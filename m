Return-Path: <linux-kernel+bounces-320387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7AB970980
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB0D282B4B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932117A5B5;
	Sun,  8 Sep 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ybcx4rrT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E55189517
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823618; cv=none; b=iyjPuYJqxZgQ+N2UMCLUSFcPWltYIF0gefjtQW9CVClSx5A6Egw+QzSOc/33mVCBfcOlN5JYeC73Kk6SePZj8VvlQQOLuo0jfULijO0ExDHj20C3bTs9RFGPPit/ekz2zNyj1T3pdofMNZyfSbzrcIf+NpgdhBnTT0U/5Gq/cE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823618; c=relaxed/simple;
	bh=oTycxlbvXHuk847zgBEikv79utx9zaMWqdYroi81HOQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JmGfX6pVht+C4QSM+SYxLLcz82GiUAKUzph22va1pXhe5+llULZykuQEGpCGODsbiigF8OBQp2LrPW86KZDc85AT66yPEX+08ZbYZir9vvqI8amhDREURhX0E3tymM0N7UDOGrvfiL0AOSUaQdWISNRW5dTfFJqDimf5ju3zVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ybcx4rrT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725823616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHunYunE4yvYgS41uFAlLjMHUcm7qtCvRULnLy7wG8U=;
	b=Ybcx4rrTIDOfdeaXo7I1hq+4bXdQhyH2syBB3j0Qa5XfZV6+3iWGXm/t3TyDbyrkf9aBOJ
	UWT9fuVgPAry1ZxjcgXzvZoPnSSwkFZB5rrI4PBCFPH6W7Ztv+03hppfY05pcctFp1B3AP
	C67aWYv4yS9yTDGfmgUN/FfC9wOt1Cg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-2BrG34rMNgKATF1UyJQ0vg-1; Sun,
 08 Sep 2024 15:26:52 -0400
X-MC-Unique: 2BrG34rMNgKATF1UyJQ0vg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 481ED19560A5;
	Sun,  8 Sep 2024 19:26:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E6DB3001476;
	Sun,  8 Sep 2024 19:26:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <202409082345.wiwtJarb-lkp@intel.com>
References: <202409082345.wiwtJarb-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
Cc: dhowells@redhat.com, oe-kbuild-all@lists.linux.dev,
    linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: fs/netfs/objects.c:148:5-24: WARNING: atomic_dec_and_test variation before object free at line 150.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <321126.1725823607.1@warthog.procyon.org.uk>
Date: Sun, 08 Sep 2024 20:26:47 +0100
Message-ID: <321127.1725823607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

kernel test robot <lkp@intel.com> wrote:

>  > 148		if (atomic_dec_and_test(&ictx->io_count))
>    149			wake_up_var(&ictx->io_count);
>  > 150		call_rcu(&rreq->rcu, netfs_free_request_rcu);

->io_count isn't a refcount for the rreq struct.  This is not a bug.

David


