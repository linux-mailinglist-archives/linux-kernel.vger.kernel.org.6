Return-Path: <linux-kernel+bounces-336493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E5983B77
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62375283C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95181799F;
	Tue, 24 Sep 2024 03:05:58 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C690D2FF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727147158; cv=none; b=RjTi4HeodoPtc4c1jUrDxNKC14gds5zrNNxaUcHMBYQ98JBD0iciO41RDsDOZPwHNAFU8C2z4bFVqNrG40Ujis1N5/yajMc6d7UdEQXHTIOTaq0giAOQUEEuURiWV3FxlfuQ861TVEkXlM70dzncICylxGrawtTcSMgDqDSuvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727147158; c=relaxed/simple;
	bh=lh/Lgxo9CFRok24RUD8SPZ+fqBSO4Nuss7QZhjcBKkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlvOSEea/a4G6Pm9eNOP9hlWfLtHLhKHTyTFcuHcOP7sRN3g6dEdddOlNFfVOxvojyy15Q3DdQpjFkeMEFK/qfoqUKZcS5osczUaLZVHMzpBLXJJUx1lwlNtE7Pt5/4YK9VNr4qQdQMR8PVHX36OJBR9P6zcpsdn+gGQL/tZXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e53926927a2111efa216b1d71e6e1362-20240924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7d7253f2-1818-4edd-9d67-4a8505054795,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:82c5f88,CLOUDID:ca39576949b5a66c0c07a0aa3eb7d79b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e53926927a2111efa216b1d71e6e1362-20240924
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1221243042; Tue, 24 Sep 2024 11:05:47 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D1001E0080FF;
	Tue, 24 Sep 2024 11:05:46 +0800 (CST)
X-ns-mid: postfix-66F22C8A-66182528
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id 26C27E0080FF;
	Tue, 24 Sep 2024 11:05:39 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: gregkh@linuxfoundation.org,
	kunwu.chan@linux.dev
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] firmware: memmap: Constify memmap_ktype
Date: Tue, 24 Sep 2024 11:05:32 +0800
Message-ID: <20240924030533.34407-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This 'memmap_ktype' is not modified. It is only used in
firmware_map_add_entry().

Constifying this structure and moving it to a read-only section,
and this can increase over all security.

```
[Before]
   text    data     bss     dec     hex filename
   4345     596      12    4953    1359 drivers/firmware/memmap.o

[After]
   text    data     bss     dec     hex filename
   4393     548      12    4953    1359 drivers/firmware/memmap.o
```

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/firmware/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 8e59be3782cb..55b9cfad8a04 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -116,7 +116,7 @@ static void __meminit release_firmware_map_entry(stru=
ct kobject *kobj)
 	kfree(entry);
 }
=20
-static struct kobj_type __refdata memmap_ktype =3D {
+static const struct kobj_type memmap_ktype =3D {
 	.release	=3D release_firmware_map_entry,
 	.sysfs_ops	=3D &memmap_attr_ops,
 	.default_groups	=3D def_groups,
--=20
2.41.0


