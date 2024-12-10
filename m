Return-Path: <linux-kernel+bounces-440222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9829EBA69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ACC283D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA122837B;
	Tue, 10 Dec 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ws4Sj/MV"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FA228364
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860577; cv=none; b=kgpRvYzQABHeqGhG30+R1rwknG4kPWvrXsnZBNRTBB5z44S9vH1RGQ9dLQxQpVniaq4vmnXVk8MbOQubM18TvZvzXbxTtYsxEF+aB2x8OuNA2lN6IPEGkM6ERdjdGJHn/0Sjp5C5TSdtDYTLr/WHv3BGotU8wATA6l6mo4bZPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860577; c=relaxed/simple;
	bh=JEumEao6OwtFIq3N27scJvmQPpmiw+AAjw5tpWVO+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkOIFrAL+LLHzUNhBusnJPgx1tNBMD/kF9o6s8GkhDDkp4Bo0ie8t7bZSVbf3R48MlH+zl49h8njIiTr74vSkgXhdAS2GeI/4nnQNB9A6mdnIqC2vjOhhG1N5OLAySPyLFd7ehG8uHIky2pouybAGQUi0WsrnT7r1FkC3/V0uyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ws4Sj/MV; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so3032723241.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860575; x=1734465375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FC4QnqJ94HTxVX1/4qkFrZziKxV3eN8ciCJ+f2BMLY=;
        b=Ws4Sj/MVvQsDZ4JUz9UwtCUys0nLv5tjhXrxEueNLtG3HUN0QaVVC7sqvLLuf1BLsC
         VRCNlSBoXBWcofxTdC7Lw69wE82O+3lURT/ZrEgdPjOj1lKbKohYLM+VA7GQcazKjctp
         02Aoc3IwuphW2yVTskgPEYHo+iqHeEICVgWEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860575; x=1734465375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FC4QnqJ94HTxVX1/4qkFrZziKxV3eN8ciCJ+f2BMLY=;
        b=w2RBloPWuf6IC9RedoI8sESQqGekS5nc+o+AxdzhQDYd+Apz0eXsuRhYbtsI+xv32R
         FFFaw+/yUtymBFaOfeZ4SOBRDXfz7MIw3OWY8321ciq3sTx7N0hqyqBClkXjXJGR+Yta
         V5WxoY7HW2upLbX/oqiapEjdVCO2dx7bIqDmdecISCXwglW+OReooAvuI1MVis96fhyW
         XUnVTBedcuiC+IOi6pgwrx0hDU0Qg7scZuSNas02S4jBTFzQGNYTR9xm51d0aJjq2GBc
         DAUepbOWJ0iYo+tq6h4+XsC4ikKlkr8r4DXWPzKEAyFm/0fBaoHS0f2Nu6WWC08M7d+t
         9p+A==
X-Forwarded-Encrypted: i=1; AJvYcCVKREkMfKmmXMGW+8nblWf3lPxYoQvtxjgwQzyerkkxZBeoG9SiFDQIBe9cvZbmZ/ifRpWxpMR+0Dty2NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uT9BBCVJXNGKBv01vBbOA4aDVfvdZoxO+n4hb0pX/GYyGZZb
	2v/EO0rIkKHvh5V0UGCVpEHcGZ/QpZ0Txgoki1C+jG6G2EsuFLxobEhOmxgbFg==
X-Gm-Gg: ASbGnct2Bkr85C8RSUuzQWXcdzjN8eimwY7KK1XUwIlfwcR8Z7wrjfzO89fu50Wk9ia
	+aSZ/EX0B3Kpm8sBrP8xj5cepjH34bpHuy1YgQXI+bL0LLazU5D60FQlm3TymjgwDJRiJDUb0Ae
	x5XmQma3B/F8XrUIbmnmXYsfM2BeHF0XrPB+k8lcwZZR+3NWEdiZ1mbFzhB0T31//FqBU9psSEL
	KiGba60hpp3qyyCZl+57P9CjJ4kRR/xjYor86NytnfVD4ITjwS5pEZOBWsAg8cM6qiXs9Z33RWf
	QafbFh9Ek03MapgBr5peuFcSxmYk
X-Google-Smtp-Source: AGHT+IF9huJ4RGbON6vnfjO82QKXcufJ1oPqeqqPWduurqVjnR4pau4FlzjogA7CTu3zPtWKx5FO2A==
X-Received: by 2002:a05:6102:34a:b0:4af:fa96:1ff with SMTP id ada2fe7eead31-4b1ca3daba8mr12220137.6.1733860574875;
        Tue, 10 Dec 2024 11:56:14 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:55:59 +0000
Subject: [PATCH v3 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-2-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..eaafca41cf02 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv);)
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.0.338.g60cca15819-goog


