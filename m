Return-Path: <linux-kernel+bounces-536319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A18A47E21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9983A75C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CB2EB11;
	Thu, 27 Feb 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXANO1mz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFF27004F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660328; cv=none; b=JUNusxoEU1Szkh7Gsrv6TjJ7lnBf5pqUU+HrIz15qUv79nBqtJBG73LlC8ONctGwaGkTeb5HvpG7RkPyn9OtlOCrQJjKOLeH8v0F4fRvQQZARjkCbj0ZSDuJKbBhC6Pmj6p9CQvx4mhjXSFtCuT928bOEIxQ/N+CfMN4POsrs/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660328; c=relaxed/simple;
	bh=qrRgq02fnXJXvcD8RgGr2ryYofMwnWE8L+HiIMkzpCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq11g5uZsRiqefTMVM3Om+WGkM/dySib3ExwPvqc1SMCrPxOCA1JGkGcH60l6zvy7ZG5vIdANOVZbi3goi9Iyl3jFEvuDHpsRa3JycBjYTTE50ZmGFlUgl4sklYKArWuuOihFhome/FkMpK70qvKE5vUtyOS/5kk7V1QhHWK7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXANO1mz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2232aead377so17124765ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740660326; x=1741265126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkaXG7TVgMagzcxv29XE8MWWCnLAdnJPJnUCWab6kj8=;
        b=ZXANO1mzMcwTD5rS0FK+ZV2NkJ3jS4kv6No7CW+3+DUaV1pLc5ouPX2SiEam5LhSgU
         3T1nA+hnLBKcsgd+vAJonriRyfgJXW9tXuAF7P6xeEYnJuh5f8JCxO6J7Digx1ngFnV1
         IvO3tAvVeA/UlAJIzOJWdl8OLYttR6t2KNh54Y9/sfAZcgUdEso6VotNo5mQHnqW+qUs
         AFAwLL8KRa/UUUw4tVMWqvT+VuTSoIKKHNnspGG4gsj1rEgKg+/FLTJM1hBvRqGd2sEm
         OZOGkKCcjj54IaPeBDA4fbR6BWWXrsyvuZZgp54YIgFp+f+DJrGh20p9xTtRNF4GAu7p
         wkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660326; x=1741265126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkaXG7TVgMagzcxv29XE8MWWCnLAdnJPJnUCWab6kj8=;
        b=PH3+2EoUYfuDwTVkwLHXCZjrX2c3XFcvhgW/IYhl/i/f2CHSFnTYktgOwsYmPpsw7K
         bef+pPqxTxp8q6inBOQr5rxAogBcPNjohOnM01jmh1Rc8X53ybgWsTaYkKwZknZm70fJ
         gvgtPKjTm0Ex/ASIWlo0J5PzI9KrJEUJLVrjnUtO0Mhs0rPiK5Sd5Z/Z6rg6Y6pY0UgK
         gKbPeDjOk9A0pqY4B3LM8U46dnDOGEe4WPWP71ygTaTIdcisdud84jE97PUBu+r/G6Mj
         d5zdG+hCPsTyd6iEiWZ5TEhLN6xfcRPvphKB13JtImSSZuuAQIPFIn7+1wIhZegr6hIv
         N7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUu5qpWO3gWn3n/bdI0cV+3Cunrg6OdSBhi5j4mWZE5ZEV4m3bFgQuh04wmM9oDoRtHoI5Bjhx8tmYkGZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJj8qqYib4dSiVWWSBAOFxBVaA7ASCC73xfcI/oi/sWaHfFROL
	qtNhPjN01ZpTsDX7g65fGZ9KloAto/q9/Y7OzSg4FOxVkRgu7lWR9iM3xpLD
X-Gm-Gg: ASbGncsiEiVb72B00DdpvjfEwVbtO3kTjMsxqynPduAweWQ5rPyNQ+wstzFfKqxLaON
	QrfrMNjsL1A1zcnjNGprcToC17lF9Nya7A7d1pOFB7yrsQNZ8lCWHmoQi6hzqhRPEavHa4I9rft
	7qIo4IWhj53QKrq4GCx+Dmy32+2WrKwWi6Rj3emKSWIwH14zogJ9Iq2VNawBwBnfckqilKq2bQG
	WqHs+Sp/tbtL3Np2iVlo4C+btNvUYrUHzdW1zwH9XIxP7LUCyuuZojjfkp+f/eEdMEtKXkN5A2B
	UVUOP3RaedWCjzSgax8ne+Foq/9XqZflQ6DmOkQEgIc/olBOMWR0
X-Google-Smtp-Source: AGHT+IGj5ckcDwv0Rhqi3CzBoUdpq0KkkItLdDvFawBlVT2ypQCGoaSp3BeXBCYyKxb4FzUS4b+Gyg==
X-Received: by 2002:a17:902:db03:b0:21f:6bda:e492 with SMTP id d9443c01a7336-223201f7e34mr127537995ad.35.1740660326180;
        Thu, 27 Feb 2025 04:45:26 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9dd8sm13406065ad.57.2025.02.27.04.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:45:25 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ayaanmirza85@gmail.com,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH 2/2] drivers/base: fix iterator cleanup in attribute_container_find_class_device (v2)
Date: Thu, 27 Feb 2025 18:11:29 +0530
Message-ID: <20250227124417.132020-4-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025022606-carrousel-unstable-f2f3@gregkh>
References: <2025022606-carrousel-unstable-f2f3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a long-standing FIXME by refactoring
the function to ensure klist_iter_exit() is always
invoked once via a unified cleanup path

The patch has been tested thoroughly with a minimal
Debain System and scsi devices and GDB.

Tested-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 drivers/base/attribute_container.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index 69637b2ec3bc..fbf7fd45651e 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -492,12 +492,11 @@ attribute_container_find_class_device(struct attribute_container *cont,
 	klist_for_each_entry(ic, &cont->containers, node, &iter) {
 		if (ic->classdev.parent == dev) {
 			cdev = &ic->classdev;
-			/* FIXME: must exit iterator then break */
-			klist_iter_exit(&iter);
-			break;
+			goto out;
 		}
 	}
-
+out:
+	klist_iter_exit(&iter);
 	return cdev;
 }
 EXPORT_SYMBOL_GPL(attribute_container_find_class_device);
-- 
2.47.1


