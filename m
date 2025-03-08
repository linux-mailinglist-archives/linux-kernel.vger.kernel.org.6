Return-Path: <linux-kernel+bounces-552412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B899A579A0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED6A3AE7B8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275451A9B4D;
	Sat,  8 Mar 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1uxVrhe"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8714A0B7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427871; cv=none; b=IocY6L8zh7DC8fHKmE7KtlmHzOjNRLgdGuq2x7I9beElGzy9ugZBisGgQJayPacW5p7xkmSqt5h2Y/u/fSqj67U42QGPdaXq/kfKImSNHu44H2Nt1cqL90to/qNP9pyzBWOsjhORcwC/JLP7Nhg8LXtIhU6/mJEU9hcMbIGSGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427871; c=relaxed/simple;
	bh=Mxr2e4ZA36jMwAelu1FBD4WhMb9dC7e5AqJ+9luHgW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0bdW0MBAEruexuY1FXtUcu5ibFEyG7kN1jgcYmiWaDlxpeXDiLYL1b7DHcMahIRhVM8q5XZtZ31KoQDxDo3xJFsOgFz/NUbz8huEXH47DgW5MvrepGYDeC2Qe04DGHBtKj+R/++H5RwafDDuLDR3so8F3/1cQ2MOjKDo8vkOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1uxVrhe; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso7817371fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741427868; x=1742032668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/s83pCYTtFE8Z1A6ie6nfuX1L77r034f5y4goULBDTI=;
        b=b1uxVrheQPmfQ0sbaP2ddB9S9/Rx97OL8pn4RdLD0/v8sEWeLqnAvywTtAk2au8Eu0
         Surd5J7Pi9A+FKxvzyOREFif0xqiQsekwrJu4fajMff3tjRm5jUxL4+CJM4ql7LLf/7z
         oHcztbsSGdc1tDlZawyR3IHoGdI6o0WLFUHvtek7y+cwQDLiq+S/DbhiEmE86KxfyuqX
         A4RfqEqyFcpyNSzvo5CkNkAjHAnxaZjNgDxlsOCwr8akE6i7Elvapgag3cUWI1wzci5i
         FI0WdR1QyfvU4NCRYcwKJQnjgqCAlSnByerPHDMSNaYayqTpbHMZh4mmBK1iNEPP2tVo
         cw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741427868; x=1742032668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/s83pCYTtFE8Z1A6ie6nfuX1L77r034f5y4goULBDTI=;
        b=AOqdcQ2EJF5R+vDEcS25iEaDGYhLL00ziMQFM37iz1YamMwcg+7Wb38S/hU/kyLjG3
         n9I53gTTmarpybx2Sdvbc/hMboPzoRyvlooy75a9ic/Pq1LcYJVcr/p+PVKW6ZZe+W5X
         R4UUUbB1D8BzPvTFL/WxyDUFZ8wwZxtDIuCHcSCrkMqMWvaBq8GAjoCZOnF5KwziTz2I
         mcfnct+H/HOZyvErj2hbK0EeFHvbXfT9ilKVVnxs/EmG3uCSxRLmQL0MqiTnv4evokPE
         FxsswehxE8hzSrW3ZED8lmh2b/akCelSq1FxWKt189xrcQ33o+RJQD7ot/tJY/CkyoTR
         A8nw==
X-Forwarded-Encrypted: i=1; AJvYcCVGy7YhNCc4I2kxXrH7M7GLZvnhkk4NZLgQNTmSVT94SUkOW6+ur6WrLyqhVuiBB3dqhKiLw9DEMKDIgQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTsgBSzJXKHfvDi9Muxx3tIWV3okZdyZH4qC50owo8Y9RR8Xn
	oSlPl1bXCcD2FEivmeLla+/5tQwmtudWNJ4htsX+eywzBziH/ia/kI/RZTDswqWYgx9dJuMB+19
	nTe7s5kmH1nuz9OXoxYkX1USIBhI1DURsl072
X-Gm-Gg: ASbGncv76WK15b5Md5Xu0kB8z/mr0fFfpxk86a3PbHOb+YQvOocw2luBTTHkbmUWW/l
	8d5yTTOmDgvUKkiUH41YwsrvqSm5+U+DRyKJqA0z1IvBygExNhUPnOcIkb/TC+qE54ow+vWO6J+
	erAnB7dj6s35fzaoAHLO6jGXucIGQtoSJl1Vqg2OlbVvRY5T0mtu8xIuwaHYw=
X-Google-Smtp-Source: AGHT+IHR0EUK9ZtMt9FxyXgc0C72OSMMag1jHgF57q5U3/mz0I7z1/yui1BhF1sLPrsNF1n0thBDgR2HaFUtEwXz8zs=
X-Received: by 2002:a05:651c:30c:b0:308:f0c9:c4cf with SMTP id
 38308e7fff4ca-30bf4615a5fmr18314711fa.33.1741427867518; Sat, 08 Mar 2025
 01:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740386567.git.dvyukov@google.com> <d11d91e0c27ef78affcef06e00d1cf4cd8747fcc.1740386567.git.dvyukov@google.com>
 <Z8XTmnRo5opCojnH@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z8XTmnRo5opCojnH@gourry-fedora-PF4VCD3F>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 8 Mar 2025 10:57:36 +0100
X-Gm-Features: AQ5f1Jr7BaXYd8XIJA3qiVBZ34K8ji0ntCxfm6LP4HxXs3q8hX6wVdmM9EHhJ1M
Message-ID: <CACT4Y+aoHwF8JtsdGXjozmUXgUX=_+HqML97KqF6-fDFiD57tA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests: Fix errno checking in
 syscall_user_dispatch test
To: Gregory Price <gourry@gourry.net>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 17:06, Gregory Price <gourry@gourry.net> wrote:
>
> On Mon, Feb 24, 2025 at 09:45:26AM +0100, Dmitry Vyukov wrote:
> >       /* len != 0 */
> > -     prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
> > +     EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0));
> >       EXPECT_EQ(EINVAL, errno);
>
> This patch should probably just be pulled ahead of everything else,
> since you change the behavior of the syscall, and now you're updating
> the test - but it will fail (since this no longer produces EINVAL).
>
> This patch should probably just be entirely separate, maybe even in
> stable?

Should I do something for this (what)? Or maintainers can pull it?
What tree should pull it?

