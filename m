Return-Path: <linux-kernel+bounces-212457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF6906145
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BD02832DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4122C861;
	Thu, 13 Jun 2024 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="my7QeV7b"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478852A1CF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243275; cv=none; b=hwgWQXQrJyrd6ABc73IA8R9KQb8tsJkIUCqAkBPXIfOkaN9hlcDiggSFywdZO7siRl85ni4FkToAGe3TQVaKmyD7XiXOqUNCHtiTQTJbed2Y86+N+9CMJQLNhbWLECnRedW9KfuiImm6We9CfG5k8Q75Q79LHmjV8suR6XXDQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243275; c=relaxed/simple;
	bh=gfQtaaj0HZXo7hMlFPf/fqEeASqbj9LDKgF87U6g+OU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxI2XbLKkXlWJIkLf+9DrS8iuPXkniY4sxxRVhuvnNy/VpOe13uB6s+48i1HUlRmwzrbXbWSHFAt1169IgBEpw/DpdD7SivS5JuCb57jZMMf/+bzvppa2m63HmLwGjOD2XJZmQSfsR1vH6SjIvclLngv2orD5qQG+ouicOyaEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=my7QeV7b; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa79b84623so806886276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718243273; x=1718848073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vumCWMKtNGhqpjBYPo4gphn32wvxgC3E6VCZk/kLxc=;
        b=my7QeV7b0sVv5U3xmbv1GECDKcqHSDctuBsAuvnCDGL91KeqLk6n7Zt16+f0GqQXam
         1Uev48nGju1yw5IkWFz7PaYieOKVu0P28RR7qC53WSlhyd7EjrqkgOLqvxfZSMnNM2cP
         AmHc4A8EK6aKArwEfps8V0wZYSV/8YL61G6yoUWPZDAVafg7lyS2LEBSk50WvCGDf4x1
         q3u5WR8k7Id/p8CZvwoPAr68HrytmUuKOW4ChezSMrwR93oETsj5DLGpCrsB4TFo9DIH
         GQ29WEhjtt0FDG+DnC+zP7Y45yHDfXCisIJRx7Udy7DdEUSvA/vqwvZWzzvDAcniQtnD
         Em8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243273; x=1718848073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vumCWMKtNGhqpjBYPo4gphn32wvxgC3E6VCZk/kLxc=;
        b=oEV/vALnALP+LecZ8sOzsjYFBlb2Q5sw3d2MamMD03lKMailFh7trkz4FrHmGrnsqf
         TNDk3AgraRGgPrmPfgSUJOIEhHEMBKIgDNsk4HxrhEy+tQZna8BYT26KbavvgRf613LP
         Q2Bh+LdeoJ97dzFzd/jYVZVJs0cTuvcyyhy697X70q4UdlGDhWLf5Qwpch+J8FUKVZ6s
         KyKIUdYByHfvm609qxpYbVavsPUt36R/cEiLgm+F1PwKcV3gpCPq3t2DZ5qSFg8I72sE
         MlllzcHZ/8a3uP8c3S2LUXZjp63YEQBlgYg5ouXbE41AzlJa4jYld+JJBk6vgTPIAdzy
         /bjA==
X-Forwarded-Encrypted: i=1; AJvYcCXbGN6ehUV2lVkJmrRfj1z2ToSLl62lXhSRV2evH5uEmJrsGtGjcT+v7FmMigNO8Prxp/wyM6unb66p5Wq+TAZUiep7VfanqCNCVrxT
X-Gm-Message-State: AOJu0Yx/xVaciWSHujTeHzu7nO72ML+qOGvu3te6vXLcvvX8pdlc9bWp
	/nGPVQV7PR6BcgpzyIooF7WPHS37GiDcKrXSlcB4ZabMaerOyiJq0WkHKwWjlFR+lVZs5r/TKkt
	KQ928QPjI3UO/1w==
X-Google-Smtp-Source: AGHT+IFvEpeulKMnslBayi/qNovxpeMCLNZenp9tdPIPtmsoPk60eHw+DWo7dlqz4FmcD5zH55ADo4JWesNC+Ac=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:1001:b0:dfa:dec3:7480 with SMTP
 id 3f1490d57ef6-dfe69005926mr304509276.12.1718243273400; Wed, 12 Jun 2024
 18:47:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 01:47:40 +0000
In-Reply-To: <20240613014744.1370943-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613014744.1370943-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613014744.1370943-2-ziweixiao@google.com>
Subject: [PATCH net-next v2 1/5] gve: Add adminq mutex lock
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We were depending on the rtnl_lock to make sure there is only one adminq
command running at a time. But some commands may take too long to hold
the rtnl_lock, such as the upcoming flow steering operations. For such
situations, it can temporarily drop the rtnl_lock, and replace it for
these operations with a new adminq lock, which can ensure the adminq
command execution to be thread-safe.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  1 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 22 +++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ae1e21c9b0a5..ca7fce17f2c0 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -724,6 +724,7 @@ struct gve_priv {
 	union gve_adminq_command *adminq;
 	dma_addr_t adminq_bus_addr;
 	struct dma_pool *adminq_pool;
+	struct mutex adminq_lock; /* Protects adminq command execution */
 	u32 adminq_mask; /* masks prod_cnt to adminq size */
 	u32 adminq_prod_cnt; /* free-running count of AQ cmds executed */
 	u32 adminq_cmd_fail; /* free-running count of AQ cmds failed */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 8ca0def176ef..2e0c1eb87b11 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -284,6 +284,7 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 			    &priv->reg_bar0->adminq_base_address_lo);
 		iowrite32be(GVE_DRIVER_STATUS_RUN_MASK, &priv->reg_bar0->driver_status);
 	}
+	mutex_init(&priv->adminq_lock);
 	gve_set_admin_queue_ok(priv);
 	return 0;
 }
@@ -511,28 +512,29 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	return 0;
 }
 
-/* This function is not threadsafe - the caller is responsible for any
- * necessary locks.
- * The caller is also responsible for making sure there are no commands
- * waiting to be executed.
- */
 static int gve_adminq_execute_cmd(struct gve_priv *priv,
 				  union gve_adminq_command *cmd_orig)
 {
 	u32 tail, head;
 	int err;
 
+	mutex_lock(&priv->adminq_lock);
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
-	if (tail != head)
-		// This is not a valid path
-		return -EINVAL;
+	if (tail != head) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = gve_adminq_issue_cmd(priv, cmd_orig);
 	if (err)
-		return err;
+		goto out;
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 /* The device specifies that the management vector can either be the first irq
-- 
2.45.2.627.g7a2c4fd464-goog


