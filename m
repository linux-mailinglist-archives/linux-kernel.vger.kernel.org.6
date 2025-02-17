Return-Path: <linux-kernel+bounces-517365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99813A37FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE473ACD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F2217654;
	Mon, 17 Feb 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwToEZ5d"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EADC217651
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787470; cv=none; b=qLIQ54lLEEG/5dLBLyC2qdgIJObE5WwGRFxfm/VkmQI2I2hJHQVDY/VoFqg4LBXyI/Wa6j+SBZTNSK9necPnBJDatSWieTLxVYPxCJC7Jqo6mS/0IDY5dfGpCuFKOsiNp6X08DizW9KN0cEnqtpmPv3YGCjKQFUAzBx4E45y68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787470; c=relaxed/simple;
	bh=/cVyc1rh86otJZ3wkWGcQ4N27XkUc752xM+g69NmlEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWtRuWC+fJnZ330bCeCM87yzzqK2WVyZHLtS130bpUubZ1tV2HdSTzJthd7443LzPRZw47RmEvItAAUFK27NRQpwsOi6nGBTX5lbGXADvLYBKrZZ4geiN/N1VjFS7ALJUIZ0N5GQ8TWxGUASPp8+oAEhuzjKzHge/vuX8Ow+DJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwToEZ5d; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb8d63b447so124198766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787467; x=1740392267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6BYtQ0vagWpucItzriIw7qjC34OuqzM5CfNcTita1Q=;
        b=zwToEZ5diBI6TG5Yp7XbbbcR8h7sfZJNrVqOlFEIdGyENZ8PjZXze1+6sJggc62EOr
         +VPtaoacD1FTJcjXLTiyHjCLUYDKQePfaCWicY2V5fp8RDpkbfjl0HfJlQxLw8BOYxuX
         w8RBwdAozE7aGJRV7v2aIyP9hMGjjsJtUoGIQfnNCMKvcc2/PzDeEAowEd0+znlUNglJ
         hQ1FxOnc7YyFsAansc328Do7loPvoCDgdDS+uCz986oKumrg7P+lp6jvyYlAo7KD4fvX
         s8cZuyYhZr++xg4iRb4qK0UlNJXpUvINFjPT1YuJvN6m6EvN0fXvmgvnBFhbF+ibEghd
         J1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787467; x=1740392267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6BYtQ0vagWpucItzriIw7qjC34OuqzM5CfNcTita1Q=;
        b=CbsRApNJZPUk17QuUVcpJmwYedXgVFU57ROca7mNeQaWTF1QWVnIMmo7oxrRDD3yVW
         ED/tF89G86FXZd32lpKDKGyjgPYGFP+CyKmRb2fmTqIW2405McI1a4YhRA1SkMG+Ohcu
         Y4YyTqmcWbhaeQ/AeWdGCunwh93i3PzVJDibPrZxI21A64wORXnB5z/T9tg1ZAas7b7j
         rA7xHHjUEEdd1+wxJDJeDkw71I55nGv8i7dHS5IUtBQkkmovsCdNs49EMxuxhk4CRe1i
         n/QBG/8kGhAbHJRS3CvZS71bKsjtiYzyC5+0h+2EACxd4aL4xUgV9N4NFb52e976LeUI
         o24g==
X-Gm-Message-State: AOJu0YzS1CzYyoJ/So+4LEaTuy5c/Zm3B67Ji8qGdwiWy5QbxnFavvjM
	BLruQGgc++e5Q3IomC5l/V+DJJQ0jP1AGwAzLIebe0kK6GkcmYCkHEQCtQKLnmY=
X-Gm-Gg: ASbGncsZzHvgJiMapco20HqCAlo3RRnSOliGGRAN480fcnVa+09p3CRcj7Y29Y6XlF9
	BeLyinkmaN94KBaJKdqXQNnr8L+N44Wm1dFtRuFrUt2scb0cXcT88RtgkZLjSwNGz1gfg25i6QX
	3OX+RzeSFGbMZoySgiPxCgeNCz72P69paxZTZ+f240d/brEVnhC+n1fMoWTgi2AveDJ8f63knWh
	eUlZdJ24kOYbOuU9Qp8IZzXkYB3dtITwdbhmdem6qPMEgdtt+ywigWggssMu1Nk3aQ5oYHVvEQh
	ZIOM6DJok39WoLH7pkWW7wCc
X-Google-Smtp-Source: AGHT+IFgDnivD1OBw8RBeqZ1T3wvlR/UtXkBn7pRJ5OfcJBMf9SgRGM/cdk3Igb/07dwRLGbAITBVQ==
X-Received: by 2002:a17:907:1c85:b0:abb:6ea6:161 with SMTP id a640c23a62f3a-abb70e4e28cmr925547666b.56.1739787466832;
        Mon, 17 Feb 2025 02:17:46 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:46 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 01/10] pstore/zone: move pstore_device_info into zone header
Date: Mon, 17 Feb 2025 12:16:57 +0200
Message-ID: <20250217101706.2104498-2-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Struct pstore_device_info is used in pstore/zone, and it's
not really connected to anything related to pstore/blk.
To further improve on the pstore zone and allow other types of
drivers to connect, it is logical to have this struct into
pstore_zone.h file.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/linux/pstore_blk.h  | 14 --------------
 include/linux/pstore_zone.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 924ca07aafbd..d0c8fb40c46c 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -7,20 +7,6 @@
 #include <linux/pstore.h>
 #include <linux/pstore_zone.h>
 
-/**
- * struct pstore_device_info - back-end pstore/blk driver structure.
- *
- * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
- *		linux/pstore.h. It means what front-ends this device support.
- *		Zero means all backends for compatible.
- * @zone:	The struct pstore_zone_info details.
- *
- */
-struct pstore_device_info {
-	unsigned int flags;
-	struct pstore_zone_info zone;
-};
-
 int  register_pstore_device(struct pstore_device_info *dev);
 void unregister_pstore_device(struct pstore_device_info *dev);
 
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 1e35eaa33e5e..284364234162 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -54,6 +54,20 @@ struct pstore_zone_info {
 	pstore_zone_write_op panic_write;
 };
 
+/**
+ * struct pstore_device_info - back-end pstore device driver structure.
+ *
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all backends for compatible.
+ * @zone:	The struct pstore_zone_info details.
+ *
+ */
+struct pstore_device_info {
+	unsigned int flags;
+	struct pstore_zone_info zone;
+};
+
 extern int register_pstore_zone(struct pstore_zone_info *info);
 extern void unregister_pstore_zone(struct pstore_zone_info *info);
 
-- 
2.43.0


