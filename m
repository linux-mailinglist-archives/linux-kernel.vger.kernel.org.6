Return-Path: <linux-kernel+bounces-514047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B32A351B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A63A3A7BED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3522753E1;
	Thu, 13 Feb 2025 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="A3ZV8Ig4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A72753E4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487480; cv=none; b=IMAnAIdkIxgjjMqYzUpUVVFNYzS7ZeqaQc9v9bW1EQKXQwWgQNZOSuWrEoCmLDmgHpTaln4YZozoqvv0zHxoqZW83mkfq7vb6t19MtIVNGUh4Arls+M4GT3EhVUpgQNstGAVh2QSM1TjrNHiDGY+7hfXYNhGFI7Nw2x3UtBPveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487480; c=relaxed/simple;
	bh=Smto5Yxb6vav2wHm0QPt2rfaxx0mEaFrjpQZAsln/As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCHQOtRLfZiTBuwH+KkWTnB4aEHG7mriMCpkGGdCzPAmstkladPz8tS943b7UtAQUrURCDsZN8R8hpkBamqJKmXFnVdPAWJlsndF//+qpEHF/vM+SdxFv9VsVzj/yzLwZH5GGfDP33FAWGNS+xXSHqBhSefhRRlTSa+qfwN4mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=A3ZV8Ig4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-854a68f5afcso34178439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1739487477; x=1740092277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giMqNiydqfL6yBj4hJcOnss0/v5CTlMHhDcOLath6f0=;
        b=A3ZV8Ig4WDV5ijuWyUL2BwAU3PgJ5WHFcnrloyfl1vOYqdBTknPHqwJbH0c8RJwsGE
         /8iO1vsswiVr1EJOZAlrA9Ie6FqZHHkA8FvNlfX7chz/C0kKVzKTnbFsMZOL3N2rep0t
         mDp+uvnDuhk+coKCzgJdun7VCGR98KpoNMMns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487477; x=1740092277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giMqNiydqfL6yBj4hJcOnss0/v5CTlMHhDcOLath6f0=;
        b=dq0DovQYBYJjwVoPx2GlvXInaahnzi7sTSsRq7nsr/6xrDSVg4808nwlLb4rNcq6NX
         hB612SdjlKe+ViDpcrjW+RHn8t2uh4dHCrG1VI0WnRrUkwjE4QL4AcnWfH9HsEeCoWQX
         0henrJ4Bd4q5TsDbv9jiZ4YeER/hO0apl/SSkdHRt93ddJBytLmNFIITu9ze46OaNT1v
         BY+zCbdqocn9yxt7C1dQ4BByKyWuyW4wnzGElYmDrY860N8CWnB+mSTtJYifype0oa2r
         VcS1J+/mk9jzIHJVj6MfSbtTYprU29ZkMYWSuhFiRVgjStlGLb+F5GUsSSWFrS92JuFG
         /Y0g==
X-Forwarded-Encrypted: i=1; AJvYcCUkmgy4LN4WqEfzdLd7U+ZLGCnZREbRjYB/gIbX3F3smc0sR9u2lh3/+iv5YpFOfNHDdgVnkUbGdbfTzFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTrXo0trgCm81WZMOva5NrBuRD/qLtCv7HDgaE5JyfqX2qF/l
	2q0Y7Vcv0sGgsDrphBXLbIosn7ClwD9TQ7mRyTLVIQeA0Mgj14rf4ljBlDjtlA==
X-Gm-Gg: ASbGnctySwyoPw+pOJhJhKbIO1eGi/eAuhwCL6Sg0xvm/P+idDE2/zRT1bZtCxE6G10
	TrRf/Kz3KN7+7KL8FwoT/bTTYVz6QEuPR/rMAGgl0x7etxc2cXOhge0Cw2hL51AiNqSX6mFLc4j
	49AGgpNSQIMYF2HNv9B4X72cvB3tum9gIYz3+gWtVidhMuLusJRvjcl97G1j9bJOZe/qX9goxvy
	M4nJLCwArnf71geA1Z2Mbh4BnOugWSjugsaNsK53QhgxInCqThuiYx+7bEtqw0iCdij5eibudLL
	Iur4QN/HbNgSrNvs/qoNyHXjZkHsHGAY
X-Google-Smtp-Source: AGHT+IEzoq0TAA6AIhRAC9HUAPu5NTo0Qc2xIPZ91yk2fGKDrTwVk0kj/so8NbRnYKTQQLoBadEh9A==
X-Received: by 2002:a05:6e02:3989:b0:3ce:78e5:d36d with SMTP id e9e14a558f8ab-3d18c23b7f1mr50464215ab.12.1739487477453;
        Thu, 13 Feb 2025 14:57:57 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed2814883bsm538141173.19.2025.02.13.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:57:57 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 13 Feb 2025 15:57:55 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
Message-ID: <Z6548yfCM14jmgqs@fedora64.linuxtx.org>
References: <20250213142440.609878115@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>

On Thu, Feb 13, 2025 at 03:22:45PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

