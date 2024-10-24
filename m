Return-Path: <linux-kernel+bounces-380237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581D9AEAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EC11C22A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E31F5825;
	Thu, 24 Oct 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzJNibCo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829741EC00F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784482; cv=none; b=C+DHkC8iEdH+0+UbpPzRAcbOB9f7bz++gDShBZoiOGhTBrTTSDg9Ob/NH3lNkxAJW/lYTxPaG7QwUb7ghZ3tSdpPUDhD1n9AhR/wGjokPsEyCPGSBJitZcBTTnUNTuV1ULoZI+XmSZpl1nS0jp79V8piRjgVqFzWA5vI3eDf3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784482; c=relaxed/simple;
	bh=U0TAXwaw2C091NXMCj80258qYlQ0K16hZmywscTwtI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxN9YKj5kPdJyF6goUgrwVFmDAPEh4Gyz1VU9BHiPH2v45qBJg7zv9+I+8yVn3METGIsLUk+OGAzDMpv0lgLRzTrORhf22s/PqEifQAE6mGMjaC7T64z2mYT/edh0/Vlc6gk0YrCCs8sTPDMdRmUxGgeoq4cb+hD+/zt/hY9xnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzJNibCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=++YfkOsXO2+CDpMSaSuskpa23+e1Njtxx79I5hnH+Eg=;
	b=HzJNibCoZ27nqI+VL14rxulTw5srEZC/ADN0+0IL/5tYL/l0GQ1hywrdCforkzFknGjs4o
	JD6IqsptLJuxmqkg9Xp4jqWBJEOH7yQxqC7tu67LMkkdIocyTdUJ9aUtpj+Iyga+FOZW7q
	20egqd+35aAtEyOBuZ4HJla6XYQN1gA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-vx_49t-tMtueYTB_A0VnAw-1; Thu, 24 Oct 2024 11:41:17 -0400
X-MC-Unique: vx_49t-tMtueYTB_A0VnAw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-507858fa6a3so354827e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784476; x=1730389276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++YfkOsXO2+CDpMSaSuskpa23+e1Njtxx79I5hnH+Eg=;
        b=wyAGtgS2cDwGA2NdH8a3PqWwjWGLAUBr+Mra8U/7au0b5YDDcEj3My+8XJtu7pshdl
         0W47t3/xx75kVsgXT+H446AfB9ygRki3th32wFIb9bDcJRJa0UebTsQ7CnPJqPsyTS3w
         JoLbgLEe1SdRt5hJYt94gqKYRp5jwu0Ky01WB+0nfrFfRAW3Aell/NLU+RbUklpCY7FX
         Ac1LIuSsY5uQkdFHAG+7kpgoyDP6CbhIU1GEFb9Zxgms0CHlJCRp+fqC/46ggzXGXA6y
         6mpc6rkK5uDVhhClsBzGq2uf/ZMD38k2xLLoK7CoRE3bThfuc7Q570ZA80S8bmE7ihPp
         m2tQ==
X-Gm-Message-State: AOJu0YzoA5w88wnpVVct+JDMR6D40qbRD1hZL3dc5X6n0xaS0froopya
	THJTaJF/HG09MaK7L9b2L09/sjce/NSK/MMcON0nXcqXQpCDqYgPkhzvnjIm/X9xNXAuWUiyqs9
	L8N4Of5UkJFBoopFrIlX8GyBdS+252wYYtgcfZwIC2DV90RLchJgMAwpyy8hcEw==
X-Received: by 2002:a05:6122:2a41:b0:50c:eb10:9799 with SMTP id 71dfb90a1353d-50fd01c153cmr7348187e0c.1.1729784476439;
        Thu, 24 Oct 2024 08:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoJ6EvpnJEVgvhEDgGgh5rB3alEYEoS8ZcnaHUhBm/Xe0sAWSCfSx9iajRDJ7CmO6nqrndSg==
X-Received: by 2002:a05:6122:2a41:b0:50c:eb10:9799 with SMTP id 71dfb90a1353d-50fd01c153cmr7348162e0c.1.1729784476125;
        Thu, 24 Oct 2024 08:41:16 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f5fad0sm1364301e0c.40.2024.10.24.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:41:15 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v2 0/3] nvmem: fix out-of-bounds write
Date: Thu, 24 Oct 2024 11:40:47 -0400
Message-ID: <20241024154050.3245228-1-jberring@redhat.com>
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

---
Jennifer Berringer (3):
  nvmem: core: improve range check for nvmem_cell_write()
  nvmem: core: add nvmem_cell_write_variable_u32()
  power: reset: nvmem-reboot-mode: fix write for small cells

 drivers/nvmem/core.c                    | 31 +++++++++++++++++++++++--
 drivers/power/reset/nvmem-reboot-mode.c |  2 +-
 include/linux/nvmem-consumer.h          |  6 +++++
 3 files changed, 36 insertions(+), 3 deletions(-)


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.46.2


