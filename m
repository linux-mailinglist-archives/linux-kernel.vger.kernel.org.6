Return-Path: <linux-kernel+bounces-521115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8FA3B444
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BE53B5D37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566E1E2614;
	Wed, 19 Feb 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1mpJ6FJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C721DE2D8;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953973; cv=none; b=ERemHr3p483JPhN3/IP7b2olNel0ytHWoyAuDAZ4R363PYyU/iwfPO8DnetZj1gfH8+/+edPeylPODhk5K7/xBYyqyhw4FCuxhLHvBhgp4OA0i7rb4ApruvxgBhxRg0f4gNOMQvj/3rEDjyPN3xpgUYQkzXG/9dvvcGAFK0op8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953973; c=relaxed/simple;
	bh=pOTBzlS7I7jZeyW/hygW6cvMdWH+uYsFy5DDt8PknnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toEHYmhrAve7m9ky5MK+ZtqNuKO2C2bOrAZYGuWfP0T1qmNDmcjWT4Lk7nltTxBOfGY876/kS5YBzono6BB06B5m240zqMpuyk8d9pI67duZDmLY4ASDSbsN1EZoDZdCqMP8EHkbBjVPX1z+EuRZ3qG6jKh8keV3ngMVJwWtV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1mpJ6FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C457C4CEF0;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=pOTBzlS7I7jZeyW/hygW6cvMdWH+uYsFy5DDt8PknnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1mpJ6FJHxbUhASHnwQfWob9BvW5TuOYs/6znrgkEnCD6oBJXTeAY05PQnRqvhBF2
	 taaZ9/NFjIMWS/ahOwbsfK508IXyiViwOm5LSrDla9bdc5sNQZn6jPyedhZSuuOWZN
	 7gbAmU6ILUbM97LJx/gKOhVKm7/CCnGWqkKNaiCeun/RVjHGpzjbJqMTrNwDHGJa1U
	 VSlgCqJhENpB2h2H1a7V3SFZay1yB0Zfq912g+uXS+baaQTOrf2f+WutuyeAe4RqlO
	 c9pdn/cJrgoaXS6ViW/Qf6D586qdmPPPAQVnnTCa6cABf1gkAPZqyMGgP9PpBnXEqi
	 1a3gaz2a8cBAw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5p-2PeJ;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 24/27] docs: add a .pylintrc file with sys path for docs scripts
Date: Wed, 19 Feb 2025 09:32:40 +0100
Message-ID: <7cfc76bb53197582b1367976c08ee1364c996a42.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The docs scripts that are used by Documentation/sphinx are
using scripts/lib/* directories to place classes that will
be used by both extensions and scripts.

When pylint is used, it needs to identify the path where
such scripts are, otherwise it will bail out. Add a simple
RC file placing the location of such files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .pylintrc | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 .pylintrc

diff --git a/.pylintrc b/.pylintrc
new file mode 100644
index 000000000000..30b8ae1659f8
--- /dev/null
+++ b/.pylintrc
@@ -0,0 +1,2 @@
+[MASTER]
+init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi"]'
-- 
2.48.1


