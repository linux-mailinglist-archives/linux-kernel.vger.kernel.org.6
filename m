Return-Path: <linux-kernel+bounces-342858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0F9893AB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FAB1F2104A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4570139D13;
	Sun, 29 Sep 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmcEibTH"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5E29CE8
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727597347; cv=none; b=ggJMboYwgvsiFCFGUd0kv5RJuvTKxoro19hvFgUKdkk+94ltx+HL0pKo/YMisUoCyIziCdTqSC4eURXM1fe6Yy9fRZe4EawtBI4SasNAOHvXvMqXlFgpYDOSVidfepoOcLKHtbjozRcbka8AXMc5edMi++sXrpFQMAJrvS0Ncpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727597347; c=relaxed/simple;
	bh=jzHY69lIb+9jsGbG8mxU7XqMRo9mUFjmUabiFwQ8Ka0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XH5PxgFjOzH4eDDnDTg8Xa1HHszq9YsMiTtc10Kra+alDRafscaY3VILxeWN8BnpMpOLgHdtpmxsbCx6XB/yXzd756qKlD2eRjiPEZqpam5Fx9sCy/IzquKtO5HrEj72DWB09dIjSHgNk+hY1nX+q7jOqdPqKyJZ6iUueE71KgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmcEibTH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c5b9bf9d8bso2327564a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727597344; x=1728202144; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncTEfn/J3adg7zNOcwO7BXMI957A7O4ashcbmw3A9C8=;
        b=KmcEibTHABLbAM+wtzjsZay/Ef58wQalvrxGfYbXJnmYX6bfGodiFN3e2LgNnVQCrI
         m5I9AW/mT/cmqvpDBvkjFMGgJRiEFggY2ffoWsgZCLnu1b+baKjwbmpusHULb6VmC5gQ
         A6jBUvljp2zyO/lukHmwn1i92nuJtr1AZ09Koc1wqjp8k1iK7alPRdvf/aRAgtuwnJyn
         mtsqBsWVcqr754zjFvxeB/NgHP1rip/O5qMbi2TYxhPRCSqbfyt7THVj8GXAw291c9kV
         IuWkBvYOCtIdev0yVZ3M6aBk9ZaEfxWwVQs77TZD27DGAsRJmVCtHnevH9w1qJw3Bacs
         DLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727597344; x=1728202144;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ncTEfn/J3adg7zNOcwO7BXMI957A7O4ashcbmw3A9C8=;
        b=fOGczDXhzfdZjP1sTvHXTNo+jMkcFkWu7kEhy9M4dAt7LwCQWn5l4oHwqy90De18zF
         IT8dT8a8NoUkWe6Db6vdAWNS+Na8UVb8+OwbCOrAkrL4WKyNmDAta1FbDEkQp4E7Kl2l
         40M2Vm9oWVJzVrLXYJFx22liwD/KuxbuToF3qPM46Xo9NocqqMwB+Do+HWbKctuozhxX
         o5oqu7N4EYGA4cMqLJMnGBWwbjFdQBA+Uzy+dcmcA2fTdEKkBX88IVDdrL5lpD8/3WOV
         1fDtNHkqogakyBuOWetE/kneruy0DVRGc0wpOsBTNrO14LeScoRwCNPmdaptiCI9kgYz
         xgpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBKua99dUH66ET8/pGrSVGoB04t5mILICuO3iFhe31rd9dZ9fjlaXJ9fEErOF4LdGz1bJDYrsEjg1b/zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1LqBZZEsrMUIf7EHfzLtyPETsu9lTb5B8n9cFT9Kf9HDOHc0
	S7i3p8az5zRchOQR8Z7ApatYYc7H7GZlD/ZnF9NE0PSWykVuWv1k
X-Google-Smtp-Source: AGHT+IGA0Gk199O0Gp225ZmQIkJW6v8jjQwEmZbn/hsxycrGBq2sbN5GsdO8D1nuoUcuwNb24qe6IA==
X-Received: by 2002:a05:6402:3813:b0:5c8:839c:734f with SMTP id 4fb4d7f45d1cf-5c8839c73c5mr9964380a12.18.1727597343558;
        Sun, 29 Sep 2024 01:09:03 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882493b74sm2922927a12.79.2024.09.29.01.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 01:09:03 -0700 (PDT)
Message-ID: <718c0476-c4bc-4a72-a1e4-483697c7eff2@gmail.com>
Date: Sun, 29 Sep 2024 10:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Tommaso Merciai <tomm.merciai@gmail.com>,
 Richard Meek <osl2008@googlemail.com>,
 Larry Finger <Larry.Finger@lwfinger.net>, Xingquan Liu <b1n@b1n.io>,
 =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Pavan Bobba <opensource206@gmail.com>, Malcolm Priestley
 <tvboxspy@gmail.com>, Joe Perches <joe@perches.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] staging: vt6655: Proposal to delete driver vt6655_stage
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,

Forest Bond contributed this driver in 2009.

The following points let me propose to delete the driver:
- This driver generates maintenance workload
- This driver has a maximum 54MBit/s as it supports only 802.11 b/g. 
Peak throughput is 3MBytes/s but this lasts only for a second. Typically 
throughput is 1.7MBytes/s.
- Depending on the number of devices on the channel the device looses 
connection and cannot reconnect for 5-60 seconds. Watching a youtube 
video is OK because of the buffer. But surfing can then be really a pain.
- Its form factor is mini PCI (not miniPCIe) that is really old and large.
- Hardly not to buy. 
(https://www.ebay.com/sch/i.html?_from=R40&_trksid=p4432023.m570.l1313&_nkw=vnt6655&_sacat=0) 
only 70$ ;-) including shipment.

Former Maintainer Forest Bond <forest@alittletooquiet.net> is unreachable.

The staging subsystem needs to focus on drivers that support usable 
hardware that is available. Newbies can then get the hardware for some 
dollars and play around which is fun.

Please consider that support will remain for years in the longterm kernels.

Thanks for any response about your thoughts.

Bye Philipp

