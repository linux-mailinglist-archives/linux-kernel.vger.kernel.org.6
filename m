Return-Path: <linux-kernel+bounces-364456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173E99D4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B451C22E47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D071B4F2B;
	Mon, 14 Oct 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsPFcVog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBD1A76DE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924129; cv=none; b=oFducT+IlG+It9AAcfvwf6VRhSB9sOKOBIXN3iaArNyowVIc05PONLXNkqDymw8bR4jcAWIOtjkK64Rn+ofH+16gciBjX7+0Y8t9HUlo23c5acBH3LkmevmMGzRO6dbLn3mNgA+dL26Yv+l+5DPdlWOc3uvufmP+oZ5KtO0iLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924129; c=relaxed/simple;
	bh=1KbERnWutO72Tt0MSOPZCf25uus9t8+fv0RSQ+GO6GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqaU8J9xYbBjG8LpiFRvluOLbx7Ht/5G0t47dCykq3UivrzB7ozy1zGz1m8t+4ocRF/b8x4q2Rt8MEdGMmOGGXT+0tIuWLwKFmlJZaDQDDvNR09cB7QGC7cLqaxhMA6DI8ksNbJItes4JXiMY8jYOjjND0diTQQ5QcYlUP8D99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsPFcVog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED04FC4CEC3;
	Mon, 14 Oct 2024 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728924129;
	bh=1KbERnWutO72Tt0MSOPZCf25uus9t8+fv0RSQ+GO6GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsPFcVogPtt2s8+V7P6WzIDByjS9gnrdoD82tXuUE9h2gN0em614jhK6hF7VvwnnM
	 CVo8uUImd81DekA2oFBjGTvJcFIPgtHSOAlNUM3XuYPF4dFMK+lRXdbB9Ld+4yL02Z
	 Acx74AzIiHCHDKHCrRJ8pvUEqNhK4m6y+vLhwipqJK1ayVowRAfMq4Nj21O97TlMgu
	 lKLkaUgC7jJm1UKBpE04v++zqdJ+9W8FG7Y0/Y71Re9WkUYMuomEDDQ8QmN0IBP/BQ
	 FwKZYO4VsUG+78EHBhVHdQ9gouGPEZdN3LFf7yD9YdUhLfXa6pZCKu0lLW84azazrL
	 otQ8bsyR9TOoA==
Date: Mon, 14 Oct 2024 16:42:07 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: introduce device aliasing file
Message-ID: <Zw1J30Fn48uYCwK7@google.com>
References: <20241010192626.1597226-1-daeho43@gmail.com>
 <ZwyyiG0pqXoBFIW5@infradead.org>
 <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>

On 10/14, Daeho Jeong wrote:
> On Sun, Oct 13, 2024 at 10:56 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 12:26:26PM -0700, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > F2FS should understand how the device aliasing file works and support
> > > deleting the file after use. A device aliasing file can be created by
> > > mkfs.f2fs tool and it can map the whole device with an extrent, not
> >
> > s/extrent/extent/g

Applied with the fix.

> >
> > > using node blocks. The file space should be pinned and normally used for
> > > read-only usages.
> >
> > Is there an explanation somewhere what a 'device aliasing file' is?
> 
> Plz, refer to this patch and the description there.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=8cc4e257ec20bee207bb034d5ac406e1ab31eaea

Also, I added this in the description.

---
    For example,
    "mkfs.f2fs -c /dev/block/test@test_alias /dev/block/main" gives
    a file $root/test_alias which carves out /dev/block/test partition.
---


> 
> Thank you,
> 
> 
> >
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

