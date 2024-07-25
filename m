Return-Path: <linux-kernel+bounces-262668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A9B93CA50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75910B21527
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6D1422D4;
	Thu, 25 Jul 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LmtSBC+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2471C6BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943726; cv=none; b=Evo+FjuwF/KFN4vteTxix4SQfUubC+kc7voy+JfobzSP1Ba12E3aHRM9Fv7hKDyZFYdEtJfSOUapzpjRA+3U0j2/F7eaJb4n7XNyFRU4eunL877DdtH6Csayc8cOVpVKSxUSh7Wb6vth31rpnatFIHFgGggUWCgx6MxWdqVJp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943726; c=relaxed/simple;
	bh=ArzQvm31q9Gr4IJnPOClGVVQj2eDZGE2jsPBDT2b/NY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sGH/bz0RuBg6mg2vAJREgs/96qPIo31IDPCpv+pWdfGFahYXr3UN4SIEzo7Ij1VsvrxxHHaJe7rirBlDyeaNI0ujIgsciKR5QrMK/eOxG1c6cOhd42BeTjCUvAfdcPAZHlpMAj2Z6MoHo88K8tvFKFk+39KV2qPeUkL95t1RR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LmtSBC+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F84BC116B1;
	Thu, 25 Jul 2024 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721943725;
	bh=ArzQvm31q9Gr4IJnPOClGVVQj2eDZGE2jsPBDT2b/NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmtSBC+0kch3KH03KKaZRX6H7uz0gE4PI0+W99zFV0yJ9pFyv6y4RaE6Bgw6/jWE/
	 FdCWjNTccYmk7i6qVZdkO+I/W45t6TFpGCI1Equ4PDQdLoF58mpEpUPIF3+9itN7QQ
	 i10cvuolrgmccFpR+tgVtrYjwhytc3fHrobazaBg=
Date: Thu, 25 Jul 2024 14:42:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 0/5] This patchset reorganizes page_counter
 structures which helps to make
Message-Id: <20240725144204.7e2d8a14bb62960dcee4cf76@linux-foundation.org>
In-Reply-To: <ZqFmu9qmRiVJfRg3@google.com>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
	<ZqFmu9qmRiVJfRg3@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 20:40:27 +0000 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> Ooops, there was a formatting error in the cover letter, my apologies.
> 
> Here is a fixed version:

Yes, the [0/n] is pretty screwy and I'm hitting some rejects against
the latest patchpile.  Can we please have a v2 against latest
mm-unstable, which I expect to push out a few hours from now?  Thanks.

