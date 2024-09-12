Return-Path: <linux-kernel+bounces-326320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0E197667F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04E41F21E99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247591A42A8;
	Thu, 12 Sep 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HkGjOiT5"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91B1A38DB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135718; cv=none; b=S546zTM8Zv691flRhM1klkSaa67WTz/5wdx1c9Uact7VV953+IdFyLNro/EjQeloYCgbBMOSMJ6MlMZGBAyKqHd9Zbu1ZFAwnpENKwijhANm57/dmyPSzCsOC4jKUnu0puPiGuqbuI1LGykEpksEWgsYKU0iN+nWrxqKhjuepVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135718; c=relaxed/simple;
	bh=sn8806idNkiCfLnCjpNboyqChe8YstlzP6sfPsdBmnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kY54MP8XJwpXlnl0LefCjuTlMbkN9KmNqA+RIWsxpEHiNT2YBcvZ1Aotfc6IXJwjttlbyVwq1aqY+4+phRytdkV1rl1mIrT7p6u3n9WsFj3+R0SdgUlHaGgeaacehj1Qe3noR12An3VSbX67mC1/8zle7EEUcrYACDS+O4sIXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HkGjOiT5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206aee40676so7045595ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135716; x=1726740516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shiwJ5PPTq2a8209E6NrREgDdzwSnjuXLWsyRANhAjY=;
        b=HkGjOiT5H/1czyPuNcKBzWamFZ9NaeVw5NhYDYDa2VhCbqOaGvmzeiRVM8FFHMJzft
         /vlbWjfWPGN0TvlSRkHU/2KypT35iVP/dXPZv1pXvMoRomoo0msu4obUPhZ+sFCnTEdE
         QZDlIpbCOT19CQsFx1fhTE1AwXLcZ2qMJopXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135716; x=1726740516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shiwJ5PPTq2a8209E6NrREgDdzwSnjuXLWsyRANhAjY=;
        b=ww9KetB2FIzusfLn7z9wARdbPHIHbwgDM/vdinMBjwX0ChhqVuZ69f50Nngvepuzd6
         C7IeUEa5fk3JO7y943WWv2xDK6wovWcANCznvXk6GV0wU1DY07jMmMGqt4Zwey50tpsu
         CvXpCTok+2OMd0KiT9KSfXaHnRQSkf6bWiHq+6Ic1v3e66mPw6e5X/DDFWATlEqeK6Tl
         rYbLIo8zFhzD0Go7AMylcpANPcD+ZCUNBjAlEWLc+Y0qGHfUKS8UG2QnkIYnK0l1ho02
         +mL4YJBI1XQyKpWhmnAKmlB2+b5jGRmi1rvrEwdmsrdOa0hBqIwHtBTLjss/PQIiezua
         jpBA==
X-Forwarded-Encrypted: i=1; AJvYcCVDcahdXIUtE4TjeRQElLIw+oib6LLblj8ejThAGcCkn3FeQ3SHS7a5ueYfUhV9yBeuNuCdrIYMtKqDJWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzV2eEe5AHiXDCYQ6Sv+6U6TVigOwpU5iYqldKORv7YPhWT2ud
	tNk+5yM7B3moGPTe8Cb38zrJDaOHxUaZ9vUrtTEs9wwAseKFugvrPUWzlNqdtPs=
X-Google-Smtp-Source: AGHT+IGmpYd2G5DIIhmYMBuEmM8z3a2VkK0t/McqxC49pS7a6J7N1o/T83xP6FKlEDXPLrwY4pJ2bA==
X-Received: by 2002:a17:902:ce09:b0:206:c8dc:e334 with SMTP id d9443c01a7336-2076e4069c6mr37192565ad.39.1726135716263;
        Thu, 12 Sep 2024 03:08:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:35 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 8/9] mlx5: Add support for napi storage
Date: Thu, 12 Sep 2024 10:07:16 +0000
Message-Id: <20240912100738.16567-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 47e7a80d221b..aa4eb5677b8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2696,7 +2696,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_add_storage(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
-- 
2.25.1


