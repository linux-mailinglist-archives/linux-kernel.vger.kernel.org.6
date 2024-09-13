Return-Path: <linux-kernel+bounces-328506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5703978518
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D13728734A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D359160;
	Fri, 13 Sep 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpTf007q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37D6BFA3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242535; cv=none; b=drPI3/OhHs01wk57J8qwZMaqr38oiTQ63FLsiLqRxYwKCV7mLYDOi1TNngwlYQyRH5UNQGKdqtTkQmRcfVfJP4OlGX+A4+wRBKcFhTR0rKTjbOeyu1sb+ef84729EtiOfmPCw9VFTuvVQZDfjVgoEGSAea5uz+EnW+mcUu+zN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242535; c=relaxed/simple;
	bh=nDCfp3+q/5sLHYS1eY3RJebr3/THVFZ7fxqMWqanALI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=cD0oxzM5mzJweD58s00Ic5KJi7NrKCpBBo6qi80A9beAFO8aCk9t5wQZfAF5vq1rR2jbiolX4Mi6LHWqXW5K5ocSEHKJBXNiAznGiy9tnzCGW85jz6JhPNG+5pt/2YWW4UaYgcazrxU+oNv+IGZMiVEUbscvWyvdBbd9NNwOGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpTf007q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726242532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRL9N728wGJtJA7a25Rl5O5Pz5GV2Sdiwf0wmyZHpJ8=;
	b=GpTf007qZxzjy4V7l0AYAXlKcxGDMU58N1Rg83W7GVagZFGNt/MkMUPZUa8ZEhl9EyLvJO
	6fKATeSLcWHNSWq7PSYRQqaHhItIdKcQsyRYuwiiYT6ryjEUGOZ5TyWoruyc3BrwWhmFk2
	NBVEfWoAOhtukNy6rJ46+8QcdocQ/BA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-k8c-Jd5DN-u0Vlg_tnPR-A-1; Fri,
 13 Sep 2024 11:48:51 -0400
X-MC-Unique: k8c-Jd5DN-u0Vlg_tnPR-A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA3591958B3A;
	Fri, 13 Sep 2024 15:48:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0FB930001AB;
	Fri, 13 Sep 2024 15:48:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240911182853.19634-1-adiupina@astralinux.ru>
References: <20240911182853.19634-1-adiupina@astralinux.ru>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    lvc-project@linuxtesting.org
Subject: Re: [PATCH] afs: Fix checking wait_event_interruptible() return value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1368424.1726242519.1@warthog.procyon.org.uk>
Date: Fri, 13 Sep 2024 16:48:39 +0100
Message-ID: <1368425.1726242519@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Alexandra Diupina <adiupina@astralinux.ru> wrote:

> The if-block in question is presumably supposed to handle
> wait_event_interruptible() failure, i.e. when it returns -ERESTARTSYS
> due to signal received by the task instead of a zero value.
> 
> Fix the condition appropriately.
> ...
> -			if (ret > 0) {
> +			if (ret < 0) {

This isn't correct.  If we take a signal, we need to drop out immediately
rather than going round again.  However, you're right and "ret > 0" won't ever
happen.  I need to have a ponder on this.

David



