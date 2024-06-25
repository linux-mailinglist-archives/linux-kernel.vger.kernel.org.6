Return-Path: <linux-kernel+bounces-228103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E50915ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552051F22430
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F65168BE;
	Tue, 25 Jun 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zr4n0jcG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB8EAF1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274363; cv=none; b=enQin7IsDzB/7HD/NZmQASaG+nzOkWl33r3ovWb35TVv/s5NPJu0PKT0Bz64Fmplw3m5gxufUWzXgjBq8cYpyLlOkBlZQq8cBKErB1iHgkuJ1ycbzUJlLmrIUgALq2itnhHB1H95HBZOn1gCRzDcU2l52CjdJ1wnA5DUOV2RGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274363; c=relaxed/simple;
	bh=Y061ARsTcLL64UeCL1OpNBWRzTIabPLT+H5igaWLknE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJAz0zCKcyyazqH7teRdQMlukPEWxuw0rDnIO1tZyrPSIu07eZ3L+UsrhqKzMdcdBAuA3Sv20wx1DE653BVW3BJFaP4YxyVbdxGlZzeMS4Hjc8R/I6VLIGJBl0YEMgJFtFIrvo4atF/0eo6EiW8SUm23QDBoRA4CERdOv1kNe5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zr4n0jcG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02f2c852f3so6584385276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274360; x=1719879160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7FM3/xX6Lc4btkBtIt2Q6DBER/DvgUWk0QFpD3KO0k=;
        b=Zr4n0jcGcBqnFvhXWQAov/kRg2a02/oezvnFKyMXgbaFyEAMLWLx0B3d/XU8bozgzP
         5NC4FJEbonz35Z/cQ5qWMWdLsSSNn3IxgIoTYf3KBD8zHbQIXohqb3dMFhHwTWEPoNOK
         35AfiTMhAkHKeoe25bqymDo99DWVTofmfhLO82fkaA6Xv0HGi8Uk76AfTtWkCAlqqBzV
         x1Ws9Bc5uO+DVpx/IMrB5HnfXVAyHQfQiUdU2l2CAIBMD5p+FPjo91trNWBRdZIpsI9o
         0xooguvY59bZrlUAMUzw9ImHajpQDSW932o7mgSYKxEsAGP+q1O3tWUtCoqs5eC65/29
         zBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274360; x=1719879160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7FM3/xX6Lc4btkBtIt2Q6DBER/DvgUWk0QFpD3KO0k=;
        b=Hop+frIzfvJFZLCW+0IKn6mCgahVX5yVk/WPCY+ZdYuv0eIEuD00LXJC1iUI9A8wjm
         9vEcUZ6WXbT4HIABvsqXw3Zs89+YLtQ79D3V7Ogtxwfdxu+eYKXtgHdC3bqjnorsnHrE
         YDH4QRCbG9Eu21jPRmdJV12Kn0lxFDc5T7JgVGez7uIaEZYDw8H+caOn0b75ch4z73D6
         hzHgyetD5bSUQr1R+rvgEisbljKahbalvilDDM2pFZiamKu/K120LbdmIdM/DBYFQEx5
         pMNeHQ3xg+Rh8ysjdb71YDi3WN7lntzvksgOkqrYuWsVDDb7yyNNUGhbj6fMqiRWl37k
         ghjg==
X-Forwarded-Encrypted: i=1; AJvYcCU5iqhjyGwKWeOHQNVCaNBwM5S7drQoI1A9pseYI/Dgm1/cTGZDNIu4VAb7cBGwZCh9Pxt7jd8soD9U8XhH6LpAjHLakl2ZR9l7Zk6j
X-Gm-Message-State: AOJu0YwSos0NaSyeTabZhTo0qzVNRQr3mtVoczSPEiZRWtCAteV9gFd5
	FjzurmQ5Y0BBPyuWeKUqfzDgv0iaocQj2Me0vZgGdfMbd7i0YO3BHVcwgknqZnNZFWQ+fYDaMOA
	jTu1IYSKpmdQ1Yw==
X-Google-Smtp-Source: AGHT+IEpq5OYP+j22Kxkcqn+Xur49FuZ1HbNefYyLI+mw9H3zRmeAteMxjS18l883dp69g8XtKiI+FrTMIqjPlw=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:c02:b0:dff:36b3:5c27 with SMTP
 id 3f1490d57ef6-e0303fd6cf4mr174201276.3.1719274360582; Mon, 24 Jun 2024
 17:12:40 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:28 +0000
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625001232.1476315-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-3-ziweixiao@google.com>
Subject: [PATCH net-next v3 2/5] gve: Add adminq extended command
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
2.45.2.741.gdbec12cfda-goog


