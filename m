Return-Path: <linux-kernel+bounces-196758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2AB8D6185
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C11B2394C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE809157A68;
	Fri, 31 May 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDY9ElEZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39116138490
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157836; cv=none; b=ZF1DPzdhSVcPwUeX5dYUd+QO3Gcb05G9DnBU5m59KY3WzjXQZQS3c6zwwlMaS9vcd1k5uDUKm9eNHdtf78HmzZxDTFKTcODdCsIEKj+FASESiTYCInfxq9anzg0O5G094uAIxvvDIWzKLQjpDsZuYLegMuohKyCNO4EbNfXRXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157836; c=relaxed/simple;
	bh=C/2Lyf7Lg4rbLPYaZKO6th7rS/4OXvr6QR1MXCxp5OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et17lg7wXkAKLDe2872G09LhdJ6kRy423+GBsh43GIDQehvdpH/vfoe3NMcaWdI2XuSaTPY2sADjbxdUwJRRaqeRGEK3RichG4tUj9sGsCpEEffGZNLFKTubWZPF0vCxfpdQ5Pe6QGLNzwTJTZQu2pYEoYqJXyYItafdE8MXjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HDY9ElEZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jyAihqKd6Hda45CnlrSOdjqk2oTnBzNCXKHWOSSfS08=; b=HDY9ElEZC9QCWO1z7fesMTuep6
	qymvqqVoiC7kRrNdDlxkZWmkqgX+HmhEo4cqg8q0iosnF0EphRjsAhCWCKIMr6UhVjZ55ZRb0oH2L
	6vYfFqpxLPaIjAvh4O2DJTXN2M3VTOL15AU0pmMdLJ8s/MDVTN5vppX0fCKSqHvtFHaKJpsP1NAls
	71oIl2eab6ruBXI2bZK0Mtx1xHl0tinVPzn7gaH2Zg/p03dVaWsPmlvFSunecZathoOldAcdGVfIg
	U0YU6d8J8KTEDQ/TCLqAlss2q7SRCsV/MISxgaCH96Znf0VN/1K7/3i5/zoWnzxqOWEg8CzVmb3s8
	pi/U+okg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1Bv-0000000BhRZ-0Vr8;
	Fri, 31 May 2024 12:17:03 +0000
Date: Fri, 31 May 2024 13:17:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>
Cc: zhouchengming@bytedance.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [QUESTION] mm: Redundant const parameter?
Message-ID: <Zlm_vlhYa91fA1wu@casper.infradead.org>
References: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>

On Fri, May 31, 2024 at 04:42:59PM +0530, Dev Jain wrote:
> Hi Chengming,
> 
> In mm/slub.c, you had defined slab_test_node_partial() to take a const
> parameter.
> 
> Is there any point of taking in a const, when you are anyways typecasting it
> to
> 
> a (struct folio *) from (const struct folio *) ? In fact, at the place where
> you call
> 
> slab_test_node_partial(), the struct slab *slab is not const.

I have a patch to fix this; hang on a second ...

