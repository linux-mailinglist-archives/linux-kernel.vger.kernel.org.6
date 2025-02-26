Return-Path: <linux-kernel+bounces-532933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD2A453EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B7A3A1E26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40202505B1;
	Wed, 26 Feb 2025 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WdLpB0Fe"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758023A9B3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539884; cv=none; b=mUfx2hcL4/T4orlvrogbnLapLGmOaYpUhiNXMaXcmK34Qrbz2+UPY5vD8iPY3zZwpmfT4SLttnvKhQP6ucsKdc+EqfyM3cxv0ZUC5bf+L771reCoR6NDVmGKWMfPeBtWbMN1NqH14kTqRvYXs/Lvimvcl3UPmE/RrjrjYb1sz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539884; c=relaxed/simple;
	bh=FlRtG5Qg0GsSwLV0DMQVtkpwIcyO/yTA4JLXKw3G1C4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 References; b=bGbe7MOm3z28zut1twcqqjzqBdqnkjE55N7Jz0iGoOZWV36pYWvRM1isoJSzA8XtSh3bQkAjnfq1bwNAX6gAQdku1ILRdP6J2FXF8l9mbH2+i78NRG8GgOApOCIFWE2eG1+c0O8BufbA4nWZI1jzk9NKiep0FM/P4WeYo8beuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WdLpB0Fe; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250226031757epoutp0306fb531f7241e64e91b16bfac93f6f80~no8wD5YvF1099310993epoutp03b
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:17:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250226031757epoutp0306fb531f7241e64e91b16bfac93f6f80~no8wD5YvF1099310993epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740539877;
	bh=whgbmdNBjy2fxsYiRHNo+K3C3SdesV6ZWCOz7KtrJD0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WdLpB0Fe+K2BBMXPKOGHRFozRHuBeWuGOV6qd578jdeAl9kIfa4Z4uiQuH/rurszW
	 y00Uii4DUJW7gUrFL4cjGtLyv4F+3SNbB9TVWSY+9DLKgeLT+KTEym4WYQfnJ7ebJy
	 qjoeRP6ypg0WwmDPV+rod+H5yMJ8YZDj2kEz3qmU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250226031757epcas2p2c9e76c65a2adc0990a1d51e714876d62~no8vxjcYa3165731657epcas2p2y;
	Wed, 26 Feb 2025 03:17:57 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.69]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z2fmh3gC2z4x9Pp; Wed, 26 Feb
	2025 03:17:56 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.8A.22938.4E78EB76; Wed, 26 Feb 2025 12:17:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0~no8uq02oB2201822018epcas2p3d;
	Wed, 26 Feb 2025 03:17:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250226031756epsmtrp2c1a292fe43e82fad3696e4df7bd64e3c~no8uqK6sH1292112921epsmtrp21;
	Wed, 26 Feb 2025 03:17:56 +0000 (GMT)
X-AuditID: b6c32a43-99d9b2400000599a-52-67be87e47463
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.FA.23488.3E78EB76; Wed, 26 Feb 2025 12:17:56 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250226031755epsmtip28f1ff721349e0bbaf40d1b156a9e4bd6~no8ufzFc60226702267epsmtip2l;
	Wed, 26 Feb 2025 03:17:55 +0000 (GMT)
Date: Wed, 26 Feb 2025 12:16:28 +0900
From: Donghyeok Choe <d7271.choe@samsung.com>
To: pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, john.ogness@linutronix.de,
	takakura@valinux.co.jp, youngmin.nam@samsung.com, hajun.sung@samsung.com,
	seungh.jung@samsung.com, jh1012.choi@samsung.com
Subject: printk: selective deactivation of feature ignoring non panic cpu's
 messages
Message-ID: <20250226031628.GB592457@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVPdJ+750g6m3JS2a9l9itng0fS2r
	xbYr8xktLu+aw2bx//FXVoujt56yW0za18hksfjAJ3YHDo93586xe/RtWcXosX7LVRaPT9Om
	sXt83iQXwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
	lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQ
	wMDIFKgwITvj2b6b7AWtEhULvy5jamCcL9TFyMkhIWAi8WbyR9YuRi4OIYEdjBInprazQzif
	GCV63k9gB6kSEvjGKHHkbAZMR8vkeWwQRXsZJR5OX8QE4TxllJh6fiFYB4uAqsTElW/ZQGw2
	AV2JSZ3bgGwODhEBEYlb6xRA6pkFdjNKtN7cwQRSIywQJvGzew0jiM0LVH/p8CQoW1Di5Mwn
	LBCbb7FLrL5gCWG7SHS+WcYKYQtLvDq+hR3ClpL4/G4v2HUSAs2MEpNuvGaCcGYwSlyZ/JkJ
	ospYYtazdrANzAKZEjuPL2EBuU5CQFniyC0WiDCfRMfhv+wQYV6JjjZoeKlInO97wAiza8Pc
	t1ATPSTmv9rHBAmtWIl3rycyT2CUnYXkhVlIlkHYOhILdn9imwW0gVlAWmL5Pw4IU1Ni/S79
	BYysqxjFUguKc9NTk40KDOGRmpyfu4kRnBy1nHcwXpn/T+8QIxMH4yFGCQ5mJRFezsw96UK8
	KYmVValF+fFFpTmpxYcYTYHxMZFZSjQ5H5ie80riDU0sDUzMzAzNjUwNzJXEeat3tKQLCaQn
	lqRmp6YWpBbB9DFxcEo1MDFty6r/lGy1SOnRh5C2P2eLfWKviXfws0i2fAq/kSAlaVllytNY
	pmuuet/2watNcTGtm6OSvC+dTLuxtbznRvrUhxunsv5g6Q1fmvmq+65xQF9iPquewYW1uvNX
	hYfyXYxcVTT94XGxd3Lnl6Sv918jZax5ocjqENNjUcXU0pfsqW9+PDD++iGL+yGDvuHLd3cn
	eyio3xK8ePX3NM1VPO03uZLk+2vsf9/SuFd75eup6S6KL7uunuy751tlVMNmaua/8DXvOaEq
	RW+B7XubqyLm71NI0N+/nWPuyxSvTQGljldjH2keV5uv+HXdqvvZp+xi+DY/dWb/EdhZsmfr
	8yuX7HXOcb7o+u/6cv6GNCWW4oxEQy3mouJEAG2hnYEXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvO6T9n3pBp8uMFs07b/EbPFo+lpW
	i21X5jNaXN41h83i/+OvrBZHbz1lt5i0r5HJYvGBT+wOHB7vzp1j9+jbsorRY/2Wqywen6ZN
	Y/f4vEkugDWKyyYlNSezLLVI3y6BK2PS9d3sBYdEK5Yfymtg/MrfxcjJISFgItEyeR5bFyMX
	h5DAbkaJ/w8vM0IkpCTat8xkgrCFJe63HGGFKHrMKHHi8V5WkASLgKrExJVv2UBsNgFdiUmd
	24BsDg4RARGJW+sUQOqZBfYySix4fYQZpEZYIEziZ/casAW8QPWXDk+CsgUlTs58wgJiMwto
	Sdz495IJZA6zgLTE8n8cExj5ZiGpmoWkahZC1QJG5lWMkqkFxbnpucmGBYZ5qeV6xYm5xaV5
	6XrJ+bmbGMEhrKWxg/Hdtyb9Q4xMHIyHGCU4mJVEeDkz96QL8aYkVlalFuXHF5XmpBYfYpTm
	YFES511pGJEuJJCeWJKanZpakFoEk2Xi4JRqYGpQm7fVVlbI2VJe0KftSl/oPnuWmqnRJ9/P
	PfDj8wJLG7mLtSZ2arOtSlI7H+hLWJVJ1jrZqv+0jaqprbb8EMqyr8P7fEvV1zpFwQU/P4ap
	rfv1P+jrXYN6qSKnvT94JnItPKvoHZ7XsPOmWYmgQpnjEqbZ854dZZ/JycnBE/TuYcCK87ff
	lVkxqjzoO9Vqc413kaDLf997q/xN+j++9r/MEs3WX+mxd5fJuUjn6IxNB1sTjVdMzJNTkPs+
	cWaE/y7X3muts4PubKw1vBD06/zkSNXzjGs/3MnfEnD3Wa29tljsssOe12qi8s8yacSlROnk
	phr3frVKv/ib+Wlb6tWr+z28nPZcS763a5apEktxRqKhFnNRcSIAVQfyRNACAAA=
X-CMS-MailID: 20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_147cc5_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>

------7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_147cc5_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello.

In 'Commit 779dbc2e78d7', a feature was included in which the message
from non panic cpu was ignored. I understand that panic cpu's message
is the most important feature in the SW livelockup issue.

However, SOC vendor's linux kernel device driver developers
in environments where hw reliability is not guaranteed The message
from non panic cpu is also important.

In the process of performing a panic when a specific cpu is fault,
another cpu has the ability to output important err information
through interrupt. If a particular cpu has an incorrect sfr access,
the debugging device driver's ISR behavior to debug it helps you
identify the problem easily.

I can output non panic cpu's backtrace through Commit bcc954c6caba,
but this seems to be not enough for me.
I would like to print out the message of non panic cpu as it is.
Can I use early_param to selectively disable that feature?

For example, as below.
I'm sending you an inquiry instead of a patch because I need to share
more about my problem situation.
Please forgive me if I broke the mailing etiquette.

ex)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fb242739aec8..3f420e8bdb2c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2368,6 +2368,17 @@ void printk_legacy_allow_panic_sync(void)
        }
 }

+static bool __read_mostly keep_printk_all_cpu_in_panic;
+
+static int __init keep_printk_all_cpu_in_panic_setup(char *str)
+{
+       keep_printk_all_cpu_in_panic = true;
+       pr_info("printk: keep printk all cpu in panic.\n");
+
+       return 0;
+}
+early_param("keep_printk_all_cpu_in_panic", keep_printk_all_cpu_in_panic_setup);
+
 asmlinkage int vprintk_emit(int facility, int level,
                            const struct dev_printk_info *dev_info,
                            const char *fmt, va_list args)
@@ -2379,13 +2390,15 @@ asmlinkage int vprintk_emit(int facility, int level,
        if (unlikely(suppress_printk))
                return 0;

-       /*
-        * The messages on the panic CPU are the most important. If
-        * non-panic CPUs are generating any messages, they will be
-        * silently dropped.
-        */
-       if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
-               return 0;
+       if (!keep_printk_all_cpu_in_panic) {
+               /*
+                * The messages on the panic CPU are the most important. If
+                * non-panic CPUs are generating any messages, they will be
+                * silently dropped.
+                */
+               if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
+                       return 0;
+       }

Thank you.

------7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_147cc5_
Content-Type: text/plain; charset="utf-8"


------7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_147cc5_--

