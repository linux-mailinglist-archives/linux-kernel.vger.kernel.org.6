Return-Path: <linux-kernel+bounces-288017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B4953086
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F281A286CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982E19F49C;
	Thu, 15 Aug 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GgrQHBAG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4019DF60
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729423; cv=none; b=o2CMDTHl97+Yx2S4JYzUp6bBqPcnyiQoNOuBLNmRHVq1dGHs9UNF//CMieREdOxVUu1ogU+oPnaiGVZVT9OlDONhdVlItYD23W0l6mDCqC1DbWcq8RYrey03bICAd5IzwcH/P4qhXXyY7ICHgZaAwlaUHpFYFlMtVTnD3mHCVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729423; c=relaxed/simple;
	bh=O4yLnFi4rtD8pwc4Wy5KyRHItfx+wXhhebwLRzGiYfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgKmw6DTAtWW7qc7v8yowY4F33o5Rxoz2a3GvndmNkA9q9QvKrbbk5SwtqM8xDZXwZoNtiFa62GCGAd9stPDFhAmqI6dNl4l8N98QhawWIznJ1/aPOLF/BUf83j7YHTbo+OlZoXzxWdIIGo+SjcsLMYbf9lL+xYqW9c7pUvwcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GgrQHBAG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso8619295e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723729420; x=1724334220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tto6eM9hNP9kwaU98qa0E0bzpJp65GdsSW76u9NX6RA=;
        b=GgrQHBAGeIEIjbNkt1Jh5jvZ58HV3lHTeS6kFyL1HfRm7m1DyKOeYxZEW4Sig2l5Zn
         PoLoNK8E6ZjHcON96BbUowhxQ9pvbW6SsixsemarJslXG5iJrVRYylclo6vO7LkJGC4p
         Xjz+/a7FRI46hBQgAGLLOwE9B1QokU1ZQyUoOHyukJ9D4r//bgbq/HsM/6Tfq38fdQpe
         u04VLdOeC+7hxTWiNtezyTzJ6whhhJdR8fhs7E0F1jf8SdlMhactZ8nMEFAKN6z8UssS
         Hg05X5pNwZUeWzV2rioBcTj3qjw2zcMizEiJUa6/gefTbQ8CtxgLxn12lP/s0A//jrwo
         CthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729420; x=1724334220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tto6eM9hNP9kwaU98qa0E0bzpJp65GdsSW76u9NX6RA=;
        b=o8a61ucay6ewRJxo0fI7HmgyBA/A9yxLB08O3ZFKZQZQ/tR69UmveJ7Yp84qvAUCMF
         nGN7Okh+qtqw+7RP+sgx9yh+9ne+0I9mN5QQEaLvjADkUhQNGlk4NACUoWexRYurTdQd
         cS6jFFl/Bq9An/wJ0JBFmr+R+4QcDGowht2VzTwlACnDMx1EUbBUYUV5IK+W7bt2RhYf
         V1lpx4AdgpIcHc1Zoz6UreyDkwmha2829HIV8OAFeEqUn1GpgEBomLSQpsKuOMA4cqNu
         wvykri4iH1o7qRDNEEsKCWYRQF3TyUOvau0ay3ebv2Wsquu78ERHFnwbeMR2leo3YTna
         n1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPx/ZVZDNwx/woIcfljeG61HGKdWiBZTY2kEOzrecES9U4ENpqw91agMAW3JissR5L3hc0taxPdDTvNS9xPyV+x39lDOGDaMClnV+i
X-Gm-Message-State: AOJu0Yzf+Rw2AU4ZS1wh5AW6vgZOrCVovoFguKiZG6Rp9EMCbHNqkMpC
	iLRNRCrMRQNGBmSQV2p9N4MSAPNF7NZps2LpRvWsmEZUMVj+3hU51A/3qshnnpI=
X-Google-Smtp-Source: AGHT+IFBN0eoxUO6gO0o4RftKhcYBMgFTRCPjkqUHwDSFbLveCxPzSAiRKMU11VMwlnvN1NNkNtixQ==
X-Received: by 2002:adf:e10a:0:b0:368:5042:25f3 with SMTP id ffacd0b85a97d-37177783510mr5153752f8f.34.1723729419493;
        Thu, 15 Aug 2024 06:43:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946538sm103525766b.151.2024.08.15.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:43:39 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:43:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [POC 2/7] livepatch: Allow to handle lifetime of shadow
 variables using the livepatch state
Message-ID: <Zr4GCYkfof1aJ-hp@pathway.suse.cz>
References: <20231110170428.6664-1-pmladek@suse.com>
 <20231110170428.6664-3-pmladek@suse.com>
 <alpine.LSU.2.21.2407251329300.21729@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2407251329300.21729@pobox.suse.cz>

On Thu 2024-07-25 13:31:40, Miroslav Benes wrote:
> > diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
> > index 6693d808106b..4ec65afe3a43 100644
> > --- a/kernel/livepatch/state.c
> > +++ b/kernel/livepatch/state.c
> > @@ -198,11 +198,17 @@ void klp_release_states(struct klp_patch *patch)
> >  		if (is_state_in_other_patches(patch, state))
> >  			continue;
> >  
> > -		if (!state->callbacks.release)
> > -			continue;
> > -
> > -		if (state->callbacks.setup_succeeded)
> > +		if (state->callbacks.release && state->callbacks.setup_succeeded)
> >  			state->callbacks.release(patch, state);
> > +
> > +		if (state->is_shadow)
> > +			klp_shadow_free_all(state->id, state->callbacks.shadow_dtor);
> 
> The following
> 
> > +		/*
> > +		 * The @release callback is supposed to restore the original
> > +		 * state before the @setup callback was called.
> > +		 */
> > +		state->callbacks.setup_succeeded = 0;
> 
> should go to the previous patch perhaps?

Great catch!

I am going to refactor the code in the next version so that it would
look like:

void klp_states_post_unpatch(struct klp_patch *patch)
{
	struct klp_state *state;

	klp_for_each_state(patch, state) {
		if (is_state_in_other_patches(patch, state))
			continue;

		if (!state->callbacks.pre_patch_succeeded)
			continue;

		if (state->callbacks.post_unpatch)
			state->callbacks.post_unpatch(patch, state);

+		if (state->is_shadow)
+			klp_shadow_free_all(state->id, state->callbacks.shadow_dtor);
+
		state->callbacks.pre_patch_succeeded = 0;
	}
}


Best Regards,
Petr


