Return-Path: <linux-kernel+bounces-344187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69B98A614
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D411C2276C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F01922DD;
	Mon, 30 Sep 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTeQJBeB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AE19047A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704368; cv=none; b=pfPy6rO8/Vs44TOTHPak2tWksmQGARatI2eG6JIkgLAlhpqCVmvw8PqlihmeYaKRCk1ee9oFmhhC5HvRicZBgS8Dm9CYyAB/uIGEHtaUNP2WwO54EnpvvCIvQlb2HBisJ/B+pzLsfIT4tMKXXCRMVNO69Mm+9wpORK/er24Dn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704368; c=relaxed/simple;
	bh=3DXpXuP6j6ZbLiklT+hfeQtKg1Z2FaE0rxToJn7T9aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej3iJglVbAW15Nyti+BlFbPWs2XjcE+TyRcTSHYcecOA7vtlaa2e6FyvXneEhp094pTwFybdmIXk2rx+p6ndyg+ppkGHcybifcsCpmRz9PPJAvFbpmhrlMMfLuoync52bZR2oSSYN3E4Idb3gYhMZxtsmJ4xuHA6h4Zla4li31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JTeQJBeB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=adKwxB+XL/whCVJICS2Ax2apZpGEL4/bZDV6/yBURV0=; b=JTeQJBeBvfLLWPmcPuSO5cJqOo
	3dLBsNgI+2TjZl7eRTPhEGZXFkUn4cId4nVtcKcyvZobbUFoNVc5n1T/Gi01n2wik/hb2tbZhmpqH
	6+UPpr9V90UGRiyiCZRMrpmiOVaMLOlF5YEWU6RBm+1RjTOHpoKKe8LpYipF5rcbdGtpQddglv6v/
	fW6rm6AcpblyRljHfdgoas40DhcLA5Inva59qc3CN6riREAKxQktmEWvI7X+dSTIpuIIiK5Cqi4HJ
	6zIq3dym5giRY4E/6PkYw/UHcYtRJREDtr0WXMPlkNAqzVKDV7Zoi9SlZhwCVOq6IByv+mx3t9oYT
	AJDdNCWg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svGpG-0000000HPFb-2qfD;
	Mon, 30 Sep 2024 13:52:34 +0000
Date: Mon, 30 Sep 2024 14:52:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com,
	hdanton@sina.com, hughd@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
	vivek.kasireddy@intel.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
Message-ID: <ZvqtIn-9PZRWkMDa@casper.infradead.org>
References: <000000000000341f5f061d8d6bcb@google.com>
 <66f9ea7a.050a0220.aab67.0023.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f9ea7a.050a0220.aab67.0023.GAE@google.com>

On Sun, Sep 29, 2024 at 05:02:02PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit f8d112a4e657c65c888e6b8a8435ef61a66e4ab8
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Fri Aug 30 04:00:54 2024 +0000
> 
>     mm/mmap: avoid zeroing vma tree in mmap_region()

This is almost certainly a bogus bisection.  See
https://lore.kernel.org/all/00000000000020f6f8061da86023@google.com/

