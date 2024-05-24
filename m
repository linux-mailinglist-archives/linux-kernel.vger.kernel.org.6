Return-Path: <linux-kernel+bounces-188310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E934E8CE060
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69BA7B20D35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF81383AC;
	Fri, 24 May 2024 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAgG96Is"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F542E644
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525382; cv=none; b=Atcdx5FmfGtE3S7bixCefUC5WfpPb98p/bDcBpCAlP6twrNNb+5itkqM2co5kndaw6jeqteIKHqHZz0pF7DAjQGX89Ctt3ryoVXzQ4J6igOBNtkjOKhucFV1VyFBmtiwMfyb+V6gAla+aNsbHd2lKYHcIDrHHGnXGFQ5I//+jzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525382; c=relaxed/simple;
	bh=lo6fRPZJ4lniRYSlcwAxNm39c3zT4LDJA+k+Id/50SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqVlLyxbj2YKOxCGMU8o4XDdBg0cgmzZ6Q8Ufz+nj7Zdjfvz3TZdIyAbNa4RlHDvytss5SiP5bYFWcgNeL5HwNBOl67snPygLQsYASl9gx7sIqY2fBCwvI43bbN7Yokvx0KmY8RPyNV1K2XB7wkypku6mFcVVCbfsJjTSTRlMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAgG96Is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA4C2BBFC;
	Fri, 24 May 2024 04:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716525382;
	bh=lo6fRPZJ4lniRYSlcwAxNm39c3zT4LDJA+k+Id/50SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yAgG96IsgKvMBVeVyWhrsOddzgbcRUBy4j6xR67RBxSr8saxYoAMgJbQgPumocEkG
	 MiUjootCHhD1o4qA6ihoyFvI81jxay6BZT5loXc1ppdEedhTwf9W+NddyDPK7li88n
	 74crn+rdF8vmd/2GhMbiP04BoBLmPNrmVnd+EEb0=
Date: Fri, 24 May 2024 06:36:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: CVE-2023-52793: samples/bpf: syscall_tp_user: Fix array
 out-of-bound access
Message-ID: <2024052404-founding-motion-5e89@gregkh>
References: <7p643u2dcn6cen32dbtrcki62qrn3o2hyiplbx2hkpcojuiev5@3hbnkswhtha3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7p643u2dcn6cen32dbtrcki62qrn3o2hyiplbx2hkpcojuiev5@3hbnkswhtha3>

On Fri, May 24, 2024 at 11:58:54AM +0800, Shung-Hsi Yu wrote:
> On Tue, 21 May 2024 17:31:29 +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > samples/bpf: syscall_tp_user: Fix array out-of-bound access
> > 
> > Commit 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint
> > to syscall_tp sample") added two more eBPF programs to support the
> > openat2() syscall. However, it did not increase the size of the array
> > that holds the corresponding bpf_links. This leads to an out-of-bound
> > access on that array in the bpf_object__for_each_program loop and could
> > corrupt other variables on the stack. On our testing QEMU, it corrupts
> > the map1_fds array and causes the sample to fail:
> > 
> >   # ./syscall_tp
> >   prog #0: map ids 4 5
> >   verify map:4 val: 5
> >   map_lookup failed: Bad file descriptor
> > 
> > Dynamically allocate the array based on the number of programs reported
> > by libbpf to prevent similar inconsistencies in the future
> > 
> > The Linux kernel CVE team has assigned CVE-2023-52793 to this issue.
> 
> I would like to dispute this CVE.
> 
> Files in samples/bpf are meant to serve as an example and not code that
> are directly used at run-time, hence I believe this bug does not have
> security implication.

You are right, sorry about that, now rejected.  Thanks for the review!

greg k-h

