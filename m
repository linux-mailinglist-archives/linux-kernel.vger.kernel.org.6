Return-Path: <linux-kernel+bounces-574647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A872A6E814
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C011895FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252044C63;
	Tue, 25 Mar 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYIQUvZY"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D5CA4E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867364; cv=none; b=f+SEPLYJI6+ceczmomAxUiNVxW10Rv9vErL/rRnPCrjrufrM1borBi00ngqXDtjr/5B8wwHCHVUqnHOD03qT7wTuUvLE/U5P/xedcyDTgS7p8Tmrzx+Q9gnLFmfggYoz5pUX3pkFY+3//+W87VYBXVwXIjzK6JvME6HLm0bVBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867364; c=relaxed/simple;
	bh=b/vUvvbZ/lvLafqz+h8A0huOHt/Ver9nFWMW6Y3nZQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNQ4gEGc9d4d3Yaww2B5uhY/YgD0KYNaQvz7YdoIeaO6mVDABEXkAQaNRQeWiLlbZmSMOMMEFWcMijH92thsnRdUCK6Paox7OA/Wm12/KVFCS27iiIMpkHlmSBSkw2+pKSsB8m9zqKC/vba872Oy8b1kxcftVpKvr21sDmYlmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYIQUvZY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c08fc20194so1042847585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742867361; x=1743472161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZary7lJCr9leLHUqm0+3bcbUqSzuAUJ+0Co/QGHNJw=;
        b=EYIQUvZYpBIM1UDQOfgzQyy1waZipjivINYb3GFyj+0apUxspyhVtg4Gp7g7ckSsLA
         WYb0+BIPAqjHVH0kXNSvCeKz3q0IL7GxRW7Z8EllNok4nQ4dVTxNDd553TxV1XGMZrRg
         F3t2ADpVwwgJ7I+Go7C7+cqrpu38KxPMHMu9vtZrAeTNACNiOd2niB5z8oxIb4ZJ2AxG
         whPSt1aejzBsKzsJ+ySRLktcVb5XedTJ6URZXG8megTkj8cAVJGXAIpn3In3sabsTa4R
         WU6hBvJ1WqxqQZ0VlneFllFUnAlkIy+DAU6YymMSSQyZTMPXN0ryyZGg49OFO4uSL9UI
         3r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867361; x=1743472161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZary7lJCr9leLHUqm0+3bcbUqSzuAUJ+0Co/QGHNJw=;
        b=cS2ZiiaoSu9ji+YfKZgSx6Ma6rIt+rugqbtZwUMGgltGGjzsxPvY9D0MWeiHrQV73K
         qmv+YpeJyyioc2oEj8HCIfBJ3t+l6q+8fygRxZ0F1CqHdhk5gCStw1+JB1QE1grSu4Ar
         L4U8RHbgdGEoeV/SPly+X9i6kAl+25kSER7gJnRXLlB3Nwb0mC06+3cJ8uijALCmv/ge
         7SH0LQpM9Y7tVGJI6er24nbLNTCeeKOrksQmaKAU8zjvT82xw59lxT85LHq+uRs8dijS
         n/tOM8VUcbN2+G421ZIb/pQbLPbo9mLCrLKyUSqTru7v5eHhbd3Q3kGuXJl2DcOtopEy
         nrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOO1PFd+A34pU5ddQ7lcJO6ilgp5IZ5Tc7JSCu/gV/o9QAgnHcYi2BcMf0DdKtwaJIlGVaM9Pofla/DU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqst3CYt2mHHyP7xBo/0zf6SDO7lzIaGgY+wuZPSNseBsMbhOB
	kIClvLQoHs0pIvIzEM4+eH7e4qyG62/2LbCZ4Qxls0VG5QbtNHr7
X-Gm-Gg: ASbGncs/yVuyLvd48y3SPNQ7by3+dNn3iVDzX7ro7gcJfDFHGgzlDQcXIN7gWnq/iHz
	6g6ggbo5+40Pmrcenicrz/IkfUOWJs1WdZKGMJAmq7Er876cFyZIWhpMPPlXUXvqXEEt1kZipwv
	kNvRcSM8/emXLX6UaFfUlojwnHGhuxDDknHHTTHUXFbNdLIUSzuADQ42Zl/I4SzbcJkcgxOq2EY
	qetUOoUusa1lMiu0V++D42PZY7CcjSlN56z03wPoQsbTTx7U63BI5aQGDZzii8+hWB8VqRyXShw
	wLKhIbIgZQTnObgwDuYLytnddKEl9y8yDVlzoAjJcVsxqNz6PxMGqdAP
X-Google-Smtp-Source: AGHT+IHbDJw6pwBUtJBgbGPD+yF8WaYHrUpLpKHYBRK8TacmFZ8qNmPR4PIiaqNqGMSQA2IUpO0BYg==
X-Received: by 2002:a05:620a:2a11:b0:7c5:55f9:4bc8 with SMTP id af79cd13be357-7c5ba139e5amr2310475585a.8.1742867361400;
        Mon, 24 Mar 2025 18:49:21 -0700 (PDT)
Received: from zerochan.hsd1.va.comcast.net ([2601:5cf:4180:270::68c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d4e27sm581171985a.33.2025.03.24.18.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 18:49:20 -0700 (PDT)
From: AnantaSrikar <srikarananta01@gmail.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Jack.Xiao@amd.com,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	shaoyun.liu@amd.com,
	Jiadong.Zhu@amd.com,
	chongli2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ananta Srikar <srikarananta01@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: Fix typo
Date: Mon, 24 Mar 2025 21:49:12 -0400
Message-ID: <20250325014912.23911-1-srikarananta01@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ananta Srikar <srikarananta01@gmail.com>

Fixes a typo in the word "version" in an error message.

Signed-off-by: Ananta Srikar <srikarananta01@gmail.com>

---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index f9a4d08eef92..fccf6e255b82 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -646,7 +646,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
 		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
-			dev_err(mes->adev->dev, "MES FW versoin must be larger than 0x63 to support limit single process feature.\n");
+			dev_err(mes->adev->dev, "MES FW version must be larger than 0x63 to support limit single process feature.\n");
 			return -EINVAL;
 		}
 		misc_pkt.opcode = MESAPI_MISC__CHANGE_CONFIG;
-- 
2.49.0


