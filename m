Return-Path: <linux-kernel+bounces-248129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36292D8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D08281BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E99196D81;
	Wed, 10 Jul 2024 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="L3D8RP3u"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F619581F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637921; cv=none; b=dHxaspFTjbfC5ruk8CveHN5sWooIfLkL3UQQCCmPOmAyQYmnP5Dn/7JwQgrViw/YgIj/lENF6Wtms1u6zb2YzK3YkYX9UXVuUhRblHQ/23UKLGeyQ7J1iJVUBuHdcY5tIpSmwf4UrHOCCG5ZSoeWrnrJ3VjEH4T8yL3rqwB50g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637921; c=relaxed/simple;
	bh=YrfnOc6wEZCSrEGdlpWnhLi4yoU51F7CZXquQNbd7mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdfzDe11A2AvOkEAlmJCJJtsa14wDMRYwT8YUYnwp3OKrTY6gIX+nLfICV2z7anDrKa+lKiX8nqCHDeKK3uKDzHlDsUB85cpgufT/2uuD/+SAP/Y3NgB/86K6bXm71wkRi0pdWno0KaEIWz98ExmNU177cUledj7avae/VEC2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=L3D8RP3u; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9f863c46so114228e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720637917; x=1721242717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJYMRMHzC37gV1kVGMz9CGrplXBbaWXQ72J7tDcGK1s=;
        b=L3D8RP3u0VoyUGm3yqFn7yuDW+mhLDiU91HGziccv0SlGbqbZc9Ra5D8jA4mRNknBf
         qumdy6OndaFiVjGvNtz7SbhOSFGJnNn8GdQa+ya1S1WnxkOMpxfIA353g8ZNWHEOA246
         iigx8w++6XfMc9eBJXyh5pdt+Nr+BEzUaaWFuNXpNUBDg6gQnzJh96Gfr/t08E1ZxoT3
         qsGssfTjJ2J50tBq9KApNCSPNWgYxI0XgxY3MkMx27FBVmT6LOrAMbUl/Eu6Z/2ycMye
         5RsW9fh/K+zp4wiEfMco+R7c586jI/w0UcvxVgZoVMnhfZtpZosEl8MUvEVJkwcevVS3
         EPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637917; x=1721242717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJYMRMHzC37gV1kVGMz9CGrplXBbaWXQ72J7tDcGK1s=;
        b=UFEF2jPduy0/C8FrgUeWHgswJoUo7VKjvVjuKWZMFTBgbK2/QiIRIY6mLJmOySQX7W
         RdYdHCLgbcx4mQ+fDlU7KFOlsmWTHC5T+nlPPkyLywaA7tXxrlLQnAXQmj3JJ+RYnyBD
         wSRuAqXeZRWr7H7H1lVss7hHgcsR12L9+r/Wm1kqUdkeCgoMJBy+iywgCtyd8tS5WR3O
         OHfctIZfOtai1xUPelh24Ylj8T7RnjO35GDUFyZl4W+v7gt9dKRo5uJ6dbOA+FQKLU/U
         amSce9vrPMmCeuWaPX2e6QhbrVJRoU7JSNA5VPXDhtbcwwk9SlKL4iBMS45b8HaVpkMk
         Dn4g==
X-Forwarded-Encrypted: i=1; AJvYcCUpj5hzSRxBItXiMj9lYS8TdRnXIaARaVBSS2tCfMDKbyAcxqAkkckoCR8KwIS61IdA+dBYR4fTrlPgA4BDCZHckRMTwBcrFzNskMgY
X-Gm-Message-State: AOJu0Ywoo1fzfZwUvwc1pKeLypGdnZx6bMx/bUfPO3oCC+amfpcPJLiH
	0KU4hGMro755ky3dih66ONx6dt32hyCz9nZT2nlZ7mJQRPUie3ov3LNR+vP8IipdcZ//QcZ5d2T
	RTKY=
X-Google-Smtp-Source: AGHT+IHq1gtV4vdpsCvWVBt/1zvuwCclYwi4LpINzmgObh9B6XyVyb0wwj2eTLHWiRBGvtDkGyfWLA==
X-Received: by 2002:ac2:5e9c:0:b0:52c:84d1:180e with SMTP id 2adb3069b0e04-52eb99d4fd8mr3107760e87.67.1720637917332;
        Wed, 10 Jul 2024 11:58:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741553sm91586145e9.40.2024.07.10.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:58:36 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: toke@toke.dk,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] wifi: ath9k: Use swap() to improve ath9k_hw_get_nf_hist_mid()
Date: Wed, 10 Jul 2024 20:57:44 +0200
Message-ID: <20240710185743.709742-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the swap() macro to simplify the ath9k_hw_get_nf_hist_mid() function
and improve its readability.

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/wireless/ath/ath9k/calib.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
index fb270df75eb2..4b331c85509c 100644
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -32,11 +32,8 @@ static int16_t ath9k_hw_get_nf_hist_mid(int16_t *nfCalBuffer)
 
 	for (i = 0; i < ATH9K_NF_CAL_HIST_MAX - 1; i++) {
 		for (j = 1; j < ATH9K_NF_CAL_HIST_MAX - i; j++) {
-			if (sort[j] > sort[j - 1]) {
-				nfval = sort[j];
-				sort[j] = sort[j - 1];
-				sort[j - 1] = nfval;
-			}
+			if (sort[j] > sort[j - 1])
+				swap(sort[j], sort[j - 1]);
 		}
 	}
 	nfval = sort[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
-- 
2.45.2


