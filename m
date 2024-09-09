Return-Path: <linux-kernel+bounces-320707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23EC970F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBE21C21EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5C1AED25;
	Mon,  9 Sep 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cv3EXSVe"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE471AE050
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865929; cv=none; b=QNpneY6/mF/AC4Vx00RHzU695rV0lyE7S60Q7TaKhURt1/k3pu5JmqZTEXZmNfB1tQFsoXxMY3g3Z2FdLmxSnM2p0yuLIRE5dRoOAM0bVhcUR6VjRR1IebzAdMSAqD1tWwVxbOI7ZzxisIvi6ypHoF8rRRWIPruQMJuv7KAGHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865929; c=relaxed/simple;
	bh=3KMrUlZrz/OgJfQcNnFbHDUOETnz1FS3VBAxZc7blM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq6gE88Cc7csoZzes+HpO2t6RWvWWaEqvO1/5diG4MpjbjuZfFjcOvfs7DA/ZJqDA48SbNIqmljM82/2PvqCefjZexuBhAu6/jR4NSrleMjsOH1UmXZqvk8f2XXzhASsVAi69Pa3gp+2QnWAO4Bj7spoS/6PYtrvQaju7n2zQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cv3EXSVe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so36186505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725865925; x=1726470725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlTYWtVvC3Cne1dBDJYb0hBguVyLh45bhCTkFwU2JeQ=;
        b=cv3EXSVe6DtoAbb5qRyL9TuEgl1E1LeYSPkUeDQLjnGRvUDAk2/6bWt1IfKxe/M4Z/
         Lve1hf81yqH4cGKeG8/x90iCy1ew8CZZUJxHegnXclZ35djZAQLVmWsjD9FKOaagy9YP
         5aByY6URsUoumIUdVj02jplqbPaVo3eihT9nus5tg7ldtX7Fgj7UkpAxG6Vhjid1va+X
         9hfhUthKMgqE+TvtNRh+j391BrabfYa34TcCKEKR+U94DjMpC6k1Sc2X23wJvCiCj3b3
         EDax2iBIK+P1QK/W9iDzr/8cNiJ0jlsVPy/sN6FDE1hHx/vtg4q9qChszLy9kZPGniIX
         dGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865925; x=1726470725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlTYWtVvC3Cne1dBDJYb0hBguVyLh45bhCTkFwU2JeQ=;
        b=Ws5IUGpFulVLzhIGPjzlN79s/V8TMTnBqKs3Jtf72REMXagRiUEBx7vuDQMH0XDnhU
         tpFkZnJQTRv7euFBHT7OEg+WfHUwsghkXbtIebupgGJ5CfeF725eWYABsM9IoXxH1D0B
         gQcVgueIjAYvzIHSjQBuom5jKv4dA0uJXp5Lv7peiZt6iTjuCGqN92LXYoFbuREvcaSk
         flcopuww0K2aM6K2d+mo2vSCDzBafMG9dNz3Dcol9ugMlx6fWavoGDCfbfAFnbU4ZMug
         s8NDUWfRVEZ4ZavyqixvsbvuMcVTcFTvLR+ddpZLwx6ZVDlmdtPbiJkO+MngakVay+p/
         L3og==
X-Forwarded-Encrypted: i=1; AJvYcCXCZhjtJVrWPy9YYcEHxV1WOVXcvzdI5jN2JjPHDuZOTswl1Yda6iDEDxLVwpB2T6g46/8UHdZipdhjtlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygA0cVdszdqahY8ZpInSSD4z98+3/UTuA9DbkYAkeAgs+twJF0
	kt3IRVEoEy3M3b2i16qohGmKU7gesAqBy7QICNogES9x9cYushJPGllkbE8mdvI=
X-Google-Smtp-Source: AGHT+IFngtNyJrOoh2h5MtVKCpb2qCaCLNPXUbMYEkAbhHFc2yZgp3oF5lWSpd1MZ4PUJTDOX3sNJA==
X-Received: by 2002:a05:600c:c8b:b0:42c:a8f8:1d58 with SMTP id 5b1f17b1804b1-42cae7091cfmr42247485e9.7.1725865924824;
        Mon, 09 Sep 2024 00:12:04 -0700 (PDT)
Received: from localhost (109-81-94-251.rct.o2.cz. [109.81.94.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32318sm66714455e9.17.2024.09.09.00.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:12:04 -0700 (PDT)
Date: Mon, 9 Sep 2024 09:12:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, yosryahmed@google.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <Zt6fw4ibDq_XA_0q@tiehlicka>
References: <jw5skccxwi3u7i2ieb2l5gamekobbiankxbdzcxtctd636fh4v@wrfgdmkomiu3>
 <20240906110419.2079-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906110419.2079-1-hdanton@sina.com>

On Fri 06-09-24 19:04:19, Hillf Danton wrote:
> On Thu, 5 Sep 2024 16:29:41 -0700 Davidlohr Bueso <dave@stgolabs.net>
> > On Fri, 06 Sep 2024, Hillf Danton wrote:\n
> > >The proactive reclaim on the cmdline looks like waste of cpu cycles before
> > >the cases where kswapd fails to work are spotted. It is not correct to add
> > >it because you can type the code.
> > 
> > Are you against proactive reclaim altogether (ie: memcg) or this patch in
> > particular, which extends its availability?
> > 
> The against makes no sense to me because I know your patch is never able to
> escape standing ovation.

I fail to understand your reasoning. Do you have any actual technical
arguments why this is a bad idea?

> > The benefits of proactive reclaim are well documented, and the community has
> > been overall favorable towards it. This operation is not meant to be generally
> > used, but there are real latency benefits to be had which are completely
> > unrelated to watermarks. Similarly, we have 'compact' as an alternative to
> > kcompactd (which was once upon a time part of kswapd).
> >
> Because kswapd is responsible for watermark instead of high order pages,
> compact does not justify proactive reclaim from the begining.

What do you mean? How does keeping a global watermark helps to trigger
per NUMA node specific aging - e.g. demotion? Or do you dispute the
overall idea and have a different idea how to achieve those usecases?
-- 
Michal Hocko
SUSE Labs

