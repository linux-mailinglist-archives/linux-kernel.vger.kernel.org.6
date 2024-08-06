Return-Path: <linux-kernel+bounces-277035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B421949B64
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C978F1F21BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9930172BD3;
	Tue,  6 Aug 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hRggnWBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD177F08
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984074; cv=none; b=MyBcilEcD+i7s1ZVTv+tx4ZEf3EVmcMG8nQ/wMBi3mlZtSxOXjc/hPsd+hL3w5Hjy8DMxJ4Y8lAbP89IzrXG/fbVJHsGlhalurQRpIP1M/U5I6y7QS2QiHNnVdeg/tXlw89GM4n3KMEd7uVPB2HXQ5nG6/dgOAvxzpX/mag5CxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984074; c=relaxed/simple;
	bh=44UEzDHataWzJNxXj0NImaWdiAbe9/ovmeNH4HvCabs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ijfuhvrGXHN2Jd8mCVgJPmuqmei87E60OKqSfIe9Pvzpwm+6MMtd8WR0i0/6gn9hEzZE9EmoyK1K9+60db6hPXSE6C3cEmHJ5BQMe89NfLEepg+yOb5Hbts2ZaRVpkJMl35iiUBntH06jYY0NtzaF9P9AQ5HYODebnlQcmVobdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hRggnWBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A869C32786;
	Tue,  6 Aug 2024 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722984073;
	bh=44UEzDHataWzJNxXj0NImaWdiAbe9/ovmeNH4HvCabs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hRggnWBPgkNoW1K37OI5faFQqCdyE+EP+Tao3S28QE29rmRh3X0D2NsdoaPKTORwp
	 E51Gyzt5uTU7XY7TPQaRPyYYrOKFZhUDzpDQgS6a8ewBmTP1JEi6e6i9l8r1R4AsKa
	 PuyywCpdQDVLDtd/gCRTdRFX3mk5stkSE7yYLI7s=
Date: Tue, 6 Aug 2024 15:41:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Kairui
 Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, "Huang, Ying"
 <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, Kalesh Singh
 <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] mm: attempt to batch free swap entries for
 zap_pte_range()
Message-Id: <20240806154112.5d6e63b527c3a9501ef5a851@linux-foundation.org>
In-Reply-To: <CAGsJ_4xR949nPauJ4kZpcg3cRwvcrHHWU7oSazpfGR2Tv5XNTA@mail.gmail.com>
References: <20240806012409.61962-1-21cnbao@gmail.com>
	<1e6bcaf2-7c48-4be0-b101-ec2ddc4098ce@redhat.com>
	<CAGsJ_4xR949nPauJ4kZpcg3cRwvcrHHWU7oSazpfGR2Tv5XNTA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 04:44:44 +0800 Barry Song <21cnbao@gmail.com> wrote:

> > > +static bool try_batch_swap_entries_free(struct swap_info_struct *p,
> >
> > Why call it "p" here and not "si" like in the other code you are touching?
> 
> that is because I found other _free_ functions are all using "p":

`p' sucks.  "pointer to something".  It's just lazy.  In this context, "si"
has meaning; lots of it.

