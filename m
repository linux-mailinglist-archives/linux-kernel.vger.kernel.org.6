Return-Path: <linux-kernel+bounces-537756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F6CA49035
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743DE16E6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4611C5D44;
	Fri, 28 Feb 2025 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFY0tDo+"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4A1C54A5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716073; cv=none; b=DE5Ypsom0ZlXv1lsbW7yD8Xhur6XjtuYnNS9qEzT4npERoJZxSBfSwYUCLAu2WOQTN3eeif+EzmMZj6j+O+R4xHEsI388Cy2dAAyZh/592Jq+ROJ88kZuSRtT9GTx4G4vMz/wXTW1i+YejuesV+zS/rpzMSocH5yuPG/503yvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716073; c=relaxed/simple;
	bh=gbAmmg7YrMzJ9XNxwCPOatERTxM1Dbe3+ajpkL6KPO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLg9A8t/Q1VogppvecTAc3SsaGo35dsU8u1i8DPO2Ovos6QoK1d2LPDWMfK+27+UOSxhqM4T7C1l8btr0VH/sKOYhRcSSfYTudDGxc4mbedbuiqwJx8ZwFiv+JiY9+8Eu9N2vunWGVx8bRQ4slbtDuQeZPhae1OvtvHxAdgXVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFY0tDo+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54527a7270eso1639586e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740716070; x=1741320870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3kLn8+jQchoUvHapCVtAnDT2HhczV+P/3nKNxhd/mI=;
        b=IFY0tDo+C0bFruux1M+XTLWb4bI5ITNY/XTODarN3eDTy+wVpjV/b1GtL/+UXYBoPC
         BsE90wrHZ+RyIlRbbHKtS9iVfGc7JXX5qirnkS1ZSkQ1YLR9V/E6ucAEGaBJIJdgXnRk
         RWurGGqfRNaYPeZe/SkWPw7gBOabDrpELPNqwVC4jgMQ6Io0HgTS5Jbm++4UkuRXoaeq
         oCtwvg7cuHoWA0lq1BteasswTlaKI17HzRBdwUoA7u8vmh9kPpexTdyBh4PwmDzegqCU
         u5mnQXDLyz34wGAdGx/h4I4Yb9tsIHKyEUS9FKYR1ksmF1toNI5PSQOAuLG6GUF61tqj
         JBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716070; x=1741320870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3kLn8+jQchoUvHapCVtAnDT2HhczV+P/3nKNxhd/mI=;
        b=iAqSqd1JHWdY62jdJAr08fA5tuTe8NU3zrf8bvzAElqiH5Ec19R8Ksx3uo6NYryVdz
         Mtr0E/+9FKKQwyfGwbjjTRleBKERcMyxczxebLq6VyoJEEHsIAsAB6V13BRrD1yzAiax
         e6xscH+NbjZIHPiWaBthkWL+ZvsDlqPzpj0GMBfr9wQ532DI4fHNk8Ql44i/0BbZxekg
         zz9GVcrREDCqQaeErPUTs6vr+FkEYJMBbLJsCf8hRkg5r/97pQ7SsSzwpIumlonuqVg3
         IXF190dT0sYrwo/3kAw3XSnFSVBTAFrwadZ/REujA9qq5naZlKE9yi94s72AJq6sykur
         PIrA==
X-Forwarded-Encrypted: i=1; AJvYcCW9w8c5gBpSC/lhOMuOJM8cTUn2KRMbhIdms9es8ss/hgsD3N+KP7u1xGaP4LOFls+KqCEbjCz+tjNlsH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZQu3l/KfzMo6nJCwLdrwkhw36B0FUrF1r+0wPmJg3ut7qaly
	1uqr/wGTRFR9sT821/QnsSWfUCj6avFBcQzgSHh5zmF3YpWSu7V3zgFclxWSivs=
X-Gm-Gg: ASbGnctq/KyYDG66f0LZWaXlIM/WTlWtPt+g2tg8HaRkPc1MGbRsKmiw0wodPEO1lEf
	qPCpJ5LK0optKbaMW59OrBl6R6+TB+gN5Dkvwf5xblTzIK/T66AqKkDlTEEF6XTeCetNuTKA2SK
	K4Gy1lJehUA9HZTf1xA0xXrgntHtuStx9nxXXs09ZMoATHS1V9fNIyO+3jCboTaxdvsxDEOkSmY
	jTZV56yLjYKtF4f2VFoHsSi4dBkPSL7J5laiHu1Di8pwGfLStwDQ9gAz+CZSKk6ExGxyr+iI5KP
	F38U4tqrGhF1I3fI3w+NW2U8ZuTr7+/gBA==
X-Google-Smtp-Source: AGHT+IFDSc3I2mqP5qdXMpIRdHJvwKMmhG7fxY3oSiaLL4XJ56Lr0lDFiJk8seHX0EAq0LMWQw0Tdw==
X-Received: by 2002:a05:6512:693:b0:546:2a27:ec35 with SMTP id 2adb3069b0e04-5494c37d6dcmr634988e87.37.1740716069990;
        Thu, 27 Feb 2025 20:14:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441262b9sm361101e87.0.2025.02.27.20.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:14:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 06:14:12 +0200
Subject: [PATCH v2 8/8] drm/msm/dpu: drop now-unused condition for
 has_legacy_ctls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-active-ctl-v2-8-9a9df2ee5193@linaro.org>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
In-Reply-To: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gbAmmg7YrMzJ9XNxwCPOatERTxM1Dbe3+ajpkL6KPO8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwTgPgCbq+XDOYj4H5rvYaOVt6Lx/s7AaC8vhi
 DkF7csW16yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8E4DwAKCRCLPIo+Aiko
 1arGB/9gEroWlk0T+tDjWT0IrtdxlhHsIIkLIlfrjs+HlEfUh1WEodAZTwZ9DWE07tG3DNCmZpn
 c3YEYkngaozD/ybdEE51nsh1lEdop/cJhejr/tusiBpBB3fvZ0M1nfUxsKfVut+XDfA+VaIqbQm
 sGNHgulMZGb1AX+2QY8LAxfVbV4MXZLt4GSmh5ZJhFqPxRHP3LqNh/yAoGYdYQoi6P4981GJwh6
 ZZG3Vq65duMphoVG53KKXxs87SPOdjM68WYAVpfclLHF4DyCHtBoPlUPxPKMpDurxwKVphZSete
 e7/Ks+NJ6bjmi2liXy02qC0fUERYj/Dr8KMxiyyrWS4tvvUe
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Now as we have dropped the DPU_CTL_SPLIT_DISPLAY from DPU >= 5.0
configuration, drop the rm->has_legacy_ctl condition which short-cutted
the check for those platforms.

Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---

Note, it is imposible to reoder commits in any other sensible way. The
DPU_CTL_SPLIT_DISPLAY can not be dropped before the patch that enables
single-CTL support.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 4dbc9bc7eb4f151f83055220665ee5fd238ae7ba..2557effe639b5360bc948a49b0cccdb59ee35dab 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -410,8 +410,7 @@ static int _dpu_rm_reserve_ctls(
 
 		DPU_DEBUG("ctl %d caps 0x%lX\n", j + CTL_0, features);
 
-		if (rm->has_legacy_ctls &&
-		    needs_split_display != has_split_display)
+		if (needs_split_display != has_split_display)
 			continue;
 
 		ctl_idx[i] = j;

-- 
2.39.5


