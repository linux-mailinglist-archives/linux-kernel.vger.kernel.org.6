Return-Path: <linux-kernel+bounces-277938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8327794A870
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386A41F21901
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E61E7A49;
	Wed,  7 Aug 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAmhcnpv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9821CCB32
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036642; cv=none; b=jF3ZjZaHZqt60IU3XGqySxYnjK7Hq/gvni6eYR/Bmb8xyQVXsuMxBXD0VrYhFH37b7EEBY3GJgWOdancAXDqXE+WLQ981eYmcxTKknAWAIWh+A8aPTFNzsNs5v17SlgEiZgZAZraunt2ghmfuBmwNGuWuKUEsvgDeVsZEDCZq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036642; c=relaxed/simple;
	bh=vSo75lzjQkETXPUOV+jM9s7j37MlUuGx+J1YmnX/Wf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2s4pwaUaqtSaMrWvD1yf3djQWNu8cDnxzZdZvUl8rnXEsvTxbadQ6y9i8gqJ7vHu/p5vongYX7x6yffhgYKPtMLiEAjMtR6wpm+eCnoOfUfUros3Ff2gdURLFTvM+KHxKwxGHoI1CDB6r1gxNaL8+DLhK+L4zxs1czSyG8q7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAmhcnpv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723036640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHA0OK62AwchNJ57FFfHC78h5WPF4JbQaFxR5tsk1xg=;
	b=eAmhcnpvl/2eNn9cpDs3BOrWWqnW3+dEXoZprGiEJirGovC4FcJSecImq2PusOyya3GIKY
	/0BYA7eYY9UD/EFXcNS7qisFxrKj2GzthzIuEhArNclPzLErsmMmMMqNcTMFy6ON2/sDUX
	o9VOp0egYuQm2BQNzCPXHHUUn1Ox7tM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-nl3OrPbNP4W8m8ZBwtmkdg-1; Wed,
 07 Aug 2024 09:17:15 -0400
X-MC-Unique: nl3OrPbNP4W8m8ZBwtmkdg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6F1F19541AA;
	Wed,  7 Aug 2024 13:17:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.97])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5BAB819560A3;
	Wed,  7 Aug 2024 13:17:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Aug 2024 15:17:11 +0200 (CEST)
Date: Wed, 7 Aug 2024 15:17:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 6/8] perf/uprobe: split uprobe_unregister()
Message-ID: <20240807131707.GB27715@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-7-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I guess you know this, but just in case...

On 07/31, Andrii Nakryiko wrote:
>
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -478,7 +478,8 @@ static void testmod_unregister_uprobe(void)
>  	mutex_lock(&testmod_uprobe_mutex);
>  
>  	if (uprobe.uprobe) {
> -		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> +		uprobe_unregister_nosync(uprobe.uprobe, &uprobe.consumer);
> +		uprobe_unregister_sync();
>  		uprobe.offset = 0;
>  		uprobe.uprobe = NULL;

this chunk has the trivial conlicts with tip perf/core

db61e6a4eee5a selftests/bpf: fix uprobe.path leak in bpf_testmod
adds path_put(&uprobe.path) here

3c83a9ad0295e make uprobe_register() return struct uprobe *
removes the "uprobe.offset = 0;" line.

Oleg.


