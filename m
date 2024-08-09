Return-Path: <linux-kernel+bounces-281073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E994D2B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F49EB2261A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A8198E93;
	Fri,  9 Aug 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="BguUhqgs"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF87198857
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215259; cv=none; b=I5ArKtO6JlRqMr2MW5UJgT3vy+hpyKAmXLbgS4BN7Yv2QsTuhrCuhqONlD98dxxeaRWyUmzHSSSHl35LERQjOwZ1MebHG3mps7iMRCuTv2BZ+GXtDPDmIY/aFrQvyEhS3NcYNeCw90AGHv8m4SIAwpj9AGUYt4bL1g2F4nxjaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215259; c=relaxed/simple;
	bh=F4r1SDEDspkkGJVIp7wGrRgL/9GVTKZM0CjVdwMn7ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu7buTb5IXZFy8xkLzgXXACPM61Jq/8UkJkRBJd/8wQaBK9yiKojVXI+DTzGDs2qKl6q59x9Y4Qzs8mIlcYJcNH+/Ljh88OxGf4dPLhYV1EUtssi6h//E8nqPxrJXmR6xJIe7UFiApzl6Mtd0OTsfGbW5t0CBxgGeZEQMn8QGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=BguUhqgs; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723215204; x=1723820004; i=spasswolf@web.de;
	bh=iCMZstcGMe+1x8lfdwO0SvthifgHmTscD3Tqg2hX+To=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BguUhqgs4ZGRLUSY3iRUaM6Ygo0nVHzE7pEMP7pLftIN9p0KVudS/GFSnqmcZJVL
	 qGJv6MQLmqTzwX0ucOWE2rT0mpvy93dqEZ/9HQppDTGllJIYgyhSIk1jmhVPiMNIs
	 5jTSY13g/Z4XAYRxqfbHs3sfgQLI+MxRkuRqdr8U3nEeJHZ/Zdw555SErho3Vanmz
	 J3jdjVLle0EBOw1/5oCuUIlShYNI6lBJe4+BFlaSuHT4DXm/IsG/SmrrsMT+ukkWU
	 L0oVL7Nz1PtIwGfqgiQqKyeYSCqYuu+H17Sx14s47zEkh9vl6Ur1gjdlMZ+RhMK9l
	 QVBp0ppNVcrDMW5IuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N6sG3-1s8dfH21bL-015I34; Fri, 09 Aug 2024 16:53:24 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: mingo@kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	akpm@linux-foundation.org,
	Oleg Nesterov <oleg@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Fenghua Yu <fenghua.yu@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org
Subject: Re: commit 81106b7e0b13 can break asm_int80_emulation on x86_64
Date: Fri,  9 Aug 2024 16:53:19 +0200
Message-ID: <20240809145320.77100-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240808015752.65088-1-spasswolf@web.de
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GWJB+daNVqTrK5YVMnPWk6kAbywQQ/Zvt7qNtyTrsv7Q/5Qs2+l
 vqENDo2BVjmVd1p3Kfhsce2+Pq6N55dn8uW2m1sw/jh7j/RuLbLee026zLTmu2Ati8dkThD
 ETqg5BcKkS+DQq9yoTYVHxsaszVeGNAtJa3uLP7fXicfSq6HXww51yuaK3Ghdomlkj9aLtb
 3NuuhCjHTQiRVcl9Qomhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NAzLfyxshz4=;enQ70EJdQbRZaA5thxyiEwjLvGk
 BhG7eRXK+H5kk/PeibvJju/utyBfrK0KUPj8EpaHEDHsuWBmkmk1NhwOJ40b6kZODXv9jRE2k
 C4YZkYS3mWqGIkgcoI9rJ/5fozjym8X6pAT4RbhP48wveOazrTtqLS/Gvy9RoT3ghgL5r7vte
 xDpTj1HeX3j9BN2PgFmi8kbIFMJuMEWfvotVs7efFqZoQjWS6yeABDWyV08ZEBJYmmXdr75T7
 Z9osoPpKvNfmkByskRaM4Yc2MNKmBmZYQxqXowABihw6Uauzf6K5uzHMLP2UmMGBhArugKLyG
 fzKtGlYRGd1IFGLn3SfXq4Kxt0w/NL9DAPlHwgVtsWzbc9zjI6js/Q7OguUEHxpMPpcuCYCOk
 5NPZIrwbw8VmAAMbpceSKp2TFv3eY3HBkX17c+AfslJXPEL7tS+E96tNYJwIjCRxrbuyYcMu3
 tcREKcgkhQedPotIjUiNCfIaHWr94E5zUv4410wi9m/WcT4ffdIA3Nm+NR7ucsRBmVB+30d+u
 9OSZzwJEeAs8d84OrkFy32oe8kK+QYZhZbajdgLbFz9klcwiLvvFivTy/a/nxTndLtBpt5fLQ
 k/r3ifMp9N11lTXmSzN9a16MZFMBV/mY9B6qNSR3swN4YUgdTUE/idGmMtE3IpZCzsCSd/ECB
 11Akxcn7riWHbMwU3HRTFfmYQOjr+rGJ+IPxzjtz95Zo1SWKOU2C30Z3gBnYvKuQs1/tbQJ7I
 wXTVPs5jDfy/laAdxEraPiXlnzmzzkyySNY4C5mm+yYgDLMvT6mweDPyC1AMxZxMdgNoSw14H
 /QGH7eGfTm5zs7X6wxr9Pbvg==

I did some experimentation on the bug with the help of the following patch=
:

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bcbbb433cece..70064da40f9d 100644
=2D-- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1212,6 +1212,7 @@ static int copy_from_buffer(void *dst, unsigned int =
offset, unsigned int size,
 	if (kbuf) {
 		memcpy(dst, kbuf + offset, size);
 	} else {
+		printk(KERN_INFO "%s: calling copy_from_user with to =3D %px from =3D %=
px, n =3D 0x%x\n", __func__, dst, ubuf + offset, size);
 		if (copy_from_user(dst, ubuf + offset, size))
 			return -EFAULT;
 	}
@@ -1257,6 +1258,8 @@ static int copy_uabi_to_xstate(struct fpstate *fpsta=
te, const void *kbuf,
 	int i;

 	offset =3D offsetof(struct xregs_state, header);
+	printk(KERN_INFO "%s %d: calling copy_from buffer with offset =3D 0x%x, =
size =3D 0x%lx\n",
+			__func__, __LINE__, offset, sizeof(hdr));
 	if (copy_from_buffer(&hdr, offset, sizeof(hdr), kbuf, ubuf))
 		return -EFAULT;

@@ -1269,6 +1272,8 @@ static int copy_uabi_to_xstate(struct fpstate *fpsta=
te, const void *kbuf,
 		u32 mxcsr[2];

 		offset =3D offsetof(struct fxregs_state, mxcsr);
+		printk(KERN_INFO "%s %d: calling copy_from buffer with offset =3D 0x%x,=
 size =3D 0x%lx\n",
+				__func__, __LINE__, offset, sizeof(mxcsr));
 		if (copy_from_buffer(mxcsr, offset, sizeof(mxcsr), kbuf, ubuf))
 			return -EFAULT;

@@ -1292,6 +1297,8 @@ static int copy_uabi_to_xstate(struct fpstate *fpsta=
te, const void *kbuf,
 			offset =3D xstate_offsets[i];
 			size =3D xstate_sizes[i];

+			printk(KERN_INFO "%s %d: calling copy_from buffer %d with offset =3D 0=
x%x, size =3D 0x%x, dst =3D %px, kbuf =3D %px, ubuf =3D %px\n",
+					__func__, __LINE__, i, offset, size, dst, kbuf, ubuf);
 			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
 				return -EFAULT;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/main.c
index 1bab93d049df..23b228804289 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1183,7 +1183,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211=
_hw *hw,
 				    struct inet6_dev *idev)
 {
 	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev =3D mvif->phy->dev;
+	struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
 	struct inet6_ifaddr *ifa;
 	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	struct sk_buff *skb;
diff --git a/mm/slub.c b/mm/slub.c
index 513f0fb80f1b..3a62bf2f355d 100644
=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -5636,6 +5636,10 @@ void __check_heap_object(const void *ptr, unsigned =
long n,
 	    n <=3D s->useroffset - offset + s->usersize)
 		return;

+	printk(KERN_INFO "%s: ptr =3D %px slab =3D %px s =3D %px\n", __func__, p=
tr, slab, s);
+	printk(KERN_INFO "%s: offset =3D 0x%x s->useroffset =3D 0x%x\n", __func_=
_, offset, s->useroffset);
+	printk(KERN_INFO "%s: offset - s->useroffset =3D 0x%x s->usersize =3D 0x=
%x\n", __func__, offset - s->useroffset, s->usersize);
+	printk(KERN_INFO "%s: n =3D 0x%lx s->useroffset - offset + s->usersize =
=3D 0x%x\n", __func__, n, s->useroffset - offset + s->usersize);
 	usercopy_abort("SLUB object", s->name, to_user, offset, n);
 }
 #endif /* CONFIG_HARDENED_USERCOPY */

which gives the following output (before the usual backtrace) :

[  223.785491] [  T46217] copy_uabi_to_xstate 1261: calling copy_from buff=
er with offset =3D 0x200, size =3D 0x40
[  223.785501] [  T46217] copy_from_buffer: calling copy_from_user with to=
 =3D ffffa85f5387fd58 from =3D 000000003ffef840, n =3D 0x40
[  223.785506] [  T46217] copy_uabi_to_xstate 1275: calling copy_from buff=
er with offset =3D 0x18, size =3D 0x8
[  223.785509] [  T46217] copy_from_buffer: calling copy_from_user with to=
 =3D ffffa85f5387fd50 from =3D 000000003ffef658, n =3D 0x8
[  223.785512] [  T46217] copy_uabi_to_xstate 1300: calling copy_from buff=
er 0 with offset =3D 0x0, size =3D 0xa0, dst =3D ffff8c819c239b80, kbuf =
=3D 0000000000000000, ubuf =3D 000000003ffef640
[  223.785516] [  T46217] copy_from_buffer: calling copy_from_user with to=
 =3D ffff8c819c239b80 from =3D 000000003ffef640, n =3D 0xa0
[  223.785520] [  T46217] __check_heap_object: ptr =3D ffff8c819c239b80 sl=
ab =3D ffffd5368c708e00 s =3D ffff8c7f800d1400
[  223.785523] [  T46217] __check_heap_object: offset =3D 0xc00 s->useroff=
set =3D 0x0
[  223.785525] [  T46217] __check_heap_object: offset - s->useroffset =3D =
0xc00 s->usersize =3D 0x0 FIXME?
[  223.785528] [  T46217] __check_heap_object: n =3D 0xa0 s->useroffset - =
offset + s->usersize =3D 0xfffff400
[  223.785530] [  T46217] usercopy: Kernel memory overwrite attempt detect=
ed to SLUB object 'task_struct' (offset 3072, size 160)!
[  223.785545] [  T46217] ------------[ cut here ]------------
[  223.785547] [  T46217] kernel BUG at mm/usercopy.c:102!

So the problem seems to be that the kmem_cache object *s has usersize 0. T=
his
should be impossible in theory as kmem_cache_create_usercopy() should prin=
t
a warning in case of (!usersize && useroffset).

Bert Karwatzki


