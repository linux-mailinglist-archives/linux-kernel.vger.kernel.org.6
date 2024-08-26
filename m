Return-Path: <linux-kernel+bounces-302331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EE95FCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97CECB21D14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600419D095;
	Mon, 26 Aug 2024 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlGOFiIe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14919CD12
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710861; cv=none; b=PTWYfnozdjwBhYlxc6arggUU6pBCP7P65a/Cj2k10HCQNCk5xeIQ0iTbatGL7baLbDyRSdYt3HPCiheAwtNB4jjYhZgUjEHFFEbouPZEv3JRw+NvdfjMjpGGDDdrifwdbgyeHalyE6K8TP+5LFM1SLY82rGZF8HFC3VD2qvwLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710861; c=relaxed/simple;
	bh=o5inbK5k5jJkCSFBq8jKV4/XzEa4ReX37kh9WGWKFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E05EFQCaATJzz7eRYr3PWtQ3sqji7ewmcDVk6JeM6m9qd7f7vgMLXTfr0ym4L2pouizC53kvKoUdFXAE+BwpuL3I4+aZt8n9NMrRTiV8JAHzkJkmpz3Sb4A9OSzVggEV6jhYVmNgPfDDuZ789Q2uNT47JP/OIpV2UxS+9dhmlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlGOFiIe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724710859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVnGMUXouwLWzh2JPfjWaejU7vTfrT6N/vmKgxEOM5c=;
	b=hlGOFiIeGy1bTTGS2gQ3Zvd8MjmDQNJq6USMeIZs8OG7CybL5NI7++9SatWgDuXz5FxkEF
	s2jjd4xKUTVIqhhFs7dqgpyycDv1pqpTvrm1tVx+uFNgbnFZS7/zQEfU/0yVwmmE9giySE
	Cm/VUz/QNDU5EqwZnPmZK8VKz69PPew=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-EGbfh6xQPk66inZH3dhDuA-1; Mon, 26 Aug 2024 18:20:48 -0400
X-MC-Unique: EGbfh6xQPk66inZH3dhDuA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6b3825748c2so95756797b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724710827; x=1725315627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVnGMUXouwLWzh2JPfjWaejU7vTfrT6N/vmKgxEOM5c=;
        b=bIXPRHN2KODRA2HEcuA18wBI+9EhFHVroJ20m/Kbk0d+Oxn6hXgr5c/TsLR52zfvy+
         ovzXfnxgpTIMqij2RUMJehJUNr0uLrmCpAIvahEwm8sbZPL5gPSFsoi55nLa8BQru2lf
         mIpHAs35g1NFkRe1LzHkJABBmYUDhnLeAErQjf5Oi/Oh6hMVqHnQhFu3cFxbBaF59HYd
         WhqBfZ+10EY2o3q+7USTo6OYQbYYO+apnWoC3TBUdkctEeHSsXV7shqymkVgE2npfhBN
         xttaJUtDBkA54jXbA2qU7W9dF4YwspW3OnaCbTVBnrgpd+3yabuZjNEI/yUE3gBm8QCF
         WTvw==
X-Forwarded-Encrypted: i=1; AJvYcCWaKTHTNByNDSZr1bv4FK2l0wtndp0iQZIWHPk8auUmE9NQnArpIPw1IYa6BNUobGqc5sp4eY19vUMLLzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52Lo1bw2K3Ixw3xWtcsxFNy7qRTCAxTgQMKfGpe8ElIkXrHVD
	Z0Kpu7QXp4Dh7kJJxDS2jhEirqf7enOW81WaSIS8rCYX17BRBXLz/K6KLe45xoEntxoN4Sbyvo9
	8AtVZD83ghRcqlKp0ukPAJRsP7+Aa2BF6ypbrZvE1AwnNnAggzUMd6uSyJGKAtw==
X-Received: by 2002:a05:690c:480a:b0:64a:4161:4f94 with SMTP id 00721157ae682-6cfb9ebbdadmr12189097b3.20.1724710827527;
        Mon, 26 Aug 2024 15:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCt7ATrJ76cUPLhlo5TYvGQOosCLkwO2wXQz1V6PkjoZ9BpjTuprffh0hZuR28QBnONhXgbQ==
X-Received: by 2002:a05:690c:480a:b0:64a:4161:4f94 with SMTP id 00721157ae682-6cfb9ebbdadmr12188837b3.20.1724710827121;
        Mon, 26 Aug 2024 15:20:27 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b007461sm16730287b3.64.2024.08.26.15.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:20:26 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:20:25 -0400
From: Eric Chanudet <echanude@redhat.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, J Keerthi <j-keerthy@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: align watchdog clocks
Message-ID: <xlmi5cm4lcnohz3glzzxqtffrbletvsos2i2l2ytr55yjnwl33@fae24t7xvzj7>
References: <20240805174330.2132717-2-echanude@redhat.com>
 <wiyw7h7hkc7u2brehi6zgxykesajtqmwwajo7tpwwvayjtcykw@w7rcmojs62vi>
 <f42f092f-2199-4cbd-8cad-96ccf4f100d0@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42f092f-2199-4cbd-8cad-96ccf4f100d0@ti.com>

On Mon, Aug 26, 2024 at 11:53:56PM GMT, Kumar, Udit wrote:
> Hello Eric
> 
> On 8/21/2024 3:31 AM, Eric Chanudet wrote:
> > On Mon, Aug 05, 2024 at 01:42:51PM GMT, Eric Chanudet wrote:
> > > ---
> > > I could not get the watchdog to do more than reporting 0x32 in
> > > RTIWDSTATUS. Setting RTIWWDRXCTRL[0:3] to generate a reset instead of an
> > > interrupt (0x5) didn't trigger a reset either when the window expired.
> > Re-testing using u-boot from the BSP (2023.04) has the board reset as
> > expected when the watchdog expires and WDIOC_GETTIMELEFT report the time
> > left coherently with this patch until that happens.
> > 
> > I initially had a u-boot with a DT lacking:
> > 	"mcu_esm: esm@40800000"
> > and I could reproduce the board not resetting by commenting in its
> > description:
> > 	"ti,esm-pins = <95>;"
> > 
> > I don't understand why that is on the other hand. The TRM says ESM0
> > ERR_O drives the SOC_SAFETY_ERRORn pin, which goes to the PMIC GPIO3 on
> > the schematic _and_ to MCU_ESM0 as an error input event. The tps6594-esm
> > module is probing successfully and it sets both ESM_SOC_EN|ESM_SOC_ENDRV
> > and ESM_SOC_START, so I would expect the PMIC to reset the board without
> > MCU_ESM0 being described or configured by u-boot.
> 
> AFAIK, Keerthy correct me. GPIO-7 of PMIC should reset the boards.

That is what I'm seeing too, MCU_ESM0 is able to reset the board.

> If you see figure 5-27 of TRM then SOC_SAFETY_ERRORn goes to GPIO-3 of
> PMIC (schematic)
> 
> Same time this is cascaded to MCU-ESM and WKUP-ESM to generate
> MCU_SAFETY_ERRORn (from Wkup_ESM)
> 
> and MCU_SAFETY_ERRORn is connected to GPIO-7.

Agreed (Figure 5-25, in TRM "SPRUJ52" for J784S4).

> Unlike other device J721E (for reference)
> 
> SOC_SAFETY_ERRORn is generated by Main ESM and MCU_SAFETY_ERRORn can be
> generated by WKUP_ESM and main_ESM.
> 
> Please look at schematic of J721E SOM [0], both SOC_SAFETY_ERRZ and
> MCU_SAFETY_ERRZ both are connected to GPIO-7 of PMIC.
> 
> So on this device and board, only main ESM configuration is working for us.
> 
> [0] https://www.ti.com/tool/J721EXSOMXEVM#tech-docs

Sure, but I am using J784S4[1] and the schematic of that board
(PROC141E4(001)_SCH) shows SOC_SAFETY_ERRZ going to PMIC GPIO3.

So when u-boot _does not_ configure MCU_ESM0 chaining through pin95, I
would still expect the board to reboot, because ESM0 raised
SOC_SAFETY_ERRORn on TPS6594 GPIO3 which should reset the board. Yet
that does not seem to happen.

[1] https://www.ti.com/tool/J784S4XEVM#tech-docs

On Mon, Aug 26, 2024 at 11:48:34AM GMT, Andrew Halaney wrote:
> rti0 ---> ESM0 pin 688 --SOC_SAFETY_ERRORn--> TPS6594 GPIO3
> 				|
> 				|
> 				--> MCU_ESM0 pin 95 --> WKUP_ESM0 pin 63 --MCU_SAFETY_ERRORn--> TPS6584 GPIO7

Using Andrew's drawing as it matches my understanding as well. So the
PMIC should reset the board even if MCU_ESM0 isn't configured with pin95
to chain SOC_SAFETY_ERRORn.

Am I misunderstanding this?

As well, since it is mentioned in Andrew's reply:

On Mon, Aug 26, 2024 at 11:48:34AM GMT, Andrew Halaney wrote:
> did you ensure that ESM0 was programmed in this test? Right now if
> you're using upstream u-boot and upstream linux, nobody seems to be
> configured by default to do that

I am using the BSP u-boot (2023.04-f9b966c674) for this test, which has
CONFIG_ESM_K3=y and esm@700000's description with pin688.

Best,

-- 
Eric Chanudet


