Return-Path: <linux-kernel+bounces-288039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7B9531FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9941C23F16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD51A00F5;
	Thu, 15 Aug 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MgYnEBqA"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3C762D2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730431; cv=none; b=S/r6pphL7JhsUepXdzEZqV75M/aRWKlgMF890biWdTouCBLujxLXhGZoHse1M95zcHeJwvFRvU8MM5scy+ZNq6NYaKVVuyFq5dzz/Ifk9s/4KZtT9Iyfl/fUV02g/eQSuV9sCIvQ8YCPwlYZHsxrrxlvIRTmsqIu96NYlUx8rGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730431; c=relaxed/simple;
	bh=7xANUlILESy6YV2LFAif1MvSLeko3tjm8Md9Nhef5cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP3nfNhbxm03scyaSRakrLJk27mRvJlxMlBDkI4PAjyvfqOyWNNR2AmsUIGuZW7/5ozt2U8KNJoQ7F26iutysCn37ucWjMjLAyN1C+fCOMe7sIX4rXfvxFI9P44jk4XirqOixVeZ0dyrSuG8t2ye8w9K0GyIzAWHgIy6oCaEVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MgYnEBqA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so112360966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723730427; x=1724335227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HwVmRV89v7M69T25e0wUMNayNXrK2r4ox2q3t50Vh0=;
        b=MgYnEBqAe01QO0ByugQPHrP0HnND32gzTU6PoclNB8AUgX6zBNsbc+DJfsnVdoXvqy
         j4vmoETVXeXFu9gYzYP0Gk3pzfiFO1e8a3jOmhKkTnVQ9ZlmD40DYafD4CUamEKyv5U2
         0/PlgYxynXt4k5oKwLvYnFUNS8tEbE3E+8M/kkMYWE9RfBwRo3z68T+2QcZy32b6eWhY
         DYBdh/HffJRcuOnT4Vt9kOLgenN/ZCjJnyaQc0HJaxN+GiEb6LHx8lL56TQCkQF7TFWl
         iTgkYRiNZ9MTQf0eCqpvhIbGQudo9zOXyIsAnQO72Da2APAQfuujRRgiVZN3cHuUesrw
         ACow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730427; x=1724335227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HwVmRV89v7M69T25e0wUMNayNXrK2r4ox2q3t50Vh0=;
        b=SCW6sW7uIY7+lINmZ/ISWSCDu0gHMyqGG9G7FjcLNw+GlWuxsDoGdsjv2eT3RAVxva
         95U6pwiFRlvUvefqGfDEUBGOSeSeQRs/weCJigwRBtimkn9ZATYtltpfisLq3nWYJO+B
         Qw5r0QIExvk3Exgcc5KCj9+pzJU6LiiVVt7yaYhXTgX4c/clgVtA+jX7KpACjVeo0xOC
         7OX518Vwcy8gyHHEQw+D76/NtYy7fxSjEcq4k/UJBn7KD7gvafWq1Ocz+DT1MSpDI/Ay
         VySiEqzlJHtWdJPWHIfxuifHOiWBhlvrZkkCDWPegh6G4tiAzjCH7wPMn0Sp7Jld1Lpu
         Sa9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCBG7LOKmlHTDl83BLRHK3vMoM5eDuh4092GMoIV7Hv0x5unLznZ1v6FMZ6oyLWsqRXTev8TIiLYsEyUUY2E9/OhTKHqsADW9p35yY
X-Gm-Message-State: AOJu0Yy76Ld1EkxzyTmJCmaRIYQGsBic68dLYAOmLs4RMXhjXILHdgjF
	iynMfMjbrYyk7bXHGIHkPVi6ONK6TI11v+z/nBSTBNJ5OP5vSfMLSYsjjXf+IBU=
X-Google-Smtp-Source: AGHT+IHCyNLSdEabE0mdKcxC0sz8KaFZAcheUO0DM/MffHvJBCYlYWGM/oMlpY7aMP2RKaChGYj3Hg==
X-Received: by 2002:a17:907:1c12:b0:a77:dbe2:31ff with SMTP id a640c23a62f3a-a8367049616mr410242466b.66.1723730426894;
        Thu, 15 Aug 2024 07:00:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6760sm107045166b.23.2024.08.15.07.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:00:26 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:00:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [POC 7/7] livepatching: Remove per-state version
Message-ID: <Zr4J-U-HmmtxU-BB@pathway.suse.cz>
References: <20231110170428.6664-1-pmladek@suse.com>
 <20231110170428.6664-8-pmladek@suse.com>
 <alpine.LSU.2.21.2407251553420.21729@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2407251553420.21729@pobox.suse.cz>

On Thu 2024-07-25 16:16:44, Miroslav Benes wrote:
> On Fri, 10 Nov 2023, Petr Mladek wrote:
> 
> > The livepatch state API was added to help with maintaining:
> > 
> >    + changes done by livepatch callbasks
> >    + lifetime of shadow variables
> > 
> > The original API was hard to use. Both objectives are better handled
> > by the new per-state callbacks. They are called when the state is
> > introduced or removed. There is also support for automatically freeing
> > obsolete shadow variables.
> > 
> > The new callbacks changed the view of compatibility.  The livepatch
> > can be replaced to any older one as long the current livepatch is
> > able to disable the obsolete state.
> > 
> > As a result, the new patch does not need to support the currently
> > used states. The current patch will be able to disable them.
> > 
> > The remaining question is what to do with the per-state version.
> > It was supposed to allow doing more modifications on an existing
> > state. The experience shows that it is not needed in practice.
> > 
> > Well, it still might make sense to prevent downgrade when the state
> > could not be disabled easily or when the author does not want to
> > deal with it.
> > 
> > Replace the per-state version with per-state block_disable flag.
> > It allows to handle several scenarios:
> 
> I have no opinion to be honest. block_disable flag might be sufficient in 
> the end.
> 
> [...]
> 
> > @@ -159,7 +159,9 @@ struct klp_state {
> >   * @mod:	reference to the live patch module
> >   * @objs:	object entries for kernel objects to be patched
> >   * @states:	system states that can get modified
> > + * version:	livepatch version (optional)
> >   * @replace:	replace all actively used patches
> > + *
> >   * @list:	list node for global list of actively used patches
> >   * @kobj:	kobject for sysfs resources
> >   * @obj_list:	dynamic list of the object entries
> > @@ -173,6 +175,7 @@ struct klp_patch {
> >  	struct module *mod;
> >  	struct klp_object *objs;
> >  	struct klp_state *states;
> > +	unsigned int version;
> >  	bool replace;
> 
> Is it still needed then? What would be the use case?

Heh, I think that I actually wanted to remove the version completely.
This change is not mentioned in the changelog. And the version is
no longer used in the selftests.

I am going to remove it in the next version of the patchset.


> >  /*
> >   * Check that the new livepatch will not break the existing system states.
> > - * Cumulative patches must handle all already modified states.
> > - * Non-cumulative patches can touch already modified states.
> > + * The patch could replace existing patches only when the obsolete
> > + * states can be disabled.
> >   */
> >  bool klp_is_patch_compatible(struct klp_patch *patch)
> >  {
> >  	struct klp_patch *old_patch;
> >  	struct klp_state *old_state;
> >  
> > +	/* Non-cumulative patches are always compatible. */
> > +	if (!patch->replace)
> > +		return true;
> > +
> 
> Cumulative != atomic replace. Those are two different things.

I see. :-)

Best Regards,
Petr

