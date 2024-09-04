Return-Path: <linux-kernel+bounces-314404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C8796B2C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3254C1F2714E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34095146581;
	Wed,  4 Sep 2024 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5/AE7gA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD3145A05
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434751; cv=none; b=VHfMdrTpcqQAD84ckIycrfN1frBwLaU9vcT5UJyI3Sdpj6SZaxfnxcsJTBcEZ34Dwm4ZZzDHvAyCu6aCjJ9UpVDSqoVuCk+i5YQnAnm4+nGN2NBN4Pg0lbvoMBm9MUmL2Ys2HoQ11nh07tLC+dQuQMFjUjWABu4Q+SeNGeYAORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434751; c=relaxed/simple;
	bh=ZtjWFy7AfO9EdyqhcgulwtDmU/bcKMsg/rppWMCn84g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9TWNDYbwz1+zEV1RVhlMUUJw/1zfASw1G3Lj13euKZArK/zAJ7UjGq6VXNONZ7roA0+cmfkouOY3cFCwc49OgQCl3j9oZwvudOEHoz0hLedvVD6FbgB38K1HrS93X86UB4Z0xh0Kd2VM0K9rq7jo8IcNnR4C+OBOuKJeL/Ps+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5/AE7gA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725434749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Ai0i48K+x75wE2opWN6H+yE5yaU/0owwcRJ41uJwPs=;
	b=i5/AE7gAl19K/KOIpO9CUGE30Fv1fOuPst0QK1jc7nKDQjA2B2Vv5E1J9UEMk3P8VRuJyQ
	a2nA1rVfIO14MbHsABueVN1djOu/u7JCBcf06mzGwsiLn1EWUPcyqhRsZH9fYq9hQ5z6/j
	XKUhoN7umQZg22BsflHlI63u7ZRgipY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-uGuNZPkgPaGZeEifKr-1xA-1; Wed, 04 Sep 2024 03:25:47 -0400
X-MC-Unique: uGuNZPkgPaGZeEifKr-1xA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb9fa67c5so9394685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434746; x=1726039546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ai0i48K+x75wE2opWN6H+yE5yaU/0owwcRJ41uJwPs=;
        b=mTx37J7geG65i+/KJBZfnWb18UrVl7A51UqXNlOcHRl93HhyjFQWwA20C1PdnxllTM
         GO5Ypd5jw+5TUK9gT+R22FN281iHFXfpvv4x+7650ZuFx12m6BPwFD23hUB5p3pKPF86
         dFvBnqbSfi7jEI++AFjMHZ0jCBCTFo6rFfZuk02u24rZKchor57xW1heYk8bnbFddD8x
         I1myqM82JnnzIZdyhu96TCx5qhaHfA2GjDve5I2CUomETV00zK7iA3yP+s1fHtrB2hkW
         mNolPUI6e22yUH5PIdurT/z7YB7dvr3dbZzazxYIcOwWt2pZhZ1NXnQ49z6rRekQKYjB
         0C0w==
X-Forwarded-Encrypted: i=1; AJvYcCUSXRlvzsvIjAwJFl/TIkLvjUbsJgUQ8/4cA0CjEJGmn4dJeAXcv9NOeG37z90uAfq/I2CYsVFhuuih3YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyer8j+G/GTCerCSFDxWH9DBE+bSOu39z6lfiPtcma4eFhdRgCW
	2bDLfttOmBGZAXCpxvRdxsQuxftakC9DyuNYwXN6nape/oWsFASO3AIKyoiR9PHpMIiGQDc1dqC
	0UZ/t+i8xjT5vlWxepegZUuzd0AB816ZTCIK//QH2PM5fSnND2ORG1Y6rr9mi0A==
X-Received: by 2002:a05:600c:1c83:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-42bb01e5f83mr144896425e9.27.1725434746511;
        Wed, 04 Sep 2024 00:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEviBJFNrkQInUgxY9gMkRKTSBKIkiCknbrw34c2RvP/P4K3CeawHA8LFRYHivQqQ6/eeBWBQ==
X-Received: by 2002:a05:600c:1c83:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-42bb01e5f83mr144896215e9.27.1725434746012;
        Wed, 04 Sep 2024 00:25:46 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6f9b584sm193222905e9.16.2024.09.04.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:25:45 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Fix might_sleep() lockdep warning in pcim_intx()
Date: Wed,  4 Sep 2024 09:25:42 +0200
Message-ID: <20240904072541.8746-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 25216afc9db5 ("PCI: Add managed pcim_intx()") moved the
allocation step for pci_intx()'s device resource from
pcim_enable_device() to pcim_intx(). As before, pcim_enable_device()
sets pci_dev.is_managed to true; and it is never set to false again.

Under some circumstances it can happen that drivers share a struct
pci_dev. If one driver uses pcim_enable_device() and the other doesn't,
this causes the other driver to run into managed pcim_intx(), which will
try to allocate when called for the first time.

Allocations might sleep, so calling pci_intx() while holding spinlocks
becomes then invalid, which causes lockdep warnings and could cause
deadlocks.

Have pcim_enable_device()'s release function, pcim_disable_device(), set
pci_dev.is_managed to false so that subsequent drivers using the same
struct pci_dev do not run implicitly into managed code.

Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/all/20240903094431.63551744.alex.williamson@redhat.com/
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
@Alex:
Please have a look whether this fixes your issue.

Might also be cool to include your lockdep warning in the commit
message, if you can provide that.

P.
---
 drivers/pci/devres.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..c7affbbf73ab 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -483,6 +483,8 @@ static void pcim_disable_device(void *pdev_raw)
 
 	if (!pdev->pinned)
 		pci_disable_device(pdev);
+
+	pdev->is_managed = false;
 }
 
 /**
-- 
2.46.0


