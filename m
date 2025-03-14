Return-Path: <linux-kernel+bounces-560886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36126A60A98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A7F189F846
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB57018CBF2;
	Fri, 14 Mar 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="httOiifW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDE1624D5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939048; cv=none; b=OraFOuSitfitNcFImF64LhGnPqHcNd0oz1CtSBe2oauyX7uwA3pFKFH6E9zUA4H3T9/jQKhmF0WkZ6covkYIqyYvX21aYQyws9Cg/Q8wvVxjj7TNW8v3lwM5mGtmqsdZ3JGTM84V3jYX7MFXnVznwPWAy+TweV1MAFVKtQv7Q8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939048; c=relaxed/simple;
	bh=BMlElhUzYDL6JB0tvYCxMzpB4MYKpbR6FOEi2tzqO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRdd7RUMhWkOndNlExqINXaKqw64al5KEd5+dPnvHpnYBjHpXdeeZU9oTH9Uw76D+m4RQiXtFGlk3/2cB+KqmHZVptlWqP0Qb5wdOuT8VBTlBTFZOteo2htU/iUhCLjpu8tMvKtg5PptBszNP7SwrHSS5A4wGD5hjt+KxBcjyb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=httOiifW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so45040215ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741939046; x=1742543846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGqvrAfhcKrz89VYEJIZSiwWmc+V5sZA3zV6G2zLMIE=;
        b=httOiifWmruoJUS8NbZxe1mcsj0+wMdUhiGaXPEpIGWcDyGqALl/6th/208u1H+w4L
         C4y/yo4rO3m/HAGa8a+/iPTI3m6Z04bTU7R1Muk7HKPeOZycShY4CzZ/Z5hJWCGuoiSl
         D0J0vF7FLaOkR+PaS+ZtMyBw7odZKl30vmOCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939046; x=1742543846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGqvrAfhcKrz89VYEJIZSiwWmc+V5sZA3zV6G2zLMIE=;
        b=NdgsaQUDPDQ4QPWn0BdQJKAkqhXLCs2pAnZbYu8LSWcnQu9smBfF0KZJZSF6rhJaig
         uF+WgrVJ3dY8cfzov9i5o8JQDjaychQPCqHZQdtfqi+PnTpboSRiSLTKa+WDx5Bw+iMT
         puDLQQmnOGTdVwRcppWRAiOiMyYpaMYHPn/cvlYXdd/bzMeeK/NTkTZ1SfCIeQ8g7vEU
         awV2OHSIMNa+r7RLi/fLUqq1qJYBXRo764o6H/PBHuR4b6nbyXk7jGbXTOkS4SC0yYm1
         UPJIuY9CPaRezb5uO0RFIWfh+F7IvoBE12hd4W5VmHZaGe398pbYqlNXcfJXjk+6f849
         WBgw==
X-Forwarded-Encrypted: i=1; AJvYcCXis4fmjVcbhhPWqkHonp00HvGdfVnuKJSsbbRVkp5CHBQOOJzvvAQkYW+oUXVtGMso2M6t4MMIHut0EKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3JWdEQfZxA4dTIu0EnpVNtAC6Uw4/Jf8sEkaHYqoAXSsKEZ/
	L4Sq7UNKcGV0TLn14d46d1FiZy9axQ2mj4OcY21Xk16b4Cy3jbaZYLjjOjzjWA==
X-Gm-Gg: ASbGncv6qLGp0TAm5Nstf0PYayMUDUc8kV0YL+5qQszN3xVk/6n4zmdh7i8baQyTLG7
	/CWG43ILQFndwSAHz6c8xmQ0dexOwiIQb7FZnAenwkYzJDGWtR5ye1GLn6VZfFyQUvugOZWssOe
	9MhwHSoeF/MuZ9IDGiIfYgNwMMsOh04FwUPfl6ExKowsjPcnEH3mOXQHhn7/3ICvyamGyG/eqq3
	gVMeA01HHh5T7bTdyfd++oIEWHYC+K0BiWqXw5z0yw12oyPy8CJYPnDR0cBvMzbg5CrMIJDZYHE
	loao8NtuJoIfL3lgq57kwHc2dVzm12OKpjmqQgVXYaq3I8IXnrtYDPH8EaY+NWQsJAIH2lgsEBM
	=
X-Google-Smtp-Source: AGHT+IGcdiyY6idwVO/6iM9R+Lbkfus0qpbdDrY+BW36asi0U5rIaBOZjp3x3v1YPc7FN9l17L4XaQ==
X-Received: by 2002:a17:902:ce89:b0:224:1579:5e91 with SMTP id d9443c01a7336-225e0b51498mr21334615ad.47.1741939045771;
        Fri, 14 Mar 2025 00:57:25 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ae4f:9361:a038:8207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688da81sm24405595ad.43.2025.03.14.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:57:25 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] media: mediatek: vcodec: Correct vsi_core framebuffer size
Date: Fri, 14 Mar 2025 15:56:17 +0800
Message-ID: <20250314075703.4167532-1-fshao@chromium.org>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The framebuffer size for decoder instances was being incorrectly set -
inst->vsi_core->fb.y.size was assigned twice consecutively.

Assign the second picinfo framebuffer size to the C framebuffer instead,
which appears to be the intended target based on the surrounding code.

Fixes: 2674486aac7d ("media: mediatek: vcodec: support stateless hevc decoder")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 .../mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
index aa721cc43647..2725db882e5b 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
@@ -821,7 +821,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct vdec_hevc_slice_inst *inst,
 	inst->vsi_core->fb.y.dma_addr = y_fb_dma;
 	inst->vsi_core->fb.y.size = ctx->picinfo.fb_sz[0];
 	inst->vsi_core->fb.c.dma_addr = c_fb_dma;
-	inst->vsi_core->fb.y.size = ctx->picinfo.fb_sz[1];
+	inst->vsi_core->fb.c.size = ctx->picinfo.fb_sz[1];
 
 	inst->vsi_core->dec.vdec_fb_va = (unsigned long)fb;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


