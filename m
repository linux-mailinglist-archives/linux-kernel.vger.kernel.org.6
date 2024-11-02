Return-Path: <linux-kernel+bounces-393170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918159B9CC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 05:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262941F22175
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5EA13C689;
	Sat,  2 Nov 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yanwBs1F"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B817F7
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730520272; cv=none; b=ascJPfEKTrJe+ugmpaxh9sc1igFRiG/vAydNICaWRnyLFKS3nmF5AGlBdjrUNz0xTezEhEhuTuQfZbGlrqkmRFlcGRaFKDu+jA4GyVd31Wh8TJR87D724maRV9VQXJSqjZo2AKLJLydL7x8woYeYouAaPJHYiIcHjA4qFL3a7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730520272; c=relaxed/simple;
	bh=sPq+SJ0a3+k9JP5GL+8kQ3Xd/sRatONjAlsfu/kmHlU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hQ7FkB3fE0XHLkPzCfe0BbrWuL2Hb9rX6ahHhlx7ZaRzgcFjBXRjkdYfhvLGY0zj4PchCflM+6ArzTHE3S0xkN1XCPwCNMkYntEl+7jpGdq/z4choolghXN8O2hE2T4xdwrrpWiE0PTHneQQXFPes3Ng0HqUW3hSZkVJ0Bgv2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yanwBs1F; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730519956; bh=GW0nztBNVJY9Pkc2QrBgRYV+FP9ZJ4yeU0I7HWzUgoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yanwBs1FPpeSO2BsIPEatgVnUz37TlWIX4ElG3NMONI1pIsC0sODBtHTLOlRPo/wp
	 PLJdlMTboCGw7UPdb5Cz/HH2ZXCKMtXOW5YdD36/0hIDfbMqJiH/LTLliyN2VJ6eSg
	 48OxuOe2tQPTfgZ9KkU4/d2Tcn+LMr4XoutmkEyA=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id ECE87A87; Sat, 02 Nov 2024 11:59:14 +0800
X-QQ-mid: xmsmtpt1730519954t0dm2g6y9
Message-ID: <tencent_C34B2C1BD325BFBAC0BB5C339C9EB01B4008@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaP+1mcOH883s6BTSz1LqicTvZC3tQmat/iksQoklSDyeC1jdzuE
	 3sqzqwQEX7Gw83BaJWeXNYHynUWURc53Ea0wzRglhMYcpy0P4kZcEdOSKdneYqSTEG1T+21ROo3F
	 kj0DUpcQXXlb6h75RQz/AaLiZc5GD5i5L4jJSqvco5hZhTnQIW0zF3xBbQgGY1nADH+QTkVMxMb0
	 hhprTgK9m7T2mPCzIRd8WzHQsz31iE7M/Ov5AiZ2gYcalCknHfzTk3PZM0sIaVnJoPKYrzsXf6HQ
	 kzyMkA4s5Rgfpnb662nKGBG7ePVfyTjDjlPBAU/ZEM7wGlvN60PhuDlG29EKkO4yLkWvDPoWME6v
	 Fn4gNveySsQ7SYbZHtPTejBL1qTXUiyZu1W0BqL0NDnrzxXZN64qPC3vC54iI1VTfVGRKaZm/dj+
	 1PPiVCA6nnDyMdgokeotGsLYU0nRcGUwhq2R1Qys+zRUx7zuhH68IK7piR4SBq1MEQDGKZx+hh6b
	 8ms96iO/L9gdYox5A2+sQqwzo1UJxdsLiMVbL66JAM9FNesvfNfptBs9o2Xn/C4BfD3huXOuUQ2/
	 h8DDjCNLSJaQVLnGz75Y2MPCOCJtApin9ZwLZHHM+0z6Dae8k9qg/Rfwz7YBfqHEAv9uwvnDFrW1
	 83IBjN4GR6FIOori3otTSPDzzdPIhTZ89rw1mu0eaTvA8jGVi8EhpYeA5I0FeAPGjpuDuUnS4L39
	 EeV2khoZaEeHi1eElFHdIfMSrZXa3orAcscJlHJs45KUOhmpMWLOBNhf4o4kQFPM9thObYX58NQz
	 fTmsQ06r4SbwPSEIVqjJdkzkl6M1sXcRkQ8+96EhvDYABKGdm5cbo2mwSbNjnTP6t8EBRxeUC2Sp
	 yIvH/tjt2XqQ2cfDLvKZQavhoF2PsBzs7iNSImuKurzqM53qp5TRQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
Date: Sat,  2 Nov 2024 11:59:15 +0800
X-OQ-MSGID: <20241102035914.4133613-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67251dc5.050a0220.529b6.015c.GAE@google.com>
References: <67251dc5.050a0220.529b6.015c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

there is a raw_spin_lock and spin_lock:

      raw_spin_lock(&b->raw_lock);
      spin_lock(&map_idr_lock);
      spin_unlock(&map_idr_lock);
      raw_spin_unlock(&b->raw_lock);

#syz test: upstream master

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..4891904ee1fc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -54,7 +54,7 @@ DEFINE_PER_CPU(int, bpf_prog_active);
 static DEFINE_IDR(prog_idr);
 static DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
-static DEFINE_SPINLOCK(map_idr_lock);
+static DEFINE_RAW_SPINLOCK(map_idr_lock);
 static DEFINE_IDR(link_idr);
 static DEFINE_SPINLOCK(link_idr_lock);
 
@@ -352,11 +352,11 @@ static int bpf_map_alloc_id(struct bpf_map *map)
 	int id;
 
 	idr_preload(GFP_KERNEL);
-	spin_lock_bh(&map_idr_lock);
+	raw_spin_lock_bh(&map_idr_lock);
 	id = idr_alloc_cyclic(&map_idr, map, 1, INT_MAX, GFP_ATOMIC);
 	if (id > 0)
 		map->id = id;
-	spin_unlock_bh(&map_idr_lock);
+	raw_spin_unlock_bh(&map_idr_lock);
 	idr_preload_end();
 
 	if (WARN_ON_ONCE(!id))
@@ -377,12 +377,12 @@ void bpf_map_free_id(struct bpf_map *map)
 	if (!map->id)
 		return;
 
-	spin_lock_irqsave(&map_idr_lock, flags);
+	raw_spin_lock_irqsave(&map_idr_lock, flags);
 
 	idr_remove(&map_idr, map->id);
 	map->id = 0;
 
-	spin_unlock_irqrestore(&map_idr_lock, flags);
+	raw_spin_unlock_irqrestore(&map_idr_lock, flags);
 }
 
 #ifdef CONFIG_MEMCG
@@ -1479,9 +1479,9 @@ struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
 
 struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map)
 {
-	spin_lock_bh(&map_idr_lock);
+	raw_spin_lock_bh(&map_idr_lock);
 	map = __bpf_map_inc_not_zero(map, false);
-	spin_unlock_bh(&map_idr_lock);
+	raw_spin_unlock_bh(&map_idr_lock);
 
 	return map;
 }
@@ -4278,11 +4278,37 @@ static int bpf_obj_get_next_id(const union bpf_attr *attr,
 	return err;
 }
 
+static int bpf_obj_get_next_id_raw(const union bpf_attr *attr,
+			       union bpf_attr __user *uattr,
+			       struct idr *idr,
+			       raw_spinlock_t *lock)
+{
+	u32 next_id = attr->start_id;
+	int err = 0;
+
+	if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >= INT_MAX)
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	next_id++;
+	raw_spin_lock_bh(lock);
+	if (!idr_get_next(idr, &next_id))
+		err = -ENOENT;
+	raw_spin_unlock_bh(lock);
+
+	if (!err)
+		err = put_user(next_id, &uattr->next_id);
+
+	return err;
+}
+
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id)
 {
 	struct bpf_map *map;
 
-	spin_lock_bh(&map_idr_lock);
+	raw_spin_lock_bh(&map_idr_lock);
 again:
 	map = idr_get_next(&map_idr, id);
 	if (map) {
@@ -4292,7 +4318,7 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id)
 			goto again;
 		}
 	}
-	spin_unlock_bh(&map_idr_lock);
+	raw_spin_unlock_bh(&map_idr_lock);
 
 	return map;
 }
@@ -4378,13 +4404,13 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 	if (f_flags < 0)
 		return f_flags;
 
-	spin_lock_bh(&map_idr_lock);
+	raw_spin_lock_bh(&map_idr_lock);
 	map = idr_find(&map_idr, id);
 	if (map)
 		map = __bpf_map_inc_not_zero(map, true);
 	else
 		map = ERR_PTR(-ENOENT);
-	spin_unlock_bh(&map_idr_lock);
+	raw_spin_unlock_bh(&map_idr_lock);
 
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -5656,7 +5682,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 					  &prog_idr, &prog_idr_lock);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id_raw(&attr, uattr.user,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
Upstream-Status: Pending


