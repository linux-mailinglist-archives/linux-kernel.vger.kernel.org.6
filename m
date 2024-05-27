Return-Path: <linux-kernel+bounces-189936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97B8CF762
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C4B20D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07D20E6;
	Mon, 27 May 2024 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aI1YAsuy"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2B653
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716775309; cv=none; b=RUSfCmHMiYPo3KmE8xkOseWqM1fUqAecoOOYMRRYeZRmtKE0D9zv+ogzvD3uFzf9V80oPb10DROIy3TfrLRGtZrFM9ltGsvNvrNYYzYbAVU1gtSkPaagzOTPQ/5LJq1KFpZforz2FNkvCVBToR+atwqcKxQ9XPBeqi8yqBqprXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716775309; c=relaxed/simple;
	bh=1iKB6LSdGo/7FZCO/nsmeCr9BVtKte1llxxIyXddlgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WM3ge95fuJXGPMcDt0IvwAdjsWDybSWveg1llqtoN7UEDFMXNgu8KpNCQxAjcOGw67VDiGOHJ9fpXW9Uco4ecfiMWeB21jvEX1r/KU1KcjSJ3W8yKKEzv9Nzq9Lzg+TF0c4DphAASen18jRVFCPSR7AqLIDparhqFJ8iGLxkAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aI1YAsuy; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dmitry.baryshkov@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716775304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4KbC23pVUx2ZjByBYlN7VlAIPsbM3xhWrQdhcgUorw=;
	b=aI1YAsuyn35SzhLYiWlpO+d5nNexjamENbPmTyQSbuBnXV4YNy/F9IQ3Sh1BPtVMC5VAtv
	dhCQQx1ME086s38TXjxcZDILTzAdK8+2w25Bss+qnOaR1m3Po54Et78J9AI1DWM09UQ9Z1
	DQhvk+bhFzFdb+ySSykqQKW0B9+bOzo=
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <03701609-86b7-47a3-85af-db47035695fb@linux.dev>
Date: Mon, 27 May 2024 10:01:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 02/10] drm/bridge: Set firmware node of drm_bridge
 instances automatically
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240526202115.129049-1-sui.jingfeng@linux.dev>
 <20240526202115.129049-3-sui.jingfeng@linux.dev>
 <lfgb24qv22sohgizlmt7kq3ymnshjeawlkwwcndivbeiloip55@x3qnu4ss3x4y>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <lfgb24qv22sohgizlmt7kq3ymnshjeawlkwwcndivbeiloip55@x3qnu4ss3x4y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/27/24 05:19, Dmitry Baryshkov wrote:
> On Mon, May 27, 2024 at 04:21:07AM +0800, Sui Jingfeng wrote:
>> Normally, the drm_bridge::of_node won't be used by bridge driver instances
>> themselves. Rather, it is mainly used by other modules to find associated
>> drm bridge drvier. Therefore, adding a drm bridge to the global bridge list
>> and setting 'of_node' field of a drm bridge share the same goal. Both are
>> for finding purpose, therefore better to group them to one function.
>>
>> Update the drm_bridge_add() interface and implementation to achieve such
>> goal atomically, new implementation will fetch the device node from the
>> backing device of the drm bridge driver automatically. For the majority
>> cases, which is one device backing one drm bridge driver, this model works
>> well. Drivers still can set it manually by passing NULL if this model
>> doesn't fit.
>>
>> While at it, Add a 'struct device *' pointer to the drm_bridge structure.
>> As it already being passed in by both of drm_bridge_add() and
>> devm_drm_bridge_add(). A lot of driver instances has already added it into
>> their derived structure, promote it into drm_bridge core helps to reduce
>> a batch of boilerplates.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
> 
> [trimmed]
> 
>> @@ -231,7 +243,7 @@ static void drm_bridge_remove_void(void *bridge)
>>    */
>>   int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge)
>>   {
>> -	drm_bridge_add(bridge);
>> +	drm_bridge_add(bridge, dev);
>>   	return devm_add_action_or_reset(dev, drm_bridge_remove_void, bridge);
> 
> This breaks aux-hpd-bridge, which gets of_node as an external pointer
> rather than dev->of_node.
> 

Yes, you are right. I forget to modify that driver.
My bad, will be fixed at the next version.

-- 
Best regards
Sui

