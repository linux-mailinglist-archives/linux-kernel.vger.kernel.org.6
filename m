Return-Path: <linux-kernel+bounces-519768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D569A3A1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159EC16B7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1F26AABB;
	Tue, 18 Feb 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zoh1xK9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75C207A06
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893541; cv=none; b=o3L+FCBSOPQ6AUcrUfZTssYeGxYsGcJugHp2j8tYmX4kdZl3aPdF+1D3yvtM6aEifJh6Dfd3LjI1pvwVLn+1xJ/PMLbr+k4RRgk/955p8S2YK+mYF6BwlepEIp95dwBWLC7k8bLlABR6lGkPq8FC8TDRxwkJ/y1P6x+g3wkUaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893541; c=relaxed/simple;
	bh=T7hySr5ecqC3x+q85ihTMQrkoCJj4NZdyMJ78ShIj+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI00m/Fz3gqxunOIqRlD+pwjZmPjuHJNQfhJuEBVXV4Fdo8Bv0OZaqBin3eyMyGO2+G0zCYYrCzzjSFbGQdtTFRwq3wqmC895emFsOAZrH43wYjKcaj6R6fMZSkI0YSmPcVEUfe37nUgfeyArttt714TWXn8FCupmoSRsKDPOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zoh1xK9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBFBC4CEE2;
	Tue, 18 Feb 2025 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893540;
	bh=T7hySr5ecqC3x+q85ihTMQrkoCJj4NZdyMJ78ShIj+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zoh1xK9Fat+HL/1UOMTHYWdt3x+dfkDWbK1m7iXtlUeo6CaY/qncJLmN6Yw+MRLyJ
	 n+qQNHlqaHBe8+KbEHgZVQ4DMz79KBxRR0x0Xd+iOZY1vhTb/1h4ayJGLEOrajcJnL
	 y4teGLxkBqF8hJEfILbcwBuc9TEJrxJgFOJMGp8DzvHtClqicSqtUPWb1s4OALhB3Y
	 Yn1HFIc+FmjvHFZVQctqmIejJuc60PXS53jG7RqzDPpO26G33oEUnzuBhnZ3Ibz/qI
	 s+5MWpLfkdXCaKatHNrCrPOvjm+X3jcypDE4YCxc9IZh0B4dBeLY5Hp/WX2qDAKZBu
	 zpAOuZdzUm/0g==
Date: Tue, 18 Feb 2025 08:45:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
Message-ID: <Z7SrIT9m51w8A4DC@kbusch-mbp>
References: <20250124184311.1642797-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124184311.1642797-1-csander@purestorage.com>

On Fri, Jan 24, 2025 at 11:43:10AM -0700, Caleb Sander Mateos wrote:
> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
> checks that the return value from recvmsg() is non-negative. If the
> sender closes the TCP connection or sends fewer than 128 bytes, this
> check will pass even though the full PDU wasn't received.
> 
> Ensure the full ICResp PDU is received by checking that recvmsg()
> returns the expected 128 bytes.

Thanks, applied to nvme-6.14.

