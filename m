Return-Path: <linux-kernel+bounces-410596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC79CDDB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03CE1F22755
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDB1B6D15;
	Fri, 15 Nov 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWIQwZfd"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74419CD08;
	Fri, 15 Nov 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671376; cv=none; b=nx0DV/kmwiAquiQGRFrPU4vWLx4PGkmCXIUE2XAguKuozX3iFDKpZ+hGAY71x2iw4mDzyuQX72yv756ocl8YK+I2oh5HQJJeH2L5q4CbnY4TZmb4NxPekQ2HJSTznfDulPtbRE/I2MySHX/DCQD6Bhls1GwnKeos14IksKC13hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671376; c=relaxed/simple;
	bh=4LLiP+VUFm3qOSVLMN2/ir4nxnih7Y21VZucPwfBf98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y9rPZy/iiNFwYD5JrH85ljAU34bn+V5HjE3b0hjqBnlNe5qzD2htKiquxqVM9lTauIuRJNEpFy2PJNEl9Dxq12Wa5m3Yo8VGneSfobclRDjFa9XsNaq8BH4XyVcFQH8dko2LnW5beP1MiDUMngI6gl/2cz8SNnfJ3vI+9vshbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWIQwZfd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbcd71012so19329095ad.3;
        Fri, 15 Nov 2024 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731671373; x=1732276173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KtoZGAEyQBCnhyYoL/bdON4aQAbKow6V3dd3ML98XEo=;
        b=jWIQwZfdTPDUDX74BUwXNAThgI2vhWZihy7tRr3XgHGjd9bpGB+tj9VFdU2HSoPEqD
         OiPKlX/SBlrP81D2PDnmQKIk7vrUhM0MjnlHzDXwWvLJ8dLodJbgzlYVgZS4EpTVUecM
         LB5X668zuIqerYSz3Wgb+AHGjRtH75UXfZuHzKWkUKIgrm2H1rhi2AHBdh1TWLpCtbmA
         3uC9MxBoE3nD6YuPu86MFQ0kNOBwFFNn77dbi+/+77n9wyMY27Ou6Fl3QnUWdu/txA+z
         9JqHlUDRJWlHjB0koC73b6KMndpxOWcuu8fmpR1iEs62zN7mM+idRqFtAgXCafnX275p
         o9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671373; x=1732276173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtoZGAEyQBCnhyYoL/bdON4aQAbKow6V3dd3ML98XEo=;
        b=Nz/LATwW6sAIpwsRNGAMe83ZcGsLk1bSvf6ueI1+RQtJmYu7GK8dGjv7c0gt4x2KSa
         H/Ajjh36GTQ9breTGh6d0yUZNdeHa4n/tdoU3wUyzuD2cLucg1+VIQ/UEEFbDl3gqClE
         gUtrp7lC8d75TTD7f+SITC7uGsPAyNh7RCFEg+RKshiwrQf3ygwraWfuoM+84kxpeCPs
         eRSQL0lsgoxQ2i2TIbmhGdMHhFya07YGrs/vGZgCVfh/GryzyXKnc7pf+/wTHUZzHcqR
         6UJ16b4Sfb5lWlBFdosMbLoccgNbtoR+IUDzccZhMx+z716MwUB5xQe8qx+1+kZdZafP
         XB9A==
X-Forwarded-Encrypted: i=1; AJvYcCVQgxaZdqMwtWeekgLqmyRqaMYUph2lmXpRYypKruH0tEOFPLTVlcpgEHUljAqQ8DvakJQsJJ88lNMDWpw=@vger.kernel.org, AJvYcCXSGCl/D5FtasrvMLq7/PXna12PCrSfqaY5tmMb2lmUSfRz7JnNCZ8JirMv5Fes0noOfwrQ3ye28UMT9g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwViNYQzsQCs10hhtQnNbmNtKzJOJIwHHzYH22TrQwu12f4BBT
	oWiJeM5nOE0sUZ6H5AY7uSY7X1yWKZcf+zmz3JSxcbrCA3Kqo/Js4QI2fm3y
X-Google-Smtp-Source: AGHT+IE5sTGzwQKuTH0On3cSqtf2nsawCLjUF0bcqmiQ/aTjp84Xc+l7NZt2tv8FVSZSvOI7ACAIyQ==
X-Received: by 2002:a17:902:d50a:b0:20c:8331:cb6e with SMTP id d9443c01a7336-211d0d818c6mr34430995ad.19.1731671373536;
        Fri, 15 Nov 2024 03:49:33 -0800 (PST)
Received: from HOME-PC ([223.185.134.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47b2csm10469315ad.219.2024.11.15.03.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:49:33 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: frattaroli.nicolas@gmail.com,
	linux-rockchip@lists.infradead.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	heiko@sntech.de,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH sound-next] ASoC: rockchip: i2s-tdm: Fix a useless call issue
Date: Fri, 15 Nov 2024 17:19:24 +0530
Message-Id: <20241115114924.23843-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes a useless call issue detected by Coverity
(CID 1507978). The call to rockchip_i2s_ch_to_io is unnecessary as its
return value is never checked or used.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index d1f28699652f..10f46fbe5175 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -577,7 +577,6 @@ static int rockchip_i2s_io_multiplex(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 
-		rockchip_i2s_ch_to_io(val, true);
 	} else {
 		struct snd_pcm_str *capture_str =
 			&substream->pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
-- 
2.34.1


