Return-Path: <linux-kernel+bounces-280019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F894C4A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1511C22FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714315A87F;
	Thu,  8 Aug 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Gn2yR5A2"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200415350B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142499; cv=none; b=YYp4peq2G97k2vIhIfbS7WCovAlQNoE6x98znt7UIiF27fpThqrNyWRXHDa0yLTQHE1uV8QfGoGNKiZ/D1pQNZaXE8Sg314d3McV/1IFNngLNrwT/jq0tWb0I8GB5YR7hVvrJI97PDOwvQ6eOcOSDjTnU6MQoo/9XsnfmfZ68iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142499; c=relaxed/simple;
	bh=mc2b2wnvSswdd9bGNTJz3ThvN6deTuY2z1veO6hhceI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI8ayG1qlYFeAHr1E9K5c2xPnuTaWuSeV+kI79ySKWp4h+tIX7vCIf8BLPgAcAKOA95TxIxxkc85jspLeFD7TZaFEM6HOOknvq89jUvqUKq0EXpBWU3eptvJb/iCyjPLQHhnA0KAApHyiLUtIoYaLHMkqBqog2qm6IYFV9iacT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Gn2yR5A2; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id ba7jsrWO8jnP5c84vskzOj; Thu, 08 Aug 2024 18:41:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id c84usSNtLRdDPc84usVouE; Thu, 08 Aug 2024 18:41:36 +0000
X-Authority-Analysis: v=2.4 cv=YuoJRZYX c=1 sm=1 tr=0 ts=66b51160
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=bf4sMg6fRU9RvZfKRQcA:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Hy7G8KZGHDNlJ3507GxEirDfB3P09Yp8UX4cEgxCNo=; b=Gn2yR5A2DkEODa9mYfOrJzjBvR
	jRsU0kedD/5yUEgWmNV2GKMzrEserzkqo5e49WwxpMcuYfEnyRAapQ9V372V0U7MVFMryABH8+c7R
	vvCVCxf2zLD/CAJNO6nv0W9ff3iQMm04HZoLjjYyp+KwKLrOfor+m2KK7u5bZ0CPhKm5a6wKMU/tn
	nHOirqXdhkU97zocmxXTRBS7vjS/hKp/TRggipSVHyKM7ezFkTrGmYfp93ekqvi+6S8ZCwNSkug6r
	qlg1k9yr+N8sTDfyTpnbsyzXz1XnX+pda8nwbLr5iB7DAZqN0oKgYS/xyIWbSFsL0KRxkZaaLEmIA
	Lnaz3bWQ==;
Received: from [201.172.173.139] (port=57980 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sc84s-00417g-1x;
	Thu, 08 Aug 2024 13:41:34 -0500
Message-ID: <111cc058-a681-4aec-ace4-cd6bc19699f7@embeddedor.com>
Date: Thu, 8 Aug 2024 12:41:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] cxgb4: Avoid -Wflex-array-member-not-at-end warning
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZrD8vpfiYugd0cPQ@cute> <20240807200522.2caba2dc@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240807200522.2caba2dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sc84s-00417g-1x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:57980
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFRC9J/Mwx55iAWYxrzCDXia4mP6AEs9C0kvEJhJLNtcQ5BCs9xn9VeXoLqAlqDNir+h7FAv6deATmHWd/2s8J5aqH1LcqFN+QMxkfBPFZKpBA/Faea9
 /73XT9V7Yde6Nttrxp7dJ8hIzYagtLvGgGAQNzQWq+EsFoEql01gpgGG9ZaLNBNFqvmnBWlz/OkrlpqcoroG817MIqXD9OecLwtpV3NBELi4oUlbQ6l4gfO/


>>   .../chelsio/cxgb4/cxgb4_tc_u32_parse.h        |  2 +-
>>   include/uapi/linux/pkt_cls.h                  | 23 +++++++++++--------
> 
> Took me a minute to realize you're changing uAPI.
> Please fix the subject.

What would be a preferred subject?

--
Gustavo

