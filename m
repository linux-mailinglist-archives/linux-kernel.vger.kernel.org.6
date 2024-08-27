Return-Path: <linux-kernel+bounces-302636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D914D960147
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957B6282B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5C13A416;
	Tue, 27 Aug 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Is6H7dMM"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535628689
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738498; cv=none; b=abYaDD1xLm52T6fi1F/Vu0DOPKuLhpcJDW5KHNCYP2lg97AbeCoYmZp9E7Ih151dGN/9it/cI6Uks7IkMIfZGjA3wqA6Ra8lPDvvRQlhJfKUaVDkb3XuerLIIM3Ayltrh0ASE3esp6AdCiqlWm7shjr4nu41IZFeCq48Aon0fM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738498; c=relaxed/simple;
	bh=ZpgYtWXWQX1RlXoxt9WyOaOIHSiZV5dnIWN7iBw/Ez0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StuxQk8NliDlJQFgeRktZcOwBX4JfxdjEy6tec5ty0SlvysUUzzKsPKSgsOZT4oUAauIHrRmuwURL2HK/JCudHaMfiG211XnZme5//ZTt/BPGw/hxiWsRr+8n46Ouv0xAbWBRYVImWgFtR55oYio3NU+p6UolQIdQFx1a8R+U7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Is6H7dMM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c07eebf29eso2236132a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724738495; x=1725343295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2V26ymBzYP2Z7GWKZsLXO+lAp6n0aHmQIkOVXPd0pbM=;
        b=Is6H7dMMviJHa5j8LkOEErNvwLCq14O7NJvvKb55bwIILNBqJHHXrcJlF78H5FDWI/
         sWk/qq1VN1Hqczv7JIgJ03xQYQmcns7+cANgKqJ678C76CuS5EtP0zn0kqV4xKljKdsM
         mgOlnGxC5KDPx/azqnz3NeV9aABZHXBXdFOih6cu927V4TI9IXGU6b981K/i2qCaVFe3
         0wbG+AoEe+5zU4/Op8VzXvL9OEOQKqJl2J7WCHv3EM0YqvyX/2K+IO7pVAtP4axE99nx
         EN+r+BTJ2NsWHSbOrwTjT87AusqLW8Y1/cxhvNXTE1jHUF2ox0iIFJAVFswcyU1gJ8mZ
         SO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724738495; x=1725343295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V26ymBzYP2Z7GWKZsLXO+lAp6n0aHmQIkOVXPd0pbM=;
        b=OIWbamWiCMtPLlYVZihYqKqxKLBaTh/w2F9/sRLxUjRtaFhq0IoLW2JWYd1zuaLFvF
         AH3bdx2vpypMYOsxuvM8XuMhxawJtnaUx5WEJ1cAldOHzFxMZkxXOl/YulLUJPQQEQ9W
         f7EnYmc31jy5gJaxs25G4Kb6LqpPFa4zo2SDFLX29EqF1izAp0f7QsmlK04xPncSN79E
         SutMgvCGZA4RJ5e+A4nAtnkrZMEf6KlzykHNCV2swOJaud9gsU2RSfutkzqRIUKo0tOO
         MdFkFhHWAjWE1VgSfPnh3+VGvDHGlHUEy2oI5w7LbmpJOJ8GMCgefguznKdLKVJCHBtL
         Ei/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpSSL5BI7aeRMaM4KVc8ScYfR4FfmIO7XV1Geof0ilCZbDvHQ8R7vOm7SJgb4WFONc0L8WjCp7szd8c5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7tU0hCMniXmfRip6dbwfS/47oyAE6fMibSDe0I+q7Ygq9KfP
	3A5AflMwTrZ5ZCMvv92rwt8isw8CA8UfSnpIlC/D2X8MXKeYqACduoew7QuuMuo=
X-Google-Smtp-Source: AGHT+IF2gqL09d/X0zV5rFVkiVrS2Z5bbUz8sAze/K0DL8uePv7zb38gZRMFPwimQZSTcgTR1WWbYw==
X-Received: by 2002:a05:6402:26d3:b0:5a1:2ce9:f416 with SMTP id 4fb4d7f45d1cf-5c0891b4825mr11035852a12.37.1724738494768;
        Mon, 26 Aug 2024 23:01:34 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c5b39sm602082a12.20.2024.08.26.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:01:34 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:01:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zs1rvLlk0mXklHyf@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
 <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
 <ZszlQEqdDl4vt43M@tiehlicka>
 <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>

On Mon 26-08-24 16:43:55, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 10:27:44PM GMT, Michal Hocko wrote:
> > On Mon 26-08-24 16:00:56, Kent Overstreet wrote:
> > > On Mon, Aug 26, 2024 at 09:58:08PM GMT, Michal Hocko wrote:
> > > > On Mon 26-08-24 15:39:47, Kent Overstreet wrote:
> > > > > On Mon, Aug 26, 2024 at 10:47:12AM GMT, Michal Hocko wrote:
> > > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > > 
> > > > > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > > > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > > > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > > > > 
> > > > > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > > > > dangerous to use if the caller doesn't control the full call chain with
> > > > > > this flag set. E.g. if any of the function down the chain needed
> > > > > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > > > > cause unexpected failure.
> > > > > > 
> > > > > > While this is not the case in this particular case using the scoped gfp
> > > > > > semantic is not really needed bacause we can easily pus the allocation
> > > > > > context down the chain without too much clutter.
> > > > > 
> > > > > yeah, eesh, nack.
> > > > 
> > > > Sure, you can NAK this but then deal with the lack of the PF flag by
> > > > other means. We have made it clear that PF_MEMALLOC_NORECLAIM is not we
> > > > are going to support at the MM level. 
> > > > 
> > > > I have done your homework and shown that it is really easy
> > > > to use gfp flags directly. The net result is passing gfp flag down to
> > > > two functions. Sure part of it is ugglier by having several different
> > > > callbacks implementing it but still manageable. Without too much churn.
> > > > 
> > > > So do whatever you like in the bcache code but do not rely on something
> > > > that is unsupported by the MM layer which you have sneaked in without an
> > > > agreement.
> > > 
> > > Michal, you're being damned hostile, while posting code you haven't even
> > > tried to compile. Seriously, dude?
> > > 
> > > How about sticking to the technical issues at hand instead of saying
> > > "this is mm, so my way or the highway?". We're all kernel developers
> > > here, this is not what we do.
> > 
> > Kent, we do respect review feedback. You are clearly fine ignoring it
> > when you feels like it (eab0af905bfc ("mm: introduce
> > PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") is a clear example of it).
> > 
> > I have already made my arguments (repeatedly) why implicit nowait
> > allocation context is tricky and problematic. Your response is that you
> > simply "do no buy it" which is a highly technical argument.
> 
> No, I explained why GFP_NORECLAIM/PF_MEMALLOC_NORECLAIM can absolutely
> apply to a context, not a callsite, and why vmalloc() and kvmalloc()
> ignoring gfp flags is a much more serious issue.

You are not really answering the main concern I have brought up though.
I.e. GFP_NOFAIL being fundamentally incompatible with NORECLAIM semantic
because the page allocator doesn't and will not support this allocation
mode.  Scoped noreclaim semantic makes such a use much less visible
because it can be deep in the scoped context there more error prone to
introduce thus making the code harder to maintain. 

I do see why you would like to have NOWAIT kvmalloc support available
and I also do see challenges in achieving that. But I completely fail to
see why you are bring that up _here_ as that is not really relevant to
PF_MEMALLOC_NORECLAIM use by bcachefs because it demonstrably doesn't
need that. There is no other user of the flag at the moment so dropping
the flag before there is more misuse is a reasonable goal. If you want
to bring up vmalloc NOWAIT support then feel free to do that in another
context and we can explore potential ways to achieve that.

-- 
Michal Hocko
SUSE Labs

