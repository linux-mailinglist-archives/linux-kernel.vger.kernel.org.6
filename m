Return-Path: <linux-kernel+bounces-201214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE88FBB08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B5E1F22272
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048714A0AD;
	Tue,  4 Jun 2024 17:56:15 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 216FB149E03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523774; cv=none; b=cefViAkWRBvvJKhEXc/GvVDUXr4n3Qt2YpTOKeyYYZKXk1eacEjgb93xDjHXA3V8YJjb9B4gJdA3Vct++Rn8oXVcbipyQwpyTeHnmHIkmAYeXE+e08JZYkqQlinAULW7E6jODoVaFaHDZa6HuEJ5FIdAyehPiiUMWx7rb9Bibx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523774; c=relaxed/simple;
	bh=3wAIXqH/S9/iZ/LgCLChcaYhPeYIkh1fRM8lbxS7ikk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv/3BLX2YJDoEQFEuHHHNB6y2ef6r7nWphy8GP5ucUksZ1kRNcfQFdlseeELxbPIAufMZBouP8bK6/brMVEJ4yBScx65Oiec4Vlp0aBGSNRJkok8OUmCFPUbtCBcH9pt8sPGcps3e/D/5Z87ul0GIodizC5lg9+ngWoRdFHFZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 165846 invoked by uid 1000); 4 Jun 2024 13:56:12 -0400
Date: Tue, 4 Jun 2024 13:56:12 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
Message-ID: <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>

On Tue, Jun 04, 2024 at 05:29:18PM +0200, Jonas Oberhauser wrote:
> Currently, the effect of several tag on operations is defined only in
> the herd7 tool's OCaml code as syntax transformations, while the effect
> of all other tags is defined in tools/memory-model.
> This asymmetry means that two seemingly analogous definitions in 
> tools/memory-model behave quite differently because the generated
> representation is sometimes modified by hardcoded behavior in herd7.
> 
> It also makes it hard to see that the behavior of the formalization 
> matches the intuition described in explanation.txt without delving into
> the implementation of herd7.
> 
> Furthermore, this hardcoded behavior is hard to maintain inside herd7 and
> other tools implementing WMM, and has caused several bugs and confusions
> with the tool maintainers, e.g.:
> 
>   https://github.com/MPI-SWS/genmc/issues/22
>   https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904
>   https://github.com/hernanponcedeleon/Dat3M/issues/254
> 
> It also means that potential future extensions of LKMM with new tags may
> not work without changing internals of the herd7 tool.
> 
> In this patch series, we first emulate the effect of herd7 transformations
> in tools/memory-model through explicit rules in .cat and .bell files that
> reference the transformed tags.
> These transformations do not have any immediate effect with the current
> herd7 implementation, because they apply after the syntax transformations
> have already modified those tags.
> 
> In a second step, we then distinguish between syntactic tags (that are
> placed by the programmer on operations, e.g., an 'ACQUIRE tag on both the
> read and write of an xchg_acquire() operation) and sets of events (that
> would be defined after the (emulated) transformations, e.g., an Acquire
> set that includes only on the read of the xchg_acquire(), but "has been
> removed" from the write).
> 
> This second step is incompatible with the current herd7 implementation,
> since herd7 uses hardcoded tag names to decide what to do with LKMM;
> therefore, the newly introduced syntactic tags will be ignored or
> processed incorrectly by herd7.

The patches look good to me.

Just to clarify: Your first step encompasses patches 1 - 3, and the 
second step is patch 4.  The first three patches can be applied now, but 
the last one needs to wait until herd7 has been updated.  Is this all 
correct?

Alan

