Return-Path: <linux-kernel+bounces-322359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B34EE9727C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D71CB230A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1253914EC64;
	Tue, 10 Sep 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex3xqeyB"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325804430
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941048; cv=none; b=MKArEaiItjA7cvTF5ueWBs10O/iXswPYadjuUGoPv+bVzJ/4B0Mn5ZFlxdlPh0vvBpDR9hGoXnEBvgrfaemhP4OJw3qbZMF4pHfNmRferU3GFq7Igypy1VZin6+7oYTA65B1jYX/AenvAOx7pMnrtY5HFWlNejty+vkpGIuIAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941048; c=relaxed/simple;
	bh=/gJAksFgmw0XJca2LxIhCdD460NHpee6rWYJ2Mx9jq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ujXPQYd4FaoMPld8u7tFFHP1BJAeHnN+WdxhNSUQF0CtXgpfjHssFthkaZET4oTktHdBCvJ9izXZomcWeuTCz54X/Vouuk2OJnPOCFTYA95uAC9dlKC0tHSfiLPwbkPTp0FFd6Ja57lFA5mes3Yqym9HV9chx1FbbcYKyjuFdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex3xqeyB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d5058819so344532b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941046; x=1726545846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wedlIa7uUfPhH/VbGYP8ZCH9iPIQwhmTlK3bFiNPCr4=;
        b=Ex3xqeyBwFMfdHUZGiKjM59lLo1pC6HIkEXU8jQpX3lZxcNPbM5iFt5RC/ovANR3+8
         y8LTomMhFw184fDTK/tmihyudROhQ/Tel8oS87tyBmRJb10D7mou8DvnZSrXs40zumY/
         siZBtbRGTA2E3BRzJ46aQZGgLdSXAKSu6ilHmqWoGNjAIvyq9O6uIuV/qUEGOY58aOAo
         pGVS4XdlMIWMKcrffzCCyclQMuatk6bxuQPo0Ll6Y2e1fFgOURtaiGpmpzdQwVgykvJ4
         NQqswpqs4LvzWZXHpA+472ujHguyuuzjZfXlr5n5ihtWwRaRTxtaUOdyp+3E3wJvoHR0
         W1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941046; x=1726545846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wedlIa7uUfPhH/VbGYP8ZCH9iPIQwhmTlK3bFiNPCr4=;
        b=Fpy1FPZg7L3IHRyCvTdIxYETMPNGCq05tyBSnIOO+WyzSyHEq1KNoIhWr9HxNFYO92
         O2dYxymOJqJ5cR5YqmFW3G2Ru+sOWkyDBe4BxKPLuuMkQ1EVnueQZP8gP016m41dhhBI
         wZpX4WbR0n18u5yFwNtYMwVsGaYwZ/gKrLGS756JKIsxQLSXeBfIBFKTjiAieDQTLXeO
         3BghQ5N6HiE2j4gDQdElw7EkaLIDt+TiaQTB+GDeo1/t+ABGRQG/HUbqU82IkWcURjmv
         Er/avuOavkSl3CzvmIn5V+QQ5SecSuVNYBnz0Iiw9G3ZAKnCrQOJ8kTwaaz8ph0tVtQL
         93kw==
X-Forwarded-Encrypted: i=1; AJvYcCUUsyemsd4QHrlkYH9y85nRamQvYKwGUeFdyKvS7NsNaofQkvQbb5sqEiT6b80nRj/zRbQxRZ8Ui9v5mcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVfSkBT7q0KqUCBNHNLaQF/0zSUr1yRMkObjYFvprKlkJzh46
	PIl1JrQxMTFDSKj0rsfwmI8gfrWaW0bfj1/jReYanckjCVbceBTq
X-Google-Smtp-Source: AGHT+IGRuF82h+ayxgwhBkurm64jexmcAas2NnpDXYe4MXsPsNlz3EwcHAteMIGLIA64it+lErPW4w==
X-Received: by 2002:a05:6a21:9992:b0:1c6:bed1:bbd0 with SMTP id adf61e73a8af0-1cf1cefb853mr7113079637.0.1725941046359;
        Mon, 09 Sep 2024 21:04:06 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095275sm471902b3a.129.2024.09.09.21.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:04:05 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] staging: rtl8723bs: Fix spelling mistakes
Date: Tue, 10 Sep 2024 09:48:45 +0545
Message-Id: <cover.1725933169.git.topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes various spelling mistakes in the
rtl8723bs/include/rtw_xmit.h, rtl8723bs/include/rtw_io.h,
rtl8723bs/include/rtw_mlme.h and rtl8723bs/core/rtw_xmit.h files.
This patch series is created after receiving feedback on 
individual patches.

Roshan Khatri (4):
  staging: rtl8723bs: include: Fix spelling mistake in rtw_xmit.h
  staging: rtl8723bs: include: Fix spelling mistake in rtw_io.h
  staging: rtl8723bs: include: Fix spelling mistake in rtw_mlme.h
  staging: rtl8723bs: core: Fix spelling mistake in rtw_xmit.c

 drivers/staging/rtl8723bs/core/rtw_xmit.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h   | 2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 2 +-
 drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


