Return-Path: <linux-kernel+bounces-276020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287BF948D63
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3271C203B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF61C231F;
	Tue,  6 Aug 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEW1ZGvx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDF1C0DF8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942159; cv=none; b=DJw7oMMn1za3BtPqggwgvSF4w1HMPKEy8hf1fX+EaAfFXJiPjKbmuOnvkZonJ0wPwkHWWb5dLby7S4kgRD9Azqxg4c8JVRxCPSUt+98b6DT2AYVM37g36765ye5ZQ7d8VxpBQKhaiiqZm53XZL/wBZsqS2uzWODIjc4yR1wmgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942159; c=relaxed/simple;
	bh=WPIwI17hwcZxWai6yGSu9rydstpOwlzbWRHp6gl8JV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2NrcfN/M0ofv8l0knSDBeJq3C6F2MLW7hdPAMb2uwba0AvDKaTRVzBM/allphXE5HbJaE8cP1VrYQ8/HyllgnYwVD6eGaOwD823pQxQcCVncblIpOeuk2xYbWl1tX4cyyO2xCsipv985Is4x/Mvu8YpvGMaTgn2UoHFbyTfDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEW1ZGvx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722942156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dG/wdq4KNgGfbSlTIoCrxrVcBX6174acHdMyq7P0THM=;
	b=YEW1ZGvxGEz+uefnqhgmYapIzPpTv68plgqESObYixGo+ipXFN6RloLOiqmnPfofVzGeaP
	6FNkhqVhKSa2qj9kcsKwaYe0w1NNzv/TMVu47tIVESThLcNI6bsCk73VBOOHU3YNxrIwZR
	sYfhoMzrkuts/DdowezD7/9a56X0J9Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-jCS_w4KXPe60S2XtvRMnDA-1; Tue,
 06 Aug 2024 07:02:33 -0400
X-MC-Unique: jCS_w4KXPe60S2XtvRMnDA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCB6B1955D44;
	Tue,  6 Aug 2024 11:02:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8128319560AE;
	Tue,  6 Aug 2024 11:02:29 +0000 (UTC)
Date: Tue, 6 Aug 2024 19:02:20 +0800
From: Baoquan He <bhe@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Message-ID: <ZrICvLH9YDHfC7MA@MiWiFi-R3L-srv>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
 <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
 <ZrA/QWAy2iXl/Oc4@MiWiFi-R3L-srv>
 <8f051483-46be-87b6-03bb-5e0d145a2ac3@huawei.com>
 <ZrHasuAXM2Ph9V5p@MiWiFi-R3L-srv>
 <ZrHgH9hFADBJrtJ6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrHgH9hFADBJrtJ6@shell.armlinux.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/06/24 at 09:34am, Russell King (Oracle) wrote:
> On Tue, Aug 06, 2024 at 04:11:30PM +0800, Baoquan He wrote:
> > I am fine with it. BUT have you addressed Russell's concern, e.g how to
> > test it actually?
> 
> Thanks for bringing that up.
> 
> Let me reinforce my position on this. I will _not_ be accepting a patch
> that allows the crash kernel to be placed into high memory on 32-bit
> ARM unless it has been thoroughly tested to prove that it can actually
> work.
> 
> Right now, I don't believe it can work as placing the kernel in highmem
> likely means it will be located *outside* of the lower 4GiB of physical
> memory which is all that will be accessible when the MMU is turned off.
> This is a pre-condition to boot a kernel - the kernel image _must_ be
> located within a region of memory which is exposed to the CPU when the
> MMU is turned off.
> 
> Unless it can be proven that placing the kernel in highmem means that
> the kernel will be located in the lower 4GiB of physical memory space
> with the MMU off, then further work on this patch is a waste of time.

Yeah, totally agree.


