Return-Path: <linux-kernel+bounces-253389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F0932068
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929331C21442
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEA1C6A4;
	Tue, 16 Jul 2024 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avJq/JYi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E31862C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721110980; cv=none; b=eMH+o/LMba/teLTaV4jRdltoQCwYZ39wa0w9VR5NLXNRXSZAdsXFU3ikzu7OC0fB6BE8gMXsK+ttRVUuVnyDYY8Pe4EycJabEobyKNSzC86nCfJf4cdlqNPgrqlQH+SlseRCrJ4kCYmMwRiTZwgnnsVWpv9oHw/Pfs02uu/1AHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721110980; c=relaxed/simple;
	bh=fD3MfLU3ikk/UuUZdhypDiJ9UTHRdvVQ0KcNRCRsAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKyNYFgmyVMv0AtwucLLWYHZpSTOrmh7hINTOuNpPxY5tEt49GfCczkxvWD1x4zqlXMVv+JvNDqdoZkL+wreIqspm3Jwmr/SyS/1TWiFndziukKi54xzAJERIZXH1oGBynLTcBywXz7Xf+BZZX040IDM6g3S21gtllj/j0XYcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avJq/JYi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721110977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqKn77J468u2b1ZYWnF9Bn5NYZUmxmPmv9PF18q3/+M=;
	b=avJq/JYiOs1lKscfqv5rhlUA8LdgBcWCgIxo0TKUTgSVWIuKdD9YfQhwf835/63SKRaXB9
	cMQK96b5nSsFYvzBFaoxsn5NeJFBg/ploN6bN7X6GVS4gTUFjPGrKxq0NHIlt7QBjgC18S
	1nbJ0Sa4gxQ+KMR9CB69fB6/YKxlitU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-JfpIj8o0NGGlNF0_rU1jwA-1; Tue,
 16 Jul 2024 02:22:53 -0400
X-MC-Unique: JfpIj8o0NGGlNF0_rU1jwA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 949221955D44;
	Tue, 16 Jul 2024 06:22:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 873E21955F40;
	Tue, 16 Jul 2024 06:22:42 +0000 (UTC)
Date: Tue, 16 Jul 2024 14:22:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	austindh.kim@gmail.com, rmk+kernel@armlinux.org.uk,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Message-ID: <ZpYRrsSLd2ZpUyff@MiWiFi-R3L-srv>
References: <20240713014808.1689915-1-ruanjinjie@huawei.com>
 <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
 <ff8d5b8c-088c-9e05-53b2-f86335a18b8f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8d5b8c-088c-9e05-53b2-f86335a18b8f@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/16/24 at 11:44am, Jinjie Ruan wrote:
> 
> 
> On 2024/7/15 22:48, Baoquan He wrote:
> > On 07/13/24 at 09:48am, Jinjie Ruan wrote:
> >> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
> >> as below:
> >> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
> >>
> >> And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
> >> is also ok as below:
> >> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
> >>
> >> The cause is that the crash_size is parsed and printed with "unsigned long
> >> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> >> which is 4 bytes in memblock_phys_alloc_range().
> >>
> >> Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
> >> input size.
> > 
> > I am not sure if this is a good idea. Shouldn't we handle this in
> > arch_reserve_crashkernel() to check the system RAM size?
> > 
> > With this patch, if you specify crashkernel=4352M (namely 4G+256M) in
> > kernel cmdline, then you will reserve 256M crashkernel in system, don't
> > you think that is confusing?
> 
> You are right!
> 
> In the case you mentioned, it can still allocate 256M successfully, but
> the log shows 4352M successfully allocated, which is not taken into
> account by this patch.
> 
> And handle this in arch_reserve_crashkernel() is a good idea, which will
>  bypass all these corner case, I'll do it next version.
> 
> > 
> > By the way, I am considering changing code to apply generic crashkernel
> > reservation to 32bit system. Maybe below draft code can prevent
> > crashkernel=,high from being parsed successfully on 32bit system.
> > 
> > What do you think?
> 
> I agree with you, I've thought about passing in a parameter in the
> generic interface whether high is supported or not to implement it,
> which is so incompatible. An architecture-defined macro to filter out
> parsing of "high" fundamentally avoid using the generic interface to
> allocate memory in "high" for the architecture that does not support
> "high". The below code do prevent "crashkernel=,high" from being parsed
> successfully on 32bit system.
> 
> But if it is to support 32 bit system to use generic crash memory
> reserve interface, reserve_crashkernel_generic() needs more modification
> , as it may try to allocate memory at high.

You are right. Below change may be able to fix that. 

And I have been thinking if one case need be taken off in which the
first attempt was for high memory, then fall back to low memory. Surely,
this is not related to the 32bit crashkernel reservation.

By the way, do you figure out these issues from code reading and qemu
testing, or there's need for deploying kdump on 32bit system, e.g i386
or arm32? Just curious.

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..ac087ba442cd 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
+			if (search_base != search_end)
+				goto retry;
 		}
 
 		/*


