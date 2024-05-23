Return-Path: <linux-kernel+bounces-186871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C158CCA36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176AF2826F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB34C9F;
	Thu, 23 May 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBDA6+pS"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA54A19
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426221; cv=none; b=FAKIb5f+0CKCyaUgpd/Jfe+d1Trv3MVRZ6gE/wRNYiKAsVdQ3BNDR58Z3KjuGMkX6wbPiP0u3P8F+u5i0k4SCGRxe+6x6/OqPh79A/h6XLdzC2treOwWZ7MI/bnu/VP/ldIivlN8eHLfPcbARtIhXuAEpDA8BYTbVgkXHq/aMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426221; c=relaxed/simple;
	bh=X/IOIz8vh/undhlTqfN3gHn8QMDYPkM2PCYDYxTaJ/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TT0mnw3IK7s5PIxGkqb7plrWlbvMx+CJunHmaIYCJiuTcDTToHK7MppnTOtEw6dJuNjB4TME4HXQ9vQ0d1cHhRKTqHIYLJhzrZGsNdVR+Y93FwVmA6N6pptYyK9dHv5fAkN0KC+0ANY17j+hSXE+hDFfgojim7VzvAQr4TDX93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBDA6+pS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f693fb0ab6so2457558b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716426220; x=1717031020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZYl2zJJ4r9cHbew4LXkf1H38XyQAAei68+AApNGmeA=;
        b=SBDA6+pSmAVPNmmZW8eVWJ+5POX/VrZF00bArVU+Yp/d6RAumSajg1acHCx6RufbUz
         qNS1eH0IEGKAFRTvhwSWZzZP4DN1bdbFIqyzTAoYdi92X+EmPt3qnM4s6QKyNoBHxXEm
         udexvxSkYANIATF+1qpq8qNNgorgxBSvsItwXci0vUx56G0Goe5cDeTx/E9Y4/OFMov1
         K6rND/2+y/nY8Sm9cMHcPSrzix7KpAbBFbCtldUaiy5d/bWcWcQB/3D9/4MTrcEnWo91
         QzazA5YDEUt/CeqqZcTsVj3MmRsB0SgFMJd0i1hbHjmRdSsbIk/pD+GlGg35ci/EafBC
         p1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426220; x=1717031020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZYl2zJJ4r9cHbew4LXkf1H38XyQAAei68+AApNGmeA=;
        b=Mn4MP8NYjGrPUI/mumKSlPLKlymgCxPc9sOAl01yMHj7D9K/Xq2hmxv0i9qupAgksz
         74pt9LcstxWNrRAmMLjyzC2ZIA/bAMRaahjxnYQZ1MOoaXg1sDuCgGFHM12NpfS8tmgF
         XpPf/3Md1Q+F4G+Ub03vSs2h3FqEUniBFiVfMhugBiFsh566BbGH2NBJrxVMI6Rfg7PB
         KjDntY2ExgY6oHP359ZQisUQZAnYTYdU9qyplGR7z+47gOR3BonIDlBpNzRFpzVar/N1
         UY23oBNssnOUQ7hlrl+Ez7NEQti9inTw/40QyJ5BIO4p2AQ4dTLCzdrDb20Q5dH0HVO6
         uxiA==
X-Gm-Message-State: AOJu0Yz1Vf8U5B63efkhqGcHhjHynG6RjpWypOJ39NVakaDurZahkDT1
	GZsrZDJSxhEE0J9xBWEagLWqpAf9FKL+7xs2h6L8ljps0mRFT5H+
X-Google-Smtp-Source: AGHT+IHJJOLgJKwuCxuG6IOPx2nKACfo56zF7nXBiyWUTNJkNp/uCZeNo240D40ScnBLQ90emRGT1w==
X-Received: by 2002:a05:6a21:78a7:b0:1af:d044:1395 with SMTP id adf61e73a8af0-1b1f887f558mr4099675637.20.1716426219703;
        Wed, 22 May 2024 18:03:39 -0700 (PDT)
Received: from localhost.localdomain ([111.196.74.188])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d4828sm244348265ad.20.2024.05.22.18.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 18:03:39 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	Xiong Nandi <xndchn@gmail.com>
Subject: [PATCH v2 1/2] scripts/decode_stacktrace.sh: wrap nm with UTIL_PREFIX and UTIL_SUFFIX
Date: Thu, 23 May 2024 09:03:17 +0800
Message-Id: <20240523010318.12934-2-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523010318.12934-1-xndchn@gmail.com>
References: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240523010318.12934-1-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since System.map is generated by cross-compile nm tool, we should use it here
too. Otherwise host nm may not recognize ARM Thumb-2 instruction address well.

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 scripts/decode_stacktrace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index fa5be6f57b00..2bc3a54ffba5 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -30,6 +30,7 @@ fi
 
 READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
 ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+NM=${UTIL_PREFIX}nm${UTIL_SUFFIX}
 
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
@@ -158,7 +159,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
-		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
+		local base_addr=$(${NM} "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
 		if [[ $base_addr == "" ]] ; then
 			# address not found
 			return
-- 
2.25.1


