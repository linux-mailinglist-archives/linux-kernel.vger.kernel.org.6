Return-Path: <linux-kernel+bounces-329059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE38978CC4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 04:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2611F245BA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 02:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2916D517;
	Sat, 14 Sep 2024 02:24:35 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386A8BEA
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726280675; cv=none; b=IZyLd0+kBJgg9AuPB4rZrhX4uKLdyDVBjFE8vU/FuiMjSKkdNhC+25udlbcfkGpgdTjY7WKICkcxTHBj1KWKiueSzsVYX1hSE563IB2J7gd8AbIzX9LK/JhWnCvew4KzFSn7BsCBqQ2xlIrTW7Nm8GS529ajKhjzud1Hh27FFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726280675; c=relaxed/simple;
	bh=SvjgF0NBdlcX3CwbzkLCjZjAkfZ1075lpWbkTYbIeGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyUoCgvW4Re/3EPdsHElC0nc1vqPp74jFo8fe5OW7MVb8ehJ+GhhazLAjktYWTFoSREKHKf1iuWBObi9byB81eGfpS4im90ZeF7ecNCcGvo8WsYbWK5UWYIPlCLQsp9QtwH8OZj9ChLhnpgdIPJXG+aNx56TnbWj83UEXi7goBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz4t1726280583t45kfja
X-QQ-Originating-IP: zt9s5hnMP9ASfBOErfW6YV8nnU/KKrV7riW77zoyeqY=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 14 Sep 2024 10:23:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2754753639437398407
Date: Sat, 14 Sep 2024 10:22:34 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Subject: Re: [PATCH 1/2] powerpc/entry: convert to common and generic entry
Message-ID: <9B5E7C0A7C4BFBF0+ZuTzanfk7BcYoFas@HX09040029.powercore.com.cn>
References: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
 <fc509bcd-5ca0-4dc2-962e-766a01cbe4fb@csgroup.eu>
 <153FD6B5CE4F97D9+ZuOYDQ-iHIIwJjbh@HX09040029.powercore.com.cn>
 <95ced963-b584-4ccf-ba34-8f2ba99172f4@csgroup.eu>
 <0332BAE1905768B6+ZuPsBvgv0nwmFAjW@HX09040029.powercore.com.cn>
 <854eef54-4779-4233-a958-0c98ae5fcb7e@csgroup.eu>
 <F81D1486B7B82141+ZuQp4YQkAA2cB9Rw@HX09040029.powercore.com.cn>
 <81200b50-eaec-4cfd-9121-f661f3065572@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81200b50-eaec-4cfd-9121-f661f3065572@csgroup.eu>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

On Fri, Sep 13, 2024 at 02:15:40PM +0200, Christophe Leroy wrote:
> 
> 
> Le 13/09/2024 à 14:02, Luming Yu a écrit :
> 
> > > ...
> > > nothing happens after that.
> > reproduced with ppc64_defconfig
> > [    0.818972][    T1] Run /init as init process
> > [    5.851684][  T240] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
> > [    5.851742][  T240] kworker/u33:18 (240) used greatest stack depth: 13584 bytes left
> > [    5.860081][  T232] kworker/u33:16 (232) used greatest stack depth: 13072 bytes left
> > [    5.863145][  T210] kworker/u35:13 (210) used greatest stack depth: 12928 bytes left
> > [    5.865000][    T1] Failed to execute /init (error -8)
> > [    5.868897][    T1] Run /sbin/init as init process
> > [   10.891673][  T315] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
> > [   10.894036][    T1] Starting init: /sbin/init exists but couldn't execute it (error -8)
> > [   10.901455][    T1] Run /etc/init as init process
> > [   10.903154][    T1] Run /bin/init as init process
> > [   10.904747][    T1] Run /bin/sh as init process
> > [   15.931679][  T367] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
> > [   15.934689][    T1] Starting init: /bin/sh exists but couldn't execute it (error -8)
> 
> That's something different, this is because you built a big-endian kernel
> and you are trying to run a little-endian userspace.
okay
> 
> Does it work with ppc64le_defconfig ?
make ppc64le_defconfig

yes, it builds && boots just fine.
the host is a p8 powernv system , the qemu command line is as below:
qemu-system-ppc64 -m 64g -smp 16,cores=4,threads=4 --enable-kvm  -nographic -net nic -net tap,ifname=tap0,script=/etc/qemu-ifup-nat,downscript=/etc/qemu-ifdown-nat  Downloads/Fedora-Cloud-Base-38-1.6.ppc64le.qcow2

I will try other test configures as well.
> 
> On my side there is absolutely nothing happening after the last line, the
> screen remains steady.
> 
> 
> Christophe
> 


