Return-Path: <linux-kernel+bounces-415352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F89D34E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4D71F20A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5671684B4;
	Wed, 20 Nov 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcnO1GKa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEB15E5BB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089399; cv=none; b=lo2e0hCl+1lEFFyoYJGjFUbPl6MPGLGeCTjRRSMzHwGryMvHhh8eI3wEnVWBNjJDqlpUUkhp2Zxa5MclOPNoxBI/JneVRlNiLgWu4E6kcHxY+qoDy2+rH/QerJWr8bFUDaOieNA22Y5T0LPmx1auo4bsRzd4SUviV+e1pxAS3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089399; c=relaxed/simple;
	bh=H03/gBpmwbvm4SJnHDtHA8ja+q2ofpTmCh+NLQXYzqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROaFnuhLTA6B61a7WTXAPia7aOKax2473GTG+iy+kkbf0iAuTUpa1PVGJXqEkcFvqbQjtN8dgTG0XpRK3zd18tmbJRq9M8jBMK6vnoJ3iK+Da5e4PTJdmHhS7WOMc/76Z2/c9/MS3l0XooJe7po6N0DLwGOPoHLvB3txJ2+ItH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcnO1GKa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732089396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZbxayy/768/C/Pe+6yfnqyUJU/CL7fFAORA24PtnR8=;
	b=VcnO1GKatMLxtW+mPNJUwxmy6kbx9chutaVJ9Nv8w7SMIzeClKORRPF6udEdEzPO5R2j6V
	ps7AEfpITBELHhlEMjNvmAEUHsIkt+T594CNQaOIfphdAaHTyyESTZnP85qDtugyPP1V1N
	9F+RW23q0ZqyNn6KhqwGPGlWyDoISU4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-HYED_1jDNkqjUkn_wPlzyw-1; Wed,
 20 Nov 2024 02:56:32 -0500
X-MC-Unique: HYED_1jDNkqjUkn_wPlzyw-1
X-Mimecast-MFC-AGG-ID: HYED_1jDNkqjUkn_wPlzyw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 514CF195609F;
	Wed, 20 Nov 2024 07:56:31 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED1301956086;
	Wed, 20 Nov 2024 07:56:29 +0000 (UTC)
Date: Wed, 20 Nov 2024 15:56:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <Zz2WKFxkOJNZrI5H@MiWiFi-R3L-srv>
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
 <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
 <ZzwA53x3KYQgDbeQ@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzwA53x3KYQgDbeQ@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/19/24 at 11:07am, Baoquan He wrote:
> On 11/18/24 at 09:19am, Tom Lendacky wrote:
> > On 11/17/24 19:08, Baoquan He wrote:
......snip.......
> > >  /*
> > >   * Examine the physical address to determine if it is boot data by checking
> > >   * it against the boot params setup_data chain.
> > >   */
> > > -static bool memremap_is_setup_data(resource_size_t phys_addr,
> > > -				   unsigned long size)
> > > +static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
> > 
> > Oh, I see why the __ref is needed now, because this calls an __init
> > function based on the early bool.
> 
> Exactly, I explained in another thread replying to you, it could be
> ignored.
> 
> > 
> > While this nicely consolidates the checking, I'll let the x86
> > maintainers decide whether they like that an __init function is calling
> > a non __init function.
> ...... snip.......
> > > -	return false;
> > > +static bool early_memremap_is_setup_data(resource_size_t phys_addr,

Hi Tom, Ingo,

What's your suggestion about the __init and __ref adding/removing on
below functions as Tom pointed out?

> > 
> > This should retain the original __init reference.
> 
> OK, so you suggest they are like below, right?
> 
> static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
>                                                 bool early)
> {
> 	......
> }
> 
> static bool memremap_is_setup_data(resource_size_t phys_addr)
> {
>         return __memremap_is_setup_data(phys_addr, false);
> }
>  
> static bool __init early_memremap_is_setup_data(resource_size_t phys_addr)
> {
>         return __memremap_is_setup_data(phys_addr, true);
> }
> 
> I can make v3 if we all agree on this.
> 


