Return-Path: <linux-kernel+bounces-233471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B25491B768
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510041F21861
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE413DB9B;
	Fri, 28 Jun 2024 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtGqpOIg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D16A022
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557632; cv=none; b=JUtXaSjKnQhcKWXDLPFHa/1w4OW3j1dcVgauNH5WeQBttTxQWwM4r1QJVsBX2VPEYez3vA9CmJNE3rGnpSLKvB//g5/CnRqI9Sz2aNFdvu62PIAN5sqcbume1T+1RK3NqyIMXhoTfvUwY0qyZaBMm4qVkFPdsw6WzhTlhU8HpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557632; c=relaxed/simple;
	bh=d/6wducofChoiWZvHDjq7iFfEt1pLDvMGVrrbiCq/7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGgKVLeCLQMFTaOqE4JXxAlt8oKlI076sl/vxXAJkL/VY263s22N/eAxTQZgFj9YbwTioPcUFHnNG4ix/UMNswAuXa9r2pZ5QlkRppMlHnQLYA6StYzUCEi3/vOop3Wb4oxcHVtjDOGy2ima+wPICiSKdrDcjmOLc+P7OMkG9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtGqpOIg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719557629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTYbIiL1+jqU9PJ1oaxz7hIoPa2Vj4NQeHxl7H52P1E=;
	b=LtGqpOIgTeqXQ6PElBaDWnpjSh/SG9sOSH7u3e7TjjSkl4XSL6HpWcxZ46T9MsoXly3c8w
	uWvtbuZV4mZElSsrWYao3BQqA9DRuSK2eZpAe8Cjp3dIUSxsLNv091dY6zyPJ66ksrhYmM
	x5phRqDTeQG+wxvT0Drq0we2unLE2a0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-RMp3hwoiOHef_8GBP9Qcyw-1; Fri,
 28 Jun 2024 02:53:45 -0400
X-MC-Unique: RMp3hwoiOHef_8GBP9Qcyw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE8B01944D31;
	Fri, 28 Jun 2024 06:53:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 159D919560A3;
	Fri, 28 Jun 2024 06:53:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Jun 2024 08:52:09 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:52:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/4] seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all
 users have exited
Message-ID: <20240628065204.GA29300@redhat.com>
References: <20240628021014.231976-1-avagin@google.com>
 <20240628021014.231976-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628021014.231976-2-avagin@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/28, Andrei Vagin wrote:
>
> SECCOMP_IOCTL_NOTIF_RECV promptly returns when a seccomp filter becomes
> unused, as a filter without users can't trigger any events.
> 
> Previously, event listeners had to rely on epoll to detect when all
> processes had exited.
> 
> The change is based on the 'commit 99cdb8b9a573 ("seccomp: notify about
> unused filter")' which implemented (E)POLLHUP notifications.
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  kernel/seccomp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


