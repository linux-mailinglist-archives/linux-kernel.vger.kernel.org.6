Return-Path: <linux-kernel+bounces-264297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6444493E168
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 01:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E8E281A42
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0141C89;
	Sat, 27 Jul 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR7SxPhQ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4542BAE5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722121608; cv=none; b=XUeStwlRWgfavfsED7A4RK+7PDsUyXvNZAl5x1wEfRouDU2sVOUumTgcrxG4tmPp7eIQHTjMGPApVrgtfr5zaxZCHklOYQh9pP2FsGcWKaaVuSGNQdTJYb2uY1s7efmwFAGSSM9py4/octGg25dgD45Do3tnshLrBH1Gs9sJjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722121608; c=relaxed/simple;
	bh=SncpMYOnc8cu83KnIdF3oD1mKmSZK+qNANc/LrfPR/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ti0Sau6AVP11AsnJ7ChHokvB5+24mupDDnji9e9UgEWKWg8t3vofH44YQRDfnY8B6mQdSLblzLnAO1b2ID2sfhfMwN0eD5qNgOoKUKFI3qV6E1DRMB1+jbLo+93hv5fDusDuxrhN9zAvu6TxjflDHE9BEs+Sjco12mXw2VjuZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR7SxPhQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd640a6454so15333875ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722121606; x=1722726406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asRqtKXsywbzrAcCEkTYZ9u01rG3hLmaFH3A9iaCAfM=;
        b=dR7SxPhQQfKGnXo3O9u7TDV9rceU/+JStmmRZKt52wnzvardi+104ROPQfxN4KBMgh
         ofjkn6kbI5pzI7PCLK+6XBc+l3RqXTlLDa7I6QtYYfHXRBcruvJuPeRnpkixHxp40wO3
         LPi86iCJBEL71JTHolDpIuV4JHRxFrjFFD+M0UfaDDLUoe6zESOEUD+cO8gH5/Z1p+yp
         PuUz3odS5Ou886oUTRLh6XZgEix1gLdXvDzHW1oK+gCFYGmtnkSVlUPzQfSMHf+p8JeA
         013YONxxsZ5MTdCG5RC6e2POvwbRSGeUOgO+R44kwuBr2oX1RKixeTcuI+AQn6LMbDdZ
         Uocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722121606; x=1722726406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asRqtKXsywbzrAcCEkTYZ9u01rG3hLmaFH3A9iaCAfM=;
        b=irwf2zd50xRt444D9ZTvWXRIxGRWmT6EC6idQpFH+ruB6W54cwCsUH3LbGqgI8IeiC
         b9MiKijTiyI7BFk4o1ADZaB64MMwpat81PbQx1QhvRzZUKP/8FKGHv4bE5ytnO4SnIUe
         lKgYBnWYRAUkUfEQ3raiJVU6D88Hw2C1Kpd+TO3H9nVVOvSJN5/Ckuy6QOqZkVtokkQE
         JA3gz1HFsgk/01aA8n6owfYZXakR/Lbbf7tOK6bskG1PnQXP/FOS7SJSBxNcCLKQaxW0
         9oADdW0xKbvDiF8jemCj0dCE0lNYSZePbZI8gOfVCleafTS/HVBG1XTVR9S3UYYmRYNu
         dXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy5K76Ake1+dsNSPut8Pm118iYKPFu4z0ZZGTMKAQ2SkiGtGs56j9zXxpEB1gIYfGYiWr8BGzMczFPxsKcH2cLNNdLlSNwitLSGNSJ
X-Gm-Message-State: AOJu0YyJmjJ7baKLDYVCjlx9jTIwF9OrGJ8wClAWIpznuD6o7KnzlfKk
	SL2TyhjNMKk4dQWfGqKiIj8m8maDgUCVpN8eePB54RHYyRoMp8uO
X-Google-Smtp-Source: AGHT+IGbZwKmuPAl4mE+aNxHvQx+qP16j9O2vdoVqtxjnkCEpqYfTNptOeMJddk0zlMom2lADyZlbA==
X-Received: by 2002:a17:903:2302:b0:1fc:369b:c1dd with SMTP id d9443c01a7336-1ff0480893bmr36504385ad.6.1722121606234;
        Sat, 27 Jul 2024 16:06:46 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f274a7sm55881145ad.209.2024.07.27.16.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 16:06:45 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm: zswap: fixes for global shrinker
Date: Sat, 27 Jul 2024 23:06:28 +0000
Message-ID: <20240727230635.3170-1-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses issues in the zswap global shrinker that could not
shrink stored pages. With this series, the shrinker continues to shrink
pages until it reaches the accept threshold more reliably, gives much
higher writeback when the zswap pool limit is hit.

v4 is for cleanup and improvement in code formatting, comments, and
commit logs. No behavioral changes have been made since v3:
https://lore.kernel.org/linux-mm/20240720044127.508042-1-flintglass@gmail.com/

Changes in v4:
- Updated comments and commit logs to clarify expected behaviors (Yosry,
  Nhat)
- Merged duplicated spin_unlock() in if branches (Nhat)
- Renamed writeback attempts counter (Nhat, Chengming)

Changes in v3:
- Extract fixes for shrinker as a separate patch series.
- Fix comments and commit messages. (Chengming, Yosry)
- Drop logic to detect rare doubly advancing cursor. (Yosry)

Changes in v2:
mm: zswap: fix global shrinker memcg iteration:
- Change the loop style (Yosry, Nhat, Shakeel)
mm: zswap: fix global shrinker error handling logic:
- Change error code for no-writeback memcg. (Yosry)
- Use nr_scanned to check if lru is empty. (Yosry)

Changes in v1:
mm: zswap: fix global shrinker memcg iteration:
- Drop and reacquire spinlock before skipping a memcg.
- Add some comment to clarify the locking mechanism.

---

Takero Funaki (2):
  mm: zswap: fix global shrinker memcg iteration
  mm: zswap: fix global shrinker error handling logic

 mm/zswap.c | 112 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 30 deletions(-)

-- 
2.43.0


