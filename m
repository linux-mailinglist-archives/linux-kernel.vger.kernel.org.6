Return-Path: <linux-kernel+bounces-187217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 139108CCEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C631C20DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909AA13CFB9;
	Thu, 23 May 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKMOxD4K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238B42040
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454901; cv=none; b=M9UE/SImwaOYp65O05+K1D9ruEcp3v7z/MmM2urLYcEUxyIK/6ZOZ4Qh2B/pysLtRvwjhai4QAOv3QOUhE3oFoLNeFasOGdwz4M4XumpZG/fWdHsncCpGTv1owq7FtappZfmK3WmyFdrrG/C98E6YnyAKYU2ROXNELTIif4Qa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454901; c=relaxed/simple;
	bh=9JZ4vRyQSMOfMmu/Xksqw4BMvaZK4uQ39PyE/CgZAtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx7AQm2abr9ElLV/zECceEa5x43IidYv3LxAPQk0ekv+K7z81LLrq95V9SJ84XjEv6slQ3C1zrUOvLqly9Z0k0ugAGmmPtnKYkvP7NW/Sk6KhEBYoj1wAkyb/N4zZK0/FVMs2+TTBbEvF2m0L51qeUA//0KfORvTm7foPyEvE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKMOxD4K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716454899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mFacu1kUKny2NDsPD4zOPoyJoW5apqOqcBL0dKkoTjo=;
	b=IKMOxD4KBgJlE7koL0xGcA/j+y0wfCpxDoYcHnL/CLFFDQoRf+nWnEjvFGr2MmjUswqhdC
	JEMrq8cD5q6z8F0nrtNHWauwioAqG5APFI+P8kLY965KFCzHUm5TnHUl9hnxcddHDy/WWg
	EygvCAN27b3G64aRfk1UBUZIXgNY5h0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-D4efVv2oM0eKn96ZQCIxoA-1; Thu, 23 May 2024 05:01:34 -0400
X-MC-Unique: D4efVv2oM0eKn96ZQCIxoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39C53800994;
	Thu, 23 May 2024 09:01:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.7])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2C8CF40C6EB7;
	Thu, 23 May 2024 09:01:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 May 2024 11:00:07 +0200 (CEST)
Date: Thu, 23 May 2024 11:00:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] seccomp: release task filters when the task exits
Message-ID: <20240523090004.GC15163@redhat.com>
References: <20240523014540.372255-1-avagin@google.com>
 <20240523014540.372255-3-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523014540.372255-3-avagin@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 05/23, Andrei Vagin wrote:
>
> Previously, seccomp filters were released in release_task(), which
> required the process to exit and its zombie to be collected. However,
> exited threads/processes can't trigger any seccomp events, making it
> more logical to release filters upon task exits.
>
> This adjustment simplifies scenarios where a parent is tracing its child
> process. The parent process can now handle all events from a seccomp
> listening descriptor and then call wait to collect a child zombie.
>
> seccomp_filter_release takes the siglock to avoid races with
> seccomp_sync_threads. There was an idea to bypass taking the lock by
> checking PF_EXITING, but it can be set without holding siglock if
> threads have SIGNAL_GROUP_EXIT. This means it can happen concurently
> with seccomp_filter_release.
>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  kernel/exit.c    |  3 ++-
>  kernel/seccomp.c | 22 ++++++++++++++++------
>  2 files changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


