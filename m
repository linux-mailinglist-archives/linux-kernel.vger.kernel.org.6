Return-Path: <linux-kernel+bounces-436837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78849E8B7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E68281AC7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE082147FA;
	Mon,  9 Dec 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDHeFJU0"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA917C219
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725497; cv=none; b=bF2pvugUI1AtlC1zIMQ+XNUUWq9ADOuyU4y8qyhoUSFZ883dqS46dE8f/K/ZF5CT9zIkhmXB8dzg30w32HDRPj2Wb5xab2r4BV4wv0E2WsXHNSidfmx5tpeV51eSKQ5DtvaTR2hP4vGjAyVKIU1eyqesDzOKZqca5wHapkI3Clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725497; c=relaxed/simple;
	bh=mGTYY/S1tcZ7mB4hZaQXD2gGwB9lm/gy74p2V9lOMBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gmHPVIHhbhGoKb86fVIi81GtXzRcwx3H7dBQPfB9x2uJYRt3CfvV7WuTYQbWXKmZ6cgObMMNPqN0V+pX2AtFONCLSOEMCR682U2+MoEOmFHpCFRqX2p8qB/t7+rEKKR5Ju2FaTxtr+J6UwW+pg1EUYuk3X0ayDA14fR+AkT+M0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDHeFJU0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e406a547so11385305e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733725494; x=1734330294; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSWdbzUv/klyRC+VpwtXiylS3X8oQQ/HWEE9CGjI/X4=;
        b=PDHeFJU0vQBTAPFsllbvcWPzfktZyXYLdV+E+TIkw1ZtAGkSOb0efnCDaxIWD2cqbt
         5tLEIARzGusAzIWogh6NXdY5smQQuTog+rrI+9d5cJtvzX150ek4EWTWuZ/uaQEiLEXO
         DKs6ASzQcLX7h9C4DUzaCNXVFUeSrzz7nG+sOroUxkLz7W4mv7tRRHTnGjWsqAeKK5w+
         DuaurR9m0Y0Uym6eJ9OgyEp6wovueB7njQ2pcB6t6OWHtUaOAk6xS3YvwQKDeJ3Vyjg8
         G3KJbuQDRF+lCKhvJGDHIwihv7oNEJbRpbowMOmeG6QN7L+xUXbWDMQYyLFQM5gZ1k5C
         trLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733725494; x=1734330294;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSWdbzUv/klyRC+VpwtXiylS3X8oQQ/HWEE9CGjI/X4=;
        b=wvFB64Z/NhCI+1okTTWfLe83TWD3u3rQ5isEYfxCgwa64V7xB82QgpA7/8EU3jE4wM
         PQ9YSNrrdXs11Rt9oXDckiQ+mVoEJPLdjlV46gtCvkqHtejLPyBWgiP8H7Rm9yngeSh3
         Ie9FqCM/IAabPQksK0zNl+jQ5o5xISlrgXp42M7ZRz+tKfnhbCtrzkAe9SUZZyKl5Wqt
         RqTWWRB9qp83bThmcvkuhv4zoZNxx+fhkgOQMfQidQ+ckMkIBjUw3rMXmBQOTfOsxNAv
         zx+CfpRZM4NTRaMyDPuVJTd4QpFqh3gcBDLt8b6AgWFy6UN6hwpbWnaT4i8J5yEtyZyt
         AmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVFH29/K0euPlPgAW9z4XUFQfxKzVB8qp/4Qnfe15cgD7fxVaSz2mqOo4zHuF6c9epLRy3fEzM46qUm4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sTlSRdiFy7d8RS5Mtk0nlpk8p+bR0e92OY6Y3n5t0yM6AIoB
	aA+vcc7HEK1uknmkNJYB5HTu3xFa24fe1MSHYmhL/R6qxH9mSrSy5rwGgDi/EfInzXgFbQ16ea0
	Z
X-Gm-Gg: ASbGncvFNM/rJE+S4he1teYSQiZVw6Euau/oX+dKdAqDn//AwB9785r3bqRSzJFT/OL
	ChX5oiznT0VbIEH5MljlnQGYKC7V20xiSwIZtZI/J58DWCGl6J3JoYfRKSB3xIa2hNP4psBd/Ne
	DA58ATRyWuBtVFqauJRI+K7uYc8y4idK0BPsO620FP4xywZcLox0t0008kfTdDgbJydG1PR7Taz
	W2vGSGmhtyLY+oCkKqRaF9BoCvZUnQyHkz+gc9Wprtj3lGg4XbAaVA=
X-Google-Smtp-Source: AGHT+IFBto4Yfrx+pv3ASlNQe/3a3g3g5C2AxRS3XdYTeSZtg6kA2LXtYVN1NzUSxdF0yl5jdyXPsg==
X-Received: by 2002:a05:6000:178a:b0:385:f417:ee46 with SMTP id ffacd0b85a97d-3862b33b786mr8183957f8f.2.1733725493969;
        Sun, 08 Dec 2024 22:24:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386394dd379sm4517942f8f.24.2024.12.08.22.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:24:53 -0800 (PST)
Date: Mon, 9 Dec 2024 09:24:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Akhil R <akhilrajeev@nvidia.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/tegra/tegra-se-aes.c:1596 tegra_cmac_do_one_req()
 error: uninitialized symbol 'ret'.
Message-ID: <134e89a8-49a0-4675-8e07-4f257828f51d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: 0880bb3b00c855fc244b7177ffdaafef4d0aa1e0 crypto: tegra - Add Tegra Security Engine driver
date:   8 months ago
config: nios2-randconfig-r073-20241206 (https://download.01.org/0day-ci/archive/20241207/202412071747.flPux4oB-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412071747.flPux4oB-lkp@intel.com/

smatch warnings:
drivers/crypto/tegra/tegra-se-aes.c:1596 tegra_cmac_do_one_req() error: uninitialized symbol 'ret'.

vim +/ret +1596 drivers/crypto/tegra/tegra-se-aes.c

0880bb3b00c855f Akhil R 2024-04-03  1577  static int tegra_cmac_do_one_req(struct crypto_engine *engine, void *areq)
0880bb3b00c855f Akhil R 2024-04-03  1578  {
0880bb3b00c855f Akhil R 2024-04-03  1579  	struct ahash_request *req = ahash_request_cast(areq);
0880bb3b00c855f Akhil R 2024-04-03  1580  	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
0880bb3b00c855f Akhil R 2024-04-03  1581  	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
0880bb3b00c855f Akhil R 2024-04-03  1582  	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
0880bb3b00c855f Akhil R 2024-04-03  1583  	struct tegra_se *se = ctx->se;
0880bb3b00c855f Akhil R 2024-04-03  1584  	int ret;
0880bb3b00c855f Akhil R 2024-04-03  1585  
0880bb3b00c855f Akhil R 2024-04-03  1586  	if (rctx->task & SHA_UPDATE) {
0880bb3b00c855f Akhil R 2024-04-03  1587  		ret = tegra_cmac_do_update(req);
0880bb3b00c855f Akhil R 2024-04-03  1588  		rctx->task &= ~SHA_UPDATE;
0880bb3b00c855f Akhil R 2024-04-03  1589  	}
0880bb3b00c855f Akhil R 2024-04-03  1590  
0880bb3b00c855f Akhil R 2024-04-03  1591  	if (rctx->task & SHA_FINAL) {
0880bb3b00c855f Akhil R 2024-04-03  1592  		ret = tegra_cmac_do_final(req);
0880bb3b00c855f Akhil R 2024-04-03  1593  		rctx->task &= ~SHA_FINAL;
0880bb3b00c855f Akhil R 2024-04-03  1594  	}

Is it possible for both SHA_UPDATE and SHA_FINAL to be clear?

0880bb3b00c855f Akhil R 2024-04-03  1595  
0880bb3b00c855f Akhil R 2024-04-03 @1596  	crypto_finalize_hash_request(se->engine, req, ret);
                                                                                              ^^^
If so then this is uninitialized.

0880bb3b00c855f Akhil R 2024-04-03  1597  
0880bb3b00c855f Akhil R 2024-04-03  1598  	return 0;
0880bb3b00c855f Akhil R 2024-04-03  1599  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


