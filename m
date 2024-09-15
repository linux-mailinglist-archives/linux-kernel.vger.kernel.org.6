Return-Path: <linux-kernel+bounces-329684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804DA9794B2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D73F1F220DD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783E182C3;
	Sun, 15 Sep 2024 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="pcJw0O0n"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823417991
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726380496; cv=none; b=YLMRbSpuVpNGPN+J6aa456h7hczkICYqti4d9uXJSVeposEH53QiT/JYAmnkH82zb8aMt/UdyvNGVM7HUHT0SQW6TLfoCJFRf30uSc+XS3zilXR8ZRihq06ijsLtnhLF2mmJ6XyTTcBMXEe8jWBUsyOphzRCOABcxrM1OcHRHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726380496; c=relaxed/simple;
	bh=znVqT6GCzYVJuY7ELeDSV7O5N8U5p0AKotjL0wSNki8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJXYjuvb/nNs19GoNLynMbhOKJKkDaEJJ9/T110b1ihBJH3pCfszYyC41VY9faq9PsyDBSO+rO1+lIeGCMWNz810Xr90LsowAaQCtrz+ZIrgUnDOthfwHoocIJ4zkz5IagqlAfQbgFG8AqKbshZ8rAg/m4odJ8oR7wdOa5XirkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=pcJw0O0n; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1726380491; bh=znVqT6GCzYVJuY7ELeDSV7O5N8U5p0AKotjL0wSNki8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcJw0O0noBzSrW3k9hoSSFSb76ZMI+3DG5PRxDQsrxuS7yvAUIQVQ0sloaK+js2PY
	 LDVwd1SK9lhPyoSFHfyKnsV8Fb8mZCYl+rFKNhRWR62aNrS0aQM2s+7gHbM5QAtO70
	 us2evpIiRG68V3zF44YXMjHTKgIVUofIuFCYIb64=
Date: Sun, 15 Sep 2024 08:08:10 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Wen Yang <wen.yang@linux.dev>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sysctl: encode the min/max values directly in the
 table entry
Message-ID: <ec28176d-5ed4-4635-932d-bbc4c1cf6bd7@t-8ch.de>
References: <cover.1726365007.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726365007.git.wen.yang@linux.dev>

Hi,

On 2024-09-15 10:08:26+0000, Wen Yang wrote:
> Many modules use these additional static/global variables (such as
> two_five_five, n_65535, ue_int_max, etc.) in the boundary checking of
> sysctl, and they are read-only and never changed.
> 
> Eric points out: "by turning .extra1 and .extra2 into longs instead of
> keeping them as pointers and needing constants to be pointed at somewhere
> .. The only people I can see who find a significant benefit by
> consolidating all of the constants into one place are people who know how
> to stomp kernel memory."
> 
> This patch series achieves direct encoding values in table entries and still
> maintains compatibility with existing extra1/extra2 pointers.
> Afterwards, we can remove these unnecessary static variables progressively and
> also gradually kill the shared const array.

As this is already v3 it would be nice to have a series changelog and
links to previous revisions.

> 
> Wen Yang (5):
>   sysctl: add helper functions to extract table->extra1/extra2
>   sysctl: support encoding values directly in the table entry
>   sysctl: add KUnit test code to check for encoding  min/max in table
>     entries
>   sysctl: delete mmap_rnd_bits_{min/max} and
>     mmap_rnd_compat_bits_{min/max} to save 16 bytes
>   sysctl: delete six_hundred_forty_kb to save 4 bytes
> 
>  fs/proc/proc_sysctl.c  |  29 +-
>  include/linux/mm.h     |   4 -
>  include/linux/sysctl.h |  95 ++++++-
>  kernel/sysctl-test.c   | 581 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl.c        |  45 ++--
>  mm/mmap.c              |   4 -
>  6 files changed, 708 insertions(+), 50 deletions(-)
> 
> -- 
> 2.25.1
> 

