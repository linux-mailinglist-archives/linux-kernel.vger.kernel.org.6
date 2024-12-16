Return-Path: <linux-kernel+bounces-446814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDC9F297B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC16018855E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68531C07C0;
	Mon, 16 Dec 2024 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUG9tTOi"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1718A92C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734326481; cv=none; b=J4RudlDKDbuVlQUvQTkiqZJaoSi+WpddOsZJzOLkjPsmzQRLYR9mCNwVggKUs0PJEK6It3K7JUq8nGz0VLyY1jSH1/5XB2GYtEBXlYGZd7sETeJZa9UxT49eVXIYXW69uYI1NihIn0DHIwKueTpqhLwFZv1t5eXK2q0DTLJytAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734326481; c=relaxed/simple;
	bh=Y8BBnzSAQCrOq/vZCN+HTxvR9YBoCNxrtJ37hzJJipE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4g95nVlzxwzMhrb+4bmuxHLeWbY1ltuZTC0zezfm9riiU6aVvNvpjYOvsHs/ZCO1YKVrQeqAfuUetD7xA8QCo7bZfI8ckqhsjKjl1El1eqW6T/wI0iHf6B+UgG2y4TrFVyYc3If3U8Q2qmKjLJf3x5uVfAHpczxpZbSKavKFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUG9tTOi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso2677200b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 21:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734326478; x=1734931278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dODE1oLOneIGU2zuf4IE3qsFOnpfwOB30wuyhRbPCE=;
        b=cUG9tTOiww1RjLO67ZF7MZEBx2ZWhWnzPi/yxjBMmDuekjT8o3yKrvJMMLid22EiH8
         4Fh6xrtWO5jAqEHa9z3/fP3PG1YKX7+sQM2ddvQWEMcezqf3rQVrpLMcTGndJWKL6zlc
         5XhXN0etfUEgWGRHOwlsH6ig1kqVd1SidyMLiNyw5PuQivJb5HX1oYF/CRg3hT9FKA6A
         ASaE1OFJZ9zTYD4+WEzhx7p7M4+ky72RFoR49kauCnLVkZoFmTOF8ceyOd262C6ldK7w
         PihgrHJrSbgOMShVw2ERnk0B+3uxmE0hI3ED05KglhpHWPRY2miDrySLJdTsdtEEeT9o
         Pfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734326478; x=1734931278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dODE1oLOneIGU2zuf4IE3qsFOnpfwOB30wuyhRbPCE=;
        b=D/IiZrKDJilNaXXP3Mu3837MUb4o7tPuStN5YAZCP/uM0SwhyxJIJUIuwDMOA5b8An
         sCHRIczEmk0ArwkTyrI5a+PySrGvxoe3eXYhYEJKkfhjKD3X6vfWf1BN5wlT1ETf/MBn
         s97vmOJb57viBVe6JZrDdUSr4p6RQWxJby4tROoCQnUSQBFqmFVcWxCorkIqFe1/gH6W
         fbqGmcwadoEOoMwpn1Np8Es15nn/1yUjaHHxvYy4AoQEJWnlEM3OMIXBxOIjACrzQKks
         0ZTkb4jEjAvNNfbH5ZSUWyd+aZUDBUvDpLcN4/1btL+rlmSI1IT4kV9i3A9N3PCktJHB
         hQtA==
X-Forwarded-Encrypted: i=1; AJvYcCUlAKrRmyv1ZVg51r+xp3cjdMhcpkywc2VOWtr4Sec2bgiHl3HkKd+2DrdQSiU4aym5rnDsB6kbKgDs+gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhMaRTTIBSnLmfdj1ebwfe0rLAiS7RF6J7XLNAHWUL8q6LHZJ
	6KBFxKZgLLZQY3FYbMfajCmWO6GC4pdtGDIl8l5m9zuGaKTEOXiS9qLGGkoHGA==
X-Gm-Gg: ASbGncuPe+PwT0y8ay8bG3q4lnZ/uAhtKu3IUnTYnMV5bib6RMmdpBbGtjUD0CpRQmt
	qJLynkCsy915Jnw8Rd0yj8/KhJ7xupEqITmgf86IUQ/mg3poIKIogLEqna34Ca+d+G7jc19zKBT
	+KFJFbV5v7tEYwKCntOqzUK1h/MZxkH5Is/fzuMv+dJGDXIN2CdVyT3ydHhZw4dP81WA+33oeAu
	IKMeVCAHwiSxJyk6EYMNaXZ/1M/kTxe9zxhtk3LCJjIbH3bxJvViTiJqk7zydq6a9g=
X-Google-Smtp-Source: AGHT+IH1mSVhE67FzmlPZUxDT5sePvi+vkzZfYMDKYk51As1yvOgwpFk9uK6IoSy8DGi01snoWjo4g==
X-Received: by 2002:a17:902:d2c5:b0:215:97a3:5ec5 with SMTP id d9443c01a7336-218929c8eccmr158587875ad.22.1734326478043;
        Sun, 15 Dec 2024 21:21:18 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6416csm34490965ad.230.2024.12.15.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:21:17 -0800 (PST)
Date: Mon, 16 Dec 2024 10:51:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 0/4] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
Message-ID: <20241216052107.tyhwzh4g3tmnp5ll@thinkpad>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <c5c9b7fc-a484-438a-aa97-35785f25d576@quicinc.com>
 <Z18SkkuPbVgTYD8k@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z18SkkuPbVgTYD8k@wunner.de>

On Sun, Dec 15, 2024 at 06:32:02PM +0100, Lukas Wunner wrote:
> On Wed, Dec 11, 2024 at 05:55:48PM +0800, Qiang Yu wrote:
> > PCIe3 is able to link up after applying your patch. Slot power is turned on
> > correctly.
> > But see "NULL pointer dereference" when I try to remove device.
> 
> There's a WARN splat occurring before the NULL pointer deref.
> Was this happening before or is it new?  Probably makes sense
> to debug that first before looking into the NULL pointer deref,
> which could be a result of it.
> 

Precisely.

> 
> > [   38.757726] WARNING: CPU: 1 PID: 816 at drivers/regulator/core.c:5857
> > regulator_unregister+0x13c/0x160
> > [   38.767288] Modules linked in: phy_qcom_qmp_combo aux_bridge
> > drm_kms_helper drm nvme backlight pinctrl_sm8550_lpass_lpi pci_pwrctl_slot
> > pci_pwrctrl_core nvme_core phy_qcom_edp phy_qcom_eusb2_repeater
> > dispcc_x1e80100 pinctrl_lpass_lpi phy_qcom_snps_eusb2 lpasscc_sc8280xp typec
> > gpucc_x1e80100 phy_qcom_qmp_pcie
> > [   38.795279] CPU: 1 UID: 0 PID: 816 Comm: bash Not tainted
> > 6.12.0-next-20241128-00005-g6178bf6ce3c2-dirty #50
> > [   38.805359] Hardware name: Qualcomm IDP, BIOS
> > 6.0.240607.BOOT.MXF.2.4-00348.1-HAMOA-1.67705.7 06/ 7/2024
> > [   38.815088] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS
> > BTYPE=--)
> > [   38.822239] pc : regulator_unregister+0x13c/0x160
> > [   38.827081] lr : regulator_unregister+0xc0/0x160
> 
> The WARN splat seems to be caused by:
> 
> 	WARN_ON(rdev->open_count);
> 
> So the regulator is unregistered although it's still in use.
> Is there maybe a multifunction PCIe device in your system
> so that multiple devices are using the same regulator?
> 

Maybe the regulator is shared with other peripherals (not just PCIe) in the
system.

@Qiang: I referred your patch [1] that added the slot regulators, but they were
not used by any peripherals other than PCIe. Could you please post the list of
consumers of the 3 slot regulators?

FYI, I did test root port remove on RB5 board (with dummy fixed regulators) and
it worked fine.

- Mani

[1] https://lore.kernel.org/linux-pci/20240827063631.3932971-8-quic_qianyu@quicinc.com/

-- 
மணிவண்ணன் சதாசிவம்

