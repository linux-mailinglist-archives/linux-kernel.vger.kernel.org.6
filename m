Return-Path: <linux-kernel+bounces-244722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CD92A879
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0775628179E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1414C58E;
	Mon,  8 Jul 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsZLcG9E"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CC14B959;
	Mon,  8 Jul 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461201; cv=none; b=VnxSzF3zDjmfaAkr2etJKYDXpQvPgAab9BCfQ+edVOa4Cn8o+mgjlcJrXjPSsMtkPtxL6znaQ66VA8YOuWYysP9GHFkSI7l/TE3rjC/E3hwB28lMoIhFwzMeb8IWzhtRys+oBXCefIZg5Y5u0e0WHW5ZcRkR7zzo7i82v3Bm7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461201; c=relaxed/simple;
	bh=iOLaAKGVBNBu76WR45/Ccdjddni/NIVquIog/WJvECg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSeFkoTCbaIH+GIG7F6Kb7SaiuW13yoM6XDchgMuENivVxm3Kt1RSDnLvpWW1TNfF2vLpPCDQrWzFGILvM7c0Vzr9h7y0eXLPjQdjOMkr65B7utqFjCqUeb4bNdZ9mgaDatHblWRTnW8dsbzO1rR3JlMW6y33xBMpNGNlUnZraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsZLcG9E; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-70b2421471aso2087933a12.0;
        Mon, 08 Jul 2024 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720461199; x=1721065999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOLaAKGVBNBu76WR45/Ccdjddni/NIVquIog/WJvECg=;
        b=VsZLcG9E+h4by1U4z7eUKRHeg/sdOMJi9121Wviuf1QDFT37WoQ1PpNoBy88y4n4rG
         Onuh/Aw/U8mjA4fb/YsaY+QOcnPcKkp1l/RXMbifAr2nh3j1zjyKrWP8gOTDEYYvKUHL
         fgD43s3mooOmSw4vYelkXgf1Hgg7RxYOu3ouXCRox1hdfkGqgTD7zctSZyibR4weWEh4
         4+pf/xav1R3yqt5SjGW4xRe+QJUSface6Ve8BSkz31rZO/qB8yKXbeRIwP2osUcFG5XA
         nP0/6z4iv2y8XRcV+YqSvVWFZbc9raxn0kXibFfscROOk53NVcgLvWp0/JBa/I65U/xy
         bRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461199; x=1721065999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOLaAKGVBNBu76WR45/Ccdjddni/NIVquIog/WJvECg=;
        b=lVLmMBSBvn8ppMdkhCmH1/tOo0ZCDqLhsjPeOzkCUrXKIdBmGwq8slkpPWvgzOP+xw
         9ISuKaW/I8V7bnvXSo7GVIRXqGGTNJ4PthELli3oWPHgcyj3rf6fuXAz+8HN9Icbdeb8
         mXbX8zEm2rMk5ZXtSG2rWbCMh/dzZ79wmF7u1msasrz93ZCBvlFr1FvkB2q5YeWCDfa4
         XjTW/hJctkAOpaRUGVtPp+MNm7Vi1AazARBeo+WxW5SfO0USUiISrduBgeXeMh/9ap5x
         pXYk/jWDb07A9u0J6WNAHV65Tn8RFABaCkCRv/liknMJwxwFXowlE85cDlp9IAomsKT/
         J3CA==
X-Forwarded-Encrypted: i=1; AJvYcCWKcqU0zZbmeGoJ4ZrGYso6Mq5/O8dQ3PvhQaBHXUcZMTWBpM8xvMYoZfsD3dZjkDF5o2Z6LRUcwLJFLcdZKj0XzwnQjvoTnaKfxU2Vp4CK0T8qUIyZmuVRqZNGrGBiHwGMlDqbQwj0+h/Dxi4=
X-Gm-Message-State: AOJu0YzvYVoKLLzBtNr+1D0G2cmC25BDJxdTHs2a4Ou3crzns0VUjl6Q
	olGRuLUZArTul45GU3AfGPFTtq2wQw9dh5Wupo5FAC0kBSMQHXZk5Niz5DbbOB/z1w89KrOYS7B
	Ai6v44CLRaYkayCO5Mjh+9Bso5Wo=
X-Google-Smtp-Source: AGHT+IFJoQ6KmD4jhTDV11xtIYGkrwe+YX4ZC/+/EhoEyO3AO52j5H4WMIhNXKER9TW+xaj44B/UR+jKC8yQ1dQRJLI=
X-Received: by 2002:a05:6a20:748d:b0:1c0:f216:7f20 with SMTP id
 adf61e73a8af0-1c2984cfa26mr129290637.49.1720461198871; Mon, 08 Jul 2024
 10:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703110624.1301830-1-wangrui@loongson.cn>
In-Reply-To: <20240703110624.1301830-1-wangrui@loongson.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jul 2024 19:52:44 +0200
Message-ID: <CANiq72m35W=8V77Rcu7MKw29EXEFq102tOL_Myyx1UvMuJYUBA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: rust: Use rustc option -Zdirect-access-external-data
To: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Xi Ruoyao <xry111@xry111.site>, Xuefeng Li <lixuefeng@loongson.cn>, loongarch@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:24=E2=80=AFPM WANG Rui <wangrui@loongson.cn> wrote=
:
>
> -Zdirect-access-external-data is a new Rust compiler option added
> in Rust 1.78, which we use to optimize the access of external data
> in the Linux kernel's Rust code. This patch modifies the Rust code
> in vmlinux to directly access externa data, using PC-REL instead of
> GOT. However, Rust code whithin modules is constrained by the PC-REL
> addressing range and is explicitly set to use an indirect method.
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

I have created a tracking issue for this in
https://github.com/rust-lang/rust/issues/127488 since there was only
the MCP, I hope that helps.

I also added it to our #2 list of unstable features -- please feel
free to ping me in the future if you add others that you will need in
the kernel, I am happy to add the entry even before you send the patch
to the kernel in order to track things (in fact, even if it is not
implemented we can still track it in the other lists).

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

