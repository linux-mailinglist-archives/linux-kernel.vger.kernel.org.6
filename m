Return-Path: <linux-kernel+bounces-333808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472497CE63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51A01F21BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820D1420A8;
	Thu, 19 Sep 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="lrqmdcA8"
Received: from sonic307-21.consmr.mail.sg3.yahoo.com (sonic307-21.consmr.mail.sg3.yahoo.com [106.10.241.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63913E02C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726776593; cv=none; b=nlwENEI4GSBbCq9FA2/WT1/Gn0x5g6DRiPLMeW7e/qrV/RuHefcQVICj8qdHAwZ59deLtyqhtZ2sh/3F2vgKqze8jDiMkao77qrPEspZ9mtfbvdLnwqBAZDfI1wrqaUi/VhxI3YqkTGOLF6vLffUhv6btRkXrdTEp0bXoUUzGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726776593; c=relaxed/simple;
	bh=Pi74zlM6TskqmQKMczXJ6slU66dgyShWd9GfcMh0Lxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1NQWvNOKyXe/S3r+Wah6S+KsV8CBE+GYHr0Cuy021Vmi6z7pDYmBy4RVrCL4d7loXYoqNiGGY8ZUyjMC/BQ0n3mqHe5jQHmaKbT4hfVt238Zl26UqS+yUgUsQ8sjSbzYGiofLaL3+bBQNKzZrNFHLis5MSlnHshfXpchsQIlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=lrqmdcA8; arc=none smtp.client-ip=106.10.241.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726776582; bh=fgt6Jz3h8P03c3yvDf7Eht9CMTvveXc1XEEi0rb5bX4=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=lrqmdcA82seuutp+bS8w+UCQei2q2coixiUGqZAyS/SBeBM1JI4UqICmjP+PI4SLdp8E//WewyaxsaVPp+n0QhMfducmvcao9nh6uq8MFxB3jI9W6Gxkck2Vo70b+nmaknZ5Gg+f9FUIWeLkAFMEPUNTITNQLRGmVglGo69eTRJh0k16q1hjVvTtysAdRIpYxlmh8OeK8+3INshOzupCA2kGHt+Oiz97AB5GoxKLJbkgg0UJCO9MzYLdjVpRVOZ3iBPY94dUkZtPTxIK4qOfOoDj585kWzO0uoX3CYEULEsdiPasGrVAQTnBW6a1UxJdTNSTkCNztr5Q8laClHBrqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726776582; bh=d4xkUKZ38DtzqdpolwZg4/q5xDhTxmQsWV32DmLWO2r=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Zvxr4brRHoNoSpQgf4p8oN/w81SoIxtktocjTBNArx8e560Cz78ZeDMFyDPPE8Sv5f58FfxUYhsFyZRcnJ5oT1wzZE2l6Dtuc4cvgL6avEr0Xif0otKsqRnlamKeOkWITT/LPwqZfg4yDpwcDjwhIo3uwIvfpLdumjiPgAFy69vmFDwdxToCoQr/czSLgSIGuJxD8/QFOeCOa4O7VN4c2qX+vZzCMihfEb8HjaH9xc7sZPnxK/oGQqFnZlvDpw5uFf3N0ar0h6hVzMCsL6tDpaBPP9GAqGSmR1Og0vrpoN2rvoI11yOX8XfFwPSMEN7znjMociq9v1Wp0WEzNwx24w==
X-YMail-OSG: sxr1UmgVM1k_WI3SlSeyavCZvxRjez8RxKHMF5WjGCaycoRcWf3KIznBADVMgm3
 INNlvqlSi6k4sA.yr4XHMDp1JSRM_vLqsbHTrCepD3mELAg0E.lboiEA8ZK3dHsfCwl.2gDyx_bw
 q8SvES8Fq5CmH1NJCekHw5tQDiuw8lfuZrtenA_qXqFJgS.0KN3joO1ht.VjRAz8bZelbh23to4V
 ElKa0QuqGyeP1M371G1mM70x2AybqO_BvIm9VnVDKm7w7.HSgSaT74UYVL7YjDoQWw9fHyEHdLKg
 DRMJ0ZkfPLZG05lba2GKKhEM..dgFJTr6mPAp30U6fq4l6YT7KJHZFG0uC0By9svI4B_Xl8gOMS4
 Opy5l_sODdKEI7AOO4v25az33Ml6Z8Azc_fL26JkfptGSfiwxqFsR8iN4mOCMADbWNN6AI_13ODB
 HGYn38V.xTmTL7quODjfEdZoGcyzXtQBWqry4JoK4MIFLJ5lh3Z3RW8axy_FK6RpLV.U0ExoRSVK
 nBxmwQZ_0wjLZgXRCrJpuTZn1dPZnnXpO93L.62GSPMWGvY93YjoN.6wLoPViPwl2d.TiWJ4qNQd
 RFqjP3guCdgVG8vQDEI8pzhVBovUF4aVw0tcdl11id4G4QKBz_5ggBHlQnfz1jj95tvkkpH_syLC
 Q4SuOVajrggl_sjTMLDzGZ9n.E9cT0Ie5ksNEgeUbeuZmr6eyXmYBoD5hrVmIXyWHeyltybF3jF7
 T6C.q2MUa6GBhax.nhWZgI5CJr.k1JXBxpgr4JG5.EHMbL5KsDxa8Vr6Ppy0RY7d4Iik7MbKpjYc
 ASV71N3stBmoijKqnwgy07g1J.2ShRtADYmNQWBtoVsh4DOqHjaLS8f5_vJF1L3gpSq8RxQKv.F9
 P3ezJh.GmhObTRTtq2JJj4yUSLrNhqZljNxA4F5GPgsV6jv.piaYMRnh.fqJbPQBqwXgxWyS89Rj
 4exO0oVT6FPf4nEA1uwEl9K9wyL4G2qM90c2E_SBKEu7Zn7VzbVaG1Kz4YdT95kzn9sAolahNJwO
 acrAiY.670WMW5pZhfBHjFhe.BnQrLANlq9NJdbzM2iARI43zMiJqu4yFigKRBgrvejotoo9CXAu
 wZN0f2EuQPsDbviVvuI__8UlqWqt_To3sLMw6cJgjyyh_6R1TNOKKh0zBORbzqpytNsmCM_rxcWO
 t3vjouZKKEhD1dRSjj1ofv6wBDrQpuP33maf2iDjHlFCloyfHLWalIK2QLNKijPsgfiGqFSrBw3c
 w5fNVAfsKsRUcXaokPgkv8nJcVRssTqpMA1hiRPKwuygsH5zPZKRkZY.hw5OufeVzyqMcGCKom1r
 eN6DDdhuAId6j0edSCvLqWR0712xDRHXUhk8QTj9krZ34oiY_u_4XrCv2xgR42wMjc510Ax0syu8
 VacBkikt2zMae7Pgt7ffVH35JA4lq36S3DWPEGlC747yyTVZQc4PqgnlVgeC.iux945FJFgo1Guy
 hjjqwaHnvF8f6suh_edIU971Kk4eHZsxNLMPyMTw5WWkkcsfekyuqZwMfqtfdWI_4Qk3iKnEQGXD
 UM4BC4Dc_987j8FCzoKyxvot9s5N4jRkorKpBt1QuYddKyeDBrDm9InaRJp7IPskyzEopHvL_Qeg
 AEqWY1XDgXs7uKfxmDQQZuF93kKAbU9q1jv6Zvx4FNsE4uEVeou.oM58EF5Fb4Rp6iGCyumTrhWY
 Tf54IhzMnwZxuReRAi7Endzrc4jSUBlSoJcbwz5_48vmp69cm69xwM4s6J3HfGK8apLSa78WICfc
 cXHZHZSXQiP9K03_OvcCT5_ryV7AJIahWVF7SD72ZN926w6ieE4.B_uOMRmbr54Pmp3goz5mnLdC
 UhG7sxto4hjw6tMckZA8xhBvDEct1ZpEOCpyGT9roXDtWwXqpdiLzixNP8MLjhRrG81XnNW50Upq
 LiaoCe4H2Wq33XRku2mWsFYhnkTn8vWpBV9j8kQIISRl5Wv.IajlSEQ2u_kYXIu5Yk08BZqvReZY
 w2lhgyajY1LyRYC4sliABlI7A1Y_jScc_FcTfCoWb36yBMvN_6G84rxODU43xEKciBLXReATAdG.
 JlXWZT9V2zThf43QUop9ZiDWzhqBWh2tFif1AnWYOs7.0Fc4wSQz131fM6NmJAXq7gRKDtwScSjL
 9aYdu.iZEsSZkRDzySzCwp4tIp5TgAAlIOYB2pAH4p8IOd8o14uFmMtt4QPWKBqeXm9qZ_WaNNb1
 MTRitWLLsKBxxXhI6Q4t8.yseuLkb0qapYfQkATpdEhlFaeXp
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 6b736631-b841-4d5c-b154-087198b0131f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.sg3.yahoo.com with HTTP; Thu, 19 Sep 2024 20:09:42 +0000
Received: by hermes--production-sg3-fc85cddf6-277r8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5ddd3d30f8b6c5a81c235f2023234f7a;
          Thu, 19 Sep 2024 20:09:40 +0000 (UTC)
Date: Fri, 20 Sep 2024 01:39:34 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, shuah@kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: add silent flag to reduce noise
Message-ID: <wvvmrwlr32uk6k6724srds4bw7zxbnqeyzyxt25z2eqp3zt4d7@wepug2fulklv>
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>
 <20240915234131.61962-2-abdul.rahim@myyahoo.com>
 <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Thu, Sep 19, 2024 at 09:40:34AM GMT, Shuah Khan wrote:
> On 9/15/24 17:41, Abdul Rahim wrote:
> > When ALSA is not installed on the users system, the error:
> > 
> > "Package alsa was not found in the pkg-config search path.
> > Perhaps you should add the directory containing `alsa.pc'
> > to the PKG_CONFIG_PATH environment variable
> > Package 'alsa', required by 'virtual:world', not found"
> > 
> 
> extra line?
> 
> > is printed 3 times, which generates unnecessary noise.
> > Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
> > assignment, so the message is printed only once.
> 
> I would say this message is alerting the user that the package is missing.
> Why would you want to delete it?

I agree, but the same message is being printed 3 times

This patch makes it print only *once* !

Here's the output i'm currently seeing:
```
   CC       acct_syscall
 make[3]: Entering directory '/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/alsa'
 Package alsa was not found in the pkg-config search path.
 Perhaps you should add the directory containing `alsa.pc'
 to the PKG_CONFIG_PATH environment variable
 Package 'alsa', required by 'virtual:world', not found
 Package alsa was not found in the pkg-config search path.
 Perhaps you should add the directory containing `alsa.pc'
 to the PKG_CONFIG_PATH environment variable
 Package 'alsa', required by 'virtual:world', not found
 Package alsa was not found in the pkg-config search path.
 Perhaps you should add the directory containing `alsa.pc'
 to the PKG_CONFIG_PATH environment variable
 Package 'alsa', required by 'virtual:world', not found
 gcc  -isystem /mnt/ubuntu/abdul_linux/mainline_dev/usr/include -L/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/alsa -Wl,-rpa      th=./ -D_GNU_SOURCE=  -shared -fPIC conf.c  -lasound -lpthread -o /mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/alsa/libates      t.so
 In file included from conf.c:18:
 alsa-local.h:11:10: fatal error: alsa/asoundlib.h: No such file or directory
    11 | #include <alsa/asoundlib.h>
       |          ^~~~~~~~~~~~~~~~~~
 compilation terminated.
 make[3]: *** [Makefile:24: /mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/alsa/libatest.so] Error 1
 make[3]: Leaving directory '/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/alsa'
 make[3]: Entering directory '/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/amd-pstate'
 make[3]: Nothing to be done for 'all'.
 make[3]: Leaving directory '/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/amd-pstate'
```

These are errors are being returned from here
(tools/testing/seftests/alsa/Makefile):

CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)	<----1st
LDLIBS += $(shell pkg-config --libs alsa)			<----2nd
ifeq ($(LDLIBS),)						<----3rd

and the same error would be returned by all, if user does not have ALSA

so i put a --silence-errors on the second assignment.

> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > ---
> >   tools/testing/selftests/alsa/Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> > index 25be68025290..cd022fc869fb 100644
> > --- a/tools/testing/selftests/alsa/Makefile
> > +++ b/tools/testing/selftests/alsa/Makefile
> > @@ -2,7 +2,7 @@
> >   #

> > -LDLIBS += $(shell pkg-config --libs alsa)
> > +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
> >   ifeq ($(LDLIBS),)
> >   LDLIBS += -lasound
> >   endif

