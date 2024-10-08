Return-Path: <linux-kernel+bounces-355408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6E9951CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EC7282A19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE01DF971;
	Tue,  8 Oct 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhzlbFAq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2331DF998
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398035; cv=none; b=C79gea77RMdRxnFZdRR2eKO92Ooez3/xL3TT5T7gX8eu/+RnArg8Sa8pJT1JlPfOFA0Y1wWMmp4usxY6KOsYukhIkzh97Jd8mfUuWB3WrJ4NGLOk8dcY63aFAJctZjU4w5tfSBvqWPDc4t7Fr6vJcGilHL20Oa4km27Vi/rncNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398035; c=relaxed/simple;
	bh=cJbvDgUha/1eoUVSaOiEuoQnBVNtsRTyLKAM+qSvSQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFmHGZRHuzs83z5Ed5zAsRdBUBIQC7tsYpsCKBcxAUhxQ1iKnlphqwrvpFYY9XJXpdxTDaGBiBAWG4ZxT5dzfLvuGCZAzArzHjLH191dMc5CiY2g0p5cbTbNMV6MkIwWW0ClFTSbOSyhuBV+yYM0yUFxYlQpwtXIa4lKMDv5tKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GhzlbFAq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5399651d21aso5214095e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398032; x=1729002832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l8UUeF5zVA7me/KDNa1uZvUuZ4ABpmFfw0rMc8MJiM4=;
        b=GhzlbFAqqtx77ra1+v8o//33rCwoJFllP1X9NohIgaVgqW3neaEHb4GF1co9xIgMGb
         MvgqDehmYJf+Urq4ShbnFZL5RiyRNBEzhTL52ptNFDgj/qkWc2oMXjjDXZjT1n9zYPQV
         1Xp0fz/FPp5XqtgGub8V5ldG+2DgD5Hnj4aRW0i/9y4H2PgqpnZNsPgi5LvLNpUOgKIO
         DrKJQQMqGFa2bGbvdYm1n3u3AbEKmBOQVhGESBiiNV11dmaOQFJdinp5TIrLswSzWdZ8
         645L6DeP+i7OwvIHg7UHNCOhsdifTcL72MmqZ/aspTzzktZ4fb/e+y254KqX1i0qWLdT
         LLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398032; x=1729002832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8UUeF5zVA7me/KDNa1uZvUuZ4ABpmFfw0rMc8MJiM4=;
        b=wVhGS76UNi/8rFHm0Rc5ul4ucOnkQrZSEtaQtzOgT0OctC8DS2B2a7NsRxWRKA4CIY
         UeRswhSv2j9A+R46WXXM5J4qCFlxyx6vM7o43COjdz550z7IRVuilqwEqJIAdKSRzGGY
         DLnHbVgPqTaEKnvCQltME+cxRvuXvvD3iTxDbBDUWeoAkicg8lqtZHviLGVM5hxDsegz
         keXQ798W1kntPpY/JHPQaDedMWowY5mRlcCVDpi3fTfnsk1aW0OP6wCdjyebh1L0psOq
         pF7y1hzT6LKfCBBaenu79zijBLBL7qyQDIFIgR0RFT7snVnuhbCy7GLp1rZ/Eb7Jb40p
         myAw==
X-Forwarded-Encrypted: i=1; AJvYcCX1X2mqSjJhzgbGBQ5pTodQcoyEeJmpc0sV7FeFKmulFLmd5wer7KWTNiiSXJ7vyowRAT952mGGOXCB6mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLW1YKiXjuF9zsAELc7tYLVKPku3p+w98lnF6qcJF04SvY8+2e
	Rj8RHRwiVHRAEMENQhk7tolfLb90znVmPLTg/wSV+Q3m0P+5dfH1Ek10cWBwgyY/dy61e7whib2
	4DmPWYUiHKXb+eynpcGfqoQZvMqH4jzyBZuonbA==
X-Google-Smtp-Source: AGHT+IGBYcpHt0lMWnVGb0Hy+ZeNqvJFr2wYYFazy0Mc7IJSh/h6XvyFgyinHLgdB/nKkTDcnov6qsaKInqYJZBkAPE=
X-Received: by 2002:a05:6512:3b85:b0:536:54df:bffc with SMTP id
 2adb3069b0e04-539ab9dc722mr7192766e87.42.1728398031871; Tue, 08 Oct 2024
 07:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002221306.4403-1-ansuelsmth@gmail.com> <172833255295.162249.16483920948700467749.b4-ty@kernel.dk>
 <CAPDyKFoueMwVfN+P+tG7zT+-iUs=hghsRu+i9mNiHGw_9tcwBw@mail.gmail.com> <fe10ee8f-1220-4a1d-a25b-efaaa314699a@kernel.dk>
In-Reply-To: <fe10ee8f-1220-4a1d-a25b-efaaa314699a@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:33:14 +0200
Message-ID: <CAPDyKFpoFP3v8XneMoY5_DEVssYkDyK03QpikBdsZseO4_MLPw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] block: partition table OF support
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Golle <daniel@makrotopia.org>, INAGAKI Hiroshi <musashino.open@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ming Lei <ming.lei@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Riyan Dhiman <riyandhiman14@gmail.com>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Jorge Ramirez-Ortiz <jorge@foundries.io>, Li Zhijian <lizhijian@fujitsu.com>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com, 
	Christoph Hellwig <hch@infradead.org>, Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 15:24, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/8/24 3:10 AM, Ulf Hansson wrote:
> > On Mon, 7 Oct 2024 at 22:22, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >>
> >> On Thu, 03 Oct 2024 00:11:40 +0200, Christian Marangi wrote:
> >>> this is an initial proposal to complete support for manually defining
> >>> partition table.
> >>>
> >>> Some background on this. Many OEM on embedded device (modem, router...)
> >>> are starting to migrate from NOR/NAND flash to eMMC. The reason for this
> >>> is that OEM are starting to require more and more space for the firmware
> >>> and price difference is becoming so little that using eMMC is only benefits
> >>> and no cons.
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [1/6] block: add support for defining read-only partitions
> >>       commit: 03cb793b26834ddca170ba87057c8f883772dd45
> >> [2/6] docs: block: Document support for read-only partition in cmdline part
> >>       commit: 62adb971e515d1bb0e9e555f3dd1d5dc948cf6a1
> >> [3/6] block: introduce add_disk_fwnode()
> >>       commit: e5f587242b6072ffab4f4a084a459a59f3035873
> >> [4/6] mmc: block: attach partitions fwnode if found in mmc-card
> >>       commit: 45ff6c340ddfc2dade74d5b7a8962c778ab7042c
> >> [5/6] block: add support for partition table defined in OF
> >>       commit: 884555b557e5e6d41c866e2cd8d7b32f50ec974b
> >> [6/6] dt-bindings: mmc: Document support for partition table in mmc-card
> >>       commit: 06f39701d0666d89dd3c86ff0b163c7139b7ba2d
> >>
> >
> > I think we may need another merging strategy for this as I quite big
> > changes in the pipe for the mmc block device this cycle.
> >
> > Would it be possible for you to drop the mmc patches and instead share
> > an immutable branch with the block changes that I can pull in, so I
> > can take the mmc changes?
>
> I mean we can, but the mmc changes in here are pretty self contained.
> I'd rather avoid rebasing the block tree for that, given how small the
> changes are. If it conflicts, should be easy enough to resolve.

Okay, let's give it a try and see how it goes.

>
> You an also just pull in the block tree now and resolve the conflict.
> There's not a whole lot in there yet outside of this series.

Let's wait and see. If we get some conflicts, you can always set a tag
to the latest of the mmc commits in your tree that I can pull instead.

Kind regards
Uffe

