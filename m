Return-Path: <linux-kernel+bounces-278048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6D94AA18
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2840828404A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4F78291;
	Wed,  7 Aug 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWxFXq/F"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43D5914C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040920; cv=none; b=qJDNdUvPaOrXvOn4b4qwCmgL1hmfTQDK2DfNyNNXzTytvSQsHtiF0H1+8PFL3c2eaYWJ3ILbfiYtVfVhOXajJBWaccY2AvPEaWnXkJ2YpLv2kdDERxeGvPSKvYVBdpd9uVRYaEyoxtP/qKI1raO0GleP2HBQ53q66IzAikesetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040920; c=relaxed/simple;
	bh=sjYkFCUHkzVFgdYIjhNjUTc7FfQpRSU/xEpkvL0kysY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yjz1dqc0z1kroZyoW9oPSjjuqvgAFISpe4fq+YYcMwiylAdVBkr3I6x3SOvf7a+Pcz7TXCSK9yC+b3A7T4LbssZZGMqxpSIj8Qo+e0KOQ+HH6bX2Ing+8biLPTQDjp+R99wPNHrnWc912F5Rj+mVJGZZaas8K5v6sEOk3hQJd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWxFXq/F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ff4fa918afso12785295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723040918; x=1723645718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKuKBySJ6S+gvs4v9HSUedwC/HHVUTjFlzosJrPtZ9k=;
        b=nWxFXq/F60747HVCiU27onWE2W+OUS5FiS2NLsFJ2ShBqsLo4MtR9lskHzo16/Rzui
         rkMsECbh4i4qHXMD+53o3JPxpTaCNYER8pGMB7kz6u4iOqNRPbChzzjnjo5+Y7KHKF/+
         CiX5loVjJ5mgcXbCD3bBI5olLEsQsoS/QSoqFxST11IHzLQ2WLmHki7w1hQDLt4jGPE3
         f7tOCdcULocYYx4nh7FAbvfz3KQwHyaqarmXhlmBjB1vR8wldSVyKM3nBzA30sBs/aHd
         /5qhK540Rwq+P8/Vw4JkqNChEFOIe6KtefapWIVlmU5OWhQRTa+IzOHcI/amE1Q6g5vK
         ooHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040918; x=1723645718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKuKBySJ6S+gvs4v9HSUedwC/HHVUTjFlzosJrPtZ9k=;
        b=CgzCirDprAV6y0mjmkliWby2qh/VY15EMErhWvb0xDUBoxutyFNZb5wQ7S/lJb93/L
         49ehA88zL2XbxYL/XSEpsZ4pmNhFRdRgCzgDep5NhkruYkIMzotExYcH+uF9/raNO5AY
         K3uqH+pNcRYD0pDWa5TuwkeqUG0QtPS7Q2zvwgqRnSFY/RWkttE6YyVN+DbCKS8kpcQJ
         mu0zinuEORXp5p1IZWgefOmpCKJCG1OMYv4V7m0PPE2uu12Crt7yE7wbjuZLcbcU05De
         jpYAoqcyAKklVODzvnTfIUdPKMa4ihtbu7hke8czjLtZe05+dnhOZ+tgVEHyLBaXblhQ
         NU3w==
X-Forwarded-Encrypted: i=1; AJvYcCWqIhighodq2pfJxfZjcMaEa3o3yxWZUzlqPnHqKW+WeJva/U8ICiqEk9p2UrlTyllo76sg6OtFLhGggVn5FJleIy+GBcwwtDIV5i/g
X-Gm-Message-State: AOJu0Yygdabg41lnQptEYxE8B5opD8bRgplJNgUv8WfB34bmpWVKeaXa
	wtuNCUPU9eZ1pXHFWiZFSfpSJRdbHDoI8d/cuzQxILlzptazPCctSzC5CzYIiQ==
X-Google-Smtp-Source: AGHT+IHZGNj+CO42m9jtmxWeNlytFnAG0AsbIOFpHxbImnUwc5QhUJCTK/KRugcCs3bD/VRGGFL7CQ==
X-Received: by 2002:a17:902:d2ce:b0:1fb:93d6:9fef with SMTP id d9443c01a7336-1ff572ecfc9mr201757215ad.38.1723040917595;
        Wed, 07 Aug 2024 07:28:37 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5927ef2bsm107265385ad.227.2024.08.07.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:28:36 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:28:32 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
Message-ID: <ZrOEkD9RpvdtqXDK@google.com>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-3-cmllamas@google.com>
 <218314e9-7c7c-490c-bb2e-9611243cade3@redhat.com>
 <ZrI3mFLUwDyEMRIB@google.com>
 <e378ac65-73cc-4829-b605-f164c67dc5ae@redhat.com>
 <ZrJgnP5Nv03k8rMG@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrJgnP5Nv03k8rMG@boqun-archlinux>

On Tue, Aug 06, 2024 at 10:42:52AM -0700, Boqun Feng wrote:
> On Tue, Aug 06, 2024 at 10:52:52AM -0400, Waiman Long wrote:
> > 
> > On 8/6/24 10:47, Carlos Llamas wrote:
> > > On Mon, Aug 05, 2024 at 09:36:43PM -0400, Waiman Long wrote:
> > > > Many kernel developers understand that BITS refers to a size of 2^n. Besides
> > > > LOCKDEP, there are also many instances of such use in other kconfig entries.
> > > > It can be a bit odd to explicitly state that just for LOCKDEP.
> > > > 
> > > > Cheers,
> > > > Longman
> > > Right, and similar to BITS there is SHIFT, which is also a common way to
> > > specify the 2^n values. I'd point out though, that it is also common to
> > > clarify the "power of two" explicitly. To name a few examples that are
> > > doing so: SECURITY_SELINUX_SIDTAB_HASH_BITS, NODES_SHIFT, CMA_ALIGNMENT,
> > > IP_VS_SH_TAB_BITS, LOG_BUF_SHIFT but there is more.
> > > 
> > > Perhaps this is because the audience for these configs is not always a
> > > kernel developer?
> > > 
> > > Anyway, this is pretty much a trivial patch to address Andrew's comment
> > > below. But let me know if you think I should drop it, it seems to me it
> > > can be helpful.
> > > 
> > >    [...]
> > >    btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
> > >    bitsize?  Maybe "bit shift count for..." or such.
> > 
> > I am not against this patch. Currently I am neutral. Let's see what Boqun
> > think about it.
> > 
> 
> This looks good to me. Maybe it's a bit verbose but that's what the doc
> part should be: providing enough information so more people can be on
> the same page. Please keep this one, thanks!

Sounds good. I'll send out the v2 and keep this patch then.

Thanks,
Carlos Llamas

