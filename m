Return-Path: <linux-kernel+bounces-247952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929F92D6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15CC7B2C8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0B1990BC;
	Wed, 10 Jul 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKS/F+gj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489C1990BB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629134; cv=none; b=nMydAqsqOG0qBF0hpQmGGAiDXMtiLIj/JCiApJb6esIXFqkL/kYhNv0xaOc19G5sznIDYde5BH6yFKfO/5OoYIH76AVy9jyaP+pFHlnkN7XMPwUGVkV7yql6qjo7O7WdjGgf5ehLKvHl68ujv1AiTlOfiohezGYXxuaK58JILQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629134; c=relaxed/simple;
	bh=fYMc6KLTY6LKXBmxGdlexV5LNTc9Pq7aLfamCDMNYqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6SR5b+qTwzgZ5bUSKIWbVgF8hEchYsNIjyjy9Gll2M59DQaHcqypPpm1zevubfk1+F5UdtuV1Y0U5awIr1puZi9HV3etCAsqiUtDTowmBiOKZxr2b+QYvUAHRyYld/jUYT4yTor48iC3oKjKtw4kzpfwj2k30lGyumeu/xiKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKS/F+gj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720629132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYMc6KLTY6LKXBmxGdlexV5LNTc9Pq7aLfamCDMNYqg=;
	b=YKS/F+gjIXDN3Lo0G4QqY+ZFrsB6qt13rvyzPrN+ybV4y0YgUMoFvxjMd+VjFq+t0aGavj
	9o6ZAtb4Wxahm/GiHiNUmmTnGdvwqY+5wrCgLoNTnaVfz+qIsxbVsb8yr6Fkb5s7kqjilF
	ZdupaFjn46p9J9fpqKG6Z7w3cC9CE8w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-NNjsDcgkP_65D1O_JDi5QQ-1; Wed,
 10 Jul 2024 12:32:05 -0400
X-MC-Unique: NNjsDcgkP_65D1O_JDi5QQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15C1D19560B1;
	Wed, 10 Jul 2024 16:32:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4A7C33000184;
	Wed, 10 Jul 2024 16:32:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 18:30:27 +0200 (CEST)
Date: Wed, 10 Jul 2024 18:30:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/3] uprobes: future cleanups for review
Message-ID: <20240710163022.GA13298@redhat.com>
References: <20240710140017.GA1074@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710140017.GA1074@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/10, Oleg Nesterov wrote:
>
> Peter, these simple cleanups should not conflict with your changes,
> but I can resend them later if it causes any inconvenience.

In fact I would like to push 2 more cleanups before the more significant
changes, but they certainly conflict with your ongoing work, albeit only
textually.

Let me send the patches for review anyway, perhaps you can take at least
the 1st one.

3/3 is only compile tested so far. Andrii, can you take a look?

Oleg.


