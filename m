Return-Path: <linux-kernel+bounces-315132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEB296BE66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C89E1C23801
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550931DA116;
	Wed,  4 Sep 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7+hnL2K"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57B1E884
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456316; cv=none; b=IYkHzxsg/q+U649vOfZS78raiw5S4cm81Pr7pRGEJlf9jjTNs2IVzGtLi6khJYAdIlmHxEt8VdN6jnJGGu41Rnc8iQv3KLlEBg/d2dQ2Lyr1MOovxOXMvJdAVvD2hATtoSq5WAEQHFQh5cCwK20W1h6STrlqsXnvURPFFkNYLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456316; c=relaxed/simple;
	bh=MGzKiUuF6aRwv2FnLvUfpLtjHzOPaPEhLyKQGDj5NDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEDk/CSwEXHY1LUvul41oeM8RLOpSXcXsmcW+FLFGjhOnHrGal91PEkYiaGCa34fCxk0eCke7Y1/AJs6kryusdvQYWd3piStE+nOHdVSPAWC/Unaacmdk2/twIN+i/8nflePS/7atKKy/envs823S7HnjqN588TQ2Pia4AbZxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E7+hnL2K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201d5af11a4so57398785ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725456314; x=1726061114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vez2uwjb3KfOIizr+O/VqkIHsnQ4z041y0eIN+7scOM=;
        b=E7+hnL2K/kQSI2rzGuO3pybJZ4wFHkb7N9dxWUDvBxT78WxaYMycnufvIv9uXszpFu
         Jk21uIAnipjm82oMudr0PDFbs3iS8UoYVgZMrWrBgeDCf3Mxud7uomcKt+aUnA9nsIYe
         M1Cb6ny6Mm7Lo0EyXvRQiaJA6knMP+xFxuNvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456314; x=1726061114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vez2uwjb3KfOIizr+O/VqkIHsnQ4z041y0eIN+7scOM=;
        b=u20uIN7iitHU+P41m2ClhT9EGORiVRGI62WWXV4xLJhIVeMp3LIdvSYlQrrnQwE7sC
         wKAu6ijJ5ZNjoJDzCv0RZDgNW1RKfeNKM0nKRwcMJpBfNIJPcAwknuupHKzGmyt6MdeK
         MgzlfnC9rcaKR7c8PQ9VEuKG+QHnHhA02F/xw2M8Tnv6uDILWzwHrpI4SzKv6dbUbj7z
         lw+PeJxrY3EWrP0AfLzwqYiLzmqlDG0g9TcSSg4FQCuPzY77lbHOS0UBAyAuqvcpYiC4
         I6WWpb+jxEIZCtzKNxi9t4rc3HoKWhwZJCekQA4jbznoMTz00rbxMHbf9oiHCkaWhMHr
         hlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpfTIDSqbtw6Vxd0Nm2V3/kMbeNWPGPUJqRuiOCqf3mTChKw3gGZPsOgXcElQ+8hfM7yxtiLa2en9fC1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGts4U41aQU6IcOS2KR4KJOCwyKYpRcqCf7kHfe25P+mS1tiK
	wwSHvWrldMdaY3uLoFqUxEFL+qcxtnrrFKxOHDOdASc7C8TybrqyTZ4OSJ84lusqEPMNOGY9pnO
	eMg==
X-Google-Smtp-Source: AGHT+IHQ4g4Mjzq1OK0YWp2/eDeBjiRseJd2eOQGRsJzJrb5nrIbO5aJyleq9KZO40CG+R+Vrw0KgA==
X-Received: by 2002:a17:902:f547:b0:206:b618:1d7f with SMTP id d9443c01a7336-206b61824c9mr22864235ad.37.1725456314517;
        Wed, 04 Sep 2024 06:25:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4132:a2a2:35bc:acba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea54e7bsm13479215ad.183.2024.09.04.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:25:14 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 0/3] zram: post-processing target selection strategies
Date: Wed,  4 Sep 2024 22:24:52 +0900
Message-ID: <20240904132508.2000743-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

	Very early RFC, literally started working on it several hours ago.

Problem:
--------
Both recompression and writeback perform a very simple linear scan
of all zram slots in search for post-processing (writeback or
recompress) candidate slots.  This often means that we pick the
worst candidate for pp (post-processing), e.g. a 48 bytes object for
writeback, which is nearly useless, becuase it only releases 48 on
zsmalloc side.

Solution:
---------
This patch reworks the way we select pp targets.  We, quite clearly,
want to sort all the candidates and always pick the largest, be it
recompression or writeback.  Especially for writeback, because the
larger object we writeback the more memory we release.  This series
introduces concept of pp groups and pp scan/selection.

The scan step is a simple iteration over all zram->table entries,
just like what we currently do, but we don't post-process a candidate
slot immediately.  Instead we assign it to a pp group, we have 16 (in
this patch) of them.  PP group is, basically, a list which holds
pp candidate slots that belong to the same size class. 16 pp groups
are 256 bytes apart from each other on a 4K system.

E.g.

	pp group 16: holds candidates of sizes 3840-4096 bytes
	pp group 15: holds candidates of sizes 3584-3840 bytes
	and so on

The select step simply iterates over pp groups from highest to lowest
and picks all candidate slots a particular group contains.  So this
gives us sorted candidates (in linear time) and allows us to select
most optimal (largest) candidates for post-processing first.

NOTE:
The series is in very early stage, I basically just compile-tested
it and ran some initial tests.  It needs more work, but I think this
is the right direction and it all looks quite promising.

Sergey Senozhatsky (3):
  zram: introduce ZRAM_PP_SLOT flag
  zram: rework recompress target selection logic
  zram: rework writeback target selection logic

 drivers/block/zram/zram_drv.c | 287 ++++++++++++++++++++++++++++------
 drivers/block/zram/zram_drv.h |   1 +
 2 files changed, 243 insertions(+), 45 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


