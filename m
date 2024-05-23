Return-Path: <linux-kernel+bounces-187277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090B8CCF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134CA1F21907
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E113D27A;
	Thu, 23 May 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fpbygn7/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CE17F6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456911; cv=none; b=tkJnuxPiPM12/9yO/QpaPCP/ENNhCu7LZucdMeAa4GYAvNDS9PLslVsI0/e/eh6oSCKFPsAUgn7hU7aBGo7Dd5b+cgpcPCVWKlcV1yPevTyPKdmzRQvP5gWrbm34eZU3tNTYp5cHuUFIUI+crgq++HzWwQeqGsGhLscospBR/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456911; c=relaxed/simple;
	bh=3RdzRMF61KiMbeEgHAOewoeGsgX0t3vtk/NZFBB30OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIQf/EEl8HSidoyZRvBIvN7LRYjTxkmi/3WAIfN/65SC7C5++9kPIcUpnrfPv0amIP79xmh4S6RA5sTVfwMjpJoi5lmiGkFGTX5b2HyOH3+81cFKHwUhlTFzJZwBsaWPPCVzfQVE+3RnXb0gOK5y9gtdYLVzijmz7f5NGcULjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fpbygn7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716456909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lfk0mvv6ZfCRNrrlaQ0pNTuzMUrG6EPTfySp33FAHbY=;
	b=Fpbygn7/VPkA0d+7PBn6AbIb+uKLhRYizrZxRZfnrkykFSGUgOTGB5enyGKn43n4r1HaIm
	tUOjU/a1qyOac+dq/F6zdbzQECLDzSr32j9DXSVg8BrimNu57CD9JW38CWYKBBk159PHGu
	/MmqCLUGLp97rTEXoZlWtJDYa4TpSAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-h6UX6NhuNf2mmpSngUDQ-Q-1; Thu, 23 May 2024 05:35:05 -0400
X-MC-Unique: h6UX6NhuNf2mmpSngUDQ-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4304800281;
	Thu, 23 May 2024 09:35:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.7])
	by smtp.corp.redhat.com (Postfix) with SMTP id E3CDE200A790;
	Thu, 23 May 2024 09:35:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 May 2024 11:33:37 +0200 (CEST)
Date: Thu, 23 May 2024 11:33:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3 v2] seccomp: improve handling of
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <20240523093334.GD15163@redhat.com>
References: <20240523014540.372255-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523014540.372255-1-avagin@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 05/23, Andrei Vagin wrote:
>
> This patch set addresses two problems with the SECCOMP_IOCTL_NOTIF_RECV
> ioctl:
> * it doesn't return when the seccomp filter becomes unused (all tasks
>   have exited).
> * EPOLLHUP is triggered not when a task exits, but rather when its zombie
>   is collected.

It seems that 2/3 also fixes another minor problem.

Suppose that a group leader installs the new filter without
SECCOMP_FILTER_FLAG_TSYNC, exits, and becomes a zombie. It can't be
released until all its sub-threads exit.

After that, without 2/3, SECCOMP_FILTER_FLAG_TSYNC from any other thread
can never succeed, seccomp_can_sync_threads() will check a zombie leader
and is_ancestor() will fail.

Right?

Oleg.


