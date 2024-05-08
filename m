Return-Path: <linux-kernel+bounces-173520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F357A8C019E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE8A281EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDC128806;
	Wed,  8 May 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6PavpCx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C78625B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184009; cv=none; b=AJObQsM853Rr21WJRj3Xt2i31sNKbXQeF4YeeuiFWL4A+mXxx/96aWYK6BCNRguRG/RTr5ZvVjHUd4MEu3Rz0Q+JIhrS3iDL5MPR0V/6jmudP8Soc0Tr6+e7YbvJXu8N17Lz/xKTLwDIj1BkN5TjOaZKUztXcued079MbGbJ4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184009; c=relaxed/simple;
	bh=1lSRyAUvj7TaEFSrdWlONCYUiSqhdnwxpM1dpG8EhOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrIpctJ19SZAkOxKodUZ19KXz4HMtqqbCyq09jYRkB/3wQk8cSiiTr7PtAkfEiwvOkaJsjBih+ToetP/sk8fpDLqchbE+eP3k/HLA7ePBXqHOKu0OvfQtbG9b9A3YBmIFYUdJGeyrHp9z0HrmWczAqx4ZXxMy1Q878bieWGL6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6PavpCx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715184006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lSRyAUvj7TaEFSrdWlONCYUiSqhdnwxpM1dpG8EhOE=;
	b=d6PavpCxQq1zpgx+3jnzReJlIphC98WzI3O/kufT+4RiNEvC+zVznpbrBVoQwYoM89aKcC
	xjOXf0fphZQK2wwYpDH6KpQcgYAZMV6HT6UiB5hhP6LIYA4pv7l29bAWVYjR9znekQQgYq
	UN6LEnv53mqoH6p82vjv5BSVaMwNZ2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-lQB2gLYYMWq-TKaj346k6Q-1; Wed, 08 May 2024 12:00:01 -0400
X-MC-Unique: lQB2gLYYMWq-TKaj346k6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 056EC801211;
	Wed,  8 May 2024 16:00:01 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1109240C6EB7;
	Wed,  8 May 2024 15:59:58 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v1 1/1] lockd: Use *-y instead of *-objs in Makefile
Date: Wed, 08 May 2024 11:59:57 -0400
Message-ID: <E8F5CED8-8E7F-4D1F-B862-5FC1A372FBE6@redhat.com>
In-Reply-To: <20240508151951.1445074-1-andriy.shevchenko@linux.intel.com>
References: <20240508151951.1445074-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 8 May 2024, at 11:19, Andy Shevchenko wrote:

> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
>
> Let's correct the old usages of *-objs in Makefiles.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


