Return-Path: <linux-kernel+bounces-175389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FEA8C1ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AEA1C20C47
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A2B15E81C;
	Fri, 10 May 2024 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaNLUooB"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7A15D5BD
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325289; cv=none; b=lg2MQNjA5sLx9g+aK1a7Y2aAEo+OijS1km9fxzqt9gd/TFa34wq/afJQHg6y88fIuWUr1j4DIPzAEkAmo9xSoiqrkNhxSrZLDQhydxhkSpJ6eS3CdszTYR6SXygIdAHHxxOFm6ACbfAM/60BqNGlQHwo8jedLJJtedPw52vR1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325289; c=relaxed/simple;
	bh=IJE6I+L6sV1tOwrRV3nyPourpfWqjB+7lS7uGHq+Jn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEJz814CWjAyBGnjEg8WcQQwNEerO4V+t1VoGjCseWpDGI357eyXG26y8vmph1mI7Hmypo4RHkwpI6jRIi2YS4ZhIGinBwJpbGVCYZJfFigoN/M9liBlgxeLNRIe9b35cr0xlVolyp3CwedzE5H6C5iryfUgXYPiEM1XKy40v1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaNLUooB; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c99aec9598so47691b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715325287; x=1715930087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBBXTUCIRfYLCiHAylYDUKwve6DKLHYgX/TaH/xLMbw=;
        b=kaNLUooBSY6DPh4lwunImzEkAK7zEyJzTZ9FutcnDCUQROLWi2jJDFB7KiA8/4IQNr
         X496Itc1afkIfDp9Cc+5lbpQ5lxaHpT5jcdxi5m3WVjlidUv23MJuoNZzms+AmSANgY7
         JOj4gLJqCpVVqdA76FGUWkbOVeLEJGSmLw5aqITs+P55vz0IFeu1wi8yMWMov84UgUPY
         Qh9U7wW7iw2jaTKqLEF9zRb1UuR0IkNZbWTFXGTNbA9QrajIo/W567mf42lTfyJNgppj
         UarCGTwfXq6DVkqL8nqUB+B7ab5Y1o522z2HN7MNr55NS10aQ9AMAjIgF+WLcei8ZLYM
         c03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715325287; x=1715930087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBBXTUCIRfYLCiHAylYDUKwve6DKLHYgX/TaH/xLMbw=;
        b=NbybyOICNKwVRtjnwT7nK1KMsjHJoM+bhpPToeHEw2fb7DGO6NA9llsH/zvD7Bv7Gx
         0jTvhtt6oJwslNB/1V59MmZ0lAGFtKKgQBcMzjPX1mPJ4SBZmJ06uM2tKcpWJLiJBe2e
         hf8F+VIdDaJqq9Zi6SUOnnMionchViRkTy1HJb97sDOIa1sPscqIbBGTWy+CFm0YiczU
         OJQUZZZDj0Kt+havvOznqeJIK21HCka2+5IOIvlieNRiKIXBofXMMER+rZNIN/jjSAfR
         UTfvsXCNFx21bpSAvcJ/Z5pKqC7+1+qREGbqq+UzPQGob6BScRnU59QgvhrRlM3693s9
         TyiA==
X-Forwarded-Encrypted: i=1; AJvYcCUuc6SP5tcHcmHfwgkuH1GJdxmQ15dE2Um1NQUl3yeBoa1G3XxGsbaSAsOCObxTQ5BCY28ncZVv29XAXk91/rIj/GM0y46JJeWTG5Bw
X-Gm-Message-State: AOJu0YzcdimH8bhxsLyxX5AvzeCy8tyILbL2mlhWKWK4O8zcf01er57g
	9gI3MtMeqW/d85TmrtkyFmHahX+9Jngg3YnKpmWNPrbglEcAmRa+
X-Google-Smtp-Source: AGHT+IHlSQdtKY3w8KFFzE8nXqqdD2fjH2uqTRUc+/XMV7gev5lp9kn2AH7hGAvIHMPiQ+L05Gnfbw==
X-Received: by 2002:a54:4086:0:b0:3c9:9424:9318 with SMTP id 5614622812f47-3c9970cdb18mr1879132b6e.45.1715325286648;
        Fri, 10 May 2024 00:14:46 -0700 (PDT)
Received: from kousik.local ([2405:201:c01a:90f4:8de5:a651:7145:5260])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a37sm2344475b3a.161.2024.05.10.00.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:14:46 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 0/3] Use scope based cleanup in drivers/soc/ti/
Date: Fri, 10 May 2024 12:43:21 +0530
Message-ID: <20240510071432.62913-1-five231003@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.8.ge326e52010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do scope based "struct device_node" cleanup in drivers/soc/ti/*.  This
covers all the possible cases.

Kousik Sanagavarapu (3):
  soc: ti: pruss: do device_node auto cleanup
  soc: ti: knav_qmss_queue: do device_node auto cleanup
  soc: ti: pm33xx: do device_node auto cleanup

 drivers/soc/ti/knav_qmss_queue.c | 17 ++++++-----
 drivers/soc/ti/pm33xx.c          | 20 +++++--------
 drivers/soc/ti/pruss.c           | 48 +++++++++++---------------------
 3 files changed, 31 insertions(+), 54 deletions(-)

-- 
2.45.0.rc1.8.ge326e52010


