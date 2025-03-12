Return-Path: <linux-kernel+bounces-558425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEF0A5E5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071F93B2291
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B41EFFB5;
	Wed, 12 Mar 2025 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tmY/1FCJ"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9021EF0A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812871; cv=none; b=mDF4sf9J4cYNPbk5V87O3TKkhy9xb1finrBmwnUVpabUj2iXDgXys7wPWWVuFKJNqSYuvZ8kEc5slbEUPXVrx0E9zDce97DIiIbih6xi2hD1Z+5DdK59L4ReRzSbVzsZKOj1TfT6GW/qcFAgT++MccLvaWSgpodImvXjJeTNDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812871; c=relaxed/simple;
	bh=ALpGNAmNdk7IjcJBHvxI2FTYA7UCD0e8jGKb+hVFTD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDgGtOaAcciPk3/e/6fxgFTV2ucQ0h5nDNU0FDZ0p+tcF8EL4xq4js2twqI87YIjcXUTNf6Gnvbn9wYjhgH84edRgetfIdddRVlSELV0E/db+3JhRDBwZC72RWjtlfIKW2Ei4/SSRO4fui3z2gHabsZseH/Vkr2uZwPLQ2a/xoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tmY/1FCJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 13:54:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741812867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PRlhVmJUNrS0JYz035zFGg8adbjMpmQ3va6GgX0Xrw8=;
	b=tmY/1FCJ4bb2X+Qxrs686K7Xcg8a4H2d3NZubse0v8BVV9juU8Dm9hScDdO4Y1DeNCb66M
	GrHtieptlrmBl+grp5G04DPn6M1/Jx+hbHthVXN3hBbYk8XPFGn6lsDcZT/Ni+PGGSXuvk
	xgyp0go7g0DNOnGASufWLCn8hJtKHGs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <howlett@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm/madvise: remove len parameter of
 madvise_do_behavior()
Message-ID: <nd2hvahjmztqfidyd2kc2n3jntxxdyor5csxg2kzbxohtvi4id@ybxotegatuza>
References: <20250312164750.59215-1-sj@kernel.org>
 <20250312164750.59215-5-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312164750.59215-5-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 09:47:50AM -0700, SeongJae Park wrote:
> Because madise_should_skip() logic is factored out, making
> madvise_do_behavior() calculates 'len' on its own rather then receiving
> it as a parameter makes code simpler.  Remove the parameter.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

