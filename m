Return-Path: <linux-kernel+bounces-207667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F404A901A62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D9281A77
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E61CA92;
	Mon, 10 Jun 2024 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hQUkpC9t"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741E125DE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998542; cv=none; b=MWgBs1QILFBIR0xseaG/TymxN8n4X67SPLOSbFumq8epbOxzVJNpFLAZTpm1F30rPgxjPM1qMtyAzm7P7M+fbGa6E7msViDwzszNb0N6O8CtXKrrNymLzlqJE6ONztMfRS+ywuskmEoxhVHggXuvxJsRFmLTlcARjsC+nRJQcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998542; c=relaxed/simple;
	bh=5aVoma0bpE5GWX/WIZ9LITVTKqc1xLxGDktG+yidrQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIa+ygvy+lhcJiFcn51uqu11ln12Ujq/yl9fmb0Ql24J/GQkXAIh8+UtDsQFjqi3abumbTb8JGvSZFrRsWlZlsxVePzPSz7LcKqR+MUxCAc9AKToKP6wtKfjhdFnrGY0mWLyFW1AEoTgJtQuE4vnjD34O+AyD8JyXM56RyAPQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=hQUkpC9t; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e5fd488d9fso1581838a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998540; x=1718603340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKb/VDt+1G/+4IorQ/WgsaHkB3UUwpTTGGc6wYZp8zc=;
        b=hQUkpC9tQw5oLHZBFfnSCcElQn4cHNZLRd6XoGjWfoSWM+apSc1giMIv+rNaOLo5el
         7JiyZ588XVnPIOCGwXv/ChyTM4VTmtgqtECkWFOXW6YQ0lKAgqADaxKLmmHJVLD9cviI
         rdwe3lMI0ru5/aosIalrSf9Hwc74mgKIULR+C/H3SmhFejbEQ5Bd9FoutbOGt1OyWO4O
         u+nNm9GZ0y4ztwHOAvFs1vlv4y1ABA4MJPSXzLWsWclHu23HUwl2VTi4mxTcB0cl/L3x
         ttY/hfisEhjMLmv8fnEgAMHoA+nObHuIhn28k4AP5ybray85P54cpKy4j6mrskiJn1HT
         Xb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998540; x=1718603340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKb/VDt+1G/+4IorQ/WgsaHkB3UUwpTTGGc6wYZp8zc=;
        b=C/fddpxveIhSwCQwsmhOJpP3LkTDIUHk8S8kemcD25SzXGU7fFNEMcgbx8KqJdNKRO
         JPzPdSYLFKTxgzIL08Jki6lbnvX7q4PPbOZ2KEr4IR4P2dj+NkrQdCqA5RUHgIEbXtmP
         YvoSBdZZlvJSxOQWf+ORE2maPzZtv8M0szar6ESWfs95knGHRYrKHpEoILzUO1N5IzS5
         Ii7H0KDOKRLHHk0bjb6LtVxTQZjBr2rjZ2Rz0Naj5z4E25wePACxwQwM/1w65mCjMOVA
         mvq/NgixgoV5ssZi3qDKESv4fjk+8JD8TMvbo7U3JCmOaeogkgbw9rMe3+msUGirt0qf
         F/AA==
X-Forwarded-Encrypted: i=1; AJvYcCUwdbSz8nzihG8uu5U0EwtEWoRw0cVxYiPwt14PWDtmIP2Y83kOE177dI+isArkfsQWmfwb23i4b8BgI+ybzcWg3UmfW4hYzjUFGFjK
X-Gm-Message-State: AOJu0YyQaIqVUgiHMn341XQ1Q3gEliIUnkNAoAESU904yFs/oh9J05y/
	QV9QqFS0GLLIGG0AlnOjJ4YmYTqaPE813IerFlRPiWxJ4f/wly3j5vGHCKCNi9c=
X-Google-Smtp-Source: AGHT+IGmNjqiQssDmVqEQJrhuHT0e3CeZ9A2cadaiJHRjoTBCTo2tjN4RQg4nlaDqEo6bs0Ze7fRJw==
X-Received: by 2002:a17:902:988b:b0:1f4:b18a:3f25 with SMTP id d9443c01a7336-1f6d0398abcmr92192565ad.60.1717998540444;
        Sun, 09 Jun 2024 22:49:00 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:00 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/24] Staging: rtl8192e: Rename variable HTOpMode
Date: Sun,  9 Jun 2024 22:44:29 -0700
Message-Id: <20240610054449.71316-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable HTOpMode to ht_op_mode
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 360d1cc446d0..83082a990fbd 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -417,11 +417,11 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			break;
 		}
 		if (ht_info->current_ht_support && ht_info->enable_ht) {
-			u8 HTOpMode = ht_info->current_op_mode;
+			u8 ht_op_mode = ht_info->current_op_mode;
 
-			if ((ht_info->cur_bw_40mhz && (HTOpMode == 2 ||
-						      HTOpMode == 3)) ||
-			     (!ht_info->cur_bw_40mhz && HTOpMode == 3)) {
+			if ((ht_info->cur_bw_40mhz && (ht_op_mode == 2 ||
+						      ht_op_mode == 3)) ||
+			     (!ht_info->cur_bw_40mhz && ht_op_mode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
 				break;
-- 
2.30.2


