Return-Path: <linux-kernel+bounces-310862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D5968221
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780141C222A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1052757EA;
	Mon,  2 Sep 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypZLShvm"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EE161310
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266216; cv=none; b=RJtjHlScydKuu8wkpRAeAm1bw5ORhV//kNUxm+4CEeutrmyYO6c3T/G6fMQsRYUr/u23UEZbb4Sg/gNtqQce4WX2uHRsSSOydA8A3VvKqC2c9GK2kcyaWe5TD5tMtwM/+OwBM38WN8WXJj107wxRwDA8C1rpHfAEricog6mKTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266216; c=relaxed/simple;
	bh=xy3Z9lAOzZ45z4zrLrPCPDOJApY6xNM5ad9KMplBiCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcoY6AJd8JvfXu7JTHsnytnkZsiKIKZA3Ft3EmnkT3M8QT+hy/fBOJJz78JLVBggfENvsa7DcqCw10q5wIskbA1znEHMtgl5AWLYJsa8x0+BwYxjFafSc6CLVEMWwfsgnOuCwbkkwq5x/o/43ec4Zz3scjRlaZjviPf0o2L/wfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypZLShvm; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-498d14b9b8cso1412148137.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725266213; x=1725871013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=izgwLH91JZbFLA7uRSiQZxwM6vVQO4Q8Uz2oK9o3XyU=;
        b=ypZLShvmkJM0+4sPsN77MD+MrSuOGoFMgSlgIPu0FxTt3FxM2VdZxLz5Iut2lvJNpZ
         2DnEwDT+OKbBIXepXb/2r9j+FV3K5n7QLfCoW1JTlxNcHqGryeqyLdFiWzOzePz9Lpwz
         YhOI5+VG6EacPynNhT7qBeVXA5RGGfTF2MiSddOApEW8PIQdaq0ZWt1YlbTkOoUexrZT
         ClN6Q+mrdThuNiAaSjUUwtYxZk7WiAVAPdFsoX1TU1xPnlQeF52vYcjZfErX3i1c9Uk7
         ZyJXs7L9flAGqIAMXd8QFJw5yoPrKS6ZA+D2Q5e+uQmBJaf/q/fbfGzIdcD+cDIhc4Yk
         oJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266213; x=1725871013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izgwLH91JZbFLA7uRSiQZxwM6vVQO4Q8Uz2oK9o3XyU=;
        b=EBI9sPUBUoz1bQrMrR5bLmNrT0xNp70tQ3kyctY7r2XpI7DaIMMNjKUQDvpBKxnUNp
         JRTR7BWHkEMv8GsXkyBC2yjUUjwhn2uICQtuOXQoyAQYQ9FVYP8vpiTd9v3f5/J1J8Ed
         09Pi3W/0bnbJYeQCcHyi99nkmPZVXNcxnEWX2aepZF1OgHKZwcQed3WQ7In22tzecUI8
         sJjKULo3KqKFeEOwshejvBEDFcPbOegRnvYG3MQMCKJ4667Nf6cl7piof8XzsOLOG1Fx
         QwdjK51o5ghIAqCAWY4RIiVh+FeQ7vEm+4JtoufIv8Ux0bmRM06HJW7dekXd0J9e4sej
         wilg==
X-Forwarded-Encrypted: i=1; AJvYcCUkq+ze7RQgXvtuYCNdt95Acy3xtQJXP2U8v5MDN9scBdRepZgOOj0Q26h7LmudKtz0BSDZOiyd+iIxJGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6q9GkYMkLA6PeSSjkwvEfbNCozjmhpVjYzhS+I3k8EpcvY6h
	qoiJMKtseakEQBeRq5xle6IZI2G7ZOJT54keJAuvMgLc3sFfZdZnsaKfrJR1tG5Yww5ChIzexVr
	wjlimZL3Pg0lXawmFsV2ua7CC6JBAGTeSCA6/eg==
X-Google-Smtp-Source: AGHT+IHr9d4uGJaINXYhlYol6A9FJjb6MMNb9yI6s2d5LmfEr5luCvl4+OTH0rW6lSrtvbYTbS2AdcEhIMsVx/v6eXU=
X-Received: by 2002:a05:6102:3050:b0:498:c875:ffaf with SMTP id
 ada2fe7eead31-49a5ae5b461mr17121501137.12.1725266213517; Mon, 02 Sep 2024
 01:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160809.752718937@linuxfoundation.org>
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 14:06:42 +0530
Message-ID: <CA+G9fYszuNTqPzsX7cw-2_7D0tFUMeroVKeza4gASmUEbcxcqw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/134] 5.4.283-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, abdulrasaqolawani@gmail.com, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 22:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.283 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.283-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc defconfig builds failed on Linux stable-rc due to following
build warnings / errors with clang-18 and gcc-12.

This is a same problem on current stable-rc review on
   - 5.4.283-rc1 review
   - 5.10.225-rc1 review
   - 5.15.166-rc1 review

In the case of stable-rc linux-5.4.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this to first bad commit id as,
  fbdev: offb: replace of_node_put with __free(device_node)
  [ Upstream commit ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76 ]

--
Linaro LKFT
https://lkft.linaro.org

