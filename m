Return-Path: <linux-kernel+bounces-409624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5E19C8F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815471F22765
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F80B13BADF;
	Thu, 14 Nov 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MG/+ZokM"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4C18EAD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600985; cv=none; b=HPgrmHsFkGgTNTSXwQyxZt4W5hnpkydOI7IWihosRgeF+FlYFUb7vGyHe4FILGbQBNiq1McHnLi2dyBbGFi2u+EJ10Xapaf6PSWGVDaJuWbJ9HbsahfpI2urTHKmojWyTtvZyMzTXswnSGCWIYPznFXVVSQNgyW+dPDqKi5VHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600985; c=relaxed/simple;
	bh=mHFHn4t/EyBpmOdpPhVG84ehQfiDq556H9EMlvRdlW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUAEbR2+nwZM+hQy2iK8tbVwzM12KoRl/5uCWKQr8wwFcFlBw21dRYYOTFMpJsLCUwbXBsSMQ23QsAHsijM7Dek8exJ1L41cgJYBYhgTOamCVTiqQVMVauAHuCWEtWZ/H6FoDzbll1AJJ38Y0GKXUHmcg4BX7RFbAFejD8X9ZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MG/+ZokM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73b2b454-8897-49ff-8393-0dcb8b69d5ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731600981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhLrL6xZDaAVGdx5FBoKq/JE8N1BZC18rNxW8cG3LwM=;
	b=MG/+ZokMHcJO11rqkIZQxRk3+tGpLIu90jFGT/9urCOVehojALFFgRaNd2/EZm7/5oq+2A
	ZztGSENBEtuhaT0zxiykSERYXyqag/e2O36FtDuK5J+Cf5DliSVLX4u4k+ns5N4RFtqaec
	ow6y3M1Bpmn/prD2yFWNIKYMqinGe7I=
Date: Thu, 14 Nov 2024 16:16:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/7] enic: Save resource counts we read from
 HW
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-3-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-3-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Save the resources counts for wq,rq,cq, and interrupts in *_avail variables
> so that we don't lose the information when adjusting the counts we are
> actually using.
> 
> Report the wq_avail and rq_avail as the channel maximums in 'ethtool -l'
> output.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

