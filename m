Return-Path: <linux-kernel+bounces-520867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349C1A3B03B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44C616D27E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23006192B76;
	Wed, 19 Feb 2025 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MDxQK3nN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524CEEA6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937837; cv=none; b=jszVA/eAW4a8aHs+FyW7M6RUtLMow5Q9Wt90yziCvbBLvTGJ3PqYZT+kZz/H1kS7Ykk6Mxrry95NbpSFyaVs1x/6mWik/GDDeplnYYW6MBbBKz013EiACKNBHuS5FA1lArPrERcb43M+6DvdaPJLUrKvxQKNownEo6MgYZ7QImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937837; c=relaxed/simple;
	bh=6MYOs90sgX6BErm9N0uarW3tKHRCajPMBu6jn7FErwU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Wi+o6K9/GdXx3pWlzRjJPFy8Mfh4ouUmBBI3FzhjGXo6oiGIEIvVuMKt8ciD4JAMRaaQadFt935XrkEtEZutCVq0kyXZgbJTtP3NwuL6cZY2fPxlbuLzFzG1Gqb2/EEsHfTNIk5XE9fD/JsJjNipRsx6qTGrWy7+lj2mKvhDrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MDxQK3nN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C53AC4CED1;
	Wed, 19 Feb 2025 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739937836;
	bh=6MYOs90sgX6BErm9N0uarW3tKHRCajPMBu6jn7FErwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDxQK3nNi2zbugcG3WV49DwqFKMKaOsn4LPoeJLhocxH+BJdySYoF1E8c98AwqOZo
	 UaNT7rFbmUS9fzyQuaecKztRhAl/06VXVwOn9EEtILXjBGwGiDe9goWeNukYmauBNA
	 VvlUpu5mSXcfuxM3rnL/GiY3i2nwsnfQkB32inUY=
Date: Tue, 18 Feb 2025 20:03:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: gaoxu <gaoxu2@honor.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v4] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Message-Id: <20250218200355.959a79bf9b6253772a95e782@linux-foundation.org>
In-Reply-To: <CAGsJ_4y9eoHRSUSzs96UWUVygEDcoTQqFM1uyEtr_VHcmAmVDw@mail.gmail.com>
References: <e223b0e6ba2f4924984b1917cc717bd5@honor.com>
	<CAGsJ_4y9eoHRSUSzs96UWUVygEDcoTQqFM1uyEtr_VHcmAmVDw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 15:28:26 +1300 Barry Song <21cnbao@gmail.com> wrote:

> > The patch seems to only provide a workaround, but there are no more
> > effective software solutions to handle the bit flips problem. This path
> > will change the issue from a system crash to a process exception, thereby
> > reducing the impact on the entire machine.
> >
> > Signed-off-by: gao xu <gaoxu2@honor.com>
> 
> Regardless of whether the above statement is 100% accurate or whether
> a bit-flip actually exists, providing this check still seems useful,
> at least for
> defensive programming.

I'm doubtful as well.

How often has this crash been observed?

