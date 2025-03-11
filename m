Return-Path: <linux-kernel+bounces-556600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02452A5CC27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989A2189EA41
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD192620E1;
	Tue, 11 Mar 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HxoaFUfb"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A42620DF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714193; cv=none; b=KfZnUY0MvaqeAPIf999jPq23yz3lK2galLprAc/52JRpl/WR4Z+bn4xQafXPnmLfOBWYS7EXlvlMATzCGHGjPzgmM6xXupBQUu+mIXJKXBxoRzXlVwl5nDuAPoH2Huicg2a8ffQLiPT2zHJkIFS7EvEwe4Qy7sCPg9Cl0zzZQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714193; c=relaxed/simple;
	bh=bz4i3vwBWiRTM/4WsD2Sgt4Gf4wuWjf4iqMscKzae8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLJT5qO8unyHCMruxJpJX5DcVpdSIRmjK0P8Xsad9FiICHUkpwDUuzFsaWBHMGfXduQbDW//O0fLebBI3wHzuWfT2tsYmr5sewK4CGyimF4nHMrfuBGGkz8Y5L4N0eHW/eLgswSuhPpolrtqsHFcRF2o9JWXNLPUZ5Vqj2xYNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HxoaFUfb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0892e4b19so578345285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741714190; x=1742318990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InkYCZuBh6NtBXn1ZPIqBAGqEuGWZOKnkIkfR4YnU14=;
        b=HxoaFUfbrZUrQq+54bTOc/oqToROTePvuagj1D5v+cyKComqRU14NdCmShFRTPdOVp
         a7TMb4e+swXMqAAEVmHtr+8YEBCgExulU+c/qiHzRvUIeoY4+nO6pFWTJVaLcpijsr2a
         afm0tuR4i1wOTqEuHpOqny5/WpHoMS2D/FEuVBD5kcES6caqdXfQWEvRKn1KtG3TZfzf
         DbNjEEmvJWJgfYzgPNzAVZ4b5cQ9KKi4Jx80+3mgNJSPH3yFR08oP6JJezc0H1THqYNV
         t+RMxhNa4bhz8rGiFo4e75wXaZFJknNFMIzBr3jMt1HeOfXXIUBu8jl1WubAjWU1afbn
         aFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714190; x=1742318990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InkYCZuBh6NtBXn1ZPIqBAGqEuGWZOKnkIkfR4YnU14=;
        b=hQt8NGUAAZIN8GRIlJadNNjWd2qIpSEYZbHfYHybFnTtiEl5/5b4jfzSFeX6bzcWP+
         /8kpGcjXtVPaJFm/PKM74sS2BB9rWc6Ic2sssq3EQ3oCjSQHgq4bjl8/d+KHY7F/m9+6
         N2IKfyQjXWMVHamkst9o+7hZPWxtuodK80zKvNxoECvGglvxnx4tVDCj8ASuehbYPHUx
         mmhKa8d3tIKx5v3wbzde5KhiF9NOyED5K1JPqAoqLrpTXl135Jnh5Pl0gVFIr8CGVMD8
         ofTSHqDdenXDHJBYS1pFvmhBxPTBXJNfHgMZDBEl6O9Ds2MBbR/W5h7Z+n4F1jkoI4MA
         gKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF+2sKpeVSDoeDFZyYYerWh38jST+AesOQPOdrevCqiwHkHLYDJBT9A0UCxudzsdSTKR/R1rF1+hy4Kp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszN1qZGEglop6z1naqcYybjPJWYjPQRpWfjaQyqIGU+SLhXBq
	ekfccwN6EWK4xfwyJkj3AMYivU7bDCMkvqNdQxx2u+4HU1LBxxu6g3nE7jGGcOk=
X-Gm-Gg: ASbGncvcSxl+vMDYs6IfZ5Yzd98BgvpKU3AFc/nASMkh3E+KtlhqOWOca+ja9wBFuEr
	YYSxq6aDzlQ4DpTW2PFH3cVCYau/ULz54STpf5cZUJyagsV4gc80bs7k0IdJPjP7aOwcTRUiinm
	m0dIu5rRKJXXW6guvnzloM8M/PMtuOR0UAwSDRkRZy/nyCoU5/0YyU8/PydAlAKzs1fW1ZqEJBm
	QZpytHkApcGde+MDt9Xc2WdGza9f5AmrcgczOKN9yB1KDE77qzb8T+yOHyH1x6LYO356AxvgrB3
	xwoPD6aOlesY4dt9yNiyfaQs4fu069q2SjN8tZSE2Co=
X-Google-Smtp-Source: AGHT+IHsp6QUFpMLzg6RFZfT24l93gao05k4Ok3I8RY1SmxsMToyPGVIKqWah9c5Rc1/JLuYkzCUNA==
X-Received: by 2002:a05:620a:26a3:b0:7c5:5585:6c83 with SMTP id af79cd13be357-7c5558573cdmr1464793185a.54.1741714188560;
        Tue, 11 Mar 2025 10:29:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f715b718sm74299356d6.91.2025.03.11.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:29:47 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:29:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Message-ID: <20250311172947.GC1211411@cmpxchg.org>
References: <20250310230934.2913113-1-shakeel.butt@linux.dev>
 <20250311153032.GB1211411@cmpxchg.org>
 <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>

On Tue, Mar 11, 2025 at 08:57:54AM -0700, Shakeel Butt wrote:
> On Tue, Mar 11, 2025 at 11:30:32AM -0400, Johannes Weiner wrote:
> > On Mon, Mar 10, 2025 at 04:09:34PM -0700, Shakeel Butt wrote:
> > > Currently on cpu hotplug teardown, only memcg stock is drained but we
> > > need to drain the obj stock as well otherwise we will miss the stats
> > > accumulated on the target cpu as well as the nr_bytes cached. The stats
> > > include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
> > > addition we are leaking reference to struct obj_cgroup object.
> > > 
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: <stable@vger.kernel.org>
> > 
> > Wow, that's old. Good catch.
> > 
> > > ---
> > >  mm/memcontrol.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 4de6acb9b8ec..59dcaf6a3519 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
> > >  static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > >  {
> > >  	struct memcg_stock_pcp *stock;
> > > +	struct obj_cgroup *old;
> > > +	unsigned long flags;
> > >  
> > >  	stock = &per_cpu(memcg_stock, cpu);
> > > +
> > > +	/* drain_obj_stock requires stock_lock */
> > > +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > +	old = drain_obj_stock(stock);
> > > +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > > +
> > >  	drain_stock(stock);
> > > +	obj_cgroup_put(old);
> > 
> > It might be better to call drain_local_stock() directly instead. That
> > would prevent a bug of this type to reoccur in the future.
> 
> The issue is drain_local_stock() works on the local cpu stock while here
> we are working on a remote cpu cpu which is dead (memcg_hotplug_cpu_dead
> is in PREPARE section of hotplug teardown which runs after the cpu is
> dead).
> 
> We can safely call drain_stock() on remote cpu stock here but
> drain_obj_stock() is a bit tricky as it can __refill_stock() to local cpu
> stock and can call __mod_objcg_mlstate to flush stats. Both of these
> requires irq disable for NON-RT kernels and thus I added the local_lock
> here.
> 
> Anyways I wanted a simple fix for the backports and in parallel I am
> working on cleaning up all the stock functions as I plan to add multi
> memcg support.

True, it can be refactored separately.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

