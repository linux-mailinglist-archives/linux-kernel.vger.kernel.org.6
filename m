Return-Path: <linux-kernel+bounces-387750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD929B55AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CFAB21AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19420ADD6;
	Tue, 29 Oct 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXwIC5xg"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE5206E61;
	Tue, 29 Oct 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240420; cv=none; b=LK3SHUL9CtSI6JOqD89ZISagjbk/y0ukJey1SQ9qMPOX1XI5MuMCxHk34Aw7sNhZeT8erawpnLgMixzHFY0KnnkQ+L5OnAOzXln4oC6HfrYx88BSv6dUCeDOUjCDT5qynQ9+HLXKHUC0/6NnOrnTUpSRxUApi8la0FMdFy9jN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240420; c=relaxed/simple;
	bh=0XkPUGLs3OUYWUj0mHzYM5xE1QTfkxXx2AYeL72sqKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o7tUU+6CxcL+K7bzCNlL9cU1cmCOaDE1rbWGeQlzblZp0upU5ITinYpm3S5Mbv3EMKGljGAtdi8ub0ASQXs5c+RbaMW4H0qcthlhZX/4npqrdh0jcigWT6CV3hInBs2RDqY+cLp25klVffiGlmgelHIlGicugvs/HtT2zjQUzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXwIC5xg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4fd00574so197370f8f.0;
        Tue, 29 Oct 2024 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730240416; x=1730845216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/7OE/QMinTNnLERT167c3CvL/M1HjMkuOBezusZau2s=;
        b=dXwIC5xgN+Bd7H7CrFjfjXOmGDfX/N0skhe/KSaDzUqGoFBSl5ImfsbpTagoZB7SoF
         7QJ762v9CwU6miGw0G6q3MmHAjO59NrgOFq1zEm+OWfWqcOLWanmJ2JbhdPAYHQl5/B0
         7guJ5SxhP+rQCuk+DTOLRFAKxG0eSYyZeIcSUeItJu3bThSRYEskHCDueaLfw64Qa8Ki
         ggnOCgGqVrnV8U0sCqvVXuQCmw43xc9pPFbwvcbSl9I3NBXc944ExaCQJUJv1xjNIvE3
         9li2Hq5oaMTdNbSKKKsSywxM2UObSuZQbcv4zNpviKM5B4Su5LT+PgcA4CByI8gVdew3
         tY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240416; x=1730845216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7OE/QMinTNnLERT167c3CvL/M1HjMkuOBezusZau2s=;
        b=bx0ukrFOxi4SbVOdDPBopPLF5xNthe/cvIDVM2otCwUm+Cnm86kYCAIlM2+bKXvQRQ
         bVwRoTU2iUjKlrSlUOgfJ4mqeVY0h1jRRe5b5pZbcmANwXRR/lH+sdP2kTNYnYcYPS2Q
         lfcwtmoEAw/zfOv5fUU/lMYk6RjPpIVF0VJaBmZuNQDoDF7qdxKQY3gY005l2Wh5ZEJQ
         xrRFfrxYn3jWIA6gmH237El6kogYXMnSbwBPRXUdvEB2RElBiJl1qvcsxZtb7Bophaxj
         2CAXFkol1tLDYYAZ+kcEBcuPeZDK9KDkrNO8SfzTnhs4znLJd1exixEolAB9pVgW+JUS
         hkkg==
X-Forwarded-Encrypted: i=1; AJvYcCVR5bb4o6cnJNSePgPPm58fcFjKce5OuAM61CcsT4jYHDQjch46GQE49JDlkYRTeyfB9MRINwszZSY2Q90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8XAR775uTm6mKZfhEc3DT46WFlNzx11IkszCU4SKR0Ohm0jh
	Fa1PWb/0iJxTZ7QRmiLRbP5i4Ys7nqq6hNwPm1mQj6rH+QzrL/8d
X-Google-Smtp-Source: AGHT+IGu+nfYSmitltWyx5Bwjm+ThSqNw6TaW7O5o1H3hKftUq+FGaLL8JkRaM0CTwtlDfnaFXsyjw==
X-Received: by 2002:adf:e810:0:b0:37d:4330:c87a with SMTP id ffacd0b85a97d-38173e61f42mr3163196f8f.4.1730240416210;
        Tue, 29 Oct 2024 15:20:16 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c8a9sm13723466f8f.12.2024.10.29.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:20:15 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: remove redundant check on outpos > pos
Date: Tue, 29 Oct 2024 22:20:15 +0000
Message-Id: <20241029222015.3069873-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check for outpos > pos is always false because outpos is zero
and pos is at least zero; outpos can never be greater than pos.
The check is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/jffs2/compr_rubin.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/jffs2/compr_rubin.c b/fs/jffs2/compr_rubin.c
index 556de100ebd5..9854253d0108 100644
--- a/fs/jffs2/compr_rubin.c
+++ b/fs/jffs2/compr_rubin.c
@@ -276,11 +276,6 @@ static int rubin_do_compress(int bit_divider, int *bits, unsigned char *data_in,
 
 	end_rubin(&rs);
 
-	if (outpos > pos) {
-		/* We failed */
-		return -1;
-	}
-
 	/* Tell the caller how much we managed to compress,
 	 * and how much space it took */
 
-- 
2.39.5


