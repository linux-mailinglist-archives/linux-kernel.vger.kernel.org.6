Return-Path: <linux-kernel+bounces-195167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A798D486E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4F51C2319C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C2142E6C;
	Thu, 30 May 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fKRRqK5g"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03E6F315
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061031; cv=none; b=H+mKHZ3ufgR8pVIUmUMd0fqYCc5ppbeq1Gujvx8Ot/h2e7/E8+uIa5x2sV9TfpoputHSWnlRhz7QYQxwZ+KAovdZopLMW+9lPOsMvKEVUDD7A65ORjatZlJPr+Cjx6F5LFEZqeUdIlerQ4wn8rE5hQrook9s8EvGLgYatKAKxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061031; c=relaxed/simple;
	bh=5xQNtr4KKjhLwOAxnbxqbasCaZrA8nthp+Ey9uAEedk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYNVPO3roaiFCAjvFkfP54NlX18JOeEdFZGbTvf+c1TWIM15NjoriQN7kcmKdkQ40dOooiHTHuE1Q6NvEVuqFuBy58XRNK2AH6jcS5d50gpqDf//kGdhlNAHXz12ZqEz0fZek/4ob01P98NTCh0uwy6DypKtn9SvgBeslBncP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fKRRqK5g; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b7ebb2668so506794e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717061027; x=1717665827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKTau+YU0RyTU4x5XVrkjnpY1yWlzcekDVk7dqnzHyc=;
        b=fKRRqK5gEP2K3Cy1fy93TH1ey4tWhpCW6rlpL6vC7EvtsY9XxwfqKEVNisfWKv1wkI
         8YPUtsEXEoauHZBmzh4rNPCuLsaA79LiQo2gtqiLsIkXlUfqiYmG+Hn8Ep/8GXS+badM
         gSOQmRZvC6GfaQXLwbyA5zfsE2gGrX+tYb7cLk2K4hlUU+LJnD+o/VDTpe7ht2PNM/DI
         GspPCVW0ZAGaiAtaIsc1hjLiHdXcRvARWUjXdrew91rBcEeKaF7z/kozmvR2AhcU3bhp
         7t533AiQJWKN0t5N6+VhC7DPj/DpiEBWkgHTwo0JdYX/tXBvJcZGIzfirp43pN663zvN
         Vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061027; x=1717665827;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKTau+YU0RyTU4x5XVrkjnpY1yWlzcekDVk7dqnzHyc=;
        b=misx0h0VT/quQ4NvoIyrPUfhZKygDR/yvD62ztfzRxrToHfDxIHUgHEQEFUwGM/Y4n
         PcSiRAp1se0gEHw/pAAHoHYcDrjr86xSLBOGywCY4E35bxPrnbmc4G2B3UB9LX8xsPNz
         iNT6VpsV0R9QmsEsZfmapKd3ZIsrJ/f2JtU/eCVX8YWTbYGqkZpWe3Nfl8MucTOk/DNs
         IqR9p8+6wal4azwiXCcKm18d1CX+PDxgrrxIPh3r7melysHm/sI+fUo6vUyUMPt3GmJO
         /JOMh7lMNba+9oyoCtoR+Tr+rE8odSY6myacHB8C44qyGd0BCjmDWLSBVuriZZHdCx3h
         FHNg==
X-Forwarded-Encrypted: i=1; AJvYcCVPZDkknEeajYxMFJOcuF1wn6kDg5iXyIYwfd1kJh7wR0VSNO5XC/bKVKNDImFyQofT/eKvA4fFElerH4Ks8YWmdURT2+mYoYq3WX9o
X-Gm-Message-State: AOJu0YwAl+OluoUDgURkoS8l4o+4oT8RHO+9QTfP2NjBHZr7XFi1gklL
	It6O1zfEjdqgOhkM8nUYEkcjf5oCHCArNKyTGCWAxwGRGVsN+fgdrfUzVHSqXuU=
X-Google-Smtp-Source: AGHT+IF85vUzPlq0AyAMTY+th/DjCHy1wMkF5f7oy4kB3UpvpxIDGn/E0S9HB07IbBUb/8RWP+1DDg==
X-Received: by 2002:a05:6512:3694:b0:522:373c:fb74 with SMTP id 2adb3069b0e04-52b7d4996d1mr1068441e87.52.1717061027465;
        Thu, 30 May 2024 02:23:47 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a630f25943dsm368913966b.41.2024.05.30.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:23:47 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 30 May 2024 11:24:00 +0200
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: broadcom: Add support for BCM2712
Message-ID: <ZlhFsGw7PaseT_08@apocalypse>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
References: <cover.1716899600.git.andrea.porta@suse.com>
 <8dd6997394a01317747ca11b4779f586752b4947.1716899600.git.andrea.porta@suse.com>
 <f94cf0fb-a9a2-4447-9b32-7f09c2a37cf6@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f94cf0fb-a9a2-4447-9b32-7f09c2a37cf6@gmx.net>

Hi Stefan,

On 08:11 Thu 30 May     , Stefan Wahren wrote:
[cut...] 
> > +	clocks {
> > +		/* The oscillator is the root of the clock tree. */
> > +		clk_osc: clk-osc {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-output-names = "osc";
> > +			clock-frequency = <54000000>;
> > +		};
> > +
> > +		clk_vpu: clk-vpu {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <750000000>;
> > +			clock-output-names = "vpu-clock";
> > +		};
> Is the VPU clock really fixed or is it just a workaround for minimal
> boot support?

Unfortunately I don't have enough insight on this due to lack of documentation.
I had to take it by faith from downstream dts.

Many thanks,
Andrea

