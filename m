Return-Path: <linux-kernel+bounces-234174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBAF91C349
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FC71F23FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A41C9EC6;
	Fri, 28 Jun 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lawUVLj+"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30691C9EA7;
	Fri, 28 Jun 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590838; cv=none; b=gv5NxasDpwKPPDWQY5/da1JlDWM522Se5+qJZLafpPpCmg7CgDnXRTc/cRnGLcI5kpu2pDiyI/vayqeWYFXAxLi9TQW31ZNlFEf8luBl5ZAoT8q30ViIzPUnZqjDoDCPluGmzy7MFGcOlGFQvrtdJ01AO2Y7aHP0Iq8YFC9TAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590838; c=relaxed/simple;
	bh=hfX+qJVjjcAcXiAhQztZ3+zVRGnspWsdg4Of5y5zZtg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=axIoGUDIJxvi6GiZN9RDzxoRhUvw7SpvPlUzA3TKbB6JdG9ixofFJ+P2jAZLHYU5UfaUUTd1sfsnGIuNFCGuvx3vJc6Rjczb811qvHEo5Js0fgoaxcsEX8u61h6F/rOhAnBVKbeERpu6Mv6xWuk/zEL2cmycuFrv6a1crDP9Cfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lawUVLj+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so808213e87.2;
        Fri, 28 Jun 2024 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719590835; x=1720195635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BLuQHw7XUYh7A6NXygwXg3SOfMQ/2DhzNHBqiquzFk=;
        b=lawUVLj+9aRm3Wr/GI5EofWffXwtQJFVsKQzbOiEwlrt9CmKIs07ZphEaEmZ0WhYmv
         DYnTMAOsXFO+fqLJanntzA4vb/9js9LeHF0Zwo7XaCW1jrCK01OIIPI64m5B4Le7kBQK
         J0Y3iYJzqgI2QpwliCjRZJwIH3Z8wVhjxZ4oCdmwjd6ZNoHWBwdPFjv2af+JpFiNgbO0
         Z5nij0gJaqXa+pBLbl5R9IT9ZyxSLUKwObPRMBYJmKOURyx5de8y6OfMnGuNUd7BTPWa
         ZzTSx7WnZTEDJ7b0Hu8WfSoGVgTSvNgK3VlDSaPFYITffnvtAV3mrBF8XT0PqWe/v52F
         LGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719590835; x=1720195635;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8BLuQHw7XUYh7A6NXygwXg3SOfMQ/2DhzNHBqiquzFk=;
        b=t14AAdJJnQXKBsTdsJPNq4W87WDud3dJ2qJ7ovnPi6NgtlQ7X8DtDvldy6pf0uHlFc
         OCqFKeOcN6Zgffcp7NMIpME/R80QV/Yi111Mpc1sxrzzvqk1gnEHzV+wJG1jDOjevEQF
         8mvfYodSbA2XOi93+jTEGk9kB8pO1cQbrvNxJM2+ScR40DH0I+LDMGCF+y7OFeSb694l
         fypZLUjqwhTbzB6s67waX20P4Ax0iZ/a6t4U9RSVba2lLCSpbbwPvPZQkDOM+ZCPQnG3
         uSuO2M8McG2PEXAo351dWqVjlnAmAxIedaRjjCqxTN8xErTXDIWNRy/XPIsqVnHSC75E
         /Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCWceyYYYHzsvAaNBlz56B9LVqk2WMAivxJBooatsaoiGA4pvNcTL9+G1z+8HnIXrCzvsIXcs/3MzLqNYnM/aEwTADqU6dofGkiNSQ6uNpw7dbJ3wC54pVyIQ9Cb/4jlmzeIUf4vOH9idzo=
X-Gm-Message-State: AOJu0YzIawUiHennhwE9ifW/M5JFj90qui9Lc32GeaDN5LLeF1dcpMzK
	1ucz83mDnUhh+CpuDkW3ITv22OPQ8ZV2iQKnoZhTofMUxaQ2hLLK
X-Google-Smtp-Source: AGHT+IGKtZ27jyLm/4hObT+qQKvkXECnsn/l8exN8++MKWIkS87HhKNrOpgNjyAfe/Lwii2sJwIqVw==
X-Received: by 2002:a05:6512:3105:b0:52b:b327:9c1c with SMTP id 2adb3069b0e04-52ce068042emr10387590e87.62.1719590834351;
        Fri, 28 Jun 2024 09:07:14 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097c2asm42256035e9.38.2024.06.28.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:07:13 -0700 (PDT)
Date: Fri, 28 Jun 2024 18:07:12 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Marcus Cooper <codekipper@gmail.com>, 
 =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, 
 linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <667edfb08cbf3_eca1e370ea@njaxe.notmuch>
In-Reply-To: <d614f04e-3609-48e3-bd30-9e57c69cd94d@sirena.org.uk>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <20240529140658.180966-3-matteomartelli3@gmail.com>
 <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
 <6662bf1b61bbc_2f51737023@njaxe.notmuch>
 <d614f04e-3609-48e3-bd30-9e57c69cd94d@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mark Brown wrote:
> On Fri, Jun 07, 2024 at 10:04:43AM +0200, Matteo Martelli wrote:
> > Maxime Ripard wrote:
> > > > -	/*
> > > > -	 * DAI clock polarity
> > > > -	 *
> > > > -	 * The setup for LRCK contradicts the datasheet, but under a
> > > > -	 * scope it's clear that the LRCK polarity is reversed
> > > > -	 * compared to the expected polarity on the bus.
> > > > -	 */
> > > 
> > > I think we should keep that comment somewhere.
> > 
> > I think that keeping that comment would be very misleading since the LRCLK
> > setup would not contradict the datasheet anymore [1][2].
> > 
> > Also, do you recall any details about the mentioned scope test setup? Was i2s
> > mode tested in that occasion? It would help clarify the situation.
> > 
> > Could anyone verify this patch against H3/H6 SoCs?
> 
> Any news on any of this?

Not on my side, unfortunately I cannot test the fix against H3/H6 SoCs.

Matteo Martelli

