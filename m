Return-Path: <linux-kernel+bounces-400456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358F9C0DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FD41C2287B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EA21733F;
	Thu,  7 Nov 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dCCfewTo"
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD82170D1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004271; cv=none; b=FBTICzgcB0fL0h4aQPM7kf1ojAq21RWo22ZdH/kty7BbFTTn7lR0MOmmPv8qtSZpa8Zk75xqI92C7iAVbLtYx0Wk44o0I/zvrvOb52qnzcbXsTh5L6nYq2c0MTYUoe9IoDXD8rHU1Dsj+kbyfukEp6EWmj659TTUB6mxGMl1F9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004271; c=relaxed/simple;
	bh=+7GSFZS1z6Q2nK/J2hOMMCbumu8o1d3GcPgXqPKINp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCM7EX0hAZwE0DeIzzMHuI+G2VboyTLdazrqBMmtXDLx87LeaEe6l7xULu/Ync3dAJKx+uMgmzeBgblInrlY8uabEByxwsnXG/i1ZBlGBFijc6T2XDiBuDipsP7E0oRU+uY2gn25JZwNbN59lVnWoK85oM+7TSp8yPl/tBpIPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dCCfewTo; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-288fec398f8so171542fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1731004267; x=1731609067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJVBj2BWP8MSLlUfkHkKfAXT6jikollCx1oJSSB5KYA=;
        b=dCCfewToE6WDXM+aNrvaaWxNKu+Keal/QvnIC5yxKXKpdvBbK8MVTxtTI76XDng1VW
         nPDmhnzu8LT5mdALd6JzMdkTgEhVjjlj0nXYY6kd0U6DdSeiNSkQho2VJoLdHfB1rRMP
         4BxXbzupp6cElZ9H2LNKYRUj3lTbaIi2fbViwtgM6TjZu/CRGluFP3CVzaYqtbhAJ6g6
         Bg6IDnWXolgh6YpRCjWeMbvC17Md+oy2BorOVWsf6/1CE1fmXkp7p5yChoYtFMipvPWj
         adjrO1hEJOSVwcbK0h8o06r45+dfwDGvUPXNnAdEDEzg2YAc0VGOghrtNmRCcYzwOYa3
         zVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004267; x=1731609067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJVBj2BWP8MSLlUfkHkKfAXT6jikollCx1oJSSB5KYA=;
        b=NPNRi9L1fZBcLlIE5+HhWhG5zdnvC5ZeqSER5Hsv6R0vh+skmtG0eYJo3sqLpYUK3K
         v0WNrU6vP1FcZqCxm+34gQWXgoMzXx7nIyUqoMkK6dfj7tDDosRitUwNJHyAME/RsMSS
         Noxci7dh+qICV4tBvuh87KZyxA/Cem9e8PUvQ7RwU2Agb+6PDHj9N/g6XrJywd0uPYU0
         Q6Pfavlmpm1fzg9R/Gd/jrTTa1Y7NIG8I1v3QVMUCLCppRnkaRKfYyaHg1oAS2Al0zfA
         B8UR2EH+3Y6X+Ed8HbAXEc1siBal73kFsxuxHxJSdObtbtGtSySyLduPr33ctHNM4kVA
         D3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUSNYLkea4T5mitAbpPA/6a9QxiHE3Q+sSiOPFYbeKN3WbYa68NHkAnbj17Xwf7qj/LISW93jGQPPmo4xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFnZejD8ZjQcc+cRvtdP2BnSbeGdGjJTm3yQdSfo8do448W8D
	jgIX69o+AnpOuA7/vpwmMgVQ1euD06Jxoqs4G0s1B5puwKOFvVHeNHcRISYYv30nXioS0pUzZqG
	Jmgpj0Lkj0su1UQUmWtOGZQwuwbSQs1dG
X-Google-Smtp-Source: AGHT+IFy+P6qjGcCcGWY8SuGhP2P81lGxGaGxgCCjeNGSOOnvaRv9ggx/dWrjTCdmCSF3o0xeTnQ8LDvke76
X-Received: by 2002:a05:6871:4e86:b0:288:5240:2ffe with SMTP id 586e51a60fabf-29559d81487mr280659fac.14.1731004265868;
        Thu, 07 Nov 2024 10:31:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-29546d9c868sm79284fac.26.2024.11.07.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:31:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C1C063401E5;
	Thu,  7 Nov 2024 11:31:04 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D3A72E40DC8; Thu,  7 Nov 2024 11:31:04 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] mlx5/core: relax memory barrier in eq_update_ci()
Date: Thu,  7 Nov 2024 11:30:51 -0700
Message-ID: <20241107183054.2443218-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZyxMsx8o7NtTAWPp@x130>
References: <ZyxMsx8o7NtTAWPp@x130>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory barrier in eq_update_ci() after the doorbell write is a
significant hot spot in mlx5_eq_comp_int(). Under heavy TCP load, we see
3% of CPU time spent on the mfence instruction.

98df6d5b877c ("net/mlx5: A write memory barrier is sufficient in EQ ci
update") already relaxed the full memory barrier to just a write barrier
in mlx5_eq_update_ci(), which duplicates eq_update_ci(). So replace mb()
with wmb() in eq_update_ci() too.

On strongly ordered architectures, no barrier is actually needed because
the MMIO writes to the doorbell register are guaranteed to appear to the
device in the order they were made. However, the kernel's ordered MMIO
primitive writel() lacks a convenient big-endian interface.
Therefore, we opt to stick with __raw_writel() + a barrier.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
v2: keep memory barrier instead of using ordered writel()

 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index 4b7f7131c560..b1edc71ffc6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -70,11 +70,11 @@ static inline void eq_update_ci(struct mlx5_eq *eq, int arm)
 	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
 	u32 val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
 
 	__raw_writel((__force u32)cpu_to_be32(val), addr);
 	/* We still want ordering, just not swabbing, so add a barrier */
-	mb();
+	wmb();
 }
 
 int mlx5_eq_table_init(struct mlx5_core_dev *dev);
 void mlx5_eq_table_cleanup(struct mlx5_core_dev *dev);
 int mlx5_eq_table_create(struct mlx5_core_dev *dev);
-- 
2.45.2


