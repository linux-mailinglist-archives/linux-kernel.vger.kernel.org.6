Return-Path: <linux-kernel+bounces-190440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C1D8CFE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED66928458A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89313B5AB;
	Mon, 27 May 2024 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="AW08ziET"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363F3A8C0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806727; cv=none; b=e+Gj8Y2AXTLFnEMFVDVC2/r22QL8FLbzpyo6dQrMPWcQ6U8FjoJkSPQZhKDXgdKNtgti6TyfuHcDzcxBybznj3uXxutnvYPHNLj1dL5cDduzwq4jJ+4KSd0zg6PJFQpTPeSIXZrxM/K6bFJQz1QH6bS/MuYsXXKnz93KKTE5lZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806727; c=relaxed/simple;
	bh=rKvMLo7joCjKiFuHZ58luWYMNXJKJf8/fNkgpcBwjf8=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=jRWwuTaKHh5mHWTxUBUHfJ94bzqrClFjcudj/JIuPc5sgeOJBIkAtGMb6qXQ8UR7MJ4OJyz46jvvU1OxG1YpG85FD0TgvTKBztL73RW9pI+T4w4snxFWmLkYrGpsCjw5Oev+MHzGCJ8v4eFjMEiBxxdQchUh/YPQg7XWdezxnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=AW08ziET; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id BSKIs7RLbAidIBXqwsnhNv; Mon, 27 May 2024 10:45:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id BXqvsLuemr1IfBXqvs5qxU; Mon, 27 May 2024 10:45:17 +0000
X-Authority-Analysis: v=2.4 cv=BawT0at2 c=1 sm=1 tr=0 ts=6654643d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=thD_vAUaAAAA:8
 a=PHq6YzTAAAAA:8 a=VwQbUJbxAAAA:8 a=q2727y1HDB8PbVJpZgoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kl19cmx7V54we018lLRm:22 a=ZKzU8r6zoKMcqsNulkmm:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aUdqAH9GyHh2gGt9rAEDpDY6ZVQgxj4JgC7F5xnaUIY=; b=AW08ziETFpPq9nt3K5E4rg9qIb
	TB8iJt/978hcyy9ZJMDZOLzFEdiWeCN0A1pFVYpc+WFqsx3ZAWz11DdCxkbws8zHXx6of35e0m0Ba
	x8xa53VRegGuwEs7i/7rzZJjktPia6dFyec59HPHoDtvf3OQwUcAN7+CeJMUZk7/Ga123viY73W3c
	BlGhixembTig/EKu5yBGKjcyaCsLt+UwD+qNkvUtz91DKI9CFLNBQaHDFOVtY+PVWpzBGhy0sZ2MJ
	HMX/bvLLqcO8chkjzWzoJTCoqAWDCbw8rsmdld9AFRnW7qbWq+WDjr3rvvE6QTWqAAKY+nc/mY/om
	SzXiD6pg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:40150 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sBXqu-001gJc-2a;
	Mon, 27 May 2024 04:45:16 -0600
To: Guenter Roeck <linux@roeck-us.net>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 regressions@lists.linux.dev, linux-clk@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>
From: Ron Economos <re@w6rz.net>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
Message-ID: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
Date: Mon, 27 May 2024 03:45:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1sBXqu-001gJc-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:40150
X-Source-Auth: re@w6rz.net
X-Email-Count: 5
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBPrObc/6++HGsBB7ThX0H+CpCKwDM4EILdzVZU+e/Omwy/m1ua8tXqMw4rb7Ld+RphnoOoSm5cc0odE8Sbuu38W+uzKIjPhwsM1z8Uw+VUdLDpTuIPF
 dN6aYaCcjx7m8VwstNC0Am/QMHyx/Dpj9FoB87/wErhcy1adByEbDJqAyOJCguhIq0t5DttgMb4hWtuqjuDQ9KK1PXRdpSWtS+U=

On Fri, May 17, 2024 at 03:09:14PM -0700, Guenter Roeck wrote:
 > Hi,
 >
 > On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
 > > Report an error when an attempt to register a clkdev entry results in a
 > > truncated string so the problem can be easily spotted.
 > >
 > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
 > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
 > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
 >
 > With this patch in the mainline kernel, I get
 >
 > 10000000.clock-controller:corepll: device ID is greater than 24
 > sifive-clk-prci 10000000.clock-controller: Failed to register clkdev 
for corepll: -12
 > sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
 > sifive-clk-prci 10000000.clock-controller: probe with driver 
sifive-clk-prci failed with error -12
 > ...
 > platform 10060000.gpio: deferred probe pending: platform: supplier 
10000000.clock-controller not ready
 > platform 10010000.serial: deferred probe pending: platform: supplier 
10000000.clock-controller not ready
 > platform 10011000.serial: deferred probe pending: platform: supplier 
10000000.clock-controller not ready
 > platform 10040000.spi: deferred probe pending: platform: supplier 
10000000.clock-controller not ready
 > platform 10050000.spi: deferred probe pending: platform: supplier 
10000000.clock-controller not ready
 > platform 10090000.ethernet: deferred probe pending: platform: 
supplier 10000000.clock-controller not ready
 >
 > when trying to boot sifive_u in qemu.
 >
 > Apparently, "10000000.clock-controller" is too long. Any suggestion on
 > how to solve the problem ? I guess using dev_name(dev) as dev_id 
parameter
 > for clk_hw_register_clkdev() is not or no longer a good idea.
 > What else should be used instead ?

This issue causes a complete boot failure on real hardware (SiFive 
Unmatched). The boot only gets as far as "Starting kernel ..." with no 
other indication of what's going on.

Guenter's suggested patch solves the issue.

diff --git a/drivers/clk/sifive/sifive-prci.c 
b/drivers/clk/sifive/sifive-prci.c
index 25b8e1a80ddc..20cc8f42d9eb 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -537,7 +537,7 @@ static int __prci_register_clocks(struct device 
*dev, struct __prci_data *pd,
                          return r;
                  }

-               r = clk_hw_register_clkdev(&pic->hw, pic->name, 
dev_name(dev));
+               r = clk_hw_register_clkdev(&pic->hw, pic->name, "prci");
                  if (r) {
                          dev_warn(dev, "Failed to register clkdev for 
%s: %d\n",
                                   init.name, r);


