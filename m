Return-Path: <linux-kernel+bounces-179571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932828C618B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44051C208DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA807581B;
	Wed, 15 May 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTXAM2h+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C44745D9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757464; cv=none; b=JX0pXeriJ62RdUpJtF52p36ciUrp0DMw0b/iNFIzon4y+3ooYX78lNY1/XmqoeTBg2+LKIlWcyZ5AmglWkbdaTwjN3hhlaN+LUdkpQRJjbsqhNtzVzBI1OgdAx8tDJXJrqr8GYXp6LZtBNt01WI8LGuJNLZFxrBAf85mWv3t0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757464; c=relaxed/simple;
	bh=vwOiFI5WYyrjHytmKrfcWdUOay50C5Amcx9THlRsWqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyhfop7tvfpvZpowVdbMpidzqELghpLXem+G+ncL4B8v+849V/zS+wnnQobSVWN6swXUOin2a3L7ScBRUftBOcqQMDTu7Da+5foQ1jF39LsDTc+ZVUiwzZgUiWug7jLdauwcegUNHFGJtSUyDoC0iBOZ6VLo0wZJc9g9cZIw1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bTXAM2h+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f082d92864so16528875ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757462; x=1716362262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWMx/siR7FY9UCYUHf6j2VRPjDt1sZ3YrZXGDzQRlXs=;
        b=bTXAM2h+GhS9bRINMcGOldAw3OpEZEMGRHDRC1FifNDeNhfo3OJYmzpJGHaWJ8Ksei
         Hu6WsJeiWQjcqMkIPGu2YoDWPxzcytREKOZun2lRdj/zdNs+5ZWnjI27UPhX+RGjon0H
         X3vaF7/4KDKSRsiBa9CDkRHtUT8I5PcTnLyL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757462; x=1716362262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWMx/siR7FY9UCYUHf6j2VRPjDt1sZ3YrZXGDzQRlXs=;
        b=OcZ+Z8qghOcyhjk4jCH2djveKAClMGhRf4TnI2GhRzkVJ5vVC+5GYZ0c1H5VPhMC1M
         M5NBU00Ts1GlSQM/hzdL9iuL3OJqPwhZwGQ0E3hII4ep1DGKHYXwxpvvOjQVN6k6IwAM
         mU78qbP8cloK4TGn426PrlOZ538gHDhMlTCjXxIRNwO+MzaN2p54nBC99aYsjfaEklWA
         l+lRGrDDrPrsuelv/xQXkIM0z7EHZ92+T/9Sr5iVJS+AEdFFTLf2KTH355K0mgp0wvd8
         bDDuql2uf+yEo/bCiVZyXrRtopoqQiSsya/AHvFB9cO+qVuRrP8nSrnfmcAvPjS8fj5v
         0WfA==
X-Gm-Message-State: AOJu0Yz1vRYSrIwuBBO76RzMNzg04dh88A3DtHI67w8STrcJbzl6cDQ4
	jsvFDVa46Hpjbij5OnYB7Stbx846V2omtPRVY+9FmqcfGAbQD9o1gY2h+oOptg==
X-Google-Smtp-Source: AGHT+IEAZvvWI3L3dp2OnVta0kR0smXesfqE4//K2Eg9tSM/PQOb96+KhvywxjLh/WRSanjCEV8rcw==
X-Received: by 2002:a17:903:1209:b0:1eb:6477:f2e3 with SMTP id d9443c01a7336-1ef44049595mr180248885ad.49.1715757462340;
        Wed, 15 May 2024 00:17:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:42 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv4 19/21] lib/lz4hc: export LZ4_resetStreamHC symbol
Date: Wed, 15 May 2024 16:12:56 +0900
Message-ID: <20240515071645.1788128-20-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This symbol is needed to enable lz4hc dictionary support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Nick Terrell <terrelln@fb.com>
---
 lib/lz4/lz4hc_compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index e7ac8694b797..bc45594ad2a8 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -621,6 +621,7 @@ void LZ4_resetStreamHC(LZ4_streamHC_t *LZ4_streamHCPtr, int compressionLevel)
 	LZ4_streamHCPtr->internal_donotuse.base = NULL;
 	LZ4_streamHCPtr->internal_donotuse.compressionLevel = (unsigned int)compressionLevel;
 }
+EXPORT_SYMBOL(LZ4_resetStreamHC);
 
 int LZ4_loadDictHC(LZ4_streamHC_t *LZ4_streamHCPtr,
 	const char *dictionary,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


