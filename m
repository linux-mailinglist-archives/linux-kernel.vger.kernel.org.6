Return-Path: <linux-kernel+bounces-372662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264AE9A4B99
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90F31F2287B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BC81D5CF1;
	Sat, 19 Oct 2024 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGSmcD13"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9D17C22A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729320343; cv=none; b=YbWZDacamNO7ZdY8fbaQphXkYpsljxz7hPyIBFION55+ZwyXitrVEApIiLnbpGJQvHpp3E1aigus3Ey+0zCYdJkg17v5C+EfQPwzo0+IO27Um/SFSAgPREh5/YOn+iLgjd45jFUf14WHzMRlSW9uC7fNwz4LZCYaDuBKA+tIz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729320343; c=relaxed/simple;
	bh=wTUixt+BbMqQ/Ysusg9cMMvxAyJMxvwCB9wzUw3vUIE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=kE9Da/V5wr4oGbIaG7i3th90xpwa43XXbAzDOxYBopDSiWH2NAPQe3+wdXrlc4eGnYwuECVLIOfHn+chUYZrGtsjxqY7TnqZE4SuU3CmVBmohATqMDlhoGq50VlRp4gdEepQUYxRKUHZCV/ue1Cjs+bEXaB2K75QynVS44N2pgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGSmcD13; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso3048408e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729320340; x=1729925140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/xBFEYk5+1PnZWk62QbDei5REpQoLrsRgMuFoSkY2M=;
        b=WGSmcD13gFOwi54AxcUsyC8zYPgV5Ya9B66dYK8Xpvf2D1nTBmyREqU716zLXqf3Xa
         APduqQ585YdMCg2lrCxjvAeLSNVgzR+SzE4ACcXyUz4d+DARFN6RAEPf1ffFni/dgjP1
         HU0rpFDc9iT7UBgAkqLAZjuwSsAZlPqzZQhohGSxZc/AXZ0/sv/H3lNgMWkuD51grQBt
         67Zj9jvdRVE0nqeeKh1P+0ctqQ1xXrvivczDUIvJhFG1iUS7nSR4rQYoYGUgZ7cAseQ6
         Yyg22pIXKy3CaOzIINJ6Mlpx89ueYQHg5fQ6hLRU+0ovmps0I+yP5Jw9RbDzljlk/zTM
         Dezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729320340; x=1729925140;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/xBFEYk5+1PnZWk62QbDei5REpQoLrsRgMuFoSkY2M=;
        b=K2dguiNZZjZqv3wRooi4Z9+MpF5zqlXxMyPmGT7qzC4cSj/5IcepuX9xFRnLXSoC9Y
         F5gCU/Us3bABBdB5MV3O4HfdJTSflwUfSr+Z/80xXDL3rkmKOYKypFgt88Xh2yfYehvD
         wBh9HPp9kfAEY7BY6Z2OiHwYMD7YQz2a2UXDjCoWgAGCJJtQ40dE2rzpu4CN/l3nhOLl
         gYBXzwswcHxdrQ2SHrcrfQd+JvIZyjr9cQzBHS0lmv9YLzP5G8MGcP8B9aXAZrvOWNyk
         EA6Vu7HWKvnuKjf52Dz6RG5iU1L90u41KmtlTkRLMEwvfwhjPuRlrJqI43ERaPT8rprD
         bAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf19UiHUiqo89QwwAOWwMhwh2yTNqGYo48kTuFs39UJ6IDNBPueK+sCByUssAH6fwG0aX87sTflL4R5W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC2pxlTIv5khKUZ2vwDkxCh7QK3GKuqJG2EmjDZMfsVY3ISlo+
	+E9f0/aFUURTThFvAwv/11gOQ7rxylBTBhIZZ8FwDSMdUlFg6b0D
X-Google-Smtp-Source: AGHT+IGj+oVaKApjcHHkZ5rbaWGEk7pnvLlMQPmRLcjNNo1A92fJ0dMwx1gGK6vOZmivsNapG6RqWg==
X-Received: by 2002:a05:6512:224e:b0:52e:9762:2ba4 with SMTP id 2adb3069b0e04-53a154a9eecmr3025761e87.25.1729320339483;
        Fri, 18 Oct 2024 23:45:39 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b076d7dsm1519593a12.14.2024.10.18.23.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 23:45:39 -0700 (PDT)
Message-ID: <96ae2b42-c0ce-4d9a-8933-eb874dc5589b@gmail.com>
Date: Sat, 19 Oct 2024 08:45:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] staging: fieldbus: Proposal to delete driver
To: Sven Van Asbroeck <TheSven73@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Ruan Jinjie <ruanjinjie@huawei.com>, Zhu Wang <wangzhu9@huawei.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Deepak R Varma <drv@mailo.com>, Ajith P V <ajithpv.linux@gmail.com>,
 Tian Tao <tiantao6@hisilicon.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Ding Xiang <dingxiang@cmss.chinamobile.com>,
 Jing Xiangfeng <jingxiangfeng@huawei.com>,
 Cristiane Naves <cristianenavescardoso09@gmail.com>,
 YueHaibing <yuehaibing@huawei.com>,
 Oscar Gomez Fuente <oscargomezf@gmail.com>,
 Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,

Sven Van Asbroeck contributed this driver in 2019.

The following points let me propose to delete the driver:
- This driver generates maintenance workload
- only 11 patches during the last 3 years. Part of the patches seem to 
be motivated because of maintenance (for example - remove deprecated 
function)
- Maintainer lost interest, last "Reviewed-by:" is May 2021
- no blog about usage of this driver

The staging subsystem is the way for drivers into the kernel - at 
current speed and interest this is never going to happen.

I think that fieldbus is an interesting topic. But when almost nobody 
cares about this driver, it does not make sense to keep it.

Please consider that support will remain for years in the longterm kernels.

Thanks for any response about your thoughts.

No response will result in a patch for removal in 14 days. This time can 
be shorted or extended by appropriate comments.

Bye Philipp

