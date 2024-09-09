Return-Path: <linux-kernel+bounces-321624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168C971D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3DF1F23C21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722061BB6B1;
	Mon,  9 Sep 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqrGPKru"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AE1B81D8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893406; cv=none; b=ZL4CuTIqXJM/MSS7Dr3C73tJnG0eP86U/h0di3XZ8a4BHPKDwABOWHjX2xPZtCSOLlKQcsiiR1A/CMAJjYX5PL/wUvLpUDa/EbZ3t/gwiE1LySOtC2bh1sG/MP0lCmBGZ+tj8vkPzzA+RbzLZJG1AGilxAwTsM/B63Izr+4J7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893406; c=relaxed/simple;
	bh=VyMYMatbM0ZkxcQ7JH9byFExbaiv76IZbIMr2qViwHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXWH4kDtbJPV/XGGXpA4seo7nOJKtw1apl01X3K1vWcRPOmmpb5+FD688WPjSqLWd4CnHShAOncrEQ3aAG7UxMWR+BfvKoINMmJEtJw9YLCR4P8cFNahSHFHd3nKR7AI2SK1gw4lOeCADvEOsQ/bL77voIb6JqlEaHjr0FMGyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqrGPKru; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso5087761a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725893403; x=1726498203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9v2Ew7hhlLr4kMPvE7YVmpXKAISPQ2qnVJhqFoRzg8=;
        b=JqrGPKru7XPZ68x5zlbipz+N98DpF3kUcV5OaTg4dObqzxEMjRvIp0BC1scQeP0KvR
         HI6p8XYn2JV0JlRZZa2duLgqjkkdAbjmzoGlFYEQ0CQXsn551BhKZBZBi8G0OUQZ7i17
         BtXX3KCKtgS7nMuMW1IiRRVXTqiQKldzU7W6fTeO+mLz3jw+2WmDkrDGu23MJ0l6VzNh
         Ep5T3CqR+Wm1U6cOWRrdTg68y4B2FbU56yrs5saE3OUtENZuPciwYzT4mM5yx+Rdt9ro
         aBXhHf1HJ0g2eGZ1GMLfwP7UIKLblCk6Xk8VLuznqBg0abRKmphj3tIICVv6Gd05jeD9
         mBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893403; x=1726498203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9v2Ew7hhlLr4kMPvE7YVmpXKAISPQ2qnVJhqFoRzg8=;
        b=Z5MH3Fta9rXjCymv52L+3SyWZDx7P7Rkr50JIflC16H+uQ88hF2BitygaSC1Wai6+7
         jN6TNdxdd5fIUM5M+RIg9y9xO7lIKB4ibBqcTyT2/3gcgIQoBuYIKwRokvvNt5lZZ4Vj
         siXpSNRdKZrGcLaQGngPO7CO05+rYP9ifTPBwFUwAtQx+panqaxRltwTkE5Bf0RlqcGi
         9c6I/M2Ml45iavF8ePHQirq/4LiAg0ktBKMlxVyjasTNpZSMeNDUIjwcbI8KOz3D9Ydq
         65actpQOY4eZZr9O1GcCdyXsZLBKlexAlDw1IotDnrFzUlKPAKbzVaX7V6vcPfllRI/r
         OU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOqzfoQ2tMJdJYa+i6PD1G+DHmVPsF36bQPxN17ubh8HqTIUAb1bBMSIJmoVnUTBvaNY/DQaotRXXVNXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCPR1NAN2yhit06h2fpprsMm2pS1SxilTV6p/HYwp1auj0x5a
	6GxQfmAOuv4eMV3jgoGW9LDpVm6qOLWneZwZTwWpx41RyD7araTOTMqvg3MRSN8=
X-Google-Smtp-Source: AGHT+IHf434hHzqA3na7vHiDZ07v1njm5O6rCFLa56eADhixaf8Z8IRp8g+sM15hDoTHcp+eFRE1lw==
X-Received: by 2002:a05:6402:448a:b0:5c2:632e:fad7 with SMTP id 4fb4d7f45d1cf-5c3dc7955famr8352205a12.15.1725893402803;
        Mon, 09 Sep 2024 07:50:02 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8ceccsm3086633a12.91.2024.09.09.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:50:02 -0700 (PDT)
Date: Mon, 9 Sep 2024 16:50:02 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, yosryahmed@google.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <Zt8LGqwoq4dSd_Ed@tiehlicka>
References: <Zt6fw4ibDq_XA_0q@tiehlicka>
 <20240909105157.2663-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909105157.2663-1-hdanton@sina.com>

On Mon 09-09-24 18:51:57, Hillf Danton wrote:
> On Date: Mon, 9 Sep 2024 09:12:03 +0200 Michal Hocko <mhocko@suse.com>
> > On Fri 06-09-24 19:04:19, Hillf Danton wrote:
> > > On Thu, 5 Sep 2024 16:29:41 -0700 Davidlohr Bueso <dave@stgolabs.net>
> > > > On Fri, 06 Sep 2024, Hillf Danton wrote:\n
> > > > >The proactive reclaim on the cmdline looks like waste of cpu cycles before
> > > > >the cases where kswapd fails to work are spotted. It is not correct to add
> > > > >it because you can type the code.
> > > > 
> > > > Are you against proactive reclaim altogether (ie: memcg) or this patch in
> > > > particular, which extends its availability?
> > > > 
> > > The against makes no sense to me because I know your patch is never able to
> > > escape standing ovation.
> > 
> > I fail to understand your reasoning. Do you have any actual technical
> > arguments why this is a bad idea?
> > 
> > > > The benefits of proactive reclaim are well documented, and the community has
> > > > been overall favorable towards it. This operation is not meant to be generally
> > > > used, but there are real latency benefits to be had which are completely
> > > > unrelated to watermarks. Similarly, we have 'compact' as an alternative to
> > > > kcompactd (which was once upon a time part of kswapd).
> > > >
> > > Because kswapd is responsible for watermark instead of high order pages,
> > > compact does not justify proactive reclaim from the begining.
> > 
> > What do you mean? How does keeping a global watermark helps to trigger
> > per NUMA node specific aging - e.g. demotion?
> >
> In addition to the cost of pro/demorion, the percpu pages prevent random aging
> from making any sense without memory pressue, because I think it is aging that
> rolls out red carpet for multi-gen lru.

I am sorry but I do not get what you are trying to say. Can you be
_much_more_ specific?
-- 
Michal Hocko
SUSE Labs

