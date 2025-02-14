Return-Path: <linux-kernel+bounces-515599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D4A36691
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB73188E4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5BA1C84C0;
	Fri, 14 Feb 2025 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKeutZql"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF851C84C6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562960; cv=none; b=BJcxj5TwIpTGYhGeTHhQ0b+arvGVQMAX4CB8x75/Swx2OOuilqhG8G58pqTMdBSku5m2efwEMus8ZEyoeKdIHmjaHNJ7OcgpdaZBQVtkrzg487GdpktEKRdVddwM9hc7uP3DKPHRDgo1ou8ztYG0WVDZV1BBXlUOA3+H1KIgN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562960; c=relaxed/simple;
	bh=K7bYDqnR9vXpWMpWttOaWLLbXoQP6llK5irYRI+EMaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=la696MX9kq39yD4Cbr9fgFnhqr/wFKxoJ2XPW9HvvkJ/23g/5npHnXUFK9ZrfdKeFXMBnM9eKOdUCEbtdQUNEXUOw+dGfGl9/QONqJzsnCxsfwnghbFb7Vvq3bQFfF87tvjEc6eKXFhlqtfQ6HJqMT6lgilZmbQUoVrBF7KlbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKeutZql; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc3035e947so209592a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739562958; x=1740167758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8eFD8Y0Jdwt006d6ZGfmM2mEuwTtejAwkszA51XpJo=;
        b=VKeutZqlgF8bdPMCsMgxNQb2yJZKURSYR+DWuYC4c2LBFePNRcHlkSTVSdyR0aSPrs
         zUE5Qn/Ud4IsnGCTtZEuzfXO0C6VytYHS4ETW2AgY9HcVQgv/vj+V8CWqsNiJ9KQ0Jwh
         Nnyni0zu4TF0nu5gKzrzAYPoIIyCZnvzi6WOIBGjoR7GrfGA3E8PvXMgpDcyjVXogaEb
         yJPEnHEJqq0TO2ErTePOHXBtZggqfMqENk04sDJoH7L1uvOmYPm/jveuQLmDyW8DKb4O
         K9L2ZggzA8LCJg8kQuPSp3INMVcBeodRkBwX0Kx06kh5DjpogTi+yARH7TeJAsW8RdlD
         /e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562958; x=1740167758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8eFD8Y0Jdwt006d6ZGfmM2mEuwTtejAwkszA51XpJo=;
        b=nudMPLCYGiNxhuXYrXB63/qEbmI1XjadV+mwY2508/+cXFOR0Low52gwUFFkR1yOOs
         3l4/yoUmuQf2EZSg02TtsKhvb5P6KVrN7J2fOnU5Pp/PPrZYwAzfJpqtGIr2HOTMSLU8
         CCeELGv3Nx5c12ymtg1xWJsy5nq24GQVfpFAxcjtGubjXyUniKO5KxiJE7lbYGy4jbrX
         Wsv3I5M/LnoNDi0l5IBcOp6TEQ56Vn8YwFD8wbZqnrqFa8cejRj9YvJOojtYS6cD0h+X
         5e2KFxtfBSaELryDWaJfjrzme/Eu+H8+eTJWEyHSRQnOkLe99DRZOA+Eb+aoTCemVie7
         0MdA==
X-Forwarded-Encrypted: i=1; AJvYcCVmVi2xn59BPq/x4N3m82lyQJtLNrVeMn92oXvUe0ANKiyjvuzPfLOHGTmllVKyG3vSmfBEuVM6dnVzATE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mtGPvkkH8b5DUunuFNZDyi06/jvlMeXjd8/1SGwucTrp6EfL
	n6RDDqe2P0OEEMwML4S0VI27oHK7WzFvH9DKQvcEc0T/aFIrLz0m
X-Gm-Gg: ASbGncs6hy54zyfiNM9GEXphZ4AprC80MRP5ZgaTAb3VTEyy3cYC4pa1KUZGaW25DBC
	BnzpmFymVgt0GHTiBRhK1xQnVYN4/IF/IIYI25MRByVDLw34k2eB5SUcWQG6AXWu4lRDJ4thVrf
	QamM8wyCrEDLM59qnyO0MfPoId65+yypudQsMx6Nd3W/Mh/xQsqcMBcwXj2qP+KwMTyInwMVTNK
	hTMLccJbqrgULov+k2VO+WE503rd8PtpfdEKP0SkyqGtPeyq5CI8M1sir2WHI/OXK7jzP6SFPNg
	7iTWYEH2TnNf75CvhNjpQD1BBTxpacY=
X-Google-Smtp-Source: AGHT+IEDvxqpJwfdkwb18JB4Bmp8msqxbfmJy94sOkKiuSkAxnIjXU1DN01E3qa2U1W6sH9l5reYuQ==
X-Received: by 2002:a05:6a00:3e24:b0:730:83c1:1f79 with SMTP id d2e1a72fcca58-732618d733bmr422885b3a.3.1739562958288;
        Fri, 14 Feb 2025 11:55:58 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2670530b3a.75.2025.02.14.11.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:55:57 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	ajithpv.linux@gmail.com,
	roheetchavan@gmail.com,
	niharchaithanya@gmail.com,
	eleanor15x@gmail.com,
	everestkc@everestkc.com.np,
	kees@ijzerbout.nl,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	gascoar@gmail.com
Subject: [PATCH v2 2/5] staging: gpib: eastwood: remove unused variable
Date: Fri, 14 Feb 2025 16:54:42 -0300
Message-ID: <20250214195456.104075-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214195456.104075-1-gascoar@gmail.com>
References: <20250214195456.104075-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove unused variable 'nec_priv' in function 'fluke_line_status'.

This removes the following warning found compiling with W=1:

warning: variable ‘nec_priv’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v2: no changes in this patch.

 drivers/staging/gpib/eastwood/fluke_gpib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index d5b1a03abf11..65bb79a8fd3c 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -194,10 +194,8 @@ static int fluke_line_status(const gpib_board_t *board)
 	int status = ValidALL;
 	int bsr_bits;
 	struct fluke_priv *e_priv;
-	struct nec7210_priv *nec_priv;
 
 	e_priv = board->private_data;
-	nec_priv = &e_priv->nec7210_priv;
 
 	bsr_bits = fluke_paged_read_byte(e_priv, BUS_STATUS, BUS_STATUS_PAGE);
 
-- 
2.48.1


