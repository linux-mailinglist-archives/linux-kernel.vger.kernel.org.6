Return-Path: <linux-kernel+bounces-345963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4F98BD76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1957C1F23C09
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F311C463B;
	Tue,  1 Oct 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS+UUDcC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E941C4614
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789235; cv=none; b=Ya8enxOH8w6qyLD8vZe9boK27h4LeCwLFjTcSlAdCKlx16YHxKbFts4hnCMcwCXW32/SNuwOdoS2Hzhzd9NbheFzeFOrI48enFMLgxF6qjbbvP9JRFwCcXFZ//u3SvP0WH332ZoiuDXOe13nAYyGIuA8QYm8WQfXws56nJaWexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789235; c=relaxed/simple;
	bh=KwqipP43Ai0dr0+756zH0lxRFzZd3vyxsr87zG/I1+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqgC/HrmrWwu+jQQmWVlVB3G+Xh+9ZUJAQxPFrHqPHO/4cPP6EHwvSJNRtDymYTdY+cA3t2VKJkrNTLizCg0pFsioaNJhglj0CesJZQ23sBTvUHpjG7tcK9CLs++02EOKWOjc2A8Vk4YhrhMgDwSoeAWDE/5vx1ihDukFpMbdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jS+UUDcC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727789232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U+0XIqGB/Pxi9xC17W1R4YglKYnGcIZWqNBcS+hO/RI=;
	b=jS+UUDcCa5GgSVgU47C5U1xQqRD89lD3J3ecVlHSkRU7ZojPlTLTHIZVLkL8aZRiMrD4J6
	DtVwrsZuCxl+3ic7a88HCFT95+A3CZOt+aEZZs/ZKEg+ynqW5otkfXgIAcOGD0Iwv6Yyoa
	DPdgkEpi1FnRd/eLi4ncmCMXgxyAZkQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-97zSWtaUMO2vm5qHiXrFsA-1; Tue,
 01 Oct 2024 09:27:09 -0400
X-MC-Unique: 97zSWtaUMO2vm5qHiXrFsA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A52CB196A406;
	Tue,  1 Oct 2024 13:27:07 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D909A3003DEC;
	Tue,  1 Oct 2024 13:27:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] rxrpc: Miscellaneous fixes
Date: Tue,  1 Oct 2024 14:26:57 +0100
Message-ID: <20241001132702.3122709-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Here some miscellaneous fixes for AF_RXRPC:

 (1) Fix a race in the I/O thread vs UDP socket setup.

 (2) Fix an uninitialised variable.

David

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (2):
  rxrpc: Fix a race between socket set up and I/O thread creation
  rxrpc: Fix uninitialised variable in rxrpc_send_data()

 net/rxrpc/ar-internal.h  |  2 +-
 net/rxrpc/io_thread.c    | 10 ++++++++--
 net/rxrpc/local_object.c |  2 +-
 net/rxrpc/sendmsg.c      | 10 +++++-----
 4 files changed, 15 insertions(+), 9 deletions(-)


