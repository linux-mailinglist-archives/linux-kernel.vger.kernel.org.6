Return-Path: <linux-kernel+bounces-410139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDD39CD507
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D88B23656
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E05A7AA;
	Fri, 15 Nov 2024 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CImER+3l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA11E522
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633821; cv=none; b=avL2Rg7pBbSG2ArvEZ6+/2iMgwPFRibDF7bOoPLjDKx/u/vrU+kPVpCnVOBqt1D7bYj2dd2FB1E41Yal44S7lVoO4lckZWA1riGYU3w1CwuIrxoc2DyJ9aB7W22D5SLU9qbhuGH0p4SD5cRNC/OwjK/ULMzIc8+/WnoxPNIuJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633821; c=relaxed/simple;
	bh=qJdppurHsZwUIEn8LZrPDH6CYULyvMtl4kNytxJWmP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC9Sgbaz76dlZYdon12wg0KrKOQzjkAbxhWNufMpHBVhWykU5/yQtPU2vG57sjGuhw+lj+XRtGo+AZryzdzjoB5kHsGs17aZKFh/8AQJRGVHZLL3bz5+Aow9SWejqoohKSkbfioDlgLOrAp//pik+vEzS1MUL40WQ2ucuvRaH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CImER+3l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731633818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auIunFr57gOFN1FNFHA32Az1353D4ZZkXxzIl3P/F3I=;
	b=CImER+3lbQfmzYqcdd+OLZru2oldshHQc1rG+xuHQZi7nkH/bomJqmplCS5T3STImy/DNk
	qdXcrqU8mHhZfAhS12Qt9VwnPYlpoYdk5rb/jSJDEvneP7J2/yGIcyQ2X+ygG2yhZLpoyl
	uGVsQNGQgHhzvzZZmvEiix+TZB9uySc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-jer0dGJqMXqiUqm9a4LeyA-1; Thu,
 14 Nov 2024 20:23:35 -0500
X-MC-Unique: jer0dGJqMXqiUqm9a4LeyA-1
X-Mimecast-MFC-AGG-ID: jer0dGJqMXqiUqm9a4LeyA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC0321955D62;
	Fri, 15 Nov 2024 01:23:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC931955F43;
	Fri, 15 Nov 2024 01:23:31 +0000 (UTC)
Date: Fri, 15 Nov 2024 09:23:27 +0800
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: x86@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	bp@alien8.de
Subject: Re: [PATCH 0/3] x86/ioremap: clean up the mess in xxx_is_setup_data
Message-ID: <Zzaij4fbgBdMYqdi@MiWiFi-R3L-srv>
References: <20241115012131.509226-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115012131.509226-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Also CC kexec list.

On 11/15/24 at 09:21am, Baoquan He wrote:
> Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> share completely the same process and handling, except of the
> different memremap/unmap invocations. The code can be extracted and put
> into a helper function __memremap_is_setup_data().
> 
> And parameter 'size' is unused in implementation of memremap_is_efi_data(),
> memremap_is_setup_data and early_memremap_is_setup_data().
> 
> This patchset is made to clean them up. It sits on top of tip/x86/urgent
> commit 8d9ffb2fe65a ("x86/mm: Fix a kdump kernel failure on SME system
> when CONFIG_IMA_KEXEC=y")
> 
> Baoquan He (3):
>   x86/ioremap: introduce helper to check if physical address is in
>     setup_data
>   x86/ioremap: use helper to implement xxx_is_setup_data()
>   x86/mm: clean up unused parameters of functions
> 
>  arch/x86/mm/ioremap.c | 117 +++++++++++++++---------------------------
>  1 file changed, 41 insertions(+), 76 deletions(-)
> 
> -- 
> 2.41.0
> 


