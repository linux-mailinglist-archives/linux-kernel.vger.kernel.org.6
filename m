Return-Path: <linux-kernel+bounces-248899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D692E369
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C6D1C219A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191C155A52;
	Thu, 11 Jul 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGJAbTId"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C211553BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690095; cv=none; b=roF8R4fpZlu0JFThGxHy9kPZ6kv8s12JP0bAB8CeuEDE2OkHzXPr1oUzw8XkaXOgsA7QhrFt6Wju0Uc95BQE871nkI5PT5W0zzNzLXQuFM1xBcX27kvica6w/APaZEPRZLCobFJiQyppIfHQLFx0aI7z1KOpOHFvgi/k0zYEsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690095; c=relaxed/simple;
	bh=37/pqm4xjgo9ExMfXcLghTZ1XLu8IiG2BqNv6q2i5U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiADWC4dl1Y7VaeoMxPJE5MGVWyaZNvRM1Sx+RYJL6poEiqdFl6Lx/7Pyms0nfpwYiz8Yvc9t0+gPiER/8sAYHrxLboc/qndqG2GFbMgIzl+l5sihOJsmZpkuxlk0ZWdywJvOk44dV8ZiIDhK9mEeZ0AvUQ5UdKYpUkVr9nfSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGJAbTId; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720690092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8dTeOHlu53W6N0+wG7vI6REcOmgYVWMDG4bNhHFz/s=;
	b=eGJAbTIdOWYUL6gNFQQbs0SgfdzblvbMQMlYxCF4lchkv2ejHVJ/C/tNvNzEGyniWXaEhB
	Q5WCekZTU4QMASCmckfWznBe9oTtm7R8bvu9qGVaxpqiPDtNFPu39me7t+xOfAR7eMyP0O
	33Y65zPOHhiqBV6nRDA8F8qDHSfASdA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-NTnX1kYTNkWtjl-oX-l2zA-1; Thu,
 11 Jul 2024 05:28:03 -0400
X-MC-Unique: NTnX1kYTNkWtjl-oX-l2zA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E66D0196E094;
	Thu, 11 Jul 2024 09:28:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E64061955E70;
	Thu, 11 Jul 2024 09:27:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 11:26:24 +0200 (CEST)
Date: Thu, 11 Jul 2024 11:26:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe
 *
Message-ID: <20240711092619.GA18031@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710163133.GD13298@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/10, Oleg Nesterov wrote:
>
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
> -	struct uprobe *uprobe;
> -
> -	uprobe = find_uprobe(inode, offset);
> -	if (WARN_ON(!uprobe))
> -		return;
> -
>  	down_write(&uprobe->register_rwsem);
>  	__uprobe_unregister(uprobe, uc);
>  	up_write(&uprobe->register_rwsem);
> -	put_uprobe(uprobe);

OK, this is obviously wrong, needs get_uprobe/put_uprobe. __uprobe_unregister()
can free this uprobe, so up_write(&uprobe->register_rwsem) is not safe.

I'll send V2 on top of Peter's new version.

Oleg.


