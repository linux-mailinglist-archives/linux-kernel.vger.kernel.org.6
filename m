Return-Path: <linux-kernel+bounces-231506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3AA919951
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B49B235DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6691193098;
	Wed, 26 Jun 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD/grlT6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED5183083;
	Wed, 26 Jun 2024 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434379; cv=none; b=jhBNPD54fnpoPQPVa8bB2tReXfyj+gb+gYh2tjUFXFKw4fH4lyJ39WWr5PctNR29kaO6qzL8D8nHz36Q3Njc42PEH2MZ4Bgu82LlK2iSGXTYnHaiDoPy+yDtH6v8Ya4es6CvUbyOlXwlOE8aAuSh78ahZ1C6Q6LWjcYsaPx3cmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434379; c=relaxed/simple;
	bh=/9W3G49m6A/qb2aig9tVX/75zGdSbXbe9vL831wbHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJoHH0jCA1WEb1aufXU5dJ4UYB8l39U0I4Eg9yXceXyrSdtmFTypK1NcLLTqDSJei1N1HW2UHkzUz8WQ6keLaYgTvxDyL2PK/41HOWsMq71tcNGMbGHz8cjG8UBT6jJcNrhyIEiXXpH3ToZuFLb6fRbaUkHTWgLEdg1Hq6a2y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD/grlT6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42561715d41so4569965e9.0;
        Wed, 26 Jun 2024 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719434376; x=1720039176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E5szASgFFa7et9hf6JKLTJ5flysbwDYJWoC3WWH5W0=;
        b=XD/grlT6cJdcz9UvuLg/uJ3ptlk5+9Z1aub2dUvyXmX8/EsI0gvkGUVRm+Q4+3eiag
         cH8RxrnBw8PIxNtOjW19qzJ/Hi4RU6JhqUC4gZ/zVEG6biPPpQjJR1xD3cCfByY7yKX0
         X+57K7XRSe7vPLh1L9yQp+4JlYqs0FOjC72fDS6PiykV4pDx48Jv2le4g8JRkxKaxZh7
         isnCdG66Nr63MkdyxgBxEckV00s2NKySXn9AGNpSOjUNSw7OuK+q6aRuYD8dcyiWiZkx
         qe7Q+f4G0+G8SRnkvR7uSXtgcKAxB3ZrLwnIEvdjb80XOqyrtOccy28jLG+p4CU7hKXo
         ylvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434376; x=1720039176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2E5szASgFFa7et9hf6JKLTJ5flysbwDYJWoC3WWH5W0=;
        b=PLilv2KrirgyttYhRQ+prcD2VsS3DFm3uqtr9bSuI0DJaGtFbVT2CJpqN4AwQDr3KT
         TuSqFVQOCcOkD6AwTfSnwb8AK7O0Y4RdC00+NP8S8gYT0qze5UXKJ2L+Dgws3z+aReOj
         Q/3MLXtzy/pZoHBJcIuTGjJIFm7L3jCM9d8LUMWZfzCIkPkkNTiqLR4/YR868+3mAP8b
         XdE4ngmyOG4zLiAtqaJljmxTvF4Q+s4tIKwSs6OOjLPA41Ucdzc/Y6b53O/a/8mHtSPA
         XJgcdV5rvsB60ETB1T+IpOteOqnAhS66j6LmP7n+EVeCzbNaZEeMadpa9ez4etxlUUkC
         Llsw==
X-Forwarded-Encrypted: i=1; AJvYcCV2rBU1kRs11L9L6Vgo4/NTg5WvrJbWspmxzPAf6CTGbhRCvPtCn3wV5sq117hgAJ2PF4WUkcGqXBtDn8DPfycsiD6n3Rbdk2+83OS4
X-Gm-Message-State: AOJu0YwMsNvc97zQa24uG7TnUgDrl9SS3BciFDqfbLX4o7Wpbngm5G2r
	pcrpP3KtQTJw1OWqo2vJCOJ2uGcw8wNzHV4i8W0nW0TamkGpCt/jH/SUEd0XDI8=
X-Google-Smtp-Source: AGHT+IFKDR2sUT+AuFSaaRTVuaMId/3tR6eXb6ySb3gtXwcPNSlO+mrqxdZ1i/9J453D4BlGAorIMA==
X-Received: by 2002:a5d:4e0e:0:b0:360:9500:9bbb with SMTP id ffacd0b85a97d-3673cc55d87mr706365f8f.12.1719434375678;
        Wed, 26 Jun 2024 13:39:35 -0700 (PDT)
Received: from seskpc0236u.linux.cat.com (static-dsl-173.87-197-126.telecom.sk. [87.197.126.173])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3663a8c8f50sm16661946f8f.109.2024.06.26.13.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:39:34 -0700 (PDT)
From: Jiri Kastner <cz172638@gmail.com>
To: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	cz172638@gmail.com,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] Documentation/tools/rv: fix document header
Date: Wed, 26 Jun 2024 22:39:06 +0200
Message-ID: <20240626203906.191841-1-cz172638@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626150727.156397-1-cz172638@gmail.com>
References: <20240626150727.156397-1-cz172638@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jiri Kastner <cz172638@gmail.com>
---
 Documentation/tools/rv/rv-mon.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/tools/rv/rv-mon.rst b/Documentation/tools/rv/rv-mon.rst
index af0f329a7c9c..4d86fd55eb59 100644
--- a/Documentation/tools/rv/rv-mon.rst
+++ b/Documentation/tools/rv/rv-mon.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=======
-rv-list
-=======
+======
+rv-mon
+======
 -----------------------
 List available monitors
 -----------------------
-- 
2.45.2


