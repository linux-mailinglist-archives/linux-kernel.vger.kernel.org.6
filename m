Return-Path: <linux-kernel+bounces-185090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862538CB05D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E7B285D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB712FF98;
	Tue, 21 May 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7O+mR/4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497A130A5E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301459; cv=none; b=bvZWgr2ui10Jnggf5gf+62CeEzsowO7fYA/n7UEs5rrtY536Pw+eW0cC7+he15VR/V4oQKey+CA6oouX9o4gnjxriszvwherXZmkv4sfx8SRiCvLulu/dOH9xfM+cpP2Jg18jwBy1vZ3bBZOrMrxqRUXexNeKDI7YAtu9+MeRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301459; c=relaxed/simple;
	bh=CTILGHjgaGkYQSxM0cSn6nRvwmlTHgeaKOp0IO0HWxw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FVuLUU7ORjqa7ik+nMUgWVSp256FzT8AD7XmOL/DnbldUHzPPE1dImMlCZfPDWvCtkvHM4cEBUv+Lgrjl4dCQAHlekfX67vlljrn3Og9kjUDoe2WfpoPKC3DsPToPJV7lYWIAChD6iMgpFiARaw2YW73svYiaAu4qbrVefcSWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7O+mR/4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716301456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rhtyKrz2w4HaVXBZrxE7MjJzIMil2OihfH05cUBp8po=;
	b=b7O+mR/4G9LvJUCOw1p6ev9JismfhDttW7W9wnewIp/Z2ZWEuk5A8+ToSrOZR0tgRckpwl
	WzwoLvB8qOG7ah/JEyFm+HCKxMLBCNmDA+GLY9ElaE0fvRSAKc7e9JppjTHOxo8C2YrbeC
	4qu6vYML8cTqbNqIZmnDjsqayySFuq0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-4qhM56d0MkiChBK8q-pIRQ-1; Tue,
 21 May 2024 10:24:11 -0400
X-MC-Unique: 4qhM56d0MkiChBK8q-pIRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41F4E2802297;
	Tue, 21 May 2024 14:24:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 890021C09480;
	Tue, 21 May 2024 14:24:06 +0000 (UTC)
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
Content-ID: <300530.1716301445.1@warthog.procyon.org.uk>
Date: Tue, 21 May 2024 15:24:05 +0100
Message-ID: <300531.1716301445@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

asmadeus@codewreck.org wrote:

> +To David as I need help with netfs

I'll look at this in a bit, though it may be tomorrow.  Just fixing something
in cifs at the moment.

David


