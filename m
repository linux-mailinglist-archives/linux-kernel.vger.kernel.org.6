Return-Path: <linux-kernel+bounces-222084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94390FCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEEF1F23B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2F3B192;
	Thu, 20 Jun 2024 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiW/LrNz"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD52B9B8;
	Thu, 20 Jun 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864428; cv=none; b=k3FbSkctE9JPcjtnnVJXs9Yi6NSkz5er9eJEsuonUHWYEhbS0Oh7FnuJuXxE3Fm6UHIX7od50DbZsLuEoAlN7Lku91T9xH9Q2bSsNJ7MNNIVj71ls81LfMLH08A7hnit/ANQgbJRTI2Qa1TWPbjH4Fp52/u6OwvxuWX5ZrgIgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864428; c=relaxed/simple;
	bh=B9CJ2ldY8jyR3pzSjSlniJHxFqNSRSw0UYOPYmsbBo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9qsWx5EeCwEhPM1a1JDrE/XVkc/p89DcSMq0HfqJ7OYcZeq8GqWTqKlo3NO5piMb6eAtqhIgaZYDLXoOGHf+g4neKVOsAdtIlrrxf+Y/uAmoXTS6cSfGZt9CDbt6UtxfR9WlhwR8vjCVVrzHd5X55FPtoJVfaWEhxB+1dU7KeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiW/LrNz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a5344ec7so4068505ad.1;
        Wed, 19 Jun 2024 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718864426; x=1719469226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iItcsmyQwcrNCTeNFucD5f2cULIJJ35ZnqQXtxgaW1E=;
        b=iiW/LrNznVjEMrWEGka4+ciGI0pcEn/pnJkjVPuACrQcTWcfbWw3dcIyH72NxFJAJM
         QiSiUC/4BlAVfNbcnqTCpReceNdvDfuWTfaWsoi/ON+y9lCaVHnoPb/hs7zyQMMvOK/q
         ww0kFA55Kzl2iOwJkFd3ajw1z1duPSv+gLXg0ETBWcnL1hFtuVrZmSZkXWAWsRT54c3M
         graDhwaAzcQ4Dp14LceWXggjbMV8wex1B6f3iKv3roYdHRd9tx1MuDqEbk5trunCPkbC
         TK65MINIXt21gvf8nLDLvcJEqXIiNDh75J5/jpVnuBnEV4z8gfmZdGzsN23K2QydQ3A4
         MRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718864426; x=1719469226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iItcsmyQwcrNCTeNFucD5f2cULIJJ35ZnqQXtxgaW1E=;
        b=AOjtNlJp/VULWKnXFmn5/3ByNHPOB5lxojfTzTndaMLYAU0z5Z9wgCqjooVLr1LK8w
         UrcyAEpLbL7y9qWdNMZQJ+i8UHKPKBGxDcE3HopY/xu11CDfJW1vJbo7+gzsRHXQzn1z
         qe4ULz+SYJ4d28ZItUXDhNh+72bN+n4A1LbS/VMw07FpJR4efpFiGEIHcdnH3QQ/Ytx7
         N3SXlPYh9bVbUsEfPBxRzSSHJrke4W6XCYe8jeSnS0EUFZvUIIcbL+wJW77+Vw+0uZCd
         /0cHqQsFjCiMEJ0Tzopd9TzEQ7d56e7nD8MehY5e4modxWfTjnEUAK1Bp2izyAVc606C
         4cbg==
X-Forwarded-Encrypted: i=1; AJvYcCVfD9oayUsLOcTMlPkjESmhU9WQlkE11Zv7BPgNSst/stFUPwvDOIsvvc+kqmXKSs2bSfLh1E11G4CPgVLfhpAh5SfnD3D6aEtzCHFyaKoOMcz/OVUmktZFc9sNvIUBwADsKZC4UdSs
X-Gm-Message-State: AOJu0YwSOenDRaS4hx1/cygXZpY7forVOaAjR/ApoWH3CmD5keqtWzJ7
	O+YTPco1GO+8wFxZjQJd4R7Y1ZqPXvuAV5Z/KT7kMZy3vKO2If9GLLzFjw==
X-Google-Smtp-Source: AGHT+IFHg5Snu7tfRJVPHnDTks68fuDxJmIVRSzZ4FhE50qhVAevn/TH3PJgef0e4Ocxq4QeKoqACw==
X-Received: by 2002:a17:902:f545:b0:1f8:3d2d:d9ae with SMTP id d9443c01a7336-1f9a8d5de27mr66807255ad.18.1718864426104;
        Wed, 19 Jun 2024 23:20:26 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4aaecsm128521675ad.284.2024.06.19.23.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:20:25 -0700 (PDT)
Message-ID: <eb13bf49-aaa3-4898-8161-cb0ea74dd2ed@gmail.com>
Date: Thu, 20 Jun 2024 14:20:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst
 translation document
To: =?UTF-8?B?6YK55rab?= <wodemia@linux.alibaba.com>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_6C54200469B1518482F88605A0980FBFD20A@qq.com>
 <5f6bd005-81b4-4e26-ae43-803448a0dbbf@gmail.com>
 <8BF94CA3-B91D-462E-A5EC-A4CCAFED4B9A@linux.alibaba.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <8BF94CA3-B91D-462E-A5EC-A4CCAFED4B9A@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/20/24 1:10 PM, 邹涛 wrote:
>>
>> s/在有无内存节点/存在无内存节点/ ？
> You pointed out a readability issue. 
> 
> Maybe "在包含无内存节点（一个节点有CPUs但是没有内存）的系统中，xxxx" is better？

Yes, the new version is better.

Reviewed-by: Alex Shi <alexs@kernel.org>

>>> +numa_foreign统计数据会被严重曲解。在当前的内核实现中，如果一个进程偏好一个无内存节点（即
>>> +进程正在该节点的一个本地CPU上运行），实际上会从距离最近的有内存节点中挑选一个作为偏好节点。
>>> +结果会导致相应的内存分配不会增加无内存节点上的numa_foreign计数器，并且会扭曲最近节点上的
>>> +numa_hit、numa_miss和numa_foreign统计数据。

