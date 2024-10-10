Return-Path: <linux-kernel+bounces-358931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B82998577
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9021E282648
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8081C32E7;
	Thu, 10 Oct 2024 12:02:33 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2B18FDBE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561753; cv=none; b=SWCcfkye5DsTWkE/dvrBGP6ZYratda7vi8W7i4YkPdG7vIdLwuFSoACnVtGbnKwhM/nh5gJieiZqSPEAHnGYab5naoOzZhtaQyhwRgQGw4MX8PGwJKll3+rpp75oXNkm8LYwtCqJGaD2SsLOflwmV252ZRS9PIIqMgzSYXNi7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561753; c=relaxed/simple;
	bh=wX/k0vEBEf86s8flFnE2Uh3DfGe8zM7GmQlxkkwkt0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhNphnt0R0ai0W7K38tm/aLs/9x9jYyjMD8kmIBwVLF028sZEUv3lNDzXgKQT7qM8AHLdPMxL1fWA70jYjbOHOa2ROzvmKbq0fn2B/6ehmdyLoN8Z2Uu7n29pJlkCsmh3x0bCw+J3S39+ksi3bIDrUdw2FsgJCjkLrAusEEqXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1syrs3-0008R1-Jg; Thu, 10 Oct 2024 14:02:19 +0200
Date: Thu, 10 Oct 2024 14:02:19 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: Re: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 __nf_unregister_net_hook in v6.12-rc1
Message-ID: <20241010120219.GA30424@breakpoint.cc>
References: <ZweN3SiUk4bK9N7u@ly-workstation>
 <CANn89iKNZ4AZVYfxzhGWnx82T44_7tw5P63-TE0-GUn+sTRkZg@mail.gmail.com>
 <CANn89iKvrv+-yMRwmyb_bjus6sN1hOq+QmOwvpCFU9G0UzkWNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKvrv+-yMRwmyb_bjus6sN1hOq+QmOwvpCFU9G0UzkWNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Oct 10, 2024 at 10:58 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Thu, Oct 10, 2024 at 10:19 AM Lai, Yi <yi1.lai@linux.intel.com> wrote:
> > >
> Florian, Pablo :
> 
> It seems that bpf was able to defer the __nf_unregister_net_hook()
> after exit()/close() time.

Thanks for the analysis, I will send a patch later today.


