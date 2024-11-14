Return-Path: <linux-kernel+bounces-409665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C579C8FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B7A1F222AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121B17D358;
	Thu, 14 Nov 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bt1MfwmS"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55115DBB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601921; cv=none; b=C2WD5RAqyn+rXH74y6atRMvqN9aZkkqg57O8pI7yZR66rA3weLqfqJyvHkS1PnpAfvNPr82CUO9loz/KObpjCzrFSWXmuVcCeHy6jheNW2+mL2nGSkJV+b9aqj4oYrhmzHU0mTyNvPcN0+y0kUAkSNeuq98+XU/ayS+Jjl4nwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601921; c=relaxed/simple;
	bh=IKS3bmOd44a6RC5WgGwK8Q039x8HkDeJIMgqsfsmBJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrqEUp3TUSDrdOhphu4xlEH28vn4XT48jXAl3Mt2nwKSPyXhqgJOKiKustBWkDqXMsVQYVT5JgkjkPtLhFJ3Uf0FJNhHKEA9ZKSCd4WYrSVlHFmaQ3X/K0lEr5hneC2I7NUppuSHlkaVsVojT7invgW8KVv4j+oddIFJnSW1ZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bt1MfwmS; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f6455a1-c4e3-4565-8f64-819cf5dca340@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731601917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXMmXM+7CbkyC1m7f735GVNn5/bfFpCZqMplZB8tKF4=;
	b=bt1MfwmSyOwR/6JH6lJp7dG+szURo5/Yxf2hVchJNVJsSOIbRS7ZcLjATavYI/u/jz0mfY
	v6ngmIRL57albHB6v+w3nXk7q8q1SyfsmO6PHcwzxXweQk8jfSCiza44vF4d8nsmDovHTy
	beUsCfCtg5shp3URiWfNWzejuXm5zc8=
Date: Thu, 14 Nov 2024 16:31:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 6/7] enic: Move enic resource adjustments to
 separate function
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-6-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-6-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Move the enic resource adjustments out of enic_set_intr_mode() and into
> its own function, enic_adjust_resources().
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Oh, that's nice clean up of resource management code, thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



