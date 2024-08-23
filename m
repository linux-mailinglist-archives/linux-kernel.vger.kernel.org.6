Return-Path: <linux-kernel+bounces-298091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058895C1FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D757B22A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80696620;
	Fri, 23 Aug 2024 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSJzUSk6"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB98460
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371759; cv=none; b=gVQ36HQXxTlHEKfLbgT8EOboqFVaTEBcZGSrYTIHaIQ19qDgI0K+6mVK0afQJyRO7A/lj4Qx6yOVERN41SAd/w9NVfvzDOTH14x8Mfc1g7IFkX3Prhlrm3Whg+ZavaWKxN6gKHu19S4IF1lwXwOAHj4ttxqQ7X6zZhw5xL9CB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371759; c=relaxed/simple;
	bh=m+c/5MW45/tyWu35EmD+BgkxwEXyCv8Vzt7r3uTYj60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sX+g0bgDMm/Zl4aBHCbU/WKXtqNdAJEnQ8hIlDxGBZIdgMt4jX04QFXGO5S9BYz444lmeTCp9iWsKTLJ5JGlOYbfyj1D2BZCI+11jJ/+Nn02bPXvqIhfrKvaWaqiJbQ5seVDMK3DKuRAiTLCPzSHXlMg2n4qyjkZ+3DDepICXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSJzUSk6; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-202376301e6so11723855ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724371758; x=1724976558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhCLT7fR2S11sGpguefXbB0hpgKF8eSfcW6dqtZgfug=;
        b=MSJzUSk6QKpM8piTobsSY8TO+JHndx/M5v5eSQ6lmshOoG1fVXdL2TiA1p0AKThNza
         xCUY936XtBkKCXpn4DdoTMnMe1WCZ9RfeTYfvgp86NUkdZrDLLIcnImtDUt0Claf7gvh
         sN6DQoT3UepBGqjzm0ygBJccH4kXMR8g1eQgROI1YqqiCS9KkJ9SwDlelk4z9QcfVNGV
         txGc053LN4qX2DvyAhwrn4mBmkvat410Leo9ZUNl/ZvGCw0ju/m843E3QNYJvkmZVXD3
         KRJEqkxyy7X6RbqsNapls/H67zaZysw/d8ziesI+lgRAtwSnb7DfNDjujZDLM2+CCkAB
         CUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371758; x=1724976558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhCLT7fR2S11sGpguefXbB0hpgKF8eSfcW6dqtZgfug=;
        b=de4uvilj8vRIiDbSsJHSF+yZmdpTSYUuyZiAlibk9rJ5lFjz2Mw72pCU0KDWAfnzpd
         jPHUR+hi2aP81KbIpoMjdaqdVTcyxTgrK2wMh407hJNFF8vg0bQjE9fPifwPFHPr0drO
         KjPxyr+6uFTHAKUM8kkYEL+nbvO9M1ECpVLzJ22kigSKHmNa6AKxnauIEJSw8Gqpm4zY
         7AfIO2wfEIb2pBOwkMXrK+kL1QPPSCE9iWNclzGpubNXv8lDLcH+2DpqfXHyHrTZSEXS
         fiqHrzhIX+Rbkc8njQcPAwncqsxq4kCSDkW7v7Musu1kmD3a+/o6+iolLKobPTHUvbeU
         URPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUym2cZ+fq4Wr86d0G/xw/W/u0dCiEk4sOfcuAXYRkPmTJiDOqWPrxngf30mk2/a3aiR8lR6cIVR4ljMZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPqnoHmWzaeBGnspSF3GMLnzyZjKXGgtY88+f62//50Mxpzvh
	GNUcgTosEPMajzSGI+d9IGv8uDciIz2XtqLtPTc/QGW9SUdeoHZ5
X-Google-Smtp-Source: AGHT+IFVKP0+IFKpmm+pPMDqZRto/w6+b1WOU/Y0tqn8LIBH+hSIT45cGMirmc6aapcaVFhJ1lEtZQ==
X-Received: by 2002:a17:902:e745:b0:201:f568:b8fd with SMTP id d9443c01a7336-2039e50c509mr5104785ad.42.1724371757550;
        Thu, 22 Aug 2024 17:09:17 -0700 (PDT)
Received: from localhost.localdomain (dhcp11819.ime.unicamp.br. [143.106.118.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385608eb5sm17929185ad.188.2024.08.22.17.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 17:09:17 -0700 (PDT)
From: Gabriel Maciel Raad <ffunctor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2 0/2] Staging: rtl8192e: Fix some code style issues
Date: Thu, 22 Aug 2024 21:08:36 -0300
Message-ID: <20240823000838.8207-1-ffunctor@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some code style issues in rtl_ps.c

Gabriel Maciel Raad (2):
  Staging: rtl8192e: Fix parenthesis alignment
  Staging: rtl8192e: Remove unnecessary blank line

 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.46.0


