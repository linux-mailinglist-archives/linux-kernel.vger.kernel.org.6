Return-Path: <linux-kernel+bounces-231078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3409185D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3E71C221D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78918C327;
	Wed, 26 Jun 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQjg7w/b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892AFBEF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415822; cv=none; b=i75nYxib3mkJ+2eJqRlt9UiMxfI9QdH1koXu9GmFs6zWQQ7gZ5KuAHfm9dGq6c0wMCDu5Xnf/2GnukuGmUAone7P5a2gbltLgGjWZMqFOLjNkFE6t4UR9Ma66hnL1MSeinn6kvv9HUjdjF7cSidTurbyaJ2m6PohQYCGmAE6OCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415822; c=relaxed/simple;
	bh=k22ie6hHIhjYT8DjXFokXCWeeEjB7cTfhyrI6fPRW+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jm4EIuXs1evy1dOFY/R9POK5Sxs5eDEBBSffx1ONxbwmA5j4LpdplIceiGi6zeUS3u7+Q89cEXbPHXfwaBSiT1/m3X+vaHLt0MaZTfH89pgIDupL5aqQEehMKIUE9vqLoda5jGnGvl0zGJ7p46E8DZkoY1L14QGVwotV/5hn5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQjg7w/b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719415819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=k22ie6hHIhjYT8DjXFokXCWeeEjB7cTfhyrI6fPRW+M=;
	b=CQjg7w/bsmIAE67sF+y/msabHZLUQwaca4apTM9o0GyuFkGa/GyJYCRwS5qwW2czeB58TW
	j8sIdZ23gD2o2KlxVMjVi1mS7y9IeYsMdJbfouVM1REoq9U/rOjuyCHh61UIBmFd/fjSIE
	dAVvXN+GBxCXSifRP8mRhQlEFJR1ncY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-uIhVIbkZPxu0MW8gvoPg-w-1; Wed,
 26 Jun 2024 11:30:15 -0400
X-MC-Unique: uIhVIbkZPxu0MW8gvoPg-w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24D1619560AE;
	Wed, 26 Jun 2024 15:30:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.94])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 76B551956087;
	Wed, 26 Jun 2024 15:30:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Jun 2024 17:28:39 +0200 (CEST)
Date: Wed, 26 Jun 2024 17:28:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH -mm 0/2] memcg: deuglify mm_update_next_owner()
Message-ID: <20240626152835.GA17910@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On top of mm-optimize-the-redundant-loop-of-mm_update_owner_next.patch

Michal, et al, could you review ? Compile tested only.

Oleg.

 kernel/exit.c | 81 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 38 deletions(-)


