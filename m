Return-Path: <linux-kernel+bounces-344898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FAE98AF63
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DA1C2190C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478518734F;
	Mon, 30 Sep 2024 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPXRRFTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116041865EE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732838; cv=none; b=Mg+l/oLzm4VY0K/j7hBF974+OtFIpbNOi8hEh18A4zLPkswuFr5F0ISwA4RI9ORYpMD/P2iEyppZh/dnExkkpcfxGWkl0xYY4iBlD+7pTf6vhtBdQWsp1rhzxefJCBmsGKCg7bxEBQr2ncgXgx8byi4q/WQTrJ991tDm76ADYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732838; c=relaxed/simple;
	bh=5awKclN+R8JcBSYyMz49R133Ys96gvkpG+PfK9syjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvwZYF/WYwpFtg8R+vx0zZCWndgnS/IxrwCdmvtnNfvw67HOMxlz+1ri5FN2K5nqT6W0D0NbEvHG2iR8ruN9HbrixcHI9/PVNK54np6wyJhrAzfdrnYYCHPSAwlGC4BxCSzbe90+7JrAP6EqB6wvKO/LOY4KuVG3u7m+iU521gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPXRRFTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6DFC4CEC7;
	Mon, 30 Sep 2024 21:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732837;
	bh=5awKclN+R8JcBSYyMz49R133Ys96gvkpG+PfK9syjIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPXRRFThCEeoqToDHegTSbc1j08vufTOQJv3RTgNTmLpuOwajV83N2fj43ed4Y4zB
	 danLMeoQJ84PMvCDeNLVqMZ4oxufXcb8Cv+xxK2ulO1k7vrgkrrbYfSReK8U6x1kns
	 ajx36uK/my78d3/h5eZ+VnHHsfQxKE+KEadjk1qS7WM/xzzS0/RnV9tqxOdsvMSXIg
	 vdG2T7k3u7nNWrANGzsTFY6ofMcAZ08RvmgmKjaPZ6CwhtsoQnugBYCyqMMfoVEc9V
	 lzKvtwojZyc+my4AMkh8d397Fx0Rt8FatE3Lel3a8u5XVlz1m0aUmJXb9+gAhEC51Z
	 E+qMV+w+jZPDw==
Date: Mon, 30 Sep 2024 14:47:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, kan.liang@linux.intel.com,
	adrian.hunter@intel.com, peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] perf jevents: Don't stop at the first matched pmu when
 searching a events table
Message-ID: <ZvscZEx5lEl6M7S8@google.com>
References: <20240716132951.1748662-1-kan.liang@linux.intel.com>
 <CAP-5=fVZVU7kMOHz7CC7O1+2dX844dHqhqMebzEKWMA=59am-g@mail.gmail.com>
 <Zqo8kVXkN_UaTp6f@x1>
 <CAP-5=fX=QR66nQ6VKRMFfiFdueiC1EUGmxSbT9RCkW8dz67e6w@mail.gmail.com>
 <ZvsIgszeRrlWEUj8@google.com>
 <CAP-5=fXk8QJjP7iDsSrS5GZz-uHYheeLg2DHCWHjD5z+jZk+9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXk8QJjP7iDsSrS5GZz-uHYheeLg2DHCWHjD5z+jZk+9A@mail.gmail.com>

On Mon, Sep 30, 2024 at 01:30:03PM -0700, Ian Rogers wrote:
> On Mon, Sep 30, 2024 at 1:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I'm seeing this build failure after applying this.
> >
> >     TEST    pmu-events/empty-pmu-events.log
> >   --- pmu-events/empty-pmu-events.c     2024-09-26 10:27:15.600055460 -0700
> >   +++ pmu-events/test-empty-pmu-events.c        2024-09-30 13:20:34.631357001 -0700
> >   @@ -380,7 +380,7 @@
> >                            continue;
> >
> >                    ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
> >   -                if (pmu || ret)
> >   +                if (ret)
> >                            return ret;
> >            }
> >            return 0;
> >   make[3]: *** [pmu-events/Build:42: pmu-events/empty-pmu-events.log] Error 1
> >   make[3]: *** Deleting file 'pmu-events/empty-pmu-events.log'
> >   make[2]: *** [Makefile.perf:765: pmu-events/pmu-events-in.o] Error 2
> >   make[2]: *** Waiting for unfinished jobs....
> 
> Need to copy pmu-events/test-empty-pmu-events.c to
> pmu-events/empty-pmu-events.c, do you need the patch resent with this
> done?

Yes please!

Thanks
Namhyung


