Return-Path: <linux-kernel+bounces-366958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F77299FCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1EC1F2552C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE961422DD;
	Wed, 16 Oct 2024 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mbtChjbV"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC421E3CD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036891; cv=none; b=oam4oXDQab4It7lI+NN89f+YKa1LpCcJX5snMZqyP64Rc2g+X/EmeZ3ij7vLeh8Ye3ZzQmlJI4QdAVuxHhWdupkzB8fNT2raKdhEy1T24fGE9OZNCxUzPMtOlTZJrWkVeuRbjiFAjvq0QmUBL1b6wNMm2H1sIaiwucZeQtDZAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036891; c=relaxed/simple;
	bh=ZJMHfdFl40Jew9Db8fPQXUqbsd6wtiGA37UqAtoMAKU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGuC6tNGQPkesoP2CqXWArEIqIdLOuT7JupJFM/EN8eGm0JjLG+tro0u6r37q3+iG3EIueFH/YxpJFDwD2hGD0DtXyydmkdLTp9jlDDlmjTexl/Oa7NbGr0shzwl0WXpRnHRR3/R2yM+VvOdg5JAsh+fQleOrv+eqbAF+AJ1HGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=mbtChjbV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c5acb785f2so31241536d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1729036888; x=1729641688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xvFHgFKvO5/gieDiOaoU8RXGfIAzjnLuO2tCqQ4vsXo=;
        b=mbtChjbVRxj9rwU6g1BSVAupZSC05M4VfSDFgiE3A4QAWpO9AS4yEu1eANyX8zYwCc
         mNOe3t/1x6TYTIMyGJG8axFaCm9aRmNOIo7hvMvi6ysSxdSb1g7LRqzGsbQ7Pvl6iK1j
         OW+urcsVi0TVx8KchUGObERC2DiyQfzfG1MSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729036888; x=1729641688;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvFHgFKvO5/gieDiOaoU8RXGfIAzjnLuO2tCqQ4vsXo=;
        b=EFgp7Mjmob3917By8Ya7Ux7PIqvoj1IVNNvm01pyG+z3LDP/rsctHj8VMlkQEHqTvG
         iIrU4JYb0hmhztaVSuqLzkuWGa5bdF0vuwYjbXQqvBWlpG6Bn0mUpUf/TzzAyKUITICG
         h8O3aGdHZKAqKVNGzsdBRgpkKocnuNRb85lJsn94/5fl1f0JjRsXL/SFYP3YD6qS7ArV
         wH3rudmrGSL11SQD2Q3UnYKl11JD2EaocZ/g/f1YVTJGgbRcRPajd/VKSFR14ea3WYwY
         k2wKnxKpkS7ZjMs5XcipaDEV5Gf8mYNP7R0bxw+gndu9oZuYQ2ZNUFoxV1tppTExYQOY
         3vsw==
X-Forwarded-Encrypted: i=1; AJvYcCWEU7VqDf0hwETxlyVRzhFd3dnwaF5noMUbnIaot/pEgVHQ7ydUdR7fCmlJ2Fw7ocPHd4uBgPZ4Nvb2fKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMUaRNyquOv3P1VbNlj1SaOqZdRWpgna8YRFakVIwaQXW0ldV5
	gVn4DFy1PrgYT3LRtMRlzF9CMG0rkV30vTy7qSmVKrMnWqWsX4yYtpLfdgnr4MXzK3VWBflQ2OK
	p
X-Google-Smtp-Source: AGHT+IGFUHOVYpa5KmX86teubmJx9xKEjLJnnz6GJHUgs88i09coAXcRd+X6WZKxdB3snA1E4wz6SQ==
X-Received: by 2002:a05:6214:4343:b0:6cb:728c:8bd6 with SMTP id 6a1803df08f44-6cc2b8d7140mr28758546d6.27.1729036888552;
        Tue, 15 Oct 2024 17:01:28 -0700 (PDT)
Received: from localhost ([91.196.69.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290f962sm11957356d6.13.2024.10.15.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:01:27 -0700 (PDT)
Message-ID: <670f0257.d40a0220.9c8db.5c21@mx.google.com>
X-Google-Original-Message-ID: <20241016000123.GC973@JoelBox.>
Date: Tue, 15 Oct 2024 20:01:23 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/3] RCU CPU stall-warning changes for v6.13
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
 <670eb924.050a0220.63bb1.4746@mx.google.com>
 <f5a833c4-6346-4ec4-8360-4a818342fb52@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a833c4-6346-4ec4-8360-4a818342fb52@paulmck-laptop>

On Tue, Oct 15, 2024 at 04:02:37PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 15, 2024 at 02:49:06PM -0400, Joel Fernandes wrote:
> > On Wed, Oct 09, 2024 at 11:05:02AM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > This series contains RCU CPU stall-warning changes for v6.13:
> > > 
> > > 1.	Delete unused rcu_gp_might_be_stalled() function.
> > > 
> > > 2.	Stop stall warning from dumping stacks if grace period ends.
> > > 
> > > 3.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().
> > > 
> > 
> > Other than small nit in 2/3, 
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Applied, thank you, and I also added the data_race() in 2/3.
> 
> > I was curious if you're seeing perf or other improvements with the
> > finer-grained rnp locking.
> 
> This is about robustness rather that performance, though I suppose you
> could argue that lack of robustness is an extreme form of bad performance.
> Holding the leaf rcu_node locks for too long while dumping stacks can
> result in things like CSD-lock timeouts due to the dumping CPU having
> interrupts disabled for an extended period.
> 
> And earlier commit, 1ecd9d68eb44 ("rcu: Defer printing stall-warning
> backtrace when holding rcu_node lock"), took care of most of the issue
> by deferring the actual output.  But while in the area, it seemed wise
> to avoid up to 64 dumps being generated (but no longer printed) while
> holding a leaf rcu_node lock.
> 
> Hence this commit.

That's smart to do and makes sense, thanks!

 - Joel


> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 						Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > >  b/include/linux/rcutiny.h |    1 -
> > >  b/include/linux/rcutree.h |    1 -
> > >  b/kernel/rcu/tree_stall.h |   30 ------------------------------
> > >  kernel/rcu/tree_stall.h   |   35 ++++++++++++++++++++++-------------
> > >  4 files changed, 22 insertions(+), 45 deletions(-)
> > > 

