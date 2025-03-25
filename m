Return-Path: <linux-kernel+bounces-576307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A8A70DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A9F189F855
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762526A0BD;
	Tue, 25 Mar 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpglKHxe"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB741EE03B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946734; cv=none; b=MFkWvu5/mdPin/PKhlQXd0zlwzibMpy+APS6OTkp8bG7Qnlu237fFO809u2s/j5UHBbj+nPOjR4SGimYdJgg4JWlLeJBWmlwYjiF66M144LBHVdY2IyUilUa1r0pNxa4cIfWsgIQ/YMG+sN0Afrfy3i57JdQ/HdQlnbTsmvVe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946734; c=relaxed/simple;
	bh=spJWwOE7wjjtUn9SUuIF5rq2nt2VG4zb9iQID91tlm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQsCD/0RB0vwyI8TyVM3NNKG4fQeFdyyXpwxHhxYv5tFxrl+MShudYqQ7ARmiTvP0hrGZvoiLSj0jI5SrQikJc31TvuzmH+7YtFUKoSkIJ9asgrQtYbxnINLP5U0sDhST7jTXtOYUI4QIPwlKEn2NpEiFHtzGPGMmrD80ZN88/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpglKHxe; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d59c8f0979so1134985ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742946731; x=1743551531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy8HlVpes5VQ4yH1mrVBD9iBkoCttWz1PBn7DQDO7kA=;
        b=WpglKHxeEEhrVj19OMqQPxKKl34fpMxTwl1VH8zGJvh9TJ0SDQmL9064H7XOeBjO+Q
         nMfRiED+1Q95k+l64Z98qLIJeydrY3Jzj728HAe/jjf8WdNIsiXaJCbPj6nmJ12sp+DQ
         WBR+Tw5S0mjr2Nzz5DN/obB8d0upcQgTlCmZyWVidJTcf4IUmdQnIbWR7RCnDkFGhubz
         hWeQI4Ascg5UAAnpT2mMjeVwnCHgURK3pt+sVRileCzriIFsUS3Mbi7vJ4xGqCQ9Vzu7
         U14cUXHo/nfDdMydWUzBE6yl1D6kxSLItSEqmbZpcmRgCv5EXhs4GRTR1zmUsFt5vp7G
         YCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742946731; x=1743551531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy8HlVpes5VQ4yH1mrVBD9iBkoCttWz1PBn7DQDO7kA=;
        b=IPYBKeGzrrwy/z860Bkvdp3IiWt35qQUyZYro8uiH7a+oc6O0uH03+s552m3xZ5tDb
         0cSqEp4O4am/brpqSPuvgnwZ97nbofRkmxQcz5Q5oTSp//W8tSer3VDQ7d7MA9D9IXNw
         3IxYdt4baA8nFb98LUZ5jDpIGhmk9xIG15w3drm5lPdH1peIzR9bjG0Dg43reGhB6Dwe
         Y5gXEq9Phqx7DY2bA0LiQyfR7A0l+4EesuE4eTSYqtLZoQkhEPapvPrYdna0ehdkyWND
         3fjfZhPn7Rdt9WQYGz1k/VRyKTjfWOhBbjPFGNA5ZRBzpzcH02tdkPrTgOHxwJtFyxqw
         T5ng==
X-Gm-Message-State: AOJu0Yx2m5P7uu9nkz0MClpgInHFqiAMKiKImATjq6J/SiUEU8W10hDL
	uFJKnSIyT2fA10hsP2tBYTqF6FZLssJOX3ho5paIVFOHcV920WCpw5L+3tdi
X-Gm-Gg: ASbGnculSWFAl1tJ9xa07HKuzenJoyb1CHqi8pyNiOHGYf4W4D+8+wM0EyWDgMv85U3
	i9fxmuVGkI5/+RKHhuRbvqx+3th69L+b2TS9CAFiE5p9NghD+WJd/K3paD2/dLpQK4KtiaYQxFh
	rhuvSGLhnjPDLt45qFY3doTt3VJBGkOS/gVMuG2PJKm/0rd1fIDKy+jhsL1nFQ9SNvBwS3OJgGS
	5KjgWn4o+iojXCi2+n9poDrkvbGEzksW1RMlwbja7Pa5SADxgPvC+w7beusPNLr0cDQ9jz4LGhu
	T/SP+vl9duqr5Gfl9z6X+ZqrcWO/GfSATnAQbsMoZ674PNGgDT2BA6J7ZR/rnUwnnRe2ALQ6efe
	zlcDomBRH+Qs9
X-Google-Smtp-Source: AGHT+IFO61P9y6KQs+V1aA5gKjrSumsx1CD2lYJNfTRxe8JwuSNOKhUbkxRFgLBLZ+ZG40FakvTINg==
X-Received: by 2002:a05:6e02:3207:b0:3d3:f72c:8fd8 with SMTP id e9e14a558f8ab-3d5c21f790bmr22256845ab.6.1742946731122;
        Tue, 25 Mar 2025 16:52:11 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d5960cea10sm25191175ab.45.2025.03.25.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:52:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH 1/3] checkpatch: dont warn about unused macro arg on empty body
Date: Tue, 25 Mar 2025 17:51:54 -0600
Message-ID: <20250325235156.663269-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325235156.663269-1-jim.cromie@gmail.com>
References: <20250325235156.663269-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

we currently get:
  WARNING: Argument 'name' is not used in function-like macro
on:
  #define DRM_CLASSMAP_USE(name)  /* nothing here */

Following this advice is wrong here, and shouldn't be fixed by
ignoring args altogether; the macro should properly fail if invoked
with 0 or 2+ args.

cc: Andy Whitcroft <apw@canonical.com>
cc: Joe Perches <joe@perches.com>
cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Joe Perches <joe@perches.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..0c4f578ea6e7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6037,7 +6037,7 @@ sub process {
 				}
 
 # check if this is an unused argument
-				if ($define_stmt !~ /\b$arg\b/) {
+				if ($define_stmt !~ /\b$arg\b/ && $define_stmt) {
 					WARN("MACRO_ARG_UNUSED",
 					     "Argument '$arg' is not used in function-like macro\n" . "$herectx");
 				}
-- 
2.49.0


