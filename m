Return-Path: <linux-kernel+bounces-520231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE2A3A745
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15980188D96A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C217A31B;
	Tue, 18 Feb 2025 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acDAABgY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3621B9C7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906583; cv=none; b=O2tZruHvy1PPszMPrZkqQsZ5vN+acm5KGDgYKHK/g8XncKa29VilWoc0kvIEcdoub3ld42c2NJxw/MxhUgePPyx7IcAR9MdTX9gx+ipxakoKnqP+MDzICi5+rcUD9HhjmIj1WtZRJvPTqG7R/ovzJVzyzqtuHXtkFTk7sltTywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906583; c=relaxed/simple;
	bh=swGB3xGE9Yoh2kRKbPlYsUFSqqbPDflfTARdV/Ubt4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/fFWGJyvHDlvl0yFTkoueHgM28F7M06Srx8D86eLfuskQXJ0zLSt1s/Cq5zWwWiG8wzVgzAawPp3isjDvgvumeKxbKtMkJeDd25IeS4I1mJH4htlu3CStM02eC1e3nBttZJVhKex4aczZyKbIrQ3fUSXSLxpVDFV2DhsXQhPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acDAABgY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YaNAwOy0l3tTCLhav17cAtoV5hBrzuMcbhO7CyzKHR8=;
	b=acDAABgYj/WJ2FN12YBco4I2LTnsy4/TvM2PNcl/mlFw+i6LGctPkPOQbmLVYR3Tk6lKdr
	hh+Dt7WzgOcJ2fVGJAdmBOtPaR1kVAZODTo7lYYbw7areuk9kVMJtYJ+VnjYCQzBR0P4kC
	CaEWQTx5bkJAdvkqsASYPvG/HsnIBGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-D2-hc7eYN4mzExwpWZUUqQ-1; Tue,
 18 Feb 2025 14:22:57 -0500
X-MC-Unique: D2-hc7eYN4mzExwpWZUUqQ-1
X-Mimecast-MFC-AGG-ID: D2-hc7eYN4mzExwpWZUUqQ_1739906576
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 213F5180087B;
	Tue, 18 Feb 2025 19:22:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1538E180087C;
	Tue, 18 Feb 2025 19:22:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/5] rxrpc, afs: Miscellaneous fixes
Date: Tue, 18 Feb 2025 19:22:43 +0000
Message-ID: <20250218192250.296870-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Here are some miscellaneous fixes for rxrpc and afs:

 (1) In the rxperf test server, make it correctly receive and decode the
     terminal magic cookie.

 (2) In rxrpc, get rid of the peer->mtu_lock as it is not only redundant,
     it now causes a lockdep complaint.

 (3) In rxrpc, fix a lockdep-detected instance where a spinlock is being
     bh-locked whilst irqs are disabled.

 (4) In afs, fix the ref of a server displaced from an afs_server_list
     struct.

 (5) In afs, make afs_server records belonging to a cell take refs on the
     afs_cell record so that the latter doesn't get deleted first when that
     cell is being destroyed.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (5):
  rxrpc: rxperf: Fix missing decoding of terminal magic cookie
  rxrpc: peer->mtu_lock is redundant
  rxrpc: Fix locking issues with the peer record hash
  afs: Fix the server_list to unuse a displaced server rather than
    putting it
  afs: Give an afs_server object a ref on the afs_cell object it points
    to

 fs/afs/server.c            |  3 +++
 fs/afs/server_list.c       |  4 ++--
 include/trace/events/afs.h |  2 ++
 net/rxrpc/ar-internal.h    |  1 -
 net/rxrpc/input.c          |  2 --
 net/rxrpc/peer_event.c     |  9 +--------
 net/rxrpc/peer_object.c    |  5 ++---
 net/rxrpc/rxperf.c         | 12 ++++++++++++
 8 files changed, 22 insertions(+), 16 deletions(-)


