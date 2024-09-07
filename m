Return-Path: <linux-kernel+bounces-319600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D424B96FF0F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC41F22DDA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C10DDD9;
	Sat,  7 Sep 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja7P/h1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B8DDA1
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673672; cv=none; b=dPbmUJTUZ8kFDxfWP+b5v1TjBusNWIKJNCyOaeYUr/+FtZ0qI2WRwJh2FcOdYvr/OkhMT1VgD9y1Sx+tNoOeUuHQeIy/RFFh4mbEeZV5xGWlW5GStVGT0/gglU9OUCzEMKF66bpgehSTGUoOt4ti5u4hKtb3c20OJbmxW1UCOfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673672; c=relaxed/simple;
	bh=KaK41JPOiwkTi9ta791J8wS37yAgctFiFMaLNuuZ/y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1Z3w97JKBQM0oCQ0tKg01/cMifZaajPqIDnzxahk3WWRMdbulyDKnwjxV/56/GlEFWPW+FvhOuhKZgAkROH8KWBtxtkDvn4dI1teZvqIvlbmkRICbxP6xLDAmxX3KZEtekhKkuU1p7nk3+ICglR9kip5K4CeyDRIwwrSmLgecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja7P/h1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ABBC4CEC4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 01:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725673672;
	bh=KaK41JPOiwkTi9ta791J8wS37yAgctFiFMaLNuuZ/y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ja7P/h1Rik8bso2VeBsPNO38kUZ0kWeIIQcLp+37wbHG6PfM0cQJxvklf5lJXOmHw
	 K1zK90HEKY7dn9Ms3pOy/zrdxWWNJW18Kz82/vtVy2G0suYAtQ3QMGBxKdoA8QzxK8
	 1ZzvkK7u6n9zLz5pnvkNMBN2XpOyjMe7/TIvEshNaDAc1NAd5HL1VxfbWRnM9nYmL+
	 FnLRwRwdBZUxvHsJxzzG57l+RvUX8Avk1XrsDDH4EPirCwSrWmpKTvsshwT1aW4PCk
	 8qs9bYkZuREQYydjqWbGxGjM0mMZT24j71lcxPGzn5urSLpG+/cnSCEc9FxjOTU69C
	 +Ija1Qd0zJCzQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso1306041fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 18:47:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULQtxKZXXL82G4UIPZYo52FdKHoeKSD3kW/soSjk9MnPsZBdH54lya9XTUTzdVABDehsP4WfgMsnhOyC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVV0ZnPICtnpMa7WuCqkIrbnMYkIRvnJmuPJiDgW1Oytj9iJVK
	0ny5263FkHwwymKkv298zfJhXUPOfq4+6HzMZ9e9YcfRCAapiIhX2CiG7ydcvKLEl939ao9i4Gb
	YPRRaaoGQH4v7AJz0qQzfhf24FtY=
X-Google-Smtp-Source: AGHT+IEAbN9Eqzj7/94jpm3ZQGTLWu4waEvFkSByhRyNjqTPy8Lz34CNrAmcTOD6tEPOYyD0XNKDboxR4rC3W+hfagk=
X-Received: by 2002:a2e:a983:0:b0:2f6:63d1:166e with SMTP id
 38308e7fff4ca-2f751eaee26mr34366321fa.3.1725673670870; Fri, 06 Sep 2024
 18:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZtsX_tcEuOjktUl9@zx2c4.com> <84a8ee9c-7781-c474-c394-d1498dc00050@loongson.cn>
In-Reply-To: <84a8ee9c-7781-c474-c394-d1498dc00050@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 7 Sep 2024 09:47:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>
Message-ID: <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>
Subject: Re: LoongArch without CONFIG_ACPI and CONFIG_EFI
To: maobibo <maobibo@loongson.cn>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
	qemu-devel@nongnu.org, thomas@t-8ch.de, xry111@xry111.site, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jinyang He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 9:44=E2=80=AFAM maobibo <maobibo@loongson.cn> wrote:
>
> Add huacai who is maintainer of Loongarch Linux kernel.
>
> On 2024/9/6 =E4=B8=8B=E5=8D=8810:55, Jason A. Donenfeld wrote:
> > Hi,
> >
> > It appears that as of QEMU 9.1, it's possible to boot LoongArch machine=
s
> > that don't provide EFI or ACPI.
> >
> > Would you consider removing the `select ACPI` and `select EFI` from the
> > arch Kconfig, so that kernels built for this minimal QEMU environment
> > can be a bit leaner and quicker to build?
Very difficult, at least removing EFI is difficult. Even if booting to
a FDT environment, we still get information from EFI now.

Huacai

> >
> > Jason
> >
>

