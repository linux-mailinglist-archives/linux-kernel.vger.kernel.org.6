Return-Path: <linux-kernel+bounces-543910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8FA4DB6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA063B3EE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F28A1FF5EC;
	Tue,  4 Mar 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RGppOLt6"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9DA1FF1CE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085362; cv=none; b=R1IGiay23dD84GppYWFQlmU3+drHIO4zJ8EowqbT5XYcUOQ7IsXhHu0Lgv/N6oGu6HqeE76QNkuXgqe0EWx5rYfOZqOCxg4AlRhO+uvWrf2S+ICQ6JwrLsWKkAC9fXRQ4BNlCgZdB48ZAv7B/PfPOz6TmUm/L3p0kD+1AJya65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085362; c=relaxed/simple;
	bh=fxudIMuxQ24hDbWnTYLNX2+i6iBKaTHq9FRiygj6aII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUrerVwfkGPUN3LOK43J1mixde/BrV4UPNHnMUZ8TJ0WA8JWx3XfXntcvm6Aq0lideCHL1/Cq3aUpiXdLXHODGLX+RmkDsIqXdoL3W5lBI2VbPtoFwGb9UCBzu2TqgG7hUh9Q0TjHcQybH3dR0NjTRkF1+5xHB0bM8qBtmg9B2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RGppOLt6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ORZ4G0EiXDz68zcXcIvNtaDtqVUbtZY5Q5s9EDAh5rQ=; b=RGppOLt6i33dSw6gZrvg4hTSkb
	/CFYi/ggm2jjlun8cVACSNYB8rAf8kTvciGFAjlu7I0ohV0EmZsIBYmFuH2dDMv610XfqckUpXdIL
	ySki0F59FH2iHKLhxJi6ZGlOTn0+evEHfEffPQ3u5ZIbSK0qMmOSPTDBWmmr66GARU1MZyTjKmrz7
	to3380Vqfs7QMX2dDLZAePunNDPlasEC5Xay+fDFczV1Zo/eoMfCWMfnPNcwbo35/rlDZJnxYM99B
	iTOqEtHLess2PFasMG2o481TM43CAnovXrnL5FITECwGfR9ZCwGzBYcJpzGv2WJaNCLXDSR0rWyJF
	8dO39YJA==;
Received: from [175.114.83.198] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpPpg-003feW-Ij; Tue, 04 Mar 2025 11:49:11 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v4 0/2] sched_ext: Add trace point to sched_ext core events
Date: Tue,  4 Mar 2025 19:48:58 +0900
Message-ID: <20250304104900.154618-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tracing support to track sched_ext core events (/sched_ext/sched_ext_event)
to debug and monitor sched_ext schedulers. Also, change the core event type
from u64 to s64 to support negative event values.

ChangeLog v3 -> v4:
 - Replace a missing __u64 in a tracepoint definition to __s64.

ChangeLog v2 -> v3:
 - Change the type of @delta from __u64 to __s64 and make corresponding changes
   in scx_event_stats and scx_qmap.bpf.c.

ChangeLog v1 -> v2:
 - Rename @added field to @delta for clarity.
 - Rename sched_ext_add_event to sched_ext_event.
 - Drop the @offset field to avoid the potential misuse of non-portable numbers.

Changwoo Min (2):
  sched_ext: Change the event type from u64 to s64
  sched_ext: Add trace point to track sched_ext core events

 include/trace/events/sched_ext.h | 19 +++++++++++++++++++
 kernel/sched/ext.c               | 22 ++++++++++++----------
 tools/sched_ext/scx_qmap.bpf.c   | 16 ++++++++--------
 3 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.48.1


