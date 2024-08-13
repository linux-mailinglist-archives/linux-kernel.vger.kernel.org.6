Return-Path: <linux-kernel+bounces-283943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF77294FAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A424282BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B74524F;
	Tue, 13 Aug 2024 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fgqw/8UX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BA5684
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723509936; cv=none; b=eODthjX0fmYtzk/28gNS+FzbzQhvPE626LPGVcr0imddH9IaEiS77/Q47fSxAZ7I2c9MB1vJg4MnDrClQJiG5x8rvGkoQgQz+qVt5r7b7AEE4w+V6aBM6YHpn30jpsYx9VJlFcbgyuHtOHJxV9TZcJgUE/SwJ80ClK3XmY7ZSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723509936; c=relaxed/simple;
	bh=1sBgTIKoJ6AjCZ9d/4YTN6ajHX8hpg8Jnb/EcKKS2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQij6Ptj+wjKWpE62Nr3cDp5UY34X8tWZcJ6rE4JCHUqTW3G7p9ZLBC3cvbM3cdDeEvjWeAqYHOG6NNPOWpB9+4LX7Q+IHHvxrOE1nE7kTMV0xYqZyZmKFRNPX1SAzUFapkSteQeMFBGuJQb7EgXI5jthkSzeDo/bluC/MBZ6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fgqw/8UX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fdd6d81812so48560465ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723509934; x=1724114734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Beo73jI8KH5p03NxQPXLaupS8Ut84TtJmPr0+Y+H6g=;
        b=fgqw/8UX/rOFKnGO4Qw7UTr3fPRrjchwCWqqDMVWrfrnA5KtNi8sApteK5xebfWEAe
         3alttG2i/SY5X//HIcW09qGywlfHaMlJkjSlqm+YNeTQTR0r4RCLK4qsE2iO1wEZLcGd
         LkGYpViyZ11vPUfG1DoRxRTGf2FVKI0vQ9xr5rHwbqlJYA7J+0wCB/QBdmM+NUjvfA2g
         Dj9nD+zaR3Gun6corO4RDKART+aaAphUjomNCUfLmIf2JU7VFO8dKDt6RtPEMQfgcvnD
         pIQVe1iuiG74phuO9Qpwnqv8uz57GXrzveaXy/2RKVD3XTHPRDClEvkV3ghkWrfP3u1j
         1WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723509934; x=1724114734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Beo73jI8KH5p03NxQPXLaupS8Ut84TtJmPr0+Y+H6g=;
        b=gWiDHIFawUodrftm/lPFSuhitiO18fU7FJ4kkMdfyYFsXX/6hXNZimQMaLJzGKvS3o
         xOw55ACJeD0qZ370EBCvqmbGDvk4fxTUlbkKN9fRF+SzRrfflssCgJsbSooEYPWfabok
         A2f7N9eE1bK+ubcKBAeEoececG2FYSS5kBeaAMMKqMQNz6Bd7nL1mpogoGz7WH9hhY4d
         XTmziY2oAy1wRME5CF7/rByJdI2WJ4kL1jkFVmtAJ/d/96fV3bJwOgAdIGiYNfSe62bY
         RPirzd7D7ywxC/PAbQTl8/kN+WVMPzg4e1iYAOzuEg8iTBwwmfFvl7XmPe9P9iuO1MWB
         S4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXbwyilbjJjzbzk66pZXhRxlHP+VwKvx4sxQhDgRUSaYvmnyGFcXE/jMoj+0aS1OSiHNFBXep+yuEJPpxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3B6x3qtd4VX1hpv6x3nxEf8OO+btyZ7QCPIfUPu3ibgJ/C14n
	g3IVJVXha4gIVi+9B9bS3PZTyaykEa0SLb6aod6K6xrV4P1rk+wJ4GVFSFac5X0=
X-Google-Smtp-Source: AGHT+IHdEc1RzSfknb4O0tEELFITV1/FMiLC99gVJNOSQQB/c+hZmMPVy98DA8PMYeZcE4ZXSNQJNQ==
X-Received: by 2002:a17:902:e80b:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-201ca1831c4mr26201755ad.37.1723509934094;
        Mon, 12 Aug 2024 17:45:34 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:239c:9f30:d4d6:f989])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c86ddsm2537295ad.263.2024.08.12.17.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 17:45:33 -0700 (PDT)
Date: Mon, 12 Aug 2024 17:45:30 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v9 00/13] riscv: Add support for xtheadvector
Message-ID: <ZrqsqsCtKwfG4Q5B@ghost>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
 <20240809-slapping-graph-461287bac506@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-slapping-graph-461287bac506@spud>

On Fri, Aug 09, 2024 at 11:31:15PM +0100, Conor Dooley wrote:
> On Tue, Aug 06, 2024 at 05:31:36PM -0700, Charlie Jenkins wrote:
> > xtheadvector is a custom extension that is based upon riscv vector
> > version 0.7.1 [1]. All of the vector routines have been modified to
> > support this alternative vector version based upon whether xtheadvector
> > was determined to be supported at boot.
> > 
> > vlenb is not supported on the existing xtheadvector hardware, so a
> > devicetree property thead,vlenb is added to provide the vlenb to Linux.
> > 
> > There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that is
> > used to request which thead vendor extensions are supported on the
> > current platform. This allows future vendors to allocate hwprobe keys
> > for their vendor.
> > 
> > Support for xtheadvector is also added to the vector kselftests.
> 
> So uh, since noone seems to have brought it up, in the light of the issues
> with thead's vector implementation, (https://ghostwriteattack.com/) do we
> want to enable it at all?

I can make it clear in the kconfig that xtheadvector is succeptible to
this attack and that it should be enabled with caution. I think we
should let people that understand the risk to enable it.

- Charlie


