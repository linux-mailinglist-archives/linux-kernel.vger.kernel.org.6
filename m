Return-Path: <linux-kernel+bounces-395814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880819BC35E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA35D1C21E46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C674D8D0;
	Tue,  5 Nov 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="frcZ2JyS"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE634317C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775057; cv=none; b=pjaLe0EWb3VK60bEJhi0tT+nvYXoYoM5s9aK7d2NP6Fe6Hmn2hNSVfJYWfzAPqKWgf91ZqzjGq6qBuQ/UV0A/VgSRu74IxRwYl6/f1xRPxmcdrDYIpVCBN5gpNg8qVolR3ta4dy3qboaJ6feOKFB//7xdU5WBCO21qG3mnQy0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775057; c=relaxed/simple;
	bh=vbiJPHegxNQ2CbHFn19WOVEY31A9cQbMk+3TsF29fLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/WGXEw+8MBKmeY+stN12xoBEJWOLGZsFP924l/rzbCU/CDNj0zFeUCExZAI+o6JwLipiTciaaK7pqhHa0P8XWXt5aac8ZCbzk4yk5D10zdQ2ffUAUh2wO6191xIjwzbrCcqx0oDq0yr9Gp0KJ2tkQmsnwydIJnwN8G2wpDlG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=frcZ2JyS; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cd93a6617so166930839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 18:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730775055; x=1731379855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ul3hkd/tGZUgdB/NcC3+w2ZkqD0S/VDimfThwQCgdHo=;
        b=frcZ2JyS8wY+r4SxHLjfJ0xUjmN46CrkaOZgSYc0FDtcxphpwkpjaoq9o0cvSXGSzB
         eUG0rFIZFKbBcICahMmOxiFHEU1uHXvu7AXYxIQoBrutOfu1EGfq2UUhlovt9iiKasJW
         Q7/WZmDi0WGwfAPB6I0tTiypS18LlXStwzX2IRW220NliTaORksv1ihUT/0H8O7nwhRZ
         RQ7oCpf60/gOoYAOoZqqiVIE6KQVYxcDUPvWLKiKI5JJKncCEKymDDVKw0M3xdpWcIq2
         rtUF5+uYwgX5FcQlowm59CiGvOBOBYgsz0FhWA2tM0blYcqkeQFldo3YLO9hD4tqe8Tz
         +DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775055; x=1731379855;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul3hkd/tGZUgdB/NcC3+w2ZkqD0S/VDimfThwQCgdHo=;
        b=sUPjmTMhsnCnqjfgqmAqRbaCtRyqGhju8KgpNmBCpRIhom70weGEbgVJqihWr0i5qt
         bpe3O7Cjc46nTcyN3d21I97E3Lv4jU+Nj0Z1+urKjtf1vie7dXWDGv8OQxUda/LSYbrT
         rjionv0mguXneXUUODlcQ+fYCbRnjXapGZ2vFDx/rXWt7MyvyQwOtbf97qJhQHjZknUi
         7uQG7l200zfNTSkSsfnMSY1ox2Y+bN5gLAa+HDo3ntkT7FLOQerXcPqbVx2zJnvU9VrR
         SbGPLBd0gMVD0VRT3jWSI/NVPRbsUpa6GRdPGtp08osbSIl4rvwvAh0ArSzmI6PbWWlU
         q/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWigz6lMCetC1zE4otQM+J1rw6Kslf07ZkmWzfnlRYBbPhegNC33Tvs0A326eAJwdnKLqfRm6I/ACERK/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOj66eR3vUKmymfMWN5xbOetAnFL2PgVWbFYLK3gdbDuHWhv2
	NWG47ogNtrG9RnBfnFv5ExqIUzWuniFWIZHWsqKx6sA6I0+mzUMH6hC0y954euY=
X-Google-Smtp-Source: AGHT+IFCnX1dntppVfh7JOMx6QPmo5cW1xeoynpjMcWrKPYAnWrp50DBwRG8U2h/uLNbyAAUxQqaZQ==
X-Received: by 2002:a05:6602:2dce:b0:835:4278:f130 with SMTP id ca18e2360f4ac-83b1c5d43acmr2984623839f.13.1730775054965;
        Mon, 04 Nov 2024 18:50:54 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04977ce7sm2193935173.119.2024.11.04.18.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 18:50:54 -0800 (PST)
Message-ID: <8a04f84b-453b-44e5-9053-204a08d38e19@sifive.com>
Date: Mon, 4 Nov 2024 20:50:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: spacemit: add support for K1 SoC
To: Troy Mitchell <troymitchell988@gmail.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20241028053220.346283-1-TroyMitchell988@gmail.com>
 <20241028053220.346283-2-TroyMitchell988@gmail.com>
 <6zx3tqdc5bma2vutexwigzlir6nr6adp7arg4qwl5ieyd3avbu@5yyhv57ttwcl>
 <dbeea869-54cd-43fe-9021-783d641f1278@gmail.com>
 <ariqiukhztgziwwgaauqy6q3pghflnoeuwtag4izwkfmtvi2kh@gnlq4d7jsaw4>
 <6cce463e-25cc-4a07-971f-6260347cb581@gmail.com>
 <502b0b14-0e1f-4a59-85ad-7edeb9d3033d@kernel.org>
 <a08384bf-6747-4975-b025-f8fd3685fc30@gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <a08384bf-6747-4975-b025-f8fd3685fc30@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Troy,

On 2024-11-04 7:14 PM, Troy Mitchell wrote:
> 
> On 2024/11/4 22:48, Krzysztof Kozlowski wrote:
>> On 04/11/2024 14:01, Troy Mitchell wrote:
>>>
>>> On 2024/10/31 16:00, Krzysztof Kozlowski wrote:
>>>> On Tue, Oct 29, 2024 at 04:36:00PM +0800, Troy Mitchell wrote:
>>>>> On 2024/10/28 15:38, Krzysztof Kozlowski wrote:
>>>>>> On Mon, Oct 28, 2024 at 01:32:19PM +0800, Troy Mitchell wrote:
>>>>>>> The I2C of K1 supports fast-speed-mode and high-speed-mode,
>>>>>>> and supports FIFO transmission.
>>>>>>>
>>>>>>> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
>>>>>>> ---
>>> Change in v2:
>>>  - Change the maxItems of reg from 1 to 2 in properties
>>
>> Why?
> I need the address and size. In v1, I wrote it as 1, and I got the make
> dt_binding_check error.

One "<address size>" element is just one item. maxItems > 1 would be for
hardware with multiple discontiguous register ranges: <address1 size1>,
<address2 size2>.

Regards,
Samuel


