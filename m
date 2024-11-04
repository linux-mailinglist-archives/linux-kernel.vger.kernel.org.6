Return-Path: <linux-kernel+bounces-395130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C99BB8EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0353D1F220E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965881C32E2;
	Mon,  4 Nov 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdMJK0F0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3A1C07DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733871; cv=none; b=DEKTz9j10brZVz1EpQT4R1gM3vYpYCcZYNP187M4Kzs+URhHFGZUp8gAsVrJv5u8gnw2Uxfh9a7AUsVctmkXWCTOAkKJPWVYtQrFhMATw592BrYBZ5O/sWPpTxv5YkPBkdZK0waEZ9BDKTa4NdTwUruHlhifuJ95j0prZ9dWnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733871; c=relaxed/simple;
	bh=F+Rkt6DFKWyeAzf1fsIGO9wOASAOwTVg+r45q4FvosM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=luuk9ysGr/F1VKWZyJRMe5qomsRSrDE1fCTlI5bQpiAIYGD23uoj3txCH/INmaAL4/8jIrmpQqV5t6AJwf+CTfftduLP81LCf8HppWDUYWkLv7LMS5wg2NZOPWxHidmULdKGuXDGCK8Dg7ahWeLXxgZC4I0O4Gn26uAiBlrHPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdMJK0F0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730733868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ceEKqnPRXD8WryuQq49T4d3l3F+Nw1UqjWpRO1N6dKs=;
	b=bdMJK0F0e3EB5KtySJbgNOpQt24OHFup5OAuhogSCApZ+BwFrefkXOlDAkm0tMPsauD3cz
	wXjrrlag0bgkNAOmxsKQjVf+OdfoLeDvU5Jwv9fgBGDIeFQtygdu+Js+a5qbYtrYFpL9Eq
	X+OX7o1d15J959lCrCGO9uf1Tad2HOM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-08v02D1vOHimV1IXXxtTWA-1; Mon, 04 Nov 2024 10:24:23 -0500
X-MC-Unique: 08v02D1vOHimV1IXXxtTWA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-288543b7a16so4803944fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733862; x=1731338662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceEKqnPRXD8WryuQq49T4d3l3F+Nw1UqjWpRO1N6dKs=;
        b=EnTOljZvh//NLhu0XDzTIBl1tGwLuYmFsEXs9vLA2lcxewlr4OOITchJHOlkwwSwb/
         kcukiSIc0oS+aWcElUPG2RGTgmVPv0iTYp/V0ncwX9IDZlp4CltSlzldG6snx/8Q7+T2
         q6f2S/d7YcdsrV1L4f5V5V1sBeVJoigb3Gn1Oyt4F7/bM2HcEJ48M4evX1twPO7Vuzqm
         QHYZBGnlKD1t+Rp+lB6AnehbVHbwu8zS9me1T2y216m1ClyqhA6atzacx4VYLVoUGkQ+
         KICZ05LmWFnZiF5vzK+G/Ew5okMv/A9W0eABIHKiYc+3qfDHMalm1BkSmkuqqs7902pm
         s+Rg==
X-Gm-Message-State: AOJu0YyxOJmlOrI/owWcWCxHBPNlUMR2rseu2bGWwiJriItCXghRXwjM
	P1QEHUGnopSFP6tlIiyPVFGPtwUXK0Fs93Hx5edgZe8oGH2U1+fixLE2wtdE0rdpVVnlA3QItyO
	JNgp3ntXsWlSRz3CpP9mGZzLfq+n7Ya5u6TcRVf7k6Tbb4aDVy5UIS6M/+l2psg==
X-Received: by 2002:a05:6871:c707:b0:28f:329e:9f23 with SMTP id 586e51a60fabf-2949f07cb9emr10704040fac.42.1730733862281;
        Mon, 04 Nov 2024 07:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgILSpblRLX3xBlUuGr2b/jMwLrVJNb7cVTeCUzdn+sJSfeFxcwKwVgNsQOBNH1k8z3UQ7vA==
X-Received: by 2002:a05:6871:c707:b0:28f:329e:9f23 with SMTP id 586e51a60fabf-2949f07cb9emr10704015fac.42.1730733861968;
        Mon, 04 Nov 2024 07:24:21 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59b45sm1980847a34.6.2024.11.04.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:24:21 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v3 0/3] nvmem: fix out-of-bounds reboot-mode write
Date: Mon,  4 Nov 2024 10:23:09 -0500
Message-ID: <20241104152312.3813601-1-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

These patches fix a small out-of-bounds write when using the
nvmem-reboot-mode driver on Qualcomm SA8775P, such as by executing
"reboot bootloader" in a shell. Relevant error log:

  BUG: KASAN: slab-out-of-bounds in nvmem_cell_prepare_write_buffer+0x144/0x47c
  Write of size 4 at addr ffff19dd8e1a37a0 by task systemd-shutdow/1
  Hardware name: Qualcomm SA8775P Ride (DT)
  Call trace:
  nvmem_cell_prepare_write_buffer
  nvmem_cell_write
  nvmem_reboot_mode_write
  The buggy address is located 0 bytes inside of
   allocated 1-byte region

This problem manifested because the devicetree file sa8775p-pmics.dtsi
specifies its reboot-mode cell with "reg = <0x48 0x1>" and so expects
the reboot mode write to only be 1 byte rather than 4. Other in-tree
devicetrees that seem likely affected include pmk8350 and pmk8550.

These changes add the missing bounds check to nvmem_cell_write and make
nvmem-reboot-mode able to only write as many bytes as it needs to.

v2:
- Added missing function definition for CONFIG_NVMEM=n

v3:
- Accepted suggestion for changing nvmem_cell_write bounds check

---
Jennifer Berringer (3):
  nvmem: core: improve range check for nvmem_cell_write()
  nvmem: core: add nvmem_cell_write_variable_u32()
  power: reset: nvmem-reboot-mode: fix write for small cells

 drivers/nvmem/core.c                    | 26 +++++++++++++++++++++++++
 drivers/power/reset/nvmem-reboot-mode.c |  2 +-
 include/linux/nvmem-consumer.h          |  6 ++++++
 3 files changed, 33 insertions(+), 1 deletion(-)


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.46.2


