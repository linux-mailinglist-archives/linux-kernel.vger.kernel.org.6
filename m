Return-Path: <linux-kernel+bounces-439721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60589EB31B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DF41645BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3411B392C;
	Tue, 10 Dec 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="D6Sb2jrw"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A21A9B3F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840652; cv=none; b=gqUD2SgUdUn0teLEPgvTLwHDDm5MHGydydVJUDGGdD2iNxLNUoPUicVGvXLLfAZpnNu0FMWvNbwv7l2QuaAZi2As06VEaM9rNiEjNBfDGYeWyRbPEuzNQwzRcPOrk1JuSq0LweZYRYFvcW9kYFv5mhupIF2b2zcChNFsO0ycNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840652; c=relaxed/simple;
	bh=+w6wx6WGmeVV0XR4mlevAfOchwtnHUcErLzpB3kmjZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t6jezVl5thcSDR7Lf3qbfdhCE+Gc3qG6clATMurQ5N9btU+hF6GaKiATuZvYrMJPPmCbzDJUhfPCR5XUJsph/ZlcRqz3ZQ/rOpn2xzLJNwNXMiQT2n4eIkGxDvQ/dk96HVi7kYiO3F3kLs/Pff30MdyimYWa15VRSvBS8PH6cOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=D6Sb2jrw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso2081298a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733840650; x=1734445450; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cyw5f/C2V37Mp3ln9xoUKSHP1fOBqKDeQ6bS/ukoVw=;
        b=D6Sb2jrw1HAnSHyDH4Pmy3hPulTkvzyxQGyCy3PL6Ruxo+t7qzqjISvmeRKja0QSTd
         WR+MUIQzRv1jV43KhN4yJG1zkbkAJVxHt03W0jYCme4hqnfnp8oTZU4UfOIgbB4Y9TwJ
         NzmbaScwrtcj0v76IGlgeZqbFXnWuTxImDXqQCnwKarq7Tu/zGNuMXVuVTkOO+WkoCer
         W8s/bpzTnNZI8ZCiPlIb6KoLLJs5sr3aA72ANAfg9bgMgHxgx77ZdYLPe2jR620yQgoO
         U7fKq1JyhnpS7KDf/s67nX/csF3jQpkUvm27sGBraxXVsHs1rKHTd9IWaJjVlmxasz/F
         c34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840650; x=1734445450;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cyw5f/C2V37Mp3ln9xoUKSHP1fOBqKDeQ6bS/ukoVw=;
        b=qulxICYD2Y+gxJedyKQ+1NHGf8DmYaMXV+gs7FnHJm1bpPrsTQN85BVK0gmoWAyK2w
         khcmk7YQ2kwuz8KPF3uyD98eZ4UFAR5O0MmzN+v05FTFcoVZZZBapWAFBZUmAKfrVgjR
         Jl/ZmaUlJuV8YBUYAsrNqxmtnUY9nBUkqm1WStKygM2awjZJ+7auQIzWu6uwm9ivnEQ7
         muahp6c4tgtzZt3UNGY8CGlnjAFCInzdIA1czxiuOkvzY0xMF4WS9FUpr5ys3YQ5acLq
         rxDcb2/e7/T0i84Y09Xbu8zyoW7SDSwdp1okgmPt5hZWiHLomwg26A5PAw/YrZBlYtak
         Z2HA==
X-Gm-Message-State: AOJu0Yy5Fn4tn5CG2/JYivJya4eZeM2N4eEM5IMCk0HO0Mtn4PW2yP4E
	9VRwMnN9Gv6pU+6IFObuqh5gm2u9RydbeO5TQsgo9cEbIfzx87iH6DiTTqWSByHA946g57cvZMf
	nQgsnxi3ejIPrBp9JTrdJfJZ+HLQ5dFta6LQnDBwel1vQEtWCYmKPzruNHQGy5xyo9iv+v4MA33
	uUyRwB6R/Fn68TC1QWBexLygo4uhyJDEPT3gqpj+2EdiQ/+fSZTjyeoA==
X-Gm-Gg: ASbGncvx0LM3QAv/3AIiSXYrGhJfRszaNe9YuSjtlZ91J2/FJ+b0w/rOrPD2Fjz4NRo
	5tk0642sLc1uBnPgZ/TJFpP6IUPMWawjyBib4YPEJKD0UrAAduuLOBKTCcE6UznfQLsax5sJUtW
	zrRgfhAruGzIDzR7NR4nTziEkkOBKpQaorZcJM8SV8im0ML3p93QzJyno+YDluh3yK51HFnnD5J
	gdjNjiFb4aB2EnBlgAf3Cn7ZaHQfZ4YiqfrIx4WELpn6YYsWpVKA6IffaNJd5S2WSza1yrCoE9J
	fp1kNdRC
X-Google-Smtp-Source: AGHT+IF/eLNCS1WvrJyj5WY1drdW6oiQGMzfyH0Ke6hYhFaWTOwYF6DioSEMu//To8sMbC82xu9nsA==
X-Received: by 2002:a17:90b:5205:b0:2ee:d7d3:3019 with SMTP id 98e67ed59e1d1-2ef69fffa68mr29462379a91.12.1733840649478;
        Tue, 10 Dec 2024 06:24:09 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7315fd3asm7538444a91.44.2024.12.10.06.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:24:09 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andybnac@gmail.com>,
	Zong Li <zong.li@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] riscv: signal: fix signal frame size
Date: Tue, 10 Dec 2024 22:23:49 +0800
Message-Id: <20241210142353.6457-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210142353.6457-1-yongxuan.wang@sifive.com>
References: <20241210142353.6457-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The signal context of certain RISC-V extensions will be appended after
struct __riscv_extra_ext_header, which already includes an empty context
header. Therefore, there is no need to preserve a separate hdr for the
END of signal context.

Fixes: 8ee0b41898fa ("riscv: signal: Add sigcontext save/restore for vector")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/signal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index dcd282419456..c3c517b9eee5 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -215,12 +215,6 @@ static size_t get_rt_frame_size(bool cal_all)
 		if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
 			total_context_size += riscv_v_sc_size;
 	}
-	/*
-	 * Preserved a __riscv_ctx_hdr for END signal context header if an
-	 * extension uses __riscv_extra_ext_header
-	 */
-	if (total_context_size)
-		total_context_size += sizeof(struct __riscv_ctx_hdr);
 
 	frame_size += total_context_size;
 
-- 
2.17.1


