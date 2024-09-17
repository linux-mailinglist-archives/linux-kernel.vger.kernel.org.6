Return-Path: <linux-kernel+bounces-331713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2A697B062
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C3AB230FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7C175D27;
	Tue, 17 Sep 2024 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU7l39nX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5716B38B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577525; cv=none; b=VVUrZaOFMlz5obii3Jbh6OpMi3ErClQJ2EyaahWbtIrKfwU+2TzQtjQn/ritb7k06/UZcEWv/8izC6sjSkLvoqurXsd4cueGZq4v8hVx0Cewc0UKPMg53WTZN+EaXCBOO6T8/0KCSfScME4Vp62Mqf8mU7sy4VmZA4NnDgsUPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577525; c=relaxed/simple;
	bh=q+G8igdOUq3tqLsUf5U+O4Nb1JvXMT2uFPeu7Xyy6ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q67TqIKQGW//7TZdNkNfVVJhggSnLcFAyVjhs4Ahgn8rOo08Uf26NXf9slmxNnWmZbm+GdtllHVdJs0Q5mtwALs8RXp5LP5aBl/O+YDi1v1ocizw3aoCMqEETPBNXeIoMvpTd3+L9GHQ69ZyLSEf6AAzhesC+s60n2VFs/3agpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU7l39nX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726577522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj6D4JWAWCa+K8vQuk1yo6gI/nZb1Gt2a2F+27DHbOc=;
	b=gU7l39nXUi3emmFBqNZVUyB3iI15Zb2bSuobFxjrDAt/MyNPtK4xpcSHXzEFWXBGd40PEa
	mXxSu9PLxIrkJMye+kWCn1bgqLI7wZKHItTlzEpmeRo6ThNciB1DOPZ1Ku2UNN6cCbXbEH
	42ghE5PVTDeARr4LYVCVA3FN+X09yJM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-zmhLdzkwM9mbYl9vNSnpOw-1; Tue,
 17 Sep 2024 08:52:01 -0400
X-MC-Unique: zmhLdzkwM9mbYl9vNSnpOw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C983D1953963;
	Tue, 17 Sep 2024 12:51:54 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAC8B19560A3;
	Tue, 17 Sep 2024 12:51:45 +0000 (UTC)
Date: Tue, 17 Sep 2024 14:51:41 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	WANG Xuerui <git@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Yangyu Chen <cyy@cyyself.name>,
	Han Gao <gaohan@iscas.ac.cn>, linux-kernel@vger.kernel.org,
	rsworktech@outlook.com
Subject: Re: [RFC] riscv/entry: issue about a0/orig_a0 register and ENOSYS
Message-ID: <20240917125141.GA14463@asgard.redhat.com>
References: <59505464-c84a-403d-972f-d4b2055eeaac@gmail.com>
 <84ae492a-1995-4fa1-9d3c-78c5bbf9ff71@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ae492a-1995-4fa1-9d3c-78c5bbf9ff71@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Sep 17, 2024 at 01:59:23PM +0800, Celeste Liu wrote:
> On 2024-09-17 12:09, Celeste Liu wrote:
> [...]
> > Unfortunately, struct user_regs_struct is defined as below:
> > 
> >         struct user_regs_struct {
> >                 unsigned long pc;
> >         ...
> >                 unsigned long t6;
> >         };
> > 
> > It doesn't contain something like reserved[] as padding to leave the
> > space to add more registers from struct pt_regs!
> > The loongarch do the right thing as below:
> > 
> >         struct user_pt_regs {
> >                 /* Main processor registers. */
> >                 unsigned long regs[32];
> >         ...
> >                 unsigned long reserved[10];
> >         } __attribute__((aligned(8)));
> > 
> > RISC-V can't include orig_a0 in user_regs_struct without breaking UABI.
> > 
> > Need a discussion to decide to use which solution, or is there any
> > other better solution?

As another data point, AArch64 has NT_ARM_SYSTEM_CALL (introduced
in v3.19-rc1~59^2~16[3]) for the purposes of syscall number tampering.

> > [1]: https://github.com/strace/strace/issues/315
> > [2]: https://lore.kernel.org/linux-riscv/20240627071422.GA2626@altlinux.org/

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=766a85d7bc5d7f1ddd6de28bdb844eae45ec63b0


