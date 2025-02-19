Return-Path: <linux-kernel+bounces-521104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76293A3B43B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DAF1733A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1671DF268;
	Wed, 19 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ8Cz7++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FF1D79BE;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=gXO8dYMHourRZXlzA2Tp5qC660OX8+tqbwmrW3gVYBcxS2wB1U9q3KQUFNrO8VNMefcCUC2lV042sv3D+AobDznGOvePFM4hhBwTeuZAzhtRCglvEoOUtRYjc6L1pWOWA+O4rYrWNBmgt3+h4bSmeM5H0TwrOnjtzHHrV6Tb1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=NkNgWuYdW6yz0X6IJafkeOcfMUGHd/fARN30vGbl73o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io1fjB2jd29vezDKSl35JeBdKgERgshl8O7ObG3xINSjp0HEs4KPnAPjxnL2WF3tTvXZYuae/+Rp0iQ6Cf7ZarTgKzGmIPC3FvdG01/e09wpCw+kPhJOzM6LYhcEqnTpHW7wTeDiNfb2wsa9NH4CAZt3GYxrEze4xMjrrnJjTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ8Cz7++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67349C16AAE;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=NkNgWuYdW6yz0X6IJafkeOcfMUGHd/fARN30vGbl73o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJ8Cz7++Yjt3Ig9koGZyODHpnN6t2J1URjuM/m9BR8NAqW1mkgbYKZCg/QztwQvDG
	 N72YASEoYfL7BQz2D1BAacJ/J/NNzVZ26DiA0XyIgGDCSUCBg2cekvs1D4AK6c+XNW
	 DNxSAmorG5Sjev0UXRbTjbbpEgiq9/oRhDcbVH4nvHehPnUxJfJ1lVpb93XFdOfB/f
	 n9SsIn5qJ7pa/an2qc6GX0s/Hf6hqQ4JM+sYA00KN+Z659VHtU8T2ST+GtDoj+WEKQ
	 v/SniB3WtMNz6K8vz2OrjOlgYs/rW7tRWlpdoMH6jN8im9bkcU1hCC7beYVCOR9w9H
	 6tjpQYQigpgSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5h-2CAT;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/27] scripts/kernel-doc.py: properly handle out_section for ReST
Date: Wed, 19 Feb 2025 09:32:38 +0100
Message-ID: <9186a117f52b6875f61ec323159f2acf9a53464b.1739952783.git.mchehab+huawei@kernel.org>
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

There is a difference at the way DOC sections are output with
the include mode. Handle such difference properly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_output.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 6a392dad2e9d..ca21cd856be4 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -314,12 +314,12 @@ class RestFormat(OutputFormat):
             if section in self.nosymbol:
                 continue
 
-            if not self.out_mode == self.OUTPUT_INCLUDE:
-                if out_docblock:
+            if out_docblock:
+                if not self.out_mode == self.OUTPUT_INCLUDE:
                     self.data += f".. _{section}:\n\n"
-
-                if not self.symbol:
                     self.data += f'{self.lineprefix}**{section}**\n\n'
+            else:
+                self.data += f'{self.lineprefix}**{section}**\n\n'
 
             self.print_lineno(section_start_lines.get(section, 0))
             self.output_highlight(sections[section])
-- 
2.48.1


