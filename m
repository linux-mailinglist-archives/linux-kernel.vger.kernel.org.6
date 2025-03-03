Return-Path: <linux-kernel+bounces-544432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0465DA4E11C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DFA189EA34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C052517BC;
	Tue,  4 Mar 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Itw1Q/Vp"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507823496F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098644; cv=pass; b=TWyLuWOpYwtSWcal/+tb2YGd8oflCGOSPwpqAYR4wOjl+6VKZugLCaiBq/ta3GQkr//eiH9WCIYvSFBgFQ1W/PrefAs5SnjLgNKOo4hsQImkR6v8TIBjDzwoGWkZh93ezo7AnhRj6qLF3LRZH7BYAZsVfgWTxtrNsNvTb4wc8Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098644; c=relaxed/simple;
	bh=GcGZjB4psRJn240loMGAFUQ6PTe1U2vHy+yhCkQHk2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7iTymEvHtllNWDjqMRMsWVyN4p8AXJ9kFzTsuSsbvx6fRm3nx664laa4zYKzV+my8EFcRBc4yK+NboLXXgZU8iEcTQCNY6CPQsd7Aykk5oYdy/1PAnMxNrHEPEx0YdGbzaN6A1gFywZx1jkxycW8Vvo/PKsavg5AjVhY8y/ziM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Itw1Q/Vp; arc=none smtp.client-ip=52.119.213.152; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id D571740CEC85
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:30:40 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazon201209 header.b=Itw1Q/Vp
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dMM3CK3zFwjH
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:28:15 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 25B1742754; Tue,  4 Mar 2025 17:28:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Itw1Q/Vp
X-Envelope-From: <linux-kernel+bounces-541862-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Itw1Q/Vp
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 14EC741D5C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:57:37 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id E06F5305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:57:36 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91BF1894FC8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83E212FBC;
	Mon,  3 Mar 2025 13:57:26 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F41F3B9E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010243; cv=none; b=XKSGSVwAuOwW5QR+cJsL1ARDp4pcUHfdqoy0GzJwqtgYqFbxDhsrVJzdHgXtoti8+hbvQwCNuZBTLExdGmzmy1ETQyymdqg1sCS3I6HiLuBhKA3jYGPQaFPZUTZE8oRKJCn9ZPZEwAzAJpxPY4eWtC54AUtIIAQxgy7xVJC+kwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010243; c=relaxed/simple;
	bh=GcGZjB4psRJn240loMGAFUQ6PTe1U2vHy+yhCkQHk2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2X/cQohFxXWd96qL+otl7a4/42mE3yknrBk9GYYl8zbbgr/gSqrUfE9l4OvGd4OSp8q+3/fCl5aRu3/iw7KXoqfTYVscbRVbOVmhrHHAg8Oda4dwxvyhnplbzBynVREiSefyfqZadP0SkD4tgeNVtMMqZi/JvumP3+aLQVVyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Itw1Q/Vp; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741010242; x=1772546242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EcQU7JWqSgBdXG7/K0YCP2UVn+lCPSs4bSrgwB88G3k=;
  b=Itw1Q/VptXvToxtFulH6HEIvORBgeq3koVI860MoPNbdadMpQh5rkre3
   SxhgN+KDPkTfELYx0CwwZH8thsQoi0bOXHKGMn9HXy6qkDl3tat26C5br
   Gs2Wf0ztt3IArm/o0VbCFXFVUByxaKBDV7/YgmA5pLJgRpOmhe2mbqi0J
   c=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="70793752"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:57:19 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:6856]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.78:2525] with esmtp (Farcaster)
 id 17630173-f0aa-49ad-a610-76369532b75c; Mon, 3 Mar 2025 13:57:17 +0000 (UTC)
X-Farcaster-Flow-ID: 17630173-f0aa-49ad-a610-76369532b75c
Received: from EX19D018EUA002.ant.amazon.com (10.252.50.146) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:57:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D018EUA002.ant.amazon.com (10.252.50.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:57:16 +0000
Received: from email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:57:16 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com (Postfix) with ESMTP id 05F94A006A;
	Mon,  3 Mar 2025 13:57:16 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 8F59120DA9; Mon,  3 Mar 2025 13:57:15 +0000 (UTC)
Date: Mon, 3 Mar 2025 13:57:15 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: <hagarhem@amazon.com>, <abuehaze@amazon.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: BUG Report: Fork benchmark drop by 30% on aarch64
Message-ID: <20250303135715.GA21308@amazon.com>
References: <4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com>
 <20250207110754.GA10452@amazon.com>
 <1ca758c7-b6ab-4880-9cc7-217093a30bbb@arm.com>
 <20250210213155.GA649@amazon.com>
 <4b48fd24-6cd5-474c-bed8-3faac096fd58@arm.com>
 <20250211214019.GA15530@amazon.com>
 <75503128-c898-4da7-ab99-55f4ef6e2add@arm.com>
 <5f92761b-c7d4-4b96-9398-183a5bf7556a@arm.com>
 <20250221064436.GA485@amazon.com>
 <14a2aaac-05d5-4b2e-a8c1-617bb4411659@arm.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14a2aaac-05d5-4b2e-a8c1-617bb4411659@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dMM3CK3zFwjH
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703383.3033@+zftj7gdrMERAyPEu5FJkA
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 11:05:01AM +0100, Dietmar Eggemann wrote:
> On 21/02/2025 07:44, Hagar Hemdan wrote:
> > On Mon, Feb 17, 2025 at 11:51:45PM +0100, Dietmar Eggemann wrote:
> >> On 13/02/2025 19:55, Dietmar Eggemann wrote:
> >>> On 11/02/2025 22:40, Hagar Hemdan wrote:
> >>>> On Tue, Feb 11, 2025 at 05:27:47PM +0100, Dietmar Eggemann wrote:
> >>>>> On 10/02/2025 22:31, Hagar Hemdan wrote:
> >>>>>> On Mon, Feb 10, 2025 at 11:38:51AM +0100, Dietmar Eggemann wrote:
> >>>>>>> On 07/02/2025 12:07, Hagar Hemdan wrote:
> >>>>>>>> On Fri, Feb 07, 2025 at 10:14:54AM +0100, Dietmar Eggemann wrote:
> >>>>>>>>> Hi Hagar,
> >>>>>>>>>
> >>>>>>>>> On 05/02/2025 16:10, Hagar Hemdan wrote:
> 
> [...]
> 
> >> './Run -c 4 spawn' on AWS instance (m7gd.16xlarge) with v6.13, 'mem=16G
> >> maxcpus=4 nr_cpus=4' and Ubuntu '22.04.5 LTS':
> >>
> >> CFG_SCHED_AUTOGROUP | sched_ag_enabled | eff6c8ce8d4d | Fork (lps)
> >>
> >>    	y	             1		   y            21005 (27120 **)
> >> 	y		     0		   y            21059 (27012 **)
> >> 	n		     -		   y            21299
> >> 	y		     1		   n	        27745 *
> >> 	y		     0		   n	        27493 *
> >> 	n		     -		   n	        20928
> >>
> >> (*) So here the higher numbers are only achieved when
> >> 'sched_autogroup_exit_task() -> sched_move_task() ->
> >> sched_change_group() is called for the 'spawn' tasks.
> >>
> >> (**) When I apply the fix from
> >> https://lkml.kernel.org/r/4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com.
> > Thanks!
> > Will you submit that fix upstream?
> 
> I will, I just had to understand in detail why this regression happens.
> 
> Looks like the issue is rather related to 'sgs->group_util' in
> group_is_overloaded() and group_has_capacity(). If we don't
> 'deqeue/detach + attach/enqueue' (1) the task in sched_move_task() then
> sgs->group_util is ~900 (you run 4 CPUs flat in a single MC sched domain
> so sgs->group_capacity = 1024 and this leads to group_is_overloaded()
> returning true and group_has_capacity() false much more often as if
> we would do (1).
> 
> I.e. we have much more cases of 'group_is_overloaded' and
> 'group_fully_busy' in WF_FORK wakeup sched_balance_find_dst_cpu() which
> then (a) returns much more often a CPU != smp_processor_id() (which
> isn't good for these extremely short running tasks (FORK + EXIT)) and
> also involves calling sched_balance_find_dst_group_cpu() unnecessary
> (since we deal with single CPU sched domains). 
> 
> select_task_rq_fair(..., wake_flags = WF_FORK)
> 
>   cpu = smp_processor_id()
> 
>   new_cpu = sched_balance_find_dst_group(..., cpu, ...)
> 
>     do {
> 
>       update_sg_wakeup_stats()
> 
>         sgs->group_type = group_classify()   
> 							w/o patch 	w/ patch                   
>           if group_is_overloaded() (*)
>             return group_overloaded /* 6 */		457,141		394
> 
>           if !group_has_capacity() (**)
>             return group_fully_busy /* 1 */ 	  	816,629		714
> 
>           return group_has_spare    /* 0 */		1,158,890	3,157,472
> 
>     } while group 
> 
>     if local_sgs.group_type > idlest_sgs.group_type	
>       return idlest					351,598		273
> 
>     case group_has_spare:
> 
>       if local_sgs.idle_cpus >= idlest_sgs.idle_cpus
>         return NULL 					156,760		788,462
> 
> 
> (*)
> 
>   if sgs->group_capacity * 100) <			
> 		sgs->group_util * imbalance_pct		951,705		856
>     return true
> 
>   sgs->group_util ~ 900 and sgs->group_capacity = 1024 (1 CPU per sched group)
> 
> 
> (**)
> 
>  if sgs->group_capacity * 100 >
> 		sgs->group_util * imbalance_pct
>    return true						1,087,555	3,163,152
> 
>  return false						1,332,974	882
> 
> 
> (*) and (**) are for 'wakeup' and 'load-balance' so they don't
> match the only wakeup numbers above!

Thank you for the detailed explanation. We appreciate your effort and
will await the fix.
> 
> In this test run I got 608,092 new wakeups w/o and 789,572 (~+ 30%)
> w/ the patch when running './Run -c 4 -i 1 spawn' on AWS instance
> (m7gd.16xlarge) with v6.13, 'mem=16G maxcpus=4 nr_cpus=4' and
> Ubuntu '22.04.5 LTS'
> 
> > Do you think that this fix is the same as reverting commit eff6c8ce8d4d and
> > its follow up commit fa614b4feb5a? I mean what does commit eff6c8ce8d4d 
> > actually improve?
> 
> There are occurrences in which 'group == tsk->sched_task_group' and
> '!(tsk->flags & PF_EXITING)' so there the early bail might help w/o
> the negative impact on sched benchmarks.
ok, thanks!


