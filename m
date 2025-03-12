Return-Path: <linux-kernel+bounces-557724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45578A5DCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74528178E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A8245021;
	Wed, 12 Mar 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="M5Shd+Wz"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBD244EA1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783269; cv=none; b=gyzVsGb9soXn2EE0M/LwDYhADspt2hGpp3fOlAYOKtqPVku+IaZzL1+bBFRdP/DHV1its0ih6gmkdhCe+dgciEjhRiX1wxt6zvYedHToG4hu2Azv0OwyZMXRZt231RPFQpEfevbzRTFSM7LGF97pQexUSA1BxEpstWe1hK/CE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783269; c=relaxed/simple;
	bh=bUaSlUg3RSFBTsJCJQtMWIt/F/YS6Geb3jIJDsgvVi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxOyME1VRV1smu2mmkZjw2t3ksuVynC2F8LTwk3poTuGfDf0I3O/YwYBuM8cUgv2Gc2UwCtcAb4NrS7b0VCB1f2ay/zov2PTDAx6ISo2QMVMzCG8J38OPwIU6/VMSGJAMQMf7JgCtph8vEkpOS6vPrTK8rkAmTDbnp8BBWQ2+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=M5Shd+Wz; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85b5e49615aso255632439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1741783264; x=1742388064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dP4A1PaPKl7EUlUOAH0m0yidu5CcqdMAHhNJvQYeKs=;
        b=M5Shd+WzC7GB6bjfp/h+Z0i3ZsVVuaO6Q2Lc9jxjclwprMYa4SWAUOzO9bYYvbLuVb
         KsD0wvtMLDSqBoSonFnjrWLczXateIFvbARFkqGpbYwlDz+XowASRJj71wUIlhQlFMYK
         iB3UYYWASs3XOJbPscVqBzgJiriwFQevWIlVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783264; x=1742388064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dP4A1PaPKl7EUlUOAH0m0yidu5CcqdMAHhNJvQYeKs=;
        b=tlb2my6OYqC1v54w3+r8WOG0yVssOfrz5GVTb9BjE1kZgdecSwDruAsLiTqzK7MPkr
         uiX37ymh22cyjDMfQANAvq1PcF4fTXqyUhHIXuNr3IEsQgWMgBWgfNckb4rTJ8x3WjTP
         Juoz3WIFCgM8OKSoKmD4BaePH9MI7DQLOzq28sQecedYeGG9WagqqhQcm5XmdkUTiQ49
         XtGI9I0V5c+0Yivf49EhCartYtNsHCwQlx9m/T1iZAdOcw5uwTihb4n1NQfBmvwjWIp/
         sGkILhH43dOUVR+5lIzjcZ5j0L/PjvUQk8qvVG7X4jNwPH5o62zP2RUN5njffgB/Om0C
         L8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJwR1isoRzxomTgl+Q/P6BUj5mgP7Peh43BTRBaz3sv+cpmZ4xKtLVz8W6zI7vDOMOEwMD2rOoPgyS0BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdxv9M3xFWfsQ0VxpWxc35ijYE+VGFMbyJVRYSpM/YRMwAenh
	6mq5USPmMkGZbCMjoSFzIrIBZJs+iAjZCBR1DwQvW079je+Zruv5PssBP7Q/yQ==
X-Gm-Gg: ASbGncuYzGDXKpZEL5C7wcRb4XMAphgnqWCY9ke7rjAVVlUOqJhPA8VPBNipMcFUeA4
	y+IZQdhngX80oLNECpGAe42HwROixZ3edD21vhpEsX01eXxOZyoHUgniaMQWU7PbOI/4hUOdu7Q
	tFF+ad+p/BTtb9RrHmighp+zBG1cypRU/Q3AUbeEbzdQ14cSzuY1T3rah74WLgMOhife0MejpvT
	iv8ev9OM4l9NnAl/bRBaCa2MnfwVNkvndtAyhP+pXzWdpyi05lD37Y8fQIKWF28wEBNn1pHEwzg
	yVf6vtDOB7wf6hRWtbcg78R9FXwJ43EjeWzKFZ2HsqwhK8TQgQfVEr2tvJQfMA==
X-Google-Smtp-Source: AGHT+IFLQqpuypHSRNnz0zBPbGSRwBTTy9nuZ3EEUDWO1+xrScavLssIudJZMqoxc71JqTU36mYhUw==
X-Received: by 2002:a05:6602:4008:b0:85b:577a:e419 with SMTP id ca18e2360f4ac-85d8e1ac1cfmr810913739f.1.1741783264692;
        Wed, 12 Mar 2025 05:41:04 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e15822sm3165046173.37.2025.03.12.05.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:41:04 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 12 Mar 2025 06:41:02 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
Message-ID: <Z9GA3nNRacBJxmiX@fedora64.linuxtx.org>
References: <20250311144241.070217339@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>

On Tue, Mar 11, 2025 at 03:48:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 14:41:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.7-rc2.gz
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

