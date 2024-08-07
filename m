Return-Path: <linux-kernel+bounces-277147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B272949D35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EFF1F2343F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EFC1A28D;
	Wed,  7 Aug 2024 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Hl3lLU2W"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C277462
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722992655; cv=none; b=fviug7n0SYYz3t6kb9dTCKbWLnbcLUEUDZH62ue6bTJmVjrjlFdgc6amXVJmaZI1LDLka1wcyOgkc0XYp4b323I3tp2Uw5Su+w8qqbmPx1XCu0J+Ul4br+Z+aldWBoUwpHNqGzQwWtyL92eh2+7gdLOSGT7aYxRWQsWVIKIdGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722992655; c=relaxed/simple;
	bh=8iMhWV7U+E5tggdIy+2NoRMi/ndLIXfYJZFXu+b2kk8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jz2hSmF//DUQlGwAQAJzCENFaNdh3MMGW8N9pFQOIykyGYTcQxaXU86U4MT+yy3cMiVlBYxJ+7bS+3SkYGptagJguvTUGVihIsG/oBl5I2IyaN9UWv2pRisGoqjmNlXnP/sCfD81aaCukrW/3DM268IOgXu6vWB2AcjwDk6X6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Hl3lLU2W; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722992643; bh=TIBS1BBSQNfkaaaS/Q4rdYC9CpqNA7RJWzFHQkJNXIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hl3lLU2WdiXvMuaXy5iygte8ZVjK+YSmNQ61ZRis7jpHI/So4qBhwX6lK2Tn3ZFtO
	 OVVo6aEUh6zx+ECSuzQvfHK6Af8kfyrcX3AwUEKnpi2O/VIXeUJ+meKvE5AUOTtZE/
	 L8ypPjDPJxo2na35hTpF09/BZLquK2MDb6nAztdg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id CE18A8CC; Wed, 07 Aug 2024 08:51:33 +0800
X-QQ-mid: xmsmtpt1722991893tdfqqwi1z
Message-ID: <tencent_1DA5E7E446CB52E4066CC9B82EC96EF38C06@qq.com>
X-QQ-XMAILINFO: M0yQCYO1Pk4B69fqA/VPSExWtCySEax6DkUj+tUXirMo4YZUogSOQ7TplLyJxQ
	 MIc3TYYozORhEEUh/elyi1kQZEaMM7BS8uTmLLcjlpI6pVXoQF/s9W2OvnKdHC6iXf63kB3Go3G6
	 1oH5k0aaZG+eemHGp61985adjC3Kh8FcoYacX+DVrIVf38v0/a72vgpatPv4gOruL/Ww+OxIoQC0
	 LT+tn+MmVH8jeyPvAeUWqOpPZhN4dn9nEEYH1M/wizIiDjFVvemZENC4FpTfH92AVetzpY3RSDE6
	 bEcgDhkiuQd37gLqBTDqVEDpS+j7p3x3eOd3hifvYTF7bK5iYrqHL/w9/ADtJafEBl57Cpvr0T99
	 8U2EdiJLSiHnoxtEnSYGRXqIeuL7nlKPCg5+gnTuegA4OAk5kmbtAFjI+QDRTy3hMSVhbnyEckP1
	 DQpfwvmMK6dkbwmutMT6yC58yTeTx1zy2ugxCafxvKsDK/W2tHyLnS4Kvx4QVbnUUmUTcJLekXZU
	 232O+qoH/dkDVxkssyYxDNFst867SYeiwsjKAVTDnNsmyoMI4d5SYfWOUButn2JUMZv9WX5MB9r2
	 Ec/Fl9lGsotdPc6SPsHcj7hlwNerW2eMGiZQ7uY1VYJt3aAxk7jpCn4Answ2td3NrTIJ3SPx2527
	 aklhVptIhvtIst0NFRiVkDaVLdR/FyKrIirokc/+xLREjoMJmVK6iaqtdOkOr7Efx+bkThjPrx+m
	 5QusZHid5EsZ3wvl+8TfcgE6vmKBfl3YIKGENoOvmsaQue8TF6l2uIPoLQodApCvkVoEs1TvY/iC
	 5Xcz/St9WVY680ajHhYAGHJ6gupQx49VTeRgLFIADVjZl0Y9LSDX+l6r7EyhOBsjptqtEWW2BE1/
	 fjdaLwGrC6VpRJlanFTymTD2nXHD0quW+sciO28V33
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 08:51:33 +0800
X-OQ-MSGID: <20240807005132.3945450-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000af9991061ef63774@google.com>
References: <000000000000af9991061ef63774@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

because enabled CONFIG_DEBUG_NET, make refcount wrong dec?

#syz test: net-next 743ff02152bc

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..29c3ea5b6e93 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1225,7 +1225,7 @@ static inline bool skb_unref(struct sk_buff *skb)
 {
 	if (unlikely(!skb))
 		return false;
-	if (!IS_ENABLED(CONFIG_DEBUG_NET) && likely(refcount_read(&skb->users) == 1))
+	if (likely(refcount_read(&skb->users) == 1))
 		smp_rmb();
 	else if (likely(!refcount_dec_and_test(&skb->users)))
 		return false;


