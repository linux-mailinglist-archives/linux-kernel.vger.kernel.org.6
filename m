Return-Path: <linux-kernel+bounces-522256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCEA3C7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9AE176C82
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3221481A;
	Wed, 19 Feb 2025 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UL0RVFUn"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6B214A8C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990856; cv=none; b=kN6TwovN1Tm1f1headL8NS/h36f96T2ouXt4hzDL9XoqadJdV7Ca3V1Y66HhqoJqc9RqjcprbLuUSHrILMvTXWU0LWJGdqKlDq9hfS8Km6qYSIpcbWsKg9yBfjdzASbRGkfOLpiXzU9pBhZiG8xK396/d2BmtJHkBExAjB4bWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990856; c=relaxed/simple;
	bh=XYhJ4WrFAoGFn3uC1pUi2Wtq7YiJ6MiWDQHpsJPopu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R54JYNHi5vjr3ib6fLxJFXSHwUG4ENbUcvoztb+XHz6ZPRY4+QHGRMbhcGMMo2uKgU2pAw6xC5sqmwu7tg2xANA3KwrIh8Ycy8mbev5/M3lx3n2os5zNh2NyJQLNqD4matNtQN3YOzsC0pxgPOn1MrcsH12ounvgBnfBxfCvGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UL0RVFUn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6r+svG78jzF9diT/8IAIF2P/yXmCgWfDm7zl/U5Du6M=; b=UL0RVFUnmLnPZOlRVdEqGxSfgu
	neyCfCC5o83udL4W/hHni5zcy8Pxl4CqWlXw5u3kokWoWRjx5N7H5McL+hG4Crt5WPys448z+VJTl
	44nryhDIcb3YrFVcJu6TioFoh0IqsXjjMpqBAtDOidpSzjI9lYT9dujME+G1lcmsDjRk2LdTkgZzX
	fFKSN+yvyuaH4Mo9l3awCCLc1kRasqaLcHDLxHGPVz43ojbNIBDHwCGuiy6nCquK8yOW00XodVpOT
	l7nEn9sp+5vwkPD2PGOrQv8TtV9omUZUHjONSg5eW919PVRy4Z5AG0tgTAB93oFNEQveNgO1nG93K
	GllISfvA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14] helo=maloca.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkp6P-00EwF0-W5; Wed, 19 Feb 2025 19:47:28 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/2] mailmap: Add entry for Rodrigo Siqueira
Date: Wed, 19 Feb 2025 11:46:20 -0700
Message-ID: <20250219184702.242924-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219184702.242924-1-siqueira@igalia.com>
References: <20250219184702.242924-1-siqueira@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map all of my previously used email addresses to my @igalia.com address.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 5e829da09e7f..64413bbc286c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -583,6 +583,8 @@ Richard Leitner <richard.leitner@linux.dev> <me@g0hl1n.net>
 Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.com>
 Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
 Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
+Rodrigo Siqueira <siqueira@igalia.com> <rodrigosiqueiramelo@gmail.com>
+Rodrigo Siqueira <siqueira@igalia.com> <Rodrigo.Siqueira@amd.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
-- 
2.48.1


