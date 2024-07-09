Return-Path: <linux-kernel+bounces-246659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8972492C4D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB20F1C21C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FB18787B;
	Tue,  9 Jul 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dkcW2G9R"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E0185607
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557772; cv=none; b=C3RBXdEAhjPfMl9nDXCTFd4vojk8skuLMlG5yQSBo/yR+h8AUh1KJjPe8ySWkjBx8TRmUga8gCSjqeI2Ax93TjavNLIV2VDNCVlmgZtskUVrzWTbuk3gROW6kFdH0HVaLHuWyhcFB+9KfBbXfN1J+ROl9C4xbKylB+vm0OBQ/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557772; c=relaxed/simple;
	bh=NzFd7/N3dtVr8i5r6QNxUqTOXBxNxROsAYCor52Ghrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzFqX+vsgViE0CSdINFXjJiMwkeu9o7cCLMSONd+1uByg9sXcrcz1DTCS0eghKPZTSx0ork6hnE7LDH8hq19Jb13nlXEwVYcdC71raWmMQzdtmKuhgJla8hMSvCrpY0cMCh9jzZLHAobpiFER0U8ooAY2ug2Lbib6p3WcMYYUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dkcW2G9R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb457b53c8so36306945ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720557769; x=1721162569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IClM+nkNh3bQyMb1SpTr5S0Y3fVSw1KJe9ktaS1rz2Q=;
        b=dkcW2G9R0uxdWnZnyrbMHLHkBAvfmy84GKC/vFqTxwRk84nyU4wLYWSN9xviZNRPtg
         c1ZMHoJKUhKHGX8H89JHUZDBE0nWgdBz1Aj2sCQP5zGL6OGYILE2vcCxCmQtm/gx5e0u
         8dmGTeMVvqqvMpYM0l4Dt1UKimh4jhCtBz/4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557769; x=1721162569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IClM+nkNh3bQyMb1SpTr5S0Y3fVSw1KJe9ktaS1rz2Q=;
        b=UI9Pmoo5GCBBdjVhkKYW4vejchFMybnjGel0el9I/YpCAS3qskcldl8mPkIS6bUdHg
         cOCxdOCYH3U43+hdVhiwpXbP+qN37vWR9FUO9GlsHji0XBTY9j78m8LXoOdu6oqXgMjU
         uGcy7zvDWHAo1cQR6q7i8MaE4+NQqHPZSi1TRtKNPO6r8yj2YkjoOLLkXGNruqeYedmz
         rT++eSZKuOgVyxfo1TWovs9X8sKYpLXuq5XukTrMiZkDKkmylsFIIyh/LtpBfw/V9DxE
         ywYKzZNR8jMOpBMCU+FjxyTVmWjWaQ0heEmCvy/qh82vxb4fp1VBvEwtXBsq9l/URxCK
         5qzA==
X-Forwarded-Encrypted: i=1; AJvYcCWwUju2+snWZxm9nCwXeEB4FjohW4Lio/ORgtoz5VnmjRA3sPH9dlcWmLehnQS0OqiFswOc2J40vXmziZ+iJHLhAZMPKXZYvJU26BxM
X-Gm-Message-State: AOJu0Yxt7ZMiqzEqih3WPQvPcjumP059o3OGy0UgnQGXe9WgaHqFKi0J
	4uSN3Cxbt5T5huZ4NUgYw4In5DKJ+yokJfx8Yn4gbG+QJ3K53TaOZ3Tl1tdv3fO/4UnuS2Pi3gw
	=
X-Google-Smtp-Source: AGHT+IGoLgQUOgFZQ37HZfVJhxLYUs8U/Kuzkwqzf3f2LTNflHkGkZ0CMMSP3/cENo3kBdzUxltHGA==
X-Received: by 2002:a17:902:d50c:b0:1fb:5f82:6a5d with SMTP id d9443c01a7336-1fbb6d44060mr37343645ad.21.1720557769407;
        Tue, 09 Jul 2024 13:42:49 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:4d59:98c6:8095:9b12])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fbb6ab6d80sm20322515ad.170.2024.07.09.13.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:42:49 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 0/3] tools build: Incorrect fixdep dependencies
Date: Tue,  9 Jul 2024 13:41:50 -0700
Message-ID: <20240709204203.1481851-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

The following series consists of a few bugfixes on the topic of "misuse
of fixdep in the tools/ build tree." There is no listed maintainer for
tools/build, but there are for tools/bpf and tools/objtool, which are
the main pieces that affect most users, because they're built as part of
the main kernel build. I've addressed this series to a selection of
those maintainers, and those that have previously applied build changes
in tools/. I hope one of you can apply this series, pending favorable
review. Or feel free to point me to a different set of maintainers.

This patch series came out of poking around some build errors seen by me
and my coworkers, and I found that there were rather similar reports a
while back here:

    Subject: possible dependency error?
    https://lore.kernel.org/all/ZGVi9HbI43R5trN8@bhelgaas/

I reported some findings to that thread; see also subsequent discussion:

    https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/

One element of that discussion: these problems are already solved
consistently in Kbuild. tools/build purposely borrows some from Kbuild,
but also purposely does not actually use Kbuild. While it'd make my life
easier if tools/ would just adopt Kbuild (at least for the tools which
are built during kernel builds), I've chosen a path that I hope will
yield less resistance -- simply hacking up the existing tools/ build
without major changes to its design.

NB: I've also CC'd Kbuild folks, since Masahiro has already been so
helpful here, but note that this is not really a "kbuild" patch series.

Regards,
Brian

Changes in v3:
 - Drop unnecessary tools/build/Build

Changes in v2:
 - also fix libbpf shared library rules
 - ensure OUTPUT is always set, and always an absolute path
 - add backup $(Q) definition in tools/build/Makefile.include

Brian Norris (3):
  tools build: Correct libsubcmd fixdep dependencies
  tools build: Avoid circular .fixdep-in.o.cmd issues
  tools build: Correct bpf fixdep dependencies

 tools/build/Build            |  3 ---
 tools/build/Makefile         | 11 ++---------
 tools/build/Makefile.include | 12 +++++++++++-
 tools/lib/bpf/Makefile       | 14 ++++++++++++--
 tools/lib/subcmd/Makefile    |  2 +-
 5 files changed, 26 insertions(+), 16 deletions(-)
 delete mode 100644 tools/build/Build

-- 
2.45.2.803.g4e1b14247a-goog


