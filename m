Return-Path: <linux-kernel+bounces-356113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7D995C95
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D236C283092
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFB13B58D;
	Wed,  9 Oct 2024 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Rz0gI6bP"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3A13D890
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435378; cv=none; b=efvI0Auyx2UFZaY8OSIeyuNd/o4jl2F9ht3sr0SUSUDTICTve265tu5A6kuAeZiFCWzSkU3/6qzuT7PqK3JWBNUyCwzSmabFY2KQQ0mG8f3tXm+aoLlXdebWM0JZWdqR9zGCxyQz4KeNljl69ITpkcl583mvOz/KIFcfg3++XaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435378; c=relaxed/simple;
	bh=w3PyoCLDwvBpb9QcaTe+IfR5xAs/HBKMLh3YZwzD30c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7T6/yfyYPW8EuC4aDyC/Swh1dHwlmlNgcr+BDBoe6yoPh/aom/0dsZJbi14yGlr/N5Q181IgxKilc2un0DCxWXvsTjuQKMiZzmZikMtj8rNa0CCqH+kwqjYLiUZ4XmV6lnMNIzNkLC8Ep/Zo1OJtIQv/w5O9b0jkZETwrqstWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Rz0gI6bP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-208cf673b8dso69084145ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435376; x=1729040176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z75IqLrMWdIhV00xNDkOvX+v1lJa5CtaV8sWjNm85A=;
        b=Rz0gI6bPkY2U5VG3VCfjpfObFPsG2+U/jQgsOgszmifH7Mp5RnIabIBEun5O2S5/8s
         DZ/Z1PrHtTXRxkw5XJdcdSvA43hujlgA7owMhPbQoZxRQ2gAfdbGC0nAYZh0TS0OCmOK
         oQqLNmAGVIDaRxZvfLBCdBE9OlOYIMZ84I+RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435376; x=1729040176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z75IqLrMWdIhV00xNDkOvX+v1lJa5CtaV8sWjNm85A=;
        b=Dz4opDkUCSNqHUU32Y1ajki80XQHt4E+mO2xK4vaniQ3tLiQdJxT9EqxFW9s+ggXH9
         P1Kqwr7jXWcrwtLuvAjtfom8BDWNA4Btm8zZLEFzcrtXJcLAxW1ko5Ig1HUfcC62lHT9
         i7a82iGfet6x9wB87v+0BFC44CXFo/9oDpUoFkfahpnPeY2fKVO8G0SV5maIEj3j3pR+
         dRIucI8FZxbGCJZoQMjKEzj/xl8cmEcD+CAOlzpV72uql6DemXHaSm/usqxejmnjEEs2
         nsIzvaKbVBjKDuJ2PW+1afCYDQQseupHI26E+BgLPOaWed0egON2KQx+n1Iooh3Am4Mh
         xILg==
X-Forwarded-Encrypted: i=1; AJvYcCUHW9uxZY7ToJ1RjuN/GNnidWOis/jtDEBQ1+q2WZZPSkG5E2DV+P1fkfE8UU0bYsPavMJBwI7RCTlq/1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1aNNII3eoyXfePtVoBUZNTAoCYKP/cqfdWve/yAvfNbfKVOf
	ATA0UfroilBByyZ1agBera9emjSoEnftJCa8Rg7cwxZY5Q76UN0P+JG8xv5MMZM=
X-Google-Smtp-Source: AGHT+IFKh8PQ2F6a8qI4cgzTsO1otx8ErNT8oz4yduW9Kr/C9SXF+H773RpC0hS0cgYHwndSbOKE+Q==
X-Received: by 2002:a17:903:2349:b0:20b:6d5c:8e1 with SMTP id d9443c01a7336-20c636dd062mr11743245ad.7.1728435376507;
        Tue, 08 Oct 2024 17:56:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:56:16 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 9/9] mlx4: Add support for persistent NAPI config to RX CQs
Date: Wed,  9 Oct 2024 00:55:03 +0000
Message-Id: <20241009005525.13651-10-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing RX CQ NAPIs.

Presently, struct napi_config only has support for two fields used for
RX, so there is no need to support them with TX CQs, yet.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 461cc2c79c71..0e92956e84cf 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -156,7 +156,8 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
-		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_add_config(cq->dev, &cq->napi, mlx4_en_poll_rx_cq,
+				      cq_idx);
 		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
 		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
-- 
2.34.1


