Return-Path: <linux-kernel+bounces-260333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9093A777
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74129281B90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8002B13D897;
	Tue, 23 Jul 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N+zk+g8P"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3B13C8EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760791; cv=none; b=iXLUSGggiF5sh+Ds2KZLorQiosIgzZBhf1ma0wCbDiUf5/iZaCmr+XPF0mcgc9lEsnW0A8FS+/Z21KAK0X0OSgURlvMmw922nx0v0NjF5UemUJUT6pAVtbLKodPzh4ccbJMtC1CxxOq7hIYbAKF11aHNOaspwMPr23bvyNJsL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760791; c=relaxed/simple;
	bh=qz/H5+/DTGzIZt1ZaTR006NppnsMA4cSgYGZfMDsBG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhzmesQtLICJNvgy+rI8TKezkzOkP7VcO3cS+hGRcvQ2P9afWMxBeV8t1mUuDO2RO39CtPOo9aXMd6UUTleKjiX0KRWGjabeWW8kidGu2y9tr3sH0PsrblP/c9EpCtbaubz4Yrl3lOhHPlMSR9cZ3XvBACXKIN29GJGQKtxTDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N+zk+g8P; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf7cfso5188038a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721760788; x=1722365588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVVj/cCy2oiJw2oQFMpyw/dNkqdjUwzvcq4UB4HNEXc=;
        b=N+zk+g8P0+HUVFH0N7MMghXU/ujnMGA66A528sElC3eAUOS9jdw/pR9eiThs+QdTbz
         Hmib9Pz49zycKxtjeMJLec/vG92wOYlfBfZfCs8HxDn6C/dvfLQbVZ7KstpTa7guUOL7
         rg1JG7ivzVslragGv9jYJVBxo/bBJfcpDFVEtnSOUXFTY9aV9A1Ecoo89NeUXyxSCN//
         S5qAsWrgM1i3+HBh2i1lJL8zMh81ZTqxs/2T7eXqspFYvQi7hg8RvMtLmGAV1Gh8Bkef
         UW1u1NLOkrXXq2jk3d9NslrMF+9778iM992rhdVvD6Qyi4WfIAr1ONTL9IioPuAxMkhZ
         9PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721760788; x=1722365588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVVj/cCy2oiJw2oQFMpyw/dNkqdjUwzvcq4UB4HNEXc=;
        b=PMrX8pneJ52DyetzNjQL+m3Muw0qpNVK5RJybJZLyc9Gm86FNNVHchFrdyXT4ZhdbM
         sLfuAk46R7km7Rk55MM7eAKocHjokche6abBljVoI+vQ1HhPpYSMt362XNdbejLT3vo8
         Q1BMcQSpAZqxlIfq7fmROrVPgtDTSNLi1XK1TPu/zEaeKJD1KSSyHw565bpPTtQ1LpDo
         Sequn8IUyOeRwp6Te5ZRkbb9VsGycrZMoPSbTWrRddqYlurDmYoATf1x5+S59VLgz3e5
         xACijNSnNRVnUq/cSWqUu3kGWHvq2bLTDIDb4lhlSsLQVgisyaACG1uNmREPNMSrpaUJ
         nQiA==
X-Forwarded-Encrypted: i=1; AJvYcCVBfF5ITK4W1UrUWsLQXM0BzUiBeQso7xpBB+HcakYp3XmVpCse5TIVYQIxoWcWapDq4rQ4hj8nCGU6FB4IF39sejzaUJDlw+aEJSZd
X-Gm-Message-State: AOJu0Yz19HJwu8LtP0pdQj5OdOTHDiGFP3fKy7OqRXpxEpvYkxbyBgeP
	xFYxPbs0QPKJ1IiYrSFKmNM1k8lPGfF9r/tkSleiC5TTCTkXYHzo8Q7oM101AAg=
X-Google-Smtp-Source: AGHT+IGU5izBNSNx/9V+PTQTzUGAa2O7y8xkGeR1qCRxtketF1SAQy7A5fxH+5zcMtT/IhDRYbqE6g==
X-Received: by 2002:a50:c047:0:b0:5a2:838a:15fa with SMTP id 4fb4d7f45d1cf-5a47a33a349mr6201088a12.15.1721760787929;
        Tue, 23 Jul 2024 11:53:07 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6e67sm7895632a12.17.2024.07.23.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:53:07 -0700 (PDT)
Date: Tue, 23 Jul 2024 20:53:06 +0200
From: Michal Hocko <mhocko@suse.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <Zp_8Eo4AuoZOfuZ8@tiehlicka>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-3-dakr@kernel.org>
 <Zp9gtelmvzN5tfpS@tiehlicka>
 <Zp-JCWCPbDLkzRVw@pollux>
 <Zp-MMcf1xUgqtFGS@tiehlicka>
 <Zp-aRJAIVI9B2pKb@pollux>
 <Zp-eJ6QTsT0wrlS-@tiehlicka>
 <Zp-xLOa7NFOt4r1V@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-xLOa7NFOt4r1V@pollux>

On Tue 23-07-24 15:33:32, Danilo Krummrich wrote:
> On Tue, Jul 23, 2024 at 02:12:23PM +0200, Michal Hocko wrote:
> > On Tue 23-07-24 13:55:48, Danilo Krummrich wrote:
[...]
> > void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
> > {
> >         void *newp;
> > 
> >         if (!size && p) {
> >                 kvfree(p);
> >                 return NULL;
> >         }
> > 
> >         if (!is_vmalloc_addr(p))
> >                 newp = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
> > 
> >         if (newp)
> >                 return newp;
> > 
> >         return vrealloc_noprof(p, size, flags);
> > }
> > EXPORT_SYMBOL(kvrealloc_noprof);
> 
> This looks weird. The fact that you're passing p to vrealloc_noprof() if
> krealloc_noprof() fails, implies that vrealloc_noprof() must be able to deal
> with pointers to kmalloc'd memory.

You are right I have oversimplified this. I was hoping to follow
kvmalloc model with a clear fallback and that should be possible but it
would require more changes. Scratch that.
-- 
Michal Hocko
SUSE Labs

