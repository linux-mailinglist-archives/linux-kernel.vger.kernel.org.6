Return-Path: <linux-kernel+bounces-413192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABF9D151D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147E0B2AF07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C891BC077;
	Mon, 18 Nov 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRZ32geY"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF21B6CF1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945633; cv=none; b=lVCJMi8zAx/lfHLCHN/N+h60yEpzP+szxEPv7SYw/nmatDzYMS7inZ70a9j5UXWAvHg5AhupbObfcnkCCLMP3AA7Cg5kkQ12DA6lRmUSAWvHsXr0XJSPpSh6mgSBv6w/5mTpJAxt4nBavRetyGIj556PW4+Zb5Hoh19hZEreTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945633; c=relaxed/simple;
	bh=Ge0r2Ea6KyPvO6/MOe8wxcNH8Q7DIB9dNFPGQKRqvQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=he/tenVi6DSIz3jPHISY7Uraugi4faZY4MDoQdMeKjmOSb9KGLjQv1LB1i/5klgvckRBMdtXbXWwKrZiNmw5RyKAWQGyhb84yWzF4pROdnzKRsQ8xie521uWrM2HQihbcbCV7xzxLu6wFDj/35vtf+dYCfQ/sXbc1Cd4YjylYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WRZ32geY; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731945627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZI0ToznCzhjHwYsDSDb01BcP4KuLMwEBrhHNS7BIoc=;
	b=WRZ32geYK58tbEOuvHdtvVxm1DNs9niOmZol4nD0+3Mp8Dh6xJRI+uVBqTQza9gc5xn31a
	72onjs3SehhdwbFfty9nLDSfYnnlGGc+e29TYEanwsJgvAy5RVSwrmcCrNMPECyUdxetI4
	aEM2/YUCYARPqIpYkKl9Nf1sh+X0xtg=
Date: Mon, 18 Nov 2024 11:00:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, harini.katakam@amd.com
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/18/24 10:56, Russell King (Oracle) wrote:
> On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
>> Add AXI 2.5G MAC support, which is an incremental speed upgrade
>> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
>> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
>> If max-speed property is missing, 1G is assumed to support backward
>> compatibility.
>> 
>> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
>> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
>> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
>> ---
> 
> ...
> 
>> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
>> -		MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
>> +
>> +	/* Set MAC capabilities based on MAC type */
>> +	if (lp->max_speed == SPEED_1000)
>> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	else
>> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;
> 
> The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?

It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
(2500Base-X). The MAC itself doesn't have this limitation AFAIK.

--Sean

> Normally, max speeds can be limited using phylink_limit_mac_speed()
> which will clear any MAC capabilities for speeds faster than the
> speed specified.
> 

