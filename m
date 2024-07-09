Return-Path: <linux-kernel+bounces-245150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8292AF00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8654F282C3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB812D1FC;
	Tue,  9 Jul 2024 04:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="inPCg2Eg"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBC7D07F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720498687; cv=none; b=gq0t8QZBSOANfgu7wD3cd7/Yfwx3JLkbGkh3EOZCnZzyJlpkChMiDgkKB2srGG/nt/jq+ZFrDW1obdSLvfZwgKhbJeYstSK+sIkNPECGA+Xm3nM16DZ7jGf9RPh3MjHskh2mU+LcCfuJQhMsXf/d7WzYqMNjqCtlbOLGqQ2DveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720498687; c=relaxed/simple;
	bh=XWhzfCvOv6lGGXQToFg0a0wy94X+LXmKI0b4Q/iwd+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cSPe7Hr0gpeFI1PuEX07ifNVkS01Epix2R9jC7uqIRUT/HJQT8vHKNXKWtg1R4xSzL1mTGjQI+7jcxoT4VyE4poyAhXqPYljVdCNdYgKePCNU09peLnjq776DqRKs9KRWlUiSwaqB39/ldP/PRy83E71sxDp0GCOVWh1nRU6c00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=inPCg2Eg; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240709041755epoutp02367148d8b0dccb4a1d3bcabbec247b44~gcG4UHEPU0108501085epoutp02e
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:17:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240709041755epoutp02367148d8b0dccb4a1d3bcabbec247b44~gcG4UHEPU0108501085epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720498675;
	bh=lKCM4eKVBkxuPbg+SH2M8AGj93cnrmRZpEG+UsgzVrk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=inPCg2EgaDGpdRhOUNGOC1MqyLclFHLLw5RZz/Dl069+sec2GwSHe68U8yIma/erK
	 BrQgxQZvtSw6NPUXmyoICD5oEGSZFXIzwkoafejh8g3+kJhUoNMkCvZb71InUg4MQB
	 tA74qoFQuRv0wdpJ72h1TA4/sU1kBAak+Xc1rq8Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240709041755epcas1p3fdb5a3f91c62ac6260d44f6c07c631a2~gcG398W781900219002epcas1p31;
	Tue,  9 Jul 2024 04:17:55 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.227]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WJ74z09JVz4x9Py; Tue,  9 Jul
	2024 04:17:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.4E.09847.2F9BC866; Tue,  9 Jul 2024 13:17:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8~gcG3UKUkw1389813898epcas1p4I;
	Tue,  9 Jul 2024 04:17:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240709041754epsmtrp24b14da4d0e313e4186f761cd0611fc2f~gcG3Tl89j3110831108epsmtrp2c;
	Tue,  9 Jul 2024 04:17:54 +0000 (GMT)
X-AuditID: b6c32a36-60dff70000002677-83-668cb9f2c901
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.D2.19057.2F9BC866; Tue,  9 Jul 2024 13:17:54 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
	[10.91.133.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240709041754epsmtip1f42c978a2a0792569eca3fee95ee74de~gcG3HCySO1245012450epsmtip1b;
	Tue,  9 Jul 2024 04:17:54 +0000 (GMT)
From: Sungjong Seo <sj1557.seo@samsung.com>
To: hirofumi@mail.parknet.co.jp, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] fat: print s_dev via fat_msg
Date: Tue,  9 Jul 2024 13:17:34 +0900
Message-Id: <20240709041734.3719513-1-sj1557.seo@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmge6nnT1pBme2mFnMWb+GzWL63A0s
	Fpd3zWGz2PLvCKsDi8eJGb9ZPO6/TfTo27KK0ePzJrkAlqgGRpvEouSMzLJUhdS85PyUzLx0
	W6XQEDddCyWFjPziElulaENDIz1DA3M9IyMjPVOjWCsjUyWFvMTcVFulCl2oXiWFouQCoNrc
	ymKgATmpelBxveLUvBSHrPxSkDP1ihNzi0vz0vWS83OVFMoSc0qBRijpJ3xjzPi35DhTwWvu
	ilevvrM2MD7i7GLk5JAQMJH48fQzM4gtJLCDUeLdydIuRi4g+xOjxK/efjYI5xujRN/Fy2ww
	HV275kF17GWUWPfCCqKonUmi799SJpAEm4C2xPKmZWBFIgJWEgdvXQFrZhZwl7i2ejVrFyMH
	h7CArsTkWR4gJouAqsSCXrBqXgFbiSX3XrBCrJKXmHnpOztEXFDi5MwnLBBT5CWat85mhqjZ
	xC6xYK8+hO0icfFxFyOELSzx6vgWdghbSuLzu71gv0gIdDNKHP/4jgUiMYNRYkmHA4RtL9Hc
	2swGcg+zgKbE+l36ELv4JN597YG6R1Di9LVuZpASCQFeiY42IYiwisT3DztZYFZd+XGVCcL2
	kDh9aQMTJKRiJabO3840gVF+FpJvZiH5ZhbC4gWMzKsYxVILinPTU4sNC4yQI3UTIzghapnt
	YJz09oPeIUYmDsZDjBIczEoivPNvdKcJ8aYkVlalFuXHF5XmpBYfYkwGBu9EZinR5HxgSs4r
	iTc0M7O0sDQyMTQ2MzQkLGxiaWBiZmRiYWxpbKYkznvmSlmqkEB6YklqdmpqQWoRzBYmDk6p
	BibHpwU7Y9/3zzwx5dXXg8pMKvu3dM54qLTNfsnx6vNrko+zOFeYlyZIX/jVEbrnlArnrSPR
	tapKxu2PX/s6NlXcWCT2XamiMibkb3znJgnvx1PO1hTk3k8p5+c7J1bvpX81XijG+qS69bOD
	LZdfako1VEiu5JNQClh3/CtroNS6rCkfXpafqnhQlp/nanKnr7O1Qr+kXNWnv7e843WC7Ox4
	SeYlqotXZ196uKlrzbr4rYI66vfnyBYkbeVYd17x+72/KzZmJuyad0J/trlu5w3JegOG7mzp
	LLnA+h/VfhVVlQzJRp8twk/9Dzpygqf0u/u/SYGRvnM6MrRZHq3g5pt62M7WUi4yt5HXb+Mr
	JZbijERDLeai4kQAfvI0oT8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSnO6nnT1pBsd/yFvMWb+GzWL63A0s
	Fpd3zWGz2PLvCKsDi8eJGb9ZPO6/TfTo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujH9LjjMV
	vOauePXqO2sD4yPOLkZODgkBE4muXfOYuxi5OIQEdjNKLD3zm62LkQMoISVxcJ8mhCkscfhw
	MUi5kEArk8SHm54gNpuAtsTypmXMICUiAjYSTyfygISZBTwlXt29wAQSFhbQlZg8ywPEZBFQ
	lVjQywxSwStgK7Hk3gtWiP3yEjMvfWeHiAtKnJz5hAViirxE89bZzBMY+WYhSc1CklrAyLSK
	UTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM44LS0djDuWfVB7xAjEwfjIUYJDmYlEd75
	N7rThHhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamBasdrB
	b03P8UuaMfkC3Fr3JbasPpD799eehVn3Ox9uPZO+KPdVU6/jSs4JDNU8iQIV+3bqBZecKvdj
	7PlgoXhr+7TPugvj61/kvZrV/q3r378ZEWWBBg9n+2RUXz18xYZv/q+7fk+E1L81cbH+fCIn
	4Mx9x6Bm8SIm5aZlCoH66Vx/vLSe+PsUPdzeNOdxWZ3Lqqh/jyQ/Llq57vPRGet1khIDXKQ4
	Baue+Eq0rtI6PUXn2GxHxjfiP7KOOwicsqlq0WmWlJq7JKq0/wXjJfHMQ35tVqYO26Kb8k7U
	+BbrJT9d/24tH9Ms38WF2XYHnk3aOT/f+sDFnu/u8udW/OW9pey1Lehetvxyh3qGTyFKLMUZ
	iYZazEXFiQDffvCypwIAAA==
X-CMS-MailID: 20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8
References: <CGME20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8@epcas1p4.samsung.com>

To clarify MAJOR/MINOR number of a mounted device, fat_msg prints prefix
that includes them.

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/fat/fat.h  | 2 +-
 fs/fat/misc.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 66cf4778cf3b..538bcb3e28e1 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -435,7 +435,7 @@ void __fat_fs_error(struct super_block *sb, int report, const char *fmt, ...);
 #define fat_fs_error_ratelimit(sb, fmt, args...) \
 	__fat_fs_error(sb, __ratelimit(&MSDOS_SB(sb)->ratelimit), fmt , ## args)
 
-#define FAT_PRINTK_PREFIX "%sFAT-fs (%s): "
+#define FAT_PRINTK_PREFIX "%sFAT-fs (%s[%d:%d]): "
 #define fat_msg(sb, level, fmt, args...)				\
 do {									\
 	printk_index_subsys_emit(FAT_PRINTK_PREFIX, level, fmt, ##args);\
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index c7a2d27120ba..6672cefc5484 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -9,6 +9,7 @@
 
 #include "fat.h"
 #include <linux/iversion.h>
+#include <linux/blkdev.h>
 
 /*
  * fat_fs_error reports a file system problem that might indicate fa data
@@ -59,7 +60,8 @@ void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id, &vaf);
+	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id,
+		MAJOR(sb->s_dev), MINOR(sb->s_dev), &vaf);
 	va_end(args);
 }
 
-- 
2.25.1


