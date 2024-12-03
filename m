Return-Path: <linux-kernel+bounces-430244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64EE9E2E72
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274AA283369
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50D207A0F;
	Tue,  3 Dec 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkEcctv/"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D511FBEA7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262746; cv=none; b=ROxn0aKugt/sFZap9CIS0LFbQ1XN6h3vVDNp255VHmz37u+nyA3PlPPN6NCadw6OAyCJ0T1LFd/zwlp0GxZtV32ILMiDSx0E/WPvizQWJEUKPotZcILwqLpuWdSUi6WazKLnJXMvVrZZNZVRpuSlnBMniQvrCN6H+2aoCqv7y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262746; c=relaxed/simple;
	bh=JFnTyIRsPpqY5AsaHUp4L48z7m2klcMtXpHcgHvP+9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6nkcrKYfvPID7GLC2U07q0TVcp6u6dADTmnkrb0urHC9Wfu1IE4lQFv+5Qk+a8xrWl2UL+Sa12WteH2MK6iXtVTIQ+xwtHm0P/M1qQN/UT/zxUJ3b5rtnJqz+7frNiaGnO5yQa+1oOjSgsftgTxKlJbtxJhdBo5p/QmBJJ9TAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkEcctv/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso572640a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733262744; x=1733867544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFnTyIRsPpqY5AsaHUp4L48z7m2klcMtXpHcgHvP+9w=;
        b=dkEcctv/R/v+2bqMG8UBzkXWEIqjEHejJV57qAbTQBaQjcsdYXk4RJLR49e6OIsC8i
         Ib636lTEp/XeiHvmQn8O6R1EPuTJHFq/FjqjUA+Ipu+Y7MC7mIdNQDHL/l2IqchY922t
         GSGs/mTmBNtBe3aZvgIh2nemhdNbCzClw6id6neGRnwn33VvrHlRF125nvqOZZL76O6P
         Xe+67ggoq88YC2er01Ca5qF1nxjbVJh9xQYA4VkVxh6bpUZ6LUu3qKy2Yj7gOWFeQvA6
         9yC8CeDxhiPEJH+4IEPqkAohxfFWESRRP9nI7SNaoNWP0xXyyk4pqk7fqH5UVnkDfW2W
         JVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262744; x=1733867544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFnTyIRsPpqY5AsaHUp4L48z7m2klcMtXpHcgHvP+9w=;
        b=kuI5tpiFaVHGocqzIYZJIbKYoCXcQ9jjMr8OLNZjSzA0kZQt3FkULbWxl9cgjK9MVr
         JAO2dhqnAouAX8imBFFlajUlfV+5h23W8SvGx7/+MnQszDDIdmCTFwamtxyI8CWxxaP0
         /7QvLYF1Fz3sdEkXhnz5L86bAKOS63NARgDtL+yHkwEv+JIYctdMYVBcnBFVHYrnijU2
         pmlXKvi6GRbpf65jPSAlhBd2zyxum5Ah/221bcRDk1Nx93+BUIXT5dP8WRqsjbi2eBbh
         gK2ukCRhqT5Jyo1aWblMzx9Ag0mElqskowP9//iTvz22EDV5XlaOUGWlVqa2yejQeCnd
         N+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN2T0I0cCsatLcUR46ub2YEAEQaJSUoyyO0kpxCQGhac425DV/0Bmq25B6xiNBuDAkvDFR5Dq3ukl2/h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fKPoReD/rStnxZujcZO85IHHQAFWvVPsS0we7MYrEA5izKIZ
	YiO/A2HPXpk7JZbxuonBpjtv0eSc5TEU6E935R46Icea9FnN4cTbuDQLoXTOoAqW1u0HcxAxtSq
	u9P2BpaHo0W48aYFCFVK8O1TiQvc+nktP
X-Gm-Gg: ASbGncvJ2UWi2hQDt4Ka3q6354N8fA5/6EuXEGrsr5LwGTt38BpC2KoqtmevbetKFLc
	UnlSvsiecvUWIOsv1eKGKh90o+kv7QII=
X-Google-Smtp-Source: AGHT+IHqmX81dM5YXkrjxZwhEES+8t9hmi/pVu2J0d9jk4qhifvDXN6Y1xWXKGbFFHdP5HO9p1WuZwk5sntpyJEj8Pw=
X-Received: by 2002:a17:90b:1b52:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2ef01018121mr2264183a91.0.1733262744530; Tue, 03 Dec 2024
 13:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119182442.GA416521@thelio-3990X>
In-Reply-To: <20241119182442.GA416521@thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Dec 2024 22:52:12 +0100
Message-ID: <CANiq72kJUx9rgA0Ex9_5ny4ss3sG5pSo_OSY=acR_Bg5jzHLVA@mail.gmail.com>
Subject: Re: Prebuilt LLVM 19.1.4 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, conor@kernel.org, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:24=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> I have built and uploaded LLVM 19.1.4 to
> https://mirrors.edge.kernel.org/pub/tools/llvm/.
>
> If there are any issues found, please let us know via email or
> https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
> opportunity to get them fixed in main and backported before the 19.x
> series is no longer supported.

Sorry for the late reply, I saw 19.1.5 getting released and I noticed
I didn't reply to this one: works for Rust -- thanks, as usual! :)

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

