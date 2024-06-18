Return-Path: <linux-kernel+bounces-218964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085BE90C83A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D28F1C20D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE501586F3;
	Tue, 18 Jun 2024 09:42:11 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9215749D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703731; cv=none; b=U3hbLvDkdouXM1mKun1kO73y0DKkGItvqFbdijQkY42X1bNTuqyu5tSVMq8GQFVeRm4V8Rt1WJxzedeEVSMTzLy0nS4L428YajVS46XeIK+5xpdsu855mF459U6ac6WwjAscRODEzpSiVOlUzc4ALHR5fc5BYbpnybbzU/97YpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703731; c=relaxed/simple;
	bh=9wlo1aXqpgX1hYeokbAe0Fon4O9lcRzOuMRt7/9KFOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blY7Cn45mUj/y9YTfeSxy7TYk32tQ4Jw5wi7S1LCcWKcGdm7yFgMmBIBOtW+Ef4C8QhYDZ8r1a73+M6QCTRSZmgqaJ8y05UKXjTwnr9ZWk25y0+xCt8xVxBATnMcRanbB6veXPj9lV00e3I1vjG6fq0c+v2bXwtqwiQdiR24VF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1718703621t9im95qb
X-QQ-Originating-IP: j0bcr4tl1DrbKiAFzsSZfOa5k3gTatx80tph8xjFz5E=
Received: from HX01040082.powercore.com.cn ( [14.19.141.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Jun 2024 17:40:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16779118222086163285
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: segher@kernel.crashing.org
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	masahiroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
Date: Tue, 18 Jun 2024 17:40:11 +0800
Message-Id: <20240618094011.19247-1-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617161336.GM19790@gate.crashing.org>
References: <20240617161336.GM19790@gate.crashing.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

Hi Segher Boessenkool,=0D
=0D
Segher Boessenkool <segher@kernel.crashing.org> writes:=0D
> Hi!=0D
> =0D
> On Mon, Jun 17, 2024 at 10:35:09AM +0800, Jinglin Wen wrote:=0D
> > +	cmplwi	cr0,r4,0	/* runtime base addr is zero */=0D
> =0D
> Just write=0D
>    cmpwi r4,0=0D
> =0D
> cr0 is the default, also implicit in many other instructions, please=0D
> don't clutter the source code.  All the extra stuff makes you miss the=0D
> things that do matter!=0D
> =0D
> The "l" is unnecessary, you only care about equality here after all.=0D
> =0D
> Should it not be cmpdi here, though?=0D
> =0D
> =0D
> Segher=0D
=0D
Thank you very much for your suggestion. I will use cmpd directly from now =
on. =0D
The specific code is as follows:=0D
=0D
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S=
=0D
index 4690c219bfa4..751181dfb897 100644=0D
--- a/arch/powerpc/kernel/head_64.S=0D
+++ b/arch/powerpc/kernel/head_64.S=0D
@@ -647,8 +647,9 @@ __after_prom_start:=0D
  * Note: This process overwrites the OF exception vectors.=0D
  */=0D
        LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)=0D
-       mr.     r4,r26                  /* In some cases the loader may  */=
=0D
-       beq     9f                      /* have already put us at zero */=0D
+       mr      r4,r26                  /* Load the virtual source address =
into r4 */=0D
+       cmpd    r3,r4           /* Check if source =3D=3D dest */=0D
+       beq     9f                      /* If so skip the copy  */=0D
        li      r6,0x100                /* Start offset, the first 0x100 */=
=0D
                                        /* bytes were copied earlier.    */=
 =0D
=0D
Thanks,=0D
=0D
Jinglin Wen=0D

