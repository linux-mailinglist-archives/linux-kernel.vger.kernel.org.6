Return-Path: <linux-kernel+bounces-335488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EB97E664
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846231F216D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29933D556;
	Mon, 23 Sep 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6/owGkA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376310F9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727075553; cv=none; b=kwIhbFKqJ2dB7pqiaABQtudHJLfkNdhaqUt7neC4xNydW6O7flFRKPTKNSnrEpihZni9uDlvF/9dr7J3PsSNMvUqoDJjJLNtdGEtW0SsgPGWKqFFjRIad5PA1v+SKiPROFnU0zYoSjO14s9XOlYT3zrhbaSykVBg3BL1eeayWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727075553; c=relaxed/simple;
	bh=fkZNeFuPSOC4vkOBo7pLVMQrJchoOMHZAH9Io4Wvs6w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dUcGWtvI/NL6vtB+r0KB3iFGSGTP9JtNOikakSaLVZzn/O5B1Cs8mQ0UBRdUL05oJ8imly8Ol0Gy2OjCeN0+JIe6+NtPEu0Wk2TWgUqV4pvxkLu5Qsj+gAT+O3sP106Ai/lD8N1VmJ0KUxHYfHNbhHK+daQX0S6LT+Gl1hrNRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6/owGkA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727075549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkZNeFuPSOC4vkOBo7pLVMQrJchoOMHZAH9Io4Wvs6w=;
	b=A6/owGkANfTWjDHzUPcMCCXZb2hsrCKCbcx3SbFg5WxgOuuu8RpM5SrF40RcFtjMBDKDai
	91Qj6OTlh5fRR+H/z5AsRofIcdHQV13zH8Zutva4TUGglR4Oq7RsLpI6IPpQawyWfDsO0v
	26Sg11XSI+WEkEp/l5Itple68Tjw0mk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-mzblnrthND26R9sZBvRIqg-1; Mon,
 23 Sep 2024 03:12:27 -0400
X-MC-Unique: mzblnrthND26R9sZBvRIqg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAA5C190DE27;
	Mon, 23 Sep 2024 07:12:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7D693000235;
	Mon, 23 Sep 2024 07:12:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zu4doSKzXfSuVipQ@gmail.com>
References: <Zu4doSKzXfSuVipQ@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <743843.1727075543.1@warthog.procyon.org.uk>
Date: Mon, 23 Sep 2024 08:12:23 +0100
Message-ID: <743844.1727075543@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Chang Yu <marcus.yu.56@gmail.com> wrote:

> Use kzalloc instead of kmalloc in netfs_buffer_append_folio to fix
> a KMSAN uninit-value error in netfs_clear_buffer

Btw, is this a theoretical error or are you actually seeing an uninitialised
pointer being dereferenced?

David


