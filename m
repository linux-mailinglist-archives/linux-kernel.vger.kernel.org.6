Return-Path: <linux-kernel+bounces-339504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37556986613
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E137C1F255CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134813D537;
	Wed, 25 Sep 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aBVlDmLu"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F9487B0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287227; cv=none; b=tKmHJcWX6+rZkD1u7virI/Ou1o9sdTzpaVUZNFYHAUnbdKWkRg5jhlup2SGzQAvnzxrQVjpzdzivWVfkZel4bcEkVTJ8JmY6IKiKUsOf4dFo0uujOq0/AR/AMuUZphZZEy0xJT2yXxbJh7ZDp6v5RZ9R2XFquBnkoP/IzlwVsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287227; c=relaxed/simple;
	bh=oxHeKNjh6qo5IJ/qOxfYjWmj4F9fJNR/X5jKHaSRxKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBsTteLU2EWslBfoAUuTBCP44Qg8/Pq5EDC5QTQYPz7POtaGHq75BkH9YqkuIgHXd2MfvsPatblRInEPQpaqbHkgwk/750188Fte3Qp3Gs36MiAZ7IVPKMkZy+S+tB8KS3P7hrJVgIfCRGp7uAnrBXhrx2MM3qPOWNv+8KSYGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aBVlDmLu; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e03d17365bso128705b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727287225; x=1727892025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty8ZvXn5cWfdvsrzl25BDp4ju+D4IYBdiCKgGBJ2BYY=;
        b=aBVlDmLu8hHxnNn2/Gb9OqAOWz68qUSVmfmKIzMOA/sDiIzD3uimdOHi6dEvQ+Kk2u
         7oUHooBohiYNWVxk0q9vzLXN2t4dgwyGooPQrOgnWrW69vnpU/oFKkW5a1QKZAbAglXW
         4yKfH6nINOyFiQyH8nOXD/eCIa2CHqP/GyJA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287225; x=1727892025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty8ZvXn5cWfdvsrzl25BDp4ju+D4IYBdiCKgGBJ2BYY=;
        b=mABRzLmXTs2h07JSyaHWQdndoxI5qbIgCzduo1YxRc2gKXd6yaHtmmrX2Rh0W4jBtf
         q96yRVvadQiO13PoekdmXZtHLa/06idpcNiQKO5eyEvAMbKnt/8AcIPvqQsdspElVD4p
         EqQjk0GU+FbxSGWBo1ANHWM1OtkLRKeyJSGQVJ6bRM5LLpaRoaJUs8Zo+jyx/boT5dep
         xyfmfNGMRv4Jk60ar38CY1MldV/e0bC9pCZ4KUbRDAciaVYPjJLqOOOQu9A5MNuhWSbb
         DHVZJRmrpxyJKBCixYjAB39xZraEucoVoJA4l2kyNO0AZt4TTsp0sm0Yn0uDBlvSCt0X
         rf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnPFY9NpUuh8raFKtemsf313DfAJo54WW98ZfhYlFqnCCx46YiDjYLXaZllsehYaJyJ1ru8eAQb55lUkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNb+f1+FCDbk7YtX5sWUUTqt1c8v6DSVOftfcXqRK810WJ8iwF
	IbpbLDr3JIbS8GZBp8YTiOj3dCpxpZhlLvd+zQTbOkgUwooYtLQmyUkitO5hk94=
X-Google-Smtp-Source: AGHT+IFrP8g8SUkZ6SyAkNAIg0Auy6eTNjBZXrEvo7manzuVA2Z2kRrPA6C+keVdAoCb4ap17t+jjw==
X-Received: by 2002:a05:6808:159d:b0:3dd:3d77:2774 with SMTP id 5614622812f47-3e29b7e521emr2707780b6e.43.1727287224906;
        Wed, 25 Sep 2024 11:00:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73092sm2980539a12.64.2024.09.25.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:00:24 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 1/1] idpf: Don't hard code napi_struct size
Date: Wed, 25 Sep 2024 18:00:17 +0000
Message-Id: <20240925180017.82891-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925180017.82891-1-jdamato@fastly.com>
References: <20240925180017.82891-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sizeof(struct napi_struct) can change. Don't hardcode the size to
400 bytes and instead use "sizeof(struct napi_struct)".

While fixing this, also move other calculations into compile time
defines.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index f0537826f840..d5e904ddcb6e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -437,9 +437,13 @@ struct idpf_q_vector {
 	cpumask_var_t affinity_mask;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_q_vector, 112,
-			    424 + 2 * sizeof(struct dim),
-			    8 + sizeof(cpumask_var_t));
+
+#define IDPF_Q_VECTOR_RO_SZ (112)
+#define IDPF_Q_VECTOR_RW_SZ (sizeof(struct napi_struct) + 24 + \
+			     2 * sizeof(struct dim))
+#define IDPF_Q_VECTOR_COLD_SZ (8 + sizeof(cpumask_var_t))
+libeth_cacheline_set_assert(struct idpf_q_vector, IDPF_Q_VECTOR_RO_SZ,
+			    IDPF_Q_VECTOR_RW_SZ, IDPF_Q_VECTOR_COLD_SZ);
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
-- 
2.25.1


