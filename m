Return-Path: <linux-kernel+bounces-247730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA7692D3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7CE1C2312F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82219413C;
	Wed, 10 Jul 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiOWbcpb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380D1940B5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620128; cv=none; b=inMA6FxKb9W4+cPBrC0fKP9tSqZz0dGLk9zsgHnosEiaj6KLOSDRJDH4VhxPgVTXoKH7T5/rf6/f4iNmoa/QEyjnM8yH/rj+65frWW3oRgOpjeUX1/Mas5fHCRiZmiHAcIudrWMufJnQSXLMirsTm30XHPkQwEK8bBRWcdhRbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620128; c=relaxed/simple;
	bh=1Q/IkzIbtH2po0tnCn/AxRGOQ8Kj9G4Vm7KOGzvRH8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fSGKVhU22ccA+ILV97HiTj2KEiQIBGb4A6JjMLAMCny8+d3mCvS44sfpR4qY5/p1992dZCE9q5cpCZH48mk7x94QQ4VvT8qIVePeRgTZ1BfMl2ebYIpyoCXQWPDsUl1WY1UVbim/UIh5i5nH1ZxJgGqAhjCdL+ead1600m+FFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiOWbcpb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720620125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1Q/IkzIbtH2po0tnCn/AxRGOQ8Kj9G4Vm7KOGzvRH8c=;
	b=YiOWbcpbGKNynTjbitl+O4/dJ9dCtbeKosrwxYd3tLmT371tnZDbYp2Ks6FzSY+ZHJn/og
	0p/RiVR90M4hDVre6wKf6jJ3d/0kiyKDkChfo3Z37Bij2EzqREotqub18B0G0fqAG+TdMv
	sb5FYuSTA6Y2hIi9Aq6AotHrretybq8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-nfif026rPRuTTcISBDyRew-1; Wed,
 10 Jul 2024 10:02:00 -0400
X-MC-Unique: nfif026rPRuTTcISBDyRew-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7FEE19772CF;
	Wed, 10 Jul 2024 14:01:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 822F61955F6E;
	Wed, 10 Jul 2024 14:01:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 16:00:22 +0200 (CEST)
Date: Wed, 10 Jul 2024 16:00:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] uprobes: document mmap_lock, don't abuse
 get_user_pages_remote()
Message-ID: <20240710140017.GA1074@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Peter, these simple cleanups should not conflict with your changes,
but I can resend them later if it causes any inconvenience.

Oleg.


