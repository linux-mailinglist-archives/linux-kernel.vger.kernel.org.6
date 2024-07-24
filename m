Return-Path: <linux-kernel+bounces-260486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8F93AA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D76B22932
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8F2CAB;
	Wed, 24 Jul 2024 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OSHv8Grq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866C28F7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779754; cv=none; b=K8Mn6UeoVrH5SEfk1CyNKrV/YIIOdaozMszApOBRzQvfg2PGyG3Mvb0rqXzAFmz6lDaFpRan67De8wMvZBfYMu8ytWnZcNaSc/YR9l9h0my4kzXOVBhFVyGz+w4DRM++t6xheo26AdkU5xFjVapdDIlMH8mxEeVTdM9RNB2TvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779754; c=relaxed/simple;
	bh=FTVVSpZk7VQoPlV50fSkq47XODk5/K3NfAmbZNp4/Pw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KS4KoP9lBQSsZSwKJuKQCYpaFxNQiUzQQ5616DSu9Yz2AsozqvX3+mYvp8ow7z+yBSpF0I+v8TnzBq8f47aUobP8+K5uJ+XlGGhd3Dt7teTPpFreh0+1MTYZZJ3S8ebHw+Ibq0Md7iDE50byOCqZmnQ0HCs4ItTLkEdwrsVexmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OSHv8Grq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D16C4AF0A;
	Wed, 24 Jul 2024 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721779754;
	bh=FTVVSpZk7VQoPlV50fSkq47XODk5/K3NfAmbZNp4/Pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OSHv8Grq83NHqLdImqmyr9oVCjKtVJCSDJgZuaaaxVRnznRa5hdFZfxSWOpUZ/6Es
	 ZRe6pbJhm54VbdLQagrVB/HXuJb7NMM2br8zxUmmcL56Q46QiuR5IO8tc3vYi5xSfJ
	 bM8GwDLxqhJb5ee11k0j+oYvGwRkwyqcg4aaBdNE=
Date: Tue, 23 Jul 2024 17:09:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, jpoimboe@kernel.org,
 kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com,
 cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com,
 willy@infradead.org, vbabka@suse.cz, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
Message-Id: <20240723170913.07bfd0ba8a2557285263912e@linux-foundation.org>
In-Reply-To: <ud5csdd23fjb2gin4uuxsocm4hvsy22bk4plfjv5zvqd2egqri@hpavorxrrprw>
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
	<2fbbxcsjs7vtzpb6a5wudbppcr2wgc2xwdw3cgs6ejzx6rioze@z2sct6rbulng>
	<CA+CK2bB4RELLHExbkL444ArTtUnqiYVYKJ1rLQGarLyenY6WxQ@mail.gmail.com>
	<ud5csdd23fjb2gin4uuxsocm4hvsy22bk4plfjv5zvqd2egqri@hpavorxrrprw>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 15:04:40 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> > > Any specific reason to add this function in header?
> > 
> > For performance reasons to keep it inlined into stack_not_used() which
> > is also defined as inline function in this header.
> > 
> 
> Is this really that performance critical?

Nope.  stack_not_used() is for CONFIG_DEBUG_STACK_USAGE and
stack_not_used() is slow.

I suggest that stack_not_used() (and hence kstack_histogram()) be
uninlined.  This can be a followup patch.

