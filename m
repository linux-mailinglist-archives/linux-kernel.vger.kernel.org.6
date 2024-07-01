Return-Path: <linux-kernel+bounces-236948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2341E91E8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3432282A94
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3316FF48;
	Mon,  1 Jul 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="QmdZtsF+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08C16D9D4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863812; cv=none; b=l47xgY+BKfgj1+RVw6pWSrdBX6psVwe30R4BMXpO3nb/bREIORwwGbmiZfJbPpEynm6kOxUxjpieglhLSoePk9FHurIGpno6iNk6aaqjDBzOSlN5jA3xPMlLnzzmxzX4YbOkrKTRIid6mm+PIofhc9ooFOjb/DnDW3POpWy9gtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863812; c=relaxed/simple;
	bh=BEBn/XfxvnAYpxoqDoK0u/zk5zmgkA/fGj7KdKSg02Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NE9vQcrmWCJJnfNfBb++cTz3lYwIKz6zw4Rgqu8MxkuIFOqO+yiNGDFwbEtfhO1qXYuzqHZCQVQ/go0wK3nTD77X6piZhqEA02Gar47bY1Qx9PCfKLX3TMwetfuNG9N3kYkKqE8XP9DrYS3Ugg51ZMsqUrZ6n+lwusrAwkwdhJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=QmdZtsF+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d0dso26537285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719863810; x=1720468610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4phTXkkw2gQSc+8dNAA63L23OQusnHODrsEh3hYbZ4s=;
        b=QmdZtsF+U2OKaZXlLP8px7LjKAmh5iru6Q/kBPqTnQwAuL66vpQ88s3l7aizsqYisF
         oCRHgjWQH9Xy6d3iubPeywNcP4wxuFbiAadLzQc9LGVtg6xbC6uQrwKHNV3798gk/HH3
         VKuWiceQ2xWxcMn9u7m8PYHN/bYFdSvkU8UVPD7ABtlVY83iKypTiE4tbx3LqBAWsVPU
         P69+NrCLDPumgLk+EpVbgPZz1+t61i9HA0oBeqTbLb8zBWxsJwYCmHYuvgeTd0q5wPqB
         G13fRZP5GNLHZ1XAt7lBbmfHXA0+wqmSw+2G4RG27GtpFF8eukLLUAq/i7AT4t0/lPdB
         8o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863810; x=1720468610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4phTXkkw2gQSc+8dNAA63L23OQusnHODrsEh3hYbZ4s=;
        b=dEot+VLBC+zPT8R03/gww1S/UqvtH3Ppo/RR8LgYmu/Qgynm6/Fvg5x84bS5YzrM51
         MN5Uw8/kUacOClvLhhtu2a3wv0OldpJTMeVSqO7cnyevjLDdhkqDBo/FnMQraVdiyJdf
         PqIwsHMNlMWNik6Gq5xdKkrA6I1UEwTRGs0QOh4tz4m5/uHruYR0V67hL4RtcEbyEZZg
         3vgJq3WXvIfOjU6sycRJibOCb6AKq25OLzK52ZhvpaOsHlhxrFIaM2YaWDyDJnUlflsh
         WI/ZgJ3Re3HRvu9pk+tfLbUyVyODaL5x3bPMKBKL27Nu1Sprxk7LIinnBCegYPtxbeNL
         8AUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNSbi1Vu/bcYna28d4bbVb0kDwLnfrOwXLs/vNpwq+lNaUcH3CcnaAkO9fLvnvtbiXvo/h5F80W9+iW0dTZtQW0wa5lkuNEGRFNENu
X-Gm-Message-State: AOJu0YxjIRP+ubU9GalJsVi4kdy8ltX1QqeI1KijguhxkT5RO5f8w17n
	VPkk3JIAkUt+QXb6NnHFnMBZSgL+YKfXHnCRMk2EL0frW0uvv8D24X6/SFTD+zk=
X-Google-Smtp-Source: AGHT+IF8iFAqlCFGCgrrnbtwsZpScqow+XchPf4GezyX7uCxsum1kO02WSlVbl2t65pDpT8elg6nsg==
X-Received: by 2002:a17:902:f650:b0:1fa:2dcc:7d94 with SMTP id d9443c01a7336-1fadbc93f97mr79599735ad.33.1719863810191;
        Mon, 01 Jul 2024 12:56:50 -0700 (PDT)
Received: from debian.vc.shawcable.net. (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15b8920sm69026085ad.304.2024.07.01.12.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:56:49 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] drm/managed: Simplify if condition
Date: Mon,  1 Jul 2024 21:56:08 +0200
Message-Id: <20240701195607.228852-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if condition !A || A && B can be simplified to !A || B.

Fixes the following Coccinelle/coccicheck warning reported by
excluded_middle.cocci:

	WARNING !A || A && B is equivalent to !A || B

Compile-tested only.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/drm_managed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index 7646f67bda4e..79ce86a5bd67 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -197,7 +197,7 @@ void drmm_release_action(struct drm_device *dev,
 	spin_lock_irqsave(&dev->managed.lock, flags);
 	list_for_each_entry_reverse(dr, &dev->managed.resources, node.entry) {
 		if (dr->node.release == action) {
-			if (!data || (data && *(void **)dr->data == data)) {
+			if (!data || *(void **)dr->data == data) {
 				dr_match = dr;
 				del_dr(dev, dr_match);
 				break;
-- 
2.39.2


