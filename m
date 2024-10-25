Return-Path: <linux-kernel+bounces-381373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63199AFE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6275C2881DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFE1C0DF0;
	Fri, 25 Oct 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gOdNBYc"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD61D4144
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848790; cv=none; b=nBD9gQAeVrRFO1+pYAizoLJ4jBwhJh+4Auajezuk0C2qO8tuJH4vDeQGZcA4GNGeYlqcTKo7E8xS5yS5Id9d/xeLAN6Ap6on/1LZn2atDTA1cpq0O9+pK1qim6Wn2n/gQbQVH8uwUk/DNMUthMU0iXTFhPZp3h+Ft9rqZhZcE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848790; c=relaxed/simple;
	bh=JJ/e/Y7d5t82y7GqFYdBYuyUdcCxOpC4iH0/oGh9cWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xewr9Ow1PK+5910hQX9/Bl2WX6lvAVfkBWJJpPIz7DpjkoVC18JHn2xNZtrMtqEVQxJBKowFRczDwPcpc7i2NNMn66JsAnUjreN32MIe2W5W5EtiNZiHBOscxjlpP/1oc0tSs4aeIO54FHU50Ywggi7D4++biOnBc7qASD1aoiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gOdNBYc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9ba43a9a0so19896127b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729848787; x=1730453587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tuqhWRYGgjjam9B7W2GUDM6P6BKsivvZeF6kAk9BsZY=;
        b=3gOdNBYcZFrMsMUQElNPHJAzaA06U27ZvdNf9pso3P5BGcqeXIhEDxBihCEUE+5NbF
         7GWiT/FoYzguhEyiTgy+EM33N73oRx/z8/8jTSqN+n63K4ca7viccj/tk+OEP6WjE5dz
         tk1uoCYYhGgB/udEoq8UM2ZvGqBpIgJ0Rsi9WnE01pVMncq/EJQmXEJAZg6IqLo9atCE
         Cje6LwpcUEvrEaJUWcBnkIRbqOSc0qnbrRD580BUr1EbhqvDGKH8k+9oIcwiyvQZHNyE
         9/lEM3yIqG3jgG6KQ0VwLv5tkU7zfvYPuKHHbkyYbLCNfGVtB9cZ19z6Cd7cCWC5DMWe
         tshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729848787; x=1730453587;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuqhWRYGgjjam9B7W2GUDM6P6BKsivvZeF6kAk9BsZY=;
        b=WPrvXEdZiCo2spMvvzp9JSbpZf1gR4zyIeJ2vUOGk3lVSIbs1E5hStszWuj4UGdNVc
         JQ+qaTs4wFM0mhGHesc4PXIBrXBMRi4Dd94qiMyfM7qOGfjb80Po/goeiLlPxwtXlqo5
         JfbnSlno79WQtNVlHclV8CcW9BY94YF2vueZzMmB8Ku2DY0GONb0h6uMN45w4VMX+HuI
         k8QlHZBLx7vgiVpiabKY9xQRt6AFPZ5EkDNdGPVdMHHti70KwgjclJzrfG8LeW19c9Lv
         PRF0hyS3ADd0h71CoWrji1jhqoyMAk5+SbeeuzaL2GEWUE4Fdlz7oy6L2i8QUBhmNgFy
         aqjQ==
X-Gm-Message-State: AOJu0Yz08Ra81oqq5/b4njjXgiEeXTl62ITi4c2s9Xg3AtHYo0HCGi7P
	9O4aeai6c6OsvSvmb+y3+ehA1vDZywwwZ/JI0d6TslQ/gpxOa6bipsZLA8zPDZ/7C5659ltNThW
	hTA+McH7y52oS3Dq5puc9LdI79PKylOXfQp14T0mgRpTVo5+95ngLW9JIsyy6bzot7kHMB3yOwk
	V8G9UggQ3Ajh/7EP+XEbJf1TIrwqIa2M57GdlIGcbJ7QDtBAjLStI=
X-Google-Smtp-Source: AGHT+IECH9pM1rudCKXymTwKhtnM/AU69iz4LBnNjtGpR3vZzl1lATWUss0Na2UGHQecUxyzkYn2RvfW2Hppzw==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:690c:296:b0:68d:52a1:be9 with SMTP id
 00721157ae682-6e858147b16mr1078977b3.1.1729848786167; Fri, 25 Oct 2024
 02:33:06 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:32:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025093259.2216093-1-smostafa@google.com>
Subject: [PATCH v3] Documentation: Update the behaviour of "kvm-arm.mode"
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: corbet@lwn.net, Mostafa Saleh <smostafa@google.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit 5053c3f0519c ("KVM: arm64: Use hVHE in pKVM by default on CPUs with
VHE support") modified the behaviour of "kvm-arm.mode=protected" without
the updating the kernel parameters doc.

Update it to match the current implementation.

Also, update required architecture version for nested virtualization as
suggested by Marc.

Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>

Signed-off-by: Mostafa Saleh <smostafa@google.com>

---
v3: Reword as Marc suggested.

v2: Update nested value also
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..ed92e207e9a0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2740,17 +2740,21 @@
 			nvhe: Standard nVHE-based mode, without support for
 			      protected guests.
 
-			protected: nVHE-based mode with support for guests whose
-				   state is kept private from the host.
+			protected: Mode with support for guests whose state is
+				   kept private from the host, using VHE or
+				   nVHE depending on HW support.
 
 			nested: VHE-based mode with support for nested
-				virtualization. Requires at least ARMv8.3
-				hardware.
+				virtualization. Requires at least ARMv8.4
+				hardware (with FEAT_NV2).
 
 			Defaults to VHE/nVHE based on hardware support. Setting
 			mode to "protected" will disable kexec and hibernation
-			for the host. "nested" is experimental and should be
-			used with extreme caution.
+			for the host. To force nVHE on VHE hardware, add
+			"arm64_sw.hvhe=0 id_aa64mmfr1.vh=0" to the
+			command-line.
+			"nested" is experimental and should be used with
+			extreme caution.
 
 	kvm-arm.vgic_v3_group0_trap=
 			[KVM,ARM,EARLY] Trap guest accesses to GICv3 group-0
-- 
2.47.0.163.g1226f6d8fa-goog


