Return-Path: <linux-kernel+bounces-305476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CE962F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EDD2821D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406481A7AE4;
	Wed, 28 Aug 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="g9iA02w+"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66631A76DD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868288; cv=none; b=YoI2IR0wucAkAmBuvOT1wnxmeqbFyqlek3L3nX9TjVOnPB7k++meKLaVyXm/bcwrUugdMe/VoSnzeEjggqpBJajuDWANYBfuSWR+aIDvqNHnWUwt5su5fNjCw06skY5wXXlFyJwSDVfeNfA/fw+IiGhsj8MVhgDX3k3sge4wV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868288; c=relaxed/simple;
	bh=7LklAEbtnglm2QqbJRXoOdk5le0yekVD8FpktvgUQ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP+ntgfaXVfKckEEuDN2n05ZrjEPE8lrfLlGtRG8BWH2c+Qt7TXS2fg3zLBgvrGBWtMsHPgUDFXC4aN4M81jo9fSGFQiB+K1NkhLOIuKAwtzPZg7iYif0PItTkTFqIq7wRi5kC4KSUSKQOikoSd8781ZD9d2HVV1BbEUOw4a4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=g9iA02w+; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-829e86cb467so137814239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1724868285; x=1725473085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D88RxHw+gLXI+BUbdOUTeiFUlCwvolVuRzDJ5llIRd8=;
        b=g9iA02w+gnkq/9Gcd8YoLDYbuK8UasKWfDeh8xwi/77mBkO0jPCwrXyOAjUMWa9uek
         P6dYKRUJem/9WmdDH1MQoH0He7jWpCmKEPXQGq78kN+aRydcNjxY86bl/Id4QxO4urCr
         6DwpIEIsUBCEMc0og1bYjjjEKDQtGTRwsa6kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868285; x=1725473085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D88RxHw+gLXI+BUbdOUTeiFUlCwvolVuRzDJ5llIRd8=;
        b=PBnWCCNpLBoOdoCzIurg3sHMPWNDvq4EPWaAD3IdBxNpbc2MCeLVUkCDOp6d0EEPig
         jfYyD92DtI4R+G2UB19mKWxoH03smxn/apUW1Vn2keS9L/4RDDBCs/7jc13ExI87cGRu
         Eij3QiUmYPvsrGYNuSzKR+ssrAbfdMxriZCBp5+VdZs9jMbOmDBIxQYYvfk3FFvN2PsW
         qlBQzAIbLj5OHu5veQY/UeyN7Wk6lz4lBfhpYbB7F+puygZrMqLtncaQnMwWb6P232q5
         kMbJLZLbirx2gAFuACzppiennQId1rwVBsHkeOhfYKt/Gpl1Qr4//OEraVanoJiWSD9b
         QPlA==
X-Forwarded-Encrypted: i=1; AJvYcCWieevnaNKVoAT162hITqG83owOXNfYjeoCKG4OdDLNqt9ExizcFdQFUL9d/WYq0ca8Ql9fllJRNDvKD98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXAQ1SweIfW7esmh36nU0kAHrlOQ/PNWKK+u7UJ9JfUEisSVH
	OedIA1mtxUC6lq65aXIKrYPorpCqkPAJzPwDoIXb89g42ohUuzCdg5JCicfzp4rSPrddc/gO/sV
	ZjQ==
X-Google-Smtp-Source: AGHT+IFD5bWw8dwybfSsYbERZ4OkMGlI4FfFSwejbt9P+LhXubeZLqrOlKHFBCJir/bc35aQBU9JSA==
X-Received: by 2002:a05:6602:1487:b0:809:83e3:a35c with SMTP id ca18e2360f4ac-82a11036779mr46952939f.7.1724868284479;
        Wed, 28 Aug 2024 11:04:44 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f1fa89sm3123229173.16.2024.08.28.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:04:44 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 28 Aug 2024 12:04:42 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
Message-ID: <Zs9mus6WLnij725m@fedora64.linuxtx.org>
References: <20240827143833.371588371@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>

On Tue, Aug 27, 2024 at 04:35:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.7 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.7-rc1.gz
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

