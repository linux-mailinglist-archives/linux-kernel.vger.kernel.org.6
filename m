Return-Path: <linux-kernel+bounces-315222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34F96BF77
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C221F23A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50971DC05E;
	Wed,  4 Sep 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ao8YCVhO"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FE1EBFF7;
	Wed,  4 Sep 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458459; cv=none; b=X1Kak6svIq2sl8DEWFyMhFdcBvQnUgZHHUE1z5vCV5iDsoXu8BPeuV20DpTNQ3OeBtEZs1UVm7fQbZ25cvoQTtnt3W4d5vRAVquhxVGuNHDiTCy60RaCby5GVOQUVrNZeLbGu6xR6WvAdUyYqITRGchcizjG9QBKRtZNq3eMjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458459; c=relaxed/simple;
	bh=xabmwVwQUfF7rMm58x2oBZLhkCaDibSaetB+crQrpuw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OAs+FeZnF98rFPzAwgcv/nXK+k6qYnvghKH7OpsXlrXo0ewT2vXvWIn1DLYQnN8Mg7Df13pnoI1SU+QyR/xfkSHF7U6fPHJlOrqcxqoieWnOTdeMbDYlFJ5yH4C6jnIsAbTlecHwjnGUMnIjwNabBX6F95T+sKbmToPFA2OQq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ao8YCVhO; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725458145; bh=u37Twz/6bME7bbrSdnZ1lrczgEz+AGuUNz7vrUaLOGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ao8YCVhOGptzW/UDVf6kbJNdqb1SgEZuyO55LsdNVsBCzGwU87kiHrk8Ji7n3omTc
	 4GZDONrUaya3Tjam/zZPWab+79NdUgg08eeVyR9udoKualnD3NrpVBKE4mM7x1DVSm
	 hQmFFBRAzRSXZGAaJg0Au+WAFXOrXmJbRIfu6ZuU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id DEA95858; Wed, 04 Sep 2024 21:55:42 +0800
X-QQ-mid: xmsmtpt1725458142tvab6f9qa
Message-ID: <tencent_088B2EF2AEE00C8AE7D706CCD2CBC6484906@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWfH/lz9dc5MnQ75kPkxKWb7vHlAveeCNVyUoPreePdjTWxND4d0x
	 +3xJEDSDvAdD4br0zdEcCOhjg5R2JKbL9la5I7ytqWxcrSjedjQH8n8aKFRCe2VHwgHP1rkBT7vH
	 8bw8WlT1jnNqtkm5/gi9oDBPbSnTJofm0vLmLqVN+yDj9npcym/zCJdNH6spcaUC1nr+/Dl9Y+Cf
	 1FpbmmX16HoG53mQj3UTN+nDNbgL8iGK8dYXAcs96JN1Hr/A2JwmO5fKLjnAJvx/X7IycteWkS81
	 wdWnjMwpO5Hec6w2LfwcLdCSJQjtXIb9ofJKY4UVyAP6d0VSAf7APMI4hIYzTlXPZFNWbI+Usnb4
	 wLZj8O3KXAIjtiBi98qo1l4Of2DkcyFfOKtEHuiemnyXuUe0BvrM3xZUIz3vMohB9XjbApDDctQq
	 +MbJS021RFjjTh4ltyjh8GvgZ4wsEEl6gw2HafjClNwDoZDGCUjPaxycVJyAhKV2skAFwcAkTKyn
	 wGnj76K7Eie3adxYN3F7KCX/qGWVN9DJ2BFaW+j8Ho3bF33asFrljRJVb/0NvyylFogJKnEUJp/k
	 vm0jpzvgSJWcO9sqBA4F0XX3N/t4XxcFz/X97d95Vv6n7OWz4LITl0Dm7Kr+fyT2o4fX5UlDUJVE
	 s7TOuglyrj4AL+xOkjZCUrVsY07AVNKFG1d6SuEO7ZfZJC8oPTRbtkYcdWHGqOOLvRPT8EPvr6mI
	 /OSYXfbCvnnsvMqsvFTbZvKhsumxvTku2vk5FPk2dJ1nz7eghEBxR4YW31KMEjzYrEhq75S748fG
	 vALLhULuV2H5iO8XmI4YWKjB97v6pTOsadh/2RwPPELRjyitFxd0muIXDvDfwgCpIOD3UmiUc96C
	 8HrTtSRtYS5ht4ejcxWDVDD+uRXMiuCxNQTu0RJ5NaW7BIRsDTt81/hTcy6oYUzgU/KWMnO2V28E
	 sqvd+Xbh0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] USB: usbtmc: prevent kernel-infoleak
Date: Wed,  4 Sep 2024 21:55:43 +0800
X-OQ-MSGID: <20240904135542.4178115-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000a338d6062149eb22@google.com>
References: <000000000000a338d6062149eb22@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reported a kernel-usb-infoleak in usbtmc_write,
we need to clear the structure before filling fields.

Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/usb/class/usbtmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 6bd9fe565385..e9ddaa9b580d 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -759,6 +759,7 @@ static struct urb *usbtmc_create_urb(void)
 		usb_free_urb(urb);
 		return NULL;
 	}
+	memset(dmabuf, 0, bufsize);
 
 	urb->transfer_buffer = dmabuf;
 	urb->transfer_buffer_length = bufsize;
-- 
2.43.0


