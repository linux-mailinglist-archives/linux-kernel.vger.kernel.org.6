Return-Path: <linux-kernel+bounces-528504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A4A41878
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36BE3B4F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8511255E55;
	Mon, 24 Feb 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv0+z3Nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEE24A04D;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=UY6cjCFZhKAtk+a4YXXkNKDniMVdliJxNjNVTGFWSXEcMqZ6GqbGFCzw0iUZSDeqoWfLat0WphzKTg/714pTMuCHGxKc5bnKDDNKr3jjBJ11X7zX+3HeeiWKYMf71aYsy+JnWEITLzEKk90wffesBIQeAljDvnyLaXSywMY4y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=NkNgWuYdW6yz0X6IJafkeOcfMUGHd/fARN30vGbl73o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4/WQsIFSYBiP8lckSQMBoxvCPoDMdUhWCLAItmffYDRDtKs88CR8eRFJZ4QnUFax+yUccNcGCGpRW7qsa7O1vjh08c33zmbGUHhPUyTtc3j/lxgZa/Dqa3GK6DyEn7QWHxmXrqAdiCG4IOrOg+p87hdNtAxLdPmhk+C8TThb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv0+z3Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABE1C19423;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=NkNgWuYdW6yz0X6IJafkeOcfMUGHd/fARN30vGbl73o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dv0+z3NxqRu85FfNj/0yT+ObMfjemzT+w5W/raZSleZBUW7IgcVF5Ym3tLvIUoLaD
	 XhbXf0EyO8QbzH0aSmU/Y9JP4085F5cUzI1msrGoWFIdEScIYhPnY8zS+d4G5QpxMI
	 c55JpqvqE01K+7rPKz5lygO4cuXd219zEkmgywY7rojOsXyjQhVYoAoS0vfYSGvWzu
	 4DLWcIm6FmG49y4gaoTJDjrcXMX/3RaepX5OMu3norGEZvwMxL4R/+J2jh/kH+W9kS
	 UFa5rN3Br5S75O3Dz+j0UE5kwg5sQcm1BUl22NbzeI733T/Nzp9ZjGzSeK1u4iMRXV
	 oxXLJJcPCXELw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p4q-1deJ;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/39] scripts/kernel-doc.py: properly handle out_section for ReST
Date: Mon, 24 Feb 2025 10:08:28 +0100
Message-ID: <166bb5d78d804371e548a758dfd143aff2077758.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
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


