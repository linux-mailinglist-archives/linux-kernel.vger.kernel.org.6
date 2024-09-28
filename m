Return-Path: <linux-kernel+bounces-342461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4D4988F55
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB03D1C20C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F79187FEC;
	Sat, 28 Sep 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QHyPvcvH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABE200DE
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727528936; cv=none; b=OVqrpjnFQpqRPmsU86drb98bK7CMdLfqlI7311aRQFmnmQlZG50Prj7r5755s0lSwXLy1sUboahfDlJp3ezQO+faf63/IL3oTVq5ZPvNhPVc10BJBXJ1Kq1aM/YSECJ4w7qphE95jzBQGscydugefsR+vafKAVaWbRiZVnwT4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727528936; c=relaxed/simple;
	bh=auOTkgC/saZaH+G9k7EQrhdHKg52RRCkrrjyliPrYok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huYcQSQO7zquLhdX8UsnOuw+cgI4y+5dHSdwpEfGIV8B+GPmF6NedluVd6ITILxPXh3b9c6gKcgfhrlmQ84FLCSvo96/tjlISZP6VpfHi24ioTBbDVlwHWWz853xvw8vWcz05ehHBvqoKEZuwLFiOopxRn8EB3Hjkst6OIYMZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QHyPvcvH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HzpZb6ZI/TJGTTzS8CVVVai1NrTI6wk/Gp3LCLox2cA=; b=QHyPvcvHJQ3I5JLnFWjORF73RY
	PkEDS9AShi2pGmBnnPyAOpKg6yPfqTZrhbdnYZuUuxH47n7j/vwts1rO416ls0QWlDHe6VSv/c+58
	3SwBzP4L/Sk4TahygjDFVvTngGaM7FQYHHImTCia7fc25L97701m4rpM76iZLmVSXFvXSAKQzJ3eR
	ykNfflaUIkajhEE4rdnBiGZAQNH+vi8A1AYL8NxvXCsBCi6fmD/VTfAjGTvXbGW7LAEmNdKtPBxhm
	La7R/3pWGgvL3eMOe2i7TGafFeRAgTpUMOBmgsY+/h8GAV4Pvcqc8mimLdqXyEQS3UCOSMvzPnfRJ
	2mH9Ggkg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suXBb-0000000CJXO-31vR;
	Sat, 28 Sep 2024 13:08:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7B340300848; Sat, 28 Sep 2024 15:08:35 +0200 (CEST)
Date: Sat, 28 Sep 2024 15:08:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 07/14] x86/ibt: Clean up is_endbr()
Message-ID: <20240928130835.GA19439@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.069013308@infradead.org>
 <20240928000444.grd3jxltzoiihsz3@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928000444.grd3jxltzoiihsz3@treble>

On Fri, Sep 27, 2024 at 05:04:44PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:49:03PM +0200, Peter Zijlstra wrote:
> > Pretty much every caller of is_endbr() actually wants to test something at an
> > address and ends up doing get_kernel_nofault(). Fold the lot into a more
> > convenient helper.
> > 
> > Note: this effectively reverts commit a8497506cd2c ("bpf: Avoid
> > get_kernel_nofault() to fetch kprobe entry IP") which was entirely the
> > wrong way to go about doing things. The right solution is to optimize
> > get_kernel_nofault() itself, it really doesn't need STAC/CLAC nor the
> > speculation barrier. Using __get_user is a historical hack, not a
> > requirement.
> 
> But these patches don't actually optimize get_kernel_nofault()?

No, I figured there was enough there already. Also, given the state I
was in, I'd probably get it wrong.

I have it on a todo list somewhere though. It shouldn't be too hard.

