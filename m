Return-Path: <linux-kernel+bounces-354869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8C9943C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F214228AF64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA38176FA7;
	Tue,  8 Oct 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjoafCjZ"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE218C34C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378685; cv=none; b=JKPwc21VfTXq/qa3gxZozgGjDhuZY7ftepTMTQARjVrP98Y+QXn0LSFVT+cavVtt1EqmvcmoWrPMPWuyeCHNNN6pyQvQSu/vBoxfolb0VHuBZ8T65oVvweIc2DG2eWFXj85T918zVYPVGDOaGUXHr9DwzOCPPk4jhige3xE2W5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378685; c=relaxed/simple;
	bh=84HK2DYs4iHZXfWaS/6Hpz++BkQ+086CSJY0qyJZqCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emlOf7Foj+O01/KSYaKOec7lsN3UorBbFJfltzb6ThFFwoCdUYZcKs8vtbkDGiELSJ1muST9qHXZhNWPumEqWzYXgBsB4RPGNSllCbSgTYF4uIbHYGO9MrOjC3K3lltELPxIT/KVdLwGKGiqGd5y8kspQWlwLFvok/WMBO+FBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BjoafCjZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28eaf56ffcso734357276.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728378683; x=1728983483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OAC1fc0GGzeGQymFrjhdhUKIp7jN5760ULqXJcDJVQ8=;
        b=BjoafCjZWwFflHxwDM0+H3PE47kbBqTGl/zl2bgdgsHY/e1DgUYrfzWlgn5JSJ9N3Y
         oLASziHYjIgsx2Oj2Ojod1xkVoY4QEmwD895UybnlNhURZCjYjV90mke1lIJhc/AgayI
         nQl+OVXdwoCQPHRFm4W2dLmzs9Jf+7lEJs0TkNu7BYLyV/M8suVejbzMjQXy06ti//sZ
         N2p4ETvKeA4KZZt/5rt651FoDo/MR7RTsyl02ruHaH1BL192OkCRlqm1yKpqmYD0ZVg/
         FX4+X+YFcDl0Ipxf2uO9KMOtm/9wF4b26ByerHEFmsg9HJp7VGz6casdQSJesHNCFD6M
         Pc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378683; x=1728983483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAC1fc0GGzeGQymFrjhdhUKIp7jN5760ULqXJcDJVQ8=;
        b=cacLw/3gFBNOfcmKKP5NXZJV4FpFKvBkUmtCPWgD8cCmInCIijOFZ/PHgeoObumm71
         cVEn1diu5mH7hj5a5uxOy15QdugP+LVEfIkCXlYh/OyAP6v7gfW5s8OCzu+ZAlr53cFN
         NbCgLoPxZUBhnW86tkdlCyMLuSDpWpYtg9H3X/gIZfBk5/Id2JeFFMP6UMczGHqbgjOm
         UqLHoed6ehG+3PfWMKhFO8SyZZclUp3ULiZ73CGo3v9kn1ABoVx2spc1edRxeSCsYsQc
         rEZu+jO1PzM5w9FhY3TttUKAxxwcm99w8Uhjn29ivqw7UTm52jG6UaaM301VV5kTvlgy
         R1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsPiPLamW4x5ED4duTJXwRR0Kxvm79Wdb/othtHjdgYG/Cy2Gqfp4FHBbq3BH4Bt1WxZZjtthVVzn90ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxufuWv2WMUA9jsc4p35GRcXnkE5YrI5OWrE6NpYvYAablTsfik
	1n6j1F51Qktg3bdzqxkuj3WLwnX4MDvNvu+9pGnL0J/hnT5oTEzJuMG3l7dGhhorxJ9q9qTaxQJ
	RCXdPb+Ny+X0bE87S/bTFZ6GlIOsTnUgH0Gp17A==
X-Google-Smtp-Source: AGHT+IHGsrKT01WcmDgyC7IYp0pZMB5k4X7yPX1YU+KNNnvYVWtze3O6NpuAFLLQ3kwmCNNi4szI2T/fCfZNHwwlnFI=
X-Received: by 2002:a05:6902:1003:b0:e28:7a13:747b with SMTP id
 3f1490d57ef6-e28936ea449mr9780326276.27.1728378682910; Tue, 08 Oct 2024
 02:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002221306.4403-1-ansuelsmth@gmail.com> <172833255295.162249.16483920948700467749.b4-ty@kernel.dk>
In-Reply-To: <172833255295.162249.16483920948700467749.b4-ty@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 11:10:46 +0200
Message-ID: <CAPDyKFoueMwVfN+P+tG7zT+-iUs=hghsRu+i9mNiHGw_9tcwBw@mail.gmail.com>
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

On Mon, 7 Oct 2024 at 22:22, Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Thu, 03 Oct 2024 00:11:40 +0200, Christian Marangi wrote:
> > this is an initial proposal to complete support for manually defining
> > partition table.
> >
> > Some background on this. Many OEM on embedded device (modem, router...)
> > are starting to migrate from NOR/NAND flash to eMMC. The reason for this
> > is that OEM are starting to require more and more space for the firmware
> > and price difference is becoming so little that using eMMC is only benefits
> > and no cons.
> >
> > [...]
>
> Applied, thanks!
>
> [1/6] block: add support for defining read-only partitions
>       commit: 03cb793b26834ddca170ba87057c8f883772dd45
> [2/6] docs: block: Document support for read-only partition in cmdline part
>       commit: 62adb971e515d1bb0e9e555f3dd1d5dc948cf6a1
> [3/6] block: introduce add_disk_fwnode()
>       commit: e5f587242b6072ffab4f4a084a459a59f3035873
> [4/6] mmc: block: attach partitions fwnode if found in mmc-card
>       commit: 45ff6c340ddfc2dade74d5b7a8962c778ab7042c
> [5/6] block: add support for partition table defined in OF
>       commit: 884555b557e5e6d41c866e2cd8d7b32f50ec974b
> [6/6] dt-bindings: mmc: Document support for partition table in mmc-card
>       commit: 06f39701d0666d89dd3c86ff0b163c7139b7ba2d
>

I think we may need another merging strategy for this as I quite big
changes in the pipe for the mmc block device this cycle.

Would it be possible for you to drop the mmc patches and instead share
an immutable branch with the block changes that I can pull in, so I
can take the mmc changes?

Kind regards
Uffe

