Return-Path: <linux-kernel+bounces-389357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3360B9B6BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6FF1F21F56
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F61C3F3B;
	Wed, 30 Oct 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8LL3JLP"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0881BD9DB;
	Wed, 30 Oct 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312152; cv=none; b=CeQ1YROfSzhIn0tXr0cSM83MRaZvpnBWgvaAhGmSv7AgcYNPZiuYySoScK2alb2fZ52KFoZ+H12xrZwGmoAHJnh8yJTvd2E42peDBJMN9d3kXsXFxzX/I0M7xAdLxLw3yAIpMI3G0QhaPLDIHI4rqqoEIfgnPaOMt1rN3wN6iPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312152; c=relaxed/simple;
	bh=FIp5VMnovXK0B4YqpNnMEbsIQtcgud52f9pYT2vkWIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZa5GGd2YF9+BcaTODHy4GxjeIYqfoNB8HuxeDYFMXtVZQYCDPfjIiiBrAeOsHaXEc9aIRWYQeu2zHKZvo/blOovg1a9nx+myGqT129R5sEcRXNogfMdm1kwcKkA02KKCBnQ03ktyqG9wLymsCooZjXS7GjP2PYoa+/t9DxFEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8LL3JLP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so88246a91.0;
        Wed, 30 Oct 2024 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312150; x=1730916950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlq2aWtL/RtkdHdafqcuLsAgi35iKnILmwxjIeCSKaY=;
        b=U8LL3JLP/tkDX0K1TCipMGYTfzOO0mt/M/ibPC2PON1NibEy7GXHA6wTic3abPToK3
         teeJrLiWkAYueREYGvQ65o46tIhPlzf2jL7ssg968w+vCUgjr21uy7Si9+44TBPlJ3FF
         aNOZMPfmQ64kDWCd/bLCymAIYOV5gh4eeVwYIxfTGEixcgt3XteFChy/+kt3o/OqXw3i
         JZXqLCD/nNalRQREn+k6GAi1unOiEcMTZm/5uJqiqgketgfqUpFx0sFuorXHrksio+cH
         T2VMQDp3Pzh6qLeEHNzSXMMbWx/9pJJDNFRnp7f1hDBYZ7DDaLu6+jgEDU70BHjugw8N
         isFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312150; x=1730916950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qlq2aWtL/RtkdHdafqcuLsAgi35iKnILmwxjIeCSKaY=;
        b=ll/3GkoPKfvFlAyHnPS8yRNbpx01dulXkfK8QZnr5T8OVpzRPQlR0H6NnnxMhi8cIy
         CTT3jwXN5Z2luRWheVT/96w6FwjA7zTiFtZyjAO0G9F2zE83Et42nyVtCjbetK9LUClV
         uTBJtrcS8Kc8BcsfDWi5igfI6OvJqq73DmKAsULvcbuT5EQXuQD1J2LKC1Qb+PbCdpC+
         6C4lc0tr1rcs0n90vPVt0MixmcEKdIsFXiO3cOAS/KMfPbBEvqLWDV3SDUsuLGHDc4JC
         j/pcjXz8xv9c792jwFNPmizLVoZtz1cNXMpjAExUBJgGwH3AgOqNGIuSwMXisw5qniW/
         X+/A==
X-Forwarded-Encrypted: i=1; AJvYcCULh5XJ6k7OILAf7xlJFR3hu99hLv7MQ/NPfwh21zX27FbM+VIvqLGxVCCSP1gIl8E4Ij9UpB+QBGZBO+gCJKsJGOomGQ==@vger.kernel.org, AJvYcCWO2D9vH2GyeFnN1ZdVok0wGS+8gzXvBuzJ+mjxlvOYJb6skeB0MU5UxLiyFZn+qiJjINniMNxfhAYfE7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJTaObSuvNp2Mn6pkS9cx2i/yp2KGxaweFtO3D0ArLDkh98Kh
	XzBvbLoFwUxnOumro/6KCb7NAlEUjMpKAS+JLWILpLTgCi+rcw2s
X-Google-Smtp-Source: AGHT+IHlEQeESIe/MXIiIcI6zogvR+5CNow8IiankJrEFJ+SNFIbQCM8EAjcuKoDKKpfBizn9vOIng==
X-Received: by 2002:a17:90b:3882:b0:2da:8730:5683 with SMTP id 98e67ed59e1d1-2e92cf549c5mr4317395a91.39.1730312150381;
        Wed, 30 Oct 2024 11:15:50 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa837easm2120464a91.38.2024.10.30.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:15:50 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	pali@kernel.org,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH 2/2] dell-wmi-base: Handle Win-key Lock/Unlock events
Date: Wed, 30 Oct 2024 15:15:33 -0300
Message-ID: <20241030181532.3594-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030181244.3272-2-kuurtb@gmail.com>
References: <20241030181244.3272-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Alienware devices have a key that locks/unlocks the Win-key. This
key triggers a WMI event that should be ignored, as it's handled
internally by the firmware.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 502783a7a..37fc0371a 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
 static const struct key_entry dell_wmi_keymap_type_0000[] = {
 	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
 
+	/* Win-key Lock */
+	{ KE_IGNORE, 0xe000, {KEY_RESERVED} },
+
+	/* Win-key Unlock */
+	{ KE_IGNORE, 0xe001, {KEY_RESERVED} },
+
 	/* Key code is followed by brightness level */
 	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
-- 
2.47.0


