Return-Path: <linux-kernel+bounces-422004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F609D9324
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23534283C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD9199E92;
	Tue, 26 Nov 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWjsFaLu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B1199EA2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608912; cv=none; b=gCuYVZmk0Y8noI/gGJ8XyXi8N5DJUyD8hMT21HUnPiVxtQKVTRPRZGrh5XyS79To5K9A6N/Ah2RiHYfyuZazC62gD0r2wct2NAGzmJd4YDJOD0ODPF93/kAgF5kthcuURLfancL1sAf2Zl4f/AmsWPX+woNxiCSON3ye5Gg384o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608912; c=relaxed/simple;
	bh=CoP7UMrmbMvKDleGBWq5qJEiHvf/CKr/kRZOc9eD9X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1gfv2l5UGA0n6mho6ctZ0Dp3ajw2SysDAJwVAumzNePXTGNddM4qOBq26Q8gKWxGX8CHSL+pWmDkIMPpSVGTjzAjDF3NBHe8aH1yGujP2YAP8sHe5dcOgAGN6U+FUgVgBgpyPT1wr1IUTNJ6WwR5uWbf+64hyMh6TQrr2KgdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWjsFaLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732608909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIJsInPbUi3sSbcFvyzFRJynlzxXRpEmE77ykCQYCNg=;
	b=LWjsFaLukq7ifrbhsNV2EU2oGodHFAFDT0Jeq5miedm1Jnizpcy0ZVBjIARPR2dQeLRTtA
	+3ItRclRgAd2yXOprme2aE/aX8X9lrV8ikwpPId59U1wPNyWXCz4zGxcVdsEr2c4rwbd+m
	iEbXbE5Wp+BLh1Cda2DBNWglgNoKjbM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-PEfmqJnJN6amdMgYPDg49A-1; Tue,
 26 Nov 2024 03:15:07 -0500
X-MC-Unique: PEfmqJnJN6amdMgYPDg49A-1
X-Mimecast-MFC-AGG-ID: PEfmqJnJN6amdMgYPDg49A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2917519560BE;
	Tue, 26 Nov 2024 08:15:06 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2AA6195DF81;
	Tue, 26 Nov 2024 08:15:04 +0000 (UTC)
Date: Tue, 26 Nov 2024 16:15:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <Z0WDhCYU6I3+uZuO@MiWiFi-R3L-srv>
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
 <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
 <Zz2dEcLrCtXEq4cg@gmail.com>
 <b49096ad-fbfd-393f-9f35-944eeecd91db@amd.com>
 <Z0Q-TAbXPSwFXWPI@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Q-TAbXPSwFXWPI@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/25/24 at 10:07am, Ingo Molnar wrote:
> 
> * Tom Lendacky <thomas.lendacky@amd.com> wrote:
> 
> > On 11/20/24 02:25, Ingo Molnar wrote:
> > > 
> > > * Tom Lendacky <thomas.lendacky@amd.com> wrote:
> > > 
> > >>>  /*
> > >>>   * Examine the physical address to determine if it is boot data by checking
> > >>>   * it against the boot params setup_data chain.
> > >>>   */
> > >>> -static bool memremap_is_setup_data(resource_size_t phys_addr,
> > >>> -				   unsigned long size)
> > >>> +static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
> > >>
> > >> Oh, I see why the __ref is needed now, because this calls an __init
> > >> function based on the early bool.
> > >>
> > >> While this nicely consolidates the checking, I'll let the x86
> > >> maintainers decide whether they like that an __init function is calling
> > >> a non __init function.
> > > 
> > > So why would it be a problem? Only non-__init calling __init is a bug, 
> > > because __init functions cease to exist after early bootup. Also, 
> > > calling certain kernel subsystems too early, before they are 
> > > initialized, is a bug as well.
> > 
> > I brought it up because that is what could happen if the wrong boolean
> > value is supplied to the helper function. The helper function is marked
> > non-__init but calls a __init function if the boolean value is true, hence
> > the need for the __ref tagging.
> 
> Oh, so I misunderstood your point, because you typoed the direction:
> 
>   > >> While this nicely consolidates the checking, I'll let the x86 
>   > >> maintainers decide whether they like that an __init function is 
>   > >> calling a non __init function.
> 
> The problem is the inverse: that a non-__init generic facility may be 
> calling an __init function if the wrong flag is supplied. As you wrote 
> a sentence earlier, but I only responded to this paragraph :-/
> 
> So yeah, that's a fragility indeed - which happens sometimes when 
> generic MM facilities share code (I think 
> mm/sparse.c::section_deactivate() is similar), but I tend to agree that 
> this pattern could perhaps be improved:
> 
> +                       if (early)
> +                               early_memunmap(data, SD_SIZE);
> +                       else
> +                               memunmap(data);
> 
> Could we perhaps un-__init early_memunmap(), and call memunmap() if 
> it's in a late context? (Also early_memremap_decrypted().)
> 
> That way this code could just use early_memunmap() and 
> early_memremap_decrypted() and skip the boolean complication?

If trying to skip the bool 'early' checking, we can possibly do it as
below:

                       if (system_state < SYSTEM_FREEING_INITMEM)
                               early_memunmap(data, SD_SIZE);
                       else
                               memunmap(data);

As for un-__init early_memunmap(), do you mean we just remove the __init
from early_memunmap()/early_memremap_decrypted() which are located in
kernel/early_ioremap.c and arch/x86/mm/ioremap.c? This doesn't cost much
memory, while it may make people complain if we only want to optimize
code when doing reducing code duplication, my humble opinion. Not sure
if I got your suggestion correctly.


