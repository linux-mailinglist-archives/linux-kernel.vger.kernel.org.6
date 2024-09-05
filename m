Return-Path: <linux-kernel+bounces-316972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A596D7B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0FE1F21E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59B19A2AE;
	Thu,  5 Sep 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxS/x9r4"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F56194C65
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537346; cv=none; b=IlS/6RYc50aMlwyK9Vb80WTqs+du5RVL5ejeeOMyVszH6ZJ9P/Rugx8rxZN9SYcONpft7q3wLEVLoHKkqOf4r5Q7rN8RdHF652q9UNlG3MNpYkkjr3R60kZUhuTonmy+wwEZHLyN4rWxulcBXEjfTi/L3laov0Nd/823I1xNn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537346; c=relaxed/simple;
	bh=9NJQoo4LMVMggcZzkDEPcmdJE9FtDyLAQZGKEsY1FLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YimIWWfjFdbFmilpf4MSRfcXFOMg47kaIF95T8tA/zDdQT81Ftc007/b57jjxE35miKmuw8PjiRC37J14R6SsNAXOrSmrHMUshKC3AAKZjfzKmuD38sxP8lfiECWYJqstLbseB89A0qvGr0HVV7giq6Vnz3gXYWsUhybdK4EpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxS/x9r4; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-846be74b299so201890241.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725537344; x=1726142144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qRJcGcRJNx1TW5diCULQtEUQCwcWsO+dA/2EMfBnxLI=;
        b=dxS/x9r4fnXUO8Sd5c7lzNjpGSYaqpWkZGldn49M6EKrgg9irH6NeVlzockNfDLKdM
         /PNz599PPijG7w10HNPuKeyXprzt+X7iqyKCjMYW8DZrMSbGrk2QjLJSVu/CWOcgFtgT
         EuVtC7ObXY+dMuSszgD1w+3P7xZoXCUILWXK+brkyb/FWnM79D7EbuqiuI7U8SW8YhMa
         iMIngGBBBhUGyhIYjIZbgkTQJwZghczrY4Jc7e5/X3dwHV57YsWjYjH2d2doj+EIcW8C
         yD5U4pTX0xbOuNztVgrk8IaWCqWfdXsB4E/DNqqEBXgV/60lgWuboSOhlFruEVsf16HA
         jNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725537344; x=1726142144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRJcGcRJNx1TW5diCULQtEUQCwcWsO+dA/2EMfBnxLI=;
        b=nL+u1ldsY3aGwb6HHetK9RCttlyPZSIL5DNcw73kjnHo9KpZFYwS7CQ+HIQc+sy79d
         5oudSjciO7NNWicApilnaJBufUU7HeubnA+AV6n2mgcY5zhSjc1IZZLGTUdIBfrycwAv
         E9WvABDJg4TQMRAyf+/+z22pmdCZ6Eh/fmhDTKFjYUKTanb5TJctR3ke0eJdLzjQlVVo
         a4Tj4Hl/uCI9DOt3/kOfMe0mnO4gaCAU5YqM/iaG4MKPvJkM7f/T2WMs86IE2oggOuHP
         7TctbIg7pr/Vlf+psoJ2k47k1jf6lYtybNH2vX2zXHg9fS8s3vnyG3BILO7gD04gIuoN
         mb9A==
X-Forwarded-Encrypted: i=1; AJvYcCXhQHOkj8XAohcOpSMHdDY4aYfX027hbx9pJ/0bXpcG8D4o6ayuFALws5fZGMIwmvnxf/m8RIPwJ53dJAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9v+/LmImZ35lhvlpspCh8MciO1uP8gyNBYqJ6NfRwMAB/T0ou
	vSe1WT8LUZHWH1YOg7d7Kpn/pp5QXFoG/Wntyy4EE+JyKdKpq2lP48DooD/P640Av4KXLhuRI88
	2LezxAeppyw3jo5RG3eJAsv/r11kM1XWpSb6i1Q==
X-Google-Smtp-Source: AGHT+IF81MA398iZ6b4Y3eucXQLIDL+C3dpW3/7905P6ameFiZ7xV/TUXSEnEfZ4bjIqf/xqhw7rYHJecNOySvu0Zrs=
X-Received: by 2002:a05:6102:26ca:b0:49b:d24a:6860 with SMTP id
 ada2fe7eead31-49bd24a6c82mr1314728137.8.1725537343801; Thu, 05 Sep 2024
 04:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905093732.239411633@linuxfoundation.org>
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Sep 2024 17:25:32 +0530
Message-ID: <CA+G9fYsppY-GyoCFFbAu1q7PdynMLKn024J3CenbN12eefaDwA@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/184] 6.10.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 15:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.9 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors noticed on arm64 on
stable-rc linux.6.6.y and linux.6.10.y

drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_advertise_quirks':
drivers/ufs/host/ufs-qcom.c:862:32: error:
'UFSHCD_QUIRK_BROKEN_LSDBS_CAP' undeclared (first use in this
function); did you mean 'UFSHCD_QUIRK_BROKEN_UIC_CMD'?
  862 |                 hba->quirks |= UFSHCD_QUIRK_BROKEN_LSDBS_CAP;
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                UFSHCD_QUIRK_BROKEN_UIC_CMD

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

