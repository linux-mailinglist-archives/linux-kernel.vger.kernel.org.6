Return-Path: <linux-kernel+bounces-350220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E599901AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029BD1F224D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C2614B07A;
	Fri,  4 Oct 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F3Uxvg5B"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40972179BB
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039318; cv=none; b=rbA/1tW6Y9giTtmoLCTg/fNZ147wNMfHcKHXHuf0amKk3bNZ4dIrwL1WMzhkO5o3kok/C2K2Fs5kH4H2XJxS8485eG42U3+Kua9hiDbMUFYKTDrN8gmZ3zt/zNFZeHxP6vchd1hd3PHZiAbW7isNt1IDwGfyHB9Zao3O/h7vcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039318; c=relaxed/simple;
	bh=/gnDSOyQALnlFj9T36lVAVNTTFzwHZFyTNcrltNvd2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyNEpSEQdGEXCoixPMwLWUJZszSMU63jZBkRu40Yo2IpXpwhlT979KJJ/yySRavtd3SrI45hH4U+K+DHdQ3phf+gWekCzG+rf+sHQDP5vToEZKGESKW97bcu9pqsT7mJLiNE+qu3/c/zyVqGG94hTEIGrKm/Ej+D0O7MUXEtP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F3Uxvg5B; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e21b4d7236so16614007b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728039316; x=1728644116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3xnIJ9xJEF5dZzVmcC3z99NvsX4DJMfYW3BHeBLqjE=;
        b=F3Uxvg5BYG4riCe0g7eys0lu6wnY+rx9rcmMNsC61DAzpId8r7UgTkS36Q132zjcKc
         hZxD4VF6j/46DlAl7naQwTiCCOpRd5TiNqyDWlsCRjTp1k5RE39JfWlkQDpM22iAG/jQ
         nZktDL6+JoZxkQvz8WD9DhQaBjgnmAdjEBvOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728039316; x=1728644116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3xnIJ9xJEF5dZzVmcC3z99NvsX4DJMfYW3BHeBLqjE=;
        b=GnBkdvTewLN2yjzYJaKt7VDx837UB6ltfr/k7zlfeqauwM5ECcIUf6yj1h/veYgw0r
         xmGvn8RJc5UWvxK5B5QmzS5a0J3uAorEIxw8j2AmH3MovzxvHkl43fifYBWeenaiAJqB
         f/69VOkEI49KQlFrdoj7nR+5jAYyPl/i+5aIncjZ6yqlhOu4U8XeGV3VSfEISgP9JdQp
         u5IB+hBmGNSLOXh4jHEbJlt3lxuX5o5aod7DWED962II5t7XSMoge2mYQ4mZyqIpuRzj
         F503iWblch+s0WYY/ba1hpDMp2I17GzXztUukN0ewmpTPFEss74Wi3gH80+xh9+ISfJS
         i0LA==
X-Forwarded-Encrypted: i=1; AJvYcCUEGFoQpIpH2Fz8d8KOuMgdmJPrz4GbaJAW4lO7WDw7Nbvh3Nci5OaLuJDYZdoehQHLwsh1Tq7QePqn3Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFQirEI/MuVpn5ZVbRDZQihdfHjqdt8rPgLZUqAOvq0arRdZF
	Qc76CyaaXIBbfp7KF2KrnRu8fyyA4AmidHA1kcEb88TnPNerF3AyGH/KVtQIdFyYTG5ih7RaD8h
	d
X-Google-Smtp-Source: AGHT+IHJtTMAHM+5jlGXnRFZgIzHdU4AHpitlBbCf/IAKX/gSdYDh1zGCko+1M5sDXvKG26SjRXZ9Q==
X-Received: by 2002:a05:6902:1ac9:b0:e28:6f55:1283 with SMTP id 3f1490d57ef6-e28937e3e02mr1501823276.30.1728039316176;
        Fri, 04 Oct 2024 03:55:16 -0700 (PDT)
Received: from localhost.localdomain ([12.191.77.58])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2885d69bd6sm549817276.27.2024.10.04.03.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:55:15 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v3] idpf: Don't hard code napi_struct size
Date: Fri,  4 Oct 2024 10:54:07 +0000
Message-Id: <20241004105407.73585-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sizeof(struct napi_struct) can change. Don't hardcode the size to
400 bytes and instead use "sizeof(struct napi_struct)".

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index f0537826f840..9c1fe84108ed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -438,7 +438,8 @@ struct idpf_q_vector {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 112,
-			    424 + 2 * sizeof(struct dim),
+			    24 + sizeof(struct napi_struct) +
+			    2 * sizeof(struct dim),
 			    8 + sizeof(cpumask_var_t));
 
 struct idpf_rx_queue_stats {
-- 
2.34.1


