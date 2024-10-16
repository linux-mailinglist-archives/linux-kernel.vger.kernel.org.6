Return-Path: <linux-kernel+bounces-366924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0999FC49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678351F21F11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2220100F;
	Tue, 15 Oct 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocnF3+jZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB02003C8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034244; cv=none; b=OJAq8hC6ExuEW1F7GJmQ04evg7YGOKPEJdDCyh1bN0dCk/PGWniNbuhG6IG6R7uu1TMH0q95HsHr0I96w7lzUrwN5ZKy0Hw/gMEN0SX73fpP9GnbnWKRwooUnqfc9JyL5d7eh5BAA2j5pObHP9EOi0l3vWQqf8CnJKXNMexOvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034244; c=relaxed/simple;
	bh=jjYUVOo8O6xgO1JMXuNPLyUgwBl2/CZLZSSP4VVGvZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QEcnXCYGxGFbT/XRuQ8uMxyfI2qfQu95vg8OggHNXz+JZN/mlDDfsCGEGBD+WaF7UPHQl8kij7UaxpbaVWO0QCgz0NcqiAdSF9VkIMgydABsE10ukMspSpEBTDhPmgRLhsEOgOauuN+cuT5qpyeDxPnS/IsOS1vmSDIi0XQIv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocnF3+jZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e315a5b199so83767497b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034242; x=1729639042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxByLhjkeevK1C1+d5cK3mr42AdVb5Xt4M/2ryRxmdU=;
        b=ocnF3+jZGm6iT9YXCIOB6bVD8Jwb7MyoSTGRkBLz7mUllxnrShwQFoCgN0sinRsc/F
         eoWoqahg3npSHRLDjBLSQ0VezP74RpxryDqwcLHuF6R9WJhfBOwUdrilPlAClpCI7ALM
         fYfKH9iIya147OtVBsj7NRorMbHOeKRbGDOKsSKxdhB7e/9xCfv/mNAKk52gx9nx8B8Y
         zja8cRnCUvYpHPAJostxXNM6Db8eU80rvV9uH77ijQqCqxF2hTHJUpfYdTZZ0JWKNegj
         ECkmZrDoLK6yqLCbrcYXGnGzN5NTkDFLD9AS4rv8UQCLR/0qSPAD7v+K7CdUo5VsvPfF
         RIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034242; x=1729639042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxByLhjkeevK1C1+d5cK3mr42AdVb5Xt4M/2ryRxmdU=;
        b=kVZZHMbMVvU1uFka/ox7je5eXog2GWI3u+t4FaJ0ztsaZSqbSZKBTrDnuZAyAleCjo
         iG8cZ5w5JDgpV7qYe+qJhYX/uI/k6je2CEk4in96jq1bk4XyJxzW/KOtgY+KTf6X7mMS
         tgIkD4zuMk7Cpp980u0dp6fndiKRq3te1B+Gc0+qbieqJPwgCOhHoOegslWxeGiB5d9+
         +uewoifSbvA/TOgxaeng66jTDdWh4WkYsfNeG3Pq93YWg3twSBneKB/PXp7rPpST9WP+
         2SjjJgfA8wOJ5Ds6v3i04ZucAIfg6muuk6a+Q89CMZN6vcZgPIxdKSmH16KUe3nqBuGW
         BghQ==
X-Gm-Message-State: AOJu0Yx4HG5n2f8cvWOapJ6ItB6uW6eQshD6o+fyMqXFhSK76GEpaUlB
	2ZM1VnI9C0AlV0tMrdRLIFGL7YL1qJmnjGkQAxgL94SWqQdt82Lk3WZhtZJJLFd7evOqqsgz+cn
	KS22UeQ==
X-Google-Smtp-Source: AGHT+IF56C+QSLsngMnwtUK1W1CaxTzGVo4aC5OUnQ07RdsmKUeWwVjXP9OEcZk8DuforTmZRqhlEuXncnap
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:d614:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e29785a421amr1470276.10.1729034242400; Tue, 15 Oct 2024 16:17:22
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:46 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-13-mmaurer@google.com>
Subject: [PATCH 12/12] module: Reformat struct for code style
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Using commas to declare struct members makes adding new members to this
struct not as nice with patch management.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/internal.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2ebece8a789f..daef2be83902 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -80,7 +80,12 @@ struct load_info {
 	unsigned int used_pages;
 #endif
 	struct {
-		unsigned int sym, str, mod, vers, info, pcpu;
+		unsigned int sym;
+		unsigned int str;
+		unsigned int mod;
+		unsigned int vers;
+		unsigned int info;
+		unsigned int pcpu;
 	} index;
 };
 
-- 
2.47.0.rc1.288.g06298d1525-goog


