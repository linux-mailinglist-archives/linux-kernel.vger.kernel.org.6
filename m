Return-Path: <linux-kernel+bounces-332225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8397B6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672251F243ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527F13B787;
	Wed, 18 Sep 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq/BsGOK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2910A1C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726628035; cv=none; b=KECvkuiTyr8+LceD/C9Zf/ubJEepBq43dc5Z0WamWI/1F2K9HVOMckiX3f276M7sTZ61hAeqE+P6A51XGM3pmy/wgu3IW9nNR5hmnT3jArsPw783Rlmc2fOSJh9Vnm81NdmcPZ/X2ev8LHjwC7PKts175KYzAS6FdhqUhhBmCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726628035; c=relaxed/simple;
	bh=493amnIszNjCMC/P1OMb5Xw35lcHRwJE7mk1e3OL0GQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=TbZUoxoI/87xDLJjXuLP1rm6vIZxIXZ7tMcBezGTepY+599GpoK+IFE68wxW6CvyrRhMzmBdDZ/oqas25p9t1c+FSIe4jH4OjfBEPdDMq6T3GsE56obgSagCEIwpz17MYSpS3DqB0umXjvwfUc8eVsSUMjzjGggz7TKYU+QHp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq/BsGOK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053f6b8201so60251875ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726628033; x=1727232833; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWZ3qcTMi/V1RAhpylJg9TiYZi40Z2/VWqsDBDLTX80=;
        b=Uq/BsGOKTy+IsdEuigzZw45eNGplswB8eOCMgxmXdEFQo6H3N4xarhmJ9SQ52KBVDV
         PYxldRrDmiFFfQhhNflzhuNhrzkCWgRBbnV/Fw0ejgwVRdy3AdJE8VP7V2jRo2piPdr+
         nx747u/OlltqALbuJzjsRPXTtVdtrsO0Ng+YIsiHV37sQX0yq+ds+7VZSEZqJLvE2CUR
         4C+XaTx33ou7Bdp51H2pEeQdeB8Du+5XAlAE3ic4aifovgOXRAgbNUyFmZrK0sTTMog+
         IVEUVkrW9ZI22c2ARTGjome8sNZi9X1ZiQJk4RFZfXW1Pzc9hwMFW9+Vj1G2+pnbCMN9
         IPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726628033; x=1727232833;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWZ3qcTMi/V1RAhpylJg9TiYZi40Z2/VWqsDBDLTX80=;
        b=agFk28+F+EPg9AQF21J5n35ZtsYytLGHAlsnzupD96tmZ7KEQUoqjOJYfQT5FP9N4c
         ZiIuMj2sCfyXxyQqqWdsqbVC3q4M1TL/v/DbX5GlOMLgGLpz+63BqCsaglU0fWIw8QSI
         HXlRFJv4y3unGKNtPx/8WXVmP7FwHoQkl16T2/rzph6sDnQtHYql6Eydt90vFh9tv331
         0UGCspnPGYZ3zeCpO6rZg+CbNNlxBa+YQgWiEwLM6PeadZtrSDTWTeJRWik+EaAET/65
         AAseo4F0IvQlV8DCLs3u5OQ6JQCbAt692de9fj+9vvnYIR02ixw8fMA8eGqQexxjtTSf
         TmFg==
X-Forwarded-Encrypted: i=1; AJvYcCVbw5qtSVKl8VrSEZ0ugnll40G4Kj9KeL1Se6H4ovJgtHTVvKk+kZZ3cAbvuJ1/DVqGwMUEzGoQ0bhZSw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4lBP3ifu6TnZRqzIhcSwRYt/hw4dmdvv8pIg8vY8poZ3Csm7
	uqBPyd1gmZoO+rC+O86gbANhxnXl/xugGFEB3mAKghgP0i1SL8jJUHW22g==
X-Google-Smtp-Source: AGHT+IGKGWYruuAC6rL2FMLKK+SZlN2gY4arKU4qgCeD621ynurim1YEbscPsFKq5JQECLbkqScxkQ==
X-Received: by 2002:a17:903:2304:b0:202:4cd2:d6e4 with SMTP id d9443c01a7336-2076e36157emr331090675ad.24.1726628033104;
        Tue, 17 Sep 2024 19:53:53 -0700 (PDT)
Received: from dw-tp ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da788sm56252145ad.18.2024.09.17.19.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 19:53:52 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries/eeh: move pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block
In-Reply-To: <20240917132445.3868016-1-nnmlinux@linux.ibm.com>
Date: Wed, 18 Sep 2024 08:03:56 +0530
Message-ID: <871q1hbsh7.fsf@gmail.com>
References: <20240917132445.3868016-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> Makes pseries_eeh_err_inject() available even when debugfs
> is disabled (CONFIG_DEBUG_FS=n). It moves eeh_debugfs_break_device()
> and eeh_pe_inject_mmio_error() out of the CONFIG_DEBUG_FS block
> and renames it as eeh_break_device().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409170509.VWC6jadC-lkp@intel.com/
> Fixes: b0e2b828dfca ("powerpc/pseries/eeh: Fix pseries_eeh_err_inject")
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  arch/powerpc/kernel/eeh.c | 198 +++++++++++++++++++-------------------
>  1 file changed, 99 insertions(+), 99 deletions(-)

Ok, so in your original patch you implemented eeh_inject ops for pseries
using mmio based eeh error injection (eeh_pe_inject_mmio_error()), which
uses the functions defined under debugfs -> eeh_debugfs_break_device(). 

This was failing when CONFIG_DEBUGFS is not defined, thus referring to
undefined function definition. 

Minor nit below.

>
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 49ab11a287a3..0fe25e907ea6 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1574,6 +1574,104 @@ static int proc_eeh_show(struct seq_file *m, void *v)
>  }
>  #endif /* CONFIG_PROC_FS */
>  
> +static int eeh_break_device(struct pci_dev *pdev)
> +{
> +	struct resource *bar = NULL;
> +	void __iomem *mapped;
> +	u16 old, bit;
> +	int i, pos;
> +
> +	/* Do we have an MMIO BAR to disable? */
> +	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
> +		struct resource *r = &pdev->resource[i];
> +
> +		if (!r->flags || !r->start)
> +			continue;
> +		if (r->flags & IORESOURCE_IO)
> +			continue;
> +		if (r->flags & IORESOURCE_UNSET)
> +			continue;
> +
> +		bar = r;
> +		break;
> +	}
> +
> +	if (!bar) {
> +		pci_err(pdev, "Unable to find Memory BAR to cause EEH with\n");
> +		return -ENXIO;
> +	}
> +
> +	pci_err(pdev, "Going to break: %pR\n", bar);
> +
> +	if (pdev->is_virtfn) {
> +#ifndef CONFIG_PCI_IOV
> +		return -ENXIO;
> +#else
> +		/*
> +		 * VFs don't have a per-function COMMAND register, so the best
> +		 * we can do is clear the Memory Space Enable bit in the PF's
> +		 * SRIOV control reg.
> +		 *
> +		 * Unfortunately, this requires that we have a PF (i.e doesn't
> +		 * work for a passed-through VF) and it has the potential side
> +		 * effect of also causing an EEH on every other VF under the
> +		 * PF. Oh well.
> +		 */
> +		pdev = pdev->physfn;
> +		if (!pdev)
> +			return -ENXIO; /* passed through VFs have no PF */
> +
> +		pos  = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> +		pos += PCI_SRIOV_CTRL;
> +		bit  = PCI_SRIOV_CTRL_MSE;
> +#endif /* !CONFIG_PCI_IOV */
> +	} else {
> +		bit = PCI_COMMAND_MEMORY;
> +		pos = PCI_COMMAND;
> +	}
> +
> +	/*
> +	 * Process here is:
> +	 *
> +	 * 1. Disable Memory space.
> +	 *
> +	 * 2. Perform an MMIO to the device. This should result in an error
> +	 *    (CA  / UR) being raised by the device which results in an EEH
> +	 *    PE freeze. Using the in_8() accessor skips the eeh detection hook
> +	 *    so the freeze hook so the EEH Detection machinery won't be
> +	 *    triggered here. This is to match the usual behaviour of EEH
> +	 *    where the HW will asynchronously freeze a PE and it's up to
> +	 *    the kernel to notice and deal with it.
> +	 *
> +	 * 3. Turn Memory space back on. This is more important for VFs
> +	 *    since recovery will probably fail if we don't. For normal
> +	 *    the COMMAND register is reset as a part of re-initialising
> +	 *    the device.
> +	 *
> +	 * Breaking stuff is the point so who cares if it's racy ;)
> +	 */
> +	pci_read_config_word(pdev, pos, &old);
> +
> +	mapped = ioremap(bar->start, PAGE_SIZE);
> +	if (!mapped) {
> +		pci_err(pdev, "Unable to map MMIO BAR %pR\n", bar);
> +		return -ENXIO;
> +	}
> +
> +	pci_write_config_word(pdev, pos, old & ~bit);
> +	in_8(mapped);
> +	pci_write_config_word(pdev, pos, old);
> +
> +	iounmap(mapped);
> +
> +	return 0;
> +}
> +
> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
> +{
> +	return eeh_break_device(pdev);
> +}
> +

Why have an extra eeh_pe_inject_mmio_error() function which only calls
eeh_break_device()?

Maybe we can rename eeh_break_device() to eeh_mmio_break_device() and use
this function itself at both call sites?

-ritesh

