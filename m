Return-Path: <linux-kernel+bounces-267478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA19411F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0951C22EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43FB19EEA1;
	Tue, 30 Jul 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8RQ/bti"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA341990DA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342875; cv=none; b=oP8eUvoiigh7Um9GgJE86PpgZMXUyU4kv+2sQjSibqNaHh6OpZFeypk6fNSczMYUDlS9nIO2rEsSOyhpqCLXOfSg9GcJugD7zLe1dtfjkAvxXehxkmxLXKTcuL90Kh+L1DY3zh9Hy65h5mD+UvkztKiRPd+GDOkGwyQCVAka7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342875; c=relaxed/simple;
	bh=rs3RGXcSWWGTF3ApLp7tiaqaGYB/pXmbYIsCKbYdf4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IOsBuz+n74TE9VqM2Lf8cFG5xzRp++zx/EirBxr/uCQ822fUU014L0lhvZcWoJQDrvVjt1/10+6iP/rOlsqs7YrdkldubOGcukPwCDCs1Kpfov7xu6D200apCms7XDlQ1o6nWDaj1YJYWb3b0KVy9EzDW7tCGn8mqqJgdnJSoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8RQ/bti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722342871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6V3LwjOv7TNIF1rS+9k+gDjnDgZuB9UXSVmha58osmY=;
	b=B8RQ/btipSDXpMulkFLZFRwd6T7AY53tWI8wZEMFgyAGcXg2g0L/5i9hL2o+L1cdHN/HS5
	QywMBy5N9jih9mY/O7WGgFeP5YVANfEdAXrQUBOew78m7yOeuxFnAHdrIfu+A8T3Nc6jOq
	1867ahJfz4aW90sDYWlLyci0WzPnK/w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-b2uUg_1yPiyVNyhxWDZ41A-1; Tue,
 30 Jul 2024 08:34:28 -0400
X-MC-Unique: b2uUg_1yPiyVNyhxWDZ41A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9C71955F2D;
	Tue, 30 Jul 2024 12:34:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A312719560AA;
	Tue, 30 Jul 2024 12:34:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 14:34:25 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:34:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/3] uprobes: simplify _unregister paths
Message-ID: <20240730123421.GA9085@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On top of

	[PATCH v2 0/5] uprobes: misc cleanups/simplifications
	https://lore.kernel.org/all/20240729134444.GA12293@redhat.com/

I sent yesterday.

Oleg.
---

 kernel/events/uprobes.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)


