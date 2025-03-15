Return-Path: <linux-kernel+bounces-562507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159CA62A05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6105A19C0364
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640C1F462D;
	Sat, 15 Mar 2025 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5vPRFEG"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44E192B8F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742030742; cv=none; b=ol2qWeyjONQ41kSus6y2UmEQDTPDN2FQrs4WkyhUtbXOLc16FfP+KvY+tKJrsJjAjN+bP36ylIOsKqXFX9I69N/2tumvUsqSizF8U+/RV6RaXN0VJ4Yh9aTic3y11RMt75MYsmZAVI8Azsr+YWPd4oFwyeZQnkPSkWfJQfpJ48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742030742; c=relaxed/simple;
	bh=Dfh3K4wMu+TjftIVQXcnGLd4dVrH+TUf6CjqZSMRHt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB90wcpSCBOrha/roiiSpuEkwr17H7MKHen6jvpsQDvRytfxhci7QzywCGPs9NtcTAMEp4oWwE0qK/AedD9MKZ+JzO/5V44f9qL/mkRIP2oLVHQ2hgk6n5JBr5d4C+HEGm7LqV3vQFSqi5b06A8OqlNkc6RgeLeMXQHjwTmfWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5vPRFEG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30c461a45f8so20445341fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742030739; x=1742635539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z9LoeYb1QLytNLRXTx2oXDY3Gr5BI3T5kycX7NFKVA=;
        b=N5vPRFEGBtwmbgDuqcXm1F8Nj0rXJOTuzdLgusmwi5xHrYCvBFOXCIR1HrNSEkwZI+
         DqQ5NRjtdK3SSoxQpnN4xv2FHtSeRgau7IWMq4tzfsqn/G82yvhP9TnIrMcxfWSnp8Ai
         VXZ2YwWxciZfJQ5XnmtU5UdOLEGcKLN8Oq9G6Vd+BfLjZFs0rK73g5FL8V5xIbZvVu6S
         IaFvrozWy1AzEQ8IfLYA7fwH0KBU8DLyY4fFUWaogyz7axWCX5DIz4XZ2Q+yQQ/rAevT
         n9IqcnG+Wv3Q1xoFUWHIDIyQyjAYpYOmADIKf4+7aRhp9u7ykrsfvaj9AW1mEhH728vi
         Fb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742030739; x=1742635539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z9LoeYb1QLytNLRXTx2oXDY3Gr5BI3T5kycX7NFKVA=;
        b=e+8pQiN5IBMnZLe0uG9HHzb0gSB8lf+lVcqdGUc0ljIpCFXSwRvzJztWEoTPW16kG5
         EdRtUNuKY8LqeQQPehIID7xiiqZ55MdWjrtEp0Fc1RtYqWO9Cy36DS4sISQysn4xc6B5
         w/wHCxvn5KqE+KIHDYWuJ8RRCKnVyjSVR5jEV+yR50Fr0BUNRJIowG4LtaaAGG2HHN64
         9beJ0wDFcJOQ4RyfQCdkFyOUYsqOiS8zFn46KFEffCNoBRbFmk2a+NSUC6R03Uu3lngj
         hOQwQQgEeiqXCXngYgo0ADKH8zB7g+rRxwLMUklrb9EwRywhM2xUqyERFr6702LzflW2
         mZHg==
X-Forwarded-Encrypted: i=1; AJvYcCUkR5OsLkCZi99p2AtEkcADLSYJp8ZvULdbFyXVbi4QAa0PiOZP+qEGo7BnujGs49cW3VAke+7ieQczs2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9VTb1cHBErr2UKZBQTKe0egt5WLuTzKqyVBTW6GBOxJ6bUeO
	6Idqdf5KDLeQ93viYGt8OHoUgq5Mwr+FHTw75Klt0b+4zVppA0K/kMxPqH/XiWdC0pa/jyNlkRE
	2HaIaNSl8ABODDgKLdPE7gzk8zPy7cK7ICOE=
X-Gm-Gg: ASbGncuYJnovJQNnV5dsgYpSik5oIuGuRf7bhWe6ZROzvojVNwzAD8YuhgZK0iiBV8L
	QR2CnRWSQfSzzM8NnBNarGQA/GyhAA+O+So0sshLvsBnihxk/VQ33XtFDz1ThMwFpHUR9vQeCMP
	0A/bdIF6f4lWS7QA/TdZv18gwYpo+p8RVBv01d
X-Google-Smtp-Source: AGHT+IG2eM916VYChFjbguAbuHnWw5bH1PlcJGT4OXY9mMRYMclPp022ZfPYmES+LH4lf4P5RaX97sgwHgFWqgdtqm4=
X-Received: by 2002:a2e:a78a:0:b0:30b:b7c3:ea4d with SMTP id
 38308e7fff4ca-30c4a867269mr18653911fa.12.1742030739079; Sat, 15 Mar 2025
 02:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <fc92a93060fe0f17bbc9fcb2d447463fd3f9296c.1741988314.git.jpoimboe@kernel.org>
In-Reply-To: <fc92a93060fe0f17bbc9fcb2d447463fd3f9296c.1741988314.git.jpoimboe@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 15 Mar 2025 10:25:32 +0100
X-Gm-Features: AQ5f1JrkjjhSpOuhcqBvZRy7H9cB6srzbNmHjSBF0-INgTbcnl3RYk-FIxvxQPQ
Message-ID: <CAFULd4bTPEsKaeRx=issr2JScXw-gaCWbOQQap_pACEGTM-Fdw@mail.gmail.com>
Subject: Re: [PATCH 06/20] x86/asm: Remove CC_SET()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:41=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> Now that flag output operands are unconditionally supported, CC_SET() is
> just a comment.  Remove it.

Can you also replace CC_OUT with "=3D@cc"? CC_SET and CC_OUT were used
together to handle compilers without flag outputs support, and they
should die together. This change should be a simple string
replacement.

Thanks,
Uros.

