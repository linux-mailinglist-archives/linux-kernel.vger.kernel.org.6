Return-Path: <linux-kernel+bounces-359489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83721998C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380C81F22F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAFF1C1AD1;
	Thu, 10 Oct 2024 15:49:51 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014121917C0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575390; cv=none; b=lfE+3jx4gaxzw2d+ivzdDk8CeA+EQarcXXnhSQzHYdU3QJ2SRItz01/EPFnTu40pqcO+z6PVB7PAeDtSjeX1Wvn2XfXerujhLRJVKeR1Ae+CMnv7ponDU0CBvoetUfs0zXiZkS0bdRaJsu3vV21f6GouBSeY89k4dJ86vWdcQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575390; c=relaxed/simple;
	bh=vv//5ekSEcWr5P3Sp+lQmrBP0oOlGOyYRdbA6C87hfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPic4Ro+gXypdPOb1zeNcKajEYbkeej7azVLPmj7X8WCDBV/9CIAWn3QCngGI737iImInJNhglg3lwYg/XeLEfesVMxxzr/W1e0aQ0I36v3zqaO52OKeerVh5akU4Bx4vRvxPZHPKV+bslouNdYMo/qyGjh3/YY2eqwBxyheZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1syvQ1-0002HR-RT; Thu, 10 Oct 2024 17:49:37 +0200
Date: Thu, 10 Oct 2024 17:49:37 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, "Lai, Yi" <yi1.lai@linux.intel.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: Re: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 __nf_unregister_net_hook in v6.12-rc1
Message-ID: <20241010154937.GA8322@breakpoint.cc>
References: <ZweN3SiUk4bK9N7u@ly-workstation>
 <CANn89iKNZ4AZVYfxzhGWnx82T44_7tw5P63-TE0-GUn+sTRkZg@mail.gmail.com>
 <CANn89iKvrv+-yMRwmyb_bjus6sN1hOq+QmOwvpCFU9G0UzkWNw@mail.gmail.com>
 <20241010120219.GA30424@breakpoint.cc>
 <CANn89iK0a_h2KdGekLdvYKrxOyzwW=L2u33QscDBKH1zKwTdQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK0a_h2KdGekLdvYKrxOyzwW=L2u33QscDBKH1zKwTdQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Oct 10, 2024 at 2:02 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Eric Dumazet <edumazet@google.com> wrote:
> > > On Thu, Oct 10, 2024 at 10:58 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Thu, Oct 10, 2024 at 10:19 AM Lai, Yi <yi1.lai@linux.intel.com> wrote:
> > > > >
> > > Florian, Pablo :
> > >
> > > It seems that bpf was able to defer the __nf_unregister_net_hook()
> > > after exit()/close() time.
> >
> > Thanks for the analysis, I will send a patch later today.
> 
> Wow, this was fast, thanks Florian !

I spoke too soon, I cannot get the rerpdocuer to work, it fails with:

bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_NETFILTER, insn_cnt=4, insns=0x20000200, license="syzkaller", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_NETFILTER, prog_btf_fd=-1, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 144) = -1 EINVAL (Invalid argument)
bpf(BPF_LINK_CREATE, {link_create={prog_fd=-1, target_fd=0, attach_type=BPF_NETFILTER, flags=0}, ...}, 64) = -1 EBADF (Bad file descriptor)
...
Killed
uname -a
Linux virtme-ng 6.12.0-rc1-kvm-virtme #1 SMP PREEMPT_DYNAMIC Thu Oct 10 17:25:40 CEST 2024 x86_64 GNU/Linux

... with vng --build --config kconfig_origin on
9852d85ec9d492ebef56dc5f229416c925758edc (== 6.12.0-rc1).

As Erics analysis looks correct to me I will send a patch anyway, but I
can't say if it resolves the problem or not.

