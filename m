Return-Path: <linux-kernel+bounces-232843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6C91AEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B012E1C22F27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9C19AA54;
	Thu, 27 Jun 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLK0Q+aP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD191CD31
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512697; cv=none; b=Ss9GCrKDq1Cz4sWCsXuFdlDsCpeV3YJa8UKODt1wXXB4MTIGNkR5Jk4UrP90f6cL8Y1NaDlqufJM09Mdvo/HioZ+fMv9jsl9pbM1EEgJqhZk0kAZpSUOEh0NHYbQVduycyFRtc+/OpWRjck4+iV25za5lcYCLg7wre5xqq8OKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512697; c=relaxed/simple;
	bh=5R8QUHPTPh+6nl0FJmR8JRADQI4yGvqwvjcoNLlc/mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUFaKnGDqVeZkWr/Or1QV3oO2wUDqtZxNGIA0Nk7QW1WNmpuqbjc3amcVwTTp6N25CweJtpQDjuE3EYvquDODy6WqdKQk9U/pJkH9B0pEHsBBcjD8tZ6zKViOAkdBMNB2OI2VZjyb3A8REK29zRYYPeXierKksmP3ovQQOLBNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLK0Q+aP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CB8C2BD10;
	Thu, 27 Jun 2024 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512696;
	bh=5R8QUHPTPh+6nl0FJmR8JRADQI4yGvqwvjcoNLlc/mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLK0Q+aPUkj3ZuwcwerLJ/BAC2+t1vhJ/8vQ1xsoiK/T7LQmZXddkEG5b/1BvXIuP
	 o2zkPG7ohdDzbO6jbDbdPL5r5zPJmG3QZeN18xqfklKjZc8Z878MD5sLRB9woj/HZk
	 qycNVZ0i18W8V5r+pfArrfrF6hxC1rtoQmK8MBBtzWT2Vr+cTa1t7Xm/aZohif7l0j
	 MQlWkWBylOW2NVdGblhkm/3kZGZf56td7/auTAeUtD5aR0fSH5G7vSYOA9f38BGIgp
	 q+8NJexuT97cCVrvCZwxHcyq5CHpXa6lP+lI1QYECRq0IKGQOY0wljq3KUVlbxa4nx
	 z79tRgwRhuVng==
Date: Thu, 27 Jun 2024 11:24:56 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, oleg@redhat.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, wad@chromium.org,
	rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org,
	mark.rutland@arm.com, rick.p.edgecombe@intel.com,
	leobras@redhat.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: entry: Convert to generic entry
Message-ID: <202406271113.1B28E51@keescook>
References: <20240627081209.3511918-1-ruanjinjie@huawei.com>
 <20240627081209.3511918-4-ruanjinjie@huawei.com>
 <202406270958.D73912B@keescook>
 <4030b9dd-0156-4fa6-9c1f-caa6a079b5e5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4030b9dd-0156-4fa6-9c1f-caa6a079b5e5@sirena.org.uk>

On Thu, Jun 27, 2024 at 06:15:36PM +0100, Mark Brown wrote:
> On Thu, Jun 27, 2024 at 10:01:11AM -0700, Kees Cook wrote:
> 
> > I've really struggled to get MTE working with qemu, so likely real
> > hardware would be needed for that... I'm hoping the ARM folks have
> > access to something that would work well for this. :)
> 
> What issues have you been running into?

It was so slow to emulate that I couldn't finish booting.

However, looking at my qemu scripts, it seems I may have solved this at
some point. I remembered wrong! I can test MTE. :P

This is what I'm using currently:

        -cpu max,pauth-impdef=on \
        -machine virtualization=true \
        -machine virt,gic-version=max,mte=on \

It seems PAC was the issue. Using "pauth-impdef=on" solved it. "The
architected QARMA5 and QARMA3 algorithms have good cryptographic
properties, but can be quite slow to emulate."
https://qemu-project.gitlab.io/qemu/system/arm/cpu-features.html

I will go test MTE with this series...

-- 
Kees Cook

