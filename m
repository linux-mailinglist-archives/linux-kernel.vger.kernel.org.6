Return-Path: <linux-kernel+bounces-550764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D035A563CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6353B175AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D11F94C;
	Fri,  7 Mar 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed9Eyaul"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C420298A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339787; cv=none; b=cfk66OyV0NN6NtBVPrc88J2Rl73tSNeOWm+WljZ8w5+fbWLNWTSYG0hs05C23nXL2tj12OVO0qezW1stfFh5BYC4BcCE4FSBtbCQZwtdH4tvTB08bAYrqTuizUHkVSxe7OT35DwhoqiXGemyMVxN71tQUC2rkH/IxZEEKDGOiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339787; c=relaxed/simple;
	bh=OA/7Qe5aEekqV7T4SN23N+UJLdSmv9Rkedt7UYvoflg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dfiU1K8V5hLSYHxO+AwLbhmQRkmykjLG6kLd3I5k8ujdd/ukNlCavSRV8rBR7rqK5k3DzedpoDv+lkci4k+rP//QcyM0umDrzPq5YtcGy5f4OuKg1Ai11O6VDUnMTh58Uw1v2ldupx7Z/0W/YfU982Opy+khLVoB//yWgTEjB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ed9Eyaul; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-391211ea598so1063914f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741339783; x=1741944583; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Im6pSo0BzRtrOvminHRm9b1Ao6lE3VOWmMljLzr+YZQ=;
        b=ed9Eyaulrc3fziPknhdHPMXo4Ya25d0DzW734oud1WnouOoJnoVyPQtU8PU0J6F2oo
         HsyvM08oKrNZ2st3hTUFpkwTJOCucLiW7MqEyLnxPi6Qjk2IrCwXSh0PG8dTy1oEywwx
         IHCyPf7RtRiOOqQ09brL3xCmOsPBIvLlqXglLDotRpVTvSu0qDJWDdZSEWzsRzREsM49
         mVx2+rMijRM+7155yGVyID4DPjflHx57yhbaqaIgrnkpsR7NQPnrZ4WC1WBLVR3/tCg7
         GoZii6LL4KOHCo3om/FmkqxnZZSZsjAZ8z1r9buVxB58PNTyzBaVRPvZrUEWOyO/C5Tm
         aFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339783; x=1741944583;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im6pSo0BzRtrOvminHRm9b1Ao6lE3VOWmMljLzr+YZQ=;
        b=lFf5aIGxe26COvQYyESrne9hEYLmZP07kgWkvhi3TDycz2+QpK7/TofnQojDTF1LRZ
         JbOl7xCKxD0RFLZWRIxXQIgwrSXtjHgm16kPnwfuhz4xAS+dEbrjzQfnnoTlc485yNul
         G8JvhjpgqvLd3W/8WdLtp3BmKGeUeZytGgNZCMv4jSkbGOOR4yEYUhs0uE0JwDXEDYGY
         h/8cbn+nloy8Q+oSp7hyZcVNIizIUuXS2Ull/3vM6uXItpX5bsOm8hJqLoJQXPyAxtW6
         JIoyEe34rtYlg4pwGxQgivarEJ9XAldiTLviDasPNrhbUCAVIOYqarTPtAz4hT8DPz+o
         DFDg==
X-Forwarded-Encrypted: i=1; AJvYcCVTnBjJko7NzwmprclKFSoGcpfsI9OcSoO97YBv9WzB7YOTJzryWlhueZD5bdM8nFeSRYatM1rJ/Qf28KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32TYOsUO2tpzWqovRf8+xxkjTIZNNNRiTQH/EvvFPotdCSfGz
	IdwTLXmgEtv4Vk0JPulvlYCea8Ca854GGDvdjoA2PNEJLkBtvLRbfNyT3vPH/FM=
X-Gm-Gg: ASbGncs7WlUd7SG73J6cyfwmqKsehsjy8zpQBqOb57bBLLApc4shlR4XU2b3Coe5BlP
	TKanw31ooeTJ2BFPN5UiZbzOYc15VXUdvRaiW9OyjlYty8lBocXLu/5+mpMDZBIdQFZqCvEzKdx
	gS3Ivv11AW+vGkK1QD0T5yfhscxm81dAjIh5JjDo5unVHAQ9NQaJfmqKGHEMusoKVx6osleWYmL
	T6emj9eVs12HGnhtvKSZlKgN4R7IYpQ5rEjSzKoYBjm9u7DLJX2zanD5Ho/w2tkx03LKQWv8j5n
	kLmTYyY0tQO8p1/OvxI8XCtT6L71/+4X2nKk0OV794U4fMl1/Q==
X-Google-Smtp-Source: AGHT+IG1aeOLiht/Zk+dJWxQiJtrE01AKe/jCJ9h6AR4ika6O/iJj47hJhtKgYXJCT1ozzCGM9Qjxg==
X-Received: by 2002:a05:6000:2c6:b0:391:31f2:b99e with SMTP id ffacd0b85a97d-39132d1fc45mr1723216f8f.2.1741339783348;
        Fri, 07 Mar 2025 01:29:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e3250sm4783347f8f.61.2025.03.07.01.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:29:42 -0800 (PST)
Date: Fri, 7 Mar 2025 12:29:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/msm/dpu: Fix uninitialized variable in
 dpu_crtc_kickoff_clone_mode()
Message-ID: <f8ba03dc-0f90-4781-8d54-c16b3251ecb1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

After the loop there is a check for whether "wb_encoder" has been set
to non-NULL, however it was never set to NULL.  Initialize it to NULL.

Fixes: ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for CWB")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index b0a062d6fa3b..ff6f5c5303d4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -956,7 +956,7 @@ static int _dpu_crtc_wait_for_frame_done(struct drm_crtc *crtc)
 static int dpu_crtc_kickoff_clone_mode(struct drm_crtc *crtc)
 {
 	struct drm_encoder *encoder;
-	struct drm_encoder *rt_encoder = NULL, *wb_encoder;
+	struct drm_encoder *rt_encoder = NULL, *wb_encoder = NULL;
 	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
 
 	/* Find encoder for real time display */
-- 
2.47.2


