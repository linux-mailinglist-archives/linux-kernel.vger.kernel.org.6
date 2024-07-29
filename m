Return-Path: <linux-kernel+bounces-265855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26B93F6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589DA1F21EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DA14D29B;
	Mon, 29 Jul 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/qqc0mW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765271487CC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260699; cv=none; b=BewJZYtOYiUBdU9yvhTqFbnamocqWPzr4/bOHnvUpBQNyPtt6Z8DLicCN5j5b2nosTLclQJFp7ZrG3SyB8cvjDVKukF6FCsme8lBQ6cgPe/H5NaYPrTwSd3U+VNmjL6re6mT0rgJrv4U8AR5sxv8WoMJ4abGMdA+RlDHdeABkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260699; c=relaxed/simple;
	bh=sqmtbWJWJbnnO58kBXQ7yJLJv2Q4yJ6rGCz08DsyGcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AYWcgEi/226DSaJ8Mvm6kX1Z7Zxi/FRRTsCtBkyyybZN1UwLZPKkKMZrfj80AQtx3aRPhwSQI+3ttP/F6YLpDTg80RCAKbUeJbIzq+nRAXo6aUp66zgNnRUlQQ1e3x/Hao0kkABo24VB8mJuPDFMUoAp8W8khpkauZNlmbxyNjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/qqc0mW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722260696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=icUyqWhOytyMRjqqDwKpqJ1F6QKpS6EQcFlYPjhlVZM=;
	b=M/qqc0mW1N2A5moq/NQDcBaug6PQQQ6tbeb0RM4TsPltV0LxaaxAuxwKgnILofSK3dCWrl
	cL8B3jDEVUGUPCIO+X0ulRBakDW3xiaoLYYIM9A4vKV5S9t/M0eibD3BKBlyx05AM3dLFl
	x7M4dGMNJDs/F52cmviL1bKrd4FwYp4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-dtyyHPEuNaOH9_GHEnd9YA-1; Mon,
 29 Jul 2024 09:44:51 -0400
X-MC-Unique: dtyyHPEuNaOH9_GHEnd9YA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6FF1977339;
	Mon, 29 Jul 2024 13:44:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.232])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 91B401955F68;
	Mon, 29 Jul 2024 13:44:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jul 2024 15:44:48 +0200 (CEST)
Date: Mon, 29 Jul 2024 15:44:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] uprobes: misc cleanups/simplifications
Message-ID: <20240729134444.GA12293@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Peter, I don't think these changes can really complicate your ongoing work.
But again, if you are going to send the next version "soon" I can rebase
these cleanups on top of it.

Andrii, I dared to preserve your acks, all the changes are simple.

Changes since v1:

	- update the comment in register_for_each_vma()
	- remove the now unused "struct path *" arg from bpf_uprobe_unregister()
	- forward-declare struct uprobe in include/linux/uprobes.h
	- kernel-doc fixes/updates
	- fix use-after free in uprobe_unregister(). See "TODO:" in 5/5.

Oleg.
---

 include/linux/uprobes.h     | 22 +++++------
 kernel/events/uprobes.c     | 96 +++++++++++++++++----------------------------
 kernel/trace/bpf_trace.c    | 25 ++++++------
 kernel/trace/trace_uprobe.c | 31 ++++++---------
 4 files changed, 69 insertions(+), 105 deletions(-)


