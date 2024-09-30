Return-Path: <linux-kernel+bounces-344444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0698A9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EE51F23BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EEF193429;
	Mon, 30 Sep 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="p6qggw9p"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5C192D63
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713474; cv=none; b=u6WMQhBsO4lpewF0eP4rgbiuibUXeOp0odNcg4JLmXUOm92a370o5yjc0mgiQezMosPu0+9vFT+APEZSJyVJlr0Suguy2qxu+2LrO3U1/cj16AjVu1FxQe/DiRFnc4NJHENlyGJf+xeyNwq+Nm1+trJMI1q2oGHAGE9GkXcXQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713474; c=relaxed/simple;
	bh=skuyjD1ajuiD/T7n5bmsansD48TDspNnbpW87vZl5kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJYBMFkEThIEY0h0G7Zlk3Z29wibfyubzjrYlZP6E1FC2mAxeP3xQ7UhT3l95NkUz6a6MRGwuZKwc2qcLLMIBOa4d4sIzqi4IymViQF7Laa6bMUzRxsrPCDlEBnl4jZXMwcYkKfSYE5m8WEjbS9w6lctkQsQW2DaEk/sEoRtm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=p6qggw9p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71788bfe60eso3410498b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727713472; x=1728318272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp8feoqdAky18wo/b0zvz2eHXjnj8M+1w7vQomtljxY=;
        b=p6qggw9p/gFAfGydTGJT0ksV+4xdDEM3IXL8H78z51PYXqDBv43d/6PxudkKG9OmKI
         FNShs2UfezFfC96KzCvCwMyrAmMnbQt5HLpm5Gm4Cml23vCEB4T7BW4QEnMRcaUBzMf0
         WPWvChSrGjY1tjGObHmwyh1IVGTnrzee13Px4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713472; x=1728318272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vp8feoqdAky18wo/b0zvz2eHXjnj8M+1w7vQomtljxY=;
        b=ZQhx5nCpT2pEVXhEVjPOrrxbkMzD6MjvMWKKJpzPBkzD88Lo41AL+tje9Z6URmg4XL
         4Asp7Ar72eYfuK+0Ifd1GkKCT+HBAO+18057o5wlRD3TWCMWvnqwxjsOSTiE82LfM9Vi
         L9IMVr6w6RxHQcquzNX+bYeC9U5lko1/L82/dCgpR80hQL9w4soy+fFr5OCSPSxhZjON
         +97KC1S39oCXypl2SwSXSbEgelRoiaJ/icXlunJqftU/wHwqZSv8W4uVAkzL5WuyM3sH
         9TcFFHI5VeoZvyYW0TcZRU1SbuLQMzCPx2/zGp0oN5ew313JUYzIn/R+Mv2x5mhhQIDg
         v30g==
X-Forwarded-Encrypted: i=1; AJvYcCVd7nBd3AkHJRJ5AtzmEyCX3EZ54Hj64bljgopX/Md8yGa7NF/5eC2sjId3bP5eSemaVFsW+NAtmjg/3cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4bcNRf0ddw4Glh7bbGSKo4++RFBt/z1O548hKqxLHDGserrSt
	NwxPSwesrid0XkWQNZngtScWesL1fDO14oSH7nwePh1jK3Y4xSD99Fe5KTj4UM4=
X-Google-Smtp-Source: AGHT+IFjpq6oB/rF3b4HdxDd9AuevTEwTzCo5XR0fDrLWvCVK+j+fq4uhFs+PIXISYEYpZkvXoIz4g==
X-Received: by 2002:a05:6a21:139b:b0:1cf:47b3:cbbe with SMTP id adf61e73a8af0-1d4fa7ae130mr16805435637.45.1727713472592;
        Mon, 30 Sep 2024 09:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649f879sm6411451b3a.22.2024.09.30.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:24:32 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 1/1] idpf: Don't hard code napi_struct size
Date: Mon, 30 Sep 2024 16:24:22 +0000
Message-Id: <20240930162422.288995-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930162422.288995-1-jdamato@fastly.com>
References: <20240930162422.288995-1-jdamato@fastly.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 v2:
   - Added Simon Horman's Reviewed-by tag

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


