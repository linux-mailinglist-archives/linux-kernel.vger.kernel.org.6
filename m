Return-Path: <linux-kernel+bounces-402739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B49C2B56
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C43FB21DF7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB9146590;
	Sat,  9 Nov 2024 09:22:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55331DFD1;
	Sat,  9 Nov 2024 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144135; cv=none; b=l44iT3a3I3ReIDpmwAZvUtkj54l1ZJm0QYmBcK8OTYYvbDG5Sp8T/O22klknVPNNXxVdvtH9iq0sAEP9sQDFYYY80cftA1c1i0hE+7a4NxH5SZqL4r/VEXw2ZnBpTzjorMpWFZsemSBdNZxOm0KyRkDusbyBGICkkTW8xqtASio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144135; c=relaxed/simple;
	bh=JnSRpSy4Y0dEjyg11F30uP2wLMuAkz3qQk/p3ugmvaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9DYa0zQTs0wkH2JLCn5mbMjDWeXRS4YstbEyV7M0kO/iMxi3vWRQQi0VG4zTvn++Fu4RZRRZ6QXz5+F/a+93kIBzvxhst9dfkz+S/KmsO3U7qDnyFPqYcHVeClZhcelQMbo7Cj1uJjj01gWgmy8ew7sjezFXezyLz+2jMC3hhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17021ba69e7c11efa216b1d71e6e1362-20241109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:e45ddae5-ffbd-47ae-b380-f8425b9c0cf3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:bb0a940dd6dc7d1943b6e6fdaf5ba797,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 17021ba69e7c11efa216b1d71e6e1362-20241109
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1099126974; Sat, 09 Nov 2024 17:22:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E45B0E0080FF;
	Sat,  9 Nov 2024 17:22:06 +0800 (CST)
X-ns-mid: postfix-672F29BE-15679110
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2FC3BE0080FF;
	Sat,  9 Nov 2024 17:22:03 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: corbet@lwn.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH 4/4] docs: driver-api: firmware_loader: Convert to platform remove callback returning void
Date: Sat,  9 Nov 2024 17:22:02 +0800
Message-ID: <20241109092202.4040669-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void.

Trivially convert the mediatek drm drivers from always returning zero in
the remove callback to the void returning variant.

Signed-off-by: zhangheng <zhangheng@kylinos.cn>
---
 Documentation/driver-api/firmware/fw_upload.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/driver-api/firmware/fw_upload.rst b/Documentat=
ion/driver-api/firmware/fw_upload.rst
index edf1d0c5e7c3..b339265655ee 100644
--- a/Documentation/driver-api/firmware/fw_upload.rst
+++ b/Documentation/driver-api/firmware/fw_upload.rst
@@ -69,13 +69,12 @@ function calls firmware_upload_unregister() such as::
 		return 0;
 	}
=20
-	static int m10bmc_sec_remove(struct platform_device *pdev)
+	static void m10bmc_sec_remove(struct platform_device *pdev)
 	{
 		struct m10bmc_sec *sec =3D dev_get_drvdata(&pdev->dev);
=20
 		firmware_upload_unregister(sec->fwl);
 		kfree(sec->fw_name);
-		return 0;
 	}
=20
 firmware_upload_register
--=20
2.45.2


