Return-Path: <linux-kernel+bounces-330536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF91979FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DB21C21938
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC71553A7;
	Mon, 16 Sep 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8dPa22M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC496153573
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484462; cv=none; b=q+IaL9/gocTGRIiPYYrmVZJrRBna0A30k9gJf7dKQSlQk8T+TCSSVSMMZSGM3JvUrxakzWRIrdJmgAwlXOh4Y8RS4QFcKmjoAnCwm/+gYQiQZlnbFL1Gv/AO4mBNSxgLxhqHpqLecEUHt8RIuoOXnYqzMWpPwEl4gfBrzpvtm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484462; c=relaxed/simple;
	bh=zXDP/DixJ2nupvnmN46tVoLl7bcTa+g5Dd43FoS8g7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3x3hi7WvS0+WPZz951IzBRkWlioRx0+vaCZb3RLo07ycjYzsAO6XrTzG9uO4WjCbFvHViYnmkpsK493/JtyFZ33JXPEL9lcfjAte53UA7UqpouBjnCzNMLlkXtbB+VmIo8NLfUJoLHOzNBkmAQP9r5ktZzcTypr5eBw/Fyf1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8dPa22M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726484459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itSh3IrUxrdCZUhjcuF+BB5F77vjj4OFkn+g9OgH098=;
	b=G8dPa22McOOOKbrDeWRklaXGAaxy2ErX7JUAbTTaIh+GDz4SqCJc9oQ/KkTgnrtYFFJ7uh
	MvPz2CK6smNglX+UB3/qQd1JyhQafGqzpgGfB7cdcmb82hiwP5IQfUI5fk0hQM0C+a85Kn
	54iOacZOqKHuAx3Vy+Dc5wVYEj4cQ+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-c8mc4TAIMPGUhuTBmdrNag-1; Mon, 16 Sep 2024 07:00:58 -0400
X-MC-Unique: c8mc4TAIMPGUhuTBmdrNag-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb5b01c20so21471065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726484456; x=1727089256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itSh3IrUxrdCZUhjcuF+BB5F77vjj4OFkn+g9OgH098=;
        b=wZP0ovjsdxA5ATCa1Y1XfPsg/k6cJj0Sw/KBVbuthlDfJwqvhuQpM64R9MRMhyFYqM
         iVo73DTPSkDauCi1kmOlTXPMZlGwh6REwjGkg9lwt260vNxjKUFfgj+hzmx53sUsTDwJ
         3vbk3WOwckuy9VAgH9LrtqSat8Acu/pABlldbIbi1K16qDEh7duMOmCdaberCQ6+8UQh
         f03ZaNadzse7TLq7c+UlP484jEecwxMzdkq8aF7C1hXBLJ4ReVkDE9x4Gfg5DJduKQcA
         /Pcrpw9S6WRhldQhPxFrWKLnEvEkXOEuSLiNJUassKX8BRdcH6wkuMHoZf0Zv/EnPJUX
         x7DA==
X-Gm-Message-State: AOJu0Yx6OmXv+nJ1eQ72SDtYuhOaMWMr1fiJNB2a+tuh3dOOaWfiuqSQ
	TwCGshy2+RQYcGqmJxLiQhvEUYPbdToqV/FD+7m1RU1jche6M5Q5UtlU0MBl52VzdI4cpvYseE5
	gHKz6Dya9127aTK1cNYnr8Sl0cDhkDm14AFghr++off6OkJrdk1w3SCYkDubZwMoHar91S+C8WZ
	k4jA0vVWKJlv8iHdOrM5JWrE5G2w+wJzn0PyP8gERSdmNYsJo=
X-Received: by 2002:a05:600c:310a:b0:42b:892d:54c0 with SMTP id 5b1f17b1804b1-42d907221b4mr59983125e9.12.1726484456055;
        Mon, 16 Sep 2024 04:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsgWHRJR4aKx2ppVUW3nxaeapfH3oj46/SJkQvNinWOePbqW+Lc2YXP1lXrRnZng63+W2aKg==
X-Received: by 2002:a05:600c:310a:b0:42b:892d:54c0 with SMTP id 5b1f17b1804b1-42d907221b4mr59982735e9.12.1726484455424;
        Mon, 16 Sep 2024 04:00:55 -0700 (PDT)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b055069sm110260975e9.6.2024.09.16.04.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 04:00:55 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Borislav Petkov <bp@alien8.de>,
	Julius Werner <jwerner@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	chrome-platform@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	Hugues Bruant <hugues.bruant@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Helge Deller <deller@gmx.de>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v4 1/2] firmware: sysfb: Add a sysfb_handles_screen_info() helper function
Date: Mon, 16 Sep 2024 13:00:25 +0200
Message-ID: <20240916110040.1688511-2-javierm@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916110040.1688511-1-javierm@redhat.com>
References: <20240916110040.1688511-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That can be used by drivers to check if the Generic System Framebuffers
(sysfb) support can handle the data contained in the global screen_info.

Drivers might need this information to know if have to setup the system
framebuffer, or if they have to delegate this action to sysfb instead.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v4:
- New patch to add sysfb_handles_screen_info() helper (Thomas Zimmermann).

 drivers/firmware/sysfb.c | 19 +++++++++++++++++++
 include/linux/sysfb.h    |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 02a07d3d0d40..770e74be14f3 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -77,6 +77,25 @@ void sysfb_disable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(sysfb_disable);
 
+/**
+ * sysfb_handles_screen_info() - reports if sysfb handles the global screen_info
+ *
+ * Callers can use sysfb_handles_screen_info() to determine whether the Generic
+ * System Framebuffers (sysfb) can handle the global screen_info data structure
+ * or not. Drivers might need this information to know if they have to setup the
+ * system framebuffer, or if they have to delegate this action to sysfb instead.
+ *
+ * Returns:
+ * True if sysfb handles the global screen_info data structure.
+ */
+bool sysfb_handles_screen_info(void)
+{
+	const struct screen_info *si = &screen_info;
+
+	return !!screen_info_video_type(si);
+}
+EXPORT_SYMBOL_GPL(sysfb_handles_screen_info);
+
 #if defined(CONFIG_PCI)
 static bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
 {
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index bef5f06a91de..07cbab516942 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -60,12 +60,19 @@ struct efifb_dmi_info {
 
 void sysfb_disable(struct device *dev);
 
+bool sysfb_handles_screen_info(void);
+
 #else /* CONFIG_SYSFB */
 
 static inline void sysfb_disable(struct device *dev)
 {
 }
 
+static inline bool sysfb_handles_screen_info(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SYSFB */
 
 #ifdef CONFIG_EFI
-- 
2.46.0


