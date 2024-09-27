Return-Path: <linux-kernel+bounces-341341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FCE987EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F51C2233F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54D175D5C;
	Fri, 27 Sep 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGgok9I9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA415D5C1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419739; cv=none; b=cwhAXuHzXzsKvGacFHNe3lGAiS3Sx9yur0mCu0tNp5z3rW1qEe/O1afat4ctB9ZjPAoDmS9RJw5eBNHOGnQ0maKXVh21wGQVUdhG1UpjKm0473OyNF37ylbjKQzn+FUbPvWVqE13kTyTcoCFrotPVG2VqisOWVMVErUJ7HNAWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419739; c=relaxed/simple;
	bh=HbVB23OZTP5tfOpmp3K0L/PYgaXn9XT3U9puUNCFz2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuR5MfAdGQAlml3/XnVeXqmOXMCuPU7CP+PfVql/XeGNLwLX/FGw7tDnZPjEdynbolgEBb4u67u3OSuBWjsD9FUllD40RCb+psNEDzm/trpTimf5GDyp03l+vKcyV3oVWOOcOGN4uFjc97ip0at7OoHx0ZQgAn43iQEAQIguoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGgok9I9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cd26c6dd1so1103683f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727419736; x=1728024536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsWU+c9ooO36ZzyqvovuRAA2PZcmtpE3oZMgAJ7nS1k=;
        b=cGgok9I9zJoLF2xMhzRRArHHeCgRNZXPzlVYpByVxW8WpQSHjZjVDJrNq/oSmao8cP
         5vW17FjvWd8hDWtk3RIC0vR6CMUP7Bf8yNzE0zYvJQtcG7ZoPurQn/HQWp64NtcXrWv9
         U4Wub5WdBNPWOfDxsuQbMlV6EVCxP/Z38DzOZJayrK4j/ebDV/NS8zB7IoRcS5xdl5aG
         lLwQIoCik29hJCIeGaq29Jq/UvloI/ZuO6ig0Df4KSGuMy/EvTMjxvagDInw6+TuNMv2
         mYEzEIcHdYjKIegTB6jFXuDyOKo2XQ+c1H+NWPR3MX9mVQ8Ti+4pap+jBPH40mtktpgS
         dv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727419736; x=1728024536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsWU+c9ooO36ZzyqvovuRAA2PZcmtpE3oZMgAJ7nS1k=;
        b=B8Y7KMAIIxicY18gxqLhrr+9Dr1OxNkuA6SuM/LJlj1TQf+kHz12AJ9XSgcCSrP/UC
         Fkt6EX2yHA9NAFpZxZ0qZ1tH9tz0c297WLJLjzxwvsAwSqg+DZuj9MHQmMa9jFE2CTWs
         u05HcHelZEFTCYiYMBH+H2PV/zziVGYWmwlvy/RzR35awyxkDdnz0z8gifnImmdNS1nK
         v9zUEI6GzxZpciNXC+5Uc78UfKJEo2rjA+9IXww/Wh+1Kd32J3Tju0+pvaARvkVj/YSV
         GVGFxlbky7zfIWYtQKKQMSO9HIXVcUbt7sG6T1eJVfGET+jKVtLmv2XbYeevAT/qALfL
         c3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXazZUWtO1YvKXdAf174TvhZX4NOWnoA7Q9jPvmr3t8GaMERDvGY6TtKiZxtwas2VjIjmcdAUzteQq6lNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVixjF4UxOhONiiFGSFCJWwZ5mbVYT6RaYZklY+pFAF/5IGMJq
	pf04PqADqA4ndWkUIjJrq2WjrGO3rlv7wjdamPjXv4LKK3V2HwaVOXY4ZnYcv8gU3iMSdbXbn1V
	+NKU+uKCvj2u/olkl+15oJMp052f/vugX3u3J
X-Google-Smtp-Source: AGHT+IE9wHdywVYcSJ0MhGBl1AGz6FW7pkwWHnpBoOpmqXayWnThfJyUMjbypeLgEyzcg3Wms3RNiMxi4qpc97lqV5U=
X-Received: by 2002:adf:8b1b:0:b0:374:ba2b:4d1c with SMTP id
 ffacd0b85a97d-37cd5aa684emr1665481f8f.31.1727419736162; Thu, 26 Sep 2024
 23:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com> <20240926220821.GP3550746@ZenIV>
In-Reply-To: <20240926220821.GP3550746@ZenIV>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 08:48:41 +0200
Message-ID: <CAH5fLggMgmg-3AH1JcA6hrNLvEoM8f8a=c99v7gSa+4q3diWjA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:08=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Thu, Sep 26, 2024 at 02:58:56PM +0000, Alice Ryhl wrote:
> > Add accessors for the file position. Most of the time, you should not
> > use these methods directly, and you should instead use a guard for the
> > file position to prove that you hold the fpos lock. However, under
> > limited circumstances, files are allowed to choose a different locking
> > strategy for their file position. These accessors can be used to handle
> > that case.
> >
> > For now, these accessors are the only way to access the file position
> > within the llseek and read_iter callbacks.
>
> You really should not do that within ->read_iter().  If your method
> does that, it has the wrong signature.
>
> If nothing else, it should be usable for preadv(2), so what file position
> are you talking about?

Sorry, you are right. In read_iter we can access the file position via
the kiocb. It only makes sense for seek.

Alice

