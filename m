Return-Path: <linux-kernel+bounces-284369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0595003F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BE52852EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C516DEBD;
	Tue, 13 Aug 2024 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/a3Miis"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780812B143
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538751; cv=none; b=f2LNnPxQ1OrKsvz4DSppescG7itlQJJUye7eW5MezBd4Jh4nAroa9tTz4k5TRD+Ts3lkOkstT7ZUG+Sg/txN9oodDn3QsVEZUjKwAN5M2fLumRsDuB1q676IcD6EpySwWOI/0QMKn7pJ2yRisC/7q3VfytO2vgt94o/0qikIDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538751; c=relaxed/simple;
	bh=CR2g8kj2SBRFynLYDch9n8bWE9lSutWsWIVAthpcHto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ow5JCg871MsgqKIsT97YR3BDf6xoBhXJ3q0RjdlOl0Y27BeuDAbJxmjSOCI5cANjJvKkDkBOz7xi1o0eefohf31YZpMNjo/zcJUeZnXvjDbXbuGROUBTzHUmxvslqq0TJrMjGC8yn4uQXCBa3bLTcJmuM4I9yCQIAAsFNQPakQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g/a3Miis; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d1c1fb5cafso3425472a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723538749; x=1724143549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CR2g8kj2SBRFynLYDch9n8bWE9lSutWsWIVAthpcHto=;
        b=g/a3MiisGeHBvlk37KbmISW9+jyiVyrmqQXobHdB4ifKp6/X6j74cspjbZSBH7VXOj
         jnXFWwpAdmjTqyb/1RvQgZb87lVKV6WFdbSqxNhYWCYsdas/VbQZJsJP9axAwrFv0k8G
         Uplw4Kavk2eKeESuwVd9HVfTU5J61PIV3Fbdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723538749; x=1724143549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CR2g8kj2SBRFynLYDch9n8bWE9lSutWsWIVAthpcHto=;
        b=NqIT0ioIkQ3Vu7Aq2Ru3nm1S8c9Tz1ivhhAJRXv+ZKU6yxjeENAsLZJBv69dORUDdC
         OcjF6zYag/4ZiXJy6FeHSchRdVt/qSmoU7mzZy5+n25A74aEOC1Vcav2eNO8pXWiJlJn
         9dak/czjNLbi+wIVXywq1KMOfoTNikqEeqmmUIoWCDqyx/VOvxAJrM7APNgkTUgMiaYi
         3eTOc5q1PerN8xSARFNX8mTZg+zMVYAqi7o3BfxPhKCnQ13L2BmNnOVczBEuJCF78DQ7
         gTGFRbmGX2vPnKqA7LFh2U6EoLBIhEMjMtj0CrW4Osx8ndp4/VQQpGqX/9TXEDoaTJpc
         LqjA==
X-Gm-Message-State: AOJu0YypC+1D+MACl1AJE827REsyMtVzqUdY+7rneLwriXjYhJ8OrVfk
	ii4LU//KM/0OMIfeSGS8L1lrzBtiVdYG5tOKkzMJzCmkHeE6eBLouZBrJUqBBg==
X-Google-Smtp-Source: AGHT+IHytsK38cneSwen9U4altGRtjG/9jpAQldjecO1P48cC9ZH8XZB+shEB3jcJLhYgERdNP0t9A==
X-Received: by 2002:a17:90a:d90d:b0:2c9:8189:7b4f with SMTP id 98e67ed59e1d1-2d39264bf9emr2894538a91.32.1723538749272;
        Tue, 13 Aug 2024 01:45:49 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d1c9c82b6asm9894513a91.16.2024.08.13.01.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 01:45:49 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: tomas.winkler@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [RFC] Order 4 allocation failures in the MEI client driver
Date: Tue, 13 Aug 2024 08:45:42 +0000
Message-ID: <20240813084542.2921300-1-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I am seeing an inconsistent allocation (kmalloc) failure in the mei client driver [1]
in chromebooks. The crash indicates the driver is requesting for an order 4 allocation
that is unavailable at that particular snapshot of the system.

I am new to this and do not know the history behind the roundup to order
4 [2]. According to the sources, order 4 allocations are not guaranteed and
should be avoided most of the time. And considering the chromebooks
limited memory, this may become an expected behavior.

Can we have more details on this as to why order 4 allocation is
required? Or can we have a lower order allocation request that can be
helpful for low memory platforms?

Some solutions that I explored and weren't applicable/helpful here:
1. using a vmalloc/kvmalloc instead of kmalloc (Due to DMA usage).
2. using a scatter gather list (Would require a lot of rework in the driver and still
not sure if that would work as it would require changes in the underlying layer as well)
3. retry mechanism (would help in few instances only).
4. allocating from the DMA pool?

Please help in this query and help me correct my understanding wherever wrong.
Thanks in advance!!!

Thanks,
Rohit.

[1] https://github.com/torvalds/linux/blob/master/drivers/misc/mei/client.c#L500
[2] https://lore.kernel.org/lkml/20180731063544.25540-10-tomas.winkler@intel.com/


