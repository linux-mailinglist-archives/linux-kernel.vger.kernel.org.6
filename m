Return-Path: <linux-kernel+bounces-414788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777F9D2DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F05B3F147
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D821D86CE;
	Tue, 19 Nov 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llnqIwk7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43C1D7E42
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039020; cv=none; b=LDCncyraLpZFruSYQSdrOy4hVB2jbdO2uNzBwns/PPrGLlWBlebpM6ObmbbYcXk42F1qOXEA1Yjnzg0OKL6iFtOMO/7hXjUUbHNkhwfB8jJyLpWg8vGg4jQXrKTYLfaHYFD5Ed2t17+AVSlaZw+9l4WbaD5EyeaPP3MWGZnd2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039020; c=relaxed/simple;
	bh=oXkj1C6Jx8yUMHy3C9MjrWlRZXnbo4AjWBLbi4B14uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbJf/d5TvLFIxaFwTHVkh9EHQquGO6QIbom7KqgdsmpDYUs/rhnevTAzWOhiPIcQ1dG4IsY+YiHckBl7htA6Tp1NaGeH4noek5FOkNaScMnObQouCPcSFXIZkwpCK4lo3yToZ4szc0sru8PiMYbXdSVan9l+iQb3q/Y6sPUKgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llnqIwk7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431481433bdso41410915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732039015; x=1732643815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjXGo5viMHe7/zGLjLLL+XFyV/IDG+n2c4d5eIBcvfQ=;
        b=llnqIwk7DU3RTRv7MSKnlSi/i7tOPCL3LYfgntzbVxQacf0+DJlpmwOAHcTYzLLN6z
         qo9kDDZBbGfM4XFsOkitwY8f5JmGNq183FsW1q+diSJTp1X/qABXMUjo8feaWgT5mYRZ
         SWUxYFT7Qc1fE+Ue5fg9ZKsByPSGD8mOdV4kxpL8gGSTvMaLaGMUY5NhUd0JdnXCLukG
         kEc8iOoBTpuvFHC+dHvdCXC9xk74xrASsTQ/GsQqw/SEWnZt9Rjgh94Eo4wb+DajLAVs
         BCYj3k6aSHMB7JrUAWrx/NRUKc2nEqZp0Rlhkh6B6BBpodlPtKH7cb3aU1MfO2T49U8o
         +0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039015; x=1732643815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjXGo5viMHe7/zGLjLLL+XFyV/IDG+n2c4d5eIBcvfQ=;
        b=ESXJX2fi9MuMhDXowIOrV6acj/+iW7nlPb6zxDjKEVDVVOWmbPsXg8tvMTg25C42Wy
         TO9hNG4H6BV82n53QM6R1smKOw1Tps19uqfsoALdKS2y59M9ynrj0c90390cGGYezxTg
         D/OM7vDEpnrYvlcVQaUMqtpqK+iNuukzBz+BIgaPLc/yCugGGC6kqPVWAl17BFwwaf0C
         IpeG2LOhEbtB8DmlnYNKfIoNL9PjNpVGY+4vJncMXC4lHQrdijM3Y/cJUO2Ww4PDKNff
         7BsNiQKExPmoLk+h6auR70r3bpxU+eYwyJwbyOBa0ikPHa9ifRPZ0JV2akHKG0f36Bdx
         o+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKqVQQ2gaUBq4PwJIa/eBzWgiNRGmD5U23ib4GLaMEJ3SJR+pLcvjyCosUxFLEdvPC/sKiVx4EbuPBU/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1K/0VKNdz3+ZiyJDNEhwspMqqWXB3aIazfyjWM9zszoNOK5JM
	prnqewgKQ/NWtn/A9BAdPghiWOiOo1Hd6AjEPDJqWMlKqUMqe5a4ieVjAgGD+6w=
X-Google-Smtp-Source: AGHT+IETH0Hm2buMkvy/Ll4++F3Vi1yZx/qAIhcIkteGjWjEm1IVZlr1JHBK3iJywT3czzSrxctNNg==
X-Received: by 2002:a05:600c:3491:b0:431:58bc:ad5e with SMTP id 5b1f17b1804b1-432df7901femr123471485e9.28.1732039015397;
        Tue, 19 Nov 2024 09:56:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm208302275e9.24.2024.11.19.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:56:55 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Nov 2024 18:56:43 +0100
Subject: [PATCH v2 08/11] drm/msm: adreno: request for maximum bus
 bandwidth usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-topic-sm8x50-gpu-bw-vote-v2-8-4deb87be2498@linaro.org>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oXkj1C6Jx8yUMHy3C9MjrWlRZXnbo4AjWBLbi4B14uI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPNFaHpmsc8d0QhqhvhKQzuhIHbOW/nweLHVI4J4K
 yOvheo2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzzRWgAKCRB33NvayMhJ0a6wD/
 wMgXLGer+Gwmpc2QXN/wUIVfxGxIJekwSowXEGKXdUnynbp8xruE7XqMXPRugx8J70wKaRkPVIDBAq
 YlvzhmgygfqOd99bB4cxv/m+LhYaB/sqeIpGxXxIFg9JUTmOww07+g5wSg8uS6g4x/6m/AE1QW6inw
 6Vi/BiDDegOqKGTC04oXy/3wuJGJkjx/hLAsfoQnmKO6rNLc7nlepQN+a86EgENOC9uP5dWo51XxiH
 Qcw0D+UEhPz7Sywxlxx7/x7hYR42vAQ9XIZE6df2tJtl+qSn5RqVSdnuk+VpVOZeN5GLzycCdaAQZZ
 +BpzDDGet1cB9RPKolF1+3rtxHRPKGaf44xlgrXdngpLlCDX3feji1t2DqUyVLy26qj+wBGcF3yC62
 5zcZUam9IXez+ZA6dmDUpWQ8bDHDUN8pH/tnJQ5NxqC5H2AUPhl6X7UgH1GVhn4wBI6oACdLFbfRLS
 cMR6fJTddxi7KPzvhhZo+GYeEA1oP/PnjjCSPMzGW/h+tSi/RVAGm5s/NBp+sO//57MwUqIIcmMYhO
 74L35njgwh0bb2h+YhE8Sbonu83uTFPWOvTov/B+Qp8FRQOiZkHZnmAgPO6L5jvzvJUZhLOTrl/Tda
 bmMyLXaUOA/pQYp//Bky30nqQHwALOEFRZJO8MR5XVxt+ciFfsVHs8vCb7uQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

When requesting a DDR bandwidth level along a GPU frequency
level via the GMU, we can also specify the bus bandwidth usage in a 16bit
quantitized value.

For now simply request the maximum bus usage.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 11 +++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index dc2d0035544e7848e5c4ea27f1ea9a191f9c4991..36c0f67fd8e109aabf09a0804bacbed3593c39d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -134,6 +134,17 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 			if (bw == gmu->gpu_bw_table[bw_index])
 				break;
 		}
+
+		if (bw_index) {
+			/*
+			 * Append AB vote to the maximum bus usage.
+			 * AB represents a quantitized 16bit value of the
+			 * max ddr bandwidth we could use, let's simply
+			 * request the maximum for now.
+			 */
+			bw_index |= AB_VOTE(MAX_AB_VOTE);
+			bw_index |= AB_VOTE_ENABLE;
+		}
 	}
 
 	gmu->current_perf_index = perf_index;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index 528110169398f69f16443a29a1594d19c36fb595..52ba4a07d7b9a709289acd244a751ace9bdaab5d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -173,6 +173,11 @@ struct a6xx_hfi_gx_bw_perf_vote_cmd {
 	u32 bw;
 };
 
+#define AB_VOTE_MASK		GENMASK(31, 16)
+#define MAX_AB_VOTE		(FIELD_MAX(AB_VOTE_MASK) - 1)
+#define AB_VOTE(vote)		FIELD_PREP(AB_VOTE_MASK, (vote))
+#define AB_VOTE_ENABLE		BIT(8)
+
 #define HFI_H2F_MSG_PREPARE_SLUMBER 33
 
 struct a6xx_hfi_prep_slumber_cmd {

-- 
2.34.1


