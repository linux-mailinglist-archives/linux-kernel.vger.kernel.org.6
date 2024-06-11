Return-Path: <linux-kernel+bounces-210314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 732F690423E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EBC1F26992
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F080E4778C;
	Tue, 11 Jun 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukQZ6ZBD"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952F11720
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126188; cv=none; b=EVv1yQfpk8l+xjB9yBBvaOBdke2dt6QwJEHne4f1RULYqoYqahW/zPptdeDM5d7VTFPBYWRqlml9LbOmzkSZ1PIa+FJ4/OYIL0+1cju2+U1zpXz+3yeh6YRkw4QHA7fWFz5S1Nf0/CNSt91Vfy6gdT0a8GLM1RCkLPrZQK8iB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126188; c=relaxed/simple;
	bh=SOPsC9E8NGLZiXlBTGkh+yswcZ5Kpe4vyv4AWnESrxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brUUrnV9moqP7zGiMxiQUybTStNqSSTG6kmqlQJ0U0lKoMRmFJITD/29qJnLcripsPKtD887fS+NrmSlMV5Sz5ifCEZ7pBdikNoToTfJdEMMklM62rc/lzoDvALFO33Az7Divm4b6UA0C9dqwFg5JupKDdMOq3ljF6ZRS6ZeB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukQZ6ZBD; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: usamaarif642@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718126183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjEGM0189YXKD5XoQXpyIoWJTRC/+NjjQ7qIOjBHtf8=;
	b=ukQZ6ZBDDQ/M0ByaznMxRAFjxzX0eDvTT42rvEjMfvYAhE58JJDseBRb2LaNnKHCqncXTr
	15hFt/Hhlgby2vYqXLnUhW0Zz1Ohm+7fMbaxl+Bj+fvwXT++ZAMF8NWXn0YHcTNYMa5R+J
	NjmOdz4HpiY6EZlVRA3uWaEO8j1Fu1c=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@meta.com
Date: Tue, 11 Jun 2024 10:16:17 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
Message-ID: <ohcrgrlmcl7ym6dlfy524g3ht63pask2qjeqy5m242xrvxojt2@36gqaboyzmn2>
References: <20240610143037.812955-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610143037.812955-1-usamaarif642@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 10, 2024 at 03:30:37PM GMT, Usama Arif wrote:
> start/end writeback combination incorrectly increments NR_WRITTEN
> counter, eventhough the pages aren't written to disk. Pages successfully
> stored in zswap should just unlock folio and return from writepage.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

If Andrew has not picked this up, send a v2 with more detailed commit
message, particularly why it is safe apply this change. You can use the
explanation given by Yosry in response to my email. Also add text
answering the other questions raised by Yosry.

If Andrew has already picked it up, just request him to update the
commit message.

You can add:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>


