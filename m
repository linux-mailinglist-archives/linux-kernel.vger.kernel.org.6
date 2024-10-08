Return-Path: <linux-kernel+bounces-354464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC0993DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9FF2B23768
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995177603F;
	Tue,  8 Oct 2024 04:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hhDl9tT6"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1F34CF5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360406; cv=none; b=RLhmPK5E+J3kVKRQN9/vEvx/vjJrm9QbRbQ4hDsmYwzyMBKs1JOrjgVD5O0MTfrw+5GYO2OCY0cN3fPatoaWVsuFy2oMUdx/ijmM1Ek53w7XcUMWMeFTgWB/OIWR0OnBGu+AldcM2/H8lGL7ZCwf1C4YnJFX8AG7pZU45+eZ5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360406; c=relaxed/simple;
	bh=/Im5Jn5orROTCo9UX+QmE3Y5Y4UAJWQAuIgdwJPVG2E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gaF1L5by8/kOEgSpwU/NBpEDyPsn5sfbAUpVv45Uc9Ej1WcYx7JXlXhd38l5z53sCZq675m5CJ6J9fiOovnjUoh9lLraOgj95LlS34/iqGviMtFzPBcXqB+ce72bgEwpIGqDxzTTlGcQ+Ef0WC5Hoa7lQn8kde05CLssoJwwzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hhDl9tT6; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728360396; bh=cOsCLIh+CXLSLHSgTiZtpbRmjQpgYrbvUNymhGJbeGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhDl9tT6m8IOgXyYMVWhONq3C2q1clZzU2i05Ga75F10o4toQ9Tv8mDroGTcf/via
	 UkJkob7OvJL1Yv+v9eCw4sb//P+HBu3BBBvgsysG21ZIVAwJxPepwX1BNBTXjP3OcA
	 qD2SvjnjTUvfNJph5PvZq0vYmhJtxJoaI9PEor20=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id A390804D; Tue, 08 Oct 2024 11:40:57 +0800
X-QQ-mid: xmsmtpt1728358857tfjppnsds
Message-ID: <tencent_193D761367023C1936DE96C236B24A627409@qq.com>
X-QQ-XMAILINFO: NvwY87CbqCKF0uibmPO9RHO1ABmuidL7C5JX5Tpvd3z16mrhmoOKzuOQKcLKbw
	 LXPPKW26awuzhuQxHUG1CPPz7K9QYY63hrXQXhLHQj3OXC5dTp6ilwWWoVFP8eghu3jbdUWxZH60
	 SCFXiNOsSFWmEAiBlGn4kMN95Izdldbvcf+FUGjT0sCszjRnLhfdlq4ucIV8FQgsy+D5u67HsdO4
	 z9NXExrd9Df/szDWTu9eoZsevg8dJO7qOTcCAD0vHui3VHxZwIQb+rH7fW1QsuYUfTQIfxbF5jpd
	 xm8PQkZIhHsY7a8hogeRBf13HBTwrhtnNKJcM1DCAbvt0GYzFHdCXIEMVmNfW+mYNoPRDyIEXFpN
	 76HZVcwWDDVyvK1KXgqnSO1InZuVCmVCFgcVRrBXtLkFSFg8PuNLlyeBsYALajVLlQPTq4MSGDYg
	 YAzuB0tSyBOM53jl10WK/X84AUXJsqQDB02OrPCuZDIn9zStZZYCOrmLSZz8JJs/fHbzFAk30GR0
	 ZuYx1jvbsY0qAqLcUwGTVxxhtyT+ROy5QYY0oRg79oBRBkKQ0GpdDZIojPTtVpyS9NQe+EKqr243
	 MtNK3Es/69hjn05T3jiA8lk6ssB0STyMcRVsQj/qBb4dvszhy0oWf3Msz9fu8IymXdi5lyY7dAg2
	 3xpn18Iffwld3Vo1VutHoBqmdA86S1L8KSyRtSZcsi6t0YtQelIR8HwxV+xD0H+Zv6HOxuOCtnOL
	 lphl6QEc+HwxxxX9QuNfotXu9SCP2l9JPvVYqaJG6A7O1vewr12KjzOiaHuUTKeejSHV3vPLt7eN
	 lqEuc5C4O41nd01IPw+c1WKkL2NV0wSQVJhK30cd0DY6qCAmBFzIHf/OzeboX0Yz/GA8HycmlJ8u
	 68Y+/PQKOdn//VYFaVTCjd/wRqMjlwWBC265pnw81H
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
Date: Tue,  8 Oct 2024 11:40:57 +0800
X-OQ-MSGID: <20241008034056.120347-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6703b264.050a0220.49194.0502.GAE@google.com>
References: <6703b264.050a0220.49194.0502.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt device is closed ?

#syz test

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..c55f0ca33b90 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3791,7 +3791,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		l2cap_recv_acldata(conn, skb, flags);
 		return;
 	} else {
-		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
+		BT_ERR("ACL packet for unknown connection handle %d",
 			   handle);
 	}
 


