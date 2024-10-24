Return-Path: <linux-kernel+bounces-380576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75D9AF2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E42867EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011101AAE27;
	Thu, 24 Oct 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hAtqRDGd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F06AB8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799157; cv=none; b=JQQgu9V2MqWCJQveI64fjKeSXuAyWW42XtWbxN6RLJIIkQjHIwC3cnydq4DV1bwyQ99GTeuid3JspCsIH/Yxsx/zggr3QFMiraWGreKil8qPS5Yh/rczfxkdXw1gM1Cgc+BUc26BRASlsg+TmagD7WDX5dFQr9tXfgVmfwQv9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799157; c=relaxed/simple;
	bh=iV4qip6noqFvRmg0+R4crLreWqZF1KJ9+3ujyzBCiGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9tsALgWAg54WUZdO8hfxFgID5WhwlqafajybbrFmfxa4qYmgTsc+iFEmgusInw8riABdkh87oksa3if4Lkn877rLmA5hVu8CGLP9DFM1DwyFlMG0aM/7PqiraMULksZI3dvzhJmPanuAOHfuDMBrAzeNQ3K0U+zj3ZY11GD/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hAtqRDGd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d49a7207cso913085f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729799152; x=1730403952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPb8mKU+KzjeBNrDUNxSqXqnN5Ly29w8syBmz/sIRLU=;
        b=hAtqRDGd5/Dp3Qx77cngVdPP3Q2XeBY94seKUHJcbObv07tuQlFXITLSfaSRftacWC
         g+z7pM1U+JzqScRKTgeh4S7SEnBh2uTccxTBPXTj3GTkXVDvzwgaZqOmLjP0YFVzt3de
         we8arjDxpKEOylU4B/NbQN3+n4DrrUVa/7R73E2sX0D95lcp1yZV7F2ZLj1Ie7KUH/8e
         uCDoByP+PkmPCOEI6+CgLeNG01bR77MvVt2gtjkx6h/pT1zrAdw04R+W3n2UfJAbtB6T
         rQ9MFzXpTNlbTT5LSMCdbPWVClrnSvnzgFWdWaHZgf5HpNsVPTfi2o+N572o/mTBUWlM
         ExMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799152; x=1730403952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPb8mKU+KzjeBNrDUNxSqXqnN5Ly29w8syBmz/sIRLU=;
        b=aU01zAUAd6G53a3V3toyWdPWpUEm9Wc/t/7HPIPRsPa/06+lmsHjtJtAo7epnNsAmf
         Juum6Rlym+uag+BAUyTG16b0OQaaB3qxEaPsn+9K+pI5XvWpiSOSwbMwALR6CeZ6Wckw
         KrpOd9/uQH2lwwgIW3uF9uE7nntgCuKQNWvJMhRe9k3ESwQoUoF7KqI0QAgTLd+P7c70
         O3NMcxYaQsSOda/KDl+iieeZtyIk/rSDgrLfhaiF27geTOryOlRD6nvXWpNGJOnxbyG3
         g+7OkVn0nE8C1LI1HYhKn3bUMMaH/Oto2a/sGb/fWGPqtTzhyDj4ZVduLlc8AR8LV/1i
         Hy8A==
X-Forwarded-Encrypted: i=1; AJvYcCUQbhBdzbmNyPPLNcmzjSD8x1rhDdnxhl6HQ7JSSeyNktXi8xVPe4NgbZCXuMte6ALlKt5fYOHNg3F+b7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRt5MUun/icFw+nMxAgrhbhXtXOCf+aVDl/kuh/BoPW+iYs64V
	HvD1qhOk4BD+unw3Y1DS9iqg7m98pyZ1N5laaceJ9WbSroFTn1cE8/51DCXY0/w=
X-Google-Smtp-Source: AGHT+IE1KNGuPkNPkWg4AR/AqGNEoAixnMnbilmy5HSq6ddD61ZBw/aVan4Y3rF9DyyvlVhbhsb4eA==
X-Received: by 2002:adf:e848:0:b0:37d:4fe9:b6a4 with SMTP id ffacd0b85a97d-37efcf897aamr4839640f8f.50.1729799152197;
        Thu, 24 Oct 2024 12:45:52 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0ba79c8sm12008716f8f.117.2024.10.24.12.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:45:51 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:45:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <Zxqj7hw6Q6ak8aJf@tiehlicka>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
 <Zxp63b9WlI4sTwWk@google.com>
 <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg>

On Thu 24-10-24 10:26:15, Shakeel Butt wrote:
> On Thu, Oct 24, 2024 at 04:50:37PM GMT, Roman Gushchin wrote:
> > On Wed, Oct 23, 2024 at 11:57:12PM -0700, Shakeel Butt wrote:
> > > The memcg v1's charge move feature has been deprecated. There is no need
> > > to have any locking or protection against the moving charge. Let's
> > > proceed to remove all the locking code related to charge moving.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks Roman for the review. Based on Michal's question, I am planning
> to keep the RCU locking in the next version of this patch and folowup
> with clear understanding where we really need RCU and where we don't.

I think it would be safer and easier to review if we drop each RCU
separately or in smaller batches.

Thanks!
-- 
Michal Hocko
SUSE Labs

