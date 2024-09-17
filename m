Return-Path: <linux-kernel+bounces-331710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470D97B05C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF1D2829AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD817107F;
	Tue, 17 Sep 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHPyhCTY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236E18C22
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577306; cv=none; b=ahQXhxqczbCsTucP7A4sALGqQOW+ERaJKRlyxXWOIieINBj/45zU+ZcjkFmYbgkItAt2qviOATYnimjVTeechit/y1zMzW41IzcBiD1dZ/JbE+bPhh3AFfJxQRee+qQiHVUUecYTsiviLKxKdqRfo22JG2s+f0Y3QlZofoFYG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577306; c=relaxed/simple;
	bh=Auh0l9mk/HtJYy32riQ0qQTCSBjLeeVyrPkhkhC2KVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNmbt6bEHJRXgI8duC30puzJdOcCZyv/kZ4oUnJPG1Eyj4V947Al3hXTE5OPcHSSxrHespTkwkDRKCxdj5p2QEtX+o3Uu50cshdfUajOxlW3nfZR+qGnfKt9lk5/3XBkADjiyaIj5aF++TkdFK7FOM08i1kcVBiYA/zic4RbCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHPyhCTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F050C4CEC5;
	Tue, 17 Sep 2024 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726577305;
	bh=Auh0l9mk/HtJYy32riQ0qQTCSBjLeeVyrPkhkhC2KVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHPyhCTYps7clwo2AYNS1ihKTIE/s2mQfAEAATfZVkWNtCzyUiFpMzK/VwCQSfEAR
	 T/ljJ//ZnviMXHC+v6kkDgneqlZBJ3zlNMvJrjbFtpgbBJXQ21h6GdEthoZeTEZFVm
	 ihPPjKBE730rIHPgDJXsMeMl+gV+faFbrYbn8qQf6mFS0pKUGMTgfQbzEh9ilg+kjG
	 m5HeDeVEkcvEjBf7q+j1Fm1MerI4on9vbe31dYs6l5xP3izXedhPpc+6mF/846BWXG
	 hpdHTYeKnTnYfPkqFk1/dDdw/MGPh7JX/Lg2sT+/3hfMIfFM3k9lWMqESSLVIMv025
	 GoSqKbsaCCrXg==
Date: Tue, 17 Sep 2024 14:48:23 +0200
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
Message-ID: <Zul6l-S_JulEnDQw@mtj.duckdns.org>
References: <Zo3PgETt43iFersn@slm.duckdns.org>
 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
 <Zq1NksrG9blyN-KR@slm.duckdns.org>
 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
 <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
 <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
 <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>
 <ZszKI2GA-8yparh_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZszKI2GA-8yparh_@slm.duckdns.org>

Hello, Aboorva.

On Mon, Aug 26, 2024 at 08:32:03AM -1000, Tejun Heo wrote:
> On Fri, Aug 23, 2024 at 02:50:01PM +0530, Aboorva Devarajan wrote:
> ...
> > I applied this patch to the almost latest sched-ext (for-6.12) branch upto
> > commit 89909296a51e792 ("sched_ext: Don't use double locking to migrate
> > tasks across CPUs") and let the test run for over 20 hours, and it completed
> > without any hangs on both x86 and PowerPC.
> > 
> > So, indeed, making sure that both scx_fork_rwsem and cpu_hotplug_lock (read)
> > are only held together simulataneously when they can both be acquired seems
> > to be resolving the deadlock.
> 
> Thanks a lot for confirming. Let me think it over a bit re. what should be
> applied.

Sorry about the delay. It ended up a bit invasive and took longer. Can you
please verify the following branch fixes the problem?

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enable-locking-fix

Thanks.

-- 
tejun

