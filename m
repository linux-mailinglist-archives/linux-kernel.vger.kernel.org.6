Return-Path: <linux-kernel+bounces-322753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D3972D45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E413C2850CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025E188591;
	Tue, 10 Sep 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNcoX60s"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AE1779B1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959873; cv=none; b=R/K3cdFijSVB04xLIaaLwPffGMRW8HIsdoa8AEraY2Ek/jMKzlwJ3sSN3MhAy2WWO2fCVtVkLIgXobHuJGdNzjdxo63OdbRaeKlGSgckv635hQz4QlugG9q+PEZjSLJuBMONauTEb05on5R5phfZ5ZmyUMG/8T9oDvmKZ7RLaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959873; c=relaxed/simple;
	bh=p+DByMRcQlNIXdA1v1uqve5CDE8dg+ziuZCalk0yZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g5Pc2K9qNTB4ziEqCC6T+7AXB5Bvxs5pV8u7EPGAfiH5IhSkxziNawn2dbqLl+NtSSy61P1hI3+ntAv716ojsv6OMV3ntT6KbPa5G2c1s+uZC61DbgA6hsMdjcPDCPmhjDP3OvpqIweh0Aru5WJLBrn6lTyrP41TzqAtV6hzDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tNcoX60s; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3770320574aso3272485f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725959870; x=1726564670; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBqya18CJGCA3gKRbbSWX8CXkyQ/an9a199RUju6xLw=;
        b=tNcoX60sq27H2rwhP/5FqdlXuQQuv8onkiarCQIjOEQIDIscWsYPOs94jpk2yun3+T
         Jev0Ac0VMoVOie0iQikKkLo9O0bsSCN4UyqzNec9R5SibQmNMtZoMfwRzftQNg7AeUTx
         Si++VSpQ4QWVTFaCBMEJTaS5HdNcWqrh4RyneK4zvxlnjtfrFxVojL7i9kiMDmJ9e+gW
         zFPxddTqr13jQK/pbBYcWyxieS0lIx7w6UlTHOAwtRhBN8fmMkaJgUWPqQ+PanMcQYgE
         kjwUdvv0pP2S2v8vHU8abSZBEgVi7u7GzQuGsSB0IU/JvfwCL4qN56nl7B3gC9/qoEAZ
         wh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725959870; x=1726564670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBqya18CJGCA3gKRbbSWX8CXkyQ/an9a199RUju6xLw=;
        b=BQmIEUTId6IMCJNX5CSEQGaO9nU50o8sGQaPnqERcrUnbMJdpy79Cy+cJhhqpSMmsq
         92+utfmTMo6lZqSvMyoB5WO9IgWMH41rtTglX6H5JVE3lJw1GxFlHCIrTFtfO/zTmQEp
         SwmOusg8K9nBReaY18K1a+xJ6JJFqkW5R/MLiy+HNW2uFrZvfNbdKHbKCJKlC1bj79M8
         oI6AwiFz7FzUOR+Ka+JvH1Qoj71kaa87YOtu8d0WLscc67+Niq1Z6+tmq7vxnUYFRDOV
         bxCkxJQUaVGBGJlTakHNTGa6uQILmP0ottdoPa0YC8BbrWxEd/3UqKGDDxJRrbBGUS5e
         aLCA==
X-Forwarded-Encrypted: i=1; AJvYcCVdywLLaG2uLRYORheDnc95nwVmHbWgbHXncD34xt4MR+60J9dg5TeZ7zAxCXb1sttj5njthWq+XziTjeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2lSU2kS2sLLM4sexYcRLlohoM77xn/VpWEsxt69BV8sKF2ZyW
	hVqzrxrUbpdNLOoF/V4txmqDDlteUWeqfDVMrqzWkFzBdotTSVqWg23NUDzTBII=
X-Google-Smtp-Source: AGHT+IHe6qBam3E3tDIg3n89+Ib4jL5iOWHkhTTyyJDMoypu22ayJRQozDZfVGh1ry7qa5NO3nOdvQ==
X-Received: by 2002:a5d:4fc7:0:b0:374:bad0:2b72 with SMTP id ffacd0b85a97d-378895c2540mr8579639f8f.11.1725959869755;
        Tue, 10 Sep 2024 02:17:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956494bdsm8347113f8f.21.2024.09.10.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:17:49 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:17:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/crypto/n2_core.c:1406 __n2_register_one_hmac() error:
 uninitialized symbol 'err'.
Message-ID: <ae2cfe53-7d2a-408b-8b18-af880d1974cc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89f5e14d05b4852db5ecdf222dc6a13edc633658
commit: 8c20982caca4b10ca79aea8134a16ea98989ca03 crypto: n2 - Silence gcc format-truncation false positive warnings
config: sparc-randconfig-r071-20240908 (https://download.01.org/0day-ci/archive/20240909/202409090726.TP0WfY7p-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409090726.TP0WfY7p-lkp@intel.com/

smatch warnings:
drivers/crypto/n2_core.c:1406 __n2_register_one_hmac() error: uninitialized symbol 'err'.

vim +/err +1406 drivers/crypto/n2_core.c

49cfe4db2ddc4d Greg Kroah-Hartman 2012-12-21  1366  static int __n2_register_one_hmac(struct n2_ahash_alg *n2ahash)
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1367  {
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1368  	struct n2_hmac_alg *p = kzalloc(sizeof(*p), GFP_KERNEL);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1369  	struct ahash_alg *ahash;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1370  	struct crypto_alg *base;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1371  	int err;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1372  
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1373  	if (!p)
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1374  		return -ENOMEM;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1375  
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1376  	p->child_alg = n2ahash->alg.halg.base.cra_name;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1377  	memcpy(&p->derived, n2ahash, sizeof(struct n2_ahash_alg));
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1378  	INIT_LIST_HEAD(&p->derived.entry);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1379  
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1380  	ahash = &p->derived.alg;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1381  	ahash->digest = n2_hmac_async_digest;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1382  	ahash->setkey = n2_hmac_async_setkey;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1383  
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1384  	base = &ahash->halg.base;
8c20982caca4b1 Herbert Xu         2023-10-27  1385  	if (snprintf(base->cra_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
8c20982caca4b1 Herbert Xu         2023-10-27  1386  		     p->child_alg) >= CRYPTO_MAX_ALG_NAME)
8c20982caca4b1 Herbert Xu         2023-10-27  1387  		goto out_free_p;
                                                                ^^^^^^^^^^^^^^^^

8c20982caca4b1 Herbert Xu         2023-10-27  1388  	if (snprintf(base->cra_driver_name, CRYPTO_MAX_ALG_NAME, "hmac-%s-n2",
8c20982caca4b1 Herbert Xu         2023-10-27  1389  		     p->child_alg) >= CRYPTO_MAX_ALG_NAME)
8c20982caca4b1 Herbert Xu         2023-10-27  1390  		goto out_free_p;
                                                                ^^^^^^^^^^^^^^^^
err = -EINVAL;

dc4ccfd15d4fc7 David S. Miller    2010-05-22  1391  
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1392  	base->cra_ctxsize = sizeof(struct n2_hmac_ctx);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1393  	base->cra_init = n2_hmac_cra_init;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1394  	base->cra_exit = n2_hmac_cra_exit;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1395  
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1396  	list_add(&p->derived.entry, &hmac_algs);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1397  	err = crypto_register_ahash(ahash);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1398  	if (err) {
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1399  		pr_err("%s alg registration failed\n", base->cra_name);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1400  		list_del(&p->derived.entry);
8c20982caca4b1 Herbert Xu         2023-10-27  1401  out_free_p:
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1402  		kfree(p);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1403  	} else {
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1404  		pr_info("%s alg registered\n", base->cra_name);
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1405  	}
dc4ccfd15d4fc7 David S. Miller    2010-05-22 @1406  	return err;
dc4ccfd15d4fc7 David S. Miller    2010-05-22  1407  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


