Return-Path: <linux-kernel+bounces-345482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC598B6D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8811F226EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419819CC2D;
	Tue,  1 Oct 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTXJmIL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667519CC0B;
	Tue,  1 Oct 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770982; cv=none; b=r6N1VCVoInSudODTKYShma8Y5lVY5GG9xvrv2q+pQbH8p1Xqw7Vd9rtYx4dVrq3bAJwtTqf493yKS+zO2w5D8S5te7lygnZrbwzJ/Q15r7YnuMtOZ3trjB2i394N4giLLvi8f4piuNwTTxL3dEtn2ZVDArzU+Nr9s/Y7rtduWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770982; c=relaxed/simple;
	bh=AJJvr4rGsV2c+7hzHqkqiMcAUcBQt2wz2CkNKaAjmro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPU14ynIcG3i2PelvKco1LbNrp7wLNy2D4ENlm7F7QfhJoUXTi0FB5BDIMA0NOa7VRrneO1zWoz+gW2mi8nPJaJLO6NgJMx8uHqCFVtm0pR/mvuT5GAK1gyOgQ3qWEbn+Z0JNlI/Z6vjeGyRpEY8hqQzBOqD7UbIJnsjTAzcgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTXJmIL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446BDC4CED2;
	Tue,  1 Oct 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727770981;
	bh=AJJvr4rGsV2c+7hzHqkqiMcAUcBQt2wz2CkNKaAjmro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTXJmIL0HeNauSDQ4UQzSlxqyMHv4Pu7i1LiedJLY73hKT5pKKSuqq2f5Smpo3sk5
	 eGQSl0xlPRR3hLJn5YZJBMJXU/3mtvttdgtZ8rdnbfYQHNv7MxoKAqegq5FkcKofGn
	 otkVd1Y05yWSA2YWNOUJnqblciuslbf+BniIRkIA=
Date: Tue, 1 Oct 2024 10:22:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: CVE-2024-46839: workqueue: Improve scalability of workqueue
 watchdog touch
Message-ID: <2024100116-shaky-iguana-7f54@gregkh>
References: <2024092754-CVE-2024-46839-cfab@gregkh>
 <ZvusWymx4rGO55NG@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvusWymx4rGO55NG@pathway.suse.cz>

On Tue, Oct 01, 2024 at 10:02:02AM +0200, Petr Mladek wrote:
> On Fri 2024-09-27 14:40:07, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > workqueue: Improve scalability of workqueue watchdog touch
> > 
> > On a ~2000 CPU powerpc system, hard lockups have been observed in the
> > workqueue code when stop_machine runs (in this case due to CPU hotplug).
> 
> I believe that this does not qualify as a security vulnerability.
> Any hotplug is a privileged operation.

Really?  I see that happen on many embedded systems all the time, they
add/remove CPUs while the device runs/sleeps constantly.

Now to be fair, right now an "embedded system" usually doesn't have 2000
cpus, but what's wrong with marking this real bugfix as a vulnerability
resolution?  If you don't run your system in a way that allows cpus to
be stopped unless an admin says so, it will not be relevant.

thanks,

greg k-h

