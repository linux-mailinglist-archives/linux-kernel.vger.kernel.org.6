Return-Path: <linux-kernel+bounces-186088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF08CBFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15471B21028
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70808248D;
	Wed, 22 May 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="famSj20R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BB52F7A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375421; cv=none; b=F5TOo0H6OZASKLlIvyLQ4bArJT6KaCY+EOcuOTnryNZbDgp5JV+YzySrkHHHCqpHHffztlQ9dJQo33OchSl6Br4XhsLU/IF2DXZB52gcSxt/BLUhMoJxpoICXLlumM7NT56qjfjVpnYGyp8e1WE/EroNgc4UhTudZzxcSZjQXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375421; c=relaxed/simple;
	bh=6Hksgokkl0HBv+oqPZJxKHQYHHUqeBHix5eB5WAxXYQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=flPPN6bRfH6WQZy4twye9ubAGLbmEOkRCSi+VeRpYEKRp2fah4LFA61641FYe8T7zMfhWpJajas70cHV5ZzDH8cX9KOoy3IZQeKh8EiHzWCiZArWh/CA5K7V4J3SUwakKTu9AXj8FQEnHbNszOkBjJHDJNMtAmprfrzcGgv0Kqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=famSj20R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716375418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UeDpmePfXLmxKAjowHlsgo0j+sPs3iu7AV0EsR6geB4=;
	b=famSj20RZ3EYikSflOYAxwCYgWIQ2DKnhkH85TTUgANUATij/yDmNZhtJJR39BlP/JsrhN
	Iscio5DNXq4ot92TazhxRMlq2w34uItnv/IzkIJIt5pAyLnvNlij39gsv3vjfItAPj7gO+
	upwdrSEL0J99BC4o/KbJMj2fdvo6DLg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-2dZ_UjK8Ol2vygMKCUcLKQ-1; Wed, 22 May 2024 06:56:56 -0400
X-MC-Unique: 2dZ_UjK8Ol2vygMKCUcLKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A2D585A58C;
	Wed, 22 May 2024 10:56:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19553200B4D2;
	Wed, 22 May 2024 10:56:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zkr8i9XxpkJ9AABZ@codewreck.org>
References: <Zkr8i9XxpkJ9AABZ@codewreck.org> <0000000000005be0aa061846f8d6@google.com>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com,
    syzbot <syzbot+df038d463cca332e8414@syzkaller.appspotmail.com>,
    ericvh@kernel.org, linux-kernel@vger.kernel.org,
    linux_oss@crudebyte.com, lucho@ionkov.net,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Write in v9fs_free_request
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <371418.1716375412.1@warthog.procyon.org.uk>
Date: Wed, 22 May 2024 11:56:52 +0100
Message-ID: <371419.1716375412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

asmadeus@codewreck.org wrote:

> That's a tough one: netfs took a ref in v9fs_init_request (netfs op's
> init_request) and expects to be able to use it until v9fs_free_request
> (net op's free_request()), but the fs was dismounted first and we kill
> the kmem cache at this point so we aggressively drop any dangling ref
> there as there's no way of waiting.

Which kmem cache are we talking about?  I can see two in net/9p/ and one in
fs/9p/.  And took a ref on what?

David


