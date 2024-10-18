Return-Path: <linux-kernel+bounces-372255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB59A464D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC2A1C22B65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9F204940;
	Fri, 18 Oct 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="sZGQoEts"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DE2038B4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277730; cv=none; b=Cc8h+ofTZCoUeXR5EEc0dfv9/lXGcIei7srqiIIWZTfk2DZZic9vTfHyqc2vlQCPJ8z8hpEwPe9aDdcPulP/i4WRqOn/xNdrJesHpr0o6KSiYZIFRqJ4Veh2NJOKdnbCiMYazwAyck6ItHg3t21P0ahFgEDO3dCa4FFxU6O3eYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277730; c=relaxed/simple;
	bh=FyxG8L0kTeJMBvFZ2TqpR7bCfzlRoydYJ1KvWJsuPAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7s64WeMCgkX9w/qbXcVKun2itHVECjJmDjZMq4UZyMU/+eqWz3Ihrzpl2ya2kfSN99st9E5mb717O089Maq+y87mPAXOEuh8hsIe6L/57UYZkHruSCqZdK+QJLiJYrpNp7YI9BoT7ZV2CQ7nrKW/7yPn6OnG9Zu12qAw1JSy5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=sZGQoEts; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id 1TIKto4GUg2lz1s88tCfQX; Fri, 18 Oct 2024 18:55:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1s87tmIi8827n1s87tyuqb; Fri, 18 Oct 2024 18:55:19 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=6712af17
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=1cCw6Q031rO_cLs8eM8A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KrrHr3IraN34Z7RX5pMYVY2PbGjQrd0P+774MqXGDuM=; b=sZGQoEtsG0vy1dYKYMPwugisEF
	6RFiB5MLfeCqdEgdeLf6elPw+zhdYUUFYR7g2xW7vi6MIQvzvngqrEHhEKC1yHicB+fqEKOsh2HYK
	zdyy/Cv6DxRnSNE7mdCF0KJKfkDRalzdRGW3AGAx91xeMnX36z59pq+9b9jDaUKiaxowEoSEW+6HB
	RGqUzVywxRLkD/4HbdA7eStG/bze7zndB8rWKS902vb1aGeoLxIC7DXv6RAdwal1S2OP286Qf5+Eq
	cLg5LZQQKACAOHMTnjyx6fOMbl52j32doIYDiQeXbXHEaRDhbLFL2TPS8frIVVE1hrWKuLBHk1m9h
	41rQWJ3g==;
Received: from [201.172.173.7] (port=46946 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t1s84-001YNE-32;
	Fri, 18 Oct 2024 13:55:16 -0500
Message-ID: <7bef8129-55b4-40e4-80c2-d319b8d6c251@embeddedor.com>
Date: Fri, 18 Oct 2024 12:55:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <cover.1729037131.git.gustavoars@kernel.org>
 <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
 <ac2ea738-09fb-4d03-b91c-d54bcfb893c6@lunn.ch>
 <202410160942.000495E@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202410160942.000495E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t1s84-001YNE-32
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.7]:46946
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNqPTXMfQcJ/gElXgE7UzMCMFJqkuQMnOOF4lFCrctStsjCj+WGtgVt4Y/riOLLSHG5WHxxZ0WXkBz52LuZP1rop7EhUPY7K0Z5CxZ1q8hdMjaIEP5rD
 M9CvjblZxFuuwGxElcI2uocV6EpxgUagb5zh/jSVi+4ZHQoY3Hkn2Fxh11mvGSD0ot/m0gjiFB1vOPylS1xI0fPGuq6ivfExBdXX1iwYi56//U2REGD0jRZS


>> These are clearly UAPI files. It would be good to state in the commit
>> message why this is a safe change, at the source level.

Yes, I'll update it!

> 
> I think we can avoid complicating UAPI by doing something like this in
> include/uapi/linux/socket.h:
> 
> #ifdef __KERNEL__
> #define __kernel_sockaddr_legacy        sockaddr_legacy
> #else
> #define __kernel_sockaddr_legacy        sockaddr
> #endif
> 
> And then the UAPI changes can use __kernel_sockaddr_legacy and userspace
> will resolve to sockaddr (unchanged), and the kernel internals will
> resolve to sockaddr_legacy (fixing the warnings).

Here are a couple of test patches (Don't mind the changelog text):

https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20241015-2&id=c3b631a5036cbf45b3308d563bf74a518490f3e6
https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20241015-2&id=66db096a530b95ce0ac33f9fdec66401ec5f2204

__kernel_sockaddr_legacy seems a bit too long, but at the same time
it makes it quite clear what's going on.

Thanks
--
Gustavo

