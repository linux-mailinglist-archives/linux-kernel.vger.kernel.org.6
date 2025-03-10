Return-Path: <linux-kernel+bounces-553518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2FEA58AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA147A4416
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345213AD05;
	Mon, 10 Mar 2025 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBodNsDw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752722EE4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577428; cv=none; b=G/H8RnUVzozIkh2Gb/FtwEbmaAifP/TL/1Ohjxt2a5litwZm0BbB6/DDb1MKxwuFpYMtcM02XTP0FqRtoX6dQBxa89dYWMTJvsgn6s+JbRuHR5T/F/aExb1mE81db6k6z4sEz32/1u/MdKRMPGlliuo0BfADbp5M0W/ctCk0aFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577428; c=relaxed/simple;
	bh=rUuBL6PtG4GanBirNtMdXheUFQk65PZlZYaCRo+8M3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQDkq5qmyzBdsWi+dTyPiLcDL25vDuvJUr/RgiYgf6FosDx1gXP3DrGJQogBnD3luTbI3EianDV3vmAWIiAbbuFhl+iR0k/c3NObruLgZyN57AOtT2bRGYWrJBqkZyZCyX60rucrpAJuRKseGDBcNQEYkRL9ka3NUnt3iIn6yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBodNsDw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741577425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XvsmY/JjLBpjK3oBugk8F8gXHOkWN8ooUJaY0xPdhNg=;
	b=cBodNsDwPwoP9HKwKi7weGTybTB0u01Ptxd3Yp7uwA/de686y7AagVNXTtQXIMByeWIWAY
	jQCAZ9wm2jdz8YoT330AjjJ7v1W6USPxvQySeyhP1gSul/MKMgAsSYiYdCkUXtTtq9p0rC
	A+z5CcLlcwj/+4x9xXe7Z8B3x6XBkSk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-5DRDCMvMM2OaPcK41SI6KQ-1; Sun,
 09 Mar 2025 23:30:22 -0400
X-MC-Unique: 5DRDCMvMM2OaPcK41SI6KQ-1
X-Mimecast-MFC-AGG-ID: 5DRDCMvMM2OaPcK41SI6KQ_1741577420
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449081956080;
	Mon, 10 Mar 2025 03:30:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.225])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85B60180094A;
	Mon, 10 Mar 2025 03:30:17 +0000 (UTC)
Date: Mon, 10 Mar 2025 11:30:12 +0800
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Coiby Xu <coxu@redhat.com>,
	dwmw2@infradead.org
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z85cxCfnRkLve16D@MiWiFi-R3L-srv>
References: <20250207080818.129165-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Andrew,

On 02/07/25 at 04:08pm, Coiby Xu wrote:
......snip...

Ping again.

This patchset is adding a generic infrastructure for luks support in
crash dumping, and it adds the support in x86 ARCH. Since the x86
related change is only located in kdump only files, won't impact other
x86 codes. Could you consider pick this into your tree?

And by the way, this is a kdump only fix, not related to KHO (Kexec
HandOver) which David suggested to adapt to earlier. Explained it here
to remove misunderstanding. 

Thanks
Baoquan

>  Documentation/admin-guide/kdump/kdump.rst |  32 ++
>  arch/x86/kernel/crash.c                   |  26 +-
>  arch/x86/kernel/kexec-bzimage64.c         |  11 +
>  arch/x86/kernel/machine_kexec_64.c        |  22 ++
>  include/linux/crash_core.h                |   7 +-
>  include/linux/crash_dump.h                |   2 +
>  include/linux/kexec.h                     |  34 ++
>  kernel/Kconfig.kexec                      |  10 +
>  kernel/Makefile                           |   1 +
>  kernel/crash_dump_dm_crypt.c              | 459 ++++++++++++++++++++++
>  kernel/kexec_file.c                       |   3 +
>  11 files changed, 604 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> 
> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
> -- 
> 2.48.1
> 


