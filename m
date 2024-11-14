Return-Path: <linux-kernel+bounces-409246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC19C8970
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C61F21A72
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6581FA824;
	Thu, 14 Nov 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBYZg9wj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F01F9AB8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585855; cv=none; b=JG4fqvEzeROUxe5KYlfXFxiOmeXLPjE7E1CGuwL6Sx6Z+IIZLIiy5twuRqNzTyTwfPmN9nzMi/ADxTFMXyNgzELmmDYiEcFxEXWJ6T1katkEIHIJK/oVRMWMmdVv9BaYgyB6RCVosrHijKo5DYfr7LuugJp+b5OHsg8T5jlG5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585855; c=relaxed/simple;
	bh=WSrWwHicHpstF8709DBJpyINEmGMSBpl3zd9E93YJg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTP5OVJaFjOQOL3HZT79J8uWoNUmLy+tDjj17i0EeIhjUrbawZWnqgqWMmcHyrgjFbJ+QnQSnEGlqQl7ETzdvzb15ZoNkG5PIphVJVRJyWbiAYjFLD4VvkZ0fCyq1/4U4U0WpyPSpMBEYC7DsxbpzE2qRbYQHvjjxhWC1Oe869s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBYZg9wj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f53973fdso431889e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731585852; x=1732190652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgyGgNfC+rd1jRerbC94tW0EIBJ7IpWdGz9q/2cwLDk=;
        b=TBYZg9wjEQTXfOe5rD7HyvJXa5wXosTwMxJUDc/Qit8OajTy9lc8Fe+MI5PQEAj0XX
         sY9pM0b+bpFXaqRwJudxSo58rX9rW63GR72KxFZYUwoM6RGiQrG75HO9OTvhnYWVB/5a
         myCnrMn36oXf2lYf64o2+l84OFULxcXKehjAtPLUBv8msfboX22m01YCsPMA8GjnJbUx
         mheum/CYqCRT5oDyt2RiIJURR8Q//dLsROG1fbCeDfuWcv3wobsKwwHCLbc9t5qi0JDj
         oGWrzbNt13EFFPHyBY1eajKXWfLuiZpcNBzd0ydo0ShEKAoq4jjmu/TduqT1IDBSVn61
         VBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585852; x=1732190652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgyGgNfC+rd1jRerbC94tW0EIBJ7IpWdGz9q/2cwLDk=;
        b=VC+NTVAKuKxttV8SHho6xyj1Oa1hs6S0RvqBQnJrhEKbPzC0b0+WOHj3mD8c2xNsCj
         h3uNJIQGZJvoFkr+am0yfOc0qnr3yR974oNoQKtHt069TYTWnVQQTZ0jqpb6hSXyICpf
         dgkuBimxczfP6S6TGgoJCrQ5gWi7+KLpGS7VVDTwEIXjaETNUvla6JHz7VZ1T5nWB7Kz
         pZpvk6A0wrdLytYBhBuiZBLhkZ6Po8keEkVmcrxeQv/sleRY/MEqhcheW68x56SWe/s/
         qp607IDi/jyDGAXkV0MVGUFjpZKY4nFliQG6jQfOCvqqkmPQsn9PJ5oxyQKuG2cflwGg
         yYWg==
X-Forwarded-Encrypted: i=1; AJvYcCVzSkhfjOS0ljLmatRrqpZlNFpiUE45Fzl+KdsI8YCBoH49Jyu1HU7OERSRWCq5xtSVpz7lJgHGtRWm1FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfTK21rX8qipxE3rIZTx5OcOZ4Gz9RAt/hVLhWyMymyKxagbd
	0Sx/CY6vQDSHEDkWGDn9AQFpitqPbt24/MXPIDrkERGp27ii6mxq
X-Google-Smtp-Source: AGHT+IGoP5QR79UJhuxbhFDCkHP2p//tAkHiIkBTmzxrYHVW3KXBIidDP3cViCoGydwTga19OqPOCg==
X-Received: by 2002:a05:6512:3f1e:b0:53d:a096:65bc with SMTP id 2adb3069b0e04-53da47ad753mr1071609e87.13.1731585851455;
        Thu, 14 Nov 2024 04:04:11 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da65487dcsm161630e87.233.2024.11.14.04.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 04:04:10 -0800 (PST)
Message-ID: <80071b1c-c8e1-4273-8b10-3630af8d88e8@gmail.com>
Date: Thu, 14 Nov 2024 14:04:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] regulator: bd96801: Add ERRB IRQ
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
References: <ZzWkny4lKpY09SX5@mva-rohm>
 <ZzXjvHvOlP6VCzcI@finisterre.sirena.org.uk>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZzXjvHvOlP6VCzcI@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2024 13:49, Mark Brown wrote:
> On Thu, Nov 14, 2024 at 09:19:59AM +0200, Matti Vaittinen wrote:
> 
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> ---
>>
>> This patch was part of the:
>> https://lore.kernel.org/all/cover.1727931468.git.mazziesaccount@gmail.com/
>> The MFD part was applied by Lee, but I didn't see the regulator part in
>> MFD or regulator repository. Perhaps it fell through the cracks? I know
>> we're late in the cycle but I re-spin this now before I forgot... We do
>> always have the next cycle, right? :)
> 
> If this is part of a MFD series I'd have expected it to go in with
> that...

AFAIR, Lee asked if the patches could be taken in separately. I replied 
"yes" - with a very small corner case of someone having the ERRB in 
device-tree already (which could've been a problem if regulator part 
went in and MFD didn't). After this Lee picked only the subset. I 
suppose this evaded your eye :) I know I should've resent this back 
then, but I just forgot to check if you picked this.

I don't see having the MFD part in without the regulators a problem 
(other than missing the ERRB functionality). So, perhaps Mark can pick 
this after v6.13-rc1 is out?

Yours,
	-- Matti

