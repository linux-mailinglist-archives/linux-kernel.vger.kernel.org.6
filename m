Return-Path: <linux-kernel+bounces-326293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BE976614
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D711F24BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180719E998;
	Thu, 12 Sep 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSaWVKtG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183A18F2CB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134901; cv=none; b=lEJh8jIU8djZeZ+x+VonIQTgpq1hsMBW6yQRB2gJYOo7sYL5OfBIpWr+v2X7LtjTH3HS0QldPQKAqMZyyUhjfOtY+wqCF7VFi8YYCjayfeTbP3I30zbypkQtiwErXnHn2evqV586Xfr79eK+d1BlXa1k1/BCm8VwpUTyRsk9tb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134901; c=relaxed/simple;
	bh=B/wFxdm9PsJbzGZDqv6XoIZHBVQVLzCBB0wOe9zejBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC9Sn+uPMdzAwVisL67631yhGszjWLxDhql/K0yhQVgMyNpoislYI8K+NtixCujegNKQjEJI4jOkHds30slvoU+LjidevJWgPLAjpuZciZ9i7iHS22Nq5TzMgyresGTfa8wFULtyoteTjao07MGp0aOnX09bX9sRhXSnek/zqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSaWVKtG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726134898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqxoiqw+842QliGENKyve7P0iOszesu17qVHDOSZ6q4=;
	b=DSaWVKtGQnkvzRGhvY1hl24hx3dJAotsFWP5/+otZ9qHrZP+2y4r2n3SaT299vSVOp1cEC
	yjhje5/GoZzNDgaheXpgLGLJBMSdc9rx9xk5fpVvROaQneazb4+MeXwmW1iCO/MHJwuoHu
	clpKsPXyUyi5IyBdjL/hBYK+XNv+vQE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-9kmFCzvVMbmuyadkSLFFog-1; Thu,
 12 Sep 2024 05:54:53 -0400
X-MC-Unique: 9kmFCzvVMbmuyadkSLFFog-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F26A81958B3E;
	Thu, 12 Sep 2024 09:54:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D03B19560AB;
	Thu, 12 Sep 2024 09:54:47 +0000 (UTC)
Date: Thu, 12 Sep 2024 17:54:43 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Petr Tesarik <petr.tesarik@suse.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Petr Tesarik <ptesarik@suse.com>, stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <ZuK6Y1+Z5x4Hvt4P@MiWiFi-R3L-srv>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
 <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Eric,

On 08/16/24 at 07:54am, Eric W. Biederman wrote:
> Petr Tesarik <petr.tesarik@suse.com> writes:
> 
> > From: Petr Tesarik <ptesarik@suse.com>
> >
> > Fix the condition to exclude the elfcorehdr segment from the SHA digest
> > calculation.
> >
> > The j iterator is an index into the output sha_regions[] array, not into
> > the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> > all subsequent segments are excluded. Besides, if the purgatory segment
> > precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> > the calculation.
> 
> I would rather make CONFIG_CRASH_HOTPLUG depend on broken.
> 
> The hash is supposed to include everything we depend upon so when
> a borken machine corrupts something we can detect that corruption
> and not attempt to take a crash dump.
> 
> The elfcorehdr is definitely something that needs to be part of the
> hash.
> 
> So please go back to the drawing board and find a way to include the
> program header in the hash even with CONFIG_CRASH_HOTPLUG.

Thanks for checking this and adding your advice, and sorry for late
reply.

It's me who suggested Eric DeVolder not adding elfcorehdr into kdump
kernel iamge hash during reviewing his patch. I need explain this if
people has concern. When I suggested this, what I considered are:

1) The code change will be much simpler. As you can see, later Eric
   DeVolder's patchset experienced rounds of reviewing and finally
   merged. Below is his final round:

   - [PATCH v28 0/8] crash: Kernel handling of CPU and memory hot un/plug

2) The efficiency will be improved very much relative to adding
   elfcorehdr to the entire hash. When cpu/mem hotplug triggered,
   we only touch elfcorehdr area, but don't need access the entire
   loading segments.

3) The elfcorehdr size is very tiny relative to kernel image and initrd.
   E.g on x86, it's less than 1M, which is tiny relative to dozens of 
   kernel image and initrd.

Surely, adding all loading segments into hash is the best. While
attracted by above benefits, I tend to not add for the time being. I am
open to this, if anyone has concern about the security and is interested
in the adding as a kernel project practice in the future, it's welcomed.

Here I'd like to request comment from Sourabh since he and other IBM dev 
added the support to ppc too. Different than generic ARCH, IBM dev can
be seen as a end user, maybe we can hear how they evaluate the balance
between the risk and benefit.

Thanks
Baoquan


