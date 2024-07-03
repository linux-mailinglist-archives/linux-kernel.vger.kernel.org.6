Return-Path: <linux-kernel+bounces-239547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7909261FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAA11C2356B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3417A59B;
	Wed,  3 Jul 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="CS1o0RVS"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDA173359
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014036; cv=none; b=k6mzRASD9LNxBrv0y4VVrS1gaJkVmjTOd2wqHgWpolSi/XVyVeFZMMLGkXiBSlnA5SWau7erF9Gjwdwg1evX9SVn7hyFOLfKIkqxZzgCQ5Fkh75zDL3Xof0hqDv26DxXZ+uVsA0f0JxopK+ZiH3i+8SlieH4s7VKacLb+hLCV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014036; c=relaxed/simple;
	bh=v7wwnRICdXXjAY6LgmjAdX6RgRmXLtgDcP5J/fl0+gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSbJbRbbPP6qExvqMp/4PFbjozjUOoOZDueDyvEo7q5wRki99hGIruxZ9DIuZIaLeoYmsztRuyGN/oWlKfEj1/RCwwgagDPI5YBGQ/hjWppQ4FZJyDUp1ZMTLUZA3JVWYH+WUHd0Xy2TVzu39ugSPzBWZ773fdOmsWxJg+kzGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=CS1o0RVS; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-376012bcc33so21757945ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1720014033; x=1720618833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqM6xmAf2FrVXZ/POZdTnbDcUyqueEVyejWAoz1akso=;
        b=CS1o0RVSprk0VY9tkDAFeZp0hI0OJ43VCrlJ2F3Oq+1sVM01E8tYIXWlxRhXa67AcN
         a+/eZ9523MkeQJFbUohozgyQ5RAxjcvqBMUyc1pGd7ioLHxrE03bvzP5IaiG99ML3r0s
         JpO09CUK8SV+HflgRyZm8rHPcXH8ei5+4ZZ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014033; x=1720618833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqM6xmAf2FrVXZ/POZdTnbDcUyqueEVyejWAoz1akso=;
        b=gdOKIFOv5Hd4dP/OEidHSMue1ZbgEtyN3cHyPJoJ5EGlbk+/ASFmke5v1A4hgBYJpx
         iTrfOKR3+gy62qkOn6FbbIZH3ME4b0NN6omdT/nUFOysFMIBJkVT7waqr12xyY6xKO3f
         eFyuVMn9KpyV74Nl/7EPJNnOvLhXQaxo6LP5qXP7dKT5SB+OBHmla7lLZqVlb9hTbIzC
         9/DS6v8ZFGuvf66mzfiJ1To9DKeaD76LJ/1TIM6U3mJYYhXCjDNUmpQC3ezth2rLLn/Z
         Q3nEeD/vJUrtzX5M658De0z2y63z6Pr/heIGFqmLlT6XElYfAPAzr2zCULY5zE0SFp1/
         nChQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzh3N7D2flQGMXNZkWgMfMeLRC5/TAuFQHa4puoTitCKh6CCAR4haIpfb1dtf7lCA7dhQKPTD6xR6VjiGiA6hW1blhiqYVQ4rmOkr+
X-Gm-Message-State: AOJu0YxuXgoI3gqjzL8HQus2TT74mOMslHAt7/+Jgel4zw2Jki9MOFT1
	BAWPHXZYxogGtZ5JOFyWEVaj1lWMwjc3eC3WRqak4eNkJ5ZNG3+ALkB5tkrEGQ==
X-Google-Smtp-Source: AGHT+IGJTLo3uW4neYggrSnFI0GNTTvwL1bgoMUMB/opYf7ZK2wNJ8LlRk6COAdB+OwLjbazDn7txQ==
X-Received: by 2002:a05:6e02:b23:b0:382:3c83:6acb with SMTP id e9e14a558f8ab-3823c836c93mr16197865ab.8.1720014032970;
        Wed, 03 Jul 2024 06:40:32 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2f41391sm28762095ab.46.2024.07.03.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:40:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 3 Jul 2024 07:40:30 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
Message-ID: <ZoVUzgPfv5miFnWS@fedora64.linuxtx.org>
References: <20240702170243.963426416@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>

On Tue, Jul 02, 2024 at 07:00:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
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

