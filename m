Return-Path: <linux-kernel+bounces-282265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1994E16F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0377028160C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E595114885D;
	Sun, 11 Aug 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sjlef+3V"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B118E20
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723383021; cv=none; b=ZFyHcniitFoxjPdlLzNTBVP26sxC/5rf2OaPJz/THoIsgj6kROp3wxqhYhJG3ulKoMgeSY620VHGG2MD3EDSN1HuExEtLSP0Mb8IY/mNDKfNxCbb/flS51Hx1Uu+dlb5uaAUn8xihONDBZqq+AmZuFeteM1wJlUzPDjY76u2NiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723383021; c=relaxed/simple;
	bh=WI32aLDXzMX73NHJX889i+Bmg8NKd4/36nuecSsCIeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BY7keXkshMtjLSIk4uKpLTzm6lAZh7N2j7Bi/zOO1qzP7ljejSHb8jqxUPW+pOVpQMapckbGEyjJJGHqZi5QHwwvQue+TWaqvCuHCvZyvl1HMeV3EKbRA6ZZV/8tPSVUUFIJxYC0p5OLXn9UU96CKGetlgPL5EoTIIIlnuP83PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sjlef+3V; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530e2235688so3761484e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723383017; x=1723987817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ophunq+irD/RQYGfTe1EmvYis9lTBIa/JcdniZkh3wo=;
        b=Sjlef+3Vg8J0R/PUs8fU/Gs4ALOySOWUwxI/yNmUnKNbrwSMCGGR2Haafq3tgkcmRQ
         ivxtTe72ERHJRqD/ny1Ok96+uJR970LAAYniH26FTtSq2mLlMEG/eHfQcvDzfAzhOw42
         mCufgdkN/tqldJs609wkNpovgMXxXSp9jfS+CuEq3lvGBdK+g4wZPgMEFI40agxdO64A
         MJ2/EPMaokcUaYBm5/1PW060rIV0Lf6f2m97i/pddZ/ju6l7MBlFldreQkflQh5njVnU
         EO3VdS8BxxZB/y2hZS2b4VvaOHrNPAYz1BjxGsPiuBKRvoa8GSP4eS6kcwutbJ/AED2V
         nRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723383017; x=1723987817;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ophunq+irD/RQYGfTe1EmvYis9lTBIa/JcdniZkh3wo=;
        b=ZShcuQx6raTPZMmgQXVWic6wZ1tQuxjcXH+I1MzsBQ9vj0HHTSGIrsYUEluQu2Vu3l
         wx0UwkD1YObURi8kgzN0Htq/DGcORiCDYoudeJXWNGBUhC+85v7LrGoK5K885WCl5EnI
         llotCoHOkN//0lpZW8aNR9OnpkfCdn9TEIHPu9PkcvS9P4FA4AHQIfqQOSunj9h9gZiF
         kn6DrLqk7UJ/nQxa5oRnX4bxa/1ZA6CBMUIXOBRb9EQODMg/thA7fZJLXVFpGWj55qfH
         WhsT7bL4tzSINje7hIsQrLEWEJB6D+F/lyn5GsW4qNW81VFTeVAOhJzIY2MMLfO57Rp7
         7hAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpx0JpN4aue5yMbFAqBEl8Yji0NNyZb5La90ilK7JywsdKEdfcid/zkt4HmdqWH1DkJcNv6KrNEIfeLxoR+x5rmiVku3yEaAUZ+U7l
X-Gm-Message-State: AOJu0Yw8XeeoGqUWgLk4ByTUm0qaNG0/Zf0GHzlrY1CR4cqJWt6+GkrC
	c4wIX+rbsad2zPMDFlF2JxHPM7IZ/Mwn4KqK6gvIWQaNU9d/9D7bTezhmI1++Aw=
X-Google-Smtp-Source: AGHT+IH3NE04N2VqidGut2ih4Aovg/6zbgyk+VvQdaiI3UDBTeO6TYI7TA1F0AtaoaJGPhUsVrHPRg==
X-Received: by 2002:a05:6512:b96:b0:52c:d84b:eee6 with SMTP id 2adb3069b0e04-530eea25013mr5295040e87.38.1723383016894;
        Sun, 11 Aug 2024 06:30:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb212e32sm146603566b.166.2024.08.11.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:30:16 -0700 (PDT)
Date: Sun, 11 Aug 2024 16:30:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/3] crypto: api - Do not wait for tests during
 registration
Message-ID: <34069b9d-3731-4d0c-b317-bcbc61df7e9d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrbTfOViUr3S4V7X@gondor.apana.org.au>

Hi Herbert,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herbert-Xu/crypto-api-Do-not-wait-for-tests-during-registration/20240810-160343
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/ZrbTfOViUr3S4V7X%40gondor.apana.org.au
patch subject: [PATCH 2/3] crypto: api - Do not wait for tests during registration
config: x86_64-randconfig-161-20240811 (https://download.01.org/0day-ci/archive/20240811/202408110413.vKk2q3qN-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202408110413.vKk2q3qN-lkp@intel.com/

smatch warnings:
crypto/algapi.c:396 crypto_alg_tested() error: uninitialized symbol 'test'.

vim +/test +396 crypto/algapi.c

73d3864a4823ab Herbert Xu     2008-08-03  350  void crypto_alg_tested(const char *name, int err)
73d3864a4823ab Herbert Xu     2008-08-03  351  {
73d3864a4823ab Herbert Xu     2008-08-03  352  	struct crypto_larval *test;
73d3864a4823ab Herbert Xu     2008-08-03  353  	struct crypto_alg *alg;
73d3864a4823ab Herbert Xu     2008-08-03  354  	struct crypto_alg *q;
73d3864a4823ab Herbert Xu     2008-08-03  355  	LIST_HEAD(list);
73d3864a4823ab Herbert Xu     2008-08-03  356  
73d3864a4823ab Herbert Xu     2008-08-03  357  	down_write(&crypto_alg_sem);
73d3864a4823ab Herbert Xu     2008-08-03  358  	list_for_each_entry(q, &crypto_alg_list, cra_list) {
b8e15992b420d0 Herbert Xu     2009-01-28  359  		if (crypto_is_moribund(q) || !crypto_is_larval(q))
73d3864a4823ab Herbert Xu     2008-08-03  360  			continue;

Is it possible for everything to be moribund or larval?

73d3864a4823ab Herbert Xu     2008-08-03  361  
73d3864a4823ab Herbert Xu     2008-08-03  362  		test = (struct crypto_larval *)q;
73d3864a4823ab Herbert Xu     2008-08-03  363  
73d3864a4823ab Herbert Xu     2008-08-03  364  		if (!strcmp(q->cra_driver_name, name))
73d3864a4823ab Herbert Xu     2008-08-03  365  			goto found;
73d3864a4823ab Herbert Xu     2008-08-03  366  	}
73d3864a4823ab Herbert Xu     2008-08-03  367  
c72358571aaadf Karim Eshapa   2017-05-13  368  	pr_err("alg: Unexpected test result for %s: %d\n", name, err);
73d3864a4823ab Herbert Xu     2008-08-03  369  	goto unlock;

This calling crypto_alg_put() on the last item in the list seems wrong either
way.

73d3864a4823ab Herbert Xu     2008-08-03  370  
73d3864a4823ab Herbert Xu     2008-08-03  371  found:
b8e15992b420d0 Herbert Xu     2009-01-28  372  	q->cra_flags |= CRYPTO_ALG_DEAD;
73d3864a4823ab Herbert Xu     2008-08-03  373  	alg = test->adult;
d6097b8d5d55f2 Nicolai Stange 2022-02-21  374  
d6097b8d5d55f2 Nicolai Stange 2022-02-21  375  	if (list_empty(&alg->cra_list))
73d3864a4823ab Herbert Xu     2008-08-03  376  		goto complete;
73d3864a4823ab Herbert Xu     2008-08-03  377  
d6097b8d5d55f2 Nicolai Stange 2022-02-21  378  	if (err == -ECANCELED)
d6097b8d5d55f2 Nicolai Stange 2022-02-21  379  		alg->cra_flags |= CRYPTO_ALG_FIPS_INTERNAL;
d6097b8d5d55f2 Nicolai Stange 2022-02-21  380  	else if (err)
73d3864a4823ab Herbert Xu     2008-08-03  381  		goto complete;
d6097b8d5d55f2 Nicolai Stange 2022-02-21  382  	else
d6097b8d5d55f2 Nicolai Stange 2022-02-21  383  		alg->cra_flags &= ~CRYPTO_ALG_FIPS_INTERNAL;
73d3864a4823ab Herbert Xu     2008-08-03  384  
73d3864a4823ab Herbert Xu     2008-08-03  385  	alg->cra_flags |= CRYPTO_ALG_TESTED;
73d3864a4823ab Herbert Xu     2008-08-03  386  
103961609b0935 Herbert Xu     2024-08-10  387  	crypto_alg_finish_registration(alg, &list);
cce9e06d100df1 Herbert Xu     2006-08-21  388  
73d3864a4823ab Herbert Xu     2008-08-03  389  complete:
862e4618d9321e Herbert Xu     2024-08-10  390  	list_del_init(&test->alg.cra_list);
73d3864a4823ab Herbert Xu     2008-08-03  391  	complete_all(&test->completion);
2825982d9d66eb Herbert Xu     2006-08-06  392  
73d3864a4823ab Herbert Xu     2008-08-03  393  unlock:
73d3864a4823ab Herbert Xu     2008-08-03  394  	up_write(&crypto_alg_sem);
2825982d9d66eb Herbert Xu     2006-08-06  395  
862e4618d9321e Herbert Xu     2024-08-10 @396  	crypto_alg_put(&test->alg);
                                                                ^^^^

73d3864a4823ab Herbert Xu     2008-08-03  397  	crypto_remove_final(&list);
cce9e06d100df1 Herbert Xu     2006-08-21  398  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


