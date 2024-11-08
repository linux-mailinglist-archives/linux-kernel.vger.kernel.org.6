Return-Path: <linux-kernel+bounces-401905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD99C20E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEDF28519F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04121B42A;
	Fri,  8 Nov 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="TY/qDmrb"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFF1F4FA2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080799; cv=none; b=omI21Dmd96lwQy/FBnN3P5gFgbQLdUW/mF73D/Jpa8Jx11kvj8ewHo1fDfw2sLZbet4JM4/HiKgMJSUtpd67CqxwTuCdq5R/P4sK1BBzlqDz0xjupeVFFPPGhIomJvnqijMNxJBNLuCeN0xWGCgo9L324NbimY/Ulk5revRV01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080799; c=relaxed/simple;
	bh=+LdFeKzzHTC8RXvEN6PYH9yBE5GfE37SIA4P+W8wZps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRxELDlsTLHnRK3b7EXdI6JPkFwisDuRIwXyTTy9b3Xldn89WfkOFdSwg6ng3fGA6w2o2Zkyw5ozqcxucbitJ9rH/31fRWqbCyMQSKl7s1fvnX/Ywctp5VC10qBPdNlUV0tL8c78JTCSKCOlM5+LEhsVylHUQ7fpX3VoGuOgUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=TY/qDmrb; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-28cdd9d8d01so1310836fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1731080797; x=1731685597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTUnoBbq/iXzcyhOPyoYG3wdG6zX1R3z7yRa2H9Gwss=;
        b=TY/qDmrbzT6tzn1ovcsgZYLWSQ5l+NxbynlRHvb/EDYs9ZyjF+1W/qpnXuituCFzZB
         4xpKb1ACw1xVGHLvB/VKGr+Ec2HNLpqrofTBJlzChoPGVFwjEJXZEOK9ruT1ZDeikwnD
         9tUy5wTiBDbO8xdmn0gnXC38shanbJ0/9myAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080797; x=1731685597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTUnoBbq/iXzcyhOPyoYG3wdG6zX1R3z7yRa2H9Gwss=;
        b=EQgBWEWmIpuJovlKTxHF5w8FfRINBbaHNb+TgMABm7FpDfTzqgoL4gk5lm6j4Ogoo9
         IJHPpjYDWKStvfaTih44RiwaXvklCQRm18eY/P5/U+O38OjQrPKdi4ybBld2azkrQU/C
         vank8ZeDeG5wlcWCtV419UQMbg3iVWWNqDufGa3mJgcaHzfw6hkibbWrqE4b8whfg8TS
         SomEigA1KKSwUNnKmr1CmA+Msqs+h5KFdbuZ/9rWTp86XApfEL0lyCaIVo/+A+LNaoGT
         vMo1uzR6WGNoC3sI+PnCqkIdn8jrkDq39tMTPK54vz4JGlymgSrQHojNhgOp0NtIFbLh
         tlUg==
X-Forwarded-Encrypted: i=1; AJvYcCV27pK94HvMuq+z71j9JVn86OW0tCIJBcdkilVnu/ZFFVSXs5fic4WRghvvAuI06iYWku/ueo7xBSF1OoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRX6/v+2TBQUyV0TXP1ykCmZmMcKXe6ulSlhI2HGvL/CkYJFSz
	45Hxs/+OPYsHqE9FWoAn3ZeLxrZqlZynIMZqioeEynswXwkVR2co7KWlLUjNsQ==
X-Google-Smtp-Source: AGHT+IHqgM++0d3OVNWimHfkLFXzfZdpJb4sdh0RBgovuWcrSSqG177xGNnpYgyLzLqRlaE48t6dzQ==
X-Received: by 2002:a05:6870:e38c:b0:277:f5d8:b77b with SMTP id 586e51a60fabf-295602a56e3mr3728771fac.32.1731080797202;
        Fri, 08 Nov 2024 07:46:37 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546ed7ab3sm1031801fac.42.2024.11.08.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:36 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 8 Nov 2024 08:46:33 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
Message-ID: <Zy4yWXTJCU0-OqMj@fedora64.linuxtx.org>
References: <20241107064547.006019150@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>

On Thu, Nov 07, 2024 at 07:47:28AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 09 Nov 2024 06:45:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

