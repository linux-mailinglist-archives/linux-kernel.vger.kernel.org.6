Return-Path: <linux-kernel+bounces-410456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E259CDBDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7541F22764
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C65B1925BB;
	Fri, 15 Nov 2024 09:51:32 +0000 (UTC)
Received: from zxbjcas.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07E192B8F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.127.214.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664291; cv=none; b=sRW7BLsCT78jwHS2oSoUFUTNCdApFFLZM9WIcyBJcEywFAGByFUssDyEimjVfOiwudnB1O3m191iT6+Ih7OW8yRQSm/cnDBBsOoh2u5U71S6glAWdinj0O0wj1N1FPx4v4k4UZGiU+v4VLRRT6ajpasvs8ZcJFRroBAfjzq7kPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664291; c=relaxed/simple;
	bh=S+iyE8PN4Zoxs4cpJTbZmazOoMItGPTp/bbhCCUKim0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwSLIFXcKEFOHh1v6wQZPamYs5xtJ7HNN1X55UC1NaI2K/584LOlaza4PvHVECGkVX0MkSQK0xJbBykVey8Qk2THJS0hoi//5vgKxutjZ/4OqCrnRSt2s6vQ9DFjyubEzoMc/YDLcovQQgJJh/3fnje3AROYarbf3VN/YvR+BBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=124.127.214.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from ZXBJMBX02.zhaoxin.com (ZXBJMBX02.zhaoxin.com [10.29.252.6])
	by zxbjcas.zhaoxin.com with ESMTP id 4AF9pBNh068560;
	Fri, 15 Nov 2024 17:51:11 +0800 (GMT-8)
	(envelope-from YongLi-oc@zhaoxin.com)
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 17:51:10 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Fri, 15 Nov 2024 17:51:09 +0800
Received: from [10.29.8.43] (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Nov
 2024 15:30:28 +0800
Message-ID: <19b392d9d8f97170518354df0ebdf913a140799d.camel@zhaoxin.com>
Subject: Re: [PATCH] Support lockref reference count if enable LOCK_STAT
From: yongli-oc <yongli-oc@zhaoxin.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
        <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <jiangbowang@zhaoxin.com>
Date: Fri, 15 Nov 2024 15:30:13 +0800
In-Reply-To: <20241114161400.72259c36cca41c0c2da6d971@linux-foundation.org>
References: <20241113085703.148839-1-yongli-oc@zhaoxin.com>
	 <20241114161400.72259c36cca41c0c2da6d971@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 11/15/2024 5:51:07 PM
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:zxbjcas.zhaoxin.com 4AF9pBNh068560


Hi, Morton:
One of the struct lockref is used in dcache.h. The spinlock_t is 4
bytes, with the 4 bytes reference count, the struct lockref is a 8
bytes variable, the count can be inc/dec by a 64 bits atomic operation,
when the spinlock is unlocked.
If the spinlock is more than 4 bytes,=C2=A0such as enable the kernel config
DEBUG_SPINLOCK or LOCK_STAT, the count inc/dec should got the spinlock
first, the sequence likes "lock; inc_ref; unlock;", which will caused
spinlock contention increased so much.
The chart below shows the spinlock contention with and without the
lockref patch. it got by "cat /proc/lock_stat" after ubuntu 22.04 boot
up. I tried each case two times. the con-bounces and contentions
of 6.6.28 with LOCK_STAT enable are much more than it of the 6.6.28
lockref patched.=C2=A0
With the lockref patch, the count can be operated by atomic too. The
statistics result is similar to the 6.6.28 kernel production
environment.

lock_stat version 0.4
  --------------------------------------------------
  bootup  class name     con-bounces    contentions
  times
  --------kernel 6.6.28, enable LOCK_STAT-----------
   1   &dentry->d_lock:    385336         413098
   2   &dentry->d_lock:    378268         402761
  --------------------------------------------------
  -------6.6.28 with lockref patch and LOCK_STAT----
   1   &dentry->d_lock:     79941          82431
   2   &dentry->d_lock:     77817          80301
  --------------------------------------------------
Li Yong

On Thu, 2024-11-14 at 16:14 -0800, Andrew Morton wrote:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> On Wed, 13 Nov 2024 16:57:03 +0800 yongli-oc <yongli-oc@zhaoxin.com>
> wrote:
>=20
> > Swap the positions of lock and count to support CMPXCHG_LOCKREF
> > if SPINLOCK_SIZE > 4 when enable LOCK_STAT. The reference count
> > can always be used regardless of the spinlock_t size.
>=20
> Please fully describe the problem we're solving here?=C2=A0 And what are
> the
> runtime effects of this change?


