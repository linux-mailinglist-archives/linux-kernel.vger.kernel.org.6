Return-Path: <linux-kernel+bounces-379645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E99AE17A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253031C2233A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729F1B6CF7;
	Thu, 24 Oct 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj7XHmSM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FD1AF0DA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763584; cv=none; b=EPTNxnbI769gETRji6Nd3ysbWQ1nSJCT76ZF26E+OTNBfkruupxiRwLVXUce2DMtj9M5PDLA6AopmBtmn8awwfEnZ2q2ctiq9MyUmJZeaCk+Y0pGlOrZSwUpTpRRFZM3B7sWFDl7liim48lRVDv7Sl8gGtYUG1Ee0x6eY6bba3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763584; c=relaxed/simple;
	bh=aN8MrCnwlE8K2TmnO3260QbfP25Pc+jBcq2HtLctFss=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=TLEJhclHCH6hYdaiJDtHKh0uQBMz4AY7PDv8JUqMTxx+cANrruqGdTuQ3JGfDEbZK67mypFKxOUIBn0T/VmxCQjuwi0rwj57JXrpQd0j176rC7zd+HEKsBWoIZmq+dI0gEdwNqyEYWZLyZR4JE41mckgiR05jkGxovRcGS0rzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nj7XHmSM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729763579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aN8MrCnwlE8K2TmnO3260QbfP25Pc+jBcq2HtLctFss=;
	b=Nj7XHmSMkUpZQYKWvpzOcmV6BfnCiWIOkpzGQQScZvBohz0ejBWbroN2hhjG+I0lL6rqEr
	rYh260iNLOutSoig8sereZP3ehWd54VDW1NCthdCL/UrGcrsC6tfYomXNlvMI9+KPhnKiA
	GfFmNp4b9mySiUAp2a0oHBdMHwn43Fs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-5E1Ye8RMN_a1yUPNjHmeBg-1; Thu,
 24 Oct 2024 05:52:56 -0400
X-MC-Unique: 5E1Ye8RMN_a1yUPNjHmeBg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1498C1956048;
	Thu, 24 Oct 2024 09:52:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 309D81956056;
	Thu, 24 Oct 2024 09:52:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3340431.1729680010@warthog.procyon.org.uk>
References: <3340431.1729680010@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] afs: Fix missing subdir edit when renamed between parent dirs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3570557.1729763571.1@warthog.procyon.org.uk>
Date: Thu, 24 Oct 2024 10:52:51 +0100
Message-ID: <3570558.1729763571@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David Howells <dhowells@redhat.com> wrote:

> cc: David Howells <dhowells@redhat.com>

That should, of course, be:

Signed-off-by: David Howells <dhowells@redhat.com>


