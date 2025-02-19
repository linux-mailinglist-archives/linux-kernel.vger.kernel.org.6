Return-Path: <linux-kernel+bounces-521228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C5A3B932
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779C61886B61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C41DE4CC;
	Wed, 19 Feb 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="oU2PPJ/v"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76981188CCA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956920; cv=none; b=YtOzD9LyISizkqQrrQXXStwPxFyDX9Eg3+HbCyhDqjGVKXMbjJQOZWiDyNA5a9PmMgLB9CI5cRnZWCxrB1WzQ2NKbdMHTm28z1FDG/j0mpLyjhdxMEXNLXXOgMPBRvkM75kRcK96PNbfiFgL1vVPW3FastaZ39SPxPIGYNzeEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956920; c=relaxed/simple;
	bh=06zekNo4G5A9Yo+HE7oMbGANNouN/RkqHggAuhSD9pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7Zjcwlo7wza15JCcwGtHPObZ/iL//cFsjTx4Ec1dp/8zjYI7ru9yVrxRvZhqDDOhLdnsTuUPRLjFJqEMCfyyOaFr+I3iIMSYHS858qq0WTRNuZ6BJ9tqDvf0FcAeu4OwCqWpUpV8AUqszLrxLy+8ntU6Ohk2wzzIpwLonLCEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=oU2PPJ/v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8eb195aso131271575ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739956917; x=1740561717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGcvgLQoClXs80g5vbFFNvxScD5flsZCA4rpWM74C3M=;
        b=oU2PPJ/v5Fcmvbzt+jt9EkREPkVU4DCfdzmA+5INaFRp9kw3iOWBLJMqUtwfZr6mlH
         GRVZM+qM0800Bh0CCJYjOdei8hFhmaT74aUt0CBUS/hCT4wDKTOxTDGSdnDioKyBs6kF
         xlnkvFVmJT0fJ5As4T0ddkhy7rH/LvW4EAw9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956917; x=1740561717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGcvgLQoClXs80g5vbFFNvxScD5flsZCA4rpWM74C3M=;
        b=nv4zzl238Ku6WkXR3BzU5MTSjZorLnIjC27fSeUVwNKvWbMYtwVznt5H6haxIrk0jq
         FxBPnxSuGKcuCsTs5kndTrSKV49MCXZqE/R8sNSfvxhax9iT8ezsoRMz6Abng8iLQEM0
         KW4wrM6x24CXrdzoBpSTEI3XsVAFlGrvdaLgikigezFE9maqRvXXThW2KUGMP2jBwZ66
         pWt5o1z8C5YT44127m4rtDyL8+q/1+89FEWF0FDlFvfD1dRaBawfyoCdPtCVq49+Dl9N
         ikqWieUnuh85qd1zY7KJYzA1T4g6RXTD1SI3gCDSmfRcUPtyhz2VJJbNqw6NYcAHylsT
         6d1Q==
X-Gm-Message-State: AOJu0YyOXr4V4aZu/thiaCXC2P2C2HXu0FpqSnTyFWE/0YT9PSh8GVGs
	9/4jClCyO6EgXfu647HkYrQx/hA5OeEyrs/NnTe3ewcwvLwi1xJJh5R2/smHoo0KBpBTH/SuyZZ
	q
X-Gm-Gg: ASbGncsBo/YBJtIHqg6aMB0opdUkqKh7yznluW94d3Uv2LPczaNQzIOGU8ejcNF3jPD
	GpYXgB3nNynkKiWTXNQppWFVuzXxFxVJM+TCVLSRYVUu4IfpBRaf9DLJFlhU0dY7baFniY8Az4B
	2eema/fTTYky1yh/kI1zP4XlmOqnQeaOuCBoTYEfFL3u9TbuySShj2qh4Y0H/T4V3h+peFecw0w
	vew5H6ka/QBelOlHRBlVkVzp+srpOO8jrB/qwzXwjKPyqfcVS1giHMvxne0WcPpCRQfELj0OLwI
	olLE9A10k9miqFFHwwZ7
X-Google-Smtp-Source: AGHT+IGOkbPUG9s+Z3lR4D6l0Ibe4DlEnvm9sm1otOt0YJAICtmcrmiifBkRnfDukKfWwvlGEv6ryg==
X-Received: by 2002:a05:6a00:2d22:b0:730:8ed8:6cd0 with SMTP id d2e1a72fcca58-7329df25424mr4415076b3a.16.1739956917207;
        Wed, 19 Feb 2025 01:21:57 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425463ebsm11840304b3a.19.2025.02.19.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:21:56 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Roger Pau Monne <roger.pau@citrix.com>
Subject: [PATCH v3 0/3] xen: Fix usage of devices behind a VMD bridge
Date: Wed, 19 Feb 2025 10:20:54 +0100
Message-ID: <20250219092059.90850-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

The following series should fix the usage of devices behind a VMD bridge
when running Linux as a Xen PV hardware domain (dom0).  I've only been
able to test PV. I think PVH should also work but I don't have hardware
capable of testing it right now.

I don't expect the first two patches to be problematic, the last patch
is likely to be more controversial.  I've tested it internally and
didn't see any issues, but my testing of PV mode is mostly limited to
dom0.

Thanks, Roger.

Roger Pau Monne (3):
  xen/pci: Do not register devices with segments >= 0x10000
  PCI: vmd: Disable MSI remapping bypass under Xen
  PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag

 arch/x86/pci/xen.c           |  8 ++------
 drivers/pci/controller/vmd.c | 20 +++++++++++++++++++
 drivers/pci/msi/msi.c        | 37 ++++++++++++++++++++----------------
 drivers/xen/pci.c            | 32 +++++++++++++++++++++++++++++++
 include/linux/msi.h          |  3 ++-
 kernel/irq/msi.c             |  2 +-
 6 files changed, 78 insertions(+), 24 deletions(-)

-- 
2.46.0


