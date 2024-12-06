Return-Path: <linux-kernel+bounces-435247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA989E750B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E303F1608C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7FF20ADF4;
	Fri,  6 Dec 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IK3r7GcU"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E7BA20
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500967; cv=none; b=OBP1op61P3AD5IXw87v2fYl7v50igSS6yxib51edP7QUb/bqCnZNJlDvGcDTgqPHYUXkoAY7xI1OFfBU3nszhGdoy3sMlTer7s/oBHN/PfBDVaJKdzK+ARbpSPID5LSB1JE/jL1s2eeg3tSIzdbJvkm+OZA9muA+ZlWy7JPkZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500967; c=relaxed/simple;
	bh=ha38dfHBZqm+4g1Lc7GZXHhvv6jjdqTzc74/DfBu9+k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=eAEho+dkbODdqiOk0kKdKrUJWH8+xdKPKSZQErL1IlUrkw1vEoiznqXOA8rr4e04+/dOmUya/3Zsvsy8bLOdPmT4BUzcFZWGrwTmzto8AsC+siD4G5Pb4iiMxbcEHpUihZ7WahyI+2ki4e9Mu9PXT81zq5llKrB7iIiT1cgWQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IK3r7GcU; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733500958; bh=uxWdeH2YQlHshFXryLQwdchwT2um8IKLVMXCKavSOqM=;
	h=From:To:Cc:Subject:Date;
	b=IK3r7GcUCYDv2dGvJp18M4VHt9lhieW281cITn8ji7/n1QDJwzXqxi1YNurXZMM6N
	 qtCaXcQXH7yFdRidzFXv+eX421fDqit3M8oLxuB+HT+Brbk4j+2EDEfn1cOLqTeZTu
	 dpDlUoGI1EdPp7fM9XGg9sJGdsAVp1lKPAX4AQFo=
Received: from localhost.localdomain ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id E1A1FA93; Fri, 06 Dec 2024 23:56:26 +0800
X-QQ-mid: xmsmtpt1733500586t7x4gb7xz
Message-ID: <tencent_08B979048FE091821B290B18AE97E70DC507@qq.com>
X-QQ-XMAILINFO: MoQ+ZqrtYx1+NruHmYG8445a4j957OD+RZD7E1SXz5loSGWVRU64ZWuQqBffsI
	 m5IoNe6qWycnYPt8Iru6mmG8MYpkJ0QapVedaK4LUPglh4bkRAa2TeQKXhmygA+izZ+OUCWF922X
	 rXxfDYbXx4z+B9RgBAEpGVACGIdSOB895oQrbyUnBpzZdGnko5Q1M0E01h6b2H5x0Yd3ngsUtLbN
	 d09q5xnNyd+jYCPcoBQtVauZtJpFy1yLjbSzk0i2G0LtZhslR/L0wRES6mZ/JG+43p4y1m7T27C5
	 DYzmAA8c9ub6hXXMZ6Al8+8OpVEv+zCfE2/6By+kqmJWTojgLhIpi1Wu4kL5FsepMQtdeeNY7ZUL
	 ZJ4YqXTT5KunOm9oyS3yDEMbiSKM+mU/SqRwqi65yFEiyhOaXA28AppCQj236qJ6gcUq7WcV+N2B
	 7LivaFwzbo3Xu1OJz5ptCgibNCfAesl40H5WjeJJ/sXlh/h3zA8X2cDcGRoL8jya2YhorlfufZ+y
	 2f2VEk/PmyPJ07HPOTRXQew6yALD2ymzeZjgYEFS5Qe//ZycE9AutqtW+06HKadN9AE0iR4ZE8JV
	 y4kBMfUhrC60YxBaxrLJIBT3uLS2QCS3PlpZIagG968xyRQBf0Lyo8Ev3B4gzoVoz5FbtXfnNmz9
	 Kqe16JDPjQ1lTXZHBdF87wvtIxhBrV/niTk9ZXCesPZeEKeUTP+Jd0AuOZxjUMIxSTPiEXmAYogK
	 uJk7PCv3buEOi8iT/J8+gRzkjpoGSH9sesTZbHhHT/uD1r1F3adB9IJcd1DkzDI1myODZNqLoYHo
	 12OJpS8KK4eOHvTEDe99HrG3yD8iS9IK9vUOF8HEas9p+CY49L8m6lFGlp97J9wAtP96Tmlj5EH+
	 VmudfRGJYxWqFsuKFZJLnPV1w1qdmilOxn5BHpIDioBmuBcS6uE3qXhPTJKDYa6F/YpayGC85zdw
	 Q7y4VxtJ9C6Sr068Nolem6UvghEMqJnP+KiXPpex0L0eLLRPGVTn9bxM/pnVOdsr5JdV0EOzI=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Junjie Fu <fujunjie1@qq.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	willy@infradead.org,
	mhocko@suse.com,
	gourry@gourry.net,
	Junjie Fu <fujunjie1@qq.com>
Subject: [PATCH] mempolicy.h: Remove unnecessary header file inclusions
Date: Fri,  6 Dec 2024 23:53:49 +0800
X-OQ-MSGID: <20241206155349.1673191-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, linux/mempolicy.h included linux/pagemap.h because vma_migratable()
was implemented inline within the header, requiring mapping_gfp_mask()
function to implement vma_migratable(). Now that vma_migratable() is only
declared in linux/mempolicy.h and its implementation has been moved to mempolicy.c,
the inclusion of linux/pagemap.h in the header is no longer necessary.

Additionally, since mempolicy.c includes internal.h, and internal.h already
includes linux/pagemap.h, so there is no need to modify mempolicy.c after
removing the direct inclusion of linux/pagemap.h from linux/mempolicy.h

Signed-off-by: Junjie Fu <fujunjie1@qq.com>
---
 include/linux/mempolicy.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ce9885e0178a..d36877557b00 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -12,7 +12,6 @@
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
 #include <linux/nodemask.h>
-#include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
 
 struct mm_struct;
-- 
2.34.1


