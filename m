Return-Path: <linux-kernel+bounces-181467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDFD8C7C68
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EB91F22525
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB715FD19;
	Thu, 16 May 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tr43CFx4"
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4415EFA8
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715883593; cv=none; b=kGAts0RTr/t27jqOgDlGtOUwghZgS+IKN/qK/UrmQA/WgIyWU3nUwxyRNp3DLF2SJeQY4x+/BnztJzXNO+jPZgzooppBG3BEqWHYJIOUn9FDWSqW3PdgeWTOEy0eIGfK/vDYctnnDCQ0eW3Q5lgM/EcEYbtf1gqmP83/7QOFIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715883593; c=relaxed/simple;
	bh=8i+81HfSMQ4B+34PJVD+1LT4BhQy/TedwCa1JhBidyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N8V7mmpMcbhg22B21dfEvs6n9rtkuntYSx5w+V/X6Gf9W+SlDWhhAiYd+/PG7LLz5lN6roawrL7W6rav/jz5swkQnezz14CqhtWHJmzntP7Ku81MnDf82h2XO0aGrajPd4yPj08IcxNIaAWMhXUSy+fM7Zt6ssrOiS/rQSZoLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tr43CFx4; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VgJKF5ZDYz9xx;
	Thu, 16 May 2024 20:19:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715883585;
	bh=CerPzP5dUgudtzxZqGbBjChoGejUpjLgIsX+ii7FKE4=;
	h=From:To:Cc:Subject:Date:From;
	b=tr43CFx470rjkCLy632XfxFwcR4DuopkPnCccYyTMlCqEqvRu3D6NAgjmeB0w25YG
	 3HAJ678i3/sRVhh+u0fgksy+B6pseiHVVsdtnSCGaHeD4w+MEtbz5ZUck29ooSbGTu
	 ygFce8B0cvrv4EvaPwk/WHewg3X6vt/QqooQFL4E=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VgJKF1bmxzdsH;
	Thu, 16 May 2024 20:19:45 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	nathan@kernel.org,
	ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com,
	trix@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/2] Fix warning in collect_domain_accesses()
Date: Thu, 16 May 2024 20:19:33 +0200
Message-ID: <20240516181935.1645983-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

As found by syzbot, there is an issue in the collect_domain_accesses()
function.  A WARN_ON_ONCE() can be triggered by processes sandboxed with
Landlock and trying to do a link with a mount root directory.  This is
then not a security issue.  Moreover, such directory can only be created
with the open_tree(2) syscall by a process with CAP_SYS_ADMIN.

See https://lore.kernel.org/r/000000000000553d3f0618198200@google.com

Regards,

Mickaël Salaün (2):
  landlock: Fix d_parent walk
  selftests/landlock: Add layout1.refer_mount_root

 security/landlock/fs.c                     | 13 ++++++-
 tools/testing/selftests/landlock/fs_test.c | 45 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)


base-commit: 5bf9e57e634bd72a97b4b12c87186fc052a6a116
-- 
2.45.0


