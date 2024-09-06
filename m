Return-Path: <linux-kernel+bounces-318840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A696F40B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C06E1F22AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B51CC170;
	Fri,  6 Sep 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNEBQqTW"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD9153598
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624749; cv=none; b=gr+lzkDmo6cwA5Jj1LN1IiZTe8ekeaBOS3yfSISQItSceiJmqE8WXclrkmsYq5V2urb8v8hoZSvDIpm/YSrPdy6M/OlFzphAeig5y1dvG5WijrNGyXuY6gjHmc2uc68cTQnNF8RslYsqm4tg61Uv7DNMM6WnY20Pl9CIqBC0v1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624749; c=relaxed/simple;
	bh=Vw3MSMgEPFW0PHWjvj/cZgyqKGRFPuv5Oi4swshCZ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IP6hM1i3BQ3B5Ehq/ndHs7avGLnkyZx49OtDtK44xPuqyXJFHSejJ2rjJTj/S+X543JsKzHGc74hKR+r7VIWcof/StCS3c3SxjhYsoCsiQxYtiJvDla0l+eSSxgHUX6rYJlo+G7dCV/DhtkKbgwVIuEdJIABSk+fphLnJY6EOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNEBQqTW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717914d6c95so1190872b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725624746; x=1726229546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4i5GjoVWDaeMVQ6cAW+T8IdgpyJeUer4e3C9DPHuxko=;
        b=dNEBQqTWWZzwlaJskHk8QQ6caYpGd98mQ257Jkk8d84qqYbSoI43KOxFIrJMfDbFbz
         yCZ1nWFKW4HPAPDyiTzmSWOXuTS81HOflgkUMmVNv658JOAQtYTQZpF1P1/ipTy/iWZp
         yRl02+Wy/xk/LhKi/kq7tLSRaEXl9RmVVi2ZiATjwYTlGivH0ezKN1xRFLgjDt1w57R3
         bTcd6uLbgvC9H4Qwajs1Zi21vy6QFJ8op5EA/CsnwVJjM8iI14EhJDkUJW5/e6huXlLd
         6MduRdbKICOuHSo6JvlDEhmNKboCeZdBJk5PWX5JZ0CDT0kotrnhVX2EGDbGIaoz1LlI
         y6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624746; x=1726229546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4i5GjoVWDaeMVQ6cAW+T8IdgpyJeUer4e3C9DPHuxko=;
        b=PNJV6nZVwg3zghrI6np9I0BZkNg7R0ft7JBNIawnAZeB3h4G25Fwfj/wylNhU2wkmg
         NqKVffA4SyxXXGyGwcPP7UKmskcbzk65r+If6DUZIoNbJ7FDUi/AYXPbRVlnJw7/EEP7
         JyQnjlhueRgzOAPUuzpziO3di56oUX2RLWa3En+AN5G0PksLgcbtamuViFWM1aqFVsJx
         MKgiOkiCKVEN4ISbmZ94wmwAgHzW7i5hreyyiXo5BmomkJAi6NJLNfQCUXzkmyEw3AaA
         5tMMr/QYtNmVHpCfRhoKeGj7PkMT8Es0mIScUClBCP6rqCpsnctja/JclFaWH9UbDxzM
         7XbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjO+9/oP7IciW4gr9U3Y3yWgCLzp8ehYMysbLGr+jsMDJO1gaT+9SM/yOJ/uTTh8o5Wvmn1uUDv8Bw0cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXj0OluDO/Cfz31jexehZ27vjnTMJiEictbrrVsadQSExxKibx
	i5plXMCbx9OQk5Ct0YDxLeYA7pO522YKL9AhzPMVR6Vn9BG2X5rf
X-Google-Smtp-Source: AGHT+IHTmhc1gZpRra32bgNWhZruveRs3OXjeDUXBRoXJYFvEh+UAyj0gYce4Qo1QpKbKdsC006ujQ==
X-Received: by 2002:a05:6a21:9688:b0:1cc:e24d:3306 with SMTP id adf61e73a8af0-1cf1d1346e3mr2457501637.25.1725624745773;
        Fri, 06 Sep 2024 05:12:25 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd93559sm4876614a12.54.2024.09.06.05.12.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Sep 2024 05:12:25 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ni_routing: Check when the file could not be opened
Date: Fri,  6 Sep 2024 21:12:16 +0900
Message-ID: <20240906121217.79507-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
---
ah this is It's just a defense code just in case.
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb..892a66b2cea6 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -140,6 +140,11 @@ int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
 
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
+
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
 	for (int i = 0; ni_all_route_values[i]; ++i)
-- 
2.43.0


