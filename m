Return-Path: <linux-kernel+bounces-257636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5749937CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6143E2824B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A3148307;
	Fri, 19 Jul 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB7DTclo"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B1383AE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416783; cv=none; b=W4QpcCpBPU4c+++cT5nHU+QZbI3LPcmCjHP6BQzH77O+L+icQ2Snu8cdjhtRbUFJ12OkGQojFvaJVZM+Uu6CwiSocbwDlG8m8GtZI2obU7AqC29G2E3mYu89MUTais9NXPuSb2dffxsZzZECHo4lonTf0XyVX6BvllYwe+xydPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416783; c=relaxed/simple;
	bh=eLzkmFgwPauQGZVcZaK/SPCAmIOt1kxVkchzfbCtLjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PWGh6Mfmj5xgT1yS51h0M+8ebkOWa9UyHQCMsh6nHUoeyEpyKQB0/jOLQkRkVoDl4Elsk3b2KTXTTwzGaaWsjG0v6She+G44E5SIQwvNSKl29teNmJCGb0hIZMe3y7g9RHej3lyyq9/JknuiP+ah7yQWRLEijktrkkoCwjyaD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB7DTclo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so1511407a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721416780; x=1722021580; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xr67dPq3inIYvgWnXjgECbHqLz3vjOh1UP/5FEOx4hI=;
        b=OB7DTcloc2Urf90+un2PYineY5kTP169Ay+XZRGHemnrCNhI1PntaLnbqZcr6ZWXQc
         5p5lxNsxYThJ2Nwc4dJTAH2OqjofTT4QlnYtsmmAM3BD9BGhu8+6+Jm8xh6UF1sWP1Hw
         F4gAM4TukHJcqQFAeFx/qIuqQGrTrkC0pDc0f5TjmvIA/XXGPwUpfVXue7x7QvVDrc1n
         OAIcVNFzQkcZSCeNWBi12cMML7rpIWQSghY76vNSeaPq7UmTvSVaZiYm+By3gwAoRKi1
         OORKuneHasPtKBcWy6nGbmMa31hvev2OH5bNqoX+MIfyJ0nwv1g+UlxKyg7Rk4gZNmKd
         J0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721416780; x=1722021580;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xr67dPq3inIYvgWnXjgECbHqLz3vjOh1UP/5FEOx4hI=;
        b=uicXcohRSk5wznL69pgTrTf/9Sv9b3kty9ObvPmbeF49Btfai3+PSYvzv2PQvF28qo
         rEBkysJ+Yh+omUlj4DES3jp8ygMzAfbLiE5bZ2Kc2bgKrYK0dVMnegQetn7fvRz1Thwd
         ega9FymwUoOGIppyupeNEtoQ3IRz2+vtMb4sVuXUD7yxBRNRtwM1pfROznm2DX0lrlWn
         F/nZNDUyjpOOS8+JaJQ2PEvBcl4fnllDXyQOv7bhZtAF6xCzJMjmuI5Y7DhumBCgVKZw
         l2FMCbQn8TjUTMKA4eqk1z4uAtjKfEfiIdkr1wNTetPeGUCsmBG0AIskXwy2yBr/7gNN
         3DjQ==
X-Gm-Message-State: AOJu0YwUYG8A6GMggLUgp5/UXt7CxU3Z0emPKtv3egMOzSTKqd5Fbr/h
	JnHyHnrxBgWSQ5GweZEzUEkC+GkDkmcht07qKeLgmKsXoX+zTtppjeb2
X-Google-Smtp-Source: AGHT+IFKqJBfi3I+iwdmOoR/cOWkIvm2HnKhm/LEVlXYNSWs2rWoDSVMUk72bOTM+6S0wFY7DmrYuw==
X-Received: by 2002:a05:6402:3481:b0:57c:6d1c:3cee with SMTP id 4fb4d7f45d1cf-5a05b7edf58mr8060800a12.14.1721416779950;
        Fri, 19 Jul 2024 12:19:39 -0700 (PDT)
Received: from p183 ([46.53.253.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa32bdsm1588090a12.26.2024.07.19.12.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 12:19:39 -0700 (PDT)
Date: Fri, 19 Jul 2024 22:19:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH] simplify container_of_const()
Message-ID: <a088c95b-53d2-42ea-9eb3-ae81fbd07c1b@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

* add necessary parenthesis so that

	container_of_const((expr1, expr2), T, member)

  compiles without warnings,

* delete unnecessary parenthesis,

* delete unnecessary cast:

	container_of(ptr, T, member)

  has type "T*" and doesn't need any more casts.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/container_of.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -30,9 +30,9 @@
  * @member:		the name of the member within the struct.
  */
 #define container_of_const(ptr, type, member)				\
-	_Generic(ptr,							\
-		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
-		default: ((type *)container_of(ptr, type, member))	\
+	_Generic((ptr),							\
+		const typeof(*(ptr)) *: (const type *)container_of(ptr, type, member),\
+		default: container_of(ptr, type, member)		\
 	)
 
 #endif	/* _LINUX_CONTAINER_OF_H */

