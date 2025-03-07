Return-Path: <linux-kernel+bounces-551362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB886A56B73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E176117995A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B822371E;
	Fri,  7 Mar 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="enjYFyD4"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F33221540
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360230; cv=none; b=X/foeTO0rYD2rSfNBi+14O/D0zWCVH6k0rhQHTGyWn6pQGjRpr4SkH7EmTbboYjhowYKnaFQgPa6miuqe1gTCGIEUk7as6iG87n76QHVaayNwbcZS1OT09AMzGj79yBO5kUc3FI3BiztkgzTK2CQEjxq1F6OjoiVKMLO4HTtvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360230; c=relaxed/simple;
	bh=TfY6Uuj22tNIZcd+AxAVBfz6b5qDljEdJ6Z4kV5QMNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQzGSKCvUgr9iCHy6dwfj1FbIcY5tgYwjH2irmeuLSUGPypTW4J2UvcxQvdGi3gErcvz7IbLUdlnoStB9Dz1XXww+h36mAAkCTgZhObf32TeGAQr46p6cvD9OFpXd7Ms/M2W8CC/0n/DdwBL/5co2KkiZ2ebtwIL2l43zGNicxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=enjYFyD4; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X1vRuwxBIZSJcxbIazD+ATemJLeoDYr5JM5IaYT4lGQ=; b=enjYFyD4PSSL539zcfI3RJ8aOc
	BlEwjte4o15XHSllqCAhJ4FYzAeJbeZty+oA6Em/tlIcWJKpk8PoYhBOKq1HbQhcOpNVYKG8RVRnM
	YPX9aV+1Jo02LcoBPjB+ie/Ad+AXZYWpuCOLLdHQsFlRqr5qVfF9W+hpiuaqiXG8cznMiUxcvBnGP
	+5Q/U202IYkqtAOykVPCF/3YjD26r4wvGRgtEXGrbwBsSHjcJghyIkcPMfVkEHIboEWzQVbuKGdtp
	u14cl+/0Kf7D7CujzUGnl3LZhZa07wziO+rG8VuY21eGpaZooy1jya821ZOz6w4qCilxDCa+gdm52
	OkMEar4A==;
Received: from 179-125-91-70-dinamico.pombonet.net.br ([179.125.91.70] helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tqYrK-005OEr-PL; Fri, 07 Mar 2025 15:39:36 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Fri, 07 Mar 2025 11:39:27 -0300
Subject: [PATCH v2 1/2] char: misc: restrict the dynamic range to exclude
 reserved minors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-misc-dynrange-v2-1-6fe19032ef76@igalia.com>
References: <20250307-misc-dynrange-v2-0-6fe19032ef76@igalia.com>
In-Reply-To: <20250307-misc-dynrange-v2-0-6fe19032ef76@igalia.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>, 
 Vimal Agrawal <vimal.agrawal@sophos.com>, linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

When this was first reported [1], the possibility of having sufficient
number of dynamic misc devices was theoretical, in the case of dlm driver.
In practice, its userspace never created more than one device.

What we know from commit ab760791c0cf ("char: misc: Increase the maximum
number of dynamic misc devices to 1048448"), is that the miscdevice
interface has been used for allocating more than the single-shot devices it
was designed for. And it is not only coresight_tmc, but many other drivers
are able to create multiple devices.

On systems like the ones described in the above commit, it is certain that
the dynamic allocation will allocate certain reserved minor numbers,
leading to failures when a later driver tries to claim its reserved number.

Instead of excluding the historically statically allocated range from
dynamic allocation, restrict the latter to minors above 255.

Since commit ab760791c0cf ("char: misc: Increase the maximum number of
dynamic misc devices to 1048448") has been applied, such range is already
possible. And given such devices already need to be dynamically created,
there should be no systems where this might become a problem.

[1] https://lore.kernel.org/all/1257813017-28598-3-git-send-email-cascardo@holoscopio.com/

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/char/misc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index f7dd455dd0dd3c7c9956e772b5ab8bd83a67a4a6..6a7f4f2f8d1227747a74be567bdc420a9e97f8f2 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -69,13 +69,8 @@ static int misc_minor_alloc(int minor)
 
 	if (minor == MISC_DYNAMIC_MINOR) {
 		/* allocate free id */
-		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
-		if (ret >= 0) {
-			ret = DYNAMIC_MINORS - ret - 1;
-		} else {
-			ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
-					      MINORMASK, GFP_KERNEL);
-		}
+		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+				      MINORMASK, GFP_KERNEL);
 	} else {
 		/* specific minor, check if it is in dynamic or misc dynamic range  */
 		if (minor < DYNAMIC_MINORS) {

-- 
2.47.2


