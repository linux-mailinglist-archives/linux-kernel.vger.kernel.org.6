Return-Path: <linux-kernel+bounces-313895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11B96ABF7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789F51F25615
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DF1D0DDC;
	Tue,  3 Sep 2024 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Xc+MNUPx"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA5126C16
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401844; cv=none; b=UK11XG4HXOH+J9fdRdM+aU6Lq4qZQf5YmiiPIbDTlaatP4/Fp5eM9DkDhDCQ5jd3rLl0MGKEg16rX3Rby2NLbolpnLSNu8q6bre+Jhv6VqcdNjSCAUUZe6JhhgGvsf3mH22yYI1ueFrkVftUaBYOiVXcJI6wJvZmpnlewuUxvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401844; c=relaxed/simple;
	bh=ixiIN7Un+lKbuuqP82YDNbIrIqTLTw6W6vi/Xln3G3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4NybQMZg2UlmQAvPIH3darm9fGdqSwvLfemfBv+i6gDKTZ/Umro5iG1/Pcnd+ggOij4W6Mnq+y0NyAod6yEKPO4R+vzwf3+VXRutgB1xxsiPXkUu1snmnrMwbIxe5SNJtHKAuwRsRyNOnpEuNKYVaFACJCho64qLrmfJrnpm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Xc+MNUPx; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a1af43502so296751339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1725401840; x=1726006640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s38PvxZbBMTVGvQ0kbtSdyWDBrmSjvOO/03Z8xfaLco=;
        b=Xc+MNUPxpf3lC2zmYHaHEjHCDZ3jhq7yZ9iFYSWPZ2Hxqifg4jVtxbaC1rGPR6P5FN
         6ApZ9zu7JQOt8W5DtDPiFYyvvDZtrzirMRAwAXnQvsqY5mb0NPVpf2INrScDJ2S1EY8h
         OYb3SlmTsgJu5NHcEb7sOSrLA9K+z2yNB18Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401840; x=1726006640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s38PvxZbBMTVGvQ0kbtSdyWDBrmSjvOO/03Z8xfaLco=;
        b=Bcq5izTOEpM4abF7ptY1uywsgGFrxwFbPC5hdd6T62shYQdzVEczBBr1K222TfxKgK
         ri+gQKKqa9zhB0CWPrNEQg8fVGId5bEXExXT2dYueEBfnF9z7P+ES8vLkulo/CkekvM9
         UQV/E/K+Gsq4qoLXCVpnnmJFi/QH6OkJay9fdfwDDJChEB70gJZ8HdTx2kSK0NaByw4y
         KjUkbyU054+H9BXFwXSWyvlZfC1UZ4EtYtjog+SG8cFeRCySQb+FmzidM0lLSGsbkKTd
         Th8gQOpo0lHGPEPVut7wTZYDBTkEAMWujIjqcBXWDjR+77rcQJE5fZ8JKL3fm+i26U6W
         OIvw==
X-Forwarded-Encrypted: i=1; AJvYcCWA/n3FIMS9NffBOnXB8ddXzrT/GfH4203DMfAbt2COGZ22410C+ocz6qacafOX9l9GMx2MQ1oM6KbWV7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYp4Qdcn+j4N/wIp/MMl9BGhIq5s4xZYxxFKfEN7aU3ATz9Xt
	0P3j+u0UQXI7Rk6jiYhLUBFxDbL2D0yOEcF/gIPf1gY/DO2KvEgdTNsTFMFk0Q==
X-Google-Smtp-Source: AGHT+IHSG24Jh26pxj6oDOdaXB3yvTtI5BWzt2ZuQfpSpL2rvr53tFFIUcwfaMJpX+ZdObf03WdX1w==
X-Received: by 2002:a05:6602:6b07:b0:82a:23b4:4c90 with SMTP id ca18e2360f4ac-82a23b44d62mr1661524439f.1.1725401840339;
        Tue, 03 Sep 2024 15:17:20 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de5cf8sm2805547173.37.2024.09.03.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:17:19 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 3 Sep 2024 16:17:17 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
Message-ID: <ZteK7TVPmK09RSz4@fedora64.linuxtx.org>
References: <20231218135104.927894164@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>

On Mon, Dec 18, 2023 at 02:49:26PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

