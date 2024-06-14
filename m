Return-Path: <linux-kernel+bounces-214205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73B5908130
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5602CB227B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F20D1822F8;
	Fri, 14 Jun 2024 01:58:05 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CD119D88A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718330284; cv=none; b=qZB5QieK0X81VRBe9gcnHiGRPU9x1RaLtrOzzdHRVToJBxXWHzqkoRi6bCLHoQ2k1QWg70dTf5qqnNRdlhGHdZH2ajK7rQ2RuehQYILVG/T//Uudq9wJ4p5AG3qh3VjEETkoPrk2lsSXFy2ssbwx4jWqAfwqDEPmMQA8cIkx6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718330284; c=relaxed/simple;
	bh=pNaP2i0RLq43N9o02Bf3GwmGTBO2FK7tqatydjNoddc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA9V4F1pGLJfclTqpbBtBhboSmeKs/enAE8YTsmGxIrT0ksQW6Xz5eLuRNpRjUkMCKrbJke+e6Xqmlw3y8eEn+hsJ0lhj3mdVJx+cDC2sCxG9mEllhHxOFJpLkAvDew3AzwWnMbU7PPG6uh57ob9umkw+JbrLWOdzHwpiGmqgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-de-666ba39e165c
Date: Fri, 14 Jun 2024 10:57:45 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <20240614015745.GA47085@system.software.com>
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <20240604015348.GB26609@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604015348.GB26609@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsXC9ZZnoe68xdlpBod6zC3mrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aLo52bmC3O71rLarFj6T4mi0sHFjBZ
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPrLzuPxqnX2Dw+b5IL4IvisklJ
	zcksSy3St0vgyjjTe5Sx4LpMxfuVPxgbGD+LdjFyckgImEicO9HFCmP/WzCHBcRmEVCVWLhm
	P1icTUBd4saNn8wgtgiQfWrlcvYuRi4OZoHjzBIfPi5iBEkICxRIvJowiR3E5hWwkGh6+p8Z
	pEhI4AqzxNHJX5khEoISJ2c+AdvALKAlcePfS6YuRg4gW1pi+T8OkDCngKXEy4YvbCC2qICy
	xIFtx5kgjtvHLvHheiqELSlxcMUNlgmMArOQTJ2FZOoshKkLGJlXMQpl5pXlJmbmmOhlVOZl
	Vugl5+duYgRG57LaP9E7GD9dCD7EKMDBqMTD6/EsK02INbGsuDL3EKMEB7OSCO+shUAh3pTE
	yqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjJLedltKmNo093Nr
	aebqbmwzf/hQq7Qzcv/SkvTtgb7uNk+5V9z2lev51GL99/NHliSLT/w7JjcsrLYXffLr4I5r
	ih1zO600NwoqrzrqwaVWvfl0xqqmeO2bqkYhaTyP/iqsuJ/W4XeeRXB3t53hL72erMwnbZtS
	f/pwWyUkPWvKCZ6Rd1BTiaU4I9FQi7moOBEAYeRamsoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXC5WfdrDtvcXaawa6XShZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFofnnmS1uLxrDpvFvTX/WS2Odm5itji/ay2rxY6l+5gs
	Lh1YwGRxvPcAk8X8e5/ZLDZvmspscXzKVEaL3z+AOk7OmsziIOzxvbWPxWPnrLvsHgs2lXps
	XqHlsXjPSyaPTas62Tw2fZrE7vHu3Dl2jxMzfrN4zDsZ6PF+31U2j8UvPjB5bP1l59E49Rqb
	x+dNcgH8UVw2Kak5mWWpRfp2CVwZZ3qPMhZcl6l4v/IHYwPjZ9EuRk4OCQETiX8L5rCA2CwC
	qhIL1+xnBbHZBNQlbtz4yQxiiwDZp1YuZ+9i5OJgFjjOLPHh4yJGkISwQIHEqwmT2EFsXgEL
	iaan/5lBioQErjBLHJ38lRkiIShxcuYTsA3MAloSN/69ZOpi5ACypSWW/+MACXMKWEq8bPjC
	BmKLCihLHNh2nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDa
	ltX+mbiD8ctl90OMAhyMSjy8Hs+y0oRYE8uKK3MPMUpwMCuJ8M5aCBTiTUmsrEotyo8vKs1J
	LT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpg5LP9ET7JPF1Pm039TsFNgcC6Xd6m
	mw60Wj3bePuBk9wejwguqxUqh8+nc7tfuLqyb+M843lrq16deidgdvEvI5ee5P+8n4E8lix6
	gXeOu0oJiG+bI3JSNffezxoWTg32Ntu2q7P550hKqpqExVxVr1jbfvUvE/N9tyLtaaZfmZWE
	d9Qq6CxWYinOSDTUYi4qTgQA7zbYpLICAAA=
X-CFilter-Loop: Reflected

On Tue, Jun 04, 2024 at 10:53:48AM +0900, Byungchul Park wrote:
> On Mon, Jun 03, 2024 at 06:23:46AM -0700, Dave Hansen wrote:
> > On 6/3/24 02:35, Byungchul Park wrote:
> > ...> In luf's point of view, the points where the deferred flush should be
> > > performed are simply:
> > > 
> > > 	1. when changing the vma maps, that might be luf'ed.
> > > 	2. when updating data of the pages, that might be luf'ed.
> > 
> > It's simple, but the devil is in the details as always.
> 
> Agree with that.
> 
> > > All we need to do is to indentify the points:
> > > 
> > > 	1. when changing the vma maps, that might be luf'ed.
> > > 
> > > 	   a) mmap and munmap e.i. fault handler or unmap_region().
> > > 	   b) permission to writable e.i. mprotect or fault handler.
> > > 	   c) what I'm missing.
> > 
> > I'd say it even more generally: anything that installs a PTE which is
> > inconsistent with the original PTE.  That, of course, includes writes.
> > But it also includes crazy things that we do like uprobes.  Take a look
> > at __replace_page().
> > 
> > I think the page_vma_mapped_walk() checks plus the ptl keep LUF at bay
> > there.  But it needs some really thorough review.
> > 
> > But the bigger concern is that, if there was a problem, I can't think of
> > a systematic way to find it.
> > 
> > > 	2. when updating data of the pages, that might be luf'ed.
> > > 
> > > 	   a) updating files through vfs e.g. file_end_write().
> > > 	   b) updating files through writable maps e.i. 1-a) or 1-b).
> > > 	   c) what I'm missing.
> > 
> > Filesystems or block devices that change content without a "write" from
> > the local system.  Network filesystems and block devices come to mind.
> 
> AFAIK, every network filesystem eventully "updates" its connected local
> filesystem.  It could be still handled at the point where updating the
> local file system.

To cover client of network file systems and any using page cache, struct
address_space_operations's write_end() call sites seem to be the best
place to handle that.  At the same time, of course, I should limit the
target of luf to 'folio_mapping(folio) != NULL' for file pages.

	Byungchul

> > I honestly don't know what all the rules are around these, but they
> > could certainly be troublesome.
> > 
> > There appear to be some interactions for NFS between file locking and
> > page cache flushing.
> > 
> > But, stepping back ...
> > 
> > I'd honestly be a lot more comfortable if there was even a debugging LUF
> 
> I'd better provide a method for better debugging.  Lemme know whatever
> it is we need.
> 
> > mode that enforced a rule that said:
> 
> Why "debugging mode"?  The following rules should be enforced always.
> 
> >   1. A LUF'd PTE can't be rewritten until after a luf_flush() occurs
> 
> "luf_flush() should be followed when.." is more correct because
> "luf_flush() -> another luf -> the pte gets rewritten" can happen.  So
> it should be "the pte gets rewritten -> another luf by any chance ->
> luf_flush()", that is still safe.
> 
> >   2. A LUF'd page's position in the page cache can't be replaced until
> >      after a luf_flush()
> 
> "luf_flush() should be followed when.." is more correct too.
> 
> These two rules are exactly same as what I described but more specific.
> I like your way to describe the rules.
> 
> 	Byungchul
> 
> > or *some* other independent set of rules that can tell us when something
> > goes wrong.  That uprobes code, for instance, seems like it will work.
> > But I can also imagine writing it ten other ways where it would break
> > when combined with LUF.

