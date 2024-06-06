Return-Path: <linux-kernel+bounces-204677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C288FF236
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FE11F20F04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134019D08A;
	Thu,  6 Jun 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiTR5taU"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1D19D080
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690420; cv=none; b=RA4cGvFXbT9D6WRLVmC0JW6gHuCyQ8dxRHEGLI40Ed+ztdH0fuwS3XQL0KN7EDwojyvtHk7/HrPOee/V+ZvnfghQIC6cDjaXj7vFJXwGuNYlof62Qqf7PybmRen8oDfjDGIeSXH9d6yqHMxRWMFfZTWcxzS5WfEMsQqWvan4vNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690420; c=relaxed/simple;
	bh=KG3hb5X8K20zAVLnBnAIIFcAA7+yWFbwp+HNoGxJH7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIZCcrMpGjG3+32IeeHHLZbKmW1NZLEiQxupOEqe2oTbOTSnpEN9mGhbHdy7/h7Mp7CeS7XaldpiyBTyrF9wm1Eb5bVzQJOouo82e090N0y4CoJIFXm9rOShLaaMRgsmBKoM598tAYwz8ZOz/n7wLvh/JgHCW2zKYKdlH8YW8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiTR5taU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b912198a6so1453943e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717690417; x=1718295217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7bsWDf8kON0466WBez1F6joRJhVo6XD8WRuZ2wLnFs=;
        b=QiTR5taUqUA/iw28iq2G28DpQPHmsQyTyUSJv5VexJ+6qg6pCObgkb9erOpgTyaQas
         YylaoCyXD0bXb5dCDeQ8hlx2rBTLyjM4SBl2wOcBDY1F6WftTEnU8/l11/62yvUGB+Ly
         2nOlSdeCp9piNNVQJ4lBsdgkTIJsTuUagPAB1EUKz0B05XrBVEWXmHRCxYRZhyDLFD7L
         siy3CvRjRgS/3RmYf0eKGuNYVvg7CveDT4fGLIQKWYKHT8P9sEAfqwYnudZAyAqWCeev
         sDw+oaP5Dvc0+Mw5Z98bEOLAKWZC2/4UESfLLaBf/pU6mGUZGOhW3z/gBerJRq0VaKPP
         rhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690417; x=1718295217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7bsWDf8kON0466WBez1F6joRJhVo6XD8WRuZ2wLnFs=;
        b=oDPm4lGXv32OwoH0g3j/PwcPr+yD971X3viKptl3BIl3lQx1fD/4u2xedWYo5R5C0Z
         46PAx6XkYybm3UGzFNQVwl5S7sHW47YUcIt9xYo+jx1PXBdgS2c9JAD2rTY6OpahBWVU
         vxy6bStmyp9s6LYG+KlSTsJMknj5RFcQLFHzX+GtSckb2g++R4aZbVq+RR5cu+cDgdFK
         aDS2PVgM5w1aD6CxWWFXsgl0Liu9c38Zq6PCath/OyqHy1oh81JLqAc4auKqeWguxcNm
         qyPX17H/gUy2A0/XNMBHJIG/gMk1femp7vugGLtSBZgMUeCL68pO40hzXeUvwDzk3Ncd
         o4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJzi9jEsnzlLxCY9lniVbxCFDd9dWp7yi+R7/Gr3rfGp6z29jO884v2+4OjRojKsyWYm4/y/k3OTr3grNiXiOorett3hECQFu/96Tu
X-Gm-Message-State: AOJu0Ywtku2MvGipr2wprCyu7L/fDevWmhZNNOTHhmFf6B1wexKiPcDg
	cdamItYRqRjJ9FNwyk0ulkT8mfVSfba8n3XVtTVpIFnrHxTNDGu+
X-Google-Smtp-Source: AGHT+IH+i+DxBJox18C+7HwhFhJzwcv17ZDP9UUSj9sX3PfM1T/ntR1jP0iBsCJGdN+8VMRID8zB+w==
X-Received: by 2002:a05:6512:3b88:b0:52b:82d5:b361 with SMTP id 2adb3069b0e04-52bb9f8e244mr86616e87.37.1717690416780;
        Thu, 06 Jun 2024 09:13:36 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm60191835e9.42.2024.06.06.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:13:36 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:13:32 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH 1/2] tools/memory-model: Fix bug in lock.cat
Message-ID: <ZmHgLFJNRekyVAiH@andrea>
References: <eb202b3b-7408-4ab9-be82-81ca554b7603@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb202b3b-7408-4ab9-be82-81ca554b7603@rowland.harvard.edu>

On Thu, Jun 06, 2024 at 09:57:55AM -0400, Alan Stern wrote:
> Andrea reported that the following innocuous litmus test:
> 
> C T
> 
> {}
> 
> P0(spinlock_t *x)
> {
> 	int r0;
> 
> 	spin_lock(x);
> 	spin_unlock(x);
> 	r0 = spin_is_locked(x);
> }
> 
> gives rise to a nonsensical empty result with no executions:
> 
> $ herd7 -conf linux-kernel.cfg T.litmus
> Test T Required
> States 0
> Ok
> Witnesses
> Positive: 0 Negative: 0
> Condition forall (true)
> Observation T Never 0 0
> Time T 0.00
> Hash=6fa204e139ddddf2cb6fa963bad117c0
> 
> The problem is caused by a bug in the lock.cat part of the LKMM.  Its
> computation of the rf relation for RU (read-unlocked) events is
> faulty; it implicitly assumes that every RU event must read from
> either a UL (unlock) event in another thread or from the lock's
> initial state.  Neither is true in the litmus test above, so the
> computation yields no possible executions.
> 
> The lock.cat code tries to make up for this deficiency by allowing RU
> events outside of critical sections to read from the last po-previous
> UL event.  But it does this incorrectly, trying to keep these rfi links
> separate from the rfe links that might also be needed, and passing only
> the latter to herd7's cross() macro.
> 
> The problem is fixed by merging the two sets of possible rf links for
> RU events and using them all in the call to cross().
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reported-and-tested-by: Andrea Parri <parri.andrea@gmail.com>
> Closes: https://lore.kernel.org/linux-arch/ZlC0IkzpQdeGj+a3@andrea/
> Fixes: 15553dcbca06 ("tools/memory-model: Add model support for spin_is_locked()")

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

