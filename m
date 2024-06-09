Return-Path: <linux-kernel+bounces-207383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E762901658
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FFE28170D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1445BF9;
	Sun,  9 Jun 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJcQjzwB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B92233A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943121; cv=none; b=PaeE4CXpj0r20klOla4IUuwDWhEGyla2WsOaq91V3VCUZAzqsPdrfx/C3OA7sDdoIIZceXhJqNohwM40iKm3cHxdkKQ0N5md5NKHjNnZ0J/2Q2jaCba5C5atEsQn58vAjAIRQ0ggywRZKCzJg//ub/F/eCEU4e7UBDdLDP+IlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943121; c=relaxed/simple;
	bh=m4kFUi5yytlI5s50Sjpyo9RnzpHFjqiSRFbMf63CocE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K3SSSMZsbsgJC/tCzpr9rz/wWAr5f03XchWZp9NN1shFbFd1zQuUJ1GCGXAaCEfk6AjQ37eIJ1b1xI2p87ndLyjCcwpN9+cvk9M05tY7hMBdDZXLQNd7oDL878K5saDZI+pJX/WWy6amjno2O53qmm/bnoVN6VcXQJcfjp9P7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJcQjzwB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717943119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=m4kFUi5yytlI5s50Sjpyo9RnzpHFjqiSRFbMf63CocE=;
	b=QJcQjzwBpOaxsARkOzPadH6CFY4Qd23JFEazJH5LcsNSr5oa/QIhhYKc20D/7QEcNNM5U7
	R4r1435ioSDm9z2B+juA4V+m0vDG5uVYjmytMnBltOn6Tf3sl2oAfkuF8rikva44dBjGCH
	qWm9Xk321yfaGFyQuXa15vpc/41MlnQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-BGEv4eDZPdSoYOjD9RXKPg-1; Sun, 09 Jun 2024 10:25:14 -0400
X-MC-Unique: BGEv4eDZPdSoYOjD9RXKPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADCB2101A528;
	Sun,  9 Jun 2024 14:25:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.58])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8376D40C24E0;
	Sun,  9 Jun 2024 14:25:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Jun 2024 16:23:44 +0200 (CEST)
Date: Sun, 9 Jun 2024 16:23:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240609142342.GA11165@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hello,

Eric, I can't understand why the commit ("signal: Guarantee that
SIGNAL_GROUP_EXIT is set on process exit") added the new
quick_threads counter. And why, if we forget about --quick_threads,
synchronize_group_exit() has to take siglock unconditionally.
Did I miss something obvious?

Tejun, could you check the note about css_task_iter_advance() in
the changelog? And can't it use thread_group_empty() instead?

Oleg.


