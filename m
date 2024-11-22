Return-Path: <linux-kernel+bounces-417604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B89D5686
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31C01F22612
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAF1853;
	Fri, 22 Nov 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gCGk41Z0"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C74382
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233908; cv=none; b=ItzgnJqf332jUVfr1c7I36rK8VH6I0lUKE/iFF/5g6U18/2R1ienOyVdDtj9zZEL1BJZSDtObCCx8Q2tr95+zvKBBXLvluZ1vQd0U3cifvCFfU4KQ9T3oiRvHSH995MHB6YevyWM4KoSOblyb1fELg68p0HAuEth66xaw/NniGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233908; c=relaxed/simple;
	bh=b8zZutAt+QIFWYnPwEoeJWUZ90wviQXtYZBmgBcpsM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q355Tzcv6d1t/dOPmLX/1utrYDGmvGJe2qky9+d6maqLnVWZf3csdPJ+CLNAzCoH9fLFs6TFuMYlTHWzPfHSeVw0ZT/PQ1HPe70y4PXzGsog01sGBdUFP6E9im6bQk78BT4CIuRxg4kto591vMsP5X2uhvBQgMonV3PQQXTdu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gCGk41Z0; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a74d9aeb38so5229775ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1732233905; x=1732838705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNfmZ8kLGk3Aq5GrsdbwcV0OpfxOVZ8lGDQ7ouTp+RM=;
        b=gCGk41Z0gX6dNCM94jx6/moIqPBKt5Q5M8HQD1dMTRfQa2OIakXwAb0ynqvI/ebxGD
         j5oylraMMfv5jJnhpWXXbJc+qY7OQ+ByNd4FeuPjyWufjS28q8/GFUTnSdCL3N0h+Kf6
         205I9fqGWR/wczrMPVcxv+rct7nsiFaBDYXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233905; x=1732838705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNfmZ8kLGk3Aq5GrsdbwcV0OpfxOVZ8lGDQ7ouTp+RM=;
        b=hHL9XQ5Dxoz8xjy0WkFz+MZKF8XndXXax8fdWTs0tju3kjKG/J+BdEYT7kYQE9OP8Y
         wMkGkgqYkmK5mKhZ7e3WhWX7nZFa8WyJVsqyLm0BafNzQjbIWVGj1QtlDcTapNshVWvx
         mtLoYSPQXL2dpDUCrDjHlXlppNfH3ydjUeLWE9NTAxpXujlXXh+rGR9BX0h0ZUITa7az
         v4ZkSNuH2HyznYMG282CIXAdiq3+T96+5R+LsKHrTeRkFZmgIBb8hgVjtXnWhODvbgXD
         ELcGDV5uaQTEjIdNEAk0cmahlBXRuuc9Q65wCopO/TCEfu6eHZn6tukVRBi6Q/KQr89R
         rQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIppZuD+Dgndy6A42BMWWBslOWSSMszhlbpcAxsz2qViJvOhCxU9QjlIHjShu2qzPDoI5g51IaxRfy4G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdI1NgpZVhX++ysUj95DVkZHmlOCt5SQ4FC+dQCOGqjbPvb4ia
	/x3gF+YcBU0t22R5LUKYjq0HrMeEyyM0/vgt8ug6y2f989ogdiIh0N29sCHJWA==
X-Gm-Gg: ASbGncv1Nxdjya1WryxARN6WbpciFN45G6r06FGo6xFw2uZ276fv6vBWEZcncbFfJ5v
	TgPykceF4o0mI0ahf7M8M8pJehnAoPdaWVSifqhgIEr9bMQdPG7lN/TWi3dApwcoGnE6Lw7XSDH
	w84aRoUeyrywLjgoH5P+Xl7tFJvBdXFNuv4eat/8WP6lT0ZJfqWLSUmIyPt/uDT2i+uxfbxduTa
	Rxzi/sebbYbUVcPdhdrqloqUvq+01X+iO7nT2uARVSBwBdRCKNAt/9bU4ckZJPSvmQ=
X-Google-Smtp-Source: AGHT+IHBJJmVoqdEV852lyYDSdtvwnErbqQGnpMTbpDUvDdyHZu4U830e97nzCavsnPBEQLf8xCSqg==
X-Received: by 2002:a05:6e02:1a42:b0:3a7:6636:eb3b with SMTP id e9e14a558f8ab-3a79af75f91mr8552595ab.17.1732233905230;
        Thu, 21 Nov 2024 16:05:05 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79ab86c6bsm2352495ab.16.2024.11.21.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 16:05:04 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 21 Nov 2024 17:05:02 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
Message-ID: <Zz_KrlE59xV3BV8I@fedora64.linuxtx.org>
References: <20241120125629.681745345@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>

On Wed, Nov 20, 2024 at 01:55:35PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:56:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

