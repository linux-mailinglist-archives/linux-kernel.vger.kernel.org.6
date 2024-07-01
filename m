Return-Path: <linux-kernel+bounces-236679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B467F91E5B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31781C2088F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB716DC12;
	Mon,  1 Jul 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="e17Bxh9n"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9918635
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852453; cv=none; b=thwu8J3mupp2RryhqTiyf+R5E0xF6uBvOax+vPjueGKo9HxCjq5Q5dGtjLmaUjtdBq6UuoqFvYzHHncI+oQ0+ZSYe2+RsbGvzOywblLkGZnEYW2u/qJWi3xRCKrUnl/sNMuCXOqXuzhmJTj6cTBSLT1k968jgwsOv7Y5EAq9WEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852453; c=relaxed/simple;
	bh=Nsgc1o0xUy64Zn2AvTib3nicIwaAJ2/DGfiFNp2gIwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t10gtPobkEfmePwXRYlk6voZ41eq53ykTboib0jG6CsfUxcW1x2Fc1BAGldpbCL4wSkf1d26MjOt61EXTnx1mz8akSZnayCfM1Yj3sB9HDoq0D/JQtHvMNU9y9CWlue5tCwJywAAKSKMJwokosR+5MtQ5kz/RB7JRYRIu44itvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=e17Bxh9n; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WCX220HHJz6CmSMs;
	Mon,  1 Jul 2024 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719852263; x=1722444264; bh=MsJAC0SHqFyuVVRY34+8Dyns
	58WoYnU8G7iaORuOaJY=; b=e17Bxh9nzeeBi1wfKHA1rv4Dd8NopdzxVuJD49Q+
	OP3XLx/EajozFrTDI06zkwkM/Eduf7zFoVCioPE5rfzQqm1wc2E+MXMU9o4a8jWD
	Gc9vqIxf6qlTnaV/twahOaBsS8Mk97xGkvPxVROc1Cldv5szo9ZITAgxmzltTt15
	hXIqrDnu0xFGILZztE4QscmxPV60qQRV/iGlidcP1RpMUGY4upTxBJYCnkx7TEb6
	B4MOJjUjypwm1bh5cJHTaT+IeQNdMY4jT/Lw7qV+gBwW4fiKTGU2+Mr4x0TU9izT
	0BdUDV9oQnEr2SwXYECTRH7pG55B5p1A8DON5JCt+/+g8g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Aydu-dLlTYVt; Mon,  1 Jul 2024 16:44:23 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WCX1y5kZCz6Cp2tZ;
	Mon,  1 Jul 2024 16:44:22 +0000 (UTC)
Message-ID: <7d41097f-4757-4bde-8a8c-d293643850a2@acm.org>
Date: Mon, 1 Jul 2024 09:44:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/53] nfc: mrvl: Simplify a create*_workqueue() call
To: Krzysztof Kozlowski <krzk@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-32-bvanassche@acm.org>
 <b2f7c7de-080c-4dab-ad6f-ed8b73aae59b@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b2f7c7de-080c-4dab-ad6f-ed8b73aae59b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 2:17 AM, Krzysztof Kozlowski wrote:
> On 01/07/2024 00:26, Bart Van Assche wrote:
>> Pass a format string to create*_workqueue2() instead of formatting the
>> workqueue name before create*_workqueue() is called.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/nfc/nfcmrvl/fw_dnld.c | 8 +++-----
> 
> I only got this patch, no links to new API being introduced and there is
> no create_singlethread_workqueue2() call. Looks fine, but tricky to
> review. Provide first patch or lore link in patch changelog.

Thanks for the advice. I will do this if I have to repost this patch
series.

This is the link to the entire patch series:
https://lore.kernel.org/linux-kernel/20240630222904.627462-1-bvanassche@acm.org/

Further feedback is welcome.

Thanks,

Bart.

