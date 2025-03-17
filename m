Return-Path: <linux-kernel+bounces-563349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1021FA63F25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FCB188F273
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14351A5BAE;
	Mon, 17 Mar 2025 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MRF/u1bN"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B37A59
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188118; cv=none; b=mu/LCK4lGkwO46f3PrEJWoMti+bfwob1HgVYDf0wBIXgDDYmMtO8F4+pcAlqH6H8uYWjhfZcwUH6mgK84Q0iAWz8AHN1el4QrTJVLTJJicw294Dm7Dz51bGwBvFC41mCOpmj20Gs9Fv1Ikh62LoUFZok9L6RdCRo0rVhGb7Z29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188118; c=relaxed/simple;
	bh=hVTA7WFaqSUZtlNO94DKKxeDg8SXYxjG0SuiM6iBQxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=KJgNMCIWOzHH0C87TW8vK5j040H2GOERspTjMe3Z086oOZB+ZlgYZ9MPIP372s9VoP+Ut8nTxNwxkPLq989HUYfogDnC8cpomFORCkAJY9VWy2Ju9Ws6wqqE1REsFsNyva8ejkYwmtkE9LQT99utP+AqgWFobypKpEBwfrfvYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MRF/u1bN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250317050834epoutp03c633e781c8fbe4b4f50ab96f4a083e04~tftwh4qLe1041410414epoutp03k
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:08:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250317050834epoutp03c633e781c8fbe4b4f50ab96f4a083e04~tftwh4qLe1041410414epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742188114;
	bh=Hmy5juUenDaDV5+L0wwlN3begvmAG+WKNly9cg/PxMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MRF/u1bNaOQvy1CBly7F/5Qk8lb6RZga7kge//dTwgZaA0jimB/vyLUDXcuq2bAKo
	 Dv4X53GiWbjV54uNUemWR6hEz+8L+dvdDHknI2ycCxDusq4RkuOPtQa/iQZpLUXk5k
	 kU1fyhi01eUSa1b5DaC9I15JjpIgvYtOkcCuCrxM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250317050833epcas2p4579d19cc5c0598a5cc34ad536e1639fd~tftvqMZpO2652626526epcas2p4b;
	Mon, 17 Mar 2025 05:08:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZGNKX6sNyz4x9QF; Mon, 17 Mar
	2025 05:08:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	E4.5D.22105.05EA7D76; Mon, 17 Mar 2025 14:08:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250317050832epcas2p4767823247bba56b2cd36571bc2963582~tftuT7z3m2422824228epcas2p49;
	Mon, 17 Mar 2025 05:08:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250317050832epsmtrp131749a3fe9baac09db07c47ff2468e11~tftuOc6Ps0499304993epsmtrp1C;
	Mon, 17 Mar 2025 05:08:32 +0000 (GMT)
X-AuditID: b6c32a47-fd1c970000005659-91-67d7ae503e48
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.D1.33707.05EA7D76; Mon, 17 Mar 2025 14:08:32 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250317050832epsmtip1780100868c82b12293720ec4052d223a~tftuBgTny2878228782epsmtip1a;
	Mon, 17 Mar 2025 05:08:32 +0000 (GMT)
Date: Mon, 17 Mar 2025 14:06:57 +0900
From: Donghyeok Choe <d7271.choe@samsung.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org, takakura@valinux.co.jp,
	youngmin.nam@samsung.com, hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com, d7271.choe@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
Message-ID: <20250317050657.GA693154@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8cLEkqLL2IOyNIj@pathway>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmqW7AuuvpBj8/mlhc2zuR3aJp/yVm
	i0fT17JabLsyn9Hi8q45bBb/H39ltdjX8YDJYvfGRWwWR289ZbeYtK+RyWLxgU/sDtwesxsu
	sni07LvF7vHu3Dl2j74tqxg91m+5yuLxado0do/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2V
	vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
	5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGds2DyDteCfQMW9h2kNjPt5uxg5
	OCQETCQWtFR2MXJxCAnsYJR41TGdsYuRE8j5xCjRc84TIgFktz74ywrT8GBzMkR8J6PEp9PX
	mCCcp4wSBz9tZwHpZhFQlWjqPAQ2iU1AV2JS5zY2EFtEQEni1fy7zCANzAItTBJXXnwGSwgL
	REnc+/qFFcTmBWpoO7iDCcIWlDg58wnYUE4BdYk3x3+AbZMQmMshce7Ca7BmCQEXiX2HvzBC
	2MISr45vYYewpSRe9rexQzQ0M0pMuvEaqnsGo8SVyZ+ZIKqMJWY9awfrZhbIkLj08zoTxKPK
	EkdusUCE+SQ6Dv9lhwjzSnS0CUF0qkic73vACLNrw9y3UBM9JOa/2gcNlqtMEv3LZ7FMYJSb
	heShWUi2Qdg6Egt2f2KbBbSCWUBaYvk/DghTU2L9Lv0FjKyrGMVSC4pz01OLjQqM4RGcnJ+7
	iRGcZrXcdzDOePtB7xAjEwfjIUYJDmYlEd7+RdfThXhTEiurUovy44tKc1KLDzGaAqNnIrOU
	aHI+MNHnlcQbmlgamJiZGZobmRqYK4nzVu9oSRcSSE8sSc1OTS1ILYLpY+LglGpg6pKz0rrr
	eqB85utzy/X2HNn0K/2b3wvvdg6vpXP5C/6uFeYqLdLRltKYmlAgKhV0f13s94KbhzO2mcpt
	75gdWbSnrHjpBM1Fbr4NtxomeFQnfTEOcWzVKRAUDtH6vVSRb8buadkrth+9N33n5XdMytPT
	S7QYbmddyPy10Uba8Zjsxzd/1QRjOV6LnSlq0jWK0NK9dcR1m/Wn90wSBYLR/3IrApzNBbR4
	v1tyfpJcffG/sq6C94XSdOErF3e/n3e/bPa/eU0H0n5uPye2XNbx/HltxvDlhowPy6Kqokzk
	pX+t8PC/Y3SGxafYyq9RYfkpx41SZ3m5Z2haWIsfVZS6e2Lu7jnPQ7XYe39FNwcrsRRnJBpq
	MRcVJwIASfxJOjwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnG7AuuvpBnPP8Vpc2zuR3aJp/yVm
	i0fT17JabLsyn9Hi8q45bBb/H39ltdjX8YDJYvfGRWwWR289ZbeYtK+RyWLxgU/sDtwesxsu
	sni07LvF7vHu3Dl2j74tqxg91m+5yuLxado0do/Pm+QC2KO4bFJSczLLUov07RK4Mp6d7mYv
	2MdX0XH9F3MD4wzuLkYODgkBE4kHm5O7GLk4hAS2M0osmvyKrYuREyguJdG+ZSYThC0scb/l
	CCtE0WNGidd7m9lBEiwCqhJNnYcYQWw2AV2JSZ3bwJpFBJQkXs2/ywzSwCzQxiRxfOZNVpCE
	sECUxL2vX8BsXqCGtoM7mCCm3maSmPqxkQkiIShxcuYTFhCbWUBL4sa/l0wgpzILSEss/8cB
	EuYUUJd4c/wH0wRGgVlIOmYh6ZiF0LGAkXkVo2hqQXFuem5ygaFecWJucWleul5yfu4mRnCE
	aAXtYFy2/q/eIUYmDsZDjBIczEoivP2LrqcL8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwR
	EkhPLEnNTk0tSC2CyTJxcEo1MPX0rcr2O6y2uKN0uWqFiLXkJJG1rnnrb/F48q/7JKF0Zhqb
	g/7RTzEx6XNY3Zceqs/YOPFl0P9HHadvR0hOyF+T/Mrov+5PHaHcU9IL98q9WnvMZlZG9/I9
	TfxL6uRKzWdNOvnwlu7FUzZbetzzGIset/xg2jb9ZUtXZWTHzWK5g39aD5y//doxPKV/4+E1
	HIfT6/fm1rK7Lzyi/YPpj4mqtY/Wdt2JRqmX8mZsLygJXXGnIGtr8/SJId93/zvsrnJFJ6Go
	veOzQm6k94qy32cda3dMObrcuE3PZ97P0zrVhTcjy5x/h/UpWm2cL/vzMLvqw+AdCyfUFQh9
	vKf76sC2ORMieoKXtR6YJ2W/O0+JpTgj0VCLuag4EQAtoZta/wIAAA==
X-CMS-MailID: 20250317050832epcas2p4767823247bba56b2cd36571bc2963582
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_22279_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
	<20250226031628.GB592457@tiffany> <84ikoxxrfy.fsf@jogness.linutronix.de>
	<Z78eGNIuG_-CVOGl@pathway.suse.cz> <8434fytakt.fsf@jogness.linutronix.de>
	<Z8b-ljGnw57GpJb0@pathway> <84ikoorj53.fsf@jogness.linutronix.de>
	<Z8cLEkqLL2IOyNIj@pathway>

------K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_22279_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 04, 2025 at 03:15:46PM +0100, Petr Mladek wrote:
> On Tue 2025-03-04 15:05:52, John Ogness wrote:
> > On 2025-03-04, Petr Mladek <pmladek@suse.com> wrote:
> > > I mean something like:
> > >
> > > --- a/kernel/printk/printk_ringbuffer.c
> > > +++ b/kernel/printk/printk_ringbuffer.c
> > > @@ -2143,7 +2143,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
> > >  			 * But it would have the sequence number returned
> > >  			 * by "prb_next_reserve_seq() - 1".
> > >  			 */
> > > -			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
> > > +			if (this_cpu_in_panic() &&
> > > +			    (!printk_debug_non_panic_cpus || legacy_allow_panic_sync) &&
> > > +			    ((*seq + 1) < prb_next_reserve_seq(rb)))
> > >  				(*seq)++;
> > >  			else
> > >  				return false;
> > 
> > Ah, OK. Thanks for the clarification
> > 
> > > OK, I propose the following changes:
> > >
> > >   + rename the option to "printk_debug_non_panic_cpus"
> > >
> > >   + do not skip the messages in _prb_read_valid() when this option
> > >     is used before the non-panic CPUs are stopped.
> > 
> > And of course:
> > 
> >     + allow non-panic CPUs in panic to store messages when this option
> >       is set
> > I would also keep the dump_stack_lvl() implementation as it is, even if
> > it could lead to interweaving of backtraces. Anyone using
> > printk_debug_non_panic_cpus should have CONFIG_PRINTK_CALLER enabled.


Hi Petr Mladek,

This is gentle remind.

I did upload the patch containing the above contents.
Link: https://lore.kernel.org/all/20250305044046.1249972-1-d7271.choe@samsung.com/

Even if it's not necessarily this patch, I hope the content will be applied.
When can the 'printk_debug_non_panic_cpus' function be reflected
in mainline source code?


Thanks.

------K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_22279_
Content-Type: text/plain; charset="utf-8"


------K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_22279_--

