Return-Path: <linux-kernel+bounces-311284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B239968721
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69ED1F2447A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941CD1DAC52;
	Mon,  2 Sep 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DCy79wFz"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DA1DAC5E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278925; cv=none; b=Q1ZJB7I62teRcxSnaNZ0u2tfJGTaYRQeNrkKeUyMM8jQURFYmFd7TPCC3xY5W4ebpk2m1Ku8bc+Vg4C7kknaWf36z2t+OL1L09FSyd0VGmjPvYcWXY8rvRJgTS7AmKY2tvFb5b5jyYyNnkH4RmDcaOVRljPN2fq4r8iNYa5/2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278925; c=relaxed/simple;
	bh=/fmn1tpBsaiU5ZR2h6nBaQpwU2eBecY+EFs72kIYxMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds3TFavebYIln5IBoT5o9bo9hRQfetJzELkCQPfw1N8JesAwRp/R9UG6TZ5fbs9tKgpVGZecRdj8EjQekHDPhesftVoWKVTTADcDGNFw769l3LRloaY7UHjXtCo+uvV4MX8FjsxBBtvMLb5qwLOEReONHiWFnefEoWkqR056288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DCy79wFz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so47071901fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725278921; x=1725883721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fmn1tpBsaiU5ZR2h6nBaQpwU2eBecY+EFs72kIYxMo=;
        b=DCy79wFzidVjE1v72eMEDUy/33AlVZ/XbuhwgGoJZHQD3BobOZxG6KHIEFp+/sPhCm
         +IdB0SF6GtRgaNOZpmUxllF6/Sc8LMKPAK+n/g6/wH1/+pe1fnQl/10U0Zh0eXs3y5Mz
         MmUJKgx8JJAqb/wfHD0PVAPbU0XFoSDNDYC7/JW2KufaRYV7+S0TSKmh2Ug8oMh/bXv8
         L9vj32WqY/s0dpFaYHPPWWqFDA1jVXksc4Ize8o9M+vxk7flvUKW986ujiEUN07YWe9m
         MtomqR5/RTGc3njQ+B+Qt1scgfKwjvFyisjtdWW4gCHo3+XFS+AEBjXOVH7S3BJCwEat
         Z5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278921; x=1725883721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fmn1tpBsaiU5ZR2h6nBaQpwU2eBecY+EFs72kIYxMo=;
        b=DiiULRmf4iNHAZMU9r/xM3pGocif+ZYCjM4hfUdHxfSYvtUXpjIygz5zPuBe6JBmXJ
         yxeUnI63cXEzsB9nbBCmNglISpqAqAA6zMJywToQ5zqNeshjtQILP5xKQ6xNctw4AmdX
         uMi66GAt4lkovhxKmsPsjokC9Co/EhUWWZvnwecJbrDZGjlflADSKLSBgRZRimZdUJQT
         iyqhPbwKZO1LxoZmEwz5v1iQY3aFQTVKGfgerk/yOCtSjkiAFmCJiVN2q/VG20YRFxcX
         oxA5A1RHKgVO+znaTB6bvl/i5KngbMBwp3LbyvVPG5Bpesw7Vp6wWAVT/47yi0XHTEdc
         taqA==
X-Forwarded-Encrypted: i=1; AJvYcCWlK1Hj+te0+qrROKMmQGqK3OEyyaw1N5sW8oeGJh3fWp7t+xqpyqcvuOdXrp50nnBx5PqTSOk7jAa7WWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0GwcvyVMGFaFreaZ6Jv8jej2DhxTk5t2ynWqW0glWj4W2jM3
	//de9V9TUU+8T4G53OG3y18NDRCgUiGlfvnCjNQC7sCka2K2SOKO+zToQqAit27oZdOXU58tC6/
	+tYrCgBeFu/YhgfsQh3fNINqy05ZovoTfXPXeug==
X-Google-Smtp-Source: AGHT+IEwniVjpUcHNV2PgckQjJz6SBHI6ttgJLYd0oBUrlEr8cM8Ja57SNENZ/8PhY5yQ9vuQ+p9+Vh5WTkPLL6qeN4=
X-Received: by 2002:a2e:5149:0:b0:2ef:23ec:9353 with SMTP id
 38308e7fff4ca-2f6104f27a6mr75282841fa.38.1725278920963; Mon, 02 Sep 2024
 05:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828133207.493961-1-parth105105@gmail.com>
In-Reply-To: <20240828133207.493961-1-parth105105@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 14:08:30 +0200
Message-ID: <CAMRc=MdyNFzNy_GndBDOUL23Rv0WxGG8mRd5DRD28pE=XuhfmQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: fix lazy disable
To: Parth Pancholi <parth105105@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Parth Pancholi <parth.pancholi@toradex.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:32=E2=80=AFPM Parth Pancholi <parth105105@gmail.c=
om> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> On a few platforms such as TI's AM69 device, disable_irq()
> fails to keep track of the interrupts that happen between
> disable_irq() and enable_irq() and those interrupts are missed.
> Use the ->irq_unmask() and ->irq_mask() methods instead
> of ->irq_enable() and ->irq_disable() to correctly keep track of
> edges when disable_irq is called.
> This solves the issue of disable_irq() not working as expected
> on such platforms.
>
> Fixes: 23265442b02b ("ARM: davinci: irq_data conversion.")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Cc: stable@vger.kernel.org
> ---

It looks good to me but I'd like to have an Ack from Keerthy on this.

Bart

