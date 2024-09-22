Return-Path: <linux-kernel+bounces-335143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1697E1C9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F924281471
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14069139D;
	Sun, 22 Sep 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPcXpHcK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4A63D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727010825; cv=none; b=W4J8PG6rapjB6CUd4KbkkS0un+6zZTLbGh6aICDuyQCorkxQ0/0IWnBBDKiYK7+282DyilqIzyrKuxeLgiPIo7rfug5uyt7ZrkoPXOgTunKudXr0Fmgei32k9CpKaF5LPrDAETl0EXristhnmXEnf64UN6spbYbhmM7BADYDquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727010825; c=relaxed/simple;
	bh=MiyF+tn+kcoh4mdbhtWHrOJ89UifnjpVtmP4/woYPFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/DDCFqYD+2qVbcCW7yfYH11RUNhavmlzEUGOGQcOMLZKX+cbmOn0TX1T/Z5zj7DkR0MaEuohy3GYWXboys54TkP4uxK3i2C4v+xRd8ZwD/jvtsWb+K5U11TuluEQw25KYbJJEh9SK1i+nGBEvdjRfZPTMopn8gChzjz8kEU1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPcXpHcK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727010822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6w+52ZmAtp9Rr2ZpQpdI5p+hg7WT52Y4HB3TS11h84=;
	b=JPcXpHcKJq1wRy1W3VI5h0/ryTjagr3mbDEmd7ZMAE+svAv6c6cAntN51Fmn1OrqRS1gsC
	FeZFBPjJkeum0Nul94/EygLO3arOTSEt3W0bbIdVT1rI/bMG5fGN0C7q7XwH3wnhiSEeth
	VX4jAzhPTnljAm6vkJDXKUKGkdMOG8w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-5sZz3x38MweqNU-bHaTFTw-1; Sun,
 22 Sep 2024 09:13:41 -0400
X-MC-Unique: 5sZz3x38MweqNU-bHaTFTw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F6DD1934BCB;
	Sun, 22 Sep 2024 13:13:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F1E2C19560AD;
	Sun, 22 Sep 2024 13:13:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 22 Sep 2024 15:13:26 +0200 (CEST)
Date: Sun, 22 Sep 2024 15:13:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: corbet@lwn.net, mhocko@suse.com, jani.nikula@intel.com,
	akpm@linux-foundation.org, brauner@kernel.org, paulmck@kernel.org,
	linux-doc@vger.kernel.org, "qiwu.chen" <qiwu.chen@transsion.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] panic: add option to dump task maps info in
 panic_print
Message-ID: <20240922131321.GC9426@redhat.com>
References: <20240922095504.7182-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922095504.7182-1-qiwu.chen@transsion.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/22, qiwu.chen wrote:
>
> +	for_each_vma(vmi, vma) {
> +		struct file *file = vma->vm_file;
> +		int flags = vma->vm_flags;
> +		unsigned long long pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
> +		struct anon_vma_name *anon_name = NULL;
> +		struct mm_struct *mm = vma->vm_mm;
> +		char buf[256] = {0};
> +		const char *name = NULL;
> +
> +		if (mm)
> +			anon_name = anon_vma_name(vma);
> +
> +		if (file) {
> +			if (anon_name) {
> +				snprintf(buf, sizeof(buf), "[anon_shmem:%s]", anon_name->name);
> +				name = buf;
> +			} else {
> +				char *f_path = d_path(file_user_path(file), buf, sizeof(buf));
> +
> +				name = IS_ERR(f_path) ? "?" : f_path;
> +			}
> +			goto print;
> +		}
> +
> +		if (vma->vm_ops && vma->vm_ops->name) {
> +			name = vma->vm_ops->name(vma);
> +			if (name)
> +				goto print;
> +		}
> +
> +		name = arch_vma_name(vma);
> +		if (!name) {
> +			if (mm) {
> +				if (vma_is_initial_heap(vma))
> +					name = "[heap]";
> +				else if (vma_is_initial_stack(vma))
> +					name = "[stack]";
> +			} else
> +				name = "[vdso]";
> +
> +			if (anon_name) {
> +				snprintf(buf, sizeof(buf), "[anon:%s]", anon_name->name);
> +				name = buf;
> +			}
> +		}
> +

Wouldn't it be better to export/reuse get_vma_name() rather than duplicate
its code ?

Oleg.


