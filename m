Return-Path: <linux-kernel+bounces-378927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6329AD753
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308D01F23E75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464551FDF98;
	Wed, 23 Oct 2024 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIQz5bzT"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE91146018;
	Wed, 23 Oct 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721031; cv=none; b=NlCKnL3MfQKtrg20Xrqvl8RQPtnFBKcnmDR3IoDGHHeYe4t7iFxY87q6ea5fH7et7Rj+GRXoWL8j0dHdzE+bbxQ7aoG9LRqJmUN+qx3SKi6tdtBbpI8HDjlaUEJ0K4Jp+snONQJZq7qjDaJf2genwL84+ja/r5ESrMP7xHUG+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721031; c=relaxed/simple;
	bh=t1lfycE/DWIut6hycCrNl7Yzfnb0M9O3vdKNQxNNqEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgHefACEZ/2KSyUa0PExj10/3JBiko442pEICNAjs1Yx4Pe7g6pIgZs0HM+PElae/Yjzblx3qzXrVb+G+SnoMezNAl1UFH5tUxru+94C2MgU3l6j3F31nS0H6Haaem6vcerDB9NABSgin1mQ+/uXwDAAm/M5SBHgFQuzXJRDS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIQz5bzT; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so199374a12.0;
        Wed, 23 Oct 2024 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729721029; x=1730325829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Illz8/Mgt5yy8TSolHFSYf5krcuuL6vPI/ADO2VJjlg=;
        b=YIQz5bzTw9R/K4Mwe4B7ZIfOWsA/Pp950Hy4rU/SleQl/H9SOWVHJ6dOExLhe4gvYx
         71B8dG1aYf8VSYqFXmaJ14J7OoV0OADrykc3ONWTmB+jCwuQjUHeFbJGxUZH5/tECA8R
         X3lrs0FLGVEy356QfhxlkMfxsXPNqh3hn0CSWNoWnmpEadhQCqFKhLMM19DmCtOy0gvT
         tgUm//NrIyHN7fGwhNmkq7eQQurhR7HMW/x1ABdH+3op3OE/q9S43FCftQw98YD25DsO
         lO8Cec8feJG2DRSyaYg+OBel0yNh9a6ap1lF1MFdgEA7SxKjc49SFa4heQnCFMBQmlMI
         ZyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729721029; x=1730325829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Illz8/Mgt5yy8TSolHFSYf5krcuuL6vPI/ADO2VJjlg=;
        b=Fl45ErQPS4YHnGxCaxJ2TttBnvU4Wshp96GeSG2MFG7DhMRbN1fZJT5G06+NKgJJ24
         oSzVEkBiCaRL0+enxqIgE0Zdko4DxfXCOIDYXIkiILZF65vu1CRtNIJJyBmruEssSHhZ
         9DQ09J207IpE56B7LO73ScJYVFxoZV1v62yhfvCgOP43gEtakjAjE6Lw9aehzko5DhEI
         aWhEIwLKUhXtIBcxDzR53whp8Kj6MBXMJoDKKjRFivINy8+I0uZEnz+f5RMvXwhbQ/rF
         4asHyb7D4I53E8LwOLp/E0ewqExpvbmleaQD9km4efaOjUyf+j4fKZBzomxCawPq3tWb
         QyqA==
X-Forwarded-Encrypted: i=1; AJvYcCVjsdR5Qdk2SCG+Wz3MJbD9XMq89/J3v+hB3Y7jF494ZPqNrhxw8b6XHp+Z6lgt7IstSZ/LSaKysfuFsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ovxpwO9WFPvG7Y7iscn2KPf4y1q89oMtntKv9JGBdgDuqIUz
	sy0WE+Fg9VxDMV8JtqE5pDClOZMbHU0EzKqX+jIIrQWXmySXvPaQoNo/vw==
X-Google-Smtp-Source: AGHT+IG/W4RcMF2mNFYgXhQuqY1L9Wf4TePz7CXqAI4aTZ549NYLigKwv2zioxbbQBIFH8L8Dmnj/w==
X-Received: by 2002:a17:90b:4a47:b0:2e3:191e:7ef7 with SMTP id 98e67ed59e1d1-2e76b5dde5emr4339090a91.12.1729721028750;
        Wed, 23 Oct 2024 15:03:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9a67sm61860665ad.185.2024.10.23.15.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 15:03:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e78714f8-ab24-4853-99ae-4ace59ae25ca@roeck-us.net>
Date: Wed, 23 Oct 2024 15:03:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove me from nzxt-smart2 maintainers
To: Aleksandr Mezin <mezin.alexander@gmail.com>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonas Malaco <jonas@protocubo.io>,
 Aleksa Savic <savicaleksa83@gmail.com>
References: <20241023201334.250764-1-mezin.alexander@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241023201334.250764-1-mezin.alexander@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 13:12, Aleksandr Mezin wrote:
> I'm a Russian troll. So remove myself from the maintainers list.
> 

I will not accept political statements into the hwmon subsystem.
Please chose a different description.

> Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>

There are no "orphaned" hwmon drivers. Those automatically fall back
to the hwmon subsystem maintainers. Please remove the entry entirely.

Thanks,
Guenter


