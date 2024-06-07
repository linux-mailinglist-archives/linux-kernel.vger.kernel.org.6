Return-Path: <linux-kernel+bounces-206383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA99008B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCFF293037
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A2195F23;
	Fri,  7 Jun 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnK8HrNV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB219538C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773897; cv=none; b=TA6QkBlPwn0lQHUPTC/BCBTc5ExRsI4dzzyuFkHeBS+g5ek2VpYRvQ2I+haScb2jakPUDeQ/JmB8duCdJN5rzq3MAS4ZbwcHn+zCTRPohVDULOaxAKBY87DQAcemlLJQ/yE3eRvnCrbJYsudLPKazyyYuBFthPl6rY+IJziiLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773897; c=relaxed/simple;
	bh=7u5Kq1brXSsHc7yb6Z2jTQVjPStfm1aWws6CwBvVo2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=k4NG9oudQLSMjcKRZdPFivCYnX7HBgBmv5QVXcOv2RZqu/kSVEJAZi5TqS9lVeGugp7lcniALCjb2kDtH/ymbLcfnlmjTkB6K8wd6PR4oT8g7YHkvYBJ2sSNOcNCsQG9ezE9tOWyC4EbQJQDPIZk6j7IrGbqalVxCHjaOhwRLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnK8HrNV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717773894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LU5NzzP6V+9mwVMNTyXJ7sgLtfZ2ktDoJyAshRfGtNY=;
	b=TnK8HrNVXOljfZ0OUNNMObWA6GLUdg195TlERYrDFo4ISgcvNruuyr9Te0mqUhqzU9L7WM
	uUDLN7oF8xsv0gwbd6zi08u47VMBUSQzFypEcFc1NTD+veqTONDCIVC8Z2MVGPwJTtkTU5
	atpPmmbRPXgDGJT3aRQmuJf2rFZhdY8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-0Q_3i9AdPWqj_jtKifaLJA-1; Fri, 07 Jun 2024 11:24:52 -0400
X-MC-Unique: 0Q_3i9AdPWqj_jtKifaLJA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7953fc67fc8so120549685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 08:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773892; x=1718378692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LU5NzzP6V+9mwVMNTyXJ7sgLtfZ2ktDoJyAshRfGtNY=;
        b=e18eDvoU+GTJKcM8Q9YqS+LOMQSo4KdcOeSbLB7a9fR9L90Ew4ilVDRk2wHLcSehLh
         XwR/H0X6CtMcZbd3qBzWdPfU/1xC84GfHDkUZ6RAxvN96By68FTMm4E8znulpTm6L1wU
         NkXCEExIPakN7UW2wZe1zFhlktuSpZL3Rx4r9+/7mT73CLVevFYmiS/m0UP/COx2OmYm
         iwOdSLFjRUgITXuBVw0maWUBkiXD/hRtpRxy5nKILlLU6R9cm9VMcgiquNU4SF0TPbs7
         uD7MQqGQnL7A/xjlOjPAIXKkxrDEpaK4umOUs379CwrOGqXg2RqcxHPZ4sa9JlVxQer0
         Osbg==
X-Gm-Message-State: AOJu0Yyy8IkRFLApeOyif1pWyCwtphayIb1qOcHpbfR8LpSx854du7PK
	TrLizVLILfjpcriXPJKbJ8u8iq8XjL1SWLzsDwFtjTCEZ6jZG8VJegH5u71+UjGYi+WjQzlhSJn
	TqHlYjW/3tE2au70w6Hyzm+aRHgIKZyYUnqpDDn+3Cd2YsKqWLso/kEexLGWI4e9uRCusqQ==
X-Received: by 2002:a05:620a:25d1:b0:794:f1d8:2798 with SMTP id af79cd13be357-7953c43c48amr298634685a.43.1717773891564;
        Fri, 07 Jun 2024 08:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Ru4y6JR7LWzbICpWk3//XUDjpsGSRIRN2VBLwLDtDBo9OCUr1sBJ/ZO4cP3XEB8p+oUlww==
X-Received: by 2002:a05:620a:25d1:b0:794:f1d8:2798 with SMTP id af79cd13be357-7953c43c48amr298632585a.43.1717773891180;
        Fri, 07 Jun 2024 08:24:51 -0700 (PDT)
Received: from x1.. (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b2426sm176765885a.73.2024.06.07.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:24:50 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	javierm@redhat.com
Subject: [PATCH v2] lib/Kconfig.debug: document panic= command line option and procfs entry for PANIC_TIMEOUT
Date: Fri,  7 Jun 2024 11:24:43 -0400
Message-ID: <20240607152443.925168-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

PANIC_TIMEOUT can also be controlled with the panic= kernel command line
option and the file /proc/sys/kernel/panic. Let's document both of
these in the Kconfig help text.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
Changes since v1:
- Added /proc/sys/kernel/panic as suggested by Javier.

 lib/Kconfig.debug | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..2fc9f0ddde0b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1043,7 +1043,9 @@ config PANIC_TIMEOUT
 	  Set the timeout value (in seconds) until a reboot occurs when
 	  the kernel panics. If n = 0, then we wait forever. A timeout
 	  value n > 0 will wait n seconds before rebooting, while a timeout
-	  value n < 0 will reboot immediately.
+	  value n < 0 will reboot immediately. This setting can be overridden
+	  with the kernel command line option panic=, and from userspace via
+	  /proc/sys/kernel/panic.
 
 config LOCKUP_DETECTOR
 	bool
-- 
2.45.1


