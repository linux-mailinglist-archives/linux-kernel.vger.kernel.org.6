Return-Path: <linux-kernel+bounces-524940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F39A3E8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4D43BEEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB17213E75;
	Thu, 20 Feb 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7Jx4e5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945951D5160
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095913; cv=none; b=h0fsAwhP1+IAQpHJl8otYsouKwi8JWVd7GdUYKstXaQawIFv10TF4WacpA6F6n4vsb9+/XpZTG8l3C/lb3GTjEhznbZVy+klTVZzn8q63wMzCGdOb/m18XEsE4x8MLjRGj1vPB0wyejZzy2Uk5Z/RqZBNaDAa0mXIutsQUpqn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095913; c=relaxed/simple;
	bh=qVNfQPPtsbxtQv0jnue0m+Vcvynj5EqWpeRbBBd3lfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4snFc5UkXyLNj55ahhnPsIp5k2luDioUjwT4g0cJQejkoUkJ4CLrV3caEQnIFV7HqcVQ6UwK83fz6MDznRQYqaWUgOmcDM1s8c3PwrobnKbBCZkX4B52A647cpy20XCsXEDoDEW9+mGfbLKCLOGEtWicBGiLyGq8r6+YF506gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7Jx4e5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F246C4CED1;
	Thu, 20 Feb 2025 23:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740095913;
	bh=qVNfQPPtsbxtQv0jnue0m+Vcvynj5EqWpeRbBBd3lfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7Jx4e5KVcNnWKYXYhDurlDGx9QBvuQ9T2idAecJYi2HiJkG0ceAJPztlUl0iHqny
	 FyJaqVuXeRkEBTel4YvLEtGhqaDocJueCKh7wZSS2SMUy2AOtZaWesgI37Vx1SLUsg
	 sztlCHGxdzD/yIglbCIJXvtO6eQBpMKqKgMGMrRex6A1hYZFyU91oZO3he5us5Af66
	 PgPOrvdLiVb8eqYc20AdIqQHNOgGTPU3C9BlQnqvUeECLEU5QI0hNs3ZwTIyPSha/W
	 d70vLZ9pt26i00Zc1O670dGNMWJPN8nyUBe79p8oItTiVtfPMaXM+HRAdi9hSU3ZDy
	 /dME7KY1RiOwQ==
Date: Thu, 20 Feb 2025 16:58:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Xinyu Zhang <xizhang@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <Z7fBpnVEBhFPXUR7@kbusch-mbp>
References: <20250220235101.119852-1-xizhang@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220235101.119852-1-xizhang@purestorage.com>

On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.

Nice, thanks for catching this.

I'm prepping a new ublk-zc version based on previous feedback. I'll add
this into the series once its ready, and I'm hoping by tomorrow.

