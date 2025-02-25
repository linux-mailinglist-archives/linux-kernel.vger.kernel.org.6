Return-Path: <linux-kernel+bounces-532119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DACA44905
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D51488007F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11219CCFC;
	Tue, 25 Feb 2025 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vFnG4Z0"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDF19993B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505629; cv=none; b=PPu8UJg8pb9yY8P3ArQE6Y6pizoc18rhFY6yNBnoZJCCjko1LsA5pFxzjZ0nt54fWxS3Z0nQkpd6vcbAVMfPvJ95SG2cdSIgNIdTaofUm/jlqNExBCrUJ0xIRDhf6U3ycrdDX4SxLhPtuefVmXEXIfbpiGAmc4uROS3qd4XzgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505629; c=relaxed/simple;
	bh=MCWMSFV6nXivXnq09n2EPqxUtKNTa60LR94dGwUmokY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL+zliAK13EWBC1y0aQgFP0L76xvZ28SRM53rD/AYRoobDB/OYKU8sr8G/NcDS3OWFDFKG9Kei7pAbiqjYrntZF4otba/M7y5x/OaU2TqvA74D8Dg5O43PBkvFI9ObxHBFmXScUwtRGKPGmeRuA+3WcafT/MzJzQ8GTMxqTHEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vFnG4Z0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22185cddbffso733825ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740505627; x=1741110427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Xd8E5UB+Vof823rP7txgr2JDe+GKD1zXqyWtuRc9C0=;
        b=1vFnG4Z0vrm9UZtdLORdft+7gzW6Bfnu2Ux8qPxCA2HXMeo7Kd1TZarlqolABXmOa8
         47CS3Rfch6q8+o1PlmFadWA0d7ueoQqQNL2hS3hL1IsrKPmc+R4tV/VS25+JJLEvqve7
         Zh/vw6l0zRcCA+iqiw9GrmL/SQpUU/uqjKVbIfieTBb0CKeO2h2jDX/7BJKeVOWDDegM
         +sYdJq5Dy1LCKdKqZQQEYC0QqBLUj3eDr+JyCxdD5HJ+px8QVDTigeJLpUaDABCByyQO
         nIasOSYi71GyC9Q8ocIyG41bA/CXU3MknASVDxffUiElaTkDm5j3Fdbx5nYZ9oLb6lGh
         rpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740505627; x=1741110427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Xd8E5UB+Vof823rP7txgr2JDe+GKD1zXqyWtuRc9C0=;
        b=G0iKUbhvqYjrxd7XKqCgKj+uorzN3QAI0WNkkiTtgc3UjMAJahownA/WOOCBPLPP1e
         79DFWERg1hklAfx4Eq78hh63E1nCh3fuX927VSfpcq+7vRgKJzkhq7a8/dZPPjDk+lHV
         fO5+aQKhbgzZur5TG+q/nGaRmVMCju8S49GsRaem5mHSAE+Y+neCDAEvBwR3LWPzywQZ
         5cpOts7LxJdQia/4Yw3c34989w+9gO+jP+2nVIT3OWCDTNC4Z4LicFx5klFeJx9SzXU7
         Hk6NnZfHCs8jePsRwfdKHrx0IDSNJ68l+job8japlAl3JUQDpYfizPDxRPiLGIiSjcq+
         E6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVRXwVtmqOIpYa9IoxrWwrC3ekJrPRU1U0oiVw+zrijBWbzksW1urQKO/HmcFNZ+WtsD88DrhxPSuMUxhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3K/VH2WKESPwqmr3pVkw0wUs9CRcv9SzKjx15rKO8AiEAnawA
	/dpNjX87Q+Ws3PicZBwz1e9tV2JyvweI9iGX7nbdSQ9ecpnS5yHrmpmNReuLoA==
X-Gm-Gg: ASbGnct72xHz/QdoofqsyRpjMh3s4rAtoQPcKW7KY6oLE/de7rkje/2yS9Z7qUikcD0
	HVnNiupDb7nWYdVE5RbhhLhj31NAsuGuBaOOfDxwGpFpYXmFMiH9NNWAOcwM+o/zoTDL50TLvaH
	Se5UBcqC73yetAe1FcgK0C0Vlv023Ou+k5kXman8kJsuwabIQ+Z/V8O2i2frG3bBpH+ctuU55Uo
	6WaIZwpY/jWGOuSwdDBr4tLvCqz2PYuznJX6WzQk0G5CF9waCMwH67eEldWW11UvljRe6p6izSC
	+AEM1wmNDqFNq6MzFHcXewO2pDGhhQ9GJQEsWgKVG3cKIOGP8DprDipC3Zdo9jA8N71Ob1uo
X-Google-Smtp-Source: AGHT+IGTeDFei68HewM3dx5h3RiuvvIIbvQKg40aSHvOB+DMfEC6ObIGktd+BXdT7pjqngdDsIJhig==
X-Received: by 2002:a05:6a20:8409:b0:1ed:d780:feaf with SMTP id adf61e73a8af0-1eef3c8ed2emr30176078637.6.1740505626579;
        Tue, 25 Feb 2025 09:47:06 -0800 (PST)
Received: from google.com (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aedaa643b0fsm1412226a12.59.2025.02.25.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:47:06 -0800 (PST)
Date: Tue, 25 Feb 2025 09:46:54 -0800
From: William McVicker <willmcvicker@google.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Zijun Hu <zijun_hu@icloud.com>,
	Saravana Kannan <saravanak@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Marc Zyngier <maz@kernel.org>,
	Andreas Herrmann <andreas.herrmann@calxeda.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
Message-ID: <Z74CDp6FNm9ih3Nf@google.com>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
 <20250113232551.GB1983895-robh@kernel.org>
 <Z70aTw45KMqTUpBm@google.com>
 <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>

On 02/25/2025, Zijun Hu wrote:
> On 2/25/2025 9:18 AM, William McVicker wrote:
> > Hi Zijun and Rob,
> > 
> > On 01/13/2025, Rob Herring wrote:
> >> On Thu, Jan 09, 2025 at 09:27:00PM +0800, Zijun Hu wrote:
> >>> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>
> >>> According to DT spec, size of property 'alignment' is based on parent
> >>> node’s #size-cells property.
> >>>
> >>> But __reserved_mem_alloc_size() wrongly uses @dt_root_addr_cells to get
> >>> the property obviously.
> >>>
> >>> Fix by using @dt_root_size_cells instead of @dt_root_addr_cells.
> >>
> >> I wonder if changing this might break someone. It's been this way for 
> >> a long time. It might be better to change the spec or just read 
> >> 'alignment' as whatever size it happens to be (len / 4). It's not really 
> >> the kernel's job to validate the DT. We should first have some 
> >> validation in place to *know* if there are any current .dts files that 
> >> would break. That would probably be easier to implement in dtc than 
> >> dtschema. Cases of #address-cells != #size-cells should be pretty rare, 
> >> but that was the default for OpenFirmware.
> >>
> >> As the alignment is the base address alignment, it can be argued that 
> >> "#address-cells" makes more sense to use than "#size-cells". So maybe 
> >> the spec was a copy-n-paste error.
> > 
> > Yes, this breaks our Pixel downstream DT :( Also, the upstream Pixel 6 device
> > tree has cases where #address-cells != #size-cells.
> > 
> 
> it seems upstream upstream Pixel 6 has no property 'alignment'
> git grep alignment arch/arm64/boot/dts/exynos/google/
> so it should not be broken.

That's right. I was responding to Rob's statement about #address-cells !=
#size-cells being pretty rare. And wanted to give credance to the idea that
this change could possible break someone.

> 
> > I would prefer to not have this change, but if that's not possible, could we
> > not backport it to all the stable branches? That way we can just force new
> > devices to fix this instead of existing devices on older LTS kernels?
> > 
> 
> the fix have stable and fix tags. not sure if we can control its
> backporting. the fix has been backported to 6.1/6.6/6.12/6.13 automatically.

Right, I think it's already backported to the LTS kernels, but if it breaks any
in-tree users then we'd have to revert it. I just like Rob's idea to instead
change the spec for obvious reasons :)

Regards,
Will

<snip>

