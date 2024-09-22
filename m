Return-Path: <linux-kernel+bounces-335335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696097E43D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29EB281266
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48A80C0C;
	Sun, 22 Sep 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="YpXbytu5"
Received: from sonic309-19.consmr.mail.sg3.yahoo.com (sonic309-19.consmr.mail.sg3.yahoo.com [106.10.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1ED7711B
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727047748; cv=none; b=SnhThZgHNSHHCqIgInuqmXUK4CNiX2dRCQf8vy36jvKcFHDLXIz4qbSt0qX8eB1gdWCdctxyNLHbFr6PYNFl0wh1Q5jWzT4r09+m7bpXehBSGYTM28b23sjnwMcc2VWmUDBk7tPh0am+BE/u4kgIYHXufKyLlXvnRLMOwk0W1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727047748; c=relaxed/simple;
	bh=d2VPowojLvE6pIFJNTWiXJSjA8DovhDJFtzR9cLp9K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Y0+vw1KECmo92F6acwj5fD2ccgrr0JojKLR4WTvEgHtj4H05IeOlBpk3N9YQQaH+jhmYY6T/WJaK4o1XSQDuRc0dFfufXM95wvb1LHXorhLYaSiXR46PxcM1AMubHYSewmMfm6Oa12mtr25/fJb6JM7HVTDiZ1If7E1OdPwjDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=YpXbytu5; arc=none smtp.client-ip=106.10.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1727047744; bh=NdwgXXN+vaZk8Zb8F01/IiMP/PymZkaowWVo3D+MKn8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=YpXbytu5yNJ9otvFu+Ipm8GGjBOgcm6N5Oe+IlGSwcFB/AcOMuE+PQT35Kby+ObT0n1UQl5ls9WW5rxr/FYuSwN4iQUc7Wq+rbOzEzNMjK9/2VV3hqs1pAMEzaI8QvtO65y1oeQSSGnNaOG3SY+utOmHZUYl6KNStTbBCCXDdcnpBY+PsBH5v+uBS3nZCDUuzym0G1KvQJUT8qCHaWE8VtEL3YN2aDdRIqeP6A1/zHwBMds/boyeCfXn3Gm2XNaEz31orB/HZDuptwZoiT1rl2qUupY6wXdklrsuLGNRn9lf1FMED/MuTz5N+qs7129aMhovLA1v/eY66v9D8F1aRA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727047744; bh=qBBXWEEUdySMMO7uMr9T10BoMuCnJmkDjVT9ozw+tn0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PyyWiY+05WavDN4x/PueZedEd+pTZLBW4HuN/MtSSzmFUXrX+upLZQvjAVCu7Fw1nGC3X54XU81McQx7dzRzbh+phJ+Pq5vgz8ut3XMf2WRhOJcG0vJ7i4NNq0k3FpejsqsNwDUpXI5Lyp2i7Dt0+ZifLnMwvESiiXodqjUJ5HxbqAZNoG6v0C3/thZm0sPKKe1r47bBdMj93nC1B5FxwwmlbX0ECsqRGNhT1eYMlRXSA23YlzwPwLXAjFfjbWIQdw/ZNf6ImpOWFLQMF8xmQKiBPNfxU86SPlM4YWB546r+MARBIiTCx3BnIUNGCooh90wMzRRpKgyhQb7kGRp8Hw==
X-YMail-OSG: mcCKfdcVM1k8rU5PHk8h.r1wN1mY1gQefdiU0geabbU88pf3AjbW8SCjxzbIdwL
 MpIlTl_9pshkBZpQBCTMKTgI54lH_i_0nA6aimjWhfzF6t72gviy.ymiI2vI8fLitgwx.wuDVMD3
 8qiRhaFW.GzaTQI6NN.aJj8QxWO.KjBtmfUvyHXQJnfuQpPXVI0iokdrw7u_JR8.9E0R3MaGeW9x
 9kdIja4uHDHEdilcVoUxkd0RiO5boMGiLY5YNgv0SMVx82KWW.z_y5oIhE8SP8QA1HU.O3KptkEa
 AYBS85.r54jwHFVYT_shGydKxj5qOiVLDE32kL8HRECdnswzSVoRod0ekjtTd_ruP.elbbT17U4r
 y6rHnbQVb56dLes6.96XQtieK0clDOWIQc5yfhMM29Mdde25rtrX3jm4LcRZuvslyxiXbZ_DGTtu
 K9B6poRNanA7eU1UltNCQ4hJ_TIRVoBTdqW0if5ks0WFcbsXvT6tm0wrmIPRnykaI1JQ2Md8Y4C9
 FhSlBkb1Y11Fdy7CQHILuLAvsrRnPxN19g1ESjyCITUc8JLcmB77E1_u8W0zr.W8X25yJXXwKDgL
 SgqA45jB.Q.YoqE6aO3Y9EUY2prMRVNlvDHpPMkLnFUrBuPxgvVJvL9luQQnVcijD2XTX9ulmcC4
 mD2855Jq9mP3OJ92XGNY5qKuzaBX62WpIlm9SthccKiH61AlOvRJ2enOGWb96NVygv1hD.Xqu99e
 NW29ecthx.4GXih6NUJVLfMAXekj0l1CMuVSkFHYuRBC7Wl2IoJqDgdepSFoYZ63ilfF63uyX1Io
 YrogjQ2BqX5y0QzGTRRMu_74RTtLsD2E4ibRin2KscmEITpBH6mSgtrci7wubo72pXBLVUc.VDHp
 0jYpssiI2cjL2nxS588oNx4WWrLR9AmZxeQaNSG.SezbvccjxZS9zkwojJw6z5YtPKMgiMBI8CKw
 K.iZDKzzwCxMAlzZAeUDetHBfg93TDyw8y2JpVuyPjey7T7uAwb1BR1ZwzoThtuy9h_9nGjKc.wN
 .OuTfFnSZg_J1YgmhYdO.RXdCn0_FyjIa3jfO7CBkMdpyHZMD18BtKgZFQtREPOSLOHOwnAKnWUP
 EX83pqLqSMO61AeXTLcvSozmK4ZgA9DsfzwvtPATyWIekoSZKTVJnhCInEp5lGo8esNtsua.IdH6
 g4QNsqwnbC7NP3rw762GgiAEtC2cbTKwHEwcrdmSViBO7PoMqEO7K_NsHvGW.bhUjJj4sP5FNoxT
 NpCv3z1zMRV_Ff6wtjye0ZmH65uNPpR.8.7DNMhV8pIU7vnFvsQl4kpJKm2Ae_.UwNArdv.tAMtW
 6IiRV0tGPyHoVMDBJ1oc3MNnr4SC7XThQ92FkzZiqGsGDlGQqrgOgSvsK.ZiitcGzf.3LnMeWswD
 G2mMsm7gv5DlFz8BnCzgXlArdm9_mzNu3kXMdI_4r6G7ylzN9.bAkuh_TzFamXzfwhEPHViaoBjI
 5l..IBnzlqZ9vKQph3ocaKhSwrp_ypg8FqzTb5Z6POOdWdKlw.H2bNh383CbCIreN2ChZRrZP9d3
 bKB9wMWtZBOA.MhyRiqt9.iI6gJM2kkmuq3pLlQGjwf6E2rDp51PWma7NjfuQraJ38pAVlH3t02F
 V6p8oJVSZvbTGa57GWvGbPev683BKEmVdSJ2yEeXfDOhodOdNR16EVijCcrD5NEGJFNBl7U_ViEP
 5XnC5hZNW_AbOBH0Ahlh7JdaClgKVD3YNHHG2q.4ykcvuHEGZiHeEqH5qJ6i_uBix0xRhHHvIhzq
 H53gAKi1yty9RQUNlZMZDyZUhnSk.d_2MLFBMDtnISj2C04FO7b6Y9mD.zfH2rSBsQdwJM0HWgoU
 RYTvYLK7dCbQm2_199xd01JcOtkfT1i7e6hmRE9PuNbjl3A5b.Pg_77mfpH5O0_skqhmFfclHm8U
 snuwogGGiLEOqi1c_MCynfZjxwENLLGRGwJJwPAH96Mp0nEuAxizT2bDFk.9zTjoaxItNf.jn6TV
 1SsLLUm60IYRRBK8JUDqwSWwLeDG47Vkmo1H2WqXxlGS9_4dkFkcmKnOEuWGE0_Mqxfi15qYaRoi
 hZiwSsFHyAjawXy6JSp3On9YcxkUljmjfF8NjmB1clVk8hsXpNcXiEJSbrrgxAherXMQyRgkmde7
 jT77mkmAwBipKc4HGY2Crjxu8bmHEpkHuDVSV.oWQbxAVS8DSgptSNHcDafndZyIwSsJQfSyHF4H
 HXwY9pbTU1gDg4InmcpPnWRLxrO94p8Z76Msczl7MLPI1T7EtTi0eaJspJKGvqcE-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: e76e49aa-2261-4d83-bb69-b1c751c7bbf5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Sun, 22 Sep 2024 23:29:04 +0000
Received: by hermes--production-sg3-fc85cddf6-kzxtv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7a694d7ff6fbf021b26f5be229f8bfcd;
          Sun, 22 Sep 2024 22:58:34 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Abdul Rahim <abdul.rahim@myyahoo.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: alsa: check if user has alsa installed
Date: Mon, 23 Sep 2024 04:28:18 +0530
Message-ID: <20240922225824.18918-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240922225824.18918-1-abdul.rahim.ref@myyahoo.com>

Currently, if alsa development package is not installed on the user's
system then the make command would print a `pagefull` of errors. In
particular one error message is repeated 3 times. This error is returned
by `pkg-config` and since it is not being handeled appropriately,
repeated calls to `pkg-config` prints the same message again.

This patch adds check for alsa package installation. If alsa is not
installed, a short and consize error is returned. Also, it does not
affect the compilation of other tests.

Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---

Current output:
```
make[3]: Entering directory '/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/alsa'
Makefile:4: *** Package alsa not found, please install alsa development package or add directory containing `alsa.pc` in PKG_CONFIG_PATH.  Stop.
make[3]: Leaving directory '/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/alsa'
make[3]: Entering directory '/mnt/ubuntu/abdul_linux/mainline_dev/tools/testing/selftests/amd-pstate'
```

Previous output:
```
make[3]: Entering directory '/mnt/ubuntu/abdul_linux/mainline_compile/tools/testing/selftests/alsa'
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
gcc  -isystem /mnt/ubuntu/abdul_linux/mainline_compile/usr/include -L/mnt/ubuntu/abdul_linux/mainline_compile/tools/testing/selftests/alsa       -Wl,-rpath=./ -D_GNU_SOURCE=  -shared -fPIC conf.c  -lasound -lpthread -o /mnt/ubuntu/abdul_linux/mainline_compile/tools/testing/selftests/      alsa/libatest.so
In file included from conf.c:18:
alsa-local.h:11:10: fatal error: alsa/asoundlib.h: No such file or directory
   11 | #include <alsa/asoundlib.h>
      |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [Makefile:24: /mnt/ubuntu/abdul_linux/mainline_compile/tools/testing/selftests/alsa/libatest.so] Error 1
```

 tools/testing/selftests/alsa/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 25be68025290..944279160fed 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #
+ifneq ($(shell pkg-config --exists alsa && echo 0 || echo 1),0)
+$(error Package alsa not found, please install alsa development package or \
+	add directory containing `alsa.pc` in PKG_CONFIG_PATH)
+endif
 
 CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
 LDLIBS += $(shell pkg-config --libs alsa)
-- 
2.46.0


