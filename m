Return-Path: <linux-kernel+bounces-199403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CEA8D86D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B3CB2178E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FF12FB2D;
	Mon,  3 Jun 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="pVLDA/NY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81BE26AD0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430511; cv=none; b=WP6XDjHwwa6Kjsacaexx+pOAKx34Pr/NbMAMs4fswIzX8kqZ5Z04fJXIcw9gTumvZ2NBUawC4nKhcdJB3nuRw0uSI4AfHsk6J9JOpFti7CbJGTHGEli++ROnizo99jje+6Acb7N1xmvPE7toS2DQ3pfp23ZjV8lFUOC4lKamTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430511; c=relaxed/simple;
	bh=yQ4boFvPnvQcwgmXDQIyEU9BNujvXIdH7FsO0yBfRiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RCeTkRya0dKMhzwG4dVc16r1LE2o8KqjctO4P511LYDA5revLvWOW+volLO3J66zd4ow8bCJTdWwNKuWltsKUnNZ6YWaHMjLNRfNJfKxetwQrXxmbZw2h4GL4WJIT+47ZAaGxQCT6Mt4bZmGPmGT6tIrPQmCiwHugfqBg9v2pAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=pVLDA/NY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52965199234so5128745e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717430508; x=1718035308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHg396P/YPGmHPltoeNdcR8nbSib0Fn7VRKw1/3Bd/I=;
        b=pVLDA/NY18Kmj27MBzkmLq5EtskQh2c+H2aigTaOuDGQgoXhMH08TaElACK1FVddQw
         tqlSDue7yyg3vMKYUFW6rG4GqnE1OrtKSCAwj6ruxqM5oLPBKXkfzLiBJX/76I/Kq1WG
         qd8j5Dl5qj4Y1K8IAUIh8WYx1xeQS2nTiRYg3jP+e9xEZT7pI3wCN+UjIX1qiHGQRPlw
         w66k+0bmTHKdUXtxHADE32CpSg/OYg2aEIKkqyks4DLVRDVRpbtnqJN0+HBK+hTg/zWb
         xP2TuOeiLtP25R3kbXZTDs2Eqod58bCyziK6XhuvYKrEBPQQsw9OreThrQ2/Zbxs8Xya
         HudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430508; x=1718035308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHg396P/YPGmHPltoeNdcR8nbSib0Fn7VRKw1/3Bd/I=;
        b=Ckc4XkZ4EY3DwKoGJPvE5FP2fNMk2RtNXJvWR5ozyRS+yfC5q+kvltPXwQy99aDTUk
         ig3iQptWcuNDZz3g1JeQWDUM3e9qX/4yA7//SGA9+/BrWAv59V8n8wO9L7beNALTQ4uc
         7Or6TzgypumDtw4nXPkzm7FpftwPn6+P9NlOSrtcdmetrSS6TuVlmxD0QzSLwLVtLUSu
         FK6MxbBMnr68+4wCWSU3UxI5zY0UK26kxvCIdnjtO/32CRsuuREAJeMVy2Xu1a3n0K/N
         zqF6Uki/0kZVqn3cYNHwpK2MdS86q5I+sA/1b89a00L98+ZUuASePZzAaBukKeNoNwYe
         qA6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDYs/03xih8t7JyYgedrc+RiqcZQ0Z9gkNIfqNTUTWrZDSTD6A4t7xOdMC4EvVuZJicIMbxnZ0HLeqEsithw1EB5zwJi3yuBIKvG1W
X-Gm-Message-State: AOJu0Ywyef7WtVoVVXWvnMcm3iPiw+gK7yyTOWhotf2ZmpBUgHeT7IYX
	Bw9vQx4QC7HLpLK+wkc5Psq93g7nObXXUPx+wce91gK6FEZzLcDL3Upx4mvxH08=
X-Google-Smtp-Source: AGHT+IEh0bsSS8vrUR6qGlubgu2gswrVKG0VaWjk9mgrZvBcWQaqMiPZX30yHAP4PUFkVCVnBMhSYw==
X-Received: by 2002:a05:6512:2024:b0:52b:9956:541a with SMTP id 2adb3069b0e04-52b99565636mr2481674e87.21.1717430507063;
        Mon, 03 Jun 2024 09:01:47 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-81.dynamic.mnet-online.de. [82.135.80.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bbbe18sm5487702a12.37.2024.06.03.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:01:46 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Julia.Lawall@inria.fr,
	nicolas.palix@imag.fr
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] scripts: coccicheck: Replace http with https
Date: Mon,  3 Jun 2024 17:56:49 +0200
Message-Id: <20240603155648.93989-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Coccinelle website is also available via https.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 scripts/coccicheck | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e52cb43fede6..9b6b29fb8224 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -11,7 +11,7 @@ DIR="$(dirname $(readlink -f $0))/.."
 SPATCH="`which ${SPATCH:=spatch}`"
 
 if [ ! -x "$SPATCH" ]; then
-    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
+    echo 'spatch is part of the Coccinelle project and is available at https://coccinelle.lip6.fr/'
     exit 1
 fi
 
@@ -233,7 +233,7 @@ coccinelle () {
 	echo " in $FILE."
 	echo ''
 	echo ' More information about semantic patching is available at'
-	echo ' http://coccinelle.lip6.fr/'
+	echo ' https://coccinelle.lip6.fr/'
 	echo ''
 
 	if [ "`sed -ne 's|^//#||p' $COCCI`" ] ; then
-- 
2.39.2


