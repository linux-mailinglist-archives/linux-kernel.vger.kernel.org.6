Return-Path: <linux-kernel+bounces-273214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B59465DF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE58281893
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C8132116;
	Fri,  2 Aug 2024 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAtufjKf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58A1ABEDD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637323; cv=none; b=ZnN0HmJ3y2AQBhtn1XICeCu+TAQiY1E1t6UiTPt2icsxLScbmQVuO57uyy/LfnRgZy70lviHRctUaodL6xSROF+J6s+njxBL+h6eccHfqTWWcxQzuBz7j/Q0wB3CD3pAcB9oFwl35YdsLMh59kBkzm0CGcSEp5qDFSBCMNvvjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637323; c=relaxed/simple;
	bh=aWddOL4huCXK8ZmFVBtZPClQfZwV5rM5X8tjOAmTyog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqEQwL240Aj2qcFYzJs3R8G0ipmn2ciP53+BXKs/KwWTNlZpyYgPmMSyTij9Vg0vy/ZLw8Efv1ESbZPOfOqysxVQasq2Ygv5F8t5t+JUw9FphhWg65XJ1m0cRiqI+B/tn0bApqWSFp6B6p/sf+k1hA7Oz+EM5ZEK6u4L/GZjtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAtufjKf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722637320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWddOL4huCXK8ZmFVBtZPClQfZwV5rM5X8tjOAmTyog=;
	b=aAtufjKfkUWfrIxrpLN9DbbnahKQ82OTwd2qgfHhXKaPfRjMsc5gw3z1rM1hBQXXKGFvVn
	YehRHWhCS32mUqMyBCjhlbGdBbjqqNC3IhXKDYDgN5FYmkpCnLracyF9pF+W2QQq2trhup
	6q8uHtTVxDBjU0HvXvDpGZv4cU4/4Wg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-kC7maBpROvmsyDx2ahMgdQ-1; Fri,
 02 Aug 2024 18:21:57 -0400
X-MC-Unique: kC7maBpROvmsyDx2ahMgdQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E6061955F67;
	Fri,  2 Aug 2024 22:21:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9958E19560AE;
	Fri,  2 Aug 2024 22:21:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  3 Aug 2024 00:21:53 +0200 (CEST)
Date: Sat, 3 Aug 2024 00:21:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <keescook@chromium.org>, srikar@linux.vnet.ibm.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"glider@google.com" <glider@google.com>,
	Matthew Wilcox <willy@infradead.org>, zokeefe@google.com,
	hughd@google.com, luto@amacapital.net,
	"jmarchan@redhat.com" <jmarchan@redhat.com>,
	"rientjes@google.com" <rientjes@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: question on [uprobes] special vma
Message-ID: <20240802222145.GC20135@redhat.com>
References: <CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com>
 <20240802090040.GB12343@redhat.com>
 <CABi2SkXqkC3wX4wnhXTXrLSs-6PLO-Fj4g=Hcvqq=ppv4QWUzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkXqkC3wX4wnhXTXrLSs-6PLO-Fj4g=Hcvqq=ppv4QWUzA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/02, Jeff Xu wrote:
>
> > So it seems that xol_add_vma() can just pass the additional VM_SEALED
> > flag to _install_special_mapping(), no?
> >
> Yes. Before I make that change, I want to confirm that [uprobes] VMA
> is immutable during the lifetime of the process, hence this email.

OK, thanks,

> > But why it depends on CONFIG_64_BIT?
> >
> It needn't, but the vm_flags_t in the vma struct for 32 bit is full,

Ah, indeed ;)

Thanks!

Oleg.


