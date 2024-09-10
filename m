Return-Path: <linux-kernel+bounces-323554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE7973F42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B61F26AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925921A7043;
	Tue, 10 Sep 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV4a3vfz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D091A4F36
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988829; cv=none; b=FQJHp+YDx40D5HuEwK4Kt+4VHlsEp/lrrDGSjusCotaSXJlKIOmTTd+E0RgwJKjVfg6Qi5LMKVguVGpI31OLRia4v9HxSxtcrfYyUqXGzuj1LY3LsFOxM2JcUGEMkWjMR3dykncJqvEZfOBg5vC5WirEpUisJpyevsv5XrdTiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988829; c=relaxed/simple;
	bh=k891haVZcn7CF/MR/qFD2k0hZo7ZiXLPafAOvRbZ5eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEhxsxhjwpUpxPJAvM6e9fkG3fMtIa/RqFpjBRGlxxl1nsmOSj0ZLT2XO4I7UvOEVcLPV+RfRTmiDWz1Y3mZEC+La1LBhFFj+wCwubZEduOLKQCd9sUGF4lUxQkydxeybGwc3kIbQO3MHdKeTPBAN2BRN3kDglcxshnhtuIBYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV4a3vfz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725988826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsrrXb0hYxp5zmbUPXkc3Gp76e4Ob7oJUblbSGBMXR8=;
	b=bV4a3vfz3cX0Oz0pUwFCtZcCUcPicVhVXSlVPyKOZA0K9wxUDb7TaZcQxp38ujPdHEUA87
	mlwNRX3/hoRXeFHlDi9HM6TX6jnGLvq3rLd6bvhdZAZsXk7RXjP6mKG7KsecW6vTE3FIfh
	pjHOWhECPdlTbqCLVAqemjJ0+jkpYOc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-DGeCr0fBPd2Ic0P_pm7bxw-1; Tue, 10 Sep 2024 13:20:25 -0400
X-MC-Unique: DGeCr0fBPd2Ic0P_pm7bxw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9b6181a13so761866785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988825; x=1726593625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsrrXb0hYxp5zmbUPXkc3Gp76e4Ob7oJUblbSGBMXR8=;
        b=sclACa+kinBMWjBKXhYOo8S2GctSMvQH45K1gVNBFo1zLGwqoGmxn7w13xDYFXHPPG
         Qwcv1QNcqIknmMsMcWd7Y4VV2s+EGH8bcxYlY7IWjxnXUTFNd48uT+k4AhAzc4lac805
         x84u5tpud918WgsJh4qyFEnW2F/bLcghiq71nI9DGeqnYpMqvMxTnzK+2zADbmKPk1bP
         tz8vNrwwQerH4vhetIXWAhhmjxbbQxTjJHV58pFIFhHq2AjG/5PdZ3IJkbTX02qJKSv7
         UcG40g0AsLlxymiDXCJ539WXie7IItQHswPo/0YrkjcphizXYMIacEmWMvG+O1eQI+4f
         5/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtzb+LKMtK4r8cjUX/6EwHhEe3VadOYW+dBih/ref7V32iEYBvdvrDvnIYhrc9KSOApCBy4eFH+g37tAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxltYg6ism3YJvN1MSttvXHtdR6ppxmC9uHiCrQpJuQ0zPIdU2E
	qWun3k8sL/gsPGt48FGMgK1eG3QXAfkzSb7X66H/rRruSBriaRDRRX1bFnnSAvcjA7Jc93H+Sd9
	oFNuX6VPEutq5oqsyXDlhFWJCE4V7mDpT1sIm3GCVHfCtoby3I7QnQOv48RoP0g==
X-Received: by 2002:a05:620a:31a0:b0:7a9:c064:379a with SMTP id af79cd13be357-7a9c0643985mr669591985a.64.1725988824663;
        Tue, 10 Sep 2024 10:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8sVB82hSRZb2Cg605sM2t/TlZA5qJ8UInluJZ1KI7WGHhfTO5q3C+QksD8At4mKz4Mt7K/w==
X-Received: by 2002:a05:620a:31a0:b0:7a9:c064:379a with SMTP id af79cd13be357-7a9c0643985mr669588485a.64.1725988824254;
        Tue, 10 Sep 2024 10:20:24 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796ae09sm324260885a.49.2024.09.10.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:20:23 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:20:21 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Keerthy <j-keerthy@ti.com>, 
	Neha Malcom Francis <n-francis@ti.com>, Eric Chanudet <echanude@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH RFC/RFT 1/2] arm64: dts: ti: k3-j784s4-evm: Mark
 tps659413 and children as bootph-all
Message-ID: <4h4wm5jja4wadh6bmbouuxjvoai6cokqqgxsl4kmhurvqnd7tu@y65y5pakijpq>
References: <20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com>
 <20240906-j784s4-tps6594-bootph-v1-1-c5b58d43bf04@redhat.com>
 <bd188c0d-9fa1-4350-8787-36af319c7930@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd188c0d-9fa1-4350-8787-36af319c7930@ti.com>

On Sat, Sep 07, 2024 at 11:04:50AM GMT, Kumar, Udit wrote:
> Thanks for your patch Andrew
> 
> 
> On 9/7/2024 2:51 AM, Andrew Halaney wrote:
> > In order for the MCU domain to access this PMIC and its children in
> > u-boot SPL, the nodes need to be marked appropriately otherwise they
> > are not seen by SPL.
> > 
> > This is necessary if the MCU domain is to program the TPS6594 MCU ESM
> > state machine, which is required to wire up the watchdog in a manner
> > that will reset the board.
> > 
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > index 6695ebbcb4d0..044a428136df 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > @@ -642,6 +642,7 @@ eeprom@50 {
> >   	};
> >   	tps659413: pmic@48 {
> > +		bootph-all;
> >   		compatible = "ti,tps6594-q1";
> >   		reg = <0x48>;
> >   		system-power-controller;
> > @@ -662,7 +663,10 @@ tps659413: pmic@48 {
> >   		ldo4-supply = <&vsys_3v3>;
> >   		regulators {
> > +			bootph-all;
> > +
> >   			bucka12: buck12 {
> > +				bootph-all;
> 
> 
> Add bootph in on regulator node should be enough,
> 
> As I see SPL/u-boot does not need all nodes.

Ahhh, I finally see now, all parents of a bootph-* node get that
property. Makes sense.

Would you rather see it in the regulators node, or all of the actual
regulators (bucka12, buacka3... etc)?

The former is all that's *needed* to get the PMIC ESM probing and
programmed. The latter makes sense to me if we want to actual use the
regulators in the future in that context... Doing just *one* of the
regulators seems odd to me though, someone may want a different one,
so if we describe one to SPL we may as well describe all.

What are your thoughts?


