Return-Path: <linux-kernel+bounces-187471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC38CD248
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BFA1F21FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6714882E;
	Thu, 23 May 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXmD2pVG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7113BAD5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467441; cv=none; b=ZGZ8mINrLzkVfySuBFYMHsZBhKULrH+zCAiZmDSvtjAKCKrqhIlO+iM9DEmduPdVdt9ibdMPqCN/Fnlc5DYVePij3yF8ZvvoI+EKCVNt9LMZPLnzNf18vBk/f0fU60X6m0mzhQPw2GW+arnfGddu42eKZQ3R0v5g7aUkNc4gZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467441; c=relaxed/simple;
	bh=Bjz/ig/gLbIXoRDfEEu5wQSlFToKNYmRgh2HDGqS07I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nqDdNRLV4CMl8xOHRKdOyOKdVX6kOmdgXhUKCtTu8cJ+juUHEgewmlSvKuX7nJ1oNAE6QKPKO1kmKLwtr/7qdQSHrFHKnA7IkSyxA3LTq2xk78Vc9aQvrt5IlsM4pGf4wLaBVa34oqlI8wwPGDE1Q7yodTSnRLPG+iHWTwkb8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PXmD2pVG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4200ee47de7so53036135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716467437; x=1717072237; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxpjAXqiH/+EfsCOuAq8y02ih0xRop+9c4sjd7YvDrY=;
        b=PXmD2pVGq1u/U5yQD5U8MGlRv5v9/c/YXUoU8aYPNTZHaESyyjpWm8pWGMzNfx8TDF
         wm4xWy2OK/i0ACrUvljVg3xlyMcz2oekQctCdt9ZqrbvRn0Q0uQBxeJ1fNSXEvJQwcjx
         Hrc1pnBn0jqkecuVtw78uRvvClHU2OOrvRTXolxVvMe01/gdSLSxv0yEZSTk4Ip3FHzC
         gQ9xWKsq7m32CI8CSy1SZRj39+tvzAqHsXy18GrCdPnOC6y90I3sbnMzfkxB9H9lQGoi
         6hFXnQAtC3Mo5ZH8xdG32/FFuqxjSWEHj4Dhewb1rG10gR/eBLpAjwvUWBN7H31ixm0t
         27Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716467437; x=1717072237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxpjAXqiH/+EfsCOuAq8y02ih0xRop+9c4sjd7YvDrY=;
        b=ZwhApsvCd0mZ7nhRUCTdleUzlAlFhy6uQ/utrhViY4FCgBy322a9/XFwi99l4xSgNM
         j4xyywCYI9XPPD16RVLp0/GR8jdJHH9SeRCuI7vI2WIQsEONyQ1v0RRh2s0DMjK/qpUC
         HKTQwhr1xrtyZwRB9wOXoMK1Xjmi8g/mMr5xFqmqcJkWPl+PeecPMUEPeYW9d3Nk1aPP
         AwUMYnIbAu1TGVl015uLAMEClWTnVIGnw/ihJ01RjZ1e4TdDZqyZLKKjB930N8B5dDCV
         /fnsmQpDyLzTLkEM5F9eU7O1o9/exTjPsqPpcQKOpWYdDVJJxCakmkjhmv4h/7VgOA9U
         1ZwA==
X-Forwarded-Encrypted: i=1; AJvYcCXXvIY9alG/d0dOUOKV65yst5mJ45tgyglTSCFLn1k8pvfbgN+plZTgcyWP8yrMk4TewBvaiaRXtnkEJK31fnZeAvrzTA+r/DE6kDrN
X-Gm-Message-State: AOJu0YyIiqhlWUpxAgx5oxGrh5PAZBSwHjfJ2Zu+QU2yfzEA2+2ENCm0
	404aEXn6tdfbre18yD8fcuRagRIOdojuicJhzyu/ctbFJ4Q9aO0ZX8x0XvyCBw4=
X-Google-Smtp-Source: AGHT+IHsPYPK5nLhbLq8ov1G8vIMZXbft1sDAvZ24WiHuV5r2ypulRQGNKivfF6NhXredx7u8RAeDg==
X-Received: by 2002:a05:600c:1c15:b0:418:5ed2:5aa6 with SMTP id 5b1f17b1804b1-420fd34d36bmr38811025e9.31.1716467436686;
        Thu, 23 May 2024 05:30:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f7c047sm24088605e9.26.2024.05.23.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:30:36 -0700 (PDT)
Date: Thu, 23 May 2024 15:30:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Kiran K <kiran.k@intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Chandrashekar <chandrashekar.devegowda@intel.com>
Subject: drivers/bluetooth/btintel_pcie.c:386 btintel_pcie_recv_frame() warn:
 variable dereferenced before check 'data' (see line 380)
Message-ID: <7446b314-53f8-4ec7-9ff7-ae47defc43fb@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ea5f6ad9ad9645733b72ab53a98e719b460d36a6
commit: 6e65a09f927566f257322358d429b267548473eb Bluetooth: btintel_pcie: Add *setup* function to download firmware
config: alpha-randconfig-r081-20240516 (https://download.01.org/0day-ci/archive/20240517/202405170424.97VIwnBn-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405170424.97VIwnBn-lkp@intel.com/

smatch warnings:
drivers/bluetooth/btintel_pcie.c:386 btintel_pcie_recv_frame() warn: variable dereferenced before check 'data' (see line 380)

vim +/data +386 drivers/bluetooth/btintel_pcie.c

6e65a09f927566 Kiran K          2024-05-07  371  static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  372  				       struct sk_buff *skb)
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  373  {
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  374  	int ret;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  375  	u8 pkt_type;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  376  	u16 plen;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  377  	u32 pcie_pkt_type;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  378  	struct sk_buff *new_skb;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  379  	void *pdata;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07 @380  	struct hci_dev *hdev = data->hdev;
                                                                               ^^^^^^^^^^
data dereferenced

c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  381  
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  382  	spin_lock(&data->hci_rx_lock);
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  383  
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  384  	/* The first 4 bytes indicates the Intel PCIe specific packet type */
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  385  	pdata = skb_pull_data(skb, BTINTEL_PCIE_HCI_TYPE_LEN);
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07 @386  	if (!data) {
                                                            ^^^^^
Presumably this was supposed to check "pdata".

c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  387  		bt_dev_err(hdev, "Corrupted packet received");
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  388  		ret = -EILSEQ;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  389  		goto exit_error;
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  390  	}
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  391  
c2b636b3f788d1 Tedd Ho-Jeong An 2024-05-07  392  	pcie_pkt_type = get_unaligned_le32(pdata);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


