Return-Path: <linux-kernel+bounces-187703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF38CD6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24625B21875
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81FA107B3;
	Thu, 23 May 2024 15:18:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE98E546
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477495; cv=none; b=dvNATPWEs3wP6DRJZdWjO4ftc/TnL6vzA2QC0mqCOAtWxccHQ0kVWgk8q8zuWcUpKE9HFzS6Q9KzPxDfwbDRYNbqqjjxDJZHzP/Do5/kSIpeXqtiTDZ/av4TaiowMCOb2t9GkAJRrk2P9aAjj3xFGWuPdzLbRWGknnqMKg0JbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477495; c=relaxed/simple;
	bh=EpKiSCqAgXtVBOjk3Q6o88eDYHlzv6Euu88zuoQhVxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXvwH/tNdXXiD2RQEcgDuUqKu8hGuhj1MRY/zzS+dLYk5zHJevOvZ0Ei07x67gU8dWtyJ11sjN1V6bNElLhrRIQI68+iuwao5GNVDQxzjH2kkqO8JAHzKMA3c9XZ/ywruuEU/+qiedfTx30rNszyqlocscSZTKugA36ozyZrAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1FA1339;
	Thu, 23 May 2024 08:18:36 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72F53F766;
	Thu, 23 May 2024 08:18:09 -0700 (PDT)
Date: Thu, 23 May 2024 16:18:07 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>, dfustini@baylibre.com,
	amitsinght@marvell.com, Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <Zk9eL6vbDvg/d+Ov@e133380.arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <b60aa6cc-7396-42c5-9a42-db8d6e8bfef6@intel.com>
 <ZkOAhH6tm1NXpre2@e133380.arm.com>
 <64113803-e4b8-49a2-a217-e1be790872fe@intel.com>
 <Zk9aUtGmeMN04+nD@e133380.arm.com>
 <8387d2d8-921a-4992-b622-15ddd89bf8d3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8387d2d8-921a-4992-b622-15ddd89bf8d3@redhat.com>

Hi David,

On Thu, May 23, 2024 at 05:07:50PM +0200, David Hildenbrand wrote:
> On 23.05.24 17:01, Dave Martin wrote:
> > Hi Reinette,
> > 
> > Apologies for the slow response...
> > 
> > On Tue, May 14, 2024 at 08:56:41AM -0700, Reinette Chatre wrote:
> > > Hi Dave,
> > > 
> > > On 5/14/2024 8:17 AM, Dave Martin wrote:
> > > > On Wed, May 08, 2024 at 08:41:37AM -0700, Reinette Chatre wrote:
> > > > > On 4/26/2024 8:05 AM, Dave Martin wrote:
> > > > > > This is a respin of the resctrl refactoring series described below,
> > > > > > addressing review feedback.  Many thanks to those to responded with
> > > > > > feedback on the v1 series [2].
> > > > > > 
> > > > > > See Notes and FYIs in the individual patches for details on the changes
> > > > > > and outstanding issues.
> > > > > 
> > > > > What are your expectations regarding this series while considering [1] and [2]?
> > > > > 
> > > > > Reinette
> > > > > 
> > > > > [1] https://lore.kernel.org/lkml/ZiE8%2foXyjBef2qTy@e133380.arm.com/
> > > > > [2] https://lore.kernel.org/lkml/acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com/
> > > > > 
> > > > 
> > > > I plan to propose a reworked version of the fflags and string parser
> > > > stuff, and take a look at the other more minor outstanding issues.
> > > > 
> > > > The series does need rebasing, but otherwise I don't anticipate much
> > > > change to the code from the Arm side unless there are further review
> > > > comments.
> > > > 
> > > > Do you have a preference on how this series should proceed?
> > > 
> > > I believe that I already answered this question in [2], hence my confusion
> > > about this posting.
> > > 
> > > Reinette
> > 
> > I guess James and I need to tidy up the loose ends and repost this.
> > 
> > I'm hoping we can get a v3 out over the next few weeks or so.
> 
> Finally having more time to review this (I hope ...) does it make sense to
> review this v2 or wait for v3?

It's up to you.  All review is appreciated, but v2 mostly dealt with
minor cosmetic cleanups, and as Reinette highlights, there are few
more significant changes pending.

So, it may be a better use of your time if you wait for v3 and review
it then.

Cheers
---Dave

