Return-Path: <linux-kernel+bounces-185402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD28CB486
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B31F23168
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D729148821;
	Tue, 21 May 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEH9Wz1X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB631EB40
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321956; cv=none; b=Ea42IsDAMTXiGzo+y+2tnoy1s4Ey5A4addSqXAZKLQb1cqOX/6CgpHSChitmT3y0SPb7EZtJp3PVl7jyHSL1c1nL7A7RkZFX/iWwsNPsp+e99hU6sbxG+F+ZQebbORCJsRMG4Wp7AFZDRrONHhYpJI3E7C9y+gOfVBXUtBlpsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321956; c=relaxed/simple;
	bh=n1XYT0f8NZ7GY+qdmS7k5N3aMcsAOCFt6lECER9tD1I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fetFT3rOLDhZD48HVwLJYe/D1vrjtbvvU6S4+0bRrMqkhAMD/m3hGb66wNGQ+3ZElDWadq396doXS6R888uPKsadj8kvKxHFg/D7L0NpRK0MkV4xx2PftlCEXrPZcW36zG8uKA+el6Gbm7ZvJLDEtK3BewHtxUwxDeHHk2x3hEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEH9Wz1X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716321954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUcZx+GYvnpd0qagpN08S3w0mckRV0Hazws3JBEBOHw=;
	b=FEH9Wz1XXIi293NSIf/plGpADF71XNQAb5nC6IJTUJmgqAq3CvbwEaVHSeG7rhFM3vFP5q
	g7HT64B7uVgkltweLFiKDrDBeacHYAJzNVWOXTSfhySGd60Tfq8K1YwsA+QUiVXYkJni0Q
	Yvbgm25ofYpJLNrX7ydr2SUNhw51I/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-g-ZkIjQxPvWuKP4dSTmyWw-1; Tue, 21 May 2024 16:05:52 -0400
X-MC-Unique: g-ZkIjQxPvWuKP4dSTmyWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB112101A52C;
	Tue, 21 May 2024 20:05:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6178A51BF;
	Tue, 21 May 2024 20:05:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <110d2995-f473-4781-9412-30f7f96858dd@kernel.dk>
References: <110d2995-f473-4781-9412-30f7f96858dd@kernel.dk> <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk> <316306.1716306586@warthog.procyon.org.uk> <316428.1716306899@warthog.procyon.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: dhowells@redhat.com, Steve French <stfrench@microsoft.com>,
    Jeff Layton <jlayton@kernel.org>,
    Enzo Matsumiya <ematsumiya@suse.de>,
    Matthew Wilcox <willy@infradead.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <322228.1716321947.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 May 2024 21:05:47 +0100
Message-ID: <322229.1716321947@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jens Axboe <axboe@kernel.dk> wrote:

> On 5/21/24 9:54 AM, David Howells wrote:
> > Jens Axboe <axboe@kernel.dk> wrote:
> > =

> >> However, I'll note that BDP_ASYNC is horribly named, it should be
> >> BDP_NOWAIT instead. But that's a separate thing, fix looks correct
> >> as-is.
> > =

> > I thought IOCB_NOWAIT was related to RWF_NOWAIT, but apparently not fr=
om the
> > code.
> =

> It is, something submitted with RWF_NOWAIT should have IOCB_NOWAIT set.
> But RWF_NOWAIT isn't the sole user of IOCB_NOWAIT, and no assumptions
> should be made about whether something is sync or async based on whether
> or not RWF_NOWAIT is set. Those aren't related other than _some_ proper
> async IO will have IOCB_NOWAIT set, and others will not.

Are you sure?  RWF_NOWAIT seems to set IOCB_NOIO.

David


