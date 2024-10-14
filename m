Return-Path: <linux-kernel+bounces-364451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9899D4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7431C22DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9EC1BF7E8;
	Mon, 14 Oct 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gO+wrm3+"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED811BE223
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923860; cv=none; b=dcgOuYfV82NeGRDSSYYSPFmSIpRBorDLHiVfa33T2pufl2JVwssba6AnV4AS7NLqJOby9FOsjO80jnz0smUaSQ/CgQle/sZ9kS3o2jKvWNZqt57RGyHD/eBna+iiSANJrhTNW0FzjmBuSSBpLNHwOsftzOsByohKpYmhmS43640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923860; c=relaxed/simple;
	bh=idzxZir+2Hfx66wZzXdoO5vCmyD32OzgN5agHfHyqSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgZ8LfYqBHFhXWBMkMI04V1l4KtSjIJSGFOW5Vj3+R/4+9V+1HX83Nwl0bYVTpSObHdOOBVXdVQ7iGUOPcQuHf+griuYyiLvqPJkNo8TmFPsilFuR5qrHsH7NvKawRowwkK3ZM94alPTEC6+fkOCXll0Ln+e1wD2ZPvs0TSBWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gO+wrm3+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e483c83dbso2639079b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728923858; x=1729528658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVGl2ftbuqqnUqeIL1a1bElRQ/ry6hMTlQBnPSxP8Dk=;
        b=gO+wrm3+Vydx8j/CFtfxG7Qi+6tq+Mei4x2pFlSHkhmj/65i4na9W05dsV3hUkbrYi
         JMJzvDDlz19HqzALzl9Ou1AowCbsCT3BacsQxNg/yP7/HMb1uI1/3NJd5YHbomxA6GSY
         UbC75cb+BVP9Jam14rHp5B3I+2armcGj1NmaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923858; x=1729528658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVGl2ftbuqqnUqeIL1a1bElRQ/ry6hMTlQBnPSxP8Dk=;
        b=SwZAlJ3WUmhSZuvRQtOGsX7b2Pfrn9yeV8J1CBHljLj0dwZ0cpg4KKBu5lw2stFcjq
         Pl4mtOGxsW4+i7v2xTc64iN5cT+nEyFzJFqcNDyWPcKHKq96KklrPUBOTA1QXRJIub9s
         1s5K1jcTS45M+h3hs96ehoQIvgiFNrxwgTmDop2fwATiIZCRyQv69q/agrEEbdsfC43P
         dLt0OFuXUL9nVSiS9Dv0Vbzd0Wojxf0Km8XDhVvzhKUoy6LsMz/w7TwnW/diOwzUkO0O
         eCI3Xonnf7ulQnovilgvxKd9R9a72ZhhDqw2Tcl2+9E/IIY8LqRVxOiSv02rQw1WUL2o
         Pn3A==
X-Forwarded-Encrypted: i=1; AJvYcCX0NJ6Ufz8j9LSJuXNG0Dju30GvA61wTcj+qRtPlYtJcjj6pZvJLhTMg/IkAo2l3Hi053NOXO8PSytgCGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDcf6aMZr6xqrZXd8nvEQjYUNFbLOWZdByBk0Rk9RCDdqXIuq
	WLSjM10IXT/KmmshUYG0PqOEY2A34z5ONMvjEf7lzzITuvbgMVOp3AFCTyBe4bZ5Osg34+8tHDU
	=
X-Google-Smtp-Source: AGHT+IEguS+DYgfr50X3amlVgerOKKT45qvqYFP4etgOkkRvUpQ1dDg9fKu0+t5LQwDSWp3K3ICKxw==
X-Received: by 2002:a05:6a00:4652:b0:71e:4c86:659a with SMTP id d2e1a72fcca58-71e4c866d72mr13703071b3a.9.1728923858137;
        Mon, 14 Oct 2024 09:37:38 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1e71:8a09:a3b:1e00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e51dc0617sm4383693b3a.165.2024.10.14.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:37:37 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/msm: Simplify NULL checking in msm_disp_state_dump_regs()
Date: Mon, 14 Oct 2024 09:36:10 -0700
Message-ID: <20241014093605.3.I66049c2c17bd82767661f0ecd741b20453da02b2@changeid>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241014093605.1.Ia1217cecec9ef09eb3c6d125360cc6c8574b0e73@changeid>
References: <20241014093605.1.Ia1217cecec9ef09eb3c6d125360cc6c8574b0e73@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The msm_disp_state_dump_regs():

- Doesn't allocate if the caller already allocated. ...but there's one
  caller and it doesn't allocate so we don't need this check.
- Checks for allocation failure over and over even though it could
  just do it once right after the allocation.

Clean this up.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../gpu/drm/msm/disp/msm_disp_snapshot_util.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 4d55e3cf570f..07a2c1e87219 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -25,24 +25,21 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	addr = base_addr;
 	end_addr = base_addr + aligned_len;
 
-	if (!(*reg))
-		*reg = kvzalloc(len_padded, GFP_KERNEL);
-
-	if (*reg)
-		dump_addr = *reg;
+	*reg = kvzalloc(len_padded, GFP_KERNEL);
+	if (!*reg)
+		return;
 
+	dump_addr = *reg;
 	for (i = 0; i < num_rows; i++) {
 		x0 = (addr < end_addr) ? readl_relaxed(addr + 0x0) : 0;
 		x4 = (addr + 0x4 < end_addr) ? readl_relaxed(addr + 0x4) : 0;
 		x8 = (addr + 0x8 < end_addr) ? readl_relaxed(addr + 0x8) : 0;
 		xc = (addr + 0xc < end_addr) ? readl_relaxed(addr + 0xc) : 0;
 
-		if (dump_addr) {
-			dump_addr[i * 4] = x0;
-			dump_addr[i * 4 + 1] = x4;
-			dump_addr[i * 4 + 2] = x8;
-			dump_addr[i * 4 + 3] = xc;
-		}
+		dump_addr[i * 4] = x0;
+		dump_addr[i * 4 + 1] = x4;
+		dump_addr[i * 4 + 2] = x8;
+		dump_addr[i * 4 + 3] = xc;
 
 		addr += REG_DUMP_ALIGN;
 	}
-- 
2.47.0.rc1.288.g06298d1525-goog


