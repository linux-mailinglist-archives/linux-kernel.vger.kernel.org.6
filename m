Return-Path: <linux-kernel+bounces-281775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE3594DB2F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAF21C211A6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9381482E8;
	Sat, 10 Aug 2024 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="boIx7JIi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8D17552
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723273446; cv=none; b=M3BrUk9UodfnvUjm2ftJk283WkPUDr4tQCVdV5DdMRDMKVHP7f8BtS0HWObMKRIwk0i/0/YT1I5wpFzgXFc7P+lC5WO+rkc9Qiy+mVqyl5GDl8XmGyAUJOj80d9yJeUizaeRMu1LsN7XtnNLWyff2/3aULfRtA02vNdqAmhOjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723273446; c=relaxed/simple;
	bh=BX2RRXvGlkFKhS4XY9fYvxr6MZbwf9hH+dvqv87yCs8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yr+OUBGDiMcw/hJA/BO45whKuKxHE5XEsG5HNgaJ9juLX0KhH6IHhsgdX4jskizD85A2z5Lq+Aa9/4ek09KMDqk3wNGvWPtn73sOb4/fn19YflOEo6ohUxSPRZ3SrjeSXkhQQwV5Juov9fadQC9/BMZ2yOAdPvc+GoE3StAwTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=boIx7JIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D772C32781;
	Sat, 10 Aug 2024 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723273445;
	bh=BX2RRXvGlkFKhS4XY9fYvxr6MZbwf9hH+dvqv87yCs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=boIx7JIi/GUawe8x0a3lPWZv5p3X0T1mqYUkK+sD5eAJsAUTY6a5u2dyUHS5ltBA6
	 bk3Mi3bvU14Sgp16HgF3Q8msLcJzWatN+PM5yBkdapPD2FvzWBPKYSI/uncO9OAZeV
	 39Bu6hJryH4Ks9KYk3jVAi9bAyqws/QgbUBgkB0A=
Date: Sat, 10 Aug 2024 00:04:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-Id: <20240810000404.b08cb06ebbba7e0de9bb8c72@linux-foundation.org>
In-Reply-To: <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
	<20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
	<20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 21:57:50 -0700 Saurabh Singh Sengar <ssengar@linux.microsoft.com> wrote:

> > > No NUMA = 1024*2*1*512  =   1,048,576 : Here refresh_zone_stat_thresholds
> > > takes around 224 ms total for all the CPUs in the system under test.
> > > 16 NUMA = 1024*2*16*512 =  16,777,216 : Here refresh_zone_stat_thresholds
> > > takes around 4.5 seconds total for all the CPUs in the system under test.
> > 
> > Did you measure the overall before-and-after times?  IOW, how much of
> > that 4.5s do we reclaim?
> 
> This entire gain is accounted in over all boot processi time. Most of the Linux
> kernel boot process is sequential and doesn't take advantage of SMP.

Again, if you were able to measure 4.5s without the patch then you are
able to measure how long this delay is with the patch.  Please share
that number.

