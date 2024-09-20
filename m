Return-Path: <linux-kernel+bounces-334198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875297D3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD591F259D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803213A265;
	Fri, 20 Sep 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="BDZX8kUC"
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960631CD2C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825206; cv=none; b=HS2RusEJIQSts3+PrQT6M6yoU6wUDVykkhTM7NAjAIW6nU9B91XGazmsCQUvrT6p5TOXpGn3FOMAsD6UAd6XXq/qh4sriqd0UrMlfU5XY14qT9LaXbgRiUU5Vh6rEtdKBqTJ2jMTkd6ESxtMzkqG8lDCe1JhyOEAp0tP96psh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825206; c=relaxed/simple;
	bh=44HEoMWww84Pcnv/H6Tw7cZpnbaRCQNzD86IDzZyHLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxsyen4yj0zOoFwEXfRwg0mjmhI3UA/bz2cb/DWJL6chX2F62TKKgLH/SxkS52UzVnTiTdGhjhCQ9a07TQ9BLTtFr7yrpjlAuAcH/eAyuQMkBYglrM5djs1C6lZNA2c+tObxRHYHImokB5O/wMTPnt9pn5tLUQU0FjHynGraVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=BDZX8kUC; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rw93B/21NuWVfL/ibqQ+YISfWYXzFqSVN+KXpI2YlJQ=; t=1726825204; x=1727689204; 
	b=BDZX8kUCXnX43fo3qcOYtcGzpzeGW/cMNjqFIzfxYpoUwrLdN+hPjuGFckTrMoRpcSFRn1bnPoc
	CWL7PK9DRZOgjYe+FI3Y9Ay7f9Rx7K+zNO4iHZwPg0PeQT3OpQReDcGQx0zVfaHZtaQmaXQbqueKj
	fYOA1bK5S0ljfLjgj7IT9JSIlsZc1OTEErpctzDOQwqqPtfHD8/V8alV6NjtQhnImTusEPVZxjGwx
	c2OgSn//KP56EIV1jkxn/nTWM90SUipk0AVwF08PHnbO8CUCSE2mftiIN33ycLMt8W65rANLkVbhb
	WVb2nadZ2MFtv42ztehghv7Cvr1YC/B82HXw==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1srZiO-006Dkk-ES;
	Fri, 20 Sep 2024 05:14:12 -0400
Date: Fri, 20 Sep 2024 09:14:06 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Message-ID: <Zu083vRBZRwvvVz5@csail.mit.edu>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
 <b1dc2aa1-cd38-4f1f-89e9-6d009a619541@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1dc2aa1-cd38-4f1f-89e9-6d009a619541@arm.com>


Hey Anshuman,

Long time... :-) Hope you are doing great!

On Fri, Sep 20, 2024 at 12:28:44PM +0530, Anshuman Khandual wrote:
[...] 
> > @@ -1908,6 +1908,7 @@ static const struct seq_operations vmstat_op = {
> >  #ifdef CONFIG_SMP
> >  static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
> >  int sysctl_stat_interval __read_mostly = HZ;
> > +static int vmstat_late_init_done;
> >  
> >  #ifdef CONFIG_PROC_FS
> >  static void refresh_vm_stats(struct work_struct *work)
> > @@ -2110,7 +2111,8 @@ static void __init init_cpu_node_state(void)
> >  
> >  static int vmstat_cpu_online(unsigned int cpu)
> >  {
> > -	refresh_zone_stat_thresholds();
> > +	if (vmstat_late_init_done)
> > +		refresh_zone_stat_thresholds();
> >  
> >  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
> >  		node_set_state(cpu_to_node(cpu), N_CPU);
> > @@ -2142,6 +2144,14 @@ static int vmstat_cpu_dead(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +static int __init vmstat_late_init(void)
> > +{
> > +	refresh_zone_stat_thresholds();
> > +	vmstat_late_init_done = 1;
> > +
> > +	return 0;
> > +}
> > +late_initcall(vmstat_late_init);>  #endif
> >  
> >  struct workqueue_struct *mm_percpu_wq;
> 
> late_initcall() triggered vmstat_late_init() guaranteed to be called
> before the last call into vmstat_cpu_online() during a normal boot ?
> Otherwise refresh_zone_stat_thresholds() will never be called unless
> there is a CPU online event later.

The vmstat_late_init() function itself calls
refresh_zone_stat_thresholds(). So, we don't need another CPU online
event to happen later just to invoke refresh_zone_stat_thresholds().

Does that address your concern?

Regards,
Srivatsa
Microsoft Linux Systems Group

