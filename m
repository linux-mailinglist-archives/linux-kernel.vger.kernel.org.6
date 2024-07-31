Return-Path: <linux-kernel+bounces-269764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4D9436B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D9B284CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E11304BF;
	Wed, 31 Jul 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="I0oT3N+i"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07554EB38
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455230; cv=none; b=gfR4KrhayfPMWhV1Qoosxn6heyHpqEpwmCz469s7f5BnVCEDS45y13sYZsdV6f8IpRQ+6m2R59MROhQSB9SXUZ1ysiflXM/HTnhJ+jl6xSL/bhvsX4VA053CEns8R0XEo62rVUDUhJeVgdFH2gn+QBNXC/qnz7W/GMg7tbOYMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455230; c=relaxed/simple;
	bh=68IEEl4T4i3Q+A1hsoS06kb7yEO9aKYPzH5dciEL+IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uibjb7nMlmWUGRwqg0E69L5ho07JmgNtd6egswope812jUSdUy5y/v8WB9uHHkFap84yu81zyaIPMWFRhkgAPiVV1/rvJS1qDGAwuvreVd3r7iIHJ8hM1KJB7H3nQ9Yi5Gq8ncQAkXBYOLqQgciDSs6IschpiaA0YOEh73CVkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=I0oT3N+i; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f905eb19cso311002239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1722455227; x=1723060027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9qmnQ6BfkDIeZVz78CLRQGm70nI1Qgca6NQE0QO5TU=;
        b=I0oT3N+iq2jKhfXcyLxLWYU6emSLTcmhzD9A7Q2etAiAakqcHItos3VXIRpUVELytx
         euG3Eku8y5vZACsiTkdqwBaoe8Yhc4Tw7jVPuMYJIhMTLqPeGi6M1IeJ2fvFsfE3xarp
         OFYEmk/Ng37ZrMlAAqjU9QbUk5juiU82NxzuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455227; x=1723060027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9qmnQ6BfkDIeZVz78CLRQGm70nI1Qgca6NQE0QO5TU=;
        b=bJu03K6FuQ1a17hbhlJOtznOeOtVOiSS2bNFSQiGV2THeB3NkpVxo/sIydRL7mBKqo
         e2wwLUcM5HIzr1dYh0Y8jqlLM9A910KU5A4fyAgAPi//YI4K+gcBDRbijP/nAU9QjF7w
         uQTC45uyDL2l5lvEVBWPRPbi+BEbfoipjpHR1idR/EzQwJiZ9z/4yYQyJqWLtbJtfESq
         1UIi/WPhNT5/5xLOjNZ4MjciNirBGu5tjWrFXFDiw1HoVSIeFLI5Pa9eE/dR6AaX4DDf
         n4Kd74ablLxfHkfRvVXrsyRMFqFdasIQH9n0tBRP2oJ444DeaZrFEJIHL73aHvGqxCIC
         UIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtou0C8pZesp8VzleXA+7qKldyfwucRtTgwH6NJOXpxSa3XIu0ysbHt8Q7ameZUtMjSBelllxJs7JyC7YO2lxQ1nBAKaChAktOxgjG
X-Gm-Message-State: AOJu0YwOlticOp3roEkzN2dpsHWC7CxCXXSqKrgAKYhcPBl1xQ+fGqrr
	ppSnvIZHfCCbrAMRMESWGA/Z3JF0xPFtFF7RBKvtmo0QrpzQE4dkn3A6ji/hwg==
X-Google-Smtp-Source: AGHT+IG408dxXKgXzbPbvVUq8CBwbTdlcfEckKAmt5cAomdh6fvurEijpX0Uy9o21Yku/co4S8HQqw==
X-Received: by 2002:a05:6602:6406:b0:803:cc64:e0bf with SMTP id ca18e2360f4ac-81fcc0e8c62mr40513839f.2.1722455227582;
        Wed, 31 Jul 2024 12:47:07 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29faa83a0sm3348439173.55.2024.07.31.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:47:07 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 31 Jul 2024 13:47:05 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Message-ID: <ZqqUuZqqq7O3nLbs@fedora64.linuxtx.org>
References: <20240731095022.970699670@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>

On Wed, Jul 31, 2024 at 12:03:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc3 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

