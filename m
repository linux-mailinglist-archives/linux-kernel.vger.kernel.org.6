Return-Path: <linux-kernel+bounces-542572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD69A4CB3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C741896E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F622CBE2;
	Mon,  3 Mar 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVqKo77F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEC18D643
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027672; cv=none; b=EN7hZI5lfVFNQ0o0q/rZH4zkwfnamYrLXejnvKfbD/7241yG8x7559KdPQ3Ne15mgsyv5vZ6cuuPOKwnDKkdJEXFbHj58bAW9ka9ui3s0rIdxUr81shuedEmPZCvC0eAUHOJAn1bF0Iax/2IW5DNjpNMknyNeKT3Y+6tEjD9RK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027672; c=relaxed/simple;
	bh=zA8qNblY8pt/GEGYu8CvsP0wmBr2ZcD4i21K+EPbjcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbcPGGki7NaAJb6fqAhOI90h9PMCKkHzTf0UzDkrRSylbFzSlOs78CpN8gu9IzZqJOoEJ9GWxreUPts5OlqbIlpMN/YF/8boxBKWXJztX1mtq47J687qdx2QS6aEvUcPJ0hd3wtcEwTvWjtNILHgJgRm32MvBsW9Hiq+F3jIYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVqKo77F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B247C4CED6;
	Mon,  3 Mar 2025 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027672;
	bh=zA8qNblY8pt/GEGYu8CvsP0wmBr2ZcD4i21K+EPbjcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVqKo77FBTo04fMaV6/BtP7g4FkD9TIKFz1CltxFaAtl9zYG4xkV9u58yDHaFVB6g
	 YVfQP2Yh7NPnALjp4q1nkYkO57jpYqSg1Bgs93iyZ7/n1Al9CaVilPPjLJlZCPmhFh
	 Oa7F4+oq7GCqArmW77xVvg6g7L3quIOechauIvehef/5tuMQWIJYUKQeOoO4lskCuF
	 2uSMlM1CyrPSy3hsk8MvG86Uhmybu+78Zv98Dxj3Zy/7a4a4nfUW+ragMy2pY9kEii
	 fBNjTfXGueZOAVlb4rZgXQKPzF/evd6Uy1yOLCUDjGpPsueRuTI9b2+5UibyWmom9M
	 AAFIFCrQfqNiw==
Date: Mon, 3 Mar 2025 11:47:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: james.smart@broadcom.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] nvme-fc: Utilise min3() to simplify queue count
 calculation
Message-ID: <Z8X5VJgQ7yPfVTdd@kbusch-mbp>
References: <20250213221622.81457-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213221622.81457-1-qasdev00@gmail.com>

On Thu, Feb 13, 2025 at 10:16:22PM +0000, Qasim Ijaz wrote:
> Refactor nvme_fc_create_io_queues() and nvme_fc_recreate_io_queues() to
> use the min3() macro to find the minimum between 3 values instead of
> multiple min()'s. This shortens the code and makes it easier to read.

Thanks, applied to nvem-6.15.

