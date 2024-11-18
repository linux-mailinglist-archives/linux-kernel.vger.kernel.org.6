Return-Path: <linux-kernel+bounces-413223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D79D1547
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34BB2836CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3022F19;
	Mon, 18 Nov 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdeTmHEO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F71B219F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947074; cv=none; b=BRtdJwifdwe7q21dOsX+A+iGQimqLQirUXQ15yh72wAQlRPV08l0EW8f+KrYY1nTqp+WWzbF4HpHFMpjr+qAyQt/YaJ8UXHYg0wxDrgLtNUGE7PFlVNaz/trVTntzqfvUhNjM7CnPV+hBWIBMzMvkHmRUSjT1Z9Ooizpj4KxY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947074; c=relaxed/simple;
	bh=U/kZg6wRRAGFaUyq3MwugoqyLVhimU1xugPQde6x/+U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=MVechoO2SaAQFTSFByItugwzpVcOtjBFP8bqqkSrA7dfj9fwe1icaEtQKQvkPRWRbVYVGzvga1aawrjd9YLFZ4IbNMjpG7YG8hUMNNzHnVdOsf0dTbPkuWh6mRcxvVTED4AH8LPdUMaOoj4UgJ+WZRcrGrsNM0fZsfJXHiebTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdeTmHEO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731947071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/kZg6wRRAGFaUyq3MwugoqyLVhimU1xugPQde6x/+U=;
	b=CdeTmHEOhYhe4dfD3DDzIyAEFoTaBr16T44XFusIerqNe112YbUP4upCcAUhoZvgb4mPmg
	dUStwlupEKypTR+Ch8flV5fjyYu66uTZ1MwEHx9wTU8tCXt4Z+tCZVHkTp/WlPcGQeFi+p
	m5/h7cjyCVDmAwGVs+uEAVGvQNVJ+cM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-dhQ99ud4NJO1pQxSCMBWGQ-1; Mon,
 18 Nov 2024 11:24:21 -0500
X-MC-Unique: dhQ99ud4NJO1pQxSCMBWGQ-1
X-Mimecast-MFC-AGG-ID: dhQ99ud4NJO1pQxSCMBWGQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E88D18F661D;
	Mon, 18 Nov 2024 16:23:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B65711955F43;
	Mon, 18 Nov 2024 16:23:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6739490e.050a0220.87769.0000.GAE@google.com>
References: <6739490e.050a0220.87769.0000.GAE@google.com>
To: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, akpm@linux-foundation.org,
    asmadeus@codewreck.org, ericvh@kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux_oss@crudebyte.com, lucho@ionkov.net,
    syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941061.1731947033.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Nov 2024 16:23:53 +0000
Message-ID: <941062.1731947033@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git netfs-writeback


