Return-Path: <linux-kernel+bounces-216005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251239099D8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF07F1F21FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0856470;
	Sat, 15 Jun 2024 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="dsPIZ/Mh"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACF4C62A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482739; cv=none; b=aJqSlXRqvggl9xIcaf4P1lh+663PXlt29xPknUsYlZqrL7ZgfpksG5713NKncjvd58m4/6hURAkohv0Yea2P4wLTSYi9BO4P4jxSuB9rEWSI9sXnJcIXgfuEPdYVx8itepPKoB/5S5bhfO6wFrsYN8L13nZOj8/l3Qb8GyJcca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482739; c=relaxed/simple;
	bh=VWcfEiBlDIo8t3b8V4pHvWJXgkHgEu1ID36AGj5Fmio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfT4NMJm0tzAhbMzxgdPhGTUUEsrFH9aZnJt/MWuwz/LiDJ8kBnEA1Ohfh68iF0ERRMnv3R/bRR4G7QElvR1jJja5TxAdGfGj6EO5vV81wkuyZ/N/LHcTJqN4NgvX0HxSb6jzo1I5JHPdgr1z8Fz5tXwmQ6Vri7SVPIwot3dPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=dsPIZ/Mh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1718482728; bh=VWcfEiBlDIo8t3b8V4pHvWJXgkHgEu1ID36AGj5Fmio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsPIZ/MhN5ZXM8F6CG2s99fRBqJY4dmDCbt21kt2Urncvwu5FmeBHWSpoxaycESw+
	 THm5RlIAfTHf92ti4WrMRcxrRFeFsKJW+wJU0t/VWBlbV5oPgpm0j3VRbPL1KLNYDE
	 PntoDWz8Hl3LeGGHY2mQ31EzwNEEXLVNcSKA9W0E=
Date: Sat, 15 Jun 2024 22:18:48 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <dd22004b-9bed-4537-b7d5-bc218ffc0087@t-8ch.de>
References: <CGME20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2@eucas1p1.samsung.com>
 <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
 <20240607094053.x3cmkhmrgaw6jqd3@joelS2.panther.com>
 <37d5fd30-9327-4b57-8e4d-22af929d3fc4@t-8ch.de>
 <20240610081036.bugf62o3y2wh2ugu@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610081036.bugf62o3y2wh2ugu@joelS2.panther.com>

On 2024-06-10 10:10:36+0000, Joel Granados wrote:
> On Fri, Jun 07, 2024 at 03:54:01PM +0200, Thomas Weißschuh wrote:
> > On 2024-06-07 11:40:53+0000, Joel Granados wrote:
> > > On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> ...
> > > Is there anything left to do besides
> > > what is being discussed in this mail, to start changing the ctl_tables
> > > to `static const`?
> > 
> > The changes to the tables also need (as per [0] and [1]):
> > 
> > * sysctl: move internal interfaces to const struct ctl_table
> > * sysctl: allow registration of const struct ctl_table
> > 
> > I think we do the handlers for v6.11, the rest of [0] and [1] for v6.12
> > and then we can go through the rest of the trees ctl_tables.
> 
> LGTM. Once you send "sysctl: move internal interfaces to const struct ctl_table" and
> "sysctl: allow registration of const struct ctl_table", I'll put them
> into sysctl-testing and have them there until they can go into sysctl-next
> (after the end of the next merge window). Please send both of them in one
> series and remember to work on the "what" and the "why" for the commit
> messages and cover letter.

IMO all of the remaining commits can go in as one series, as they all
belong to the sysctl core
(I can leave out "sysctl: constify standard sysctl tables")

FYI recent changes to the sysctl core introduced another prerequisite
for "sysctl: move internal interfaces to const struct ctl_table", which
is "bpf: Constify ctl_table argument of filter function".

See https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/ sysctl-constfy


Thomas

