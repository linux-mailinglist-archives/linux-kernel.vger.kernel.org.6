Return-Path: <linux-kernel+bounces-368869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CC9A15E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27383B22A01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464BA1D45FE;
	Wed, 16 Oct 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RsQ2oaWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4DA1D279F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729118488; cv=none; b=HuttPwvRHTDz2hD9B5WZbK6u0Tc6bTplAckwnC2x1s2XHmmBdC48tMkA2md+8yF0ZnmKfZE5sg4i7WCQofVdqgPzz3+Ol8LGAKr/mX+TJ6eGKlDu2BM5fUNVu1dFF3oUBDMjBSNYsLVnF5M00bZ/8VgaTt/jL/FQScPRGTY+uCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729118488; c=relaxed/simple;
	bh=Q5W0ZogIf37LVk2LLoADzxo0M3GONipCWt/BMiZHnoI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Wk4D2guxj0dJTy49kF33+pSn5wfW4BmONuMtgEAZeq6jKbKKBQVrdDUNcqHc+vUxyXPsuAgDmwPgRiSFq6m0Y6dK4fcrK8bIOvmrzOkz84Zm//os+bTP50q2j89sGxsDWs1Zr8SCZBGNKvdXV+76YgqubcxH9NcdhcPccSHuX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RsQ2oaWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2239C4CEC5;
	Wed, 16 Oct 2024 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729118488;
	bh=Q5W0ZogIf37LVk2LLoADzxo0M3GONipCWt/BMiZHnoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RsQ2oaWCOoTUPLdcsvbRvsd/julwO5aBAfMpXF+bp/T0jF1ycpZ/FGE6ibvFpVAyd
	 aRkI60vHXx45gyZ+g32+/TDmtu2c4L9o09Caqh/iFAnF4EtcdSIA9aleWOhtCwkttn
	 nlgKqsITd8zjRfdWtGoYSlA1Vi45Ueu8w9qJpD2I=
Date: Wed, 16 Oct 2024 15:41:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Alistair Popple
 <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>, David
 Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Minchan
 Kim <minchan@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
Message-Id: <20241016154127.3e369be7398bd0c3db27e8e3@linux-foundation.org>
In-Reply-To: <5e499b63-8b38-4ddc-82ab-848301fd8d2b@nvidia.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
	<20241016145739.770543d44313967f611f3810@linux-foundation.org>
	<5e499b63-8b38-4ddc-82ab-848301fd8d2b@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 15:05:28 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> On 10/16/24 2:57 PM, Andrew Morton wrote:
> > On Wed, 16 Oct 2024 13:22:42 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> ...
> >> Fix this by unpinning the pages that __get_user_pages_locked() has
> >> pinned, in such error cases.
> > 
> > Thanks.
> > 
> >> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
> > 
> > I'll add this to the -stable backport pile, although this seems a bit
> > marginal?
> 
> I'm on the fence about that. It is marginal: you have to
> exhaust memory. On the other hand, a real user reported
> this bug to us.
> 
> I guess I'd lean toward "correctness in -stable", and
> add it to the pile, in the end.

Thanks.  It's a super-simple patch, which helps the decision.

