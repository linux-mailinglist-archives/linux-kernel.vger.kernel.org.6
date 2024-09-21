Return-Path: <linux-kernel+bounces-334778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C29297DC08
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028CDB2127D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 07:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C314A152E02;
	Sat, 21 Sep 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="H4r+FQlq";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="F6f3KcUf"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F415E97
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726905191; cv=pass; b=OlTsiY3FMfuMQvFugXxMa8wVViWzGCBlNF3ZCPr5ny6CVSIQvRAcYmCldTE7DpK2qAkq9Mi+N1buGsaDT+PSWXqNehw7f4CIpeUcYdbM8nvDR3gg9AWAM+546qTQhpemmYj/N8dfyooKLoChqnpydlb9EAUs7QiUvRpwoU6biV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726905191; c=relaxed/simple;
	bh=ip2ELNjQq4klO/iCr0mW+NpzmFxHWrJi5cOzCaGdG1U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CxPOSlUyzAswLNUVp5IL9adh9E48MzDEuNqFMl5jZulCNhdWP8XXsoxAVQdOXqRj+3LX13Juih35K+dVywd6hQxNj2g0GKrXuWPz6AJiAjx2Cn8lvbQbsyBYqFbIZd+MwYkWAH1kEnS6g88FsGYRUGIe8uNqbDcmhiscrQzhtqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=H4r+FQlq; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=F6f3KcUf; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1726904826; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tA5C4sR6/p/2xLmQzyIx/9080eklDLXhpIdYtjavuRariA+rlATtDhrChpbfHTTYmF
    X4vnbmzz9A09XKLkYWDwTLUrx8jbzs+/2PDYfHOks3V4nY6d9uE76GX17OWEHfXHIXMX
    nR2ypl30eHbcFU/BktE5EGTNpZt2LbSQiaLrbab3TlMMOMgeyKemMUEbhHXnb+xcgHZj
    MpfneGGCuKP+hx2PTRQGuHCZXcfUuwtDXe9w33QMc9TTdVaPV4tPlb6ZDV2Nem7rItN+
    f5cmDzKPzMZfL0YTNHRsH62vy5X54b+ErjNYm7phRIwcxWTPBbNlXjIUxwHZOa6pTRcn
    ACCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1726904826;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UX6oax5JNv0f4YrefZ/CLdZTH+8SxXkpF1uGuXRjE60=;
    b=CxdUoBOD3KhVEVOUrzpqV0g8hxqGBOv69X8V/Iz2GI75KjE2g/+fRcZxvFi4MG0EOV
    McYyHwstoJfD+Z4EMr5zPtRBrqdL5l7KLFp4XGW9XkIUmn+xMmHdDpzftgiiI2W7hCBO
    YeeFIDHSqczdb9c9Juef0GBwgFbj0KY7HJ2ngDdjWdLS/XkNDyVQQ+LnSA2UDfSPu2y/
    aYn/Vwzsy6aCJg85f+tYhmSOAMx/FPPPOFscmmCrawSe9ONDY4hEZ56DEVtL2VeqyVE+
    4tnubQN4VOU4alMFtTKS1Kx89e0FpsxZZaCIIbN6++iwe35WK5OCyw7VPRw1UE626rN+
    aduQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1726904826;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UX6oax5JNv0f4YrefZ/CLdZTH+8SxXkpF1uGuXRjE60=;
    b=H4r+FQlqcir3ZPpK395lhIEGzfMss5Pvn0yynrBDej9OthbGbOSZo8Xs8/QmmeW1iV
    ctUHvWJs/Kh2JBLv/roXdHB5HLnKHqb+Tt1puTaV2F26WUtqj4KLM09nMoe8Z5XgEWxC
    ASBC8HATD/CVPOty41O9kms0/NUic9bzM8zSDu2L9uZRnBD/AB4+e4z+E89Vq4wPSpMH
    BGLhNEaMdw8DkXiDlRYKJl187xVQNaW3V0loxTro1bzSwGFCQyAaN0GHD6IeoCE8bUSi
    P3AgA1n0Gh+n+nzd9OzCdZ9CaTbn3B3i9a93NlUsjIdPsY6oz3osGRm9oY7Pqp/CKg/1
    WEow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1726904826;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UX6oax5JNv0f4YrefZ/CLdZTH+8SxXkpF1uGuXRjE60=;
    b=F6f3KcUfnXx68RHsHehldiIaWNutml+8+RLZ76cbwv8zFcJoAYbQzfDTpwA1iCB+Qh
    kj8wMAWA0lZhRigTRABg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7VpngsyrDDn7tV8xuJ2lZeftchKhvJvsCocNyYw=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id e0da1a08L7l51aY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 21 Sep 2024 09:47:05 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] powerpc/vdso32: Fix use of crtsavres for PPC64
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <aded2b257018fe654db759fdfa4ab1a0b5426b1b.1726772140.git.christophe.leroy@csgroup.eu>
Date: Sat, 21 Sep 2024 09:46:54 +0200
Cc: Jason A Donenfeld <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Trevor Dickinson <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>
Message-Id: <A9FC02B9-A15D-4A75-872F-BC85248A1BBB@xenosoft.de>
References: <aded2b257018fe654db759fdfa4ab1a0b5426b1b.1726772140.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Mailer: iPhone Mail (22A3354)

On 19. Sep 2024, at 20:56, Christophe Leroy <christophe.leroy@csgroup.eu> wr=
ote:

=EF=BB=BFcrtsavres.S content is encloded by a #ifndef CONFIG_PPC64

To be used on VDSO32 on PPC64 it's content must available on PPC64 as
well.

Replace #ifndef CONFIG_PPC64 by #ifndef __powerpc64__ as __powerpc64__
is not set when building VDSO32 on PPC64.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closed: https://lore.kernel.org/linuxppc-dev/047b7503-af0c-4bb0-b12a-2f6b1e4=
61752@csgroup.eu/T/
Fixes: b163596a5b6f ("powerpc/vdso32: Add crtsavres")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
arch/powerpc/lib/crtsavres.S | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index 7e5e1c28e56a..8967903c15e9 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -46,7 +46,7 @@

   .section ".text"

-#ifndef CONFIG_PPC64
+#ifndef __powerpc64__

/* Routines for saving integer registers, called by the compiler.  */
/* Called with r11 pointing to the stack header word of the caller of the */=

--
2.44.0


It works! Thank you.

Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>=


