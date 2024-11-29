Return-Path: <linux-kernel+bounces-425449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C59DC239
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA292B22249
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0B18A956;
	Fri, 29 Nov 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpr+tsDl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5aVUdGFu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F50155345
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876670; cv=none; b=ZZISYoQmw1d6viVpd9VXdZ1kg4u8kisJj69QNVX+uXm4UJRXz6bREkbjfz2/ycAD4Ayk/bnlS8toRNFDaymkcjxHqyLqX9tOhvBWz9Xp4gLDWeBPurpMFoDLuWqSFeVMuWEJ8sY+GsDZP5qLeqGdRRlhdEV5u7c/zNAIWfsdWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876670; c=relaxed/simple;
	bh=LEus2PJFKI4j5pu2R+ziIbnBeTSKJP57qN+2HBSqPnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gj5KojvBmpJGa9TodFLbeG5Wkp/YdGTiAbtCZq8k5N3NQID1g1I+r0ThaK6eSkaulnmnx89HWSm0RLYGySn8m3iZ4Gf/uHTl2yz07YemFJHC2e1JLd4KNl4W6ilbOAV+8QYkEuTDnFv4MFq4zlB83O8nqD5u5ixIro2Ch0SXM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpr+tsDl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5aVUdGFu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732876666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=jg1Fu0r5ABcGVeB8iiheuLrbg+BYjk6WmGLrN3qa6QY=;
	b=qpr+tsDlTcmOpg55u01a9N9faGQxEr46U1z6sN9pIWN1QEtE8T7Zdoi2U18Z5MqOhS685h
	puRzJwZAzdsCuktmOE02yeGXaSyNQJuEx3hY34jPtGnj2/gJwYdlLQnFteFk8xQOYZR5nv
	qSB+iBRnKiBvb3qHFxNsVSIcZ9by6rNW4AabPyFOIyep+lj7SsWjYSXeDsbz5rFWHwTmJP
	/aD6yZ5qpE+9AsdaxnF0bY17+okOrOfGEnc1JNcPw7OIDBBqINbgcbAUVsVNy1mi81ey88
	nQnzA0KefgeH/HP5WKOQb9HBYqwWDktdvNZBEID2BCtRNWXJIVAHGcYi44/MTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732876666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=jg1Fu0r5ABcGVeB8iiheuLrbg+BYjk6WmGLrN3qa6QY=;
	b=5aVUdGFuboMcnClaT4SbtDnYOPLpI5pe3zZPlSkWYKBMWUx8QilGuKS7j3Ue1ejcgoXGVV
	rNI4l1FGAMpA88AA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] scripts/spdxcheck: Parse j2 comments correctly
Date: Fri, 29 Nov 2024 11:37:45 +0100
Message-ID: <878qt2xr46.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

j2 files use '#}' as comment closure, which trips up the SPDX
parser:

 tools/.../definition.j2: 1:36 Invalid token: #}

Handle those comments correctly by removing the closure.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxcheck.py |    3 +++
 1 file changed, 3 insertions(+)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -217,6 +217,9 @@ import os
                 # Special case for SH magic boot code files
                 if line.startswith('LIST \"'):
                     expr = expr.rstrip('\"').strip()
+                # Remove j2 comment closure
+                if line.startswith('{#'):
+                    expr = expr.rstrip('#}').strip()
                 self.parse(expr)
                 self.spdx_valid += 1
                 #

