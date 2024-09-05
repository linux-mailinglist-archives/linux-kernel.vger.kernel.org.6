Return-Path: <linux-kernel+bounces-316984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642CC96D7E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E2E1C2302E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2219AA53;
	Thu,  5 Sep 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Ih+yAQM1"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F91991B1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538182; cv=none; b=IlH9CB2PFFvSuGHW6tuTfdz0sil4xMS2JeRBcO9io2uCscEbJdRujO8XRsapM+FnY4ghTijp4DWeIgmNX5ymIocpWuQVQ4I+GG3gp8/7sJeYNwiU8s/9OyoVSGRWM6gP7r+JmnBIkXGOcb5rVYAEKI+hEiKy0ejW8JvQyd8VjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538182; c=relaxed/simple;
	bh=9xMOOGXA8j/58f3Jw2LSmWZTl9QPCL5BBbMsrpTJn6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RX+3FEqfN15D6yMwUSu/jG214oa9+LEMlkcBHkSBwNZy6wH1iyCIXwkRtDgVa3rfRWxlczmo4gnEEN/BLHOTVATV2gHW29BdroDt5RW/J8MKLSVdiqjOSKeIxJ+hl8LJ2Jsc4VhY4V2n49+jY35B63YtzvmhVfW6mNy2FUfC2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Ih+yAQM1; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1725538180;
	bh=Rc3SdofNHSm0ztQHSD5kFPnnzeRxdv52tEaax1uWW9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ih+yAQM16u93tvaaqocLggQAIZRjV9DJKtuoG2bVaprgaLG0MJihd+ir4tgAyEJSi
	 pMpNDIa54cNFXZMC40BmnOakIO3AVkHySYYQ3Sa0c9dmeACLx5Qt+ltTn7dMumfg4F
	 X14JxUN9sCBf9Qbria7H+wDm/HX6zE11ZUs+LBjA=
Received: from [192.168.124.11] (unknown [113.200.174.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8B8596768E;
	Thu,  5 Sep 2024 08:09:38 -0400 (EDT)
Message-ID: <361bf35ccf308d2fbce14f69f156cb42eef0f095.camel@xry111.site>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and
 _percpu_write()
From: Xi Ruoyao <xry111@xry111.site>
To: Uros Bizjak <ubizjak@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, WANG Xuerui
	 <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 05 Sep 2024 20:09:35 +0800
In-Reply-To: <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com>
References: <20240905065438.802898-1-ubizjak@gmail.com>
	 <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
	 <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 14:02 +0200, Uros Bizjak wrote:
> > If the input value is less than 0xff, then "& 0xff" is meaningless, if
> > the input value is more than 0xff, this conversion still cannot give a
> > correct result for the caller. So I think for all sizes it is enough
> > to just use "((unsigned long) val)".
>=20
> This part is used to force unsigned extension, otherwise the compiler
> will use sign-extension of the possibly signed variable.

It's not relevant.  For example when size is 2 __pcpu_op_##size("stx")
is expanded to stx.h, and stx.h only stores the lower 16 bits of a
register into MEM[r21 + ptr], the high bits are ignored anyway.

Thus we can just have

+#define _percpu_write(size, _pcp, _val)					\
+do {									\
+	if (0) {		                                        \
+		typeof(_pcp) pto_tmp__;					\
+		pto_tmp__ =3D (_val);					\
+		(void)pto_tmp__;					\
+	}								\
+	__asm__ __volatile__(						\
+		__pcpu_op_##size("stx") "%[val], $r21, %[ptr]	\n"	\
+		:							\
+		: [val] "r"(_val), [ptr] "r"(&(_pcp))		\
+		: "memory");						\
+} while (0)

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

