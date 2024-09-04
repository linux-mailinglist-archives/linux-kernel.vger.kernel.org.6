Return-Path: <linux-kernel+bounces-314389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBF96B29E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103771F27117
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49B314F117;
	Wed,  4 Sep 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V2wFx/yw"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A9148FF9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434076; cv=none; b=id00Kj9PlhLjKIWUvaT7N2+qekEU5x1LrQ//uAVDM5S4wgBCYegGkWDcX0+ALQHOqkK3KPDU2Lxr52fVcscRv6bT9PJoZ8oRBmCETOeXx9a4s3EZbxCre7si4shs55Nk/q9/yfRpFY1uQuAyUViIjljlsPApZPo62+NT09w1XQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434076; c=relaxed/simple;
	bh=VqLHinL0RjI3e0Z/VURxkK5bglnAwHHouZAHOAzUEGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdxdbBCYsE93VgpiWmDc6kluYHXXCPXhTygi1P6zsjwoZW8qCqWQCrvd638ZAjOt7afvVZ3tELOH44X0i7SEK+awLCs1eWy7HzyUVBpGQe3mawDZHpgwQ1wwToyQl8twlYZGYy6Ib9QS28Mo0YObM9RGUhOlfmSIJjVdRgYx8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V2wFx/yw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so2901503f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725434071; x=1726038871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnMooA7Lbyg6swfN/5rgVwe/kJNmET/0maFcp2nTGY4=;
        b=V2wFx/ywOvVoIfkwu6ryrYoEhgoHcFhltvH3WlDTsvPrYDSDj0ler+Uq03b5Gchrrd
         CVkcpEydUOK9YCjmfC2U46TlNqKkqiqxGBGuF2qv1fx0pR225lqsQDldDuiE1yM0m2/i
         LSRIo50NLsaeZSv1b7LbxgwwhNdock/OeWEvIbMEiODO5DvYiZnjinMg2DCvUxi+CJUp
         0Y/0Zg4QASsylzoLiJCAdy4SdcTcdif078/4M+J9qF0C1srVKSveJ818UKmdpqG34lfe
         CONABmhUzaMyoWj9hUnOMK+rZdC0iBfClSq4tXHya4izJFOWGTHsnR+pwuYtGYK6CLkU
         3hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434071; x=1726038871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnMooA7Lbyg6swfN/5rgVwe/kJNmET/0maFcp2nTGY4=;
        b=b/uzyRnEM/dEf5HPekuiYQ09GnjkMR52hwFY7DQ6aDk0VW3fg3eYy8R3MlOTd+dO24
         Jd0ys7QNG56DpP2ixtMYRn3kW5Ww9zP2qrJF/SQ1I3z5BdJGP/M5Qvm8s46LNBO+/v0p
         7PYvk7ELKlSE3OqrEbPgf9Lyme7ivdu1awQuowNXlTOiUEGUrutsurzper8xXgySJT4a
         pUL3LQ4VUJYFxJ9GiCjTNpKnXjLHdPdZi9YGgUQju6yEH+2Kd2lXUu4G+ONolIOwVzFT
         Vsx1cf9danhx6JUnJJIOC5vzJDC/OV9WkCb7lr7e4JETjbFvKwJq1Oo2coXwpO/qHvWS
         WAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzZwcXDy+2IVd6D1kC8pJrAIvfP5xBchUmJZF6lQuaeHvldiM/bH+/XaGmbjPgAg0uVgFwFNCC0Fguur0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOZvNkDw8hZlg6//VFI8pILfjBABJf+Bkn+BPJ8szXnai9MCq
	fhL3BzDxLvcNqmH9ilzsb9YgU2yAFHCgg6zZBfIdnAI9tjWUQI1ATPXnUKzinXU=
X-Google-Smtp-Source: AGHT+IF8I6pFlzOU3p9D8agMKGZIZoWQQ9AW1+2AmZCmzaC0dDVMGKQ/M7w2avm8V9SBZGoK10RrWg==
X-Received: by 2002:a05:6000:124c:b0:374:c29a:a0d6 with SMTP id ffacd0b85a97d-374c29aa194mr9448975f8f.2.1725434071394;
        Wed, 04 Sep 2024 00:14:31 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3eb4sm774269866b.133.2024.09.04.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:14:31 -0700 (PDT)
Date: Wed, 4 Sep 2024 09:14:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <ZtgI1bKhE3imqE5s@tiehlicka>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>

On Tue 03-09-24 19:53:41, Kent Overstreet wrote:
[...]
> However, if we agreed that GFP_NOFAIL meant "only fail if it is not
> possible to satisfy this allocation" (and I have been arguing that that
> is the only sane meaning) - then that could lead to a lot of error paths
> getting simpler.
>
> Because there are a lot of places where there's essentially no good
> reason to bubble up an -ENOMEM to userspace; if we're actually out of
> memory the current allocation is just one out of many and not
> particularly special, better to let the oom killer handle it...

This is exactly GFP_KERNEL semantic for low order allocations or
kvmalloc for that matter. They simply never fail unless couple of corner
cases - e.g. the allocating task is an oom victim and all of the oom
memory reserves have been consumed. This is where we call "not possible
to allocate".

> So the error paths would be more along the lines of "there's a bug, or
> userspace has requested something crazy, just shut down gracefully".

How do you expect that to be done? Who is going to go over all those
GFP_NOFAIL users? And what kind of guide lines should they follow? It is
clear that they believe they cannot handle the failure gracefully
therefore they have requested GFP_NOFAIL. Many of them do not have
return value to return.

So really what do you expect proper GFP_NOFAIL users to do and what
should happen to those that are requesting unsupported size or
allocation mode?

> While we're at it, the definition of what allocation size is "too big"
> is something we'd want to look at. Right now it's hardcoded to INT_MAX
> for non GFP_NOFAIL and (I believe) 2 pages for GFP_NOFAL, we might want
> to consider doing something based on total memory in the machine and
> have the same limit apply to both...

Yes, we need to define some reasonable maximum supported sizes. For the
page allocator this has been order > 1 and we considering we have a
warning about those requests for years without a single report then we
can assume we do not have such abusers. for kvmalloc to story is
different. Current INT_MAX is just not any practical limit. Past
experience says that anything based on the amount of memory just doesn't
work (e.g. hash table sizes that used to that scaling and there are
other examples). So we should be practical here and look at existing
users and see what they really need and put a cap above that.
-- 
Michal Hocko
SUSE Labs

