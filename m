Return-Path: <linux-kernel+bounces-530303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B5DA431C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCBD17690E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C461CA6B;
	Tue, 25 Feb 2025 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJb+GdhI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02B9450
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442638; cv=none; b=I/Z52Twgn1lTiLugeJWZxqXaxn+kESc6mlX8X+Oelloq2QBx89IIBtOeoLFYSsoEf2sF7SDZGKGnshl9SRaZEmtSKus7brxeFzwIy+vCGvNcnVNm9vHK2IBc9buxEpcxeNjk6eHdc/VFMvqNTD5T1sexC/gU5J1s0C2Tff0qS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442638; c=relaxed/simple;
	bh=UH6tcp8VxWyeHOBxoFlbV8+a/iGzWX4jL92wfV+tevQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8W4O9XTOAIVGkro8fkUbhRi5mkpV1efB7e/Q9t9rb1nj3CuY8Dx2I69lReZagfeHXBGkBfiIT05y7L5HKxNloo7RgAuhwc1r5v+DiOxvJIsUwkPrtMZgL0a40UH7kVksHRUQq+fZA5rHgLByhQ3nsLN2/c85nuaY9jQ+o1x3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJb+GdhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC33C4CEE6;
	Tue, 25 Feb 2025 00:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740442637;
	bh=UH6tcp8VxWyeHOBxoFlbV8+a/iGzWX4jL92wfV+tevQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJb+GdhI3nHMOnyUSReZev4MyxHrkOS+DyhYVqL3gyx71PVuz7hD+X4pJdLLQzo0I
	 HHsadj6/GfAvoOcTB+exRRLCKs0LQ0P7Aj1eXO9ZeFSvhin3D8t0eMFcfyrqRK4sDu
	 1aBGzTdayF+mmtqYroIdqsWH7ECgbNeUfkEI3Ox9DzU0BNEqYmCz9PHbetcUpgPI4C
	 6t/M88yT/UJhGo9TMK87nD3RYEcK8aQx3nrJ8DfV1T8Zoon8z8H1NSh4oWYxhdJ/gm
	 d5Kbs1JB4qjsX9mS8v6kfhho84qYCy28HrzNHZXsgoNgrE96VRPKP+YtGaTvRrL+G7
	 MEpihvJircIEg==
Date: Mon, 24 Feb 2025 17:17:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Icenowy Zheng <uwu@icenowy.me>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Message-ID: <Z70MC0zoC0L-tOgO@kbusch-mbp>
References: <20250212170444.16138-1-uwu@icenowy.me>
 <20250213055449.GB19370@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213055449.GB19370@lst.de>

On Thu, Feb 13, 2025 at 06:54:49AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> > Here is a small patchset that is developed during my investigation of
> > a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> > SSD), which is because of the SSD's too-small CMB block (512KB only).
> 
> Hah, that's certainly and odd CMB configuration.

Should be okay if it's just for submission queues. The driver has an
arbitrary requirement that the queues have at least 64 entries for CMB,
and 512k allows us to create 128 submission queues like that. That's
enough for most systems.

