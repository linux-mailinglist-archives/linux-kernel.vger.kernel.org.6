Return-Path: <linux-kernel+bounces-515213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E3A361CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E5A17029A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B120825A2AD;
	Fri, 14 Feb 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="DJPNUGCT"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E126656D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547230; cv=none; b=lFlYLvmpEAeWYsiZgpQYa65YKepe88S2bDzQm0YTWOA5AmoIhtvjGcvb4fTu8bsjONMTzdOlPq1EqX7rslwS2paURXP0g/CielnvfzxGd7F/Um6aFzZxpflPyzwrM3mx/m1UGumm0Z0kkc0d3RfDrB2B2G4X5qAIV82eVjaNEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547230; c=relaxed/simple;
	bh=07AhQZY6eqBCHApP+AXZgM2NZRDZAnYHuj2a4Hr2NjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TopI8qhC8sQlAZ+gEJPAC1GLqqBbBivQi47RGVafB9CXFK1O53eo/ztuQ+dLTr/tnrdTV/t8EYQf1RiYf3swqYIW9KwQdxFpoHP+C/QzIErNtkP7dQZ38gd7ZPHNlQTeMCdjsyrjQ5FWSLCqe9SimY/qPtW4HDKUueLoVkhsT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=DJPNUGCT; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85527b814abso33393739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1739547226; x=1740152026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkMQckh9jiT1iN830+BKZT3u1q140/CKGbZYSL5RY18=;
        b=DJPNUGCT6u/zHwxYTyh+0wrTeEj8939ZwQAzkKVaFThB+iHhjEJTgdXu3ubUYCcwT4
         i2Svf/GAfRe/u1r8bic4ScjwmlZBuBs/h78PkqIzlVnU6Q3BDChVtlKdYMj9CRN8xtOp
         Nbejh1d3Xb1XW1Lp2iB7343l6B7e++pfyuQlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547226; x=1740152026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkMQckh9jiT1iN830+BKZT3u1q140/CKGbZYSL5RY18=;
        b=gPiQ5Yko6RdyKfT+kfxwtZnuCEIeS3nLXqfiABcZhICY1CVRptU1E5cyuyOUibts8V
         xy/Q6Yfya2UnLs7AsMIlMMZ0Vv3QqEnV7UL2RcNtdW9A6LbOXzfXSTNawD0Srmxwyw2D
         3cBNsCb/TTKZ8EPfkzfDvxFQktchJKWc+9UGuFhwuQgB4BF3fzQqgEitGISnCQd0/eDX
         83oLB2OEfq5KyVF7aYC5LZj4u05LQZMZqAPrtakhg5zFQUWoWHOn9hllurt50OdZ3yQs
         gKy9PLySQ96RfJICZrBrWaghtKYZ8vHM2wn9n9ERQ13g3Bh3vvwIccYNd7XPQrYMKgpf
         1CTg==
X-Forwarded-Encrypted: i=1; AJvYcCWJRVLkPo2dj/mFVo7CqzXrXvzAHX/wczi90ZdbVpihdV03lhhYhs36QiUQVS3UImqq3eqbfolewTp0N1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzx5He2cPktQUHOIcM/9KecVn7F/QOWV8BmIE0UWKOYftE6chj
	gluop1yGM5IgBRqaafY/U2gwLcXxRNWCV1OgVs8V1Y2ztKVxCTcV92C1BG8dYw==
X-Gm-Gg: ASbGncvsTR6GsM5GcjAiFVvxBZDLh05s72iGXHMUD4KPqbPkfvBDOfLtgZZ9kcjYSWB
	bRN2U3d1fQ3GCbJ4+KFQgG/bKdo7NYkmvzDjpGcr62qEuXnsgCYey4mOPDGRu1gYm9L2si8RX4f
	ReDJ/GLTBboDXJ6R/GOgvHGHO4E1RYJUm0P3BINQak7chlpCyWab2xHcH5m6eIBU4ku7/j0n7J8
	5SZ2fjnaeROydntSqKVL9/INFuQE0KRu13fRo6O/5CuLi2p/9zD9HiDIh/+Rjn0aLrDdacs2OVC
	92/vNTupeFhrerlts+qNlV7zMmmR0no8
X-Google-Smtp-Source: AGHT+IEq9JvuG9VMapzzSQzEygbV112X3NEj6nPsFllTlUf7bexl8lMA4JJVXPsFCKRgGWrgadZhuA==
X-Received: by 2002:a05:6602:1588:b0:855:515b:ba6 with SMTP id ca18e2360f4ac-85555daecf3mr976402839f.10.1739547226240;
        Fri, 14 Feb 2025 07:33:46 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85566e63194sm74004939f.21.2025.02.14.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:33:45 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 14 Feb 2025 08:33:44 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
Message-ID: <Z69iWGFV6szC7Jck@fedora64.linuxtx.org>
References: <20250213142436.408121546@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>

On Thu, Feb 13, 2025 at 03:22:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 422 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

