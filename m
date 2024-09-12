Return-Path: <linux-kernel+bounces-326193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D59764B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42885B23187
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE418EFF4;
	Thu, 12 Sep 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3fsoZoS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E42BB0D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130127; cv=none; b=f/AWCplZ94b3gpcCvnuCbb1QKkG0f5D+uR0K1QFWi23n6f0qc7xx5/013Ms4VaFwmedLOF/EqylRxokVoor8h/Ww5EDDTopePl+cf9UzKhLTXRniVDx58+IVIfDoppqzaxQAG7J0d2tgX8rwnwTxd+H2llSdNdkeCp5wNfNtfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130127; c=relaxed/simple;
	bh=OgFEj+72M2VM/0HsvKz4tEXYVnGKDXNIzcstmxP2yAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onpUQXbr/KWeh8CEM/b9CE8jpwUVUjIj3hVgnZLtYMxXkzeoJiVSJj3o/QYaFv5ZyVOZnluZLy2Yy92dyocj2FMVB6qHLl4GXyMBccgmjBCGvl1X2plsMty9PPXWbDUiNG4qWOD6b7cL1oYzdu7EcujBzH/Ne+zE27LpBZENvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3fsoZoS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726130124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8n8VSjvILIl7oYC7bobYUFaIgZoDIf7snFAjTE/j5ps=;
	b=W3fsoZoS6XsnVr4O6JmkSx3dDaxSCODGgqf5XJOmxQsr+VQ1N+SBCPRwFiz4EmdKoyZfw9
	QbiU/+B6o6VlXc1wOiY3onskxhJvD3r2XGt07azhIPS6g5J+T1DefnTXksxzYSmic7UaO1
	D1SxC3d7nuUhhnuUfz+FCANfDI7QCEI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-2BlVXIOmMKqAuDa4ttDdxw-1; Thu,
 12 Sep 2024 04:35:21 -0400
X-MC-Unique: 2BlVXIOmMKqAuDa4ttDdxw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78FAF1955D47;
	Thu, 12 Sep 2024 08:35:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95D0119560A3;
	Thu, 12 Sep 2024 08:35:17 +0000 (UTC)
Date: Thu, 12 Sep 2024 16:35:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, akpm@linux-foundation.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v2] kexec/crash: no crash update when kexec in
 progress
Message-ID: <ZuKnwcqv9xQDNOrl@MiWiFi-R3L-srv>
References: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
 <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
 <f4dcb6b4-2da8-4355-9d89-8b41af30214d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4dcb6b4-2da8-4355-9d89-8b41af30214d@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/12/24 at 01:33pm, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 11/09/24 19:50, Baoquan He wrote:
> > On 09/11/24 at 04:51pm, Sourabh Jain wrote:
> > > The following errors are observed when kexec is done with SMT=off on
> > > powerpc.
> > > 
> > > [  358.458385] Removing IBM Power 842 compression device
> > > [  374.795734] kexec_core: Starting new kernel
> > > [  374.795748] kexec: Waking offline cpu 1.
> > > [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > > [  374.935833] kexec: Waking offline cpu 2.
> > > [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > > snip..
> > > [  375.515823] kexec: Waking offline cpu 6.
> > > [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > > [  375.695836] kexec: Waking offline cpu 7.
> > > 
> > > To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
> > > are offline are brought online during kexec. For more information, refer
> > > to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
> > > kexec"). Bringing the CPUs online triggers the crash hotplug handler,
> > > crash_handle_hotplug_event(), to update the kdump image. Since the
> > > system is on the kexec kernel boot path and the kexec lock is held, the
> > > crash_handle_hotplug_event() function fails to acquire the same lock to
> > > update the kdump image, resulting in the error messages mentioned above.
> > > 
> > > To fix this, return from crash_handle_hotplug_event() without printing
> > > the error message if kexec is in progress.
> > > 
> > > The same applies to the crash_check_hotplug_support() function. Return
> > > 0 if kexec is in progress because kernel is not in a position to update
> > > the kdump image.
> > LGTM, thanks.
> > 
> > Acked-by: Baoquan he <bhe@redhat.com>
> 
> Thank you for the Ack!
> 
> My understanding is that this patch will go upstream via the linux-next
> tree, as it is based on
> https://lore.kernel.org/all/20240902034708.88EC1C4CEC2@smtp.kernel.org/
> which is already part of the linux-next master branch. - Sourabh Jain

Then you should mark it as [PATCH linux-next] in subject.

Since this patch is in generic code, it needs Andrew's help to
pick it. Let's wait and see if Andrew need a new post to change
the subject.

Thanks
Baoquan


