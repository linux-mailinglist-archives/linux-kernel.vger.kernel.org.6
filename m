Return-Path: <linux-kernel+bounces-534406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B917A466BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB99A1893942
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E655E21D594;
	Wed, 26 Feb 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M32g03qz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1E79D0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586600; cv=none; b=VyBc8kKtM8VbDfeIG7XSYNoBDXhRpe3btn3uGuXlqNuvBJZutMLu00mqpdQMlP4p1HfFDIrVxlGWVbRmyQYWA4ehVXHv0uiOx3sYZ5psnOlAa8F3u/NVpc5d2T455J3rV9tp0ooWwEyCosKOm3vLkdKeM0M4wsNiYPqZf956g9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586600; c=relaxed/simple;
	bh=sW0i/xtxEO2r06WYVbW9NDSc8uk+SJncYr/zTsA21bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctotLf+anqNLGv9GirDfhyjs0dPXPSPiC3p+MTIyHz1Zcl6xE55FiAqoT2wOPsZ8MD8KW0NwBi5wrXfizO84W+Nj4arQAqAyPj+mmAZfqPB5oNrLYviDCjuUsbAdLLKHENSxdmwBncziBFXU4wG30Mm/+ZkJ/SMAZ/wCva/rJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M32g03qz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KibP9ZXbVPA77tsDBIt7YejKy8jux7lGMAtKocjYqYo=; b=M32g03qz5Dfjn8teCFxFB+oxGB
	qpPSIAy3TukZOOIh8d8oJy65f5eXvPNL0sZQ5mCUm8oevnsWkg8BCriGClhX0mUrrzKPeATgtJTmG
	jcfMDkuoBf5u4kHmszo36IQK11Z+DBTv/TV2/g8j17zV89SdSvkdlGjESNrODNTd6MvGeAYWULo1p
	GYsLpWNeEtX/A2oOX5MkO1Sf/wz2qI7FfF7ta3aRph0FpSKkmgeAq6zIDQJiKxnhf3VVYwp1h8z1j
	kIueEgRrYjNaO/bZWT+WLZ7HczMPQDtjIuaG3NpPpOJWnH7gM2oGKE+yXtGujO+06LdY9qQT3cJ/A
	tz1XP+3w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnK5J-0000000Fu3E-2JPE;
	Wed, 26 Feb 2025 16:16:33 +0000
Date: Wed, 26 Feb 2025 16:16:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
	lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com,
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com,
	lorenzo.stoakes@oracle.com, hughd@google.com, jannh@google.com,
	kaleshsingh@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
Message-ID: <Z78-YdCGtbV61x_Z@casper.infradead.org>
References: <20250225204613.2316092-1-surenb@google.com>
 <hdcrjkqb4cevovpw5xprkh7ohykqay5ew27sbtpzg2k7vrm7mx@6ircmivkmkgv>
 <CAJuCfpGu3Gx-kCChgQjZMQNOxU=CqzkHuoghfNmbv+Q1UKYPxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGu3Gx-kCChgQjZMQNOxU=CqzkHuoghfNmbv+Q1UKYPxA@mail.gmail.com>

On Wed, Feb 26, 2025 at 08:11:25AM -0800, Suren Baghdasaryan wrote:
> On Wed, Feb 26, 2025 at 6:59 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > Reversing the locking/folio_get() is okay because of the src_ptl spin
> > lock, right?  It might be worth saying something about it in the
> > comment?
> 
> That is correct. We take both folio lock and refcount before we drop
> PTL. I'll add a comment. Thanks!

In the commit message, not in the code, please.

