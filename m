Return-Path: <linux-kernel+bounces-260950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CA093B0D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7076B283279
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1165215884F;
	Wed, 24 Jul 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="X7GDvsMb"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74A156871
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822450; cv=none; b=f8xTLTzsVcTrossQyhdoXlgIiEx4LAv+HNSsk+feJ3VTv+ne9bgHCKB4U43lPYpIqs9ptPF5SWGqt+ThMuZkO+5lRkH71yUqRNJnXXj3A9DXwG8TFphRvAjBYSjogTvWoAwbyDbElPxfk5czVGCu5NRR7309ZBrtbZRB6nSEMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822450; c=relaxed/simple;
	bh=ARLkQ9XjuW/sdIZVYSLMjO3/Brz1hGee5E3ABOheFTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9QWLiTTnmI57mKLP/8BVhZlsBwtkpwJegjYtECZGXTmnw9W5hue6tvpL9R5mVusBqXkEUTviSQxOv9KmOBXV1UH/pYId6+tM9/iD45e6Vj8dgJWTAR46vBckb2e6FTwsIOImYWL5h1j3nCKax4ZBRoSGGm6J4Zpct6yyCRkCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=X7GDvsMb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a115c427f1so1210350a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1721822446; x=1722427246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiwB4GQfBTgHC/AKNShPIPrSgCPO81S3+a71ysnwoBs=;
        b=X7GDvsMb8l6+dbQ2VtSbKAZiHoxgigjywJrbN70DpLEdIzSWpfRiwtjgggUP5/OMoe
         oy3t2Xd9tmt5YLHwA17ZggXpY4Qg40JbtTLZ8uD8xMvvS1fWyEN0kVXyymm394oJs1cx
         OAOyJRWus8FnkxuKZNPLOo0bC9S+9XY8C6HJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721822446; x=1722427246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiwB4GQfBTgHC/AKNShPIPrSgCPO81S3+a71ysnwoBs=;
        b=vmr6INCKninOxHIkIQrTdmctcYeaU34b89J3i283l2ARL3XR/mZ88NyEgpeCmipLhs
         8kIbXrmasrTfAVmLUe6FyE8TIZJZ4wHAKfCa70vaiFEdpx1d3JlfXre/RJk8FJSto4uc
         OkBzjI4rKXQzUEgXS6PdkZaCcWYKbcJCbnBVq4+jwRsVNNUvBw35XQxmEL9iFjZrA7Gw
         j4J/MutT5UOdVLHLPh7gAJ17nj6UJc289Aj01P9IsKHJhhrisRL/OYkQRQUSteXGJbgn
         Jfs7KLcidSWW87Kb85FIXhIbafKznTEhq71ruuvysqQJw3zT4zAHFYOAYXIocp1YJfi7
         XZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwL93Ao9A6Lst7JWj1asOhBK9ha+nRHuXmI7E/qNeczadlj6ikx5eH/3H3DOQ358+dtgG7l2pN1CYPFJgIq8Wy3JPopipM7arq7afH
X-Gm-Message-State: AOJu0YygmvR0DHod/2DudMOqPz94R4yjoczzNbxm9AV+wQ1iKbiMnHP+
	/XElMyfPL7axrXj6IrnsvmyrVjXdD8YHxiWJtp+5AnWhj02qdjnsJzYFnWkIKxjSb41n5qRzTu9
	FMjpmeA==
X-Google-Smtp-Source: AGHT+IFhKhVhIQu+7EUnE6JTQdP/zpTXnTCM2skGxc7+KC+bmZ1mOa01+8QMHHJXhssZm00E2QlUPg==
X-Received: by 2002:a05:6a20:7fa8:b0:1c2:8949:5ba1 with SMTP id adf61e73a8af0-1c45e799ba6mr3044095637.53.1721822444230;
        Wed, 24 Jul 2024 05:00:44 -0700 (PDT)
Received: from 928c5557b914 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2245f052sm5405193b3a.159.2024.07.24.05.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:00:43 -0700 (PDT)
Date: Wed, 24 Jul 2024 12:00:35 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/11] 6.10.1-rc2 review
Message-ID: <ZqDs46wpHhfUUX95@928c5557b914>
References: <20240723122838.406690588@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723122838.406690588@linuxfoundation.org>

On Tue, Jul 23, 2024 at 02:28:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 12:28:30 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.10.1-rc2 tested.

Run tested on:
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi 

