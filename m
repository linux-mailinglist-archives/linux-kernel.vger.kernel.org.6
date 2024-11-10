Return-Path: <linux-kernel+bounces-403334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769CC9C344B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1D28159D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 19:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB7977111;
	Sun, 10 Nov 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mxV67elR"
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBD1CA81
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731265524; cv=none; b=kHKwK7+di9inQBFfRNeRC/M2fIFfpK8jddEYy8hdiVQ6ND56Q85seaHIhzvbf/YuqzDBvW/oguVtc8c4eyVftL5yucCEDuZmhfKikwf6cFMbpzwvn8vQcrE6DJDl2REwvkdqAiWACxJyeQDKOZpSNIIlaf+mqkj1BT6V/AMgKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731265524; c=relaxed/simple;
	bh=MaEFS9bus4W6Lu28k4HbgCiUQ4Zh+/UyfhUhzlj7n68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBfGF3RDo7nlzZvOyYFZ8RkYWcMyS4PGlKbzMIVR+0r9hjCnbaX3uE5O/1XDCaSnSKIIA55z7lJUpEZqjnTQS6Wt13flZHV8CM7oz/2adMtJfivzS7TdHgggS7rlbWwjClynXWt3CU+YxVuk4uklg14VDEKEJ2Z0Cxpwsqy2AUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mxV67elR; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xmhjh0vGgzRKW;
	Sun, 10 Nov 2024 19:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731265000;
	bh=Q+LBf0Sv5jwbPqaYWAqayiv7fFnFEnvkioJQxITAAdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxV67elRaNQ31kjFhRw7Oje8v9A4C+1/pe8CUUCkU0VfpGJdiKPlg1Lyt7ErX5499
	 piNSrfgDc6G/ISIE40wmh6Djq5FeoXUdjZpOTDCQz0/mOnj4CBRCMQyO3U8/8Y78XI
	 AW5r4fS48/jJ1Www2hxsv44GXkNQarAf2tabgim8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xmhjg1dn8zWsF;
	Sun, 10 Nov 2024 19:56:39 +0100 (CET)
Date: Sun, 10 Nov 2024 19:56:37 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Burgener <dburgener@linux.microsoft.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] Landlock fix for v6.12-rc7
Message-ID: <20241110.Iek0rephiele@digikod.net>
References: <20241109194158.422529-1-mic@digikod.net>
 <CAHk-=wiUy+ixmBnJuFzTMe4yvxH6fNqu5UG-K=EKZzCAXw8pVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiUy+ixmBnJuFzTMe4yvxH6fNqu5UG-K=EKZzCAXw8pVQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Sat, Nov 09, 2024 at 01:59:39PM -0800, Linus Torvalds wrote:
> On Sat, 9 Nov 2024 at 11:42, Mickaël Salaün <mic@digikod.net> wrote:
> >
> > This PR fixes issues in the Landlock's sandboxer [...]
> 
> There were neither diffstats nor a shortlog in the pull request, so
> honestly, it's not a pull request at all as far as I'm concerned.

Indeed, my git request-pull command was buggy.  Sorry for the trouble,
I'll send a fixed one.

