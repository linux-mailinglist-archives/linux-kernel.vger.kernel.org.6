Return-Path: <linux-kernel+bounces-556080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8AA5C083
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7224F7AAE13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EE82580F3;
	Tue, 11 Mar 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F48nVGS7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD102356D7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695365; cv=none; b=im4TqJOwrpppqfCNgMchG8TUOnTCD1mqJIzOfod+CSErWH7HiD7FJGBhUuu4a+0tsEWM28EK1sg7OMXepU6G43Ri50CE+qgXmIohAitK0nX5HEQodQi2jBqZ1+gZ8mDqQFf6Wlozn1XneJS2a/pZyoIjBuRyqSDxmqfpC9lq0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695365; c=relaxed/simple;
	bh=JmYUzDvAxPGj4zbO2i1wDLyR5cCoRXGD9vm51/Rv110=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNqC+GjpPlGEIiGH7ciqFmNpj/6qhtXegSjHyWgDjiMJ7R0zt+aql6jQDHEOhVKZeWn3gTDXyL9ekppn2HWl16FWFgLlYZSFfVQRa6OBrDCirVP1D+BL1W97/5aRcLYd0r8zIaazgfEm+VfDxU4le9nM6bAanyLfcXg0BOI62Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F48nVGS7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741695362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L66ODmBs+dCHgrMRGT2Pjz0+6wIG2q2DYOyUrGumZ1k=;
	b=F48nVGS7Kim3mvgZsZJ16u9pAGPGoXNHxBJ+RYlzdbko753l7xBtJYQq20BxCJWduqGaAk
	K55ob8EgvrR0l+DhNMt7Gen2XX3myIaC2HSYzMcSFoM4LW0VcUqtMtCliP6o/TEQ4GlB79
	tfzi0H2kSseota/NvQ2cbGBA4h/Vdno=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-F4Pfz6OmP5CPe6M57fyX2g-1; Tue,
 11 Mar 2025 08:15:57 -0400
X-MC-Unique: F4Pfz6OmP5CPe6M57fyX2g-1
X-Mimecast-MFC-AGG-ID: F4Pfz6OmP5CPe6M57fyX2g_1741695355
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87EDE1828A80;
	Tue, 11 Mar 2025 12:15:55 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEBD01800944;
	Tue, 11 Mar 2025 12:15:52 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/4] Documentation/rtla: Cover BPF sample collection
Date: Tue, 11 Mar 2025 12:49:32 +0100
Message-ID: <20250311114936.148012-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is a follow-up to the BPF sample collection patchset [1],
documenting both the feature's build requirements in the readme and
the feature itself in the manpages.

A few fixes affecting the same manpages are also included in
the patchset.

[1] https://lore.kernel.org/linux-trace-kernel/20250218145859.27762-1-tglozar@redhat.com/T/#u

Tomas Glozar (4):
  Documentation/rtla: Fix duplicate text about timerlat tracer
  Documentation/rtla: Fix typo in rtla-timerlat.rst
  Documentation/rtla: Fix typo in common_timerlat_description.rst
  Documentation/rtla: Include BPF sample collection

 .../tools/rtla/common_timerlat_description.rst         | 10 +++++++++-
 Documentation/tools/rtla/rtla-timerlat.rst             |  9 +++------
 tools/tracing/rtla/README.txt                          |  7 +++++++
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.48.1


