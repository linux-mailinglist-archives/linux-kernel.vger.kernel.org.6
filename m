Return-Path: <linux-kernel+bounces-329092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D251978D30
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0579B21E36
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0F175BF;
	Sat, 14 Sep 2024 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnZiuIej"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518251B964;
	Sat, 14 Sep 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726285662; cv=none; b=tDemftdUtlkpYf9ayLwl7Bmbuj9Pc379aDAO8b/tui5N2oeNCqEjNZ/k49iLPhWyAarOU3nXJCKijDdeXglWctK8l2cXcavejBOU2znzrqghprgVzqAmX9vhiiOn3UXJCWyx6g9c94+s7Dbvgh51aWXfduFVXEEf20uIpoDMEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726285662; c=relaxed/simple;
	bh=pFH2oVQMOP6KXHUNI17BgtBd44onxVMFl9/jEqLmuEg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ApSfThgK9fKJ8GWsxckrgH6lgMdrAUpq3vZS08vr0BfHjPrbfi8NQ7N7nQXwQXWx07X7MISFLRwbo2ADwnAcp0XfDJeMEU45JwosRIPtmsA7jmVfBL5F2AwuNTLOdtsNVomlPy/Hx3H+wEUi9FU/jT2DlpUKfj+O3jRZSMsDLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnZiuIej; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-206bd1c6ccdso14354615ad.3;
        Fri, 13 Sep 2024 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726285660; x=1726890460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/w6egkoYxdXy/98m068U02aaTBghut5WCy5SzQeOFU=;
        b=dnZiuIejW13i5uaRwutZnwTTg+54rZK3oE0FGeDBhNJPANMahBy0NrfK2vu2eeS797
         oRq/6RfhzrrsNlSKX2pzCFKQmdFgripdRiVDj9+q0t9i61xd/AYDaH2N8+tGRLSKiu46
         yz2FTqoBT6N8T2EqlujJp57m2YrcsjeTCkSr+9OF753O1iKkLgRCiqwHm6aHWd1dni1L
         gMey61tCnQM4d8MBiCD5tXj2t8dn7/vcqDwu1ftwMXABLBLyv1HQAoekSw+hGGJ1urMJ
         polXQ7pEWq5j0jMcz4BKirxGqtFdnSMX9D6oVxj0QzRaXHANTEKaKk7GxvqA4mctuAP8
         yZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726285660; x=1726890460;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/w6egkoYxdXy/98m068U02aaTBghut5WCy5SzQeOFU=;
        b=tpM7NXZ3L4qaA7x8amgXwOW/0sH2pBOf5+9sxWZZBprYyof9NISO4MkMy+ySo7qfL8
         6XV3ljUVNgydb7JYt3b1PF1Z4/iUuC+LEJ014wWdoc5Il+EQpK31Rj1Tipsoy0r7nv+o
         guPR+e1ou6y/t3YXm5pQ9roelJklbOH0Vya3b4oPx8hc3h1ZCiR7h0vX+nKhMXmQLs1i
         iJtYkqhfRbB3sag388HwW9yrq1FgpRAHqGhPUTULFveYLLjCEh6IgEJxLe1mxquOywlj
         zcRFVpVWVtAdGHC6pxQRwDTn1UPGQM6KmzLBBh/frI5eHt595yaJtn/Qx4FOFHrPbzaW
         3xDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8F2UuTEqkd0k7vffxEpB2HQTdkdEG2O/qj/llOePS8D3BNE8s95ZU+yAR8JmnZ6DvZxKzHjW0nnkoZgls@vger.kernel.org, AJvYcCWq/mJN0jP8jGEw52EBUo7ZJwfr21FgHtjMBUo8MLnpn6TSovfgrg9KgRNqVFd78T5Pfy34ktF1F6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjZEdAXvRwiX+p7mB5GiTlNtBw87yjn7o+LgDdSozQoL3njUa
	LOtkwRd/X2rpoTs1pzPKhjaCiF/QHtZnlBl1InLSqbW9YSCNtX5hnlFe2g==
X-Google-Smtp-Source: AGHT+IHY5Kbr/IxGld49diZlQVX4pMVOcXPFBLNkf33nVglaamhRITFoVjShjgLO2nhMJSxVzsspcA==
X-Received: by 2002:a17:903:32c9:b0:205:80e7:dcab with SMTP id d9443c01a7336-20781d5e224mr70535435ad.18.1726285660471;
        Fri, 13 Sep 2024 20:47:40 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946010d9sm3031995ad.65.2024.09.13.20.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 20:47:40 -0700 (PDT)
Message-ID: <2704d2a7-b2cc-4586-8608-10aabbdb91f3@gmail.com>
Date: Sat, 14 Sep 2024 12:47:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: corbet@lwn.net
Cc: alexs@kernel.org, chengziqiu@hust.edu.cn, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, siyanteng@loongson.cn,
 Vegard Nossum <vegard.nossum@oracle.com>, Akira Yokosawa <akiyks@gmail.com>
References: <875xqz39gf.fsf@trenco.lwn.net>
Subject: Re: [PATCH] scripts: use ':Original:' tag to locate the origin file
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <875xqz39gf.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[+CC: Vegard]

Hi,

On Fri, 13 Sep 2024 08:38:24 -0600, Jonathan Corbet wrote:
> Cheng Ziqiu <chengziqiu@hust.edu.cn> writes:
> 
>> Simply substitute path may cause file finding failed
>> if we have a different dir map for translation. The
>> ':Original:' tag could be used to locate the origin
>> file if both the tag and file exist.
>>
>> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
>> ---
>>  scripts/checktransupdate.py | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
> 
> Perhaps we need this, but I would really rather move any files that
> don't conform to the English-language directory structure.  Having them
> be anything but the same can only lead to this sort of confusion.

+1

Furthermore, the "translations" extension for htmldocs available since
v6.8 at:
    Documentation/sphinx/translations.py
assumes the same structure as the English one.

It might be nice for this script to warn about translation docs
whose positions don't match the assumption.

        Thanks, Akira

> 
> Thanks,
> 
> jon


