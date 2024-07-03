Return-Path: <linux-kernel+bounces-238932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4130C925383
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F021B283E1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9153762FF;
	Wed,  3 Jul 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ZM9TjA8n"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D03B1BC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987132; cv=none; b=udM8w3ULS5P8xUK7XQOPIM8bHefFTcaOyXXniuOTFpQIGYI0SRS6NLPXPBvaPMguf1ywTb0DaQaR9Ay461EBUr1DbKNwc2tIgqN2SYDH1OTx5xu2Sk9k89qSLWQf8rSx0n5vZju5QGsv5msdskBXy03I+OLXgmY9sWdfgZxZD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987132; c=relaxed/simple;
	bh=3J99y5+6OxbwcKwAHIcLAKi5CZ2ycbqsCw8ezkKjM80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVsRzdRoNHwekPjRa0mF2y9A74fsqveNFWReYpYiv+NuW2Nd5iER6yujarE/vzRhJeRt2YQJhHmJqe5u+YanoHEd1VqymoTFQVxyjGTXiEzAq8itaZmsIE6P0T7eg6D18hQt2EOX5ThDINYvRbI9Kmdh+xHG7Mm8U1d5aitNZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ZM9TjA8n; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5197904276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719987129; x=1720591929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YgzDReIaUyz8u4XHHLiy/BwQZOZxxkCv3LtW0SkUnc=;
        b=ZM9TjA8nvdacXOC+i8jV18hP312AcUixvWRcDGa7PG288hGgq9BuqSACT7NHNFXAsx
         bPZiy9qykcnRjP3Q8VVlO4YiizNsWwOgbl/Yx8WTNvdCFd1d7dGRMA++8aMZHonB8mpK
         M4R01h7b3L1TBGLv1SAP5C+gjVtaRuOcZritfHoptPXih1SgVSnFT4H2Rju2QbSlcjFD
         BbDpw5woDX+PVrKSpeoW7pdmAfB7Cj97YNScln1KcqC7LXgQcA4JuJuEveiUTRhgi7Ut
         X6p6L3jvOc0St6SpkO6sQOYfOnvFB+SzGzudJH8GsuH9fmORQJqhZcTneeY4QnqMr/Kf
         kMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987129; x=1720591929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YgzDReIaUyz8u4XHHLiy/BwQZOZxxkCv3LtW0SkUnc=;
        b=bRT1U04rhCdnHT0nNZb6sjlaR6uekP4upkJIoamDwh+4QHBIqjDSXa6GMNcB0lsboc
         JjCQUzgtriRNZCRmkQOI0OftXxjFXMyxq0JteJy823IfW0gdx1gq9hOOJfwUmxeutexk
         Jl9TI4Wrna8Gvahrxo+KfMX3OmU1rVNY+S9XP/GvDERZr1uF7TY2M6ciOMIRLwuZozmw
         2cIhirQLQSBpSdVSBsMlPEyYW4crkiM1UsqO1e9B62KIzpcZhkiKyxoZkx6uuOORE2PV
         1UYh7EyYsh8r3cbGEFU5jHnmHtxe4qBWYMhZzT+Hp58yBHGNkHKSHFVFLRJxkUgE2nEd
         9DaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEWVX4XrKyxX++WCYjk/NGU/TGu0hbNhmEPlW2dqvz9zo+Vr85n+KoFcTnZe3p9cY+qCG5KMp5eWnBxNV4b/X0NCOuUE/wt7ofMtpz
X-Gm-Message-State: AOJu0Yz0ztw4qjK6gFmErpwfSdcZNuT0ZpoelH4Rd1Q80MrA7HuwruEg
	hrYEXZwm6fFXnw858EIsPibt/a3HVKVDUpz8CsDlN87hF39sERmvZ/t1JTpzsxk=
X-Google-Smtp-Source: AGHT+IEYwaFScpXSpfOjk0NDboyzDAX10kkBsDpozYzsFOW5+JJ9NVaivETucKRFmAX9S49/+mU4Bw==
X-Received: by 2002:a5b:9cf:0:b0:e02:b7d6:c97 with SMTP id 3f1490d57ef6-e036eaf633emr12008074276.8.1719987129659;
        Tue, 02 Jul 2024 23:12:09 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbdfdsm7531927a12.29.2024.07.02.23.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:12:09 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: samuel.thibault@ens-lyon.org,
	tparkin@katalix.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] l2tp: Remove duplicate included header file trace.h
Date: Wed,  3 Jul 2024 08:11:48 +0200
Message-ID: <20240703061147.691973-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file trace.h and the following warning
reported by make includecheck:

  trace.h is included more than once

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 net/l2tp/l2tp_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 88a34db265d8..e45e38be1e7c 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -61,7 +61,6 @@
 #include <linux/atomic.h>
 
 #include "l2tp_core.h"
-#include "trace.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
-- 
2.45.2


