Return-Path: <linux-kernel+bounces-531450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF4A440A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428DE166386
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215A2690DB;
	Tue, 25 Feb 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vceDglkQ"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1B2690CE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489640; cv=none; b=gaaJff2S3W4x0V4tHlrVLzBEEe4HQMTDnevAGRmzSydbghZ35R2Buta79FDTq+jWO4LFDCrYeb4dty0/qj2qTk5+6bF9ISF9IN8hsjD5XGUd6HyaIK2Qa0WUnLnSJw1IXklbUIBOUkavM1u+B9Fh6O0CEj0F6cVz1G/VcQLTT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489640; c=relaxed/simple;
	bh=u3yEwLudzQn5Appg1EKIWuwC8eP34YxzNljiK7UUCCg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9Jvvy0pUCUr2CQdw99SSbx18N/ZDhrC4CX2OMwmLYSVyhNDN5PQKXpLphdvAaSoYrVlhg4j9k6nRqEqMxZQX1DjO4t38WEVzdcX0gDo2WGE99IHEqrQPpCvfkBV856DFIuAdQEy+5N+KlmVxnw7kpTBbTl5x4L+WEDcst3nqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vceDglkQ; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740489327;
	bh=+oQG0kubNNcrUEyDC0x1SXjD6cJ/muvA92NEGb9rnSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vceDglkQgrwvb/l71lq6tNX5AivBJf7PHhg0WpslKeAkEbD9s5SMJ1dMxhJv9STtT
	 JH3+MhM+JbM6Ac94WjVUXw+095nUErB/9pNzdjAnoA9cjCHVvehOerfBzajg4OZCRf
	 ECRhw9bpjaw7TM3BftwSlFsD74WSvwhnzIkNc14A=
Received: from chenyu5-mobl2 ([118.114.56.201])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 3D80A29F; Tue, 25 Feb 2025 21:15:24 +0800
X-QQ-mid: xmsmtpt1740489324ty7p96lgy
Message-ID: <tencent_CC411B43EAD996961A06366F606C96DD0406@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2E6enTI6knP98gdgIednHXvZvEccsRAn9oe1QGR85OzNNIkaslU
	 Q+h5S9Q1+2jjv1ibfUEDZ8WjHmIsJuCdBSokzipwjIAldc3a8CrJTh6bhbQCGqg8ZIzGWQE46gy2
	 6kr5DGGTUMwBtLiHN++HGGETiGq/ScptKEOPD0v3ewPGqNV/fcXbUw8q1lNN+oQ7g1c2hVshM910
	 ciRiT7BsPcTBREqtrGnRRXmFO6ghcxSZI8pvbR0tiKm5WvhPtmFCRbL798g4eMP4xkZE/CeTp+GX
	 MAfEXVCBdZ15TtEr2/Lr1nQcfDvXdZPLxHWRo6yAzMXZsLy6P6Pm1YcSOZeJeHF5KI1oq9MdaVFE
	 Ab0Ayfx4eUwN3YgSuUB2IR1Js10SPUmKFZGg+yuDXUq44VS/BQkJLN7KeugpQdwK/1WoFjwy410P
	 VCzckYVh1FYCQ54DqqkEm/Ht6mjba/PIFuDYYwk2rJRNBVvoj9xzeHELV8UCmvyhokdOsTeKXyRJ
	 rwsK6JnlEdWSNjcpovR2tIUOHT0pYzvBUS8sOA87WYR/BKTOZNqB1nEuQ4J5Zj8/hyQJTP0FyWhg
	 C/yeTC92fyzKuwSIiJtNJFDHTqSc+ojmsUYKApwwLlPecGg0wkLSPQ02BPlcBPJ4o1iIdpF0nnJu
	 QV6WICJ1ChGZYJZpavGvm3yEEOYdxDoxF9qKl2HJEO8j18W0z69EOnFTKV9nLjtC/go3hLGad2t+
	 1pe/HbNuE7qs3vjXz3EyJ3jEhtYZQu9LCPvY/qBFWuC3ZOtli0StsOzHaKX7ofDXX0hh9GSZT2er
	 8V/Wp3v1E44dO0Pfb14rWQYWfcZHaCgnKVX+Ief4tBOVE5Cs7QQuombY+EPmx/iJzKooqC19v0cg
	 /+wTonDgeIUgMDTrb/RqTKJlh0WJXkikKstYBmkqOaApQjzR0rXNisFPa2gRi8LsW6h/6QiMY8Nr
	 bZPfmQjgNXppMuDnjMoF+5toFXjbEOqcuaB53IaM/IcRd1NKfhxA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Date: Tue, 25 Feb 2025 21:15:56 +0800
From: Chen Yu <yu.chen.surf@foxmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: zihan zhou <15645113830zzh@gmail.com>, oe-lkp@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  2ae891b826:  hackbench.throughput 6.2%
 regression
X-OQ-MSGID: <Z73CjBppcf/zhrOW@chenyu5-mobl2>
References: <202502251026.bb927780-lkp@intel.com>
 <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
 <20250225122705.GD34233@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225122705.GD34233@noisy.programming.kicks-ass.net>

On 2025-02-25 at 13:27:05 +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2025 at 05:31:34PM +0800, Chen Yu wrote:
> 
> > 
> > But consider that the 6% regression is not that high, and the user might customize
> > base_slice via debugfs on-demand, we can keep an eye on this and revist it in the
> > future(we have encountered some SPECjbb regression due to over-preemption).
> 
> You can specify a per-task slice using sched_attr::sched_runtime. Also
> see commit 857b158dc5e8 ("sched/eevdf: Use sched_attr::sched_runtime to
> set request/slice suggestion")
> 
>

Thanks, we'll have a try during the next test cycle.

thanks,
Chenyu


