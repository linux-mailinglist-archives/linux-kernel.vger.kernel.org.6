Return-Path: <linux-kernel+bounces-426076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805579DEE87
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB8161B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811D80027;
	Sat, 30 Nov 2024 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mIw2mvKN"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BD481AF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931727; cv=none; b=QMyvYLpbC0iabdNwxd65/G5NqcwGw19Fr79am5KzkunDwUlIC26xfD5ziKfgk4WlrAqsHWX/03Y0EAjtrjAxUsTL/LAEbyq5Z/A+m5QC24hH9zAmSaOHBzXCl4okNUDlBTyeCbTJQNjwE1J5ND2BgNgsgHmBUFDTXj6lLCeRVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931727; c=relaxed/simple;
	bh=GrvzTqeYQLPNK+Z2wv5/MBmBV0QrYdTY7w/CKHyoEag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snGUzTBdg18f/uyjSK92+hCZNXiwu+xSXkmmenHHUhMxFPDbAsF//qD23hGlihuVSIqfdrRVXY9/h9UuxtC1YNgHHe8DQ//7rfAPFDueoZZzvUgLiKXL3zZVGjgfr0r2E2XzEPrRcrFrA1Geo1OogezoZxIrqjW7kGTkC+n79Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mIw2mvKN; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (host250.triadfluidpower.com [63.82.152.250] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AU1tCK8016417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 20:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732931717; bh=bXFZIDG+GlnNgCxWwEIR9/ro6motJnoWrG5gpvavL6g=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mIw2mvKNtzlD62IO4qKkzfgUrtkpRVqImDDMNgto6xi/pNEOT0GcZmFOHG0rpFIlg
	 j4UogQYtMv8ssOUSHL/uPuIWvGKjMRloROMg06ZS/upPqsy7vb8BYMIJHivwJCZB1L
	 09efyWcYz5KA1naEOe7Lr862my7oQpu6taM7vIFgK75NgkiMbuezdewItCQ0lF3ftb
	 fQYKk4OrTRsA+wAkC2+9aDr1HmsGSQaBBProo/1mv+2Cvc61o8clZv7Bvo/7gTr/3S
	 FKvcOfkVPngjeW501udJmh3IsP9PVSMGQKp6n0oJBw4dQHbhcHjY5yG1nQdMxIFg55
	 U0KykFGKIoOdw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 780AC3417DE; Fri, 29 Nov 2024 08:12:44 -1000 (HST)
Date: Fri, 29 Nov 2024 08:12:44 -1000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Niklas =?iso-8859-1?Q?Hamb=FCchen?= <mail@nh2.me>
Cc: Rui Ueyama <rui314@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Wislist for Linux from the mold linker's POV
Message-ID: <20241129181244.GA11702@mit.edu>
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
 <87ttbrs1c5.fsf@mid.deneb.enyo.de>
 <CACKH++br0qCHhxsy1kuyK29OB_bgME3FUXA_XepRL=7FYXOvQA@mail.gmail.com>
 <2c33be3f-8c41-48f1-a6ad-b4ea00ec515f@nh2.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c33be3f-8c41-48f1-a6ad-b4ea00ec515f@nh2.me>

On Fri, Nov 29, 2024 at 06:38:47AM +0100, Niklas Hambüchen wrote:
> Turns out, `ext4` has built in a feature to work around bad applications forgetting `fsync()`:
> 
> `close()`ing new files is fast.
> But if you `close()` existing files after writing them from scratch, or atomic-rename something replacing them, ext4 will insert an `fsync()`!

It's not actually an fsync() in the close case).  We initiate
writeback, but we don't actually wait for the writes to complete on
the close().  In the case of rename(), we do wait for the writes to
complete before the file system transaction which commits the
rename(2) is allowed to complete.  But in the case where the
application programmer is too lazy to call fsync(2), the delayed
completion of the transaction complete is the implicit commit, and
nothing is bloced behind it.  (See below for more details.)

But yes, the reason behind this is applications such as tuxracer
writing the top-ten score file, and then shutting down OpenGL, and the
out-of-tree nvidia driver would sometimes^H^H^H^H^H^H^H^H^H always
crash leave a corrupted or missing top-ten score file, and this
resulted in a bunch of users whinging.

Also at one poiont, both the KDE and Gnome text editors also did the
open with O_TRUNC and rewrite, because it was the simplest way to
avoid losing the extended attrbutes (otherwise the application
programmers would have to actually copy the extended attriburtes, and
That Was Too Hard).  I don't know why programmers would edit precious
source files using something *other* than emacs, or vi, but....

In essence, file system developers are massively outnumbered by
application programs, and for some reason as a class application
programmers don't seem to be very careful about data corruption
compared to file system developers --- and users *always* blame the
file system developers.

As Niklas points out in his reference, this can be disabled by a mount
option, noauto_da_alloc:

   auto_da_alloc(*), noauto_da_alloc

       Many broken applications don’t use fsync() when replacing
       existing files via patterns such as fd =
       open(“foo.new”)/write(fd,..)/close(fd)/ rename(“foo.new”,
       “foo”), or worse yet, fd = open(“foo”,
       O_TRUNC)/write(fd,..)/close(fd). If auto_da_alloc is enabled,
       ext4 will detect the replace-via-rename and
       replace-via-truncate patterns and force that any delayed
       allocation blocks are allocated such that at the next journal
       commit, in the default data=ordered mode, the data blocks of
       the new file are forced to disk before the rename() operation
       is committed. This provides roughly the same level of
       guarantees as ext3, and avoids the “zero-length” problem that
       can happen when a system crashes before the delayed allocation
       blocks are forced to disk.

So if you care about performance above all else, and you trust all of
the application programmers responsible for programs on your system
being sufficiently careful, feel free to use the noauto_da_alloc
option.  :-)

					- Ted

