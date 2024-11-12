Return-Path: <linux-kernel+bounces-406804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335399C6439
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB15283042
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932F21B426;
	Tue, 12 Nov 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWRNPBSy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B24218335
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450344; cv=none; b=buiq3E6/d1eoXkvuYt16CYD81C6xjp80Z1mQMu0mA3uJhC40LV7UmoWYTTMAFW0BLORhzd5gYNaW5TXQFE/QJXWp0iE5vVciAY4fy4S5HKz536D/oBOwVWMPPyVshm8OGqq/VocmtkSqrBkKDEPt8TDWhH/cGZBsj8XFkWOBzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450344; c=relaxed/simple;
	bh=8GeByDS2uWdcqA65FmwK3WTf4oaQxq60Il3v1AwTHuc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nPsV03xsM0nHR09KoSmioTgdhzjiv6AA7+AAH3dA1XxAt4mkAuQQZP4g04RcsmSYiIn43FIzOVYibdBWGncTFoJZQjuKlrvUK+bqWa2Hh6W/cdAMZUBAe/ZFNKMhA/DJ4Uas00+hA1ULMLJjk+g2af43QlitvIs3O57OfxFLGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWRNPBSy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea90b6ee2fso106775867b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731450342; x=1732055142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7FlcnUnWshiI10WLNfiJyYyEzpkvJ7Zo+urE+6Owno=;
        b=NWRNPBSyqSL80sRyNn07z3O69ab7oFJVw8a2cuSH+AONG2K/NouE3mVS7V3kk8V3k5
         ZqVijh5XcJOsgAoVz9EXdTXsfYI1ePU1FIwz10fKDqAMaezsrzgS19b7pVMLIN8m1gZc
         ZWMGtgSSDMT4lueZU1D/YPOp3dsSBDwgqiCmSKWHMPddIF6VVeYQCmloySyhcuWd55M5
         B2pPWk4O1edBIzeh7FRiMmd0gh0QKIjzbpydhSwlA1D/KelufSzyqwhg4G0uOLIG/lu5
         yYsZqLYdorWt3vhT0snXa13GpYxbiT/0k02dcAnpTvAQvF9SHHJgc+mTixD9zD6kEq+6
         O3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731450342; x=1732055142;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7FlcnUnWshiI10WLNfiJyYyEzpkvJ7Zo+urE+6Owno=;
        b=ekDseD5wpgruSmwzu5rm/ayZZzQw85IdbtR+KhetBTcM8xP16+qwpZBdeZPl28hw7T
         ZqR9jNp/1cxjC3Omb4I10e+JwT2Lq4kfPXXnjiUpJW+n2zf2mdxgHN60HKeMH+hLsYex
         GBLNALkeKy+3RUUZHDDsFVl7I8ga9lUbuyTBlXPsLvbRi0pWEstccjF1oVYx3BD52xi0
         JXJx/GA1InMkbRn9ZqZaFKycLmT9M5swjpb99QwF2R8OJAnZuxuwDxZcalTfeal+GUxt
         EPMHDY0jlntL0SGmGbZPUE5PKG4ZFgZ/8qyc/pUTNuALV3muXzj/I8KmWxq1c9vXqOKU
         +0ew==
X-Gm-Message-State: AOJu0YyPHr3bfZj24GriA4Un5pVWale6vx0r8kwAdniqpTQNHVIrjNPb
	ZHVeh/BsS4liaLznNqL9xOXdCzxwVNBGSgbh9977Z09uBRfdJXv3b/LjWbPPQIHm73YqOf56GjY
	hhm3NbQ1uJStksPALMfXh9Oi5k9uDSxtv3EU6a8ZHNNdZOSNv2yElbW81YgPx3cU7qx6s+Sl4N2
	x9p0ba8AfJw2/+7g76ZPS8q6n6Q2N8xcCTTJf2dENy/UwOPg==
X-Google-Smtp-Source: AGHT+IEsuXSSvASgeovpBF0z8r+wVpgV2+7vhFt1qJRBztwwWEZl+9HACMovEJOSePyI6bw1Ja5nt4bz4jgE
X-Received: from dynamight.c.googlers.com ([fda3:e722:ac3:cc00:c8:f494:ac12:264])
 (user=jdenose job=sendgmr) by 2002:a05:6902:1342:b0:e2b:da82:f695 with SMTP
 id 3f1490d57ef6-e35ed2520d6mr507276.6.1731450341240; Tue, 12 Nov 2024
 14:25:41 -0800 (PST)
Date: Tue, 12 Nov 2024 22:25:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112222516.1.I7fa78e6acbbed56ed5677f5e2dacc098a269d955@changeid>
Subject: [PATCH] ACPI: video: force native for Apple MacbookPro11,2 and Air7,2
From: Jonathan Denose <jdenose@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, Jonathan Denose <jdenose@google.com>, 
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

There is a bug in the Macbook Pro 11,2 and Air 7,2 firmware similar to
what is described in:

commit 7dc918daaf29 ("ACPI: video: force native for Apple
MacbookPro9,2")

This bug causes their backlights not to come back after resume.

This commit adds DMI quirks to select the working native intel firmware
interface such that the backlght comes back on after resume.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/acpi/video_detect.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 015bd8e66c1cf..d507d5e084354 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -549,6 +549,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Air 7,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir7,2"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Apple MacBook Air 9,1 */
@@ -565,6 +573,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 11,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.47.0.277.g8800431eea-goog


