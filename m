Return-Path: <linux-kernel+bounces-319000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3D96F65D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF251C23707
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C61D12E5;
	Fri,  6 Sep 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+C8D6uC"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA21CF7A8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631875; cv=none; b=Ht8EfuUxQfxkNYNRq36Dox0zSb+Upv/NA4YeigKCwoY8JbquPweV4dhSLGEgHvm//qYoowVXQ5I55kD4p8LumafGdwyOcYDZscb3xX/PxFj1unJO5j+Xfoz/jBCPyCNEGYkW5beVtaw0RaQMz7+nctBV9exXpTbmvWEimxnclho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631875; c=relaxed/simple;
	bh=NJpeB18vKppi3sPR1bENr9hx4bGqvxj7rl1VDFXzZLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ncM4DhmumL93Pks8tlffGlxEqbxPQSaH+NzmMewpEiPreE8PwHBbvMeI+bZGpsYv+XEAT2/LO2rlzr+1bfu00IKyhySb0IzNY4E69/0DstVjub0CUJmSEZXGGEnfXNbQDp5rpgz2SKMGP405PPvr6BqI2lCAkm0Zr3d6oMWXXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+C8D6uC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d87a57c06fso296001a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725631874; x=1726236674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXB1DsCbeTuVjSg3/qsHRi4/y32gxxaca4O6wPKMbMM=;
        b=f+C8D6uCIGuiJGP8Y7cS4wyuFSIeiZn6Wwve04UQASLPKhZhi6zbbRCNd6hWqZDnwg
         CGTwoCaXNChLThLNL/LSEf7TbBV0yrH8i39PEopoTMQw1R/jh5q8G2AkomZywEssrPJp
         OxFntQjfPsbKwI5vA93yC1WGqoBDSyBnGVqlUIDJlDvPpG8BXYbnUM8V+b68372wOQzR
         MtvABc508q5UjC+DWiuh0zXHDhXADB/Y/r8SsTj91hmPzDFeJWkkSzEv1QXuYZtCZdTE
         5PFCwbFob/svWZ/Ap3MrH0PlLTkUW253Nk+CrC7W1u1mSdw1hE9WD2wT6/q+a3Qwk8xe
         26Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631874; x=1726236674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXB1DsCbeTuVjSg3/qsHRi4/y32gxxaca4O6wPKMbMM=;
        b=lNv4NLVsyAzorlAEKSmQi9eaWs3YY8YCN57IpIlYw5fd6J9KD1OXC/0c3LG/muPgAA
         +rC7S1ijYE90Vbdp9ZD6bbYMUP2RQvDShXWx1wFIzFhn6Ul2Yf6hpFTig/tnsHFK3dlK
         AiTLqYlt5lXrNZgUXGzTAk8ePLVmMn42WFxlAzhQtd0GePHDiWxSd3J61CzZ9kA+sOtm
         c3hzbO9+3jPga+lP1+n010Jit1hj8SsUz2+yrpZrFuNj4bbX0VfQOO/Cu+38EhFMVVcd
         RpdVo2UHacKVc3xqWQhfLKA6lz4IWfkhlj54srilnLdLWdGnR0/f/GdTRZACUdgJuZz+
         X4cw==
X-Forwarded-Encrypted: i=1; AJvYcCVV33nvywMD2Uy+07tfYj938t82PP2QsfMJOTA1+naWuouAY2qb5WbMtu5c4HMEEPNYQ2sfwznv1O16pqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4VJpr2eFqgNCx7Gz7WRQM7DP6OcK5fxwcAudQnHJchEFzjHI
	FFyNIDwwO8k6OWQaopQViXUujnsEKxJxRAEh2xLRpkJPwKFwO88p
X-Google-Smtp-Source: AGHT+IEC5jJTpGmBqCMU3EOh7gEMh+NzIQRwIxJ/mWCRsCyDqQmJ/k2CbFLhwLT+0uqt99odukmklw==
X-Received: by 2002:a17:90b:78a:b0:2d8:9f4e:1c3d with SMTP id 98e67ed59e1d1-2dad517f749mr1645704a91.5.1725631873516;
        Fri, 06 Sep 2024 07:11:13 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbff255dsm1589348a91.8.2024.09.06.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:11:13 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in rtw_io.h
Date: Fri,  6 Sep 2024 19:56:04 +0545
Message-Id: <20240906141104.10076-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index be9741a056e5..0ee87be6dc4f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -13,7 +13,7 @@
 	Otherwise, io_handler will free io_req
 */
 
-/* below is for the intf_option bit defition... */
+/* below is for the intf_option bit definition... */
 
 struct intf_priv;
 struct intf_hdl;
-- 
2.34.1


