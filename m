Return-Path: <linux-kernel+bounces-217748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F390B3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4391F281BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72013158DD5;
	Mon, 17 Jun 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Mcz+JNxH"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29927158D8E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635026; cv=none; b=OdChwZ3A1B0jBPUvy9axQqqk8B0KGhbaZy+dYCG4/Uvr3hY6nuS9yMHIAJQvkTUShaGkMXlwXahz9ymeFGtfAkCtL88e23SjAjTJhCm+O+ltnCEDop59qePB2rF/qtwxktW7ghb8UKdjjkrXZ45ifMd7UlHBtZ58+RK0mj1JUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635026; c=relaxed/simple;
	bh=+w5NacGNDXvynWarUJ/vhvC9Umk3yFIycpoAOn87z8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvo1kpAF+s6rUoaNi0ubSYTVqL/db+W0y+ps+qfHOJunBjQBTTas9/uXjrrqKDPTeOVQ1m+EUM3aemkII+pzLN5SkMZTWwQFWa4BTH+dmx9HSOrMdt0dP7AwEE/Kfo+lhLNlyT24VwtVCK0z0WNQvchvESpdn17vjvkQKJOXuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Mcz+JNxH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-797a7f9b552so309207985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718635024; x=1719239824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvP4+t8l416VgzjO1ZXGZmV/a/Zd7bc8WzT6PYRtni8=;
        b=Mcz+JNxHfNRRWMEooKVXz/xyG4KyqZaX4TSIHd+yx8XMH8zyZ2u2mby8VRFN6vMQuQ
         sp4UAEN5BZ+dvXpIyMVUp5QIiiPpHJFoIPenIR4Aqv0dLYc70kEVNaImtbX++NJEWk5D
         86wi81jX5fIi5ukDGmLsrkuQ3qaVd3GTmLPmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635024; x=1719239824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvP4+t8l416VgzjO1ZXGZmV/a/Zd7bc8WzT6PYRtni8=;
        b=mnL1paHWgWu/66/CnsYrD+MCJEElpYuO9e8TujXTMsCUn2PwPLi8jYkf3UICcmvPlZ
         xzNLrpwK+XYyiaet/GECjNOxREM6v2NPcuPfktN9YkhvrgseUI1ZAqzgfg0SqIxkiDov
         xYK2o1IxxVRdfMcEhuKOlFU6JJxrS64Xoi8Q0sPULKHzAadJXy2+2FZmc3tQwxD4klGZ
         lh4Ml/a6uE21nZZxLQXEgg2pCXRvdW4gtnrkIhiHWe4BEOPQRg/dhFELh06451TJi5b4
         FsoWvjXBxCLL6bWiy4vd77nFVipN+Rk3FxpvRCtt8s1+K9vTvaQABpN84eb4tw/aLpfM
         O9MA==
X-Forwarded-Encrypted: i=1; AJvYcCURQoMVRM0oRtDEaEt0tYn0udGbk48KMQJHiVQ9ph+BmRhFAi9vo3NCPtm6dmR6B6MHPICBIm34hlU7DGOvul3m9yEWM4y4St/vdjor
X-Gm-Message-State: AOJu0YyqGyfkJEp0df3iJRVNG9ngE3RiOEqeSKJ7/4aMHlfi1MpvxqyM
	9AHcUhS5IQD+L6Uwy0yKPj0Tvvr3eHgdrhE5WrvTIH/nLl3NnJjo7aZ6pmRDyvw=
X-Google-Smtp-Source: AGHT+IHQDMfoJ/LOZJYFoBhJ4TbHf9tXcpQcYRrBKsc6jJQgkvkhyZr/hctT8019B9VlxZwrZ62Uqw==
X-Received: by 2002:a05:620a:4507:b0:795:4e89:53b2 with SMTP id af79cd13be357-798d26a8ce3mr1215726185a.70.1718635023959;
        Mon, 17 Jun 2024 07:37:03 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc02e72sm433891885a.96.2024.06.17.07.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:37:03 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:37:01 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Frediano Ziglio <frediano.ziglio@cloud.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/xen/time: Reduce Xen timer tick
Message-ID: <ZnBKDRWi_2cO6WbA@macbook>
References: <20240617141303.53857-1-frediano.ziglio@cloud.com>
 <2fe6ef97-84f2-4bf4-870b-b0bb580fa38f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fe6ef97-84f2-4bf4-870b-b0bb580fa38f@suse.com>

On Mon, Jun 17, 2024 at 04:22:21PM +0200, Jan Beulich wrote:
> On 17.06.2024 16:13, Frediano Ziglio wrote:
> > Current timer tick is causing some deadline to fail.
> > The current high value constant was probably due to an old
> > bug in the Xen timer implementation causing errors if the
> > deadline was in the future.
> > This was fixed in Xen commit:
> > 19c6cbd90965 xen/vcpu: ignore VCPU_SSHOTTMR_future
> 
> And then newer kernels are no longer reliably usable on Xen older than
> this?

I think this should reference the Linux commit that removed the usage
of VCPU_SSHOTTMR_future on Linux itself, not the change that makes Xen
ignore the flag.

> > --- a/arch/x86/xen/time.c
> > +++ b/arch/x86/xen/time.c
> > @@ -30,7 +30,7 @@
> >  #include "xen-ops.h"
> >  
> >  /* Minimum amount of time until next clock event fires */
> > -#define TIMER_SLOP	100000
> > +#define TIMER_SLOP	1000
> 
> It may be just the lack of knowledge of mine towards noadays's Linux'es
> time handling, but the change of a value with this name and thus
> commented doesn't directly relate to "timer tick" rate. Could you maybe
> help me see the connection?

The TIMER_SLOP define is used in min_delta_{ns,ticks} field, and I
think this is wrong.

The min_delta_ns for the Xen timer is 1ns.  If Linux needs some
greater min delta than what the timer interface supports it should be
handled in the generic timer code, not open coded at the definition of
possibly each timer implementation.

Thanks, Roger.

