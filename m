Return-Path: <linux-kernel+bounces-347052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D7B98CD19
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF88228567A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FCD126BF0;
	Wed,  2 Oct 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHOYNLfM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C681723
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850203; cv=none; b=TGhU+19fpwY+GjnPIOGQneWAxamVM7lUkLX97m4604WwR9nnJaOFTyyvin6RWNBFha/GaJyWlgRx+vOL3KcQkUdDBzMGvNigp6+h8oCRhAbNKH1Z3UooVGgNfSyv5fiDsKAYuwMkeATSYjPQUOCPU35IMuS7jU2eKzee9EsfFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850203; c=relaxed/simple;
	bh=UzKoBxpbk4aL4Yx0+CEm/GEDDDVa1g3ht2MnHb5Ts/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQYdri5l+qUdX21Ex6LcTEcheNWWduHVMXLcCU1TefhD8nsR3EwOFPZ2ivXEFfIT7xjrN+NE7kGBEorTcJV58E25PEjG1Vn4mSB2Y+9MwPCsLe8SXvLtnQAtZZCgb6oeRUQVbM07oQr4MPFDztHNDev8UPhCn1smZYFg4LOwexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHOYNLfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727850200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoIq6U8qofHBQZGFVoSjI+GCS/TwH5xAxtMOanCM3vA=;
	b=KHOYNLfM6dmBdqQVanKOkVEphknBmEar7vkafClc0n2+PHPT/mcMVyJGC4ZVYgqTQZPv+S
	wMOz7aa5gtyW/Sc4TgOTQOnA3bXqe6dbEXnYyNqQ5EGSzLtioxjCUjP3ZlfZedjVZ6dnYX
	LOQRu1pPc5oiP/YanzpTfLUXVPgptmg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-y3H0uhPmP4q3HNzJ2LXVCw-1; Wed,
 02 Oct 2024 02:23:14 -0400
X-MC-Unique: y3H0uhPmP4q3HNzJ2LXVCw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3B1419560A2;
	Wed,  2 Oct 2024 06:23:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.196])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 30ABB19560AD;
	Wed,  2 Oct 2024 06:23:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Oct 2024 08:22:56 +0200 (CEST)
Date: Wed, 2 Oct 2024 08:22:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
	mingo@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 4/5] uprobes: simplify
 find_active_uprobe_rcu() VMA checks
Message-ID: <20241002062248.GA27552@redhat.com>
References: <20241001225207.2215639-1-andrii@kernel.org>
 <20241001225207.2215639-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001225207.2215639-5-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/01, Andrii Nakryiko wrote:
>
> At the point where find_active_uprobe_rcu() is used we know that VMA in
> question has triggered software breakpoint, so we don't need to validate
> vma->vm_flags. Keep only vma->vm_file NULL check.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>


> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a2e6a57f79f2..7bd9111b4e8b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2091,7 +2091,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>  	mmap_read_lock(mm);
>  	vma = vma_lookup(mm, bp_vaddr);
>  	if (vma) {
> -		if (valid_vma(vma, false)) {
> +		if (vma->vm_file) {
>  			struct inode *inode = file_inode(vma->vm_file);
>  			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
>  
> -- 
> 2.43.5
> 


