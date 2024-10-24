Return-Path: <linux-kernel+bounces-379472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDA49ADF11
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF5028475D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111D137930;
	Thu, 24 Oct 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KI3DbAky"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FF757FC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758302; cv=none; b=Vr33chWYGXtCiv2+7lk6aPniZg3KJpcqqTpBPxzJn681hgYGMbRihKqELt7+WRRCvFO9jE7g2GWpVLvJ+YubgLzK8Ynv9x+U6m1cSzr5/ciHx4C+FWxjjnLenCmZ0m/NuYy2OnFShLOBnzEtTA61CP4pcp8iqhaMQRmQdCaiXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758302; c=relaxed/simple;
	bh=9FNsT6ISVDeFGuCN1DU/1w+IcHnbXHrraMG7wVBrND8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNKDbZmwqTQdd1gNeNGokIyzWsNZehNIuayqa444vXTcfbLI8khEpF4ReSlYBax8OOLSVaJ/Eno15YaZL+7SovwkFn2hu3oXRQatyPdSRr4J2Sn5HjcOg2IbC0hSbGMMIJqrsH5UwyfsqYrI2xjQqcxYBhiNd4SjXMInC4AFItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KI3DbAky; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d41894a32so434010f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729758298; x=1730363098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CqiCsjxfc2P2m9O4T3RIYxyfddsRpc80UkRWd9InIdo=;
        b=KI3DbAky0tzgWuEMrdMcAFjqbVTUVrgl3TBSIrTMUCvKmNf+tWgcAY6KK/k/nR+Yy+
         KOfee8L5Cu+Y8p1+eGrEuVwziLDodJDiDtRYu9DMTRFPkm57achEER1Vfzom1sZswIq7
         kwe1ViakZ4WsTzbY0mtS1i5nmxLzd1V/SZRpmngmvyA+WpHYpuXtD6x/Bw2mAo5Y0IQM
         JWjWs9k1pbpmyi7KljAiXBrrpSxqO6cTCsMnglqqOckS5GGBYqzyPueW8VKMRFBEqmiP
         6o8XvchyFw+8MWyToeaopHVndhaus44Bd61c6n8DqcEbsyOn4CDE0n2GzOSBVwAlnhIB
         yz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758298; x=1730363098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqiCsjxfc2P2m9O4T3RIYxyfddsRpc80UkRWd9InIdo=;
        b=SnqugvIQ9/A13rlNSd7EJaDEMsW08nQyhIft48FTuATdgGFnMbprjhczkz0Dpp/uvH
         qRHO1c9OjyLzth6Sww53cG+DZ7n4PUlx/FJGMwgVZlO9Y68837fM8FeaNOCj9dMG355s
         gljsmZNmyFBzJ43l4+XH0MZrII4qWdhjhjsYfpa5z4oZvz8W6x7rlYyGIPAtaPIWY4sk
         ixIA9IBP9NRIigUBES4GrMLJI0fF0Ux5VJabWLlrEP5I2mDMy78aOuNZN6JbR97ELsPh
         +gfeHXcYCIzp0L++ZQzJDPut0Rho+c7isqds4/ASYv3vZbqA+rmb068g3H2X2BiuZSJX
         xBfg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ya1JAMvFvTLynRI90za+nk7WxsWGdykVrid9WntAOGlrZKqbVUoe07fwiNnR+yLRcGscUf9DEeueVH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6pVslAfIayTwhKRsBTuw7gKOeSDAI5uNcHtPPUWft30fKUTh
	HmYPcI1mJrmxcKa8xBztgceN3ahcVlu9Z79UGe6RZ8db/8m+nFthLhkgyUtRC9k=
X-Google-Smtp-Source: AGHT+IESJKOMwf+RZiVBHWmX3AZR4ukV/miP9SpvfZ2ei9dwjNnTMG2G35izlIu7na0hR/suP4zpfw==
X-Received: by 2002:a5d:4ac8:0:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-3803abf0250mr681659f8f.8.1729758297877;
        Thu, 24 Oct 2024 01:24:57 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bfaba0sm38007245e9.20.2024.10.24.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:24:57 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:24:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	dan.j.williams@intel.com, nifan@outlook.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-ID: <ZxoEWBakAv64wfhD@tiehlicka>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
 <Zxk6bHlrP5S_0LBK@tiehlicka>
 <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>
 <Zxls4HqdkV_yBYxZ@tiehlicka>
 <Zxl1eOooy5lwJwSo@eqbm-smc020.dtc.local>
 <Zxl3fB9FVz5i1huh@tiehlicka>
 <ZxnTDYiQWU45eX-Y@eqbm-smc020.dtc.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxnTDYiQWU45eX-Y@eqbm-smc020.dtc.local>

On Wed 23-10-24 21:54:37, Dongjoo Seo wrote:
> On Thu, Oct 24, 2024 at 12:23:56AM +0200, Michal Hocko wrote:
> > On Wed 23-10-24 15:15:20, Dongjoo Seo wrote:
> > > Hi Andrew, Michal,
> > > 
> > > Thanks for the feedback.
> > > 
> > > The issue is that CPU-less nodes can lead to incorrect NUMA stats.
> > > For example, NUMA_HIT may incorrectly increase for CPU-less nodes
> > > because the current logic doesn't account for whether a node has CPUs.
> > 
> > Define incorrect
> > 
> > Current semantic doesn't really care about cpu less NUMA nodes because
> > current means whatever is required AFIU. This is certainly a long term
> 
> I agree that, in the long term, special logging for preferred_zone 
> and a separate counter might be necessary for CPU-less nodes.
> 
> > semantic. Why does this need to change and why it makes sense to 
> > pre-existing users?
> 
> This patch doesn't change existing logic; the additional logic only 
> applies when a CPU-less node is present, so there shouldn't be 
> concerns for pre-existing users. Currently, the NUMA stats for 
> configurations with CPU-less nodes are incorrect, as allocations
> are not properly accounted for.
> 
> I believe this approach improves logging accuracy with minimal impact
> on the memory allocation path, but I'm open to alternative solutions.
> This isn't the only way to address the issue—any suggestions?

I still do not understand the actual problem. CPU-less nodes are nothing
really special. They just never have local allocations for obvious
reasons. NUMA_HIT which your patch is special casing has a very well
defined meaning and that is that the memory allocated matches the
preferred node. That doesn't have any notion of CPU at all. Say somebody
explicitly requests to allocate from a CPU less node. Why should you
consider thiat as NUMA_OTHER just because that node has no CPUs? That
just seems completely wrong.
-- 
Michal Hocko
SUSE Labs

