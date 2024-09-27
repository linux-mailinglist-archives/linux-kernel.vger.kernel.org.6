Return-Path: <linux-kernel+bounces-341424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA825987FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F26B26246
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A6E188CB2;
	Fri, 27 Sep 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqfrRR6n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358DD8475
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424091; cv=none; b=nOr8tBY/e2U5ad1w/hmJ5aXRLGAfAQ+vWgLxYiDUmlwTMLx0eB8CeMKZ8x8sAms6WOCaV/1pfKHBnc5TwYuSGExg4ICLlBZmL12LmVtAqU71GowMGopLMbU86doWHDkpCES0ghD6OJL9WwIoK6mq5or6egwj2RIN2i54RGuvUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424091; c=relaxed/simple;
	bh=Bz65efZunOsddqTWVpmN1jChR7h+KsKVxHwcbnAgBxg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HRIBeBQ28RdsbCgjYc8ETmacK7t2lPzihuZUGuZEBEkaKb5cO5NDd9eR94M6JSEq1dJqsy88vSRq0ffHEXS4ix3c0yjl0cwYa2RGCMqglYMutkuQYysceEPaD0UdOnXHLqOmwkc84rbB3sfuiLNhRuUuelAk/ILxkevHzE98P20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqfrRR6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727424089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aloVGHaDt2hYSL7SSw030vx7EurptsAcbaQDTmCFtRM=;
	b=DqfrRR6nGAMMMrUIpGmzYqGTiERh71ojCb2wXbjHfzrd6FhpvFyidfX+IYYJwoTsoKKaWE
	+5sVA2cX/fVRjyI0pYB4nEUzJtsc4aGXL0B9sDjeYTyHOOoo34uH9FLnzpa6RwdMpzZSgy
	Q7HSgUM6+rOa/TS8SP2lr1wq2GRdPlA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-_RuhlAuwMJqMkVne5ocjtQ-1; Fri,
 27 Sep 2024 04:01:23 -0400
X-MC-Unique: _RuhlAuwMJqMkVne5ocjtQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02C381902F55;
	Fri, 27 Sep 2024 08:01:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A453195605A;
	Fri, 27 Sep 2024 08:01:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240926174043.GA2166429@unreal>
References: <20240926174043.GA2166429@unreal> <20240913-vfs-netfs-39ef6f974061@brauner>
To: Leon Romanovsky <leon@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs netfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2238232.1727424079.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Sep 2024 09:01:19 +0100
Message-ID: <2238233.1727424079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Leon Romanovsky <leon@kernel.org> wrote:

> Do you have fixes for the following issues reported for series?
> https://lore.kernel.org/all/20240923183432.1876750-1-chantr4@gmail.com/
> https://lore.kernel.org/all/4b5621958a758da830c1cf09c6f6893aed371f9d.cam=
el@gmail.com/
> https://lore.kernel.org/all/20240924094809.GA1182241@unreal/

I'm working on a fix for the third one at the moment, I think it's the rea=
d
version of the write fix I posted previously:

	https://lore.kernel.org/linux-fsdevel/2050099.1727359110@warthog.procyon.=
org.uk/

I'm looking to see if I can make a general solution that abstracts out the
buffer handling for both as we're early in the cycle.

I haven't looked at the first two yet.  I was in the middle of testing 9p =
when
I hit the write-side bug that cifs was also seeing (ie. the url above).

David


