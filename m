Return-Path: <linux-kernel+bounces-325529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C3975ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C3D1C222F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F41BA27A;
	Wed, 11 Sep 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="KDJgk4Ny"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DA58AC4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083123; cv=none; b=CYFQJAgO6OZqlQ+OziSevmyXuEXZsVzV912NcLeIsOwaECR0bQUISYUqscNXgf2RZPbJU1vC2FfhR/YPIxJ+r9zP4IG9LtU9PVaXe7V70S8fFm3wNq4wNO5OuCNaYJJ5befhZZT8xGB/ZCfdcDTVmTi+TsJ0sT55J+y9EfC3y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083123; c=relaxed/simple;
	bh=07yVX+a5HKymQT/kEVbwRWOHz7xK4lZuHdWBrjAUKc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRWdA7f7XfU6MyayiDCVEmr/jNxJWJQeQcBF4EZPxLvNjy9ofkPb8dK7ilW+M9NeqAwy7n49E7TULc5AXVNxp4uDJLIBWwDEbUM1LBz3IoIZ9sCy4Mfuu1MSeyf0WejkWdAkNf9C0IucPqlBMtCsKqXD3cZj3hzT723lnmJB7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=KDJgk4Ny; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82d07f32eeaso6869739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1726083121; x=1726687921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gtmb2W0kiaRq3w+FhsyuW0F/eW+GNWteDIgqlZPPh+o=;
        b=KDJgk4NymABHJOwXLAXqZzFOgL03V3mwrRZ3+KfC8lU7+MNXGzvsJD0IVfvkEVf5/o
         5PehWh+xnakWAk0cftdNY5DPDgXM7x64mSKaucHKDwY+Yc/kcwzMkbCZ+1Lo2L9OEdiq
         FQqWYM69BaK/Byi0FcAwzrrv1R/k6EUCYekWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726083121; x=1726687921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gtmb2W0kiaRq3w+FhsyuW0F/eW+GNWteDIgqlZPPh+o=;
        b=eN43TeowdFntwS5HF71qBVl6n6VT0onK2qC4nfDNRSCV8LwPef0VsafoMssqGZdwsL
         40cN/cNcpH+PBFRWUpe1TP3IP/fl59NxbiGN2DpTpFh0V/qArzZtpUsd3KX/sk4R55eh
         vqUKOffmjH1WJTLqy5MMXkvzXvdlCkV5UGKfzJE3zzQaeoEGv4QnTFIbc3mmiREEeMWt
         mcQ5qeORcFfx5tvsKxbKy+hviz3J71Ubui2cIsVW/6WiON8kpdG57ZDhZpIF3YJShtf7
         a7UI+HO3Bq6UDt0RamM5GBLMiZEvWlHzSV8dA0gluDN+fDaIK99JVmfGIr+w3vMzORLe
         RfJw==
X-Forwarded-Encrypted: i=1; AJvYcCVYuF9FSCBt6RzM27NKCZCjecXIzDaelnyjEipG5leD7a1hgbQMuxMcQZvFjfEpKyxqf3SRbPLc+MPvkrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwax0K+8RDux4jYbYzXt6i3K8G56ueSAhrGkwpc4+SNJ2yxAj7
	VpGme87cStJj5urx3tq0P2W6SlWO2D299ZD1T0qIBbubKyiVbwtDdAneozs+vA==
X-Google-Smtp-Source: AGHT+IH61wJeAaDsZVI0UulLG1dxqR8dVtT/hu5F4TWg8gxDaOsHx00AEczVpQO1l7iNb6Sv8R042Q==
X-Received: by 2002:a05:6602:6c14:b0:82a:34da:72f7 with SMTP id ca18e2360f4ac-82d1fa93764mr101635039f.16.1726083120696;
        Wed, 11 Sep 2024 12:32:00 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f433dc4sm159871173.25.2024.09.11.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:32:00 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 11 Sep 2024 13:31:58 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/375] 6.10.10-rc1 review
Message-ID: <ZuHwLtRJkij6oz15@fedora64.linuxtx.org>
References: <20240910092622.245959861@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>

On Tue, Sep 10, 2024 at 11:26:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.10 release.
> There are 375 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

