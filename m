Return-Path: <linux-kernel+bounces-256492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A36934F45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D9B1C21DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571F1422C5;
	Thu, 18 Jul 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeftKm0I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967212F5A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313794; cv=none; b=NgKGEGakoE1/3AayiDgMfx1K2bKfrLttajHrUqJ0S85U7guFh2ya+C+nSXdaOwOHjL4tKPsH3ioBtSpJCzNdc6ORFPzTAU5sPZPXpoQbiM3tLLk80te0qXwAMasxeX0O1Jaeec4Jvevk1Oy3xqjHC5rSCnGG/TkjNQnzfJFK6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313794; c=relaxed/simple;
	bh=fiuEXO+y1CkUzUqy875cO3o952AlVtjQ88C3mZeRhUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eICxVPhJS/UO5M+8p+q7WkY8V/QeH2KztQ/sd5u+bFxnwdBNs9fx0zrYNBpEAAXDsYj7BAP+UjqpGqACialj9Z53OZYdqjWwcce4Y9/tqK8GC8zp8MXe3EtJvlQ8sgq/BsdSu9oPsK+jb1GhoqzVRzC6MI8ui9eOPXuo2+sKDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CeftKm0I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721313792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJrnZFWbEYDfYCgkGw1MmmGbtaUVBD+dZ8bSRNzGKmo=;
	b=CeftKm0ItfWk0QG2yRWRkLiPH6rmhU2NKY45AGzyqlboJE2SB//3Y9lDA4AdX8ox2hORrd
	HmkK17uC2cKZvpxkNlN/Rec4aja4NZ565do8l9I4gHtXVD9nZPsC3nZiCyfrrA5yz6u6dq
	cMU8tb2olfyRTUeEbCFoI3PMzJaYZbY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-wwEfdrw0NfmVBBmg15EUHg-1; Thu,
 18 Jul 2024 10:43:07 -0400
X-MC-Unique: wwEfdrw0NfmVBBmg15EUHg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 553071954223;
	Thu, 18 Jul 2024 14:42:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B42773000185;
	Thu, 18 Jul 2024 14:42:53 +0000 (UTC)
Date: Thu, 18 Jul 2024 22:42:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, vgoyal@redhat.com,
	dyoung@redhat.com, arnd@arndb.de, afd@ti.com,
	linus.walleij@linaro.org, akpm@linux-foundation.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org,
	javierm@redhat.com, deller@gmx.de, robh@kernel.org,
	hbathini@linux.ibm.com, thunder.leizhen@huawei.com,
	chenjiahao16@huawei.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] crash: Fix x86_32 crash memory reserve dead loop
 bug at high
Message-ID: <Zpkp4iF7quCOq7k0@MiWiFi-R3L-srv>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
 <20240718035444.2977105-3-ruanjinjie@huawei.com>
 <Zpj4+G5OwTYBQGIA@MiWiFi-R3L-srv>
 <aca0795c-f1a8-20c1-3daf-7f39d2ebf1bc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca0795c-f1a8-20c1-3daf-7f39d2ebf1bc@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/18/24 at 08:10pm, Jinjie Ruan wrote:
> 
> 
> On 2024/7/18 19:14, Baoquan He wrote:
> > On 07/18/24 at 11:54am, Jinjie Ruan wrote:
> > 
> > I don't fully catch the subject, what does the 'dead loop bug at high'
> > mean?
> 
> It means alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] repeatedly
> which corresponds to the crashkernel parameter of the "high".

That may mislead people to think it's a crashkernel=,high setting and
the corresponding issue.

Maybe "crash: Fix x86_32 crashkernel reservation dead loop" is good
enough.


