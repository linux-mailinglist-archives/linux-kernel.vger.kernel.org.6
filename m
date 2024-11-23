Return-Path: <linux-kernel+bounces-418909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9079D6718
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9085B1615CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E877E591;
	Sat, 23 Nov 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPeSxUkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAA257D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732326749; cv=none; b=fqyp/wsJPGMUSxuWnLxT5slma8R+O0GbtHl3JMqIiw82KanC6RjIfSGB7Z97zcnPBsWk6X41kqEmS2ubzXriaStpKw07shzWZndIZx/atvyxeeVOGEFxI1Lo52NCnQJW9Hs0cUiQLgZeLnJYEo1ICMdq5MJNelZX7wSbeA8jmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732326749; c=relaxed/simple;
	bh=etybDNllEuKOnNeD8MnQD+WhUT0PGltH34riKYYCB5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLKbV2vNTM0NWXbvhFMD6Ykbn6KxtmxH5+J9HTqec/7vIzXuPXK9mKKxo66w0/PyqLl/93ientdil/RfDxjQHyC3bNtuYWVifzshw6Fz3hLWyl1KeklNfV+hRQDwkMDkogxV5aPDkJelxd/f6BS51CAVfQiv4tM5fJ8TcP4oesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPeSxUkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E990C4CECE;
	Sat, 23 Nov 2024 01:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732326748;
	bh=etybDNllEuKOnNeD8MnQD+WhUT0PGltH34riKYYCB5E=;
	h=From:To:Cc:Subject:Date:From;
	b=CPeSxUkSF+g70dm9GBoYOUJdWydFapRbist4921ixFNh8H2CHaB+97Y85s35ZZ+qp
	 hc0OBw2lHIBstL1VtdSa1vBgifWyg3RY5n3pjAjtPqXmWiOuRR5tlEQPdtYoXdiGB/
	 BzrgGybRUs/N69+15MMlbtzTU+6Gz4YDHcouQKFH42Xc9/94wuMMCq4NspGoMp4TXM
	 w3DNorxOkxsKjMJX71vRJ/9UayqMwEDQ1nA2Ae5t6xTCwedkKvNGUTEIg7Bx5i5uqe
	 KEr/1BkS1vr3O5A82k/cHsNZ0DLCdo5h2P83lu2itSZOifEYO1iOU48qbDyyKTcpYu
	 aikMakUrelqhg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] objtool: noinstr validation for static branches/calls
Date: Fri, 22 Nov 2024 17:52:19 -0800
Message-ID: <cover.1732326588.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valentin, feel free to include in your next version.

Josh Poimboeuf (3):
  jump_label: Add annotations for validating noinstr usage
  static_call: Add read-only-after-init static calls
  objtool: Add noinstr validation for static branches/calls

 include/linux/jump_label.h              | 29 ++++++--
 include/linux/objtool.h                 |  6 ++
 include/linux/static_call.h             | 18 +++++
 tools/objtool/Documentation/objtool.txt | 34 +++++++++
 tools/objtool/check.c                   | 92 ++++++++++++++++++++++---
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/elf.h     |  1 +
 tools/objtool/include/objtool/special.h |  1 +
 tools/objtool/special.c                 | 20 +++++-
 9 files changed, 186 insertions(+), 16 deletions(-)

-- 
2.47.0


