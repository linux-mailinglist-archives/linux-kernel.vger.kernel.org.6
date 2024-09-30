Return-Path: <linux-kernel+bounces-344675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8616D98AC97
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279AA1F210B3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB11F947;
	Mon, 30 Sep 2024 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsTsPjyG"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF5199EA6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723704; cv=none; b=o3JI8UtdurZ0gjcQKyqrREk8P3G0m179QgjHxKtx4AIPTCdWeqlyJAsqpfeSUtBzFLxt9meQ2v5/Tb66nO1zdJHR0WyP5GGLhx6PJo05Fi5bh/+RS3bE38nLs4W+e+xouEYshbmTI2S56fZBSxdcbqLNT6GGwm4uefo1fH1A6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723704; c=relaxed/simple;
	bh=UEF2Fwjpx5P37OsRngoBdF6N/EpKrrdBSykNEd4BzCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToyBec8oeLd68Ketl69p9y/raytDVxaYpCTaK3EUNQADQ0eSkYo4WHMhk134bprleO+DZKKD00WCVro8/t3c1bfWSVpaRbeGtK6N8Oe3nmPIBTHcn2bP6apCevcukQALIMp5pyUZzSPXVK6TWQcBVNm3DTCQWyY47PRyRoszsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsTsPjyG; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82ceab75c27so294019839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727723702; x=1728328502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DVqxGfSg8iHnTTZ+Ngu7bvZYhFVLN+hPZgrG3l79BI=;
        b=RsTsPjyGtiJ5mJin0eJSCf8TmFuprRlYItaIaeBHiRX8KE8Hfba72pLyJuE/LTLPtd
         Fnqq5puVHYmi2MXJLigLvZUkjwlafQR8tjmdKB0H2Sc2dNZSF7l/gcxq432jg0bmJJEB
         HcdNxlClGSlLPR1TvEvqEflVJck51V2urm+ebzK7Gmqbq90GxQBSCKQ8IrFuuxV0V7TP
         AjWoCn5xHuuAIXP9ANGsOIuOr6hJ1b/8G5itiszlnFT3eSo48e6ciq+VjVeJYZQM7nAs
         Y+0GfxU11lrMgOw4iyZociqhdQarrj4t2kVEt6/c+GToi7/cz8ey11NcPsxHZKjWCtng
         PJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727723702; x=1728328502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DVqxGfSg8iHnTTZ+Ngu7bvZYhFVLN+hPZgrG3l79BI=;
        b=M3ixLKlko7Y/VPMgqsRXT/dyip9Xl67hOj8xBwP4EwJvCsf6E3zT7C8CRtpwLeZBd+
         0QaxRvFm9O4bKL4dkZ5YoEYFQ+E5nAAO+Ft5BXJkEptSaCNJt7ZqOv7Ca/tIBMGBpQ2t
         BU4ExLKGKWM9xFPNbpR/T5WHX0hfFAE7twPvQRgEEpcVyILjGi5ik/5xGZFVgc+3/jZr
         mk/4Azyf35qVH0dyWVkv4v26RAz6lN1k7mrh3WvgzNj9ukcRyITzzKo8c47u3FgwqKMo
         ToZ59dRz0rp2xm68Nncb44+qZsKeGweDQV0kLztdKLeMObxhHry7nhHR2+sBMu+88xaO
         ZJ4A==
X-Gm-Message-State: AOJu0Yz+PTT/Qq7Gp9IiGQwzEELVtyc64FO+16zyT2WUU9P3UVOPfdqr
	06YzzMxmuv7JY+AeYC78SsBoWZxOUQrjsr1j7SpRe5ldsELhIR+xIPnoZ25R
X-Google-Smtp-Source: AGHT+IH5m6Nd9+kBOtVNKFXC6bx9Soal0bxA82c2viow5fjiCs5H41KOcAEsusQOAUZok0e0MueKyQ==
X-Received: by 2002:a05:6e02:20c5:b0:3a0:9b0c:6b2c with SMTP id e9e14a558f8ab-3a3451aadcfmr107503685ab.18.1727723702070;
        Mon, 30 Sep 2024 12:15:02 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b2f67sm6824204a12.24.2024.09.30.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:15:01 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:14:59 -0700
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chen Yu <yu.c.chen@intel.com>, Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
Message-ID: <Zvr4s9ErpD9F81YH@yury-ThinkPad>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
 <ZuW_0fMfPSix4qqX@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuW_0fMfPSix4qqX@yury-ThinkPad>

Ping again?

On Sat, Sep 14, 2024 at 09:54:43AM -0700, Yury Norov wrote:
> Ping?
> 
> On Mon, Sep 02, 2024 at 11:36:04AM -0700, Yury Norov wrote:
> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> > even when cpu != i. In such case, cpumask_equal() would always return
> > true, and we can proceed to the next iteration immediately.
> > 
> > Valentin Schneider shares on it:
> > 
> >   PKG can potentially hit that condition, and so can any
> >   sched_domain_mask_f that relies on the node masks...
> > 
> >   I'm thinking ideally we should have checks in place to
> >   ensure all node_to_cpumask_map[] masks are disjoint,
> >   then we could entirely skip the levels that use these
> >   masks in topology_span_sane(), but there's unfortunately
> >   no nice way to flag them... Also there would be cases
> >   where there's no real difference between PKG and NODE
> >   other than NODE is still based on a per-cpu cpumask and
> >   PKG isn't, so I don't see a nicer way to go about this.
> > 
> > v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
> > v2: https://lkml.org/lkml/2024/8/7/1299
> > v3:
> >  - add topology_cpumask_equal() helper in #3;
> >  - re-use 'cpu' as an iterator int the for_each_cpu() loop;
> >  - add proper versioning for all patches.
> > 
> > Yury Norov (3):
> >   sched/topology: pre-compute topology_span_sane() loop params
> >   sched/topology: optimize topology_span_sane()
> >   sched/topology: reorganize topology_span_sane() checking order
> > 
> >  kernel/sched/topology.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.43.0

