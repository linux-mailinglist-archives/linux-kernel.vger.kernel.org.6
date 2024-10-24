Return-Path: <linux-kernel+bounces-380490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF89AEF74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDDAB251C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCE1FF7B9;
	Thu, 24 Oct 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK0OpRkA"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB02003C7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793615; cv=none; b=fK62C5AN0D7BKjQ6AcQTet9v3yN4py/5HNj5x81kHshfVdBoO4qyqAe/2I5OhqEI8bizUL0JeYNiuJWTHxcQrapq3lq88HMc9BQz6RjySSOAaHUPQNXrNd8eL+sLzI5W2DUvwF9fDgiKQS9CN6M1TmkxWxDqFuKK8YkATWrAzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793615; c=relaxed/simple;
	bh=0gLe6NHOG92pQEGjjPof1iR7mZJaLcKflve/uEao75k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1OyI7lOpU8Hu6TYWLEI/4sm7akOYWqInQXe2V8HzEiikt725kqjcpLMhQNJn2IKkGEU0wtuZV/VrrfQxLVPT0TjiB/6REbDW4O+8p9iYmQloQEgSJk35Q0w6K3G0an7gMigt3YKDcI4lRPLYug833SSeou/nvg7KULKkBmSLX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK0OpRkA; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b0247d67so4749005ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729793612; x=1730398412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KElvkcoCdWuugkIgjm4VYhnrKDOwYCGs3Tu2Zr3567Y=;
        b=GK0OpRkARzvLpaXcTth0PS1XEFUGXNYjgk5DQvOJncQd4jkA7tVPjonn7CTWasitt5
         7ZjUyJX5ESggZmEekBOUuZ/sK7iZEaaeQXCj5p7CcbXnekP1Ln5S7BMPb+1O5b3mZOf/
         68GAbtWf5/EwozezFxMD83OocIv6IAAhGFe3LvK4DF8Q6ZtHweV1LXLCDwpF0bn7uL8r
         9JszFhCnXZke1OwL8OUG2b/JM49nnYXXSjhLgCkUMOx3OpIjMUeY2CfSt3lJvckdj8Cs
         rLJhO+sX92oH//YhYO+MgR6PCfQAYl2XXFhmqnWpCh5A0MIwBi6Irh0DFZGB4hDj9L5q
         tqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793612; x=1730398412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KElvkcoCdWuugkIgjm4VYhnrKDOwYCGs3Tu2Zr3567Y=;
        b=TsjJLqyGST+FQ5husHWmddlHVVIIpeXg9cpN6haOKhAMOAL28bbOl1ALMCRSY92ctw
         N7hNoff/WDycqFRE5HSL3JZY1g2/nk8SHdzDR+N4ybaM9INth5cxPeXR7mv37X9BmVkU
         R0dghXGYqvBIinrM0QENZsqXcGAaFl0V0FYuqCMlPfJ1zNh/8GW3xdcesyZc2bWDqvwT
         o3u/XfbNXMIodATkaHXSvV0U1+lE6RFxlnE84UuR7+YHOhbdRNvrBQWuFEgjfI/go2vl
         m1Wa3PTkPiRTtAonUOmSs7R5vI4dd7NPpy5dYgh5BYfDFsbqk7BhWBKwc8EMJUPzflU1
         jqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzK5sEfxqt21Q3Wmkcax3A3hyOQTKn9nHRFAg4RA4+0HArqG38gMdgCB5ha1H+8RJ3FQyB+SCARrcRn60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JrNmMvQw2CsLnpjQcwDr5uJ3AOv0zb2zNq1KbzPun+NdwpYM
	s5eBmGKR5DHD3Nm72v935xZu1MY/C9+yQPEQkd3D5zSvahB8iB5O
X-Google-Smtp-Source: AGHT+IEO8kuJdouS8g34Z/zlGvWlpr/YHS3v9uYxgiaFsqsdvu/XAX2S1QCl8xQXiByFKTdke7/H6Q==
X-Received: by 2002:a05:6e02:12cd:b0:3a3:67b1:3080 with SMTP id e9e14a558f8ab-3a4d595c67amr75181115ab.7.1729793612093;
        Thu, 24 Oct 2024 11:13:32 -0700 (PDT)
Received: from eqbm-smc020.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb669sm8847432a12.7.2024.10.24.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:13:31 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:13:29 -0700
From: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	dan.j.williams@intel.com, nifan@outlook.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-ID: <ZxqOSbTa2z2JgOFf@eqbm-smc020.dtc.local>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
 <Zxk6bHlrP5S_0LBK@tiehlicka>
 <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>
 <Zxls4HqdkV_yBYxZ@tiehlicka>
 <Zxl1eOooy5lwJwSo@eqbm-smc020.dtc.local>
 <Zxl3fB9FVz5i1huh@tiehlicka>
 <ZxnTDYiQWU45eX-Y@eqbm-smc020.dtc.local>
 <ZxoEWBakAv64wfhD@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxoEWBakAv64wfhD@tiehlicka>

On Thu, Oct 24, 2024 at 10:24:56AM +0200, Michal Hocko wrote:
> On Wed 23-10-24 21:54:37, Dongjoo Seo wrote:
> > On Thu, Oct 24, 2024 at 12:23:56AM +0200, Michal Hocko wrote:
> > > On Wed 23-10-24 15:15:20, Dongjoo Seo wrote:
> > > > Hi Andrew, Michal,
> > > > 
> > > > Thanks for the feedback.
> > > > 
> > > > The issue is that CPU-less nodes can lead to incorrect NUMA stats.
> > > > For example, NUMA_HIT may incorrectly increase for CPU-less nodes
> > > > because the current logic doesn't account for whether a node has CPUs.
> > > 
> > > Define incorrect
> > > 
> > > Current semantic doesn't really care about cpu less NUMA nodes because
> > > current means whatever is required AFIU. This is certainly a long term
> > 
> > I agree that, in the long term, special logging for preferred_zone 
> > and a separate counter might be necessary for CPU-less nodes.
> > 
> > > semantic. Why does this need to change and why it makes sense to 
> > > pre-existing users?
> > 
> > This patch doesn't change existing logic; the additional logic only 
> > applies when a CPU-less node is present, so there shouldn't be 
> > concerns for pre-existing users. Currently, the NUMA stats for 
> > configurations with CPU-less nodes are incorrect, as allocations
> > are not properly accounted for.
> > 
> > I believe this approach improves logging accuracy with minimal impact
> > on the memory allocation path, but I'm open to alternative solutions.
> > This isn't the only way to address the issue—any suggestions?
> 
> I still do not understand the actual problem. CPU-less nodes are nothing
> really special. They just never have local allocations for obvious
> reasons. NUMA_HIT which your patch is special casing has a very well
> defined meaning and that is that the memory allocated matches the
> preferred node. That doesn't have any notion of CPU at all. Say somebody
> explicitly requests to allocate from a CPU less node. Why should you
> consider thiat as NUMA_OTHER just because that node has no CPUs? That
> just seems completely wrong.

Thank you for your feedback. After reviewing ur reply and [1], I realize 
my misunderstanding of numa_* stats. I mistakenly assumed node referred to
CPU locality. The current logic is indeed memory-centric and operates 
correctly as it is. 
I appreciate the clarification, and I now understand that no changes are 
needed to special case CPU-less nodes in this context. 

Thanks again for pointing this out.

[1] https://docs.kernel.org/admin-guide/numastat.html

> -- 
> Michal Hocko
> SUSE Labs

