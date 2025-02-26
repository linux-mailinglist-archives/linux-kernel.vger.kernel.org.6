Return-Path: <linux-kernel+bounces-534664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F726A469B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04717A3B35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714D242914;
	Wed, 26 Feb 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIXtaLXN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473724290C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594111; cv=none; b=A9q4OwAJqUcLkMWBaVzWPGE1ctVvjdqTYmpUG8SpO/Q9IXatr4f0BI1kDR90pLNPw8GPEiqr6QCrLglMZXdTnnMChnTq4KQHHb6CB6y9jS+xOeYHw5IgE9f7CFQCK8x6i2y7Ne1pmWud81tz1DnNJvhnMB5ihxoXOcHX4cMegN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594111; c=relaxed/simple;
	bh=J7ovxnKT0ZvQVH613CvGpayHDJqrYNEgWsiZJWPhdB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayT1hEuJJ8kmlo5iJ+uclXxvzFv+EHtH0cxYs3GVh60+HsmCuOdYoUe/jKDoHcptNoaGplRFDeak+jY9sjakTtLeo7rzM/IaTUgdPhnUpdO5qGbfCPlXdwbX8f+J+VuXuf4AtnSCnlRq9bTjSYoApB68Itm+0+qf7PD7EEXqcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIXtaLXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740594109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1F9I/iZ8TAs5hDxt1ttZ19kx2JlBHbTF4jlMhaCVOo=;
	b=MIXtaLXNnTuYXPTKGd+quTwwlUJKo+2gs2YRZrj2NgRNZZdXRBxcJhOXgH5MvxHuEhT882
	+Fu5yuYYlpp0UF5FFP8Wt5Qt7RIzIyPo7R0wSrJc3WkfL1zFwTDePIEgDc1eaJO4MGMY+G
	QFh0Osp61MBl+uA701eWezlaIE+JH0E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-xJSHAuiPNtaqTVVQa1RKpQ-1; Wed,
 26 Feb 2025 13:21:44 -0500
X-MC-Unique: xJSHAuiPNtaqTVVQa1RKpQ-1
X-Mimecast-MFC-AGG-ID: xJSHAuiPNtaqTVVQa1RKpQ_1740594100
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4022B19039C5;
	Wed, 26 Feb 2025 18:21:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CF318300018D;
	Wed, 26 Feb 2025 18:21:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 19:21:08 +0100 (CET)
Date: Wed, 26 Feb 2025 19:20:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
	avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <20250226182050.GK8995@redhat.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
 <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com>
 <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/26, Lorenzo Stoakes wrote:
>
> Like I said, Jeff opposes the change. I disagree with him, and agree with you,
> because this is very silly.
>
> But I don't want to hold up this series with that discussion (this is for his
> sake...)

Neither me, so lets go with VM_SEALED_SYSMAP.

My only objection is that

	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
	vm_flags |= VM_SEALED_SYSMAP;

looks unnecessarily confusing to me,

	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMAP;

or just

	vma = _install_special_mapping(...,
				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMAP,
				...

looks more readable. But this is cosmetic/subjective, so I won't argue/insist.

> Jeff - perhaps drop this and let's return to it in a follow up so this series
> isn't held up?

Up to you and Jeff.

But this patch looks "natural" to me in this series.

Oleg.


