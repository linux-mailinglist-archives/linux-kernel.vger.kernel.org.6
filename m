Return-Path: <linux-kernel+bounces-355933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B999595B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF32B23988
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D68215024;
	Tue,  8 Oct 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tdkGR0qn"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74120CCF7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423582; cv=none; b=EgJIqJw59C0ScyC25X1b2i3Utqs6/7CF7JQ+UCho7Ml7eka27uGITRZYeCyaYPsyjDqTfaZ4+WakA955Fv9c+Np7KB1oPNnuoi9a6dP8e7v8HtDNM1s4XzMjmarmKNT7/dVeE+XVI8WHbDxBYqFw6qV0+fnNg0yOjlCF2e1mJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423582; c=relaxed/simple;
	bh=7Fk9hEbyJa/5s/TjAYnY21mhwMhyHGcSiSWIhGqiyj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYdKwpP852EYl/Ou1gUueTizuhvokqEKo4YdTB3ng5WkagwDoILgs7azdLxLV5Bou932zg0tU1DDYPYovljar60KnEZ1vIagLOOJbRatXYbhRHOAC7kpm2m0o38pNT9CnuMFHnaKCz8IyIfwWTZUSQiipfQtfejbHV4KE+MGRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tdkGR0qn; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Oct 2024 14:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728423577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upcROJIFe0W5gBFb4ALFX5lsfVgqMc+rHei4YQkYfl0=;
	b=tdkGR0qnlVBzBzEZBwL+0FMRxd1cajezHtvnnvFP+/jvi4Y9uNrcinS8xppfVjW9wDnC68
	NU2LDbgF9gBaG6svpO6+RS6qH8CJ8Ec5PeHL8YG/a01AEpdrvXjQW6aAfaHFUU096bd7dl
	GVwka/+eDZ7Y9Kdxw9HuOn1I31F09Dc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Rik van Riel <riel@surriel.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] bpf: use kvzmalloc to allocate BPF  verifier environment
Message-ID: <rf7i4y4zsm5yspnvebn6msj5r5dfvde3qvkti65fnhngcueqj3@landndtl6she>
References: <20241008170735.16766766@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008170735.16766766@imladris.surriel.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 08, 2024 at 05:07:35PM GMT, Rik van Riel wrote:
> The kzmalloc call in bpf_check can fail when memory is very fragmented,
> which in turn can lead to an OOM kill.
> 
> Use kvzmalloc to fall back to vmalloc when memory is too fragmented to
> allocate an order 3 sized bpf verifier environment.
> 
> Admittedly this is not a very common case, and only happens on systems
> where memory has already been squeezed close to the limit, but this does
> not seem like much of a hot path, and it's a simple enough fix.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

It seems like a temporary allocation, so using kvmalloc* seems
reasonable.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

