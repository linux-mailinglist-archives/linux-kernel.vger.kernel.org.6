Return-Path: <linux-kernel+bounces-294792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67A795928C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C201287B32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978571742;
	Wed, 21 Aug 2024 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nu9HJ9zs"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3756440;
	Wed, 21 Aug 2024 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205483; cv=none; b=A1WneUPCc/++V3YZquryldQj29/5zy3dIKuKxg7Su1PvU+hgQAqgc1TkHtClQrPggvQcwfdqn92MYvw/t//40/jDoVzn8e5dq0iPVS0bOyaPewz2siJx+RKbPgCHPGyl7B3RxYis+y2wHv+8J6Arjt/QRHOjFILfcs/lmXlnFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205483; c=relaxed/simple;
	bh=FekYK30opB6s6lOZs+AUqQF1Lm3LKPRzVFEOTpGjdAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=keUdXuKTCK0LGRHU6bCp9Ra/fi/wMKDPIiAau0yrYI/LwcQtwpl1gg3zhiDdWVGC9hHaVZFYiAuhCKdoxQHpl+HdDK+DuN4Dj/icGsTDx4CxkiFHxOtMc+EhxzXRf559/br3KIEJrUbOmWNO0Qmcgki4LfUrmu5b83SYhR24HVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nu9HJ9zs; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nmNlX
	XQWddvaErUsZxk6WLgAY7QyK2JCuWIX1Yg+kbk=; b=Nu9HJ9zsc7dCJ30i8kfxc
	DtFXuZHtuVbub+38I/hjRQqgxElQ4HwYZUW+upOks6F9Brn0ElxcLLT/DRTqqNXo
	f8f+m72SLRmJqFlyB/7Qj5Rbk88JqtFbOs9KMtnJS8H6aaF8z76D4Nm4OrOKuAdo
	19T50D27+0KRWLXHblmqqM=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wCX_9sRRsVmoiP_Cw--.34346S2;
	Wed, 21 Aug 2024 09:42:42 +0800 (CST)
From: soxiebing <soxiebing@163.com>
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>
Subject: [PATCH v1] ALSA: hda: fix snd_hda_bus_reset when single_cmd is not supported
Date: Wed, 21 Aug 2024 09:42:38 +0800
Message-Id: <20240821014238.338864-1-soxiebing@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX_9sRRsVmoiP_Cw--.34346S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZr1rur17Jw1kJrW8AFWxXrb_yoW8Jr4fpF
	1rWwsrtFZIqr13AF4vg3yF9ry5Cws3GFWrG3y8Aw1fArn2kF40gryUKrWFqFWxKFWfuF15
	ur4UG3WkAFnrJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ui2-OUUUUU=
X-CM-SenderInfo: 5vr0xvpelqwqqrwthudrp/1tbiNwA+w2XAmw-9mwABsc

From: songxiebing <songxiebing@kylinos.cn>

When an azx_get_desponse timeout occurs, ensure that bus_reset
can be used when fallback_to_single_cmd is not supported.

Signed-off-by: songxiebing <songxiebing@kylinos.cn>
---
 sound/pci/hda/hda_controller.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 5d86e5a9c814..5ea198d67bda 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -809,10 +809,6 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
 		return -EIO;
 	}
 
-	/* no fallback mechanism? */
-	if (!chip->fallback_to_single_cmd)
-		return -EIO;
-
 	/* a fatal communication error; need either to reset or to fallback
 	 * to the single_cmd mode
 	 */
@@ -824,6 +820,10 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
 		return -EAGAIN; /* give a chance to retry */
 	}
 
+	/* no fallback mechanism? */
+	if (!chip->fallback_to_single_cmd)
+		return -EIO;
+
 	dev_err(chip->card->dev,
 		"azx_get_response timeout, switching to single_cmd mode: last cmd=0x%08x\n",
 		bus->last_cmd[addr]);
-- 
2.25.1


