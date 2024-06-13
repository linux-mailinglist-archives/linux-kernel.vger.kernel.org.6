Return-Path: <linux-kernel+bounces-212458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F607906148
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4451C21686
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1E71B51;
	Thu, 13 Jun 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aN4DpRTV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818134084E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243279; cv=none; b=BLK2Dg8n84mRL9ChzWK+qOFPuyffmsdh7/GCl/qZH+PYYvTsXLMS1uFp3VTeWPCDi+D95ExIfxLQ/oiZvWOvM+gvACOVbUVBvTZ5v73J1YKKIZHA9A6XRiPF8UxfvAVxgpkJ7+6gP2+p9+I6hUP1x4WWdHgscuJzMMCtoFv4kSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243279; c=relaxed/simple;
	bh=yEPlCVvZ6TpXWIZr3A2pqoXGTUazPLwyOx5qYXljysU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MrfMMROXVhy1DBraUDlwhK51ULniqx4bdYXguNvcBN27UgN2qpIN7+gVAvtgrsVCkct1XVX3o5rVPGj/iAEdjcYmGH+pCouzDf2xCMQhMB91JXfKqxEtUGdJspqDPZamq+o8MsQe5QiX9Hwh6fvhvOMx9qpnWJe1V9G8Kl1an8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aN4DpRTV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe148f1549so586966276.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718243276; x=1718848076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=msKTwCYRL4cMuPaWEm93vo3RuOQA0J5NZychvQnocak=;
        b=aN4DpRTVabwoefFcHBz4sU9Jpt3l8xGmh3GoPtpQg1eRIe0jivRuB2QgCL57wdANTv
         yjd7mlS9F7c101KVCl+HLqJ2LPMr4iwLJSqW9DLE4+lJqh/Zx6uVlDJ8j/oBZ2t7yRZq
         Ml9IZTRUsNICb9YSNRzN6Qd/Y+SBv3n9+Lb48E0ijT9oMuTgVFMbV0MsLWv/0QioKNAL
         2UJ77vBmS5TGm+CIEdbLT524ctT6XPf0UFw0aBaA2DDREOisExDDvK+btmZ1eDfCoP29
         63ZrqdiKGcb74351rvLIwlhhpViuxlGAkLKobAp+3KE+BSranepPECx/FHI7/L4KfJM8
         4p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243276; x=1718848076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msKTwCYRL4cMuPaWEm93vo3RuOQA0J5NZychvQnocak=;
        b=cK2CNP5n389j0Oms1mZ5EoXluqNn8zBFB/Bszv0FHyMEo5nYj/lDu9EfkT4rlFCOxj
         Q+9c9Yu6ja5/6PCAbqAuFvfLxRSPeE1QV+QTDwEebTqw0ov78lG/Tgz+lTAVqpoiWxy/
         ez5w0RWIlBa9s6oO88UpSYp7mmHjV6QxztZ2wTLhiu9MomCLfEebDdZawRlIrLBHyciu
         6OtQCGiYdS2o2hDF7n1t8WQ7UvgV5wRSfWXFIr2WN2cSfjlhCpUKKTryW8i1HfF98kjT
         Yu2yaJ9LckVBhl0Sjyhr3hkKmWfCJ0oG+eCnr4vq+WhMjY505UzwfI/+Kzhc+dA6jZe0
         X37g==
X-Forwarded-Encrypted: i=1; AJvYcCXZzkigySmohGjkgjYBwgUijNRMA7sqvDYTHgFdnlS14U2RV19Zpp4tnZjOuh6m6GtsnDXvfSVCjwHHr9+EpLZPyQa4rAh0a4dDTyFH
X-Gm-Message-State: AOJu0Yw737CDWvaCbnwfqdpZc7yQikx0aMK2sRHat02WkrWsmma9IjNY
	8M+yXSqJlxR2PDkLkFqXV8zii9Z3N2OUFO3peZmlmUTB2x8wLOHxigZOs9d+hMRlwzKk9Mzyfms
	u9Bm2NrgJQC01JQ==
X-Google-Smtp-Source: AGHT+IEAXOWjf5nbwCbyBuHzMmR1OaooC/zMfCv3GgBS9IwLHRxNElIeth3U2qdcZtYFS1IwcGfpkcAPR4bbvmY=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:ab04:0:b0:dfa:6ea5:c8d5 with SMTP id
 3f1490d57ef6-dfe6803c9ccmr576709276.10.1718243276383; Wed, 12 Jun 2024
 18:47:56 -0700 (PDT)
Date: Thu, 13 Jun 2024 01:47:41 +0000
In-Reply-To: <20240613014744.1370943-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613014744.1370943-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613014744.1370943-3-ziweixiao@google.com>
Subject: [PATCH net-next v2 2/5] gve: Add adminq extended command
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

The adminq command is limited to 64 bytes per entry and it's 56 bytes
for the command itself at maximum. To support larger commands, we need
to dma_alloc a separate memory to put the command in that memory and
send the dma memory address instead of the actual command.

Introduce an extended adminq command to wrap the real command with the
inner opcode and the allocated dma memory address specified. Once the
device receives it, it can get the real command from the given dma
memory address. As designed with the device, all the extended commands
will use inner opcode larger than 0xFF.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v2:
	- Update the commit message to use imperative mood 
	- Add the __maybe_unused attribute for the unused function of
	  gve_adminq_execute_extended_cmd

 drivers/net/ethernet/google/gve/gve_adminq.c | 31 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h | 12 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 2e0c1eb87b11..5b54ce369eb2 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -461,6 +461,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 
 	memcpy(cmd, cmd_orig, sizeof(*cmd_orig));
 	opcode = be32_to_cpu(READ_ONCE(cmd->opcode));
+	if (opcode == GVE_ADMINQ_EXTENDED_COMMAND)
+		opcode = be32_to_cpu(cmd->extended_command.inner_opcode);
 
 	switch (opcode) {
 	case GVE_ADMINQ_DESCRIBE_DEVICE:
@@ -537,6 +539,35 @@ static int gve_adminq_execute_cmd(struct gve_priv *priv,
 	return err;
 }
 
+static int __maybe_unused gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
+							  size_t cmd_size, void *cmd_orig)
+{
+	union gve_adminq_command cmd;
+	dma_addr_t inner_cmd_bus;
+	void *inner_cmd;
+	int err;
+
+	inner_cmd = dma_alloc_coherent(&priv->pdev->dev, cmd_size,
+				       &inner_cmd_bus, GFP_KERNEL);
+	if (!inner_cmd)
+		return -ENOMEM;
+
+	memcpy(inner_cmd, cmd_orig, cmd_size);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_EXTENDED_COMMAND);
+	cmd.extended_command = (struct gve_adminq_extended_command) {
+		.inner_opcode = cpu_to_be32(opcode),
+		.inner_length = cpu_to_be32(cmd_size),
+		.inner_command_addr = cpu_to_be64(inner_cmd_bus),
+	};
+
+	err = gve_adminq_execute_cmd(priv, &cmd);
+
+	dma_free_coherent(&priv->pdev->dev, cmd_size, inner_cmd, inner_cmd_bus);
+	return err;
+}
+
 /* The device specifies that the management vector can either be the first irq
  * or the last irq. ntfy_blk_msix_base_idx indicates the first irq assigned to
  * the ntfy blks. It if is 0 then the management vector is last, if it is 1 then
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e64f0dbe744d..e0370ace8397 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -25,6 +25,9 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_REPORT_LINK_SPEED		= 0xD,
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
+
+	/* For commands that are larger than 56 bytes */
+	GVE_ADMINQ_EXTENDED_COMMAND		= 0xFF,
 };
 
 /* Admin queue status codes */
@@ -208,6 +211,14 @@ enum gve_driver_capbility {
 #define GVE_DRIVER_CAPABILITY_FLAGS3 0x0
 #define GVE_DRIVER_CAPABILITY_FLAGS4 0x0
 
+struct gve_adminq_extended_command {
+	__be32 inner_opcode;
+	__be32 inner_length;
+	__be64 inner_command_addr;
+};
+
+static_assert(sizeof(struct gve_adminq_extended_command) == 16);
+
 struct gve_driver_info {
 	u8 os_type;	/* 0x01 = Linux */
 	u8 driver_major;
@@ -432,6 +443,7 @@ union gve_adminq_command {
 			struct gve_adminq_get_ptype_map get_ptype_map;
 			struct gve_adminq_verify_driver_compatibility
 						verify_driver_compatibility;
+			struct gve_adminq_extended_command extended_command;
 		};
 	};
 	u8 reserved[64];
-- 
2.45.2.627.g7a2c4fd464-goog


