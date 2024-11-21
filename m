Return-Path: <linux-kernel+bounces-416568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA89D46F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE382830F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4086613BACC;
	Thu, 21 Nov 2024 04:51:15 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4B230986
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164674; cv=none; b=A5z+6AqdS15RxGbLIcZECs08es1O5JpnLOGisN0D3GR0GACGN6WYJgLJET6d++U7uk6z/969FpDABfQL3iKXBzZwtCU15QmpUAgmzD+K1JUbg7awu2EC8mx+bB76cZHIjebgqRkMkxLlJhcuUbRZ48yTE/zyK/5GJGAvzK5Db8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164674; c=relaxed/simple;
	bh=Pf6KvcxT1m0Nlg1/x94Kf5QlbfcW+KzdJS58DSOjQdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7pnn29hXhl5J2U7Gr9npiXHI8HAqZzwWjco1ocyhUfSGyeZauMJ6Fo51sbkKSXm/wFuE2Lz+bduG+Q72b4IyGOW7l4Xr/OW895vOPWReYWE4IwAHDPdCv9dBU4hdgTuAYlPeqeOJf5V6gm7W7Xjq1AFL9dzgmsHGejeKK5Jgpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C4F668BEB; Thu, 21 Nov 2024 05:51:09 +0100 (CET)
Date: Thu, 21 Nov 2024 05:51:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
Message-ID: <20241121045109.GA20615@lst.de>
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com> <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com> <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com> <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com> <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com> <CAJuCfpEBs3R8C910eiaXcSMPPrtbMjFLNYzYdPGJG+gw4WHM8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEBs3R8C910eiaXcSMPPrtbMjFLNYzYdPGJG+gw4WHM8A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 20, 2024 at 08:56:21AM -0800, Suren Baghdasaryan wrote:
> This is interesting. readahead_expand() indeed has
> psi_memstall_enter() without a matching psi_memstall_leave():
> https://elixir.bootlin.com/linux/v6.11.9/source/mm/readahead.c#L727
> and https://elixir.bootlin.com/linux/v6.11.9/source/mm/readahead.c#L754.
> Looks like this was introduced in [1].  I'm not sure if that's a bug
> or psi_memstall_leave() is supposed to be called from somewhere else.
> CC'ing Christoph to clarify.

So the readahead_control structure tracks if psi_memstall_enter has
been called using the _workingset member, and the assumption was
that readahead_expand is only called from aops->readahead so that
read_pages() takes care of the psi_memstall_leave.  This still seems
reasonable given that readahead_expand operates on the ractl structure
only used by ->readahead, and tested fine back then.

Something seems to be going wrong here, though, but the trace below
doesn't really tell me anything about the workload or file system
used, and if this is even calling into readahead.


