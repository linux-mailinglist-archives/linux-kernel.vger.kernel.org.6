Return-Path: <linux-kernel+bounces-190012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF3A8CF85A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BDDB222F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A128C07;
	Mon, 27 May 2024 04:20:00 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91291A2C12
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716783600; cv=none; b=rsBs6jE/nP+wl6H01UJTyUWk0/RXZcFbKut9k8aU6b8oqybaPzn2p8ijpsNWQ96i3OxiTVcmaUyNNP3zQIqrX13SdisrCsmVNCC3PUpRhES4aPa+8k2agTbihdbFnD1kYoYJNCemMNrAy+50u1zjlddR8bfSn2jaLb74V8h2+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716783600; c=relaxed/simple;
	bh=ZI8PV6mwyIHUaMt/6WGJDqJQdM17D09hGgluXdd8v60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkCm3LEClBSLU5wcO5XQVL9GOc70XZSHrL+wTJozjrtpC3FvpFmyTCdYh8N/X+95X1e1EP0XsRKkDT2l/Zv/im0QAOYLRkjsbugWzuxempFD4rmE7HCuilGviQMJsjqEtlASRR6nsCroWhBbxq9XmvQrvWp8JTs353HU1I+h/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7a-665409e87671
Date: Mon, 27 May 2024 13:19:46 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240527041946.GC12937@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
 <20240527034614.GA12937@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527034614.GA12937@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnoe4LzpA0g3uzhSzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkAviiuGxSUnMyy1KL
	9O0SuDKWrn3HVPCZu2LJsxfsDYzzOLsYOTkkBEwkPl+4zgpjX1j6n7mLkYODRUBVYv5UsDCb
	gLrEjRs/mUFsESD71Mrl7F2MXBzMAv+ZJO4/bAVLCAuESEz7sIYJxOYVsJDYde8PI0iRkMBP
	RomWnf+hEoISJ2c+YQGxmQW0JG78e8kEsoxZQFpi+T8OkDCngKXE97vnwEpEBZQlDmw7zgQy
	R0JgE7tE87SPLBCHSkocXHGDZQKjwCwkY2chGTsLYewCRuZVjEKZeWW5iZk5JnoZlXmZFXrJ
	+bmbGIExuaz2T/QOxk8Xgg8xCnAwKvHwZrgHpwmxJpYVV+YeYpTgYFYS4RWZF5gmxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgdFgyW/+yyUx9rMSpEO/
	CJdJrDf9ky3xKaStYLfelPhOV5X9E++//zexmu+HKu+D+27PNNvjbxWdU+z7eGpxo4zAhnvn
	Pykmn2I0F+ZZKBwuMeFPEusVPd9te9rZ3lucvsdU6S/qm7zAfsV1du2b6QtPBlbtXy6yZ/Hu
	p3JfnBdwP/E58OhGtZMSS3FGoqEWc1FxIgAvh4ywxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrPuCMyTN4Hs7o8Wc9WvYLD5v+Mdm
	8enlA0aLFxuAYl/X/2K2ePqpj8Xi8NyTrBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovj
	vQeYLObf+8xmsXnTVGaL41OmMlr8/gFUfHLWZBYHIY/vrX0sHjtn3WX3WLCp1GPzCi2PxXte
	MnlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5LH7xgclj6y87j8ap19g8Pm+SC+CP
	4rJJSc3JLEst0rdL4MpYuvYdU8Fn7oolz16wNzDO4+xi5OSQEDCRuLD0P3MXIwcHi4CqxPyp
	rCBhNgF1iRs3fjKD2CJA9qmVy9m7GLk4mAX+M0ncf9gKlhAWCJGY9mENE4jNK2AhseveH0aQ
	IiGBn4wSLTv/QyUEJU7OfMICYjMLaEnc+PeSCWQZs4C0xPJ/HCBhTgFLie93z4GViAooSxzY
	dpxpAiPvLCTds5B0z0LoXsDIvIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwwpbV/pm4g/HL
	ZfdDjAIcjEo8vBnuwWlCrIllxZW5hxglOJiVRHhF5gWmCfGmJFZWpRblxxeV5qQWH2KU5mBR
	Euf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTDeky2TEKx0KFn54mnh2b8HLDwPe3ybxr5E/Nn7
	pny58kcBh8yCYyZJtaz7W2jF/1yU2f7Hv+93LWV0Wtb9sl4fpMa9K26P6urz7r66jUdX2ZV1
	xd5fV1ttUP8+0SQgRrXrjr/ZiYB6Ha6C55uq9qk5OipwWu0wsBBapnUvNfFC7K8L84PNdZRY
	ijMSDbWYi4oTAQI10hSsAgAA
X-CFilter-Loop: Reflected

On Mon, May 27, 2024 at 12:46:14PM +0900, Byungchul Park wrote:
> On Sun, May 26, 2024 at 07:43:10PM -0700, Dave Hansen wrote:
> > On 5/26/24 18:57, Byungchul Park wrote:
> > ...
> > > Plus, I will add another give-up at code changing the permission of vma
> > > to writable.
> > 
> > I suspect you have a much more general problem on your hands. Just
> > tweaking the VFS or mmap() code likely isn't going to cut it.

What a stupid idiot I am.

I already discuss the exact cases with Nadav Amit at the very beginning
around v1.  I didn't remember it when I was answering to you.

mmap() or changing the permission by user already performs TLB flush
needed within that code, which LUF never touch.

Worth noting currently LUF touchs only unmapping during migration or
reclaim.  Other updating mapping would perform TLB flush it needs, as is.
I guess updating page cache is also already perform TLB flush needed.
I need to check it.  Probably, it would already do.

	Byungchul

> LUF is interested in limited folios that are migratable or reclaimable
> in lru for now.  So, IMHO, fixing a few things is going to cut it.
> 
> > I guess we'll see what you come up with next, but this email was really
> > just the result of Vlastimil and I chatting on IRC for five minutes
> > about this set.
> > 
> > It has absolutely not been tested nor reviewed enough.  <fud>I hope the
> > performance gains stick around once more of the bugs are gone.</fud>
> 
> Sure. It should be.
> 
> 	Byungchul

