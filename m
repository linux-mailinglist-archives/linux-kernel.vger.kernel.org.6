Return-Path: <linux-kernel+bounces-530581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88717A4354E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F84178778
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE365136341;
	Tue, 25 Feb 2025 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ATVTdfAo"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B425D54D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465007; cv=none; b=gGxP9cs43aRhEiqLhzXMo5enDtOPkvLXOhQZFQ9LCUfyL3mORTvq7dyAArt7UN+eIVe31cn1I5F9T6hcjjtPSr///ckmR5JBwNMDmxifU5vpI81oHN9msXA1qakP3JR7grjY/OzXhyXUNRVmbQQ9owObTkgQLMScqpmcItovBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465007; c=relaxed/simple;
	bh=RYfyD32sRASx29xi497H3XJdDF3XXVn40eOIf2rnFm0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=i2CSn7IoaqRkZs6NgXB30D1fTDv9nFt6aytQCVdP40jTtnrOy5Xrnaxv369CXzPQFi7iNbaR6SsFZYs9Du7c/oA7BTxbN2G27he5fMRCjVGtjZsuHKf0fEPWOPSj+ZdnG/qU7Jnb1kPUIqDEksKvawW6o1tH0s38E7lrZOM5SC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ATVTdfAo; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f417de5e25so2366363b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740465004; x=1741069804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+mBAQq6Mkez/2/DMWHStf85qnBYyGFLVJqfvqnbkxk=;
        b=ATVTdfAoZ8/xxq1ZmnjF7OLKA0Xgvb7CoBQQ87W4nCqYvgoKGF1WfWw7itwOEF/kQ2
         qSEC712GTgta39biH0N9ptdUCZON99uEGDNtQAHraF5yqKkiQif0P3PLLx4dOpd02hU3
         w51m7o1mLP/kdvlplhEAUBZB0iorvyx/M6eRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740465004; x=1741069804;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+mBAQq6Mkez/2/DMWHStf85qnBYyGFLVJqfvqnbkxk=;
        b=tZC8L1BifpVzU6BieSQPcfKvZ5zbGpFf6EwEKfrBCRar83QDmH90cz/rKw/nie3x1b
         sRbeiSujIsWoJM4g6ThBrzxYHEkfu7bElr67AwCDyQuW1r/gEGaydOLmm23aTwvsPL/O
         PW53b4fuEIDNo0SBpig4OZEAnay12bP1htaImqxenPo7otq7ypBJfyxj3+vT79AJ8RlD
         viWxM0Cf5GWhElcXn2RfgquLNEfNG1wmfNa6b9DeeofrHAcYaOHT0CJbj//+rUC/Bfua
         OTuQwu0RuwUOT1qlO+NefENnsuFx8dCCB3IQ5K+6iHeMe3HNIKm8DECLraI19LWMsnpr
         LJVg==
X-Forwarded-Encrypted: i=1; AJvYcCVBkmnI0AIhEYOKNI9LR1GyRFtV3I6agMr380QrM/Rdy+aikWjOmtGnZzwrEJDmU8SoulM82tQfGz06Rho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypku0IMbUAsOouXiayVOCH4OWhOnemosowlh5USP5+xiglQCpS
	0bivkmnhm3rNOWAlLNbb85l03Cb4cK7qDCM/GdpD8dwaC1/cyESc+Xr+akSP+g==
X-Gm-Gg: ASbGncuM66K90OXmIRG14/fgll9cEwKRbwMOHcsfYtxI+kRxL+q0R2IrboIH6PX9nfu
	9pQJ2+SYJytS4fcfTT+XVJWqMOYcbdwM4Wnsle3ErBnnExJxcg2TSMHyuwp5kdn+R56NhDFzrp+
	qTufp9XKPXZ5LhdhNhytjTMl4kMGGtbm2cA2h8GMlMDBkjzoAIfWITC01E8ShMGnvft/IneIqrM
	OLvKywzmqHBJ9NL+uML0Neh9Xupp+Dh0bur7SYnXIYMcEcoTF006ohH71nLF1AQM09M8UWBkHN3
	TUe0B9qrkyGHMTOqozV08hjfaUyj7UTW7aqhR9/64Ka5+RjAdCamlPjLtjTuRq9E
X-Google-Smtp-Source: AGHT+IFdXMbhGx7fP9GFKGlpguOITWaZZGOBzMRAt9OnDAJpr0Tf6LoZNYE9WcUj4WMJOinaxdWK7Q==
X-Received: by 2002:a05:6808:3c8f:b0:3f3:e8e7:2001 with SMTP id 5614622812f47-3f424777eb0mr12305946b6e.26.1740465004283;
        Mon, 24 Feb 2025 22:30:04 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f541bd992bsm190300b6e.16.2025.02.24.22.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 22:30:03 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>, <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dmitry.torokhov@gmail.com>, <mchehab@kernel.org>, <awalls@md.metrocast.net>, <hverkuil@xs4all.nl>, <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>, <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, <parthiban.veerasooran@microchip.com>, <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <yury.norov@gmail.com>, <akpm@linux-foundation.org>
CC: <hpa@zytor.com>, <alistair@popple.id.au>, <linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>, <bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, "Yu-Chun Lin" <eleanor15x@gmail.com>
Date: Tue, 25 Feb 2025 07:29:46 +0100
Message-ID: <1953bcc1790.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250223164217.2139331-12-visitorckw@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-12-visitorckw@gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH 11/17] wifi: brcm80211: Replace open-coded parity calculation with parity32()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 23, 2025 5:44:54 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Refactor parity calculations to use the standard parity32() helper.
> This change eliminates redundant implementations and improves code
> efficiency.

While the dust settles on the exact implementation from driver perspective 
looks fine to me so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> .../wireless/broadcom/brcm80211/brcmsmac/dma.c   | 16 +---------------
> 1 file changed, 1 insertion(+), 15 deletions(-)




