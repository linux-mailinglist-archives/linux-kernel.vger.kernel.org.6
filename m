Return-Path: <linux-kernel+bounces-352138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFEE991AA7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCBA281A50
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF4172BDF;
	Sat,  5 Oct 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAAiCwx0"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF51662F1
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160493; cv=none; b=jfffHXXeSAsLpUMw6f2zFSymxRa0oGOuc1ur4h2En2UkdmnPsbrTN1mp9/Qb2in2tUJxf4skPsJKaLQWRhswRY1MdIhbfz1xGqZ8F9qBjjRyg/CTCtwqeNRR+p1EXu6+9Qbr5BGFsD0802fdBQq43MkMYWaGE1pJCRTLMVz47Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160493; c=relaxed/simple;
	bh=TpQGa5ra8SvXLVOyzl0JFjYveChuJ/zm53KUwg/ByIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUp2TF/OaNY8I9XxHJ7a6RVUvOe8SCwFR/ZEvKDnlA6YC+UAvcXqcHo72MRfxhw233+ULdfM73OUlcRVRJk9i8IjdzzkYXU52NJlwqV7JCuWhd/oogNj7hCsSFLVzbfDUyxVqGgf0s62gmWRcVR7mPduyfKY8lKNm82CHkB8rJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAAiCwx0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso26837905e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160490; x=1728765290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTJ6ZMxD1+jB403ZdV13gEam1qNwb5U1WYSGSXkZ//o=;
        b=bAAiCwx03M5wJmHFdtlBWpv1n6zdelwvkw4S6mPGPmvXk9AvVujKZc24UIBOJnaMYP
         G/Tlax2laPFFMIZgBu1XuqXhzQKul8Yd3wPLxNNYHPxY24mWrUMcWhjGto7DZZ/2vVQB
         MyOGJJJ+z2wpeJ4JluiOK+G7pqxZYw1QQAzixiDIv3aRd/Nnj+gD4mPF31IUgOR1Pi83
         /aC6MEp+N7fy1g0JOwM2AAGPMpkQT5Y0FXKuTUIlf2jeMHx17kynp2t29+cRnb1ZAOi3
         /232BENzTQb98ma4GcwJftgLBSyTD3nO9g3RMYYZ0LaMEn9gxc3n9gVwEtJLE0Pf3NGw
         LEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160490; x=1728765290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTJ6ZMxD1+jB403ZdV13gEam1qNwb5U1WYSGSXkZ//o=;
        b=iy1qgnN7fpIQxcaxt52auWb5/Cw8C1AHeFghv3qT3EtlNuPiAOqOR0EtT31kJ2qpgn
         JuguI/1z+knbSxC27oR/r1REkUSQbCE4Oq+IXz7mU2VrpGeuw7Fe/XXc5B4OWyuU0nGV
         IF4ndLuQhaluOYKac2ct/DL4Wc4j2pw4f27GdG6c9PMMSoD5LsUCbQXXGlw0YVsdhNlF
         jaHiXCZR67hi3ljpDd1mOvdTvKlbEX/jbqNmJUihK8e++D++niwm1oVp6SECDjzIacrf
         PYgKf6KnAEYMNVuaZxie3sRX8vBW9wh30iwvxKRnwHBy9ynJbQHSnv03KZnLlaqwfIkd
         viWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8pgCtLLC3uOlC28sK9UIww3Kpf89Rp4phZBHyXEePv2NqavE8gk6Z6H3hEBb6Vyh9WEIgwVpNalc0ob8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxil3YFrM8YIRnMzTTBXeFUh9dTzGWXyGk8mWWY+pD0gxL2s+Jp
	Ctaq8o6PjOcV97q7OgwGT3F/nXVDNfNaCXPPbhDNC+ix18Nim2Zi
X-Google-Smtp-Source: AGHT+IEBGRzD+6PW+UmhjSaUgcj6XEwk43MFvOUwqaFUyu64I9Bnl8stuR8amDF/ANROxkRpC+T8jg==
X-Received: by 2002:adf:ce8f:0:b0:371:8a3a:680a with SMTP id ffacd0b85a97d-37d0e782737mr3700315f8f.32.1728160490258;
        Sat, 05 Oct 2024 13:34:50 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:50 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 05/15] staging: rtl8723bs: Remove function pointer free_xmit_priv
Date: Sat,  5 Oct 2024 22:33:48 +0200
Message-ID: <01ee48c459ddda882c7616e6cf257d96429027c2.1727966761.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
References: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer free_xmit_priv and use rtl8723bs_free_xmit_priv
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 1d1e4f438e7b..bbead941289d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -225,8 +225,7 @@ s32	rtw_hal_init_xmit_priv(struct adapter *padapter)
 
 void rtw_hal_free_xmit_priv(struct adapter *padapter)
 {
-	if (padapter->HalFunc.free_xmit_priv)
-		padapter->HalFunc.free_xmit_priv(padapter);
+	rtl8723bs_free_xmit_priv(padapter);
 }
 
 s32	rtw_hal_init_recv_priv(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 55cf827fc255..ef70ada68f2c 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1259,8 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->free_xmit_priv = &rtl8723bs_free_xmit_priv;
-
 	pHalFunc->init_recv_priv = &rtl8723bs_init_recv_priv;
 	pHalFunc->free_recv_priv = &rtl8723bs_free_recv_priv;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 696a71c01bf9..0782a13074d7 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*free_xmit_priv)(struct adapter *padapter);
-
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void (*free_recv_priv)(struct adapter *padapter);
 
-- 
2.43.0


