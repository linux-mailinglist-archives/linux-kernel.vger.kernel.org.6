Return-Path: <linux-kernel+bounces-398953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF39BF86E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1EF1F22F03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF72076CE;
	Wed,  6 Nov 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="ItebCpsV"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EB13A26F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928197; cv=none; b=WdUdjYScto3dorqMcJdws7J6bbbpVwjjVp9xcpPlIy7Le/U3ErxycHXgkNH5GcPu3ormoFxJjZaBJTmHCI5OAIN0UZolMY1sHRIA49IKspNGNgJeYRBseJM82anoLke1LcUOF9IQg3IG1KqjbkJ62kZdQpPWd0XPVL1/8qUpMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928197; c=relaxed/simple;
	bh=U2i4d0ltICF/+70KkScTf5AWsmvfByR9kQmrJbRsOcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFlqsIjFYcbdqs5eHrhkGclnV+mKZrr6FknsUqPuMTrjwQTXVgUKa6IFN4NRcAnIbplN8a2sKHmQYQszUlc8PrL86iEGyzmCOHnMxPaquLaT5GmIpZh6xi2wOuqpOVhLbh+/NtaUqzfW7Ka9slClTuYtqGZ/bltB6GWxwxISHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=ItebCpsV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so2321215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730928194; x=1731532994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmvNN6gesL90wm4yphATi3h7Pns2kBBZ4GSb280H7Oo=;
        b=ItebCpsVCJMFBUG+It6d0ouVyg85a8VWKMOtj6BLWJMA0MOTJ5AMAHWoOLZngcGeoF
         nImLg8FJ5N5lrNN2Mnq8eOI6jTonFy5TGFh+mb6lgjSLstp3XMJKDicvrOLc83gkx0+/
         e3eJjRTk56kUktttcT+iJ2ak4VZFZtnv4qUkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730928194; x=1731532994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmvNN6gesL90wm4yphATi3h7Pns2kBBZ4GSb280H7Oo=;
        b=eFUSnwD5NA0VhQ5wANAPYvmIy2+MdAhc/q+DaEhhuQKWeBP9dAVvOlFvpqy+iDhzR8
         kCeuwdKvF4Byj4Qsvos60tTpdCqB+VeZhit/CGcBZ5hRr1VZDWU05FxqT/RYSOzWXJms
         Ydo8VmCICUyO7AXZyOnvQpGbetKXmRXGWyl8LhA4ofg2q4D9JpRDd5ZaKNCfIi41qDE3
         FnhudbuMMAi1YaLj5EeIOG16lYiYVaFjHVyVfyBQJjIihYanT3cehcXOl+ilTI5GHlcI
         +pNHRi6KDK658vHk8V8V3K4PG2So++6TlDAYZvHu6n70PH1rL3ATOFQXfIsV6q/UCLVf
         U6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWcuyWYVV/C4sQgbmIp++R8I+v5TH6cIxDRu32HVO3yL4Qjqy5q7TK5jXmbtZmeB15r7MaIOqvcfv9lyEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKk03VOj+cJiwAXc1S3a2vYrDkJ5UaWVeF+Qw0ZCOIKkmbpsX/
	bFiRLvgFFDJUEDYGYa4iRVNTa5r1w4uz+hEtmJiVVCkw7Z+GSStYKJAA4rZotok=
X-Google-Smtp-Source: AGHT+IFOH1fZS7r2xCtxhzRmFDfp0bLlLooQZDFMXKH6gRzno8hFIF3XfaxktR5N9V1g12TGoQiL9Q==
X-Received: by 2002:a05:6000:1f8c:b0:374:ba23:4b3f with SMTP id ffacd0b85a97d-381c7a484e7mr19608917f8f.9.1730928194104;
        Wed, 06 Nov 2024 13:23:14 -0800 (PST)
Received: from [10.0.8.225] (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee7688e38dsm7377127a12.22.2024.11.06.13.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 13:23:13 -0800 (PST)
Message-ID: <9c7b9fad-408d-4767-9aeb-4e2333b0ece9@aiven.io>
Date: Wed, 6 Nov 2024 21:23:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
 <james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
 <rric@kernel.org>
References: <20241106114024.941659-1-orange@aiven.io>
 <20241106114024.941659-4-orange@aiven.io>
 <CY8PR11MB7134C2A2328E5B8B3285C81489532@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-AU
From: Orange Kao <orange@aiven.io>
In-Reply-To: <CY8PR11MB7134C2A2328E5B8B3285C81489532@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/24 13:04, Zhuo, Qiuxu wrote:
>> From: Orange Kao <orange@aiven.io>
>> [...]
>> Subject: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
>>
>> Current implementation does not allow users to set edac_op_state. As a
>> result, if a user needs to test different edac_op_state, they need to compile
>> the kernel.
>>
>> This commit accepts module parameter edac_op_state which makes it easier
>> for users to test IBECC on their hardware.
> 
> An SoC's (with the IBECC feature) memory error reporting type is determined.
> Switching from NMI to Machine Check or vice versa for a given SoC is pointless
> in the real world.
> 
> Additionally, the interrupt mode is preferred over the polling mode unless
> the interrupt cannot work, as in the case you reported.
> 
> [ Sometimes, no choice is the best choice :-). ]
> 
> -Qiuxu

Thank you Qiuxu and Boris. Good to know. I don't have any "actual" use 
case so please exclude patch 3.

Thanks

