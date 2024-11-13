Return-Path: <linux-kernel+bounces-407228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A119C6A82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AB8284608
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C095189F47;
	Wed, 13 Nov 2024 08:23:03 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A4170A03
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486183; cv=none; b=G6ZKznkROC0MUk9goHHJtwYFuPU5yNASUdsbq7X2Pxv0O9lTiPoHjGYc300o3U5ogEg9shaQNTN26FkGXwkFEhVcFteXg5r/aSHI4xmuCEPAJQGDglqn/OZEfJi0mzMz8A8BL5XmA+fYLjgVfV2yYtPA9y3l9ZE5Ba+xq78PkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486183; c=relaxed/simple;
	bh=JGnaDC3n0Q32HCqEjT/hs/7xsPZHIu+1h1w/2+mbhRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzy6j/cRZclEYx/zbeSyMNuhg5LeAa1JUWvOONAnB5RsjXsoVXXalV3EUAKc2dbLznG1ngp0CjebRyKGHcba+J6TzZk+E+9zJ6+mzr2L0OkVFIzg+/V5pZX5q+hTS388ifoUULNUyRFrcsdhZTfYdayJ2kxapXcdg0jcul6djD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz6t1731486021t4397o8
X-QQ-Originating-IP: AoCBNTqGjiCgwOMShPwU/XfcQ+AXxg4rXlYGy1H+O7I=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Nov 2024 16:20:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12408500961849753920
Date: Wed, 13 Nov 2024 16:19:56 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Subject: Re: [PATCH v2 8/8] powerpc/entry: fix ppc syscall entry issues for
 common entry
Message-ID: <E6A78B539A22183F+ZzRhLPuA7m_YcuvV@HX09040029.powercore.com.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
 <AD7BF1A62C0AD367+20241111031934.1579-16-luming.yu@shingroup.cn>
 <87y11nlijn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y11nlijn.ffs@tglx>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OFWsfmE1GYcuy2IuR7ksmSVzWzYgbVw2UCnlizslW2/chO8jj9MvaXHQ
	2g1E/kv9qmVLT+O/yGAjzuvSxV24Q6e9x2/jT4eIRDhUQWsiRGHOq6zzCt0vr8IEnxxk88H
	MEYwchXsvRQxJJtbjM9Bba4lmAz41xqeGpfxBTGrRM1ov1YuGfMktbHgej9LugkaQjmWoBl
	acbbTXkj6LU4fiw4tCHDPdc7ndik8u2gVkQH2B3IvMym0yHS7z72m/+6ewhGsr/VFFmso/P
	m1hoQ2heplen58LkNkcAo2/je7oMhXe05gjt0NqPx9PdxqhprHF+wl3Qbdo+cD9KVSxnb9S
	D7zXBKNOTRchs14H9LIrhxjUx/iZKwwKSXLy43v93YcH49Uou3yNh03Mq5j52QfIR7kStjK
	FLU6N64o4NnyDV7EOGALwY7emN/tFRwL3X1Uq8KAzVD//uTXxWK/36/yRkXD/eeXauv2+LB
	sDbcD101L4ENU8T7+aF+rQ3V26Qq3HwQmXnrfauXg4pZLybmCweoMMnCy5ScKB80PBOmGa/
	15GcvDOy9eatPWKTLCpp02/GBkaIcj0M0z5B+B+uqcT2ElbJ/TFFjxQiMjkSmPvU4R2sqN/
	kRN7na8w/S2k7Dj25TMi0BsQ2QgHcfGSP62SR2RkBppZ/WTo2zaAYNczL18n2CQzKSbyuBK
	ogUF10ohc1MPtwvPpdo/P/m82kCNxFBs6/+9RqOgvfRNmAmhWvygv25G4hUEERN/KBvExR1
	y8q6hBdzlTl/vPUAvI/HaDD6ZWH17ttW80YMHQyNeQNee5KGlaA2OxY/W9BNJSdUGHjSCkx
	4GJy2hgO5Ef66AncQSmJr8p0/NW76ZzGowtdkHdpOPIdxtTrCT7KuKFZDSRtvNSaKAmQ5Y3
	Bt1l9JGiM6T35ypt62SV6NJa3Eoh9regCHguvdNeTExTvKZhkw7v/xKYxrPqQpJQTIC23kn
	bKeI42ehZ72zPw8dztFoDSNJV
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Wed, Nov 13, 2024 at 08:06:04AM +0100, Thomas Gleixner wrote:
> On Mon, Nov 11 2024 at 11:19, Luming Yu wrote:
> > Due to the common layer and internal calls details are hidden from
> > the top level at the call side in ppc arch code, there are some
> > difficulties in preserving
> > all semantics implications of the original code in the patch. e.g  when
> > we got -1 returned
> > from syscall_enter_from_user_mode, without touching common code, we have
> > to do
> > our own inference to recover the reasonable route to return, in order to
> > have correct errno
> > and syscall work behaviors,that are tested in seccomp_bpf 98 test
> > cases.
> 
> This indicates that your conversion to the common code is broken to
> begin with. Which is not surprising given the amount of issues I found
> already.
> 
> You need to sit down an come up with a proper conversion design and not
> just randomly replace things and then hack around the fallout later on.
> 
> If that requires changes to the core code, then they have to be designed
> up front and implemented in a way which does not affect existing users.
> 
> Thanks,
> 
>         tglx
Thanks for your time and the review comments. It is helpful.
The 3rd ver of the patch set should be able to address all these issues.
Going through v0 to v2, I think I've truely understood how came ppc64 that is stuck
in the halfway to be able to enjoy least code duplication while having fully function on top
of common entry code for so many key features. 
when the v1 is out, it is already too late to call back and the v2 was reluctantly out with
a random fix instead of clean conversion as you concluded just for making the hack working
as it was.  : -( 
> 
> 
> 


