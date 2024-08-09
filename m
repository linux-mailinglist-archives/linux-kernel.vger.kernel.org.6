Return-Path: <linux-kernel+bounces-281120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC494D350
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D735E1F21F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F3198857;
	Fri,  9 Aug 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qJznsSdi"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C7198E6D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216891; cv=none; b=L1ZtI4Bpf6t7Srm1lFUtnhQ2fK5AR9bW9Y1Pyx00dQH/SYdy2JEGk+1n2w3WvMPI+zbHCi+KBcCr74jQBty7a9rvbtI9uvXkhFtlF/6GdkJaFNnaHyLgvn9ol/dBEsKalrUu1Sks97ZYb0qLDTLt4smAvXMEzTV5NJAV8iNqYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216891; c=relaxed/simple;
	bh=YF2j1+300pl2tJxsYrUBAqHlJ5+NsKgS1Kx7u3KmH5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwpZEr8QkOwyi3SxM+FIROtLrOShSrgYdtn3e0XCj7Xvc8XxrGgnfDIOCBf2OiOqDJey4B1XpZfsJTy676Rm/0V1wkcahMrSDUvf47x3x6ZpoNdW9Zj21eYPFfCB2bt8kQ2nHLOru9NBlVT3aO1aRulOCg0SWdlezVG2DcXUk8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qJznsSdi; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id cQU8sSd24nNFGcRQmsco94; Fri, 09 Aug 2024 15:21:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id cRQlsw0UG0vWTcRQlsS3kS; Fri, 09 Aug 2024 15:21:27 +0000
X-Authority-Analysis: v=2.4 cv=ffZmyFQF c=1 sm=1 tr=0 ts=66b633f7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=T-l7Lcn7wvsJkd90kOwA:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ahVHeUMbhgnB+4j25dq8VaYi1sZLU1wW+FemcJlE7HA=; b=qJznsSdiEPtuO2wrUGnlBQKaGZ
	yk58PbqpzGYOPOD62nYNFmqLHJohRgT9AdyvnzFTD+XsyxvR0adWHccEXXLdOLJVjb81UXG3qXHAL
	mxnGSOiNVZTVdve7q/fCKEPhFA5cUkoQALBXkjSpIx0dF322hdy+pywWD2m7bv+tIGNx348LnV3Y6
	oM6qbYHM64w33S2wwl3hMWJcZZ2jfsQinBAdGLjDABBLkPqUlvS8IALblA1b5aWRMMJOdbjz4vVvk
	g4hrDEJZ1+rZ7+t4ZKjOTe6UR+Yzij+kasVhBgUQYb9kZ6QlOqrWgAV88jB+r/COqmpKbS/QvfuxH
	eXyu14vg==;
Received: from [201.172.173.139] (port=54138 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1scRQk-002rcf-2B;
	Fri, 09 Aug 2024 10:21:26 -0500
Message-ID: <cc27ae84-e759-480b-a1ff-2fac4494307b@embeddedor.com>
Date: Fri, 9 Aug 2024 09:21:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] sched: act_ct: avoid -Wflex-array-member-not-at-end
 warning
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZrDxUhm5bqCKU9a9@cute> <20240808194655.6bd39d2e@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240808194655.6bd39d2e@kernel.org>
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
X-Exim-ID: 1scRQk-002rcf-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:54138
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGEp/9vKcDCDj3hY+/im2XvmgMsWVr7t6VMlDv5+3xRoPRM8pPvE+ypdftBG6fe4IidvBc0skreYTLzaLUs3+qYqk6CkQvII9uTeespbQXJmhvxYmdZk
 2MeYEW3x2RrPh3iFlRM7xJ5arRRlPCoGSBQeoU3Ct/6DQu/bjEoEz7mCOc4GTsq9S3BbNe8KU9D7rQYM91pk73qCClT5wiz/mXGJQ5EQD2V+aq8BCebW7LYu



On 08/08/24 20:46, Jakub Kicinski wrote:
> On Mon, 5 Aug 2024 09:35:46 -0600 Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct zones_ht_key` is a flexible structure --a structure that
>> contains a flexible-array member.
> 
> I think the flex member is there purely to mark the end of the struct.
> You can use offsetofend(zone) instead of offsetof(pad), and delete pad.

Nice! I'll send v2, shortly.

Thanks
--
Gustavo

