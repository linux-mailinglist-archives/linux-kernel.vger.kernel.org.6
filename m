Return-Path: <linux-kernel+bounces-409567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D462F9C900D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3F1B3BFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542B1ABEC6;
	Thu, 14 Nov 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTgkXuvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB16150997
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598662; cv=none; b=i06dM7Lph1i/9zcX3JAIR4T8bhD3W+T4iiiqwhGyNUw0Tp/i/Tc+kK7Zumi/w9bx+00NtB2THw7FRyIBGrv2Vb3Z+437x5B1D7EkzM9B3j5DAOHXYCSWp8QnzqG+G7U2GMfWDIDucL+TgjO+5z0ajINIsL1mdFFbAcN+AzS1/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598662; c=relaxed/simple;
	bh=/+R1ST0vftb5gy4I6bUzRs7WTpvRvyWN8cNyI/K6cm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbnr81qIhubVf3C9A66QZIDyxitELJrQKsjj7nwaZWBMRsFVue2vBxKXjyhf3wsahI/t/QNJDw1PWdr07IAkEpJJC7EaW4WFm1eZlTIiHH8nXyy/QcNMUK5osYblwJYXiaCOW+wqTUZQZqHPZ+CNnRn+yvZpBo8hl9Z3vbqsSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTgkXuvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2FBC4CECD;
	Thu, 14 Nov 2024 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731598662;
	bh=/+R1ST0vftb5gy4I6bUzRs7WTpvRvyWN8cNyI/K6cm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTgkXuvbyVMCvVdW511hCPklC5A06FO9rhh+0nZWgUDV7AODxu6cC76JzlzfcdJNG
	 5pB9tTfjEQ1F3Qd7opW9zM/omVnngXcISa/uUZDbBNrRC6IcjJpaU69ZvOm0zVYcpq
	 fCn0lyJEtDHShnaMqCaqPJYXT36cFGoVeeJNf6aN8eRBFxNQGn+uT0LUUotKE4qvOz
	 mmaNHpk70FxYvQu2hDokANeV6BQ88kBwRfHsdCuy37OtkO58gV0wvazGCbD2YjthXu
	 O/BpEso46ZXIXt+7lRIrTWyzkq+sgTqV+XDUYOlDSWedyhD7q5cPFXeuSdx2NLm/sP
	 /CN4huxe2Zd4A==
Date: Thu, 14 Nov 2024 08:37:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?Pawel?= Anikiel <panikiel@google.com>,
	bob.beckett@collabora.com, axboe@kernel.dk, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzYZQ7aW1KiK2tCp@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <20241114121751.GA3971@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241114121751.GA3971@lst.de>

On Thu, Nov 14, 2024 at 01:17:51PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 11:38:03AM +0000, Pawel Anikiel wrote:
> > When doing a write of 264 sectors with PRP list offset of 0xf00,
> > the bridge treats data as a pointer, and writes incorrect data to
> > the drive. This might be why Robert is experiencing fs corruption.
> 
> Not having the hardware and just speculating, but this seems like
> a pretty likely failure mode.

I can totally believe that. I recall the driver had a similiar bug like
15 years ago. I think Nisheeth fixed it. Checks logs... Yep, commit
0d1bc9125890426b52c.

Anyway, even with the quirk, we can still have the last PRP just before
the page boundary from the "large" pool if the device supports MDTS 2MB
or more. What does this device report?

