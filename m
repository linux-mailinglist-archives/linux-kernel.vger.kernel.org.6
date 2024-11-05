Return-Path: <linux-kernel+bounces-396705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654429BD0F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89E81F237D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63B14E2DF;
	Tue,  5 Nov 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjKuhw0s"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF113B58D;
	Tue,  5 Nov 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821658; cv=none; b=OPXBC8s7S7OpsCQYJARFEWC9y9OrT6WvGQoycndKwhOtsnksxWy+YjHREPdzGqfAM56wrYkbrixl5QgjZ3mq2HYTgIgITn9IJqlx3L/DgATh2RrnM45G+87NLVGKROtXf8fm8Z7Rm+vEaQn/s3hyxixO+me2HlYphPHjrcFp2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821658; c=relaxed/simple;
	bh=vgCiY5ozpuTeGR4a6McLnYueY0nOgTV4RX/IXwrQjyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LG1AXzCLHYPcdXpzYeYmBAKgZlNuX/xxtYSYxy10QGJVNs8dZpMvY1hEliA5oRQOoeIMed44PcY+cpl6A+BN4m18hBUmbLOuawu8PeTt02tkQJhqSFKRr3E14nzu4GiQ8yiPcoYtqdL8yVPMJzM5pcPRb7KwqHtPQMo+2SqFJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjKuhw0s; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso53557395ad.2;
        Tue, 05 Nov 2024 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730821656; x=1731426456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1ooJDnnYNEbk1kr2lCujUoyFBk6F58+aUycb1FL/7jA=;
        b=fjKuhw0sHYxDSd6SvwWOWbJq8EItyhgTGrkY9i1mdAi7O7NhpNoIeKvRxHtwGJA+Y5
         0GMW8Kn33d99+cRJGjvR0qxCBbrLqSoztZ4Ko7k7X81A50yPNvwSs3roE4iVmawyDMz2
         1avf+kSV62QpYxisFin19bpTcV6ebcY0Zi68S1ps5VcX6LLksK+b4CSn7B+qyOtZCsdq
         klckytlqoAa4CDBYUamFQj9pBsNJfM1GocuwBtOll9JnRgHMkwLlLciK0qq5n8mhcmQ9
         T4BLBo8zdcelAeNs+Dmj/XwugPhQglTHgiCljuCtM2k4jXlKbdDYK4jgdCpOJXNdxiXH
         CRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730821656; x=1731426456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ooJDnnYNEbk1kr2lCujUoyFBk6F58+aUycb1FL/7jA=;
        b=DUz5AZhPx3eFA1qaB/9NWw2CgJaGNzhacI8kigduyXiWjrLjOOICAcPrmsEL9azqyb
         RO+g05Lvo21NhY9o1mrEkQrjgMeO0gghJpXijbnbvtAU5BTS5oZIpUOIn9vEuS5+Qw8H
         8KJljh49urFfKoBkeOJZg23X9DFtDCaGkawjJsTHLO0XpKpJuDtf7ycF2Tw2s1c2YQOb
         ygAc0Xm5YRxrHen932PJ7VPZFa6Nue4oZCa8qg3uQ4xReJVfaO8IjWPhWf7NJJpSPmiz
         deFvNcE5UZV20adCLFQGgdpZFuVCg5pm1aU2btrWykMc2eTMyJxA+942PYcBWvGSFKZD
         Sx9g==
X-Forwarded-Encrypted: i=1; AJvYcCUL/Cq+82e8NeOVtUWGdFRWu05Gf6C6bfjuagfGX3Y068Pk74JUCZeMVqWHJhQJ5qYskhY5+SyhPo6m@vger.kernel.org, AJvYcCVASifkF0GAXn4Q0Zc6TJLdyY+E1qyk7u1GBYGS/01Z19BsA9+0GALcDfW5ktJDsguu4CSkzkkEpz+S5v4=@vger.kernel.org, AJvYcCXzfGtWoQ5w4SdXnzvThpkBYv7dTxHt2GmydsxKJZxG2IyYAXp8tExc0MYhd8BTb42/YjwpMRXPg68bdAoT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6xwabZOSAVdjoFEPjFdA0YIfJf6rxuyVBjwYJSwycZZiNpfA
	Itxmi2fksjdKeqoHQYdPbNE4LrsD3Lp3sMqDEYQafvLnC66LwSHE
X-Google-Smtp-Source: AGHT+IF9zcbwT3e7cLCiI/zQ31Uv++mbdyvSf96625AcWV9rKF0bSrU3s/WqP8Rl91+BbmZJqznG6A==
X-Received: by 2002:a17:903:2445:b0:20c:bcd8:5ccb with SMTP id d9443c01a7336-210c6c0610amr518053055ad.30.1730821655815;
        Tue, 05 Nov 2024 07:47:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2b83sm79133375ad.157.2024.11.05.07.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:47:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
Date: Tue, 5 Nov 2024 07:47:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com,
 sylv@sylv.io, linux-hwmon@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <20241104092220.2268805-2-naresh.solanki@9elements.com>
 <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
 <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 20:10, Naresh Solanki wrote:
[ ... ]

>>  From a spot check, the warnings seem legitimate. Did you send the right
>> patches?
> Just checked again. They are resolved. But I guess the dtbinding patch
> for the above warning are merged in hwmon-next branch & not in dt/next
> 

Did I apply some patches which should have been applied elsewhere ?

If so, please let me know, and I'll drop them.

Guenter


