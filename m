Return-Path: <linux-kernel+bounces-238014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37831924221
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371BA1C2345B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED631BBBEB;
	Tue,  2 Jul 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLRJgxoB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEF1BBBD9;
	Tue,  2 Jul 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933440; cv=none; b=mv29hvOr5T4EYv5R4ZUy98gjuoekAyEKZ+HXmH09pfHRNV9kxVA/UGa/NRP2LKnhriuaAw6n+qVDSz+hNjf1rwOQhmwFhkPwkT0T0b/w0HI0lD+qvHv/DU2q6JyL9GA7vlzfgI+vlwqVDZ4qu9QdrdAhq1ZiPTAW3QA5ikiBN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933440; c=relaxed/simple;
	bh=OH+FK15Szq9dfSrBQy16ayM0LYVw6SUGzokx5M9tzy8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cUCGJ2wV74XYHsN/N6Uoov/a+3P05cCJNw8iAtgXwQHOx6dzhn/6gvWnQtT1M8JzC/767eCATNAzg+vhATj/GPAREQr5tqn1KGK3jBPSv5IlaOG3Er59Yzz1FO7eAWb3kyG060QnWiuUzVIjtUfZcQR7kYS12sak2XNsHmKM6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLRJgxoB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42567ddf099so30625175e9.3;
        Tue, 02 Jul 2024 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719933438; x=1720538238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7xByIbV2umIoygttU7Su2ntwwqoRDPa8Pnvxm3eHlc=;
        b=cLRJgxoBUqF04gG8tTO3jkNvhm85dEqu89RfUODfXSdqHhHjogLbDaBpM/xbJWHpbS
         tLY6hCAMvIqnNKtZp5rqbTtRZT5ZGVnr+5bkQHtknTrb7IDvUw1nl5khcV3EDtJ3AveG
         XuhQR4KBn0BLYLGcidNeTAAr5iAdDVwwyi2O08VM//X59hV+kLUGuNuCLHadhIw2Wkq2
         U4Zis7PlRMhIratfIO4zEgi6Ew09jOY8iK5KiDq0BE8/epSSSpvyQt47JNUu132khRMy
         ikLVRcnyR85nta2qAseEyUPTnaizTbB7VBmJ8tyvUFgaODy+hKXEIRQ+uiHVrccNu1Sp
         mZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933438; x=1720538238;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7xByIbV2umIoygttU7Su2ntwwqoRDPa8Pnvxm3eHlc=;
        b=kBsPzpmd2ryqNqQU4aNfmiKHU/ZvL8yJKSwN5mmJglkAIbkJE9bPMUGS/mZUEiItxV
         ckNORuYNY0S14A5sGfMliqL8JX9h/VtwwvjadqcTe8rh7l1e+oNhb7K5XxPyA4rOPNOz
         yR1CThRUl+Ri2xQZ99B6bR1f29UBVaMpySW95lzcXFlH5YSyb5aOniuWReBl4B9Imnfb
         XLtssRpkAnYiJAYxQLR4BEWE3pDu3Q91JzBHur5JcNyCnPf027bkQEJWkFYlpv1J7BaQ
         KedI3mdqJTMVIDS4/kHVbpPGYHfk/TL8X6zG2Dy19oNEj/emJ3jyE0EoQUIoIgNFcHB5
         rAYA==
X-Forwarded-Encrypted: i=1; AJvYcCW115FxMNUJhDTbvLbTarGvXQRirGLmnKYarfa8kA1VNNnNjeTrTSMeZGB43MD3RM9q3jD/41PdXCZTqKWDr8Ru3/CacSl9zddUllKHjzF/D435xB02mgHj3nHCsxxtTx7QTrUpLeWoopc=
X-Gm-Message-State: AOJu0YxdABf659pY1k7qcfGJrYm7cVHGGPr6LXktvTZQauO9K50ZBwMD
	h7KZlJJk5pJb1fVnvmGJM9VFea7Bat3/30W++o20ZwGzK95wvIiU
X-Google-Smtp-Source: AGHT+IGX4cMz2AKxR9UquQ5Q7gBmz158IKH0vcsGbbVsGmFToi6f21HaHfYS04B91Tgb0Y7+kQ1CNw==
X-Received: by 2002:a05:600c:3b09:b0:424:7bcf:2486 with SMTP id 5b1f17b1804b1-4257a00aadamr54017895e9.4.1719933437469;
        Tue, 02 Jul 2024 08:17:17 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b068e54sm205410225e9.25.2024.07.02.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:17:17 -0700 (PDT)
Date: Tue, 02 Jul 2024 17:17:15 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
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
Message-ID: <668419fb8ef9f_2a76d370f1@njaxe.notmuch>
In-Reply-To: <20240702-copperhead-of-unusual-intensity-7f43a8@houat>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <20240529140658.180966-3-matteomartelli3@gmail.com>
 <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
 <6662bf1b61bbc_2f51737023@njaxe.notmuch>
 <20240702-copperhead-of-unusual-intensity-7f43a8@houat>
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

Maxime Ripard wrote:
> Hi,
> 
> On Fri, Jun 07, 2024 at 10:04:43AM GMT, Matteo Martelli wrote:
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
> 
> I can't remember if I tested i2s, I think I did though. But most of the
> work was done on either TDM or DSP modes, and I remember very clearly
> that the LRCK polarity was inverted compared to what Allwinner documents.
> 
> So the doc was, at best, misleading for these formats and we should keep
> the comments.
> 
> Maxime

Thanks for the reply Maxime, would you be able to point out the Allwinner
document part that is (or was) misleading? The current datasheets (see links
[1][2]) look correct, the current driver setup for TDM and DSP modes respects
those datasheets and it's not "reversed compared to the expected polarity on
the bus" as the comment states. Also I didn't find any related errata in their
changelog. Could it be possible that during those mentioned tests you were
still referring to the datasheets of other SoCs like A10 for instance? Or maybe
that the misleading information was in another document rather than the main
datasheets? If that's the case, would you still think that the comment should be
kept as it is?

[1]: https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.2.pdf
section 8.6.7.2
[2]: https://linux-sunxi.org/images/4/46/Allwinner_H6_V200_User_Manual_V1.1.pdf
section 7.2.5.2

Thanks,
Matteo

