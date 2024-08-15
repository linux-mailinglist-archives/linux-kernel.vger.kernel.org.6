Return-Path: <linux-kernel+bounces-288388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98839953993
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411DD1F24654
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E6339FCE;
	Thu, 15 Aug 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="ESBuG04Y"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F315CB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744887; cv=none; b=AahMJjnRaa34rOBoz++8BeXZskrS4VjcWs5W76qwCM4OgNwPi6aK3PcBTEYb4dE+mf2QM7wMQRzcc91sFmX5Dkr8ZPpKiJhvLq3F4/ToktFfU8QUxfrdpmb90UR6jWjBbVwwXL1mqO6q/C5NhkWj0uf80ziuK9YVMaLiiJafVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744887; c=relaxed/simple;
	bh=p5CFD/hz48mXaQtx+PagRNm416H5ts4dtuVJW5kR9Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdTaf6rkQ0tKyl7VTwXqJlhruANafw/dKHNpSxFsdLg6CgkKFwJcIAVL8cuDfTpQHczWEdCPY7/9K9jStGz/Iljgd+zaUCXdZWB6R5O0P02bPKZLFltGn01jQZFX03Z1HUsx5vpdLC3XmZgdocRtd0nXfp16Iv4/NUMF02bA9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=ESBuG04Y; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d25e3d4b9so1528595ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1723744884; x=1724349684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7p/I1Ifd1C+sbOJNrkMm3G9GQ4/rpO39owsvu2wqEY0=;
        b=ESBuG04Yv/RjP1+tqlo773SRFJKaO84YTn8YhvwFWwj3NvW67mIHkh0QHbSC+aCpxi
         1fvqwFFT2oUgo+cIDhUudTdaFy+KO10TwncBJakRN2e3+csnydvRZ/9vmbulSdEo3THQ
         R7//90wMH9a87dNAyfvOhyapz1zkeNRM4AWMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723744884; x=1724349684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p/I1Ifd1C+sbOJNrkMm3G9GQ4/rpO39owsvu2wqEY0=;
        b=wN/JMTdAxE3E+7HIM5Xrkg1KesATawaYa2FzkDqi6D7JHlZDMlT7doJOERc00XENN8
         f8sBW4gnuqVV78BwKSqy0qcUCxQ1cDEM9314M8e98LnhlAq2pqK5rYqsnCouT/8d7UKL
         fF0yBMxvDKFnf0jcC8deNm7D6mE/hSCqF3zH2+Ue30ThdBI0UT5iC9NAM/Z3pZkttkEb
         Y3RWuLI8ernEakI+8uzBdaWHtUj79oN2Xw1SKC3BNfQJr5N0qYuVQHYDUlFymElV7m50
         5rxQrOPEI2NFY0EsspNbUq04CHejrmlZTNaide7F14k8We3emscB0SS2PDawiVRtrWns
         QVuw==
X-Forwarded-Encrypted: i=1; AJvYcCXA1ONWTCeaN1Dpo0wdBeDTcNeTlIBHGXiudOxpFf/YZIN8Nis0q7hN7mflzSD4FX4pMZpLNysFoVwPU1nK4ZMUaQZdQvHGlFoaVSOD
X-Gm-Message-State: AOJu0YxbUlOkjf4EZuJXV/+tD+I76vgkEJsexqQP8tYwojJOHzDhre0G
	wrw/UJ1Dozb95n2iQkkI+E2Qqi4r2zbyYHhJlef0WSWVGikDJgWH4ajAuCWSEA==
X-Google-Smtp-Source: AGHT+IG1BCFoeSQYyuZLRltaAhHPgxyHK54Z6wNBqWVndWOortWFbIRyHExDA0GIirWvVECf9j2goQ==
X-Received: by 2002:a05:6e02:12c7:b0:39d:1cef:2f49 with SMTP id e9e14a558f8ab-39d26d7c847mr7678215ab.27.1723744884267;
        Thu, 15 Aug 2024 11:01:24 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ed76533sm7152115ab.83.2024.08.15.11.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:01:23 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 15 Aug 2024 12:01:20 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
Message-ID: <Zr5CcFhTtIHgtj_Z@fedora64.linuxtx.org>
References: <20240815131831.265729493@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>

On Thu, Aug 15, 2024 at 03:25:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc1.gz
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

