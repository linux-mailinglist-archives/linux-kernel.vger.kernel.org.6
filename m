Return-Path: <linux-kernel+bounces-395972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A069BC5DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE801C218B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686B41DC185;
	Tue,  5 Nov 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn20Cyba"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D831B394E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789174; cv=none; b=lNtd+FtptgdmN0ku5TpxH0mYdF31dZqJrHgWj4uRVF9HC3XXkeF4cUpwxkTkNvekA7Pq9os0qT0Jfwg74isYnh8hfClOXFpuqL4tyhK3MeF+hzwHNLG0usEmTDIRk0GPJmT5UVbIupx4hwducw1ckaJqz9JmltvLeXW3eUf+IFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789174; c=relaxed/simple;
	bh=hSQTiFZQF0hGorX49JWUNc3bUyS2+/nohnICuzTw4Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dlrGEEqnHCTVfBf5eee/i5CsbcmSf3Wu8qHUMiYI2aGAYhuMQHYnl+Us6HdGUUPYpmkSOH++s1khqYGo68vGFvWq6vqKWxZ1OyK1svQKVVLiRc//mxxK49+GhOtysLyfvaqDRwLM5JWHXy5FPnt7JryLdAOjCWBViIDhDb0ddzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jn20Cyba; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522445dso470392666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 22:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730789169; x=1731393969; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kortesz35ShgnDxJcvbwhIE8NxLL7SZg3WEa2gvuUw0=;
        b=jn20CybarzvBxsyx1vU76DKMmsgT+obKbJzNt2ETHW6SXD6ydhj+ajsrg7rEueGCXV
         oTL+ZrwOLXnE3TvtiWaIgmhJZntlwRPC8aNRSmiK1gHdbpiTFSqa5AfoLgik9rrwFNc5
         bojCS9n20ll7Pez/FylxByBM1b3RmPqXmtJTWKfKNo1L6A/Z8qwfzJ5cJZKpTNJRVyme
         mjqWwjX0D2mEdPcU8oDSKe95c5gxipA8dAVeQQCdtYQfOoVFEnCZWN0eMAPS5yT8UIb6
         bHRRydL7cen6ZeGnCRQB01wEhMxE9u0VUXjS+ghw2otj1BUzzeZgiK5jFLZsCjSGrBZd
         t0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730789169; x=1731393969;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kortesz35ShgnDxJcvbwhIE8NxLL7SZg3WEa2gvuUw0=;
        b=cGmox6/arth6k99bInh83yRkqxTgUlh/QU2ErWgfyhrTrW9ppWHzRb9Qc8dPpNbD6h
         nS7M46PiL3eGAgmCLTK/oS1C/8WewhhRrVitr8/fiRdB9Lljpa/NwsyZlhdvQ4TA/9O2
         kK0wNr8GCCZqns0GRTm4EqMqlDu39qx16FuZCA0Wg0IV5gzYwyV+wguSfX29gK9Z+IOM
         tiDjZzNEg6EJ7/AKpxeKALBfXVB6T46ydoE68VXsn5UCIjdH1YrCDn/soPoVKnuCCVSl
         itBLcICItvP3gdy7+1Ux2S2WUonrj1o66sm74yPWJoUC0o9Eob/Wn0mPqu191Pb/tYxt
         LQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXD4VDznc5mdkpNcf18zaCUfd86tiGZgYrCrHqq4vCo7tNQW1c2oNyxp163klhHxeC8cbVP7TREyfD0y1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHu/z203fWI7TUvapqad9Rj848GTdJQjWaeHYGoiS846xk3zG
	buYxovSwAduZSX/vbBtzb6jFz9rVAt3rLpsAUfqfdih05pnUBJZpecVlD/MGWuU=
X-Google-Smtp-Source: AGHT+IFqwgIDPvpZ5dC/UJEbtwUiJ7w8TtUpn5NEnOCbcZpBiyi9BvlhK2QfQs6WOzzLE4V2LpOqVg==
X-Received: by 2002:a17:906:db08:b0:a9a:1165:1bb with SMTP id a640c23a62f3a-a9e658c1759mr1660385166b.65.1730789169295;
        Mon, 04 Nov 2024 22:46:09 -0800 (PST)
Received: from localhost ([77.241.232.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17d0af1sm85658866b.94.2024.11.04.22.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 22:46:08 -0800 (PST)
Date: Tue, 5 Nov 2024 09:46:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: drivers/soc/fsl/qe/qmc.c:1942 qmc_probe() warn: missing error code
 'ret'
Message-ID: <bac2dc94-1bf3-4dcf-b776-cd78ef992d28@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2e1b3cc9d7f790145a80cb705b168f05dab65df2
commit: eb680d563089e55b20cb7730ed881638fe4425b7 soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation
config: powerpc64-randconfig-r071-20241104 (https://download.01.org/0day-ci/archive/20241105/202411051350.KNy6ZIWA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411051350.KNy6ZIWA-lkp@intel.com/

smatch warnings:
drivers/soc/fsl/qe/qmc.c:1942 qmc_probe() warn: missing error code 'ret'

vim +/ret +1942 drivers/soc/fsl/qe/qmc.c

3178d58e0b9772 Herve Codina 2023-02-17  1828  static int qmc_probe(struct platform_device *pdev)
3178d58e0b9772 Herve Codina 2023-02-17  1829  {
3178d58e0b9772 Herve Codina 2023-02-17  1830  	struct device_node *np = pdev->dev.of_node;
3178d58e0b9772 Herve Codina 2023-02-17  1831  	unsigned int nb_chans;
3178d58e0b9772 Herve Codina 2023-02-17  1832  	struct qmc *qmc;
3178d58e0b9772 Herve Codina 2023-02-17  1833  	int irq;
3178d58e0b9772 Herve Codina 2023-02-17  1834  	int ret;
3178d58e0b9772 Herve Codina 2023-02-17  1835  
3178d58e0b9772 Herve Codina 2023-02-17  1836  	qmc = devm_kzalloc(&pdev->dev, sizeof(*qmc), GFP_KERNEL);
3178d58e0b9772 Herve Codina 2023-02-17  1837  	if (!qmc)
3178d58e0b9772 Herve Codina 2023-02-17  1838  		return -ENOMEM;
3178d58e0b9772 Herve Codina 2023-02-17  1839  
3178d58e0b9772 Herve Codina 2023-02-17  1840  	qmc->dev = &pdev->dev;
d23ae9f1815e89 Herve Codina 2024-08-08  1841  	qmc->data = of_device_get_match_data(&pdev->dev);
d23ae9f1815e89 Herve Codina 2024-08-08  1842  	if (!qmc->data) {
d23ae9f1815e89 Herve Codina 2024-08-08  1843  		dev_err(qmc->dev, "Missing match data\n");
d23ae9f1815e89 Herve Codina 2024-08-08  1844  		return -EINVAL;
d23ae9f1815e89 Herve Codina 2024-08-08  1845  	}
3178d58e0b9772 Herve Codina 2023-02-17  1846  	INIT_LIST_HEAD(&qmc->chan_head);
3178d58e0b9772 Herve Codina 2023-02-17  1847  
a13bf605342ea9 Herve Codina 2024-08-08  1848  	qmc->tsa_serial = devm_tsa_serial_get_byphandle(qmc->dev, np, "fsl,tsa-serial");
a13bf605342ea9 Herve Codina 2024-08-08  1849  	if (IS_ERR(qmc->tsa_serial)) {
a13bf605342ea9 Herve Codina 2024-08-08  1850  		return dev_err_probe(qmc->dev, PTR_ERR(qmc->tsa_serial),
a13bf605342ea9 Herve Codina 2024-08-08  1851  				     "Failed to get TSA serial\n");
a13bf605342ea9 Herve Codina 2024-08-08  1852  	}
a13bf605342ea9 Herve Codina 2024-08-08  1853  
727b3ab490a5f5 Herve Codina 2024-08-08  1854  	ret = qmc_init_resources(qmc, pdev);
727b3ab490a5f5 Herve Codina 2024-08-08  1855  	if (ret)
727b3ab490a5f5 Herve Codina 2024-08-08  1856  		return ret;
3178d58e0b9772 Herve Codina 2023-02-17  1857  
3178d58e0b9772 Herve Codina 2023-02-17  1858  	/* Parse channels informationss */
3178d58e0b9772 Herve Codina 2023-02-17  1859  	ret = qmc_of_parse_chans(qmc, np);
3178d58e0b9772 Herve Codina 2023-02-17  1860  	if (ret)
a13bf605342ea9 Herve Codina 2024-08-08  1861  		return ret;
3178d58e0b9772 Herve Codina 2023-02-17  1862  
3178d58e0b9772 Herve Codina 2023-02-17  1863  	nb_chans = qmc_nb_chans(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1864  
3178d58e0b9772 Herve Codina 2023-02-17  1865  	/*
3178d58e0b9772 Herve Codina 2023-02-17  1866  	 * Allocate the buffer descriptor table
3178d58e0b9772 Herve Codina 2023-02-17  1867  	 * 8 rx and 8 tx descriptors per channel
3178d58e0b9772 Herve Codina 2023-02-17  1868  	 */
3178d58e0b9772 Herve Codina 2023-02-17  1869  	qmc->bd_size = (nb_chans * (QMC_NB_TXBDS + QMC_NB_RXBDS)) * sizeof(cbd_t);
3178d58e0b9772 Herve Codina 2023-02-17  1870  	qmc->bd_table = dmam_alloc_coherent(qmc->dev, qmc->bd_size,
3178d58e0b9772 Herve Codina 2023-02-17  1871  					    &qmc->bd_dma_addr, GFP_KERNEL);
3178d58e0b9772 Herve Codina 2023-02-17  1872  	if (!qmc->bd_table) {
3178d58e0b9772 Herve Codina 2023-02-17  1873  		dev_err(qmc->dev, "Failed to allocate bd table\n");
a13bf605342ea9 Herve Codina 2024-08-08  1874  		return -ENOMEM;
3178d58e0b9772 Herve Codina 2023-02-17  1875  	}
3178d58e0b9772 Herve Codina 2023-02-17  1876  	memset(qmc->bd_table, 0, qmc->bd_size);
3178d58e0b9772 Herve Codina 2023-02-17  1877  
3178d58e0b9772 Herve Codina 2023-02-17  1878  	qmc_write32(qmc->scc_pram + QMC_GBL_MCBASE, qmc->bd_dma_addr);
3178d58e0b9772 Herve Codina 2023-02-17  1879  
3178d58e0b9772 Herve Codina 2023-02-17  1880  	/* Allocate the interrupt table */
3178d58e0b9772 Herve Codina 2023-02-17  1881  	qmc->int_size = QMC_NB_INTS * sizeof(u16);
3178d58e0b9772 Herve Codina 2023-02-17  1882  	qmc->int_table = dmam_alloc_coherent(qmc->dev, qmc->int_size,
3178d58e0b9772 Herve Codina 2023-02-17  1883  					     &qmc->int_dma_addr, GFP_KERNEL);
3178d58e0b9772 Herve Codina 2023-02-17  1884  	if (!qmc->int_table) {
3178d58e0b9772 Herve Codina 2023-02-17  1885  		dev_err(qmc->dev, "Failed to allocate interrupt table\n");
a13bf605342ea9 Herve Codina 2024-08-08  1886  		return -ENOMEM;
3178d58e0b9772 Herve Codina 2023-02-17  1887  	}
3178d58e0b9772 Herve Codina 2023-02-17  1888  	memset(qmc->int_table, 0, qmc->int_size);
3178d58e0b9772 Herve Codina 2023-02-17  1889  
3178d58e0b9772 Herve Codina 2023-02-17  1890  	qmc->int_curr = qmc->int_table;
3178d58e0b9772 Herve Codina 2023-02-17  1891  	qmc_write32(qmc->scc_pram + QMC_GBL_INTBASE, qmc->int_dma_addr);
3178d58e0b9772 Herve Codina 2023-02-17  1892  	qmc_write32(qmc->scc_pram + QMC_GBL_INTPTR, qmc->int_dma_addr);
3178d58e0b9772 Herve Codina 2023-02-17  1893  
3178d58e0b9772 Herve Codina 2023-02-17  1894  	/* Set MRBLR (valid for HDLC only) max MRU + max CRC */
3178d58e0b9772 Herve Codina 2023-02-17  1895  	qmc_write16(qmc->scc_pram + QMC_GBL_MRBLR, HDLC_MAX_MRU + 4);
3178d58e0b9772 Herve Codina 2023-02-17  1896  
3178d58e0b9772 Herve Codina 2023-02-17  1897  	qmc_write16(qmc->scc_pram + QMC_GBL_GRFTHR, 1);
3178d58e0b9772 Herve Codina 2023-02-17  1898  	qmc_write16(qmc->scc_pram + QMC_GBL_GRFCNT, 1);
3178d58e0b9772 Herve Codina 2023-02-17  1899  
3178d58e0b9772 Herve Codina 2023-02-17  1900  	qmc_write32(qmc->scc_pram + QMC_GBL_C_MASK32, 0xDEBB20E3);
3178d58e0b9772 Herve Codina 2023-02-17  1901  	qmc_write16(qmc->scc_pram + QMC_GBL_C_MASK16, 0xF0B8);
3178d58e0b9772 Herve Codina 2023-02-17  1902  
eb680d563089e5 Herve Codina 2024-08-08  1903  	if (qmc_is_qe(qmc)) {
eb680d563089e5 Herve Codina 2024-08-08  1904  		/* Zeroed the reserved area */
eb680d563089e5 Herve Codina 2024-08-08  1905  		memset_io(qmc->scc_pram + QMC_QE_GBL_RSV_B0_START, 0,
eb680d563089e5 Herve Codina 2024-08-08  1906  			  QMC_QE_GBL_RSV_B0_SIZE);
eb680d563089e5 Herve Codina 2024-08-08  1907  
eb680d563089e5 Herve Codina 2024-08-08  1908  		qmc_write32(qmc->scc_pram + QMC_QE_GBL_GCSBASE, qmc->dpram_offset);
eb680d563089e5 Herve Codina 2024-08-08  1909  
eb680d563089e5 Herve Codina 2024-08-08  1910  		/* Init 'framer parameters' area and set the base addresses */
eb680d563089e5 Herve Codina 2024-08-08  1911  		memset_io(qmc->scc_pram + UCC_SLOW_PRAM_SIZE, 0x01, 64);
eb680d563089e5 Herve Codina 2024-08-08  1912  		memset_io(qmc->scc_pram + UCC_SLOW_PRAM_SIZE + 64, 0x01, 64);
eb680d563089e5 Herve Codina 2024-08-08  1913  		qmc_write16(qmc->scc_pram + QMC_QE_GBL_RX_FRM_BASE,
eb680d563089e5 Herve Codina 2024-08-08  1914  			    qmc->scc_pram_offset + UCC_SLOW_PRAM_SIZE);
eb680d563089e5 Herve Codina 2024-08-08  1915  		qmc_write16(qmc->scc_pram + QMC_QE_GBL_TX_FRM_BASE,
eb680d563089e5 Herve Codina 2024-08-08  1916  			    qmc->scc_pram_offset + UCC_SLOW_PRAM_SIZE + 64);
eb680d563089e5 Herve Codina 2024-08-08  1917  	}
eb680d563089e5 Herve Codina 2024-08-08  1918  
2d965e25fa4180 Herve Codina 2023-12-05  1919  	ret = qmc_init_tsa(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1920  	if (ret)
a13bf605342ea9 Herve Codina 2024-08-08  1921  		return ret;
3178d58e0b9772 Herve Codina 2023-02-17  1922  
3178d58e0b9772 Herve Codina 2023-02-17  1923  	qmc_write16(qmc->scc_pram + QMC_GBL_QMCSTATE, 0x8000);
3178d58e0b9772 Herve Codina 2023-02-17  1924  
3178d58e0b9772 Herve Codina 2023-02-17  1925  	ret = qmc_setup_chans(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1926  	if (ret)
a13bf605342ea9 Herve Codina 2024-08-08  1927  		return ret;
3178d58e0b9772 Herve Codina 2023-02-17  1928  
3178d58e0b9772 Herve Codina 2023-02-17  1929  	/* Init interrupts table */
3178d58e0b9772 Herve Codina 2023-02-17  1930  	ret = qmc_setup_ints(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1931  	if (ret)
a13bf605342ea9 Herve Codina 2024-08-08  1932  		return ret;
a13bf605342ea9 Herve Codina 2024-08-08  1933  
eb680d563089e5 Herve Codina 2024-08-08  1934  	/* Init SCC (CPM1) or UCC (QE) */
de5fdb7d14b34f Herve Codina 2024-08-08  1935  	ret = qmc_init_xcc(qmc);
de5fdb7d14b34f Herve Codina 2024-08-08  1936  	if (ret)
a13bf605342ea9 Herve Codina 2024-08-08  1937  		return ret;
a13bf605342ea9 Herve Codina 2024-08-08  1938  
de5fdb7d14b34f Herve Codina 2024-08-08  1939  	/* Set the irq handler */
3178d58e0b9772 Herve Codina 2023-02-17  1940  	irq = platform_get_irq(pdev, 0);
3178d58e0b9772 Herve Codina 2023-02-17  1941  	if (irq < 0)
de5fdb7d14b34f Herve Codina 2024-08-08 @1942  		goto err_exit_xcc;

ret = irq;

3178d58e0b9772 Herve Codina 2023-02-17  1943  	ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1944  	if (ret < 0)
de5fdb7d14b34f Herve Codina 2024-08-08  1945  		goto err_exit_xcc;
3178d58e0b9772 Herve Codina 2023-02-17  1946  
3178d58e0b9772 Herve Codina 2023-02-17  1947  	/* Enable interrupts */
3178d58e0b9772 Herve Codina 2023-02-17  1948  	qmc_write16(qmc->scc_regs + SCC_SCCM,
3178d58e0b9772 Herve Codina 2023-02-17  1949  		    SCC_SCCE_IQOV | SCC_SCCE_GINT | SCC_SCCE_GUN | SCC_SCCE_GOV);
3178d58e0b9772 Herve Codina 2023-02-17  1950  
3178d58e0b9772 Herve Codina 2023-02-17  1951  	ret = qmc_finalize_chans(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1952  	if (ret < 0)
3178d58e0b9772 Herve Codina 2023-02-17  1953  		goto err_disable_intr;
3178d58e0b9772 Herve Codina 2023-02-17  1954  
e49dd637e02589 Herve Codina 2024-08-08  1955  	/* Enable transmitter and receiver */
3178d58e0b9772 Herve Codina 2023-02-17  1956  	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
3178d58e0b9772 Herve Codina 2023-02-17  1957  
3178d58e0b9772 Herve Codina 2023-02-17  1958  	platform_set_drvdata(pdev, qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1959  
ba3b7e4753c5ad Herve Codina 2023-12-05  1960  	/* Populate channel related devices */
ba3b7e4753c5ad Herve Codina 2023-12-05  1961  	ret = devm_of_platform_populate(qmc->dev);
ba3b7e4753c5ad Herve Codina 2023-12-05  1962  	if (ret)
ba3b7e4753c5ad Herve Codina 2023-12-05  1963  		goto err_disable_txrx;
ba3b7e4753c5ad Herve Codina 2023-12-05  1964  
3178d58e0b9772 Herve Codina 2023-02-17  1965  	return 0;
3178d58e0b9772 Herve Codina 2023-02-17  1966  
ba3b7e4753c5ad Herve Codina 2023-12-05  1967  err_disable_txrx:
ba3b7e4753c5ad Herve Codina 2023-12-05  1968  	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, 0);
ba3b7e4753c5ad Herve Codina 2023-12-05  1969  
3178d58e0b9772 Herve Codina 2023-02-17  1970  err_disable_intr:
3178d58e0b9772 Herve Codina 2023-02-17  1971  	qmc_write16(qmc->scc_regs + SCC_SCCM, 0);
3178d58e0b9772 Herve Codina 2023-02-17  1972  
de5fdb7d14b34f Herve Codina 2024-08-08  1973  err_exit_xcc:
de5fdb7d14b34f Herve Codina 2024-08-08  1974  	qmc_exit_xcc(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1975  	return ret;
3178d58e0b9772 Herve Codina 2023-02-17  1976  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


