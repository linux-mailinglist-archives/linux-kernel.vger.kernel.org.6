Return-Path: <linux-kernel+bounces-540663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB33A4B37B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7F71891949
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A401EB190;
	Sun,  2 Mar 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As6qQBMV"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F291E9B1D;
	Sun,  2 Mar 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933601; cv=none; b=mrSk8GbfncqDWE8IrZjub+Wb1wkblQNblv8yjr/YBUQ01c4wC55H1iiOPKDQvgN2uW+F33/yDYoJgTxuUPr7/HasWYm5Lzau583e7ls6W7Qxs0vmgWluaoDvq6S1UGSsZtMhYm/9HFeIV6poWSDtiw7o8VKHq1Jqq31jeujo8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933601; c=relaxed/simple;
	bh=kIkFM2FnSYhcuZP+xngaQrkrnntx4kvvYD0QqaLQZeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q01/WaUKjeQ3qG0ZfZ088l58aieNg+T0Ixzj7Q25f77WXGwMkjjFq7+42w1TnRuNoUqR1/i6WjiXwwUz5cfNrqAf4gkK1vRhJh7Ifcy2MHsfkKkvvIXppM8a7YrlQXQnYiyy/soLj3e38ewP2WfTyTgtLrOCfFAT1gpaZ+nsQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As6qQBMV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2234e5347e2so72359595ad.1;
        Sun, 02 Mar 2025 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740933599; x=1741538399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jynVsTZDGE0JJ1A+9XYqEFiqc805kC8QjiGCQ3kbyw=;
        b=As6qQBMVHjzVdKUbtnFm8Ljya0+FYQQprhxIBL1QoQmJGKVqq/7vBPK1Z0NP+LAKR0
         gl03yDBZ+0o/Sk1nmBM4bRprFow1+JwWPZW6CrOUaxsSzLMjLhRi2U7cAznaHZUJgBwV
         Woa7JKcYjZjPMcLvusywCzQugNwtb0tOsMAJiYAGgRNVfJQ/4rly+1FT8fsZU82iDv75
         oO/VRd+sofTPzDDyG0OhKTO6ESQEmr+I5ViSb17bh6PKFALfeY6h3McxkH7o2DoFccGn
         xd2tnDua1QCwTXZUccWxbKl5O6SbD20UAcXhfcqjibQVxga/tlcQ240WHMM1JRV/AWTA
         se7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740933599; x=1741538399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jynVsTZDGE0JJ1A+9XYqEFiqc805kC8QjiGCQ3kbyw=;
        b=H0fK4pHpon/lnq4bakZMBF9T2HNIvOrG6basV69u/v64nwJHBCRTwIz7Cyz2IDJMLh
         Yw4Jbz3TYQnBmOiv3QEY5XItpbJyhvAaSGXlPSvQoLoT1Imn1eX4SsPh2Mv8PzpkThIQ
         G/NnzT4oW5Ax+ix3DF5DSQFVlbUJ+7pvq6JTDS+MWzZEdT04rd13AT8eZXHgMUDRkoiv
         /ztW+2WnOVMXeeRKZy+dkH8sbAQrUYNvFYFIHw/gNMBi9g6kZgYbv10RH3funWabR/UV
         Na+MrwoPsp/AxFs09ZPFFmeMufQYyMlKt3wmvlxN4MB5Mk5uL8HhaPRN6fx6JajGnq7+
         OKDg==
X-Forwarded-Encrypted: i=1; AJvYcCVKygMzgwYWeiaIRBYCt3OQBSs6y8u/ccdWiN4TG14na3BSnGrbtNNHhJHtom7wdV0u4VswMqxtwa9g@vger.kernel.org, AJvYcCVTfRjiaa7cYcpmpxhkHA0b2eC0G2CQNqKffwrBwXH3kslOxOrDnNP8tT/0JsTD1SYPhmjQbYyiIp+P+ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlb0VTVL+eXNaNnruaIC2ZVi8zHEfAdlYwXO7V7IEIAy2asI2O
	twdRUITR51Bt7VcWsy/oXuj2vGMArvMuZWeXtfZ9Iw9IgjBAYZ1R
X-Gm-Gg: ASbGncsFVn7gUrFUUG8JpB8j3O08KGgVK+OsmMAvAIAh+H4byCiReZ5h/aBOR6IuD6f
	bF7eZgBcLY21AoRA1EdvcBdd6WcydhGWorxWTETlt6MzIJ3g07sI2E0q280f4MBhHRBxf/r+he1
	yM8/dAG5Iz3k1qBsnCYOvrxzkpYpXAUdusaVA02kXN3puEOqGoalQsiqvrC2edAl9FpkL8ITo8u
	xuH9CojGQlrfabVVxIEiLVVhkskU7k9SPmgR+F6FaxFCAYlIN6D/lTJiG0GzHmYrX8zHdSj697X
	0A5CW6EitgaZ2ggVYlTCFEY3VnaScU/JexM0hYJuYmq1sXCKHAbXBVkTlA==
X-Google-Smtp-Source: AGHT+IE+Jyy8Tx/mENn01VEkJrjrGhp2+KJuLyhoBiUomCRHPrUc0boTpd0srOX2HCbUWZ0Be8BRZw==
X-Received: by 2002:a17:903:2ca:b0:215:acb3:3786 with SMTP id d9443c01a7336-22368f94723mr165695975ad.19.1740933599084;
        Sun, 02 Mar 2025 08:39:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6985226sm7196911a91.40.2025.03.02.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:39:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:39:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Jonathan Stroud <jonathan.stroud@amd.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Jim Wright <wrightj@linux.vnet.ibm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: Add UCD90320 gpio description
Message-ID: <68b60e48-4ba3-496c-bd24-4af81d163168@roeck-us.net>
References: <662a050f3f8160fe7c80d4f19e45eb4fac0f2f0a.1740384385.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662a050f3f8160fe7c80d4f19e45eb4fac0f2f0a.1740384385.git.michal.simek@amd.com>

On Mon, Feb 24, 2025 at 09:06:26AM +0100, Michal Simek wrote:
> From: Jonathan Stroud <jonathan.stroud@amd.com>
> 
> Add optional gpio device tree bindings to the UCD90320.
> The binding's description is already mentioning the number of GPIOs but
> without actual gpio controller description.
> 
> Signed-off-by: Jonathan Stroud <jonathan.stroud@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

