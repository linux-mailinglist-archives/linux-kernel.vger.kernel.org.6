Return-Path: <linux-kernel+bounces-439305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D09EAD67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E01629E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4EC210F69;
	Tue, 10 Dec 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="GCIv+E3q"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5D210F60
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824615; cv=none; b=mSCcL173HSR8uxOKTxXlOB1OcMSF9c5Ndz0MDkAyucHIhogXoN7xVchlKWVBr1I+ryTaLtjm+nCzbAwBgoktECwW22urYeBwMw2XKRrpBAOYxffiapiE3Ap6daIV/J3euU/WcaLkntagR8/eDdwRc7pDYlS/W+eOTi+LqEtS6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824615; c=relaxed/simple;
	bh=xK73O0f7blSrEgwODgrtk4L4kIN4+OvcHPN1VpbRQfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnLTxLyNunjWWnZst92mPq+7TgnfjybNu4sTTIOBXVmFf4rO83sQ/gNh1khw0ZZW9mqxV0BgBwXgZbVdqPpdQ0Uasz7IkPOuTjAZta7ls92DWRwNwFRrZ6Uwc/202ksdiKIsTtW4PKsMmgtFsxi/OsKaUsRdc2Hg/fG8SkPLyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=GCIv+E3q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-723f37dd76cso4750435b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1733824613; x=1734429413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVRuXdDQ8ceHGh69+Xr1H0loAqY9s+XHZx32Oyfx7ZA=;
        b=GCIv+E3qS45vlgMGyv4j+vcl47FfHL3AdiK9t9WN5AJHv7NFePcR7Zdh7jCxQC2iCy
         vqLqOBKVhZ6z0SegiTTELEdvpue3vNZULVDGeMo9SrP7tbtxLXHpbJvs6TjvcHsnIiiB
         GVaELQKS7wE5YD3cRZDsINVO5uJKgSzUgrb9ZhfbCh1am65Jm+T+UBOYKKU0sP2utT2Q
         NXPDlzj226TyltQZVjilhUrnraPtX7hm+eg37OqawNTsUrZMH5iT4lo0C+OG3YlX8em7
         WHhe+Cz8cN48IK2y9MXpt75fGHlfzuWt0vmgaOdsXqygFn9TIYv42CMnMbxITfu/dYnI
         qbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733824613; x=1734429413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVRuXdDQ8ceHGh69+Xr1H0loAqY9s+XHZx32Oyfx7ZA=;
        b=uz3r0y3hRUvGsA0FyF/VHkA+/3qLBBFG32Uz4NjvJlCQU9l5a2BjlSd/mfPOEZ8oKl
         BsrH781TCPg+bXqKfzQ25fj3RGEyHnWCyT28pqgXubUbjH84+OP4sclIuBBvV5qW2kkW
         kbzgv0drXyaoaOwAMlaxaVpvyrtW/eMl+Rr3eLVfubFf1ox4k8Oc+xeSs4cgdL8BIvcq
         0dxWIkYhTLZL2YFd6RZT3uwYvJkAV+yx3NMWbmhHjIUm16Ff7zI1X9UzoPonsypV6+Kx
         o/bsZWHrACivnx/BQWWWqcnzUdUdB3AP7hxSplNmJk2//p8xP8p+qm7tQIB+nZlu/zaf
         xaAg==
X-Forwarded-Encrypted: i=1; AJvYcCVG2+Si99/31HD5NmzyhzbNlpa8fSgyii0SXLZHhQaXhjJWGtBS7Q5r4qDAeUNkwylBQNE7AvhNVLgoI+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBvf55kZISGBS54IBaFJITEho+y5Et5AiEFSsrdCRs2DHj4yG
	nO9iUDwHknfSr7QkaBrW+r3wp0ZW5+DbsN31g2r3mURsoKoMqLj9dukxt8hgYw==
X-Gm-Gg: ASbGnctDGw/WkdWsPIt/xx/eL+B6TwnpL1N2V/AT3lC7EBTKZS5u8r1TaMsgdB+aKcv
	ybZn7GC524MXTSZavNJuQP5mlP/AoHoV7Rsiu1n3Uu1aPtE3ap25GmSdFoR/aZJXrUV+0QAifsB
	HdKl+VygPVng7bBDKBIkS1ulgZULVQpWdfLxuHuuw/5b5xWEgUxrMzmoAgNqv7aAR5a5JtXreSu
	SefB+q3dCHLERBh1Gc0wFIG2OVWxnCAOmI63F/xO52ep1SRTH0K0H2o+l4fitTi1/DQNzVewjL5
	4lhqV7A59RIy3CLAZ/eVAsrstN1G
X-Google-Smtp-Source: AGHT+IHe+Tktbs6gzSr+HibLWo7BRUgyGJ8rAz95UU0Btgi1QAR6b+87ABh2JIWUw8KcY0eLIvyJqA==
X-Received: by 2002:a05:6a20:4322:b0:1e1:a0b6:9861 with SMTP id adf61e73a8af0-1e1b1aa024fmr4818821637.12.1733824613547;
        Tue, 10 Dec 2024 01:56:53 -0800 (PST)
Received: from ?IPV6:2401:4900:4451:8982:a0c3:dcc6:3a8d:184? ([2401:4900:4451:8982:a0c3:dcc6:3a8d:184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725df133a56sm4784841b3a.69.2024.12.10.01.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:56:52 -0800 (PST)
Message-ID: <bab9f277-a366-48ec-acdd-0896c8307ad9@beagleboard.org>
Date: Tue, 10 Dec 2024 15:26:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
 <33c61b28-c0b8-478d-8107-c6ed1ff9e466@beagleboard.org>
 <20241210104141.39acffb1@bootlin.com>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20241210104141.39acffb1@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/24 15:11, Herve Codina wrote:
> Hi Ayush,
> 
> On Tue, 10 Dec 2024 14:52:22 +0530
> Ayush Singh <ayush@beagleboard.org> wrote:
> 
> ...
>>
>> What is the reason for not using symbols directly as described here [3]?
>>
>> I do like this approach since it does not pollute the global symbols.
>> Just want to know if there are any other reasons for it.
>>
> 
> Modifying the __symbols__ node at runtime (adding / removing properties in
> it) exposes memory leaks if __symbols__ already exist in the live DT.
> This __symbols__ node exist if the dtb was compiled with '-@' or if you
> chain the overlay (i.e. __symbols__ node created by the first overlay).

Yeah, that is a problem, specially in a setup which might involve 
hot-plugging.

> 
> I think also that some conflicts can appears. What happens if you want to
> add a new label but this label is already present for some other purpose?

I do not think that actually is a problem. As described in the original 
patch [0], the symbol and connector overlay is supposed to be applied as 
a group (overwriting any conflicting symbols in the process).

The reason why this is not a problem is that `__symbols__` are only used 
to resolve the phandles (overlays do not support path references yet), 
but do not really have a purpose in the livetree (at least far as I 
know, but I can be wrong).

> 
> Best regards,
> Hervé

[0]: https://lore.kernel.org/lkml/20240702164403.29067-1-afd@ti.com/

Ayush Singh

