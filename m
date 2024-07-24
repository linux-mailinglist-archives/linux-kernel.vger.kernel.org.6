Return-Path: <linux-kernel+bounces-261287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F393B537
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3758E28450F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BD815ECEC;
	Wed, 24 Jul 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="aVvCsBJ1"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8415A874
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839386; cv=none; b=irNfKKNxazl1J1kV9sfIqfqZ/aWHDm2gOk6i14OvCbTrWPi+0RUZPAmTSn/JX2QtrOMA8kO4BHoehhvKmup6/35JVg/SyyS6bVGh6L6w3QKaQpDVl69i8N62rqROEC5uPFam073TFxpVdDTDwSxlBvq1gZainleM8IGWc8eSpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839386; c=relaxed/simple;
	bh=XnBSi4lJYwqPS7JvayepIZdhilljl7iydbSuuQDgHeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEbK00Qo26ExZQIth0ai5qpdpOz9LB1rWV+NHP9kmuQprs9IGW8OjkgXhM/b0fE9EexwNeclj+mN+ZFmbycOoL6u6BzJqha9j0lSvexVb5CHiem19f1JA0OI8ocjXcksKqOV9TlTdPLlVX9ic+zO7bC0mESaQbyXK93JIAFXhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=aVvCsBJ1; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-816d9285ebdso575739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1721839383; x=1722444183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEJs/m1LfDi05lj71qThBLJVfg82KFHAF0JSUzDWDf0=;
        b=aVvCsBJ1nn4Je1cCQAi3Q2bYum94d7ga0tFJF7/xUH6l5cbmgeM5oUNki5nO2FdBqs
         FowoKQEuNX9P9c/1IOUoHRdJPwmDBm15VHUDry8E0t/qDZTBrRcohToNd6Zpfp4Kb/Tu
         ya8CXIcMbjEu9dbY7WxSA5GHXxj+ltjc0+XrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721839383; x=1722444183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEJs/m1LfDi05lj71qThBLJVfg82KFHAF0JSUzDWDf0=;
        b=sSrkZuGbziBF1sKIGAD/T8gMuXDHX4pT9MkK/RHcmER4rKUDcjNFv0cglRmMFWJWnK
         NhbLQwifhi3cFTaTDtUNBEmY5pg6FLmJZ76W0sbS92aKDithKoHbOuy9tYDoOE0llPK8
         Jx1JRreuTBoaz5dCGkudj+BpKqvFrR92HsU7m2y+e07r3/WwqnnaReUvaExB1L9fQZB/
         DbU/Mzg3WR6tQQq8dx4Ir3bl4Q083tN++hfCOEh0fVS3o1uDVQdC0+c9LKoGqCZsiEBY
         R6qVRRMmwa2saKnUwXp5Y9DK6Yr0lbPTwWeyqjafXkcJN4SrBycROwnTidqxF9rvhh4E
         Ihgg==
X-Forwarded-Encrypted: i=1; AJvYcCWCI6vjN9lP6aoGhVtJ8z3UchBryOl3Xxn66WNy0SrDLoJcAp4vBew+xWleuS/woqCnBHJpIPfPUbU8QzAvpxc4P7C4tg8JWOwjY57D
X-Gm-Message-State: AOJu0YxWR1gzOnsCUd3u881WsUPrdrS59KNgvGzHvsqL953eAQpCpuH2
	KhmIcEhbqXH+kl3klI4dnhznFV8WC2PsthKD2eb4T6aSGDULKlys+foFM35rbA==
X-Google-Smtp-Source: AGHT+IEOh68yrb3+/ES/BDsvfk4lSOZpn9NTCMqLMBdmSacZPA1m1SxGq6eHvO1XgEDls8X7NMrdrA==
X-Received: by 2002:a05:6602:6417:b0:816:ec51:f415 with SMTP id ca18e2360f4ac-81f7ba78fb7mr63172139f.0.1721839383230;
        Wed, 24 Jul 2024 09:43:03 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7158d719sm56744939f.8.2024.07.24.09.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:43:02 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 24 Jul 2024 10:43:00 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
Message-ID: <ZqEvFNTOyOEgyAl4@fedora64.linuxtx.org>
References: <20240723180143.461739294@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>

On Tue, Jul 23, 2024 at 08:22:09PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.11 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:01:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

