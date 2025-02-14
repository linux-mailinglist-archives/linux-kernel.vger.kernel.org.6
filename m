Return-Path: <linux-kernel+bounces-514862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557D3A35CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD0A188F190
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AFC263C86;
	Fri, 14 Feb 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bgr+rb+J"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F28263C72
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532993; cv=none; b=Y+zQDaPTUmnLDJn8fPHex/fRMFoO//mF9329amSiD+LSYwH2UgXzOhgr1dtVeBLXlSLkXXvMogaohl6GypHKGnHDW/bUmysBafM88c+mVVqUQuCLCc4UXBZimVE7W341Qulov3vRoVgu+LpA4nEfACztc52vosmYwWDEdMoxwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532993; c=relaxed/simple;
	bh=Cm0kjaNyPcZ5gH4fVkG8CZGQP02CG9NsIm5EsPE1BrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI5ofKG5udNT969ezM8awxJlBLyH7uvsMsijUyu5dCMl2sAY3wb+QecK0APe80xVdbSrnKfCQm2SW3woVknf46eOFOTLohFl9u9HOea2coL7BiafKom/yxpqmn8mWjS8fZxv3EWA2/3FsNemlixTIbnaYOV0+VJAwBKuMhtJxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bgr+rb+J; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so3127618a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739532991; x=1740137791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NT8ucoFGL5fcDV7bVgoLmkubOhcY55Tclpx4BNfINtQ=;
        b=Bgr+rb+JRxPSUsxmu1tniwwh4w3TLWtS0GPYL8EqAXCTEt/ObWQyEghtk8de54XAAY
         YIOKvWTO9Qx19AbOMBmu1lVs61neE3cfBJz6bD0Lgo+O+LXCwLNjW7qEfsM3OP74ksfL
         O8GpsRcmxbL3rmKMZyf+kAzvGX0F7DORi1CLJD9Vt+ii4ZftZbdxt1UJ9YEDiMv4uTzX
         Hx92LN8Kgn4uoplXGXCcU2lvUkHS4/yxaoBNUZfXOQLLPopsjoww5WYFcZQikwX4hkbu
         P0dxNefst6cf3fVYZZ60JN5MruU4uig54Y64nQ39gHru6/6aSbMRmqDp2FMl6fzzj0wC
         cXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739532991; x=1740137791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT8ucoFGL5fcDV7bVgoLmkubOhcY55Tclpx4BNfINtQ=;
        b=Or3fjaPw0vpFayn21WoD5gA6/i+YdY4mElL4Gy1HvId+/ne8qa8a1cT673fFfPU+MK
         J3ZBFdu2XARP6nTvOe3Qge5wqABD3rNT/yEqQaxQiQRijMxqxuj83oKWmldq4/nZ3IGp
         YHzlOb/wkUS7lYpgJwZvKGUdBXUhekS4DTLYfC/6vZojOG/tDf3CKw3HOTNbh2XvxueN
         bxZcGD1nbp0szF2JMaVVGEnPvqdHk3u7KDAloUsAihJWkAQ+YVxDRrQCx6AFrm3OxCUK
         zFrHsOqWXRbjpI+KKkiwVvZKTlXAQxDv3Kb82mbtvnAIAO0BN+R1iEwlPVEpsx3uf+mR
         aLbA==
X-Forwarded-Encrypted: i=1; AJvYcCVvgE2L4Y7TFwMq217dPYGN2/8S4Zb/2Z++ULrA905Tdiyu/Bp2x5wVyrkuz1Oichqo1Un82drTP9v3BXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkKvQVETtc/kzvf+c76IXnVXUAqAM7ZspBeYFxSwU/X0tZINu
	ZwTj8YLcrySDDA4dX6Dziue0PvWwf9y1MXtW7ZK/mzUqrAIDnmw9CY+uAPjXxo5XHoQ3LvZ4aBp
	0
X-Gm-Gg: ASbGnct+0m+C+YF39a9ZprUSYa+HFqn+YmQTteHS6sjWEPhpmewXf0iFyokDDPTmnw8
	i1iGo5OCGtEJHTYJPWjhdORPLM2NMW17iPg80qsBzw+A8+nlq2GMLMN9p7SegXcpwYZ/0/tNNw6
	SsJaV4693o/2CK8QpmM5Efz17BtjAp7DwswBmZtswUV5Ilj9sCgcjfJdOGlziAeQjH8s1VVAYBx
	nYLtyNPGfaAEcg8T6QwRPMokpIOUurZytSUQc24BLyxc8ftIsmHqbZwAEpiz7PFv9crY4LSG6ww
	1cOesUa5A9FdHvx/nA==
X-Google-Smtp-Source: AGHT+IEVjN7F7pP/eIsuym2NKFVRaVxEi7sl8PyzIjEMUxWZ54kTqt4ELJYKQfkUDGvLsxVdCr6aKg==
X-Received: by 2002:a17:90b:2dc3:b0:2ee:acb4:fecd with SMTP id 98e67ed59e1d1-2fbf5bf358fmr16875208a91.9.1739532991069;
        Fri, 14 Feb 2025 03:36:31 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5585708sm27058975ad.217.2025.02.14.03.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:36:30 -0800 (PST)
Date: Fri, 14 Feb 2025 17:06:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] firmware: arm_ffa: Framework notification
 support + other updates and fixes
Message-ID: <20250214113628.djl7uq6kpwut7yax@vireshk-i7>
References: <20250131-ffa_updates-v2-0-544ba4e35387@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-ffa_updates-v2-0-544ba4e35387@arm.com>

On 31-01-25, 11:24, Sudeep Holla wrote:
> This bundle of changes mainly have FF-A framework notification support
> along with other minor updates and fixes.
> 
> It adds support to allow multiple UUIDs per partition to register
> individual SRI callback, to handle Rx buffer full framework notification
> in particular and general framework/interface to extend in the future.
> 
> It also adds support for passing UUID in FFA_MSG_SEND2 which improves
> the multiple UUID/services per partition support in the driver and
> an helper to check if a partition can receive REQUEST2 messages or not.
> 
> It also improves cleaning up the partitions by adding unregistration of
> the devices as well as handles the presence of host partition in the
> partition info.
> 
> It also contain fixes big-endian support in couple of functions:
> __ffa_partition_info_regs_get() and __ffa_partition_info_get().
> Big-endian support is still not complete. Only these changes can be
> verified at the moment without any additional application or testing
> support changes.
> 
> Regarding the FF-A versions, it upgrades the driver version to v1.2
> and rejects any higher major version than the driver version as
> incompatible.
> 
> It also fixes the mis-alignment with sync_send_receive{,2} function
> prototypes.
> 
> It replaces UUID buffer to standard UUID format in the ffa_partition_info
> structure and fixes a typo in some FF-A bus macros.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

