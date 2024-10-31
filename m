Return-Path: <linux-kernel+bounces-390337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7209B788B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9091C240B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3E1990DE;
	Thu, 31 Oct 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="dtn73n0r"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2921198842
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370103; cv=none; b=pIiBQjWOSp+vLgfSBfac7Okdo2DV9q6EZQ31aO0EqWuvoF7zZrinmTZZcTfUU6lxyD0lO3VunhyMZb+59D1WjCHeSDZHPqZ16+Q/db1pz+qWFA9BXk0D+u7IP9KiSwuV8Tjd1soyjTOZzZPTyj5ID5Kr8tCg9xh5PQj8y4XtqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370103; c=relaxed/simple;
	bh=VMRdJm2iPVZ9NEFsp5K7b4QyZ+yz0VNkGPKuNL3e9kg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOLYEpGU8qpftXYZ6v0KHDYBw5mUO/iuKVtSufanv3rPVuddw/9S8j8Mlg8qFMWmX7xbZPGjT5uIKyeZrNimAINwFhjih8ePgxJlqd0IiCql0eFHLEWepvmA+k0KNlDfrIfKiT2cKlmQ4QToWsMcQ65eSGfUnJAoS570rQD06Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=dtn73n0r; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730370095; x=1730974895; i=efault@gmx.de;
	bh=Vnti2AGSrPFnzLrZE2hR13Xa35l0I7YXOqGNiR8vqto=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dtn73n0r85uKvOZGDZX1YCCavlubO4V++dWU0s2o1tS4vFe0jadiVLdHH02aNo1u
	 HcZPUSbjYeLwrHYKmjianhm0OtErYCmsS0FkCJG3BzL67XpmrHI+wEkppH1kOOrzP
	 GX0SXlN3g1XkHtfRCA13pffvX708ckY+Q10kIGML7wcrTUCYfKSLgcVZAHGToc6dt
	 dJj3mP/BE619Kqj8L+IR4E1ZlGRKtWtnDyG6mAa10gFzSulQ0hmDOFiQ2sQWSmTJn
	 j2Dz3fO9nIF5mM0B5DQFy89SRd8SgHRVJF/a4q4ih66/nsIwScOqlwtoycnfN9v3q
	 Nu0wc4yS9bYXKbPpzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.187]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1tDrMY2fZF-002Eg7; Thu, 31
 Oct 2024 11:21:35 +0100
Message-ID: <235e470402ee86a6bf94cfe73543b0c0f5a42071.camel@gmx.de>
Subject: RFC [PATCH1] mm: vmscan: Limit isolate_lru_folios() IRQ holdoff
 latency impact
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>
Date: Thu, 31 Oct 2024 11:21:34 +0100
In-Reply-To: <88ae633aa910c7e320b89e5f4779d472f7cffffb.camel@gmx.de>
References: <88ae633aa910c7e320b89e5f4779d472f7cffffb.camel@gmx.de>
Content-Type: multipart/mixed; boundary="=-edTnI5FBai7pAguU7boe"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:sk2kb5Jd5sO2tHpqGdYyzvcw5MkUz5GbQwKTXYXHSx8X4XnGvsz
 m9hXQK4SkFI1JwNk5vYASrH0Rwugy3cCcZgIYhyMCnor4R6kURY/zfbzOvIRT+btQkxsxKd
 CX+JaIG2u4dmI3vszBdxpW/+Cb8y/k48nKCT3E5RPa0JaiAz5tWD/B6NUZ/+XLvI+39xFe3
 8df+P9w9bJO2i0hxfIEbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JKVogsXjwqM=;LwqKlXR14RZewERScfnCPXmeg/c
 GwKc7LhThWgJRJ9AudDZbCOpBkLmNWzBEJ56jg20w+wJ5mvxZLFyFqacj6oBTIed62HBiAfd1
 k3YRzcLScVW64zmgKfFcaSqMZ90U2QGkwedEG8lFPEWImFy0D9Za1z5dm8TVRJRMuQv0Zvkz2
 xxz3y7u/DfElGfFepqMmCMxA8ra7YLJO8fwb88eLO0GLNEU666fOU7Y8y0Kby+fCDxvpeLAer
 eN9UbpfUCXvavnNha7wBd7rsJMXrYzrC76wYQIjaqioDvko+N48CqJVqw/0iCcS5GXYekAcM3
 0bw66qovaZfhWB2tl9xPZ8Y7kLm+r5XVPLOHhUwdi9T3cSEaG0JP8HOnZ6Ef/inM9CMMmC1Ou
 jXIvFgGp+tbv9Yre3kEtawE/oAAVFjjw1MGI8H5UjS2GxKarHagyqAyQL9ldHPsnbV6bnpsLa
 RNVC7MvP/z4sspijQscS71/il0u5yMBZ/m81vKBGmlNocQfs6AI7XaqLvrgdjRHkVC+9XyK/a
 ojstxGphbpXGVl/iNYPUgC+1usaELYL77A891jPRzzViuEkxGUlB9F1hZOh/yQxcpbQUfDJK/
 7T46ayTK5dP4wf12HHUmHL8mTZ/cdym7CvEDhgwVfB2rQOxnKsT0R1O/uac7llk+sp2DzXL10
 eRIM7hZfCnsXuEkMSZEaeBvMD322Qiy8HI1mO6J6FJJbV8P98G7wpSxGXmbmK9ALUo6urHA5o
 0xWC5Gn5uFq12PVF3IpuSRkJ2WkytAcExextdezb4wRQeAeEnp7Sok/bvt1+tKWrYKkMMrLAN
 xkM5Un0kcC8LzWsMRamiH2Ow==


--=-edTnI5FBai7pAguU7boe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(was regression: mm: vmscan: - size XL irqoff time increase v6.10+)


While examining a service latency regression beginning at v6.10, it was
discovered that isolate_lru_folios() runtimes could cause IRQ holdoff
spanning several ticks.  Worse measured was 78ms.

Given it's called with IRQs disabled, cap its runtme to around a ms.

With this patch, and one to mitigate move_expired_inodes() induced
wakeup latency hits up 66ms, the load that repeatably produced this:

(6.12.0-rc5 running osc kernel package build + ram sized bonnie)
T: 0 ( 4541) P:99 I:1000 C: 773124 Min:      1 Act:    6 Avg:    3 Max:   =
53381
T: 1 ( 4542) P:99 I:1500 C: 515381 Min:      1 Act:    7 Avg:    3 Max:   =
60119
T: 2 ( 4543) P:99 I:2000 C: 386465 Min:      1 Act:    5 Avg:    4 Max:   =
67469
T: 3 ( 4544) P:99 I:2500 C: 309182 Min:      1 Act:    7 Avg:    4 Max:   =
65534
T: 4 ( 4545) P:99 I:3000 C: 257682 Min:      1 Act:    6 Avg:    4 Max:   =
57776
T: 5 ( 4546) P:99 I:3500 C: 220874 Min:      1 Act:    4 Avg:    4 Max:   =
64737
T: 6 ( 4547) P:99 I:4000 C: 193289 Min:      1 Act:    6 Avg:    4 Max:   =
52567
T: 7 ( 4548) P:99 I:4500 C: 171799 Min:      1 Act:    6 Avg:    5 Max:   =
52606

latency went to this:

T: 0 ( 6078) P:99 I:1000 C:1031230 Min:      1 Act:    7 Avg:    4 Max:   =
 4449
T: 1 ( 6079) P:99 I:1500 C: 687505 Min:      1 Act:    5 Avg:    4 Max:   =
 2075
T: 2 ( 6080) P:99 I:2000 C: 515627 Min:      1 Act:  334 Avg:    5 Max:   =
 2987
T: 3 ( 6081) P:99 I:2500 C: 412503 Min:      1 Act:    8 Avg:    5 Max:   =
 2425
T: 4 ( 6082) P:99 I:3000 C: 343752 Min:      1 Act:   11 Avg:    5 Max:   =
 1466
T: 5 ( 6083) P:99 I:3500 C: 294643 Min:      1 Act:  282 Avg:    5 Max:   =
 3844
T: 6 ( 6084) P:99 I:4000 C: 257813 Min:      1 Act:    7 Avg:    5 Max:   =
 3291
T: 7 ( 6085) P:99 I:4500 C: 229167 Min:      1 Act:    9 Avg:    5 Max:   =
 3516

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 mm/vmscan.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -63,6 +63,9 @@
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
 #include <linux/sched/sysctl.h>
+#ifndef CONFIG_PREEMPT_RT
+#include <linux/sched/clock.h>
+#endif

 #include "internal.h"
 #include "swap.h"
@@ -1657,6 +1660,10 @@ static unsigned long isolate_lru_folios(
 	unsigned long skipped =3D 0;
 	unsigned long scan, total_scan, nr_pages;
 	LIST_HEAD(folios_skipped);
+#ifndef CONFIG_PREEMPT_RT
+	u64 then =3D local_clock();
+	int batch =3D 0;
+#endif

 	total_scan =3D 0;
 	scan =3D 0;
@@ -1709,6 +1716,18 @@ static unsigned long isolate_lru_folios(
 		move_to =3D dst;
 move:
 		list_move(&folio->lru, move_to);
+
+#ifndef CONFIG_PREEMPT_RT
+		/*
+		 * IRQs are disabled, cap holdoff at a millisecond or so.
+		 */
+		batch +=3D nr_pages;
+		if (batch < 1024)
+			continue;
+		if (local_clock() - then >=3D NSEC_PER_MSEC)
+			break;
+		batch =3D 0;
+#endif
 	}

 	/*


--=-edTnI5FBai7pAguU7boe
Content-Disposition: attachment; filename="irqoff-trace-6.12.0.g4236f913-master"
Content-Type: text/plain; name="irqoff-trace-6.12.0.g4236f913-master"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyB0cmFjZXI6IGlycXNvZmYKIwojIGlycXNvZmYgbGF0ZW5jeSB0cmFjZSB2MS4xLjUgb24gNi4x
Mi4wLmc0MjM2ZjkxMy1tYXN0ZXIKIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIGxhdGVuY3k6IDc3NzY2IHVzLCAj
MTIvMTIsIENQVSM1IHwgKE06dW5rbm93biBWUDowLCBLUDowLCBTUDowIEhQOjAgI1A6OCkKIyAg
ICAtLS0tLS0tLS0tLS0tLS0tLQojICAgIHwgdGFzazoga3N3YXBkMC05MCAodWlkOjAgbmljZTow
IHBvbGljeTowIHJ0X3ByaW86MCkKIyAgICAtLS0tLS0tLS0tLS0tLS0tLQojICA9PiBzdGFydGVk
IGF0OiBfcmF3X3NwaW5fbG9ja19pcnErMHgxNi8weDQwCiMgID0+IGVuZGVkIGF0OiAgIF9yYXdf
c3Bpbl91bmxvY2tfaXJxKzB4MTAvMHgzMAojCiMKIyAgICAgICAgICAgICAgICAgICAgXy0tLS0t
LT0+IENQVSMgICAgICAgICAgICAKIyAgICAgICAgICAgICAgICAgICAvIF8tLS0tLT0+IGlycXMt
b2ZmL0JILWRpc2FibGVkCiMgICAgICAgICAgICAgICAgICB8IC8gXy0tLS09PiBuZWVkLXJlc2No
ZWQgICAgCiMgICAgICAgICAgICAgICAgICB8fCAvIF8tLS09PiBoYXJkaXJxL3NvZnRpcnEgCiMg
ICAgICAgICAgICAgICAgICB8fHwgLyBfLS09PiBwcmVlbXB0LWRlcHRoICAgCiMgICAgICAgICAg
ICAgICAgICB8fHx8IC8gXy09PiBtaWdyYXRlLWRpc2FibGUgCiMgICAgICAgICAgICAgICAgICB8
fHx8fCAvICAgICBkZWxheSAgICAgICAgICAgCiMgIGNtZCAgICAgcGlkICAgICB8fHx8fHwgdGlt
ZSAgfCAgIGNhbGxlciAgICAgCiMgICAgIFwgICAvICAgICAgICB8fHx8fHwgIFwgICAgfCAgICAv
ICAgICAgIAoga3N3YXBkMC05MCAgICAgICAgNWQuLi4uICAgIDB1cyA6IF9yYXdfc3Bpbl9sb2Nr
X2lycSsweDE2LzB4NDAKIGtzd2FwZDAtOTAgICAgICAgIDVkLi4uLiAgICAwdXMgOiBwcmVlbXB0
X2NvdW50X2FkZCsweDAvMHg1MCA8LV9yYXdfc3Bpbl9sb2NrX2lycSsweDIwLzB4NDAKIGtzd2Fw
ZDAtOTAgICAgICAgIDVkLi4xLiAgICAwdXMqOiBpc29sYXRlX2xydV9mb2xpb3MrMHgwLzB4M2Uw
IDwtc2hyaW5rX2luYWN0aXZlX2xpc3QrMHgxMGYvMHg0NDAKIGtzd2FwZDAtOTAgICAgICAgIDVk
Li4xLiA3Nzc2NXVzIDogX19yY3VfcmVhZF9sb2NrKzB4MC8weDIwIDwtaXNvbGF0ZV9scnVfZm9s
aW9zKzB4MTYwLzB4M2UwCiBrc3dhcGQwLTkwICAgICAgICA1ZC4uMS4gNzc3NjV1cyA6IF9fcmN1
X3JlYWRfdW5sb2NrKzB4MC8weDE4MCA8LWlzb2xhdGVfbHJ1X2ZvbGlvcysweDE5OS8weDNlMAog
a3N3YXBkMC05MCAgICAgICAgNWQuLjEuIDc3NzY2dXMgOiBfX21vZF9ub2RlX3BhZ2Vfc3RhdGUr
MHgwLzB4NzAgPC1pc29sYXRlX2xydV9mb2xpb3MrMHgyZWUvMHgzZTAKIGtzd2FwZDAtOTAgICAg
ICAgIDVkLi4xLiA3Nzc2NnVzIDogX19tb2Rfem9uZV9wYWdlX3N0YXRlKzB4MC8weDYwIDwtaXNv
bGF0ZV9scnVfZm9saW9zKzB4MmZjLzB4M2UwCiBrc3dhcGQwLTkwICAgICAgICA1ZC4uMS4gNzc3
NjZ1cyA6IF9fbW9kX25vZGVfcGFnZV9zdGF0ZSsweDAvMHg3MCA8LXNocmlua19pbmFjdGl2ZV9s
aXN0KzB4MTJhLzB4NDQwCiBrc3dhcGQwLTkwICAgICAgICA1ZC4uMS4gNzc3NjZ1cyA6IF9yYXdf
c3Bpbl91bmxvY2tfaXJxKzB4MC8weDMwIDwtc2hyaW5rX2luYWN0aXZlX2xpc3QrMHgxNmEvMHg0
NDAKIGtzd2FwZDAtOTAgICAgICAgIDVkLi4xLiA3Nzc2NnVzIDogX3Jhd19zcGluX3VubG9ja19p
cnErMHgxMC8weDMwCiBrc3dhcGQwLTkwICAgICAgICA1ZC4uMS4gNzc3Njd1cyA6IHRyYWNlcl9o
YXJkaXJxc19vbisweGNiLzB4ZTAgPC1fcmF3X3NwaW5fdW5sb2NrX2lycSsweDEwLzB4MzAKIGtz
d2FwZDAtOTAgICAgICAgIDVkLi4xLiA3Nzc3NHVzIDogPHN0YWNrIHRyYWNlPgogPT4gc2hyaW5r
X2luYWN0aXZlX2xpc3QrMHgxNmEvMHg0NDAKID0+IHNocmlua19scnV2ZWMrMHgyZmMvMHg0NzAK
ID0+IHNocmlua19ub2RlKzB4MWQ2LzB4NGEwCiA9PiBiYWxhbmNlX3BnZGF0KzB4MjgwLzB4NWMw
CiA9PiBrc3dhcGQrMHgxMGYvMHgzNTAKID0+IGt0aHJlYWQrMHhmYS8weDEzMAogPT4gcmV0X2Zy
b21fZm9yaysweDJkLzB4NTAKID0+IHJldF9mcm9tX2ZvcmtfYXNtKzB4MTEvMHgyMAo=


--=-edTnI5FBai7pAguU7boe--

