Return-Path: <linux-kernel+bounces-319151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263796F894
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D2628666E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920F1D2F6C;
	Fri,  6 Sep 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPhGTNI7"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF221CEAB1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637629; cv=none; b=mq//LR87nAjEQty4rRGKiFvOF3MMAin17DZI/hPPkRRh3uXEDFx20kvhs98NUQMjCudGIw2mC5VwtUTDbw74YS7wUPKPa1ToizF/bBhEYmOibKZpptD73XAcET0DPNEE/YrWC1pal6AKBIU/HkF1LVQ9qM5qNRLdIcXfvZr8HVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637629; c=relaxed/simple;
	bh=gu20GtAI+AjtMwQyNX0gTbxgQ17/cmjuVAn+9Ihywbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z78qDLfhWccFc/dFE03IKtw8Ik45nYEA04Njx/NpZgW0RBJQsbSOkrjpQMObRnYPD2rqeAMHtACso8Ab6RTuRZj07e9GrGStrMR6ynoq4VMt7ygHDOnmLo2zok8tKDpwdSEVu3D4qJOdMqsMY1P8cqRCBVXOqDBGNVVpDdFeqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPhGTNI7; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f50966c448so26729091fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725637626; x=1726242426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh009DPJvSFVva+/nxDK2xUzYWcU9eTQCK+MUuJaT7Y=;
        b=HPhGTNI7P0Lf6ZeJX5/maOOlzAMKMLq0ful5nNto+a3zRCZ1RUhFCfAWboR4xvxS/b
         fKxUreD8Ic5U/sXatJBcFQgIjam1NSE8uKKsuZLl4XoMTttL8ay9CkP0WODMjvq0A5bj
         +178N/L3DSW1cC8p0mAeLMg16I0QGVYay2ly9UtDfgPfi7z5Sohrn2XvDdzkJtGvZ/G4
         FjIqZ2w5gZGM5F4/duDn23JMqdzW+O2kylf2CtgKcVOSUGTMtPjc1GDERylOxOs5wC5p
         p259+maUUFtj8gbUtb6qJV2WX1lu8dObvUWVehWJUu61p25S6J3ZvafWFxmjLCk8jl2d
         dLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637626; x=1726242426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh009DPJvSFVva+/nxDK2xUzYWcU9eTQCK+MUuJaT7Y=;
        b=JugozqbbhbSIPWMob3y2+JOD3r8N5sMk2UiXwv6CODLxMkRixbp5+ryNigIng0e1Oo
         DNoN3rnsfe1S245VWWS6yQuzJDwtGeGykoBH0QqCZ71XASV3scqVg2sY7lVzrYiM5KFL
         2t43w/R4Qj8d28G1sGYGwYvGinrh2rUBg5mq74r6Q/zNXMASb635jEQljNw+i15F0ol4
         MQGodO1y41Xc9DP8saKMwNu8IgeA8pGT0T8cZl0TuKp1mxkYjXNYf2BzsCGnfBXFrqCE
         aYhMxfqtvSirZf83abatx3maANWpIeVZ7S5G105pEOhA6/w6SLot9w7Qq7peaMsof8fm
         1vqg==
X-Gm-Message-State: AOJu0Yw593+A8SwIr/9coxJD030sUEChUKHlRFn7JOtE4ErL6VTDCp8G
	op7vYAOvU9EeYUMBdDCueQfA/2NmIbGuZ0pXmQyo9uObBDoo8oJNkWideb8DGa2ypDcHxR9mCOj
	v3GtmSpLhMK5p1EUFuC922YlvEmQ=
X-Google-Smtp-Source: AGHT+IFVTTO8+ZBCXPaEE36sFeuTpJhoQDkWbuaTISaCNmzvdon+aj6I6+n1c5eaD8ERcgKm6xZ5omk4rnvtxUz71rA=
X-Received: by 2002:a2e:4c02:0:b0:2f6:4aed:9973 with SMTP id
 38308e7fff4ca-2f7524a3509mr18052481fa.44.1725637625018; Fri, 06 Sep 2024
 08:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905122020.872466-18-ubizjak@gmail.com> <202409062123.F3r9hB9z-lkp@intel.com>
In-Reply-To: <202409062123.F3r9hB9z-lkp@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 6 Sep 2024 17:46:51 +0200
Message-ID: <CAFULd4Yz=C5oZ=hWa9biLsXvvBK3EqjndD8kRRWgb=RYiSFKAw@mail.gmail.com>
Subject: Re: [PATCH 17/18] random: Do not include <linux/prandom.h>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:22=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Uros,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-nonmm-unstable]
> [also build test ERROR on mtd/mtd/next mtd/mtd/fixes linus/master v6.11-r=
c6 next-20240906]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/x86-ka=
slr-Include-linux-prandom-h-instead-of-linux-random-h/20240905-202710
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-no=
nmm-unstable
> patch link:    https://lore.kernel.org/r/20240905122020.872466-18-ubizjak=
%40gmail.com
> patch subject: [PATCH 17/18] random: Do not include <linux/prandom.h>
> config: um-randconfig-002-20240906 (https://download.01.org/0day-ci/archi=
ve/20240906/202409062123.F3r9hB9z-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 0=
5f5a91d00b02f4369f46d076411c700755ae041)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240906/202409062123.F3r9hB9z-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409062123.F3r9hB9z-lkp=
@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from crypto/testmgr.c:27:

Ah, here we have a negative config flag, enabled for allyesconfig, so
- the source is disabled with allyesconfig.

#ifdef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
...
#endif

Patch is as simple as:

--cut here--
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index f02cb075bd68..eeb7edd99a93 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -23,7 +23,7 @@
#include <linux/fips.h>
#include <linux/module.h>
#include <linux/once.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
#include <linux/scatterlist.h>
#include <linux/slab.h>
#include <linux/string.h>
--cut here--

Will add the patch to v2 series.

Thanks to the kernel test robot,
Uros.

