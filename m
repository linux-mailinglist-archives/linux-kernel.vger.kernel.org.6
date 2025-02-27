Return-Path: <linux-kernel+bounces-535204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA7A4701D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAF1165B52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408514409;
	Thu, 27 Feb 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="W+ypF5sZ"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5B20EB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615605; cv=none; b=btrHQ4dzJuMnIp595rgp14OcSjgRsKIC7hXjhMklhQKzjKZxh6PR6HDgODAgKkrhTqdC+yfmHP8z+iVZD2sz+fS/oIovZmNCq2+EnxYgIKNROHfjdPtuwkQYnAHMTC5/hzH4g7lOf0qBcuBWOtReX+v9jB4Zq2wtmQF80SUxsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615605; c=relaxed/simple;
	bh=/Uv2ZSNL0GBBewIm+5nlyMexuc3dwuC1Fvb/0p08ebU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFpjfdYOKMkbMwPze6e489L02stcOuBbCvbeW/oasL8yH2BSu538kvIVqflEIQzRLnZmSWxrB4cjCpWjXK7WrV/PUH0pJJi3jTUnATYkHQKRAi09LDx3omc8hi1MJNgfIsBsGBkF1leAZ6RtlpbN+QjSF19mp7PLkokoHaiz7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=W+ypF5sZ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-852050432a8so14168839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1740615602; x=1741220402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8wC1L3gj87WwcLGHPjzIsYmr9ioVfbKFSRwg/VgMwU=;
        b=W+ypF5sZf82AHqtQx/Y7sPKyoY/MT4p/O5q3pStTdPmNteAEnIYu8IafezOOELzaEt
         6bGunrP5Y3MWe14bWInVQljnS6k7jE8wYz36ZOqjZyPqxa4QrFqDm6/NInPov5zENejP
         hmuvpmWxs2D1etdVwQ5H31clADY3JQ6YbSP1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615602; x=1741220402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8wC1L3gj87WwcLGHPjzIsYmr9ioVfbKFSRwg/VgMwU=;
        b=CNKmnh4ZL8rpm6fg3jeoUSyvek4J/r0fVPup3QICwqcV5JV1qZ+fMwDKMR6g+WdNtL
         uUI0NUGj+tstBnJMUlzNJ0Z4cOZStXSQRpX6U4Nu5au7dIna8Ti5WM/9B3gUmyfVHztT
         yrKrxJ18o1gBFxi3xAgbT9W+G/rsgUui+IJ+DZCOj01fiYHG49GsVsvgKx1PZ9XTnG7t
         Oa2TDv8i2R+rmjgZxsQsSoae9Nv0bGiU99+iiYiUNJAOaIhQMHK9918ueAdKza73kjMr
         cVpf9/LsUegu/s4Ly9zZEMPlMEBoX/E1yeiKlRo+SWJs5PzeExbUHBFwj/WVKqh+MnLw
         1Wgg==
X-Forwarded-Encrypted: i=1; AJvYcCUwAV3fUe4d1h84gnwXlhaqCklRmc/IgpLncnKMstNuOJTros1Ka2vD3emTpB2x91UEk63oFTFujyhF6fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvimzKcWZdWuA3Me/HeDoB0+NkvcbkPFRuKiWVi7/KTMke4tb
	4xP7xfb7B7/XBYe/j8jAhau+eu5TeafuhG97Jp+1/Id36rFOVzQgIOduytA8LciKgN7alvq3vAj
	ZvQ==
X-Gm-Gg: ASbGncv7xeEhmYfEillzdJI0JRCyVPptLs0Teae77dSJ0iSAgr8FoSVQpC5wW9Pm3x6
	WB7FHWwxUe8Zms4+YtTrcZi5g/Bodglv1ZxKxAdrU3bx79DWaVycJghl+EgPG7Ks52CDyMGB3YC
	uRbJjanszQfkBeHM8/PnSEJbqEK+Cq6PGW8DC+hZeX52/BKcFlJSsNsbrqOHB+HhfwKMyFlQi6a
	xl9zxyJzj+hEKok1j8ylaOT73ltCzn4VgNtuNt7KWR/gBXz3dW6dH/Jspy0/I6d5jKIimM+g9Bp
	bxOyPqA6fNPquwAE0GKQt9/vE0Utdj/AJD6x9gwtiEI=
X-Google-Smtp-Source: AGHT+IFeShw3DzaW8FTTd4sEqD29fXvWlqwVnm5ezdkhi0VJ/bgUsO778wJVEgo8LhzCUlbtIxXpxw==
X-Received: by 2002:a6b:7e4d:0:b0:841:99cb:776f with SMTP id ca18e2360f4ac-85870eee265mr151794739f.6.1740615601682;
        Wed, 26 Feb 2025 16:20:01 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c0bafcsm98732173.24.2025.02.26.16.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:20:01 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 26 Feb 2025 17:19:59 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
Message-ID: <Z7-vr9gSWIsBuSZ6@fedora64.linuxtx.org>
References: <20250225064750.953124108@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>

On Tue, Feb 25, 2025 at 07:49:18AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

