Return-Path: <linux-kernel+bounces-323908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E49744FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8BC288CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F71A2561;
	Tue, 10 Sep 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SLjTh1qf"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31016C854;
	Tue, 10 Sep 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004737; cv=none; b=XLAi5rYL2+EF7Mp0t/udYUzL9pJb6yDKc0q+LRg/LRDi3F3NhGxh0fBCCYdRlDko90NUuy+L3rPLlBCsXZwVWqLKfvUcuRB9mYc4ULEAQvjJLuan+JhRKb8MazL7IobnY59y3XDTHUAaa+KcnvxeQeLPM6HINvuXYjrFw3XYfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004737; c=relaxed/simple;
	bh=As0yOJXwtJM0tpBuEPwuKlk+dnPAkaqlDI1BM8P67jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qkk341anB7alhAK2D8XUCl7wJlsJa9vhVktTFUBrG4V609yTe2auNOQJCo+vlWw9rJvyQJEw1zAXnXm4/91zs0L8bkSH6Gse/lrszx96qecERL95IxDr5VVr2cySt11UIhLebTDMceuPxNytX3dxZ1yC5kEa5BsW6jP9Oz2nMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SLjTh1qf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9BA554188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726004735; bh=F9JRazt1XcPxIBi4ezj1dV5LBjiEeHbt/v/TTg13crs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SLjTh1qf1DQ1TSqjPe4hXo7/rORNZ8+0s+ilj2cAifj3n6GtQh/+i+mZuu3cDWSXn
	 gi91mMWq3A2eQQsB4FmtW2hciDc5FhuQPmuLEpyaEfV8o8Knh4JlSXNV2iMEQNLaAv
	 nnOF0N5aBcpyMPGXlKA9EYW9LI5QSTHaJD+C2pounFtsSRaYlpKrvgSBSEEBb1s+Xb
	 5dy3CyqTAg1zWu1245UzH+ZeUA/JOh0PfWUIyBNAgy/0wagHW68YYRxObDLe5rQV3X
	 yMf/4NPXkxQpXcG5kEONXzi5KsmztLWeQx9VhfukytwjJbgZNho7zNv9D6lT8V6Myj
	 WvZm506Pwr1sA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9BA554188E;
	Tue, 10 Sep 2024 21:45:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Shivam Chaudhary <cvam0000@gmail.com>, kbusch@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cvam
 <cvam0000@gmail.com>
Subject: Re: [PATCH v2] Remove duplicate "and" in 'Linux NVMe docs.
In-Reply-To: <20240910052737.30579-1-cvam0000@gmail.com>
References: <8734m8h9ce.fsf@trenco.lwn.net>
 <20240910052737.30579-1-cvam0000@gmail.com>
Date: Tue, 10 Sep 2024 15:45:34 -0600
Message-ID: <87o74v5gjl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shivam Chaudhary <cvam0000@gmail.com> writes:

> From: cvam <cvam0000@gmail.com>
>
> Remove duplicate occurrence of 'and' in
> 'Linux NVMe Feature and Quirk Policy' title heading.
>
> tested: Not breaking anything.
>
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>  Documentation/nvme/feature-and-quirk-policy.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I have applied this, thanks.

For future reference, a remark like "tested: not breaking anything" is
not helpful.  If you have done testing, reviewers will want to know
*how* you have tested it.  For a patch like this, of course, that
doesn't matter.

jon

