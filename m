Return-Path: <linux-kernel+bounces-316692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ACA96D2CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70391F22D96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788CF198845;
	Thu,  5 Sep 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZW8XJB6p"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE51974FE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527289; cv=none; b=Y6krpRpj94xUZuhduWkMWsm2td9bt9WllqbUrheEuDKI8dvKm/kco11/gep1MwLuc3JAsldwbd1kbXdGsvXtwzlesUZo/bQf9wylNJzsaXW/Ibof91pqzQh+EgN7od21j9k3DP6NH2wDlAi7hzykniEJk0aezsjGjHIZ1LSzBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527289; c=relaxed/simple;
	bh=9OHhFdyeUuxGso32AGyuLsqZ0KCAvjZGLdyo6dtTv48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABgUGSKdhQ52Rl2/OuFOtL2A5I0NtE3UCQMtThblA8h8PFY4NSxz2IT9r2QqUh43NG/XeAYrI73NCGR5DcCcFj4jgSuUOzc4TTvbFWbce0uzRskbFXCqMMiTll/Emq3b4ET6WT4xgj8XJnRGM/Dl6SDDlL8c1x44WjzIe7NCMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZW8XJB6p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so327392f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725527286; x=1726132086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0V/vryDLVoKJDR+DMfjG1Za8gdq5E2+nzY5C8NyhPs=;
        b=ZW8XJB6pCJA/9pAsaeUV4dJT/YEN+w4QsEUgAQzHZAK1IoLroO1/A+2vsz/rEvXKW1
         BaVP1GdOIgr7U92qq3mKyDHVVOR1eGrvvo9EXUnWZgrhVn/+SOhwA1gMajxMyW+ltb/3
         ygFtJ+kWtVcSSDmAD6VbBPcYlSRUNrJIVcjk+VSwpZiwKpU0mAjojZkzC7upLtmFLLb8
         dtsSbG0shIykVwHSTvhVaD3yO9lNFG74LKSYsORTBH0WJla/7HSxVgWxqD80V5dSXpUY
         BqhdQu28SRVj76rGEET7MCDKEsTO5q9FniDvEiZcPN+7I7LSbzjUlgkZa4EaEfuePF4x
         85Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527286; x=1726132086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0V/vryDLVoKJDR+DMfjG1Za8gdq5E2+nzY5C8NyhPs=;
        b=Ojl04szWvNiWNh/3MZldj7MtgvMOgvYXJ+olh4fbLPMWaDQLFQG126roI5uQXDyf8I
         fJVUC4aUX1Zbrq/58t1nkFySPrwe63SXjlwkZz0mA+s7nxlXrmt5bZrBljc8mxGgOt3j
         9pQtuCpHpSf9AE399OKUQ5m47OK9Pbasnh/fqbDPELewq0p6JvrF7LkThfjtosLXckI1
         ekHPEuRn3FrW/ggI6Yasl/gyZNll3Syzp+fXg9KT3RUsWPcHcMPWGxslMBuXSc3n0WsR
         gNULri1dIOX5eB8TXh9OWUGNcTZr2OJityxYSTkYaILBDbJ5kSEsPxGQCXWwhd7sP2Lj
         PiZg==
X-Forwarded-Encrypted: i=1; AJvYcCVgISgLNEIorwHWP/JDnCtIrLG9Bifgk+MKeKyBrxu2PRkT3Ee0SbviVxDpc5U3xA4sdGu+lhcsrXtGExY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mzVAnTyBaRCPxIn2OAyMYoifdlDd3204Ej15+fu2ETTNS9e5
	XTqDz5wX81Pz6nMgrYEkBwd48GG5tyCzHhZ/hLWtsA+tzbjy04VW5qyMgkMTNXE=
X-Google-Smtp-Source: AGHT+IF26EDAbT1hPIDwG+ovBaGUQp9is2huyUvZIxpvsTb+KvJPqGzFKyCaVnXzZ5C6e7ZUmsEyUg==
X-Received: by 2002:a5d:648c:0:b0:374:c8e5:d568 with SMTP id ffacd0b85a97d-3776f929373mr3915656f8f.29.1725527286264;
        Thu, 05 Sep 2024 02:08:06 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c8a08dafsm11338957f8f.75.2024.09.05.02.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:08:05 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:08:04 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: ti, sci: Add property for
 partial-io-wakeup-sources
Message-ID: <sf2pklbnlkpgnkemv3wevldpj55kk2xqh4fabbmkcbh2tvnbzr@gg3gxgztq6pt>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-2-msp@baylibre.com>
 <f0f60af7-8561-433a-a027-811015fc5e16@kernel.org>
 <ti4ffymrixcpptlrn3o5bytoyc4w5oovdrzgu442ychai2fjet@wtdhrmwrozee>
 <44feed5a-95a7-4baa-b17e-514c0f50dae6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44feed5a-95a7-4baa-b17e-514c0f50dae6@kernel.org>

On Tue, Aug 06, 2024 at 10:03:00AM GMT, Krzysztof Kozlowski wrote:
> On 06/08/2024 09:11, Markus Schneider-Pargmann wrote:
> > Hi Krzysztof,
> > 
> > On Tue, Aug 06, 2024 at 08:18:01AM GMT, Krzysztof Kozlowski wrote:
> >> On 29/07/2024 10:00, Markus Schneider-Pargmann wrote:
> >>> Partial-IO is a very low power mode in which nearly everything is
> >>> powered off. Only pins of a few hardware units are kept sensitive and
> >>> are capable to wakeup the SoC. The device nodes are marked as
> >>> 'wakeup-source' but so are a lot of other device nodes as well that are
> >>> not able to do a wakeup from Partial-IO. This creates the need to
> >>> describe the device nodes that are capable of wakeup from Partial-IO.
> >>>
> >>> This patch adds a property with a list of these nodes defining which
> >>> devices can be used as wakeup sources in Partial-IO.
> >>>
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It seems my or other reviewer's previous comments were not fully
> >> addressed. Maybe the feedback got lost between the quotes, maybe you
> >> just forgot to apply it. Please go back to the previous discussion and
> >> either implement all requested changes or keep discussing them.
> >>
> >> Thank you.
> >> </form letter>
> > 
> > I tried to address your comment from last version by explaining more
> > thoroughly what the binding is for as it seemed that my previous
> > explanation wasn't really good.
> > 
> > You are suggesting to use 'wakeup-source' exclusively. Unfortunately
> > wakeup-source is a boolean property which covers two states. I have at
> > least three states I need to describe:
> > 
> >  - wakeup-source for suspend to memory and other low power modes
> >  - wakeup-source for Partial-IO
> >  - no wakeup-source
> 
> Maybe we need generic property or maybe custom TI would be fine, but in
> any case - whether device is wakeup and what sort of wakeup it is, is a
> property of the device.

To continue on this, I currently only know of this Partial-IO mode that
would require a special flag like this. So I think a custom TI property
would work. For example a bool property like

  ti,partial-io-wakeup-source;

in the device nodes for which it is relevant? This would be in addition
to the 'wakeup-source' property.

Best
Markus

> 
> > 
> > If something is a wakeup-source for Partial-IO it usually is a
> > wakeup-source for suspend to memory as well but not the other way
> > around.
> 
> I understand, makes sense. The trouble is that your driver code does not
> indicate any of this.
> 
> > 
> > This is the reason why I added a property that lists the devicenodes
> > that are capable of wakeup from Partial-IO.
> 
> This property looks purely to satisfy your driver design.
> 
> Best regards,
> Krzysztof
> 

