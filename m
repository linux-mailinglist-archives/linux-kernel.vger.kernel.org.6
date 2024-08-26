Return-Path: <linux-kernel+bounces-300772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B2295E822
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C3B281687
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF07FBAC;
	Mon, 26 Aug 2024 05:57:12 +0000 (UTC)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5078C98;
	Mon, 26 Aug 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651831; cv=none; b=p0V6RG1+VxkfzRf3ca1hboz6o6nDnwIvnmKJOTDGMu1nLKWt2fH58G5HgV3H2BI/Pt6FKuXWHuJn+THinXukzmBRQxJUw9AC2QOPZ9OATJsNpWVEEl1ustE1/YyRpKfa11jfBV9QM7PuKXOa7fkfIl4JCxDQwThesMMzP/sCaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651831; c=relaxed/simple;
	bh=6pTfNTYAtjWyqnhVN8Q2JD10JokADegP+LchBBnj7/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsQvVUihaB97WMwEz1j1f+2zhaEMJ+7YxgH5lsISiXlyNMH0svXuiAj+Dyg9n20NtwAGlh7pQnxUeT1vN3IjhaJm6kZPfWPgqxdBjx0FNF6IeVlyJndQi9H1fyJcckVhvdaIJbouRJNoBo/AWL/nhBsqZTZGUqlRWznRUpmwkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 192.168.208.130(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Z2I9YR2_1724651814)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 13:56:56 +0800
Message-ID: <cf3193b6-589f-41b7-b89a-a94ba3b751d8@motor-comm.com>
Date: Sun, 25 Aug 2024 22:56:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: phy: Optimize phy speed mask to be
 compatible to yt8821
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240822114701.61967-1-Frank.Sae@motor-comm.com>
 <20240822114701.61967-2-Frank.Sae@motor-comm.com>
 <a4fbc34b-5d87-449a-83df-db0cfc1bf3cf@lunn.ch>
Content-Language: en-US
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
In-Reply-To: <a4fbc34b-5d87-449a-83df-db0cfc1bf3cf@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/24 18:59, Andrew Lunn wrote:
> On Thu, Aug 22, 2024 at 04:47:00AM -0700, Frank Sae wrote:
>> yt8521 and yt8531s as Gigabit transceiver use bit15:14(bit9 reserved
>> default 0) as phy speed mask, yt8821 as 2.5G transceiver uses bit9 bit15:14
>> as phy speed mask.
>>
>> Be compatible to yt8821, reform phy speed mask and phy speed macro.
>>
>> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Ideally, your Signed-off-by: should be last. No need to repost because
> of this.
>
> 	Andrew

Andrew, please help to confirm that the Reviewed-by: should be followed by
Signed-off-by:?

it should be like below:
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>

Best Regards


