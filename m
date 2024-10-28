Return-Path: <linux-kernel+bounces-384575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D69B2BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C60B238C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A41CC8B2;
	Mon, 28 Oct 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK9JmdWV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D21917D8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109019; cv=none; b=SEow96gK/cd5Lv2sMZfe8r9o7tx+YPLdI4Cgi3Tui9uKORQh4hpvALv5bpa0m82VbWGtMi3BRPb65vnvA33yaWwUh3ku/phCckVsCTf8DZmCP1O6KfLDJQctrPyRQoMJc0elxdC+bNaCUkPNcjvrUtJW/G0gqze7vhjr+R0+szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109019; c=relaxed/simple;
	bh=iXV7Y/rovkvq7fG37oYflSSTPnF5Vru6fQTMRXJvYMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zp8oxPOlCh/Srqgq5Wg94lvxyIcxTrekYqIbvUEqTkj7J/WCBDNWv31luvDxwZVuu5kgNaTkgucsXSc+x80DiQYM/qmzWuDjw+/2TG5uHxovRvkkFYCQ9SgGEU/8oJ5fQyVOFsN/M6i30mTm0sELDrnQLeZEFZO2LYBwRehEKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TK9JmdWV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730109016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VUejJ+UJ+2esVgtFyrwTUFuUS01wSpHp2m94ivtYPko=;
	b=TK9JmdWVB3z0MNK4z2QDc41GkSaQPN8vNnlRgTNZj31K+887KrTlBoyHZvOerSeqrgH+v5
	rULbSgIHEtusiJ9RSv/IZvtZT/gEOMVEIla5ZtIfxj71xOvOczsKlnmtwI77yIDM0XewH4
	wfvGq+cWs2oxf2R++IodKLVpxNFT84Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-DfiVg6MuOPOGUm31gaz-uA-1; Mon, 28 Oct 2024 05:50:14 -0400
X-MC-Unique: DfiVg6MuOPOGUm31gaz-uA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fb58980614so26246051fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109013; x=1730713813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUejJ+UJ+2esVgtFyrwTUFuUS01wSpHp2m94ivtYPko=;
        b=brIoBReswsFBKqJjJCPxAUvRMKuy3p4+YFeS9xX4dv7s0jcFbzctXsrhht9DhUOnK4
         eHN3pddW1BSy8Fa6GWQVy7P7Q19kJjpqonXEQ04rBHjHBaOjrNmXapLq0g83kIgtDPly
         NLGrcsMePv84B0gb+LwyCrBJz93S+hE4hx2/hi8C1/hOLAKGyouuC+eB/TDG9zWOyadt
         65w0XiyIDqUroZaqYDijoKyR8KWie6ap/ZaZwTwsXYTcSYwiXJJK9uCitzIRClCn1CsH
         WyDFWQpO56X/JQ0hM98S422zz0jdjRHVwJW95bprbanyHuSU9umb3nsROBY2Wv06Zhl5
         AZuA==
X-Gm-Message-State: AOJu0YxAm9JkwwEXbzKr4y1IWmkzxud9l5Z40EUXs2QjQPz152225cQ0
	G4wkcSdVikEQE1esZcuXB9reM0FEUj6ax25k46W6g3eS4/6L76aqidQ/sX0HMpdd5j/MMOkSFNT
	5Edv9LuzuYQVu6wH/vB++I74l7A+7PNMip3ONwu+Je12h8/gByfmalQt1lMhu9A==
X-Received: by 2002:a2e:97c8:0:b0:2f9:c337:aca9 with SMTP id 38308e7fff4ca-2fcbe0997fcmr22710811fa.44.1730109013185;
        Mon, 28 Oct 2024 02:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Ldjb2IV4d9383YR9OeonLcfidz8ILEX+eZ56Ok6PAa3fOv5UV9/Hzfx9WWsGrmjVLpt6Bg==
X-Received: by 2002:a2e:97c8:0:b0:2f9:c337:aca9 with SMTP id 38308e7fff4ca-2fcbe0997fcmr22710761fa.44.1730109012779;
        Mon, 28 Oct 2024 02:50:12 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193594c8esm102560235e9.11.2024.10.28.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:50:12 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] firewire: ohci: Replace deprecated PCI functions
Date: Mon, 28 Oct 2024 10:44:42 +0100
Message-ID: <20241028094440.19115-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/firewire/ohci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 7ee55c2804de..3c045a6fd2ef 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3726,12 +3726,11 @@ static int pci_probe(struct pci_dev *dev,
 		return -ENXIO;
 	}
 
-	err = pcim_iomap_regions(dev, 1 << 0, ohci_driver_name);
-	if (err) {
+	ohci->registers = pcim_iomap_region(dev, 0, ohci_driver_name);
+	if (IS_ERR(ohci->registers)) {
 		ohci_err(ohci, "request and map MMIO resource unavailable\n");
 		return -ENXIO;
 	}
-	ohci->registers = pcim_iomap_table(dev)[0];
 
 	for (i = 0; i < ARRAY_SIZE(ohci_quirks); i++)
 		if ((ohci_quirks[i].vendor == dev->vendor) &&
-- 
2.47.0


