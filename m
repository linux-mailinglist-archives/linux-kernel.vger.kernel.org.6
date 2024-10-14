Return-Path: <linux-kernel+bounces-364441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B791B99D4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F671F23633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9131586CF;
	Mon, 14 Oct 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="gXXNEYBq"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3276231C92
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923476; cv=none; b=oeXQESuew3nkmzm0zacCPOBaGOAsHeKOxBAjzeUBQVCjb0AKAHNY6Alko5+9iOLCWY2SCt8lPrFwZ+GsEECDxWaxfRI6PAz4LjrlHxozMHA8buM/YxWHnlRc6z9vbnAGvdE4YP16yYBKfXy29DVIg27p6wjRalJSDw9CaGSk3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923476; c=relaxed/simple;
	bh=lU1JfSBV4mmemXfprGgYgMaB28Eo3OlVOGTNl7s4RWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiV5XP4UIwoNNECKuOHrZpPLHjZSviegqbL3JOcNIho05pJgQI5RwlYvHpOb1eBcvJzim9m3USloz5eEtcPaU+PtSK9dwjjrsr6R/jDxKOTntbDE9ma4LI3mDv66F05WdanR4dEASyttz7JM7HYUccBMdXeH6EiiflBGOEhignw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=gXXNEYBq; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7163489149eso3624390a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728923473; x=1729528273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S17NyVE9iarfIVpW26/l7DKy/HI2aRH4h+mkGmLpdiw=;
        b=gXXNEYBqdngiyNhIjwDFGhEGZQbOMPGL5mFNyC01MEA8NRphhHgiRpST4QjYcd+XBX
         ykU8x3U1+LxccIBdrMf7VOPEU9xOL8N/1qRLQqI+GrsBq8GEr1zwPYG/cT0MErciU+z9
         mTxhxSd6Bw/2O+ZF2jRJLcml+chKOjv434aY+g8P2RhGzBJqkG2Nekg2tnxpDkBRwXHu
         w3T04CdqJMrnDIY5EjpK5jPjcXAdzdUmAl4/fwzvGNoX0tytRa/D6crzaJN2pAJq8y+T
         zBdollfJygvOogdfmHSoWty7/QpXHy07jmdAjvQv0J/RoUQymjPJ+sWbHYK6DmfrhG+F
         1Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923473; x=1729528273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S17NyVE9iarfIVpW26/l7DKy/HI2aRH4h+mkGmLpdiw=;
        b=vAhl8bSG8v9QfN+4T/jcVzvwU1RBFLUtxtLopTSWs8cUnO7Jh+qtt5ny4Dn8OKxknT
         25lWB4j5V5bNyP/sibXHos5w9zVwhWm7Y5B5sk6SHiefWsqrzY9mhNS+BK+hBfcOflnZ
         GzpK9TJp32ul1I9HAJ7QoSNKbziIasDlxhcwm5doDSjgAAHyCRrCTUmK62Ca5J5r0YN0
         O5A6uPPMH6e8Fo223NjNAjuVUmWpMSlUArKQcCy+zz11B+ppfPUKgqPrAlL+h6ENXUqw
         Xsz8veOIVBfEVwF4tD0ARe4R9kOb4yRDvIdD+N6yCdQ4UlxE1r7+CEnutWsdzJAj95Tw
         U4SA==
X-Forwarded-Encrypted: i=1; AJvYcCVrAgr/LW0vn1R9XplAESPM5Rd11VcSDP33aIEM7jiYqkbVKO03JsLAHHB/O9TuZv9BIDzZyJgB7ifJ2i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSw9mU+mKSyoe9fpXt6RkxxTTLvnbiWrs3G3x0PNT0gjYWfGH
	exDYybi73xZPuMb4zAkmT0GhIWR2fm98cbDpr4Kmte7BKxK5lNKOb2aZslppUlw=
X-Google-Smtp-Source: AGHT+IFwS5hx/tE/8EBpuYASWc6rw3yXjwZYhoVhf49e9ANduebaPdv709YUK3kshOuBgHU5lvtJWg==
X-Received: by 2002:a05:6a20:b914:b0:1d8:d296:1fe6 with SMTP id adf61e73a8af0-1d8d2962007mr7729703637.8.1728923471377;
        Mon, 14 Oct 2024 09:31:11 -0700 (PDT)
Received: from localhost.localdomain ([185.205.247.248])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e719164d8sm598119b3a.210.2024.10.14.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:31:10 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] Bluetooth: btintel_pcie: Remove structually deadcode
Date: Mon, 14 Oct 2024 10:30:00 -0600
Message-ID: <20241014163001.4537-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch case statement has a default branch. Thus, the return
statement at the end of the function can never be reached.
Fixing it by removing the return statement at the end of the
function.

This issue was reported by Coverity Scan.
https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709

Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/bluetooth/btintel_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e4ae8c898dfd..660496e55276 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	default:
 		return "unknown";
 	}
-	return "null";
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
-- 
2.43.0


