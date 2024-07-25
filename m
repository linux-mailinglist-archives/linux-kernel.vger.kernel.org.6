Return-Path: <linux-kernel+bounces-262137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3164A93C173
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917F1B22209
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2659C1991AA;
	Thu, 25 Jul 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBfAvRmW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108F1990CD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909297; cv=none; b=BUeLlSHkKgjVR9yTvLrco+Z1dV49Ulkw5sjCa/7WUjY7n1/fVwAbdcMOAuYv4qdnj0K2aJNAA/M6ia+9BqqdFOnKJnoQJHjXzvAd8/NWN6dR0KoNl93VvW/KIH67MScShKmzZt4Cb9tmY/uB+OTZ6KMiU1lKbsP4pFCiuAQjROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909297; c=relaxed/simple;
	bh=rQ+UT5p/NV1ClrF7k0Ek2XgjC6lNtbEvzf7W+/EEbRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiTfN8cEDZc9Je9I0+uFaTOmaHiaq+ChifvJbPQSVlwy+y7lkmhIi1zlYzOyMuEcxFamPpaENtNpILHnnh9x5AtMZ5eXQduniXfcxpmWSRcUuFhNakj6vBxrGCgtKX5js9c8IvTI2jWTa+4gDVhY4Ph3TollTc+IsXacWTVwS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBfAvRmW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721909294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vuhrzqz609EphZ9EkpRhHshpMt64cWKXo3E+j3oTh8c=;
	b=IBfAvRmWHx1+O0Ff5iBvGH92R9MvWL8wOjgVFEGt2Bp5bvS0Ra8qXIQiyNOnr6SRvEwn0A
	ZKGvBa0o0omLB64pTE5YMTIgHJBZBjwZI+URnQjl9C+gBLQsQej0iEVuyZNPBcC0SNOTKZ
	WkJ65xOszxMyPmGiYRjnLgpnqo98csQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-T12Jx5UFNeGi6LFCloOouw-1; Thu, 25 Jul 2024 08:08:13 -0400
X-MC-Unique: T12Jx5UFNeGi6LFCloOouw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426624f4b7aso1530685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909292; x=1722514092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vuhrzqz609EphZ9EkpRhHshpMt64cWKXo3E+j3oTh8c=;
        b=oY//Jex3oSrr3RDT7QOWVnQ9/9Su57N2VednS74a8WeWFYZRRYZXMbQQOhM4z9MqUo
         gucB85NEL7Ej+u7o7DaDf3+Wrc5XVuPBhLEuEC49yhUJXPl0UWP6UTYW3PcdeThVaky0
         fifDGicplDZzmyvc15okRwbswHqHPfM2LO2kO85Gdn4KhGiiV0Y+AhGsv4iXoHvcES7z
         gbP54omb7oZg70YEmBegjLKQQkKyQ/zZEWS8SC/PslxWiuq+NQDfDp1kJNjlx0DQ2nBw
         UVWew/6DoqHWn/DTP/Bsyug5gCozvnJC3n26Aw0o6M0UoPYPbzKchqCou5siLrxicvXH
         ZDAw==
X-Forwarded-Encrypted: i=1; AJvYcCXcQxjKJbqinRr78/2l6McBviwXdEZgqkrK8n+Nxs7D7U0n/mApvrOIiC7WvVynGqfpvaPhla0hO4RDu7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEc8g8AH4o49SIX8pQl6PsOS8vxxATMHU0aJ6odeJEDqZgEbs
	VyO69jQ7qrFMvi527k1jTZon1R+hRgH7JQQxDd1yuHnjWSTfZ4S6TDuBNaC3KrG8+kCaYsRKtth
	gkIGgSrKbdgZtvepGuaK15KjPww5Gqp7MUxSN8W1FI6ZHtQ5ibNBtDAI7wzQXew==
X-Received: by 2002:a5d:5f53:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36b34d23accmr907861f8f.4.1721909291990;
        Thu, 25 Jul 2024 05:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBZfokjupGiSedSXRZUFXcdEL5xOY05AFTRmn7ch58F+QFptfSpqkSaMUPpueEP3eU+g3og==
X-Received: by 2002:a5d:5f53:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36b34d23accmr907848f8f.4.1721909291440;
        Thu, 25 Jul 2024 05:08:11 -0700 (PDT)
Received: from pstanner-thinkpadp1gen5.fritz.box (200116b82d135a0064271627c11682d8.dip.versatel-1u1.de. [2001:16b8:2d13:5a00:6427:1627:c116:82d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d95dfsm1963483f8f.35.2024.07.25.05.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:08:11 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] PCI: Fix devres regression in pci_intx()
Date: Thu, 25 Jul 2024 14:07:30 +0200
Message-ID: <20240725120729.59788-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a function that becomes managed if pcim_enable_device()
has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
pcim_intx()") changed this behavior so that pci_intx() always leads to
creation of a separate device resource for itself, whereas earlier, a
shared resource was used for all PCI devres operations.

Unfortunately, pci_intx() seems to be used in some drivers' remove()
paths; in the managed case this causes a device resource to be created
on driver detach.

Fix the regression by only redirecting pci_intx() to its managed twin
pcim_intx() if the pci_command changes.

Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Reported-by: Damien Le Moal <dlemoal@kernel.org>
Closes: https://lore.kernel.org/all/b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org/
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Alright, I reproduced this with QEMU as Damien described and this here
fixes the issue on my side. Feedback welcome. Thank you very much,
Damien.

It seems that this might yet again be the issue of drivers not being
aware that pci_intx() might become managed, so they use it in their
unwind path (rightfully so; there probably was no alternative back
then).

That will make the long term cleanup difficult. But I think this for now
is the most elegant possible workaround.
---
 drivers/pci/pci.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..ffaaca0978cb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4477,12 +4477,6 @@ void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
-	/* Preserve the "hybrid" behavior for backwards compatibility */
-	if (pci_is_managed(pdev)) {
-		WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
-		return;
-	}
-
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
 
 	if (enable)
@@ -4490,8 +4484,15 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command)
+	if (new != pci_command) {
+		/* Preserve the "hybrid" behavior for backwards compatibility */
+		if (pci_is_managed(pdev)) {
+			WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
+			return;
+		}
+
 		pci_write_config_word(pdev, PCI_COMMAND, new);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
-- 
2.45.2


