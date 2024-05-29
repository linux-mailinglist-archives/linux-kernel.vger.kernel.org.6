Return-Path: <linux-kernel+bounces-193946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74168D3461
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C991C23E33
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9059D17A936;
	Wed, 29 May 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="leAHGD3J"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD517A91B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977977; cv=none; b=KRmBOiIiDsw9epFLiuxfw9osa3otks79m9tEeEiiJrPr3XAS10Hh/Ql5seZVngEoztgOVWGlRdaIrlU/d9vL0QAUCdsjyAj9GD/8wo1S+uloItKenHIg6fpQckrRhUGL1xWBbjXZBoguhE3HXuiXIVWyHdAo/wz62d0unPpBLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977977; c=relaxed/simple;
	bh=UK3IBWgP4aQut5nyGcl+mgkoY3ppthy12X9kSy1W/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dteOyqGzACSyc8PwJ0jaFPesWHqNwoOQ/y/WzbQ1QIq3LIZKPl/5ZiQsb1O3z9/Dmh1XXYyBWdn5PB0YlWgttWmhASUAup4I5/cxeH6QM53h8ByfTRbzfZTBLxf5sRzlto3N9PIbtbrKrQRMsqmKJwQcnlHl2ClGUfT6tajq04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=leAHGD3J; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a1059dc4fso199787a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716977975; x=1717582775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8QfgQefVXbA+Nmlke8cGsJdkI8B0w6erXtSR6K4yuWA=;
        b=leAHGD3J2ffsVnETP2jMnNnAsUp4+h66cTnHzQ8upW8uyeekgzZYl7a6QfZJzWo36d
         C8X4+h761OT7z+gG5kgovbPgSs4g3dVgHoxxvEWM0G14YFVWTJRBN8X2VLNPvhR46FDX
         xSbaz14Brr1RtHP/3IndGVqujpazAJZwadi1lQx1u9ip355fww06t455PfTmyEqMOwwA
         8CB6FS/Qp5Aatuz7yN8PBz3GCg4LBA1xislVPluzU3qW1/ufm9yM9WmdTpoEXh2A/umO
         YlMD09t1nU5banTLqs1EL2PBIPG6cZaugliHQrjuAFKhntVWHmEid4KNgpdT+1X3MNiJ
         S8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977975; x=1717582775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QfgQefVXbA+Nmlke8cGsJdkI8B0w6erXtSR6K4yuWA=;
        b=d14NroMsqJZ/dzZ6cfH2zIK5liJCEepfi5WRQxQn1U2b+xmutqDsoiKeGojhcVth3Q
         y3t1F9jf/RygEGFTPHQoqetAevQ46JeC3zn6RV3HuxJ5PXsu1fqoUKz906ZgOJyggJsI
         Issp30i4Eb7y6GX+GIk1Fd5ioB865tTIshut7bg2Q+Qk1A5pz/AH08YXZ7xZF+r95sWM
         +7GSrgBIgZgttHB96aEozAetKtAEL5jlI+hxa7iBW+WDTz4kD1P1/2ZE4IQwlT1ZrMfT
         oxsolz9G+g0aMLAVHM9QFr3JY1UH59N2H8TosfaZWMdLEVpelxW8XEedrYMtaLLnCf+C
         rKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUXmJsIiRoO2wm8yf4e4j4HlQGSx4C2dAE6sIghMZiQDssDzhLmR5LxW+I72eQq19lZ1RnNklGSVAVGomyO4Ql0q2a3zMMrkby6LdU
X-Gm-Message-State: AOJu0YwGW0vFz1uuhAeCSHnLHI/F9C9HYO9lMaQJxL+r7U07lZA/XxkL
	i5Jp7jjpBs9HKOoOSs4AZh7AOSYLOIQFW73pODLcoh4+FyiUk6GoVMfBuuqEMm4=
X-Google-Smtp-Source: AGHT+IHTppS7GVqORdfCZgJPtNDbp7gwaigLxndDJLWwl+V+qkGGDgRrVx+0AZsfnrb5FacpPck1+w==
X-Received: by 2002:a50:8712:0:b0:578:69db:b46c with SMTP id 4fb4d7f45d1cf-57869dbb549mr7847997a12.8.1716977974558;
        Wed, 29 May 2024 03:19:34 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785249921dsm8198526a12.62.2024.05.29.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:19:34 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bpf, devmap: Remove unnecessary if check in for loop
Date: Wed, 29 May 2024 12:19:01 +0200
Message-ID: <20240529101900.103913-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iterator variable dst cannot be NULL and the if check can be
removed.

Remove it and fix the following Coccinelle/coccicheck warning reported
by itnull.cocci:

	ERROR: iterator variable bound on line 762 cannot be NULL

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/bpf/devmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4e2cdbb5629f..7f3b34452243 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -760,9 +760,6 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 		for (i = 0; i < dtab->n_buckets; i++) {
 			head = dev_map_index_hash(dtab, i);
 			hlist_for_each_entry_safe(dst, next, head, index_hlist) {
-				if (!dst)
-					continue;
-
 				if (is_ifindex_excluded(excluded_devices, num_excluded,
 							dst->dev->ifindex))
 					continue;
-- 
2.45.1


