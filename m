Return-Path: <linux-kernel+bounces-446480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82E9F24D4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1F91885E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE118FDA3;
	Sun, 15 Dec 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BSc6qgOY"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD3BE46
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734281401; cv=none; b=J35/lkeOdskU3tbDuAO/FEmZLJ4YB6IC2KlnLhr8JePakKLklCoJrC884QfrYpI3eou20bZr7Qv2oyo+poRp/s+Q1O2GYmfRHxhKymc82YPF93be4vR0qQp8rYYlG4HExQVNNWpP8MdvmedGjv7I4DO6lRoq3WIy0JMBeiLKOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734281401; c=relaxed/simple;
	bh=rIXuuppMuOBMkpBmnAVbEKooGp3Q1AReezTRBPIChcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CPWPCV9MALjDECh2ps1ib9koMoW/SLBL/eX0Wey03/jq5KBAyzzx0qBsssAwn8cJPcN2HZBS1v4y/aqIZCDXOfE7b7GuffhXTGS1xvTOtn1CB6afwHLfCwfAlq/I89JdDrMGfW7ofTd+FHqjGrEUwayKp+zvk2qWxIyFafHmW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BSc6qgOY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734281396;
	bh=rIXuuppMuOBMkpBmnAVbEKooGp3Q1AReezTRBPIChcw=;
	h=From:Date:Subject:To:Cc:From;
	b=BSc6qgOY4QMIpDTfHuovcFYs2r4AcXQo1TxkMMiA5kYqk7vqgWjliYN80cRVAx1lV
	 XLZoUbg6dLvA0bUk7y7fyfzCVEJq8ZzILiyJYZiH9Q2voQceQL5d1TjAAVARiTlBQH
	 +kb7I1VdSgQTYKC+zuCQbIbfLhfDJ9JhManviGvo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 17:49:50 +0100
Subject: [PATCH] kheaders: Simplify attribute through
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-kheaders-v1-1-319bbd50e224@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAK0IX2cC/x3MUQqDMAwA0KtIvhewsWK3q4wxOk01DOpIypiId
 1/x8/28HYxV2ODW7KD8FZM1V7hLA+MS88woUzVQS96R69E2S4bjmq3gS/IzlqL4XjhOrIbetyE
 MibpwJajHRznJ7/zvj+P4AxDEPA1vAAAA
X-Change-ID: 20241215-sysfs-const-bin_attr-kheaders-440887f23892
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734281395; l=1959;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rIXuuppMuOBMkpBmnAVbEKooGp3Q1AReezTRBPIChcw=;
 b=I85r3j7c09ThbrqAvn58Q0o4aBizvvV+JNzAiTpSkNp1nYTa1cTqFdgWzf+MPm7xtNw2ILg0u
 WY9fKiSfdSnBQk4OchNN6vq2NeVF2rqjVZxc3RJdb7GiThYw+K9i4hW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The utility function from the sysfs core is sufficient to implement this
attribute. Make use of it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
__BIN_ATTR() is used over the normal struct initializer because it is
shorter and can also handle the transition to const struct bin_attr
callbacks.
If you prefer, I can switch that back, but it will introduce a trivial
conflict with [0].

Note: There is no formal maintainer for that source file.

[0] https://lore.kernel.org/lkml/20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net/
---
 kernel/kheaders.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 42163c9e94e557c5043e2ac7987b567f23087ee2..de25d913e9473f14be70fb0f602c0202af4d92c9 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -29,25 +29,12 @@ asm (
 extern char kernel_headers_data[];
 extern char kernel_headers_data_end[];
 
-static ssize_t
-ikheaders_read(struct file *file,  struct kobject *kobj,
-	       struct bin_attribute *bin_attr,
-	       char *buf, loff_t off, size_t len)
-{
-	memcpy(buf, &kernel_headers_data[off], len);
-	return len;
-}
-
-static struct bin_attribute kheaders_attr __ro_after_init = {
-	.attr = {
-		.name = "kheaders.tar.xz",
-		.mode = 0444,
-	},
-	.read = &ikheaders_read,
-};
+static struct bin_attribute kheaders_attr __ro_after_init =
+	__BIN_ATTR(kheaders.tar.xz, 0444, sysfs_bin_attr_simple_read, NULL, 0);
 
 static int __init ikheaders_init(void)
 {
+	kheaders_attr.private = kernel_headers_data;
 	kheaders_attr.size = (kernel_headers_data_end -
 			      kernel_headers_data);
 	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-kheaders-440887f23892

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


