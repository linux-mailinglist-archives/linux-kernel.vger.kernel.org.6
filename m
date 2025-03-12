Return-Path: <linux-kernel+bounces-557412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FDA5D897
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B86175EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DDE236A6D;
	Wed, 12 Mar 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPWJn/ng"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0020C472;
	Wed, 12 Mar 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769340; cv=none; b=Bh9KnFX/+7Gj97cT0rP7ZGYRzHX/HhRyaErGHvyTKwk49jJ9cz85v+0/4rrZsKHvHALQnGfAmIW/jgq1O+kAXyIxtzjfva3+wuT0sPjdgaM2EC9CESFxrEV7PiKYNpQOsP3zUuHWu/blyDR3BIjuLt1o2pRejGTNjNjB/tJBw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769340; c=relaxed/simple;
	bh=c2D6VWs4Ydn9R+JkX15pZ2pZJ1px83izD/loo3WF4F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt1Gh/itbzdQ+Xtqamw9Kq+D33KXXrO3lOwK0IftHM9bZ0O3AzFh8g6bNOs2AUScoVGcDj/13ZvB2q/AhNjwfra1vdN6SaUtGYguoXBzfQG+AwGJu8e3xsI62+tPvpepvCUEsYwES05y33mClVi2D4D9x/Gnmjp8+8HT4fg9pSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPWJn/ng; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913d129c1aso430041f8f.0;
        Wed, 12 Mar 2025 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741769337; x=1742374137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHRas+nEhj5aMS2Gjio81zqVd9fn1LjG7e8ZVXB6Fmg=;
        b=iPWJn/ngkxJnDRte9yG4NMz3lh//0D9WbHQjtMkAEw0/jV/POYvGN8yWCen8LyeSF/
         vTcNEnliVQT+80dxbsQpH0T9B0urIqv0/8ZZHFkkvv/SFjqjSSKMaeRngPLkCqYXk98j
         YP6fXkQlR2kdSEGCQz4YcQG/XFzCwZxHeEDtjxKnLUq/98v06iodj4JDbSkDkaQl9Fq+
         HoDqfylILm0U69hoPj4r9Ra9tBdaQm/jZOJrLij4t8s2Ba9sEiD/ErYCVXPfze5ASp+2
         1yOCBUpzz6qABs2ACloeVwBcKGrYg0HiXKulF8mlp6FN3xde97x+jjoSaM0sJPHJTFHW
         y7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741769337; x=1742374137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHRas+nEhj5aMS2Gjio81zqVd9fn1LjG7e8ZVXB6Fmg=;
        b=czVJdx2xqAplQVQRZb3GZciifiH7I5o/IF5V/jfRHD5EWQ9ttfx0qr4e1p/Tq39wbq
         lXRYwLogEBS5IXfQMisosAhixe/1YtANH/8UYYJPFBB0Iyyx40urmFoea30tTrAY0jhS
         3SPBwDyNQNX0j4PnfuE/ClpVBafRaPYu4gSCgrvvOMihw983FvV4KRZqZspGnPy7070e
         w7yHWAIFBNwgQgsKlSdYSDQ7bADReIdh4bZEtzQ3wRqwGFT8KmUP0ZSvrSsniLcMKODD
         ZQCDxaDN0AyjsFrlVrLmAIkzARduK43C6FrAPYvpj6ijNPy7mg/7M6r+j7+zDl+DzkBy
         Qh2A==
X-Forwarded-Encrypted: i=1; AJvYcCUzqD7a4Q56xNMEUJyrf/8Nbq99kDX2PdYrYxJZm6vTtNHGB0nUEEF4xJ9oZQEydYEfYgF+zjHUty5lP2Pu@vger.kernel.org, AJvYcCVByHWWYBVssEuiiMKYDIFtAZNvXn+86KLE1CBMelrbHvrfXnkULWBOicoGzd15Opda9wjXTZV9egv0LjU=@vger.kernel.org, AJvYcCXjjp5ww0Y3K4v3MIRs87ZErahQcp2Me1Xl2Lv+ybLiW0+gYNsufBpo/WEQQU/LhU0hJcMwOQ6hwnX7@vger.kernel.org
X-Gm-Message-State: AOJu0YztXukXE8g+GoWZhoqgTmp73NFaxKtHg24CZnmJuYNAPf4QefhE
	826PgML9ehqGk7as4dOs2UNDxApnZzhPpiMKyvEv5deuPA1MhbFS
X-Gm-Gg: ASbGncssQ4lhx+e2+s7kBynqRZZ0quUQHZmmntMSdwsT8r+HJYOSQdYh/B+/gPoed6h
	+Hwu95mvhzLxZ/0aDfOM41qDAGHy9qn24mj2uJQ3l1CGNqaZDZHe4R5v2q/QrE2xjY/QIkDAgyz
	AVGtARIm8zBgEYOfi55PF0cxmXQA9aEe1bKOE0rtWceXkyHozdOQkg+2mShRaD2UdnVu/Mf7/5v
	yHjIjild+19u5WYQeysD6eNJZPIXGnqgtBPCGL4a+F8DtlXpMTIHaGOyULEZV3EDCFPmaEiZv/Q
	t5u4r+LjGtoRyAYCIDXBe0uU5s5K2ZW2ewJvpHlOLNMZvUCAwHzxs3Q+lYrSkMA3apHy4LlxrgJ
	ddHUM7xdsvJF+umD60fYc
X-Google-Smtp-Source: AGHT+IHb1l/+ovdoYoiVxksrC2rIlV+Lh8IYm3V+OIIa1/kNmVleWY5NV34qC6ByeSzXZ/7qR4AN8g==
X-Received: by 2002:a5d:64ed:0:b0:391:2e6a:30fa with SMTP id ffacd0b85a97d-39279e5180amr6470099f8f.27.1741769337242;
        Wed, 12 Mar 2025 01:48:57 -0700 (PDT)
Received: from ernest.hoecke-nb (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72ea88sm14488415e9.7.2025.03.12.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:48:56 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:48:55 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Francesco Dolcini <francesco@dolcini.it>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <3xmnitgajcyxu6qxkanzpnbp77jizx4n2r6pik2vmptitmtvla@wnh3dorv5bct>
References: <20250307135244.100443-1-francesco@dolcini.it>
 <20250307135244.100443-4-francesco@dolcini.it>
 <20250311-solid-poetic-camel-77a29b@krzk-bin>
 <20250311175931.GA3885406-robh@kernel.org>
 <faad00bf-0274-41b2-91dd-6b2d2dd59b2f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faad00bf-0274-41b2-91dd-6b2d2dd59b2f@kernel.org>

On Wed, Mar 12, 2025 at 09:39:59AM +0100, Krzysztof Kozlowski wrote:
> On 11/03/2025 18:59, Rob Herring wrote:
> > On Tue, Mar 11, 2025 at 09:42:45AM +0100, Krzysztof Kozlowski wrote:
> >> On Fri, Mar 07, 2025 at 02:52:42PM +0100, Francesco Dolcini wrote:
> >>> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> >>>
> >>> Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
> >>> functionality:
> >>> - wlf,in1l-as-dmicdat1
> >>> - wlf,in1r-as-dmicdat2
> >>>
> >>> Add a property to describe the GPIO configuration registers, that can be
> >>> used to set the four multifunction pins:
> >>> - wlf,gpio-cfg
> >>>
> >>> Add a property to describe the mic bias control registers:
> >>> - wlf,mic-cfg
> >>>
> >>> Add two properties to describe the Dynamic Range Controller (DRC),
> >>> allowing multiple named configurations where each config sets the 4 DRC
> >>> registers (R40-R43):
> >>> - wlf,drc-cfg-regs
> >>> - wlf,drc-cfg-names
> >>>
> >>> Add three properties to describe the equalizer (ReTune Mobile), allowing
> >>> multiple named configurations (associated with a samplerate) that set
> >>> the 24 (R134-R157) EQ registers:
> >>> - wlf,retune-mobile-cfg-regs
> >>> - wlf,retune-mobile-cfg-hz
> >>> - wlf,retune-mobile-cfg-rates
> > 
> > 
> >>> +             * Config registers per name, respectively:
> >>> +             * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
> >>> +             * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
> >>> +             * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
> >>> +             * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
> >>> +             * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
> >>> +             */
> >>> +            wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
> >>
> >> <number>, <number>, <number> ...
> >>
> >> unless you wanted 64-bit?
> > 
> > Why? You would need "/bits/ 16 <number>, /bits/ 16 <number>, ..."
> Uh, right.

After some investigation I realized I could use a "matrix" type instead
of an "array" for "drc-cfg-regs" and "retune-mobile-cfg-regs". In that
case, an item of the matrix is an array, and this split should be fine.

This is also how "adi,ltc2983.yaml" and "mediatek,mt76.yaml" handle
similarly long matrices. My bad for missing the matrix type.

Kind regards,
Ernest

