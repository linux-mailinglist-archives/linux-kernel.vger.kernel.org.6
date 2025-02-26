Return-Path: <linux-kernel+bounces-533593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F99BA45C67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B55D3A310F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB062686B7;
	Wed, 26 Feb 2025 10:57:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B62254AE7;
	Wed, 26 Feb 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567446; cv=none; b=Qt7B1mHEEWVyf/RBT8B5rdR52kSYme4J/4zA2RwNvAeFBis7aW49xzEQOQiMjqU1xmeRkv6ZbDDGR9s0qGH2lJ1xC43QTg6Tmj8STeqtD+U87CeJ7Mjm2aLasNBqio1PrC/Loxt0tIkkgY2jOD4PBgY5upt/LjSJ5ZX2IfYC85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567446; c=relaxed/simple;
	bh=SF5oCgI6KbDNfZw+WYDdTvd4xGNIwfBxc8VwyRqIRu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qmo6p59RpzFuo4YUqtNdoXuTO3XHOpzj8Fkk7ZMCDjobSyVcUwczB1uuGDRaBYVvgQZLk2YG9cjqp7k69lfL10lvc4qnS8eOB0c41kgJfIbrSZl0WGXLNABOpgeQ8ZAhLYf9c2aEdpAzjUk0DCsvwogEd8whVdbVyRIMZMDA2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EBE21BA8;
	Wed, 26 Feb 2025 02:57:39 -0800 (PST)
Received: from [192.168.7.252] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB9093F673;
	Wed, 26 Feb 2025 02:57:21 -0800 (PST)
Message-ID: <d90bc4a6-2f9b-4b02-9eb5-95a237d30910@arm.com>
Date: Wed, 26 Feb 2025 10:57:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] perf: arm_pmuv3: Add support for ARM Rainier PMU
To: Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
 <20250220180427.3382482-7-vincenzo.frascino@arm.com> <Z77tD1VuD_W0CK5B@bogus>
Content-Language: en-GB
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <Z77tD1VuD_W0CK5B@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Will,

On 26/02/2025 10:29, Sudeep Holla wrote:
> On Thu, Feb 20, 2025 at 06:04:24PM +0000, Vincenzo Frascino wrote:
>> Add support for the ARM Rainier CPU core PMU.
>>
> 
> I can't take this through Arm SoC unless there is a strong dependency
> and/or urgency. I can take 05/10. The other option is you can take
> 05 and 06/10 via Will's perf changes as usual as I they seem quite
> independent to me.
> 
> I can take the rest of the patches through Arm SoC tree for next merge
> window.
> 

Based on Sudeep comment, are you happy to take patch 05/10 and 06/10 as is?

-- 
Regards,
Vincenzo


