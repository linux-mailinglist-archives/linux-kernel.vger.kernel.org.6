Return-Path: <linux-kernel+bounces-181883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541E58C82C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A52836F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F051E4AE;
	Fri, 17 May 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7LI9t4g"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A21CFBC
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935996; cv=none; b=V3g8ABmFbuICh4vC4mSpns1xtCIdA+U0qXelNseGtHbCae2u3EfoOlfbJxobn/FW2Ff9WwbVItAdnxvxkI+/7NcR00YCd5gh1uOaOV4SWv9HUOeKLfH3QsAKTOnIcClX03goydoKamI3F1kKBFa8pSsfeDiBIhw4luxOsE4Bhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935996; c=relaxed/simple;
	bh=XrDZ2khBHaMtsbW3DKfVfsmfyIUUQMmLqt5TAhl53cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syadDqplp2AwmaO9TKDzopd5k2XbCPNBNtJa9DeFWc2+B8oUH1dyyVpbPa9lLceKIj//VZIOmMfPL4j2FHfmbsnmyfUK4GV71bcni+cMc3M/EKN8HbPqP/tsrRz+FzHPl00hAND901cos2CMZEJFgPUenFfV4O11F5BI94XwW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7LI9t4g; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so21393901fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715935992; x=1716540792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUnKK06+m9zxF848R1qs8HU2+D2Pu7/Qze/DSdxTlEg=;
        b=R7LI9t4gcHIo31g2P85GL/icgnQVVGxrlGuHk+XcILWlmbn6Jx58x9pU8STSYVpbyY
         neMWZevi/B5XdWxRFz1ByhQumSZ3yGbckXKW9/NNCq+kDF/LyNUw7PlK5hSCvYT6+Qoi
         UmFkKfYSvCiMxb1fB8PzqD5ohaa5pxmnJcg5sruaryC2QTc3sVIZhWvtvI37VrVSeO6h
         DxiPSqUHKz0Lw1FqFtRMQ1BIetfjoS6i/wJMG1/MqF/QmO394ugCJ5HeEZTVvU4QtesF
         ey5c7D7lkh0RlXic+YRknVKxUF4Qj5NOFxk6T5zdp9KuXsUDnic+1BWcHXnQJ63LPcUX
         9PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715935992; x=1716540792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUnKK06+m9zxF848R1qs8HU2+D2Pu7/Qze/DSdxTlEg=;
        b=UJNk99kVK9olAgEArY03vjHwr/II9fns+vqiZ0xKZktgonXRDwSYaAbuzomsLx9vYa
         brGy45XgPsACqCUB9wkD0OoH/SoLZQzeLmQndCXGPobhxAoWVNQ/il05hn4FzindUTx8
         zqkVahTz4nIp6p4lplVx5td7rByKOS0AV5fTWnr+eCPv/7wmPw78drJOw9GGZLs7ZUZN
         PrpF3fonK74XGM04lEQp9J0BH2GvYd46TubpKWfE1uZrXgsHI7JNyoJZ7cvoUM3IE7F2
         gC2/UrIDDd6bGHanE+CQaC43EDRv9eCmPT+0A+uO4FhuqonzJwbAC+Ce+EMuh0g5vr+N
         sJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCV4bOXpAvkkP2kIPmLM8rBAGwEON8U2i4ftDmNd6N74r7fuTRmbxPboe8jDkmx7LzU3u9JYP2pTLFyVvbKtXpwkD5dTyv8CkzH0CsGJ
X-Gm-Message-State: AOJu0YxCPX2nea50jRMQKg6tcZBefEPfsGrvIkFr9NbI8ebBtu4mrvmA
	vb9GMJ3I2AJlBezB3UmF3HPSxMKOOURwyX16bA3Zm7NCaQ882zP0
X-Google-Smtp-Source: AGHT+IGUGh68rD9VDYg5VoPspmITc/Dg5WaWIbDgsVs4E0iJoDyb8ifLul6q44yypgR7DR/ARf//Lw==
X-Received: by 2002:a05:6512:2003:b0:51e:25d2:453f with SMTP id 2adb3069b0e04-5220ff72f1dmr10395650e87.68.1715935992194;
        Fri, 17 May 2024 01:53:12 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2c8fsm3209359e87.279.2024.05.17.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:53:11 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yorha.op@gmail.com
Subject: Re: [RFC PATCH v1 0/7] DAMON multiple contexts support
Date: Fri, 17 May 2024 11:51:51 +0300
Message-ID: <20240517085151.630844-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240516221735.82564-1-sj@kernel.org>
References: <20240516221735.82564-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi SJ

> Hello Alex,
> 
> 
> Adding high level comments first.  I will try to read each patch and add
> detailed comments to those as soon as I get some time.
> 
> Also, please Cc linux-mm@ for DAMON patches.  I'd also recommend cc-ing
> linux-kernel@.

Thank you for clarification, I'll add them!

> 
> On Wed, 15 May 2024 18:24:50 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> > Currently kdamond uses only one context per kthread
> > and most of its time it sleeps, so utilizing several
> > contexts can scale kdamond and allow it to use
> > another set of operations.
> 
> Thank you for this patchset.  I believe this change is important for DAMON's
> long term vision.
> 
> A quick question for a clarification and proper prioritization, though,
> since size of this patch series is not very tiny.  Does this patch series
> is for your real usage?  If so, could you please clarify your usage and how
> this patch series can help?

No, this is not for some commercial use or so that I could describe. It is
rather just a RFC, because I'm even not sure how much this can help
in real use cases.

> 
> > This patch-set implements support for multiple contexts
> > per kdamond.
> > 
> > In pseudo code previous versions worked like
> > 
> > the following:
> > 	while (!kdamond_should_stop()) {
> > 	
> > 		/* prepare accesses for only 1 context */
> > 		prepare_accesses(damon_context);
> > 		
> > 		sleep(sample_interval);
> > 		
> > 		/* check accesses for only 1 context */
> > 		check_accesses(damon_context);
> > 		
> > 		...
> > 	
> > 	}
> > 
> > With this patch kdamond workflow will look
> > 
> > like the following:
> > 	while (!kdamond_shoule_stop()) {
> > 	
> > 		/* prepare accesses for all contexts in kdamond */
> > 		damon_for_each_context(ctx, kdamond)
> > 		
> > 			prepare_accesses(ctx);
> > 		
> > 		sleep(sample_interval);
> > 		
> > 		/* check_accesses for all contexts in kdamond */
> > 		damon_for_each_context(ctx, kdamond)
> > 		
> > 			check_accesses(ctx);
> > 			
> > 			...
> > 	
> > 	}
> 
> The overall idea makes sense to me.
> 
> > To try this you can use modified kernel[1] and
> > damo[2]. I also have written few simple shell scripts[3]
> > to collect data for damo.
> > 
> > 	[1] https://github.com/onlyoneofme/damon-multi-contexts.git
> > 	[2] https://github.com/onlyoneofme/damo/tree/multi-contexts
> 
> Looking forward to the patch for DAMO be submitted, or PR-ed!

Sure, I will submit a PR for DAMO later. I supported only 'record'
and 'report heats' commands, so others haven't touched, that's
why I decided to post it there (because it is not ready).

> 
> > 	[3] https://github.com/onlyoneofme/damon-multi-contexts-tests.git
> 
> Do you have a plan to integrate this into DAMON selftests or damon-tests?

Not in the form they are for time being. These are just simple shell scripts
that set up kdamond to use multiple contexts and these scripts only
collect information like DAMO (but only as perf.data).

Anyway, I think we can integrate them with damon-tests with some modifications
to be able to actually _test_ if multiple contexts work.

As for DAMON selftests, I didn't touch them for time being, so they truly
need to be modified and expanded, but before doing that I would like
you to look at implementation first, because changes in implementation
could affect selftests, so once we agree on that I will implement selftests.

Also note, that I didn't integrate changes with debugfs. I remember this is
deprecated interface, but I'm not sure if compatibility need to be preseved
with it, so do we need to expand debugfs for this?

> 
> > Alex Rusuf (7):
> >   mm/damon/core: kdamond_struct abstraction layer
> 
> Let's make the subjects clear what it does.  For example, this patch's
> subject could be "add kdamonds_struct abstraction layer".  Similar comment
> for other patches.  Also, I think '_struct' suffix of 'kdamond_struct' is
> not really needed.  Let's remove it if there is no special reason to add
> it.

Sure, I'll change that in next version, thanks!

> 
> >   mm/damon/core: list-based contexts organization
> 
> I think this can be squashed into the first patch?  If not, could you please
> let clarify?

I just tried to separate those patches for them to be as simple as
possible (actually I failed at that...), but sure, we can squash them.

> 
> >   mm/damon/lru_sort: kdamond_struct abstraction layer
> >   mm/damon/reclaim: kdamon_struct abstraction layer
> 
> Does these two patches mean lru_sort and reclaim are broken by the first
> patch? Let's keep everything unbroken in middle of the patchset, to help
> bisect.

Yes, they're broken by the first patch, I'll squash them, thanks!

> >   mm/damon/core: rename nr_running_ctxs -> nr_running_kdamonds
> 
> I think this would also better to be together with the first patch?  I know
> this does not break something, but makes reading patch bit complex.

No problem, thanks!

> 
> >   mm/damon/core: multi-context support
> >   mm/damon/core: multi-context awarness for trace events
> 
> I think these two patches should be squashed into one patch.  Otherwise, the
> trace point is broken in the middle of the patch series, right?

You're right, I'll squash them, thanks!

> 
> >  include/linux/damon.h        |  48 +++-
> >  include/trace/events/damon.h |  14 +-
> >  mm/damon/core.c              | 497 +++++++++++++++++++++--------------
> >  mm/damon/lru_sort.c          |  31 ++-
> >  mm/damon/modules-common.c    |  35 ++-
> >  mm/damon/modules-common.h    |   3 +-
> >  mm/damon/reclaim.c           |  30 ++-
> >  mm/damon/sysfs.c             | 306 +++++++++++++--------
> >  8 files changed, 629 insertions(+), 335 deletions(-)
> 
> Thanks,
> SJ

BR,
Alex

