Return-Path: <linux-kernel+bounces-261998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB13C93BF27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2869B1C20BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F34198821;
	Thu, 25 Jul 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="faaRbZzt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5F197A95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900178; cv=none; b=Q5nv3JWB1p5HmgEIKJTo4mjeWCCiGLHW1eqj9JOkre2cchGnE1elmvsjC7vcdrhaWqbtNT0MhozDSXHbeX90uIVfjJA16QSiGZ5MNRGOUGkUpNYxZQlD1KqlPX79xcxojMUTZwenw3JsQu5LVuyRtlhcA/VVzZ7E3ewSbKPe8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900178; c=relaxed/simple;
	bh=pL+740c5ddHbpygGZKTjCo2GuF/VcCh3grabNKr8t64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZerzBqaIZneTfyaLl3y6d8kcXpmwrhdIox8RfvFifxTWI6JvLcOqutauZh5E5mNT0CwlVvPnIFWDVEGRzGfaEHZVle+bNzhXr06iNdA4YjG/vskC0+zMIvYE7iLk4cVVhq3sgiWZrlDeYwZIDvCuYUHEv3YnoXk6+FmI4CmxYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=faaRbZzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8BCC116B1;
	Thu, 25 Jul 2024 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721900177;
	bh=pL+740c5ddHbpygGZKTjCo2GuF/VcCh3grabNKr8t64=;
	h=From:To:Cc:Subject:Date:From;
	b=faaRbZztMiSBkiiRKz/aa+BNacUunZkoitf/3qVom44DuzOXre+ElibANi1HabFde
	 ctsX+o//ZVtIi6nOzNjpV/jtXeHPJPHJJ0xWwMXNC4/RvsiowEwN3yHpQoa9yU9YoG
	 UB2j9y7Mh2OIjsqXM7eZ/hmjg+BlabadW4enqZ7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: remove tracing_is_on export
Date: Thu, 25 Jul 2024 11:36:08 +0200
Message-ID: <2024072508-freefall-headstand-7d47@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 25
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=pL+740c5ddHbpygGZKTjCo2GuF/VcCh3grabNKr8t64=; b=owGbwMvMwCRo6H6F97bub03G02pJDGmLZDqbf/OE+nLeMuItmubWsV3nlPGdWcsfP34XYJsio 3yzbNHljlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjI/nUM86zzGEvXRup+W6Wf t2a7burSUo3wXQzz4x5PmOVvwVceXmXtc2ixkaHjsY02AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The function tracing_is_on() is only called by in-kernel code, not by
any modules, so no need to export it as a symbol at all.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 578a49ff5c32..d09f2effa7a9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1612,7 +1612,6 @@ int tracing_is_on(void)
 {
 	return tracer_tracing_is_on(&global_trace);
 }
-EXPORT_SYMBOL_GPL(tracing_is_on);
 
 static int __init set_buf_size(char *str)
 {
-- 
2.45.2


