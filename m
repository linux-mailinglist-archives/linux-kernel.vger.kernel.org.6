Return-Path: <linux-kernel+bounces-446261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB809F21F0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1416A1885AF4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEA8F5B;
	Sun, 15 Dec 2024 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="shnKfspR"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503C6FBF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734231123; cv=none; b=qM+a22bstWfJkTXkvNHRJL27Cb3/WgSyiGquMwj/wZpYvrx8371pP4YH7Yf/3fL6XQCav6HfD5xY0o0Sn2WKEg/Ts6hFg7bTjZ4UDtT34wCNg0sm5ZOushi2mGlaxYoMn94i9lNezO4hZGVQS0f52EbDlavEtBSev/v9zgx40ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734231123; c=relaxed/simple;
	bh=Abp2yU01ROfzDCwkYgb27q0Q7Zs3StXU83KlGFHms0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMD1zwVjkXzPjKFbVRMa3wlHam8BjEgYSEX1rnSbozFoq505hdJgJ5q83zY50RBmEKlI9ZJYVMzYi30Q75KSL0RRkbC8wZt/4y5xwl8LmfEl/uDMMXSv+ak2SINSvPaaoM3UxUjMLnE3EOHmd+S1PY53BhNour9DiLDfNEtHKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=shnKfspR; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de [5.147.80.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 489FE405FF;
	Sun, 15 Dec 2024 02:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734231109;
	bh=hbfUstOhxfuMshI74HEeb8jyNAJBmxUBHYUUxO2zJ70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=shnKfspR2t/Ht7Aw5GpclvXqwJBBMEU1fzhbaUaavMFbmM6QLz0CsW8LIX6/Mwdvv
	 0hJvhEUYEU5WO0leu/Ul/jZfRoEPlv/S6R6ztYPeHrUS8S77BPofkqj4mxw3viE/o2
	 WYT+fRs0llhxlgjAALKdn9zaeNlO62mt0SvqMeGYmh0Aio+IPOceGhCEzIeW3D2wQa
	 v8jqpEvM3OW9LhNCfUtzieUcYMwhXDNAZZp1GGxgOIPfvhc4Cva8hp4e/mtrS2N9Fy
	 rccClrAtjc15floijfmCURJ9xR8gGjERczeMnjA8woKOdVCETAmZYKPX6TfDf5nMZC
	 e3rTe+4ke/DOg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
Date: Sun, 15 Dec 2024 03:51:02 +0100
Message-ID: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct SPDX identifier for the 'GNU General Public License v2.0 or
later' is GPL-2.0-or-later.

Checkpatch.pl uses the misspelled words from spelling.txt both as keys of a
hash and as part of a regular expression. For usage in the regular
expression special characters like the plus sign need to be escaped.

Heinrich Schuchardt (2):
  checkpatch: allow special characters in spelling.txt
  scripts/spelling.txt: add GPL-2.0+

 scripts/checkpatch.pl | 2 +-
 scripts/spelling.txt  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.45.2


