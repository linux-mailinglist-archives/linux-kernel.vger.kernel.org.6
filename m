Return-Path: <linux-kernel+bounces-245180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19692AF5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664EF282375
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CA4D8BB;
	Tue,  9 Jul 2024 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Frgybxd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13140394
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502141; cv=none; b=toN6lItv1VP9eQKmFKaDW+faDFknBzulU+hp/4RvxQd8HNYr268eEKTjS7Kl0LqZKGADqo/2wZJowf0CSbbNIwG6GcIpx9FBd8vfnlscUd4IOukua9zcionshG7w8eLwkwojB3B4NONswJxO2M18zaHPQt1QvNhVnH8G5ykMVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502141; c=relaxed/simple;
	bh=xXqh1hV/4Uj1TIrRLd1FPZZpSpZUs6aVKukJQDZw/Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMREe4B6rhaxJ3F6PCeQMSgOuf+QBzK1cyx/YivXMnrVU4R14Ysg/GL1YJbycJRLLayyyFQTVcADXQVPWYL0Cbq67T1giH/1T7ZgeTHP8rWBR0MQmHsy2l74pwtMIdCHYcyH2s4MkwseLsVamKgycLR0KgpiPU0+2+V/hfQ1uFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Frgybxd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1955FC32782;
	Tue,  9 Jul 2024 05:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720502140;
	bh=xXqh1hV/4Uj1TIrRLd1FPZZpSpZUs6aVKukJQDZw/Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Frgybxd0MSjkW+yDK9Dvnc/unxAzUIHQqfbWAgWT/2zqyZ1K+kHoHY/DKFolPu8dh
	 WXcbUlJt0G1feqmDv5xnb3VuGX8E6wKZXlnW81Y5k9Kx1aG6T80rkkwDUtglBauZFj
	 ZUjTZ/bkstCMlTZFlDX/KkmXCOlhlXOk6NwmA7JE=
Date: Tue, 9 Jul 2024 07:15:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jim Mattson <jmattson@google.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH 5.10] x86/retpoline: Move a NOENDBR annotation to the
 SRSO dummy return thunk
Message-ID: <2024070949-blame-emperor-a764@gregkh>
References: <20240708164319.3801778-1-jmattson@google.com>
 <20240708170541.GGZowcZZ0tZmt7znYA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708170541.GGZowcZZ0tZmt7znYA@fat_crate.local>

On Mon, Jul 08, 2024 at 07:05:41PM +0200, Borislav Petkov wrote:
> On Mon, Jul 08, 2024 at 09:43:05AM -0700, Jim Mattson wrote:
> > The linux-5.10-y backport of commit b377c66ae350 ("x86/retpoline: Add
> > NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
> > NOENDBR annotation, repeating the annotation on __x86_return_thunk,
> > rather than adding the annotation to the !CONFIG_CPU_SRSO version of
> > srso_alias_untrain_ret, as intended.
> > 
> > Move the annotation to the right place.
> > 
> > Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
> > Reported-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/lib/retpoline.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> > index ab9b047790dd..d1902213a0d6 100644
> > --- a/arch/x86/lib/retpoline.S
> > +++ b/arch/x86/lib/retpoline.S
> > @@ -105,6 +105,7 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
> >  /* dummy definition for alternatives */
> >  SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
> >  	ANNOTATE_UNRET_SAFE
> > +	ANNOTATE_NOENDBR
> >  	ret
> >  	int3
> >  SYM_FUNC_END(srso_alias_untrain_ret)
> > @@ -258,7 +259,6 @@ SYM_CODE_START(__x86_return_thunk)
> >  	UNWIND_HINT_FUNC
> >  	ANNOTATE_NOENDBR
> >  	ANNOTATE_UNRET_SAFE
> > -	ANNOTATE_NOENDBR
> 
> Whoops, those two here didn't look right, thanks for catching this.
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> And looking at 6.1, it is wrong there too. :-\
> 
> commit 7ef6a7f9b32fdfc8bec0a10e6d5ac5374d4f02e7
> Author: Borislav Petkov (AMD) <bp@alien8.de>
> Date:   Fri Apr 5 16:46:37 2024 +0200
> 
>     x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk
>     
>     commit b377c66ae3509ccea596512d6afb4777711c4870 upstream.
> 
> Greg (KH - there's another Greg on CC too :-)), do you prefer such stable-only
> fixes like that or should we revert the wrong backports and redo them?

Sending fixups like this, for things that are already committed are
fine.  But note, someone needs to at least send them to the right place
(i.e. no one cc:ed stable@vger.kernel.org...) if they wish to see them
applied to a stable kernel...

thanks,

greg k-h

