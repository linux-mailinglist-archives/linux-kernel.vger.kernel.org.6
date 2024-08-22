Return-Path: <linux-kernel+bounces-297563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163295BAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A910B2A8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F96C1CCB2B;
	Thu, 22 Aug 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cvMHwKn8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775561EEE3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341704; cv=none; b=AJ+XwhroOJK2nzQfMmH3tg3hIBGdmD0N290+DzrAobfN4a1ehXQD7Vc+1efCNsTgp/zNxc5sCBiTTDZ5OrXomJD55u9MwjR4A7Gln006x9ieFh1cfXM2tDQzH4JJjeoPAharFB/pNLk/KBtCPthAnEprua/bXTHlyF8olMXkJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341704; c=relaxed/simple;
	bh=s1EhVvaSO1gpIspbSHhTTtb5IH7FCC3bOxcpOGvXxd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMKCHejPTUyI+u/xP9I6wFtg2VEvPQOKUyFM4MJ77jiJrv2Z7FKV6DQB077SjORVg84X+9zyCQUp2sclS8PFjefsamXFdEqcTbWMMxwsF5RRaFefjLv9eJPlrGhreAHz2ym1chtMcDagEKZG20HrqyCJW5zp18HwUwAdWu04xy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cvMHwKn8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s1EhVvaSO1gpIspbSHhTTtb5IH7FCC3bOxcpOGvXxd4=; b=cvMHwKn89lTSVg5ozx28zkOtEj
	xxWOHeRJy/X8J3qWuI6UKX7lngVg6i5HwePTjTE1+cXaWEjokEtjDpjTJViuu+Tf1aCFMfXifPNDH
	ZZNxa/6o0GvdKA1UaKmNCPPL1R/RRWotY6HfWtYlp8Iug9q/HWIlqiDVuXA6YtJxgDfO74n2+eN+P
	NmXl46iVlG+RnLHkLnCPdgLbspv7RCW51o02Af1pM/olQIOjYgNPTqHMXc8J1gJqBs5fk46OvNjJv
	mUP2TKmHiPJY0b05P72BBhpe6rRT8nT/V2BolCc9z/nVlo5VgrTe9g3p/gNPWsx9DQxWFi3vqeRM5
	xF0JS/LA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shA2h-00000009zPo-2oz4;
	Thu, 22 Aug 2024 15:48:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E401300642; Thu, 22 Aug 2024 17:48:07 +0200 (CEST)
Date: Thu, 22 Aug 2024 17:48:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelaf@google.com>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH 0/9] sched: Prepare for sched_ext
Message-ID: <20240822154807.GA17097@noisy.programming.kicks-ass.net>
References: <20240813222548.049744955@infradead.org>
 <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>

On Wed, Aug 21, 2024 at 05:41:32PM -0400, Joel Fernandes wrote:

> With sched/core , it boots fine with core scheduling disabled, but
> when core scheduling is enabled I am getting hard hangs and
> occasionally get to the login screen if I'm lucky. So there's
> definitely something wonky in sched/core branch and core sched.
> I could not get a trace or logs yet, since once it hangs I have to
> hard power off.

Uff, thanks for this (and the follow up), I'll try and figure out where
core-sched went sideways.

