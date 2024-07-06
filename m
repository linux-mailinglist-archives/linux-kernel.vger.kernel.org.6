Return-Path: <linux-kernel+bounces-243038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EB9290EC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3AB1F22F8E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDA1C2A3;
	Sat,  6 Jul 2024 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="McJeecHS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DA18EA8
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241816; cv=none; b=u5vF5plZwbBqRERH/ik1MrGMBj0CUSR0mufZW+nE0tvodcN38SxOuBv9JVdcT5Wc35mmaJJ5RfjxucgF6vSTBk/CFAGkdpk79h/7Ge6nNIG/RUqlM4oiBV0EZ7OE8YZ+xhADpyBkgaFD77gKF2Xa0R8jcs/WHIS7Cq1+isYFwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241816; c=relaxed/simple;
	bh=TW8IWpx+kWbsEG+EhKN0puvD0sZJLuyE33r66GzEHKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPJ3WCg2Becs6/NbHpNFmBevTqU1svBN7J6rvU7b+a53cki0CQJ4Xv/Rv3gkvhd04HoztnhYT6BGilYqSUuQJrpMDLzE5SIwtiYAGnDOHPGplsWlqFVlt0bgH8KklDzefWx/3uPLi+2qUJr/Dmv9XnG3CSjJsZG1fulXrv5WFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=McJeecHS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70af81e8439so1840316b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241814; x=1720846614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FXjjKFQQ/AAI7tVJvwr6gZnCUjSgAdFHQ4h4smS3cs=;
        b=McJeecHSwVF1yv8VIpWxOJqxNPb44hm1IKR0u+Vp2iIv5CIqwVojRmWMT/s3HhDnkt
         HqAgeVu/573/X98Fd4dtP4HCUHS2hipNEQiswsnvrmCNJ46tg4tfXO6YXvJt9OmqCrdX
         OEAer+tFK6eb+XP+pW5akf8/PR2MrVFI3xV+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241814; x=1720846614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FXjjKFQQ/AAI7tVJvwr6gZnCUjSgAdFHQ4h4smS3cs=;
        b=M2vDd+tH++6oPRY7Dv+RZLaCNAQ3p/T424yGZtyb+rGXV7ifK1lxUXdObJAYApj3gm
         C72HN7S1SnE1rRhmS0nkxOZ4P+j7xSPw+vNwV0upHa8BI/2lbmfJz1k8JVEYQq/AIM8l
         vENBtL8mbQ0VHvve4wLTiaAH1x7mK/yVR8E4yDpA7PYTvifP8a7mLL9TqSw3qQqSyvXz
         2xm3NIdKweZbD44nfHmKKDOoqS7+gURfFgVKbthNe6BMVCkSzFWCoplrORrBwi4SCL5T
         S33V3uR1NY6MUoArLQ8x0FR+EUiZkBFZJk4ULKpFtJ2pMMUCJcsUuaVZIokxID1Q0c3+
         TP7Q==
X-Gm-Message-State: AOJu0Yw8qatF3DH0jXKsuze5wRQ4cwxqLLRIpbwpvQDv8/BzBNvAh7H6
	TokvkuWpE4NUvjO/vV63g0C7qJH+03ooSjKjm4VdFBlbZJiUfwRKAqcPiOVdww==
X-Google-Smtp-Source: AGHT+IG1uu9EeufS7V2p8jG+wHETC2wQx4NYEmGYvO/CDixqNrUGPN9y8xNRWmR8SgshWuZeDtrZ/Q==
X-Received: by 2002:a05:6a00:3306:b0:704:37b2:4ced with SMTP id d2e1a72fcca58-70b00945e6emr8066889b3a.11.1720241814560;
        Fri, 05 Jul 2024 21:56:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:56:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv5 02/23] lib: lz4hc: export LZ4_resetStreamHC symbol
Date: Sat,  6 Jul 2024 13:56:04 +0900
Message-ID: <20240706045641.631961-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This symbol is needed to enable lz4hc dictionary support.

Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
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
2.45.2.803.g4e1b14247a-goog


