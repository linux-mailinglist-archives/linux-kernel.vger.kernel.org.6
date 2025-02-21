Return-Path: <linux-kernel+bounces-526350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54808A3FD8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C00D189B5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F12505CD;
	Fri, 21 Feb 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="teBZVJxt"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF22505B1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159189; cv=none; b=dybo8F3gZ6+Je10s285Mh8Mz7GeYzEkdpia0rMFVzg0KXAXyXsTfypSPzed3CyiutaXGGmGT3SousNHyJ0k1mVOLBoBQHHSxs6BF8R9Ehtx4Afxt+hkmNnyrTVk4mCa+h0at/hwPstHSRCkYXCHEPPwsMhT1G94pL4zD2JuMdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159189; c=relaxed/simple;
	bh=XLjO1u/egxQWR8tqLWAGSrotUDvhTrWuOgdLJXLfcv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoATR7SbH6OmWDN8Di9x4kv9DFo6av9n7FwBHzPPh/rTiL+9Ngmc+rfBOiMqtSUyTfgJR/1t7UvUAXfRIaAZ+4H5ob3Vf0BcZLdXqhZwmbAd4/tRXfdYw+hConLp7gTrLnj5XZ9RNGMnLNeDNmmWEqS/O2dyHG/DhfC5DxBrT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=teBZVJxt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e69db792daso19637936d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740159185; x=1740763985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7jsxVP6w1UGpBAKyAXYr08AjC4TjmcUC/HGyPVCCKI=;
        b=teBZVJxtLCh8/pJQBJiBu3fgP4gx0YpUsHe5De4BR/hxnjyHxeM1qRgPj0WuZ37MEu
         6LHmeXChjcYEIRkbssJ+LhfXcW94FACRxxJ1Q+1KCw61nELkePY0Jr0Cwpt2+1aZ8N/3
         U5TezPdiQb/TU5+Nl8gIigwP0hID8Fy2zZEgrzqbEaaDM40k0M6ZXlle3wks8gLZMEjC
         5xrNRf85LqFvxxZTAZykris4EvdmhVz+5hvTN2/Gs7dT9wMhW0sY78da4+tmp6VkNAMY
         u1HGr2TDW81HrRw4G/8Ltkuoab3tHyl6f+kbOf6qyN7op5FZQ8iF2Wz6j4uBB3yFwMUC
         1Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159185; x=1740763985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7jsxVP6w1UGpBAKyAXYr08AjC4TjmcUC/HGyPVCCKI=;
        b=UR+DaFdPhSbkbI/fV78u/GuTBy78AgJj/PEgX8I6GzczTVuGah9tKRRJdMjmbEYPFU
         q/sczt16nGsaUuYpyi37JqyXa9vrdz6xNTvKnKYLTnlpLrl5WP1skusRULeYZ2yyO+J5
         viA/IOJdKl/E11FQvStNFdoZXzaYGAQurU7fhETUwFk2/H+x8G9+DxEUuceDs3NbRuUb
         FN+dyB0Ii1rOlMjh7YSclcFzy0PCnLWVtXHeYXftq5AVeT1T6cZ6Wkc2MtRe5Gm6lo3W
         yXFTuXNJldFyWzSvywqwVvRPTEaBTIGCvC+B4aYoonwUZRJBjce4yI2Vgiz2BjcKU6rp
         GfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7S17/wfWeBqDwbUr46rB5oyJqzuscExA8s4NdaSGFAKzBMGxwPginu9LHPrhutQPR9b0abX78sNdG2lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lzxMZ0QO5I25xacrfyezQ44pLZZadn7o4nPMUfAYysHL1U1B
	mG+fliJTYKEfX5Knu2mjmcmP3UhOW67uvk/mUU5stkWCVNrT+X2GZswE/foyNCN0Uorxbf/P5mt
	T
X-Gm-Gg: ASbGncuzxd73abC1t5ElJYZrg6BnO0sS5P0hn+T64j+acuGFVYp77Ky1qNoyKf8nVWK
	r6SewwQqi7dJ5azFXDAG+drTYnvP+TuYNt7UoBf1FnCcNG5Cz7rXEq1j65kOHcGUuMYSFxQKNix
	lhdbMZ7gHeD1E3UgYLoEGdaXk4nPdiUhs2RRX6h5D6lPkD4Cxr+zl8pzKdqUcur3Dhr1o8L2sEt
	dSlW/T1qzpjSxVI3lxmTnshGTxRwmCcsKpsbCUwz5TfhX+hijCokCEar2pkMcx8LmhkOVUK952P
	MHdKDx63CpCEtHMXEGJT0ONB
X-Google-Smtp-Source: AGHT+IE3cgVYn2eGar0O/0ukNoQm0eNJyqOC9Rc7IYrJXB1nvpH/MMWIepoLzgF5QZxzzXxBuI1P4A==
X-Received: by 2002:a05:6214:2b0e:b0:6e4:242b:934 with SMTP id 6a1803df08f44-6e6b007f744mr39430526d6.17.1740159185600;
        Fri, 21 Feb 2025 09:33:05 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65daff4a8sm100224966d6.97.2025.02.21.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:33:04 -0800 (PST)
Date: Fri, 21 Feb 2025 12:33:03 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
Message-ID: <20250221173303.GA1316314@cmpxchg.org>
References: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>
 <20250214212647.GB233399@cmpxchg.org>
 <CA+i-1C3e_JUBBhMDYwrehvLZzLtb9pfgEy8=wQa=9uTBr1-b5g@mail.gmail.com>
 <764394d9-592c-4d68-8910-67362dd8810a@suse.cz>
 <20250218203830.GA1264207@cmpxchg.org>
 <CA+i-1C1m-p0GkYE8QTd39qEG3Pb_QMsEs=dLH1_87giDVhVH2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C1m-p0GkYE8QTd39qEG3Pb_QMsEs=dLH1_87giDVhVH2A@mail.gmail.com>

On Fri, Feb 21, 2025 at 06:24:45PM +0100, Brendan Jackman wrote:
> On Tue, 18 Feb 2025 at 21:38, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > @@ -1930,7 +1929,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
> /*
>  * This can happen due to races and we want to prevent broken
>  * highatomic accounting.
>  */
> >         if (is_migrate_highatomic(block_type))
> > -               goto single_page;
> > +               return NULL;
> 
> Side question: when does this happen? Might have a spooky gap in my
> understanding here as I thought the only reason the pageblock typed
> was changed without the zone lock held was during memory hotplug.

Good job catching that. I don't think they are needed anymore after
the hygiene patches. I had proposed removing them as a follow-up, but
never got around to it:

https://lore.kernel.org/linux-mm/20230912150320.GB3228@cmpxchg.org/

I'll send a proper patch.

