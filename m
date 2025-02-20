Return-Path: <linux-kernel+bounces-524578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FACFA3E4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CCA3B975B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4C24BD1F;
	Thu, 20 Feb 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qCrCkmtR"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509B1DE8A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078623; cv=none; b=lDH1rES+UoOWwNB93oF5ctHR+fKz/e3sT2BAr6RDnnTNBoLV4ardxZMGgLIKv5W2yhy4MbkawbcGc52C9aExjhCXcl3LIAH91ZaozAkZBJUNyys/uVfacnHXlqPasriwXmHHv0j9xHY+kuIysLeseRW+uhDoPVzvs2xZKMqGgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078623; c=relaxed/simple;
	bh=ODwutrq0swHEnrnZoPZyyp9tP45da7fGNHCERuBBpa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z97YHfyyOayFzA0G2BJf5Q0r/JDLhzX0cI4AXRd9N4o6Ed2NQ9rmLneq2m6k4GKDPxPA822A5C70uvgA04+m+xpM6gmdhrIjc7ev4VSKAuK/fZmSam7kvTqJcoV8ZXv4AClm4lLlHxgpDSp53gAo8JzzcM5yTnpZ0YyJe8u1gRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qCrCkmtR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 19:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740078619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9LdEek9D0ZM2IpwYoKGDur1UZslOjkc+w5EqklCMpig=;
	b=qCrCkmtRMVHsyfpGi8cDWfYG6hWYAAfHacr/SXO1vtQOYmWQnE4eT2obOB3KuKAgYYu25+
	RiqSqBDay8k6/+fNqlLvw8c7h0cYcueYx1YkiCIRCJtOeKm4rQ4fMYd96SAMoR5MWabreA
	K0XHttQn6iJe73AcA7RQ7GOwFutJ9d8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/17] zram: permit preemption with active compression
 stream
Message-ID: <Z7d-FawfAYRQJUgn@google.com>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
 <20250214045208.1388854-3-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214045208.1388854-3-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 14, 2025 at 01:50:14PM +0900, Sergey Senozhatsky wrote:
> Currently, per-CPU stream access is done from a non-preemptible
> (atomic) section, which imposes the same atomicity requirements on
> compression backends as entry spin-lock, and makes it impossible
> to use algorithms that can schedule/wait/sleep during compression
> and decompression.
> 
> Switch to preemptible per-CPU model, similar to the one used
> in zswap.  Instead of a per-CPU local lock, each stream carries
> a mutex which is locked throughout entire time zram uses it
> for compression or decompression, so that cpu-dead event waits
> for zram to stop using a particular per-CPU stream and release
> it.
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

