Return-Path: <linux-kernel+bounces-261762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C093BBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192691C2384E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008111B94F;
	Thu, 25 Jul 2024 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5itf1fE"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59441862C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882901; cv=none; b=dROPQUPjsc/oAaqzya8z+L/4+6r2hy2dIR1UcD3G/SiqyfcNItMHJbo0KVa8Sb+5+k2UqVEiCfxXI0PDOg15mARWH/NMMttFPDgUrlNskcezCd9EFDZ+yLPltwq0YC++PntaSISoSUrws7hPNbjyYnKfMSwzdEmVv7jg1vnQfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882901; c=relaxed/simple;
	bh=4tkzV4CrdLGLyLxeqqrIR9odUjTIIvuyAKEAUZasaog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOqb4NuP7oFTJBM3h1btdbeI8kMrKKTcEalwfr2igijanTy5Z9rG1uHDvTTCm2ZM/KXQH1bwuoX2zQEMixeo7WBFzl3KwY+KldOwYUZ9iDrtYLF3ZxSBJwxCPzsTU72jZFp0YQCKce2oeZwFhAmGoHVp3JQw34vRaIe5/bIaKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5itf1fE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-793a3a79a83so335529a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882899; x=1722487699; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuLrTOMZXwDvrh3Gcss0q0VIdIl/tmC7R+/hGCD5mQk=;
        b=n5itf1fEcC/Fe1QSCWu9b0tXh85FplQ3qRWFHq5FctPL8exhYKOpMOt/iFFstZlTcE
         ozGlzgHcVy01s9nzZ+iYgDSNTNYId+ntYgigCKBrf9njRzJEf75QlXvIuSZTd+/1qqEK
         0GuOOKF58koSgfcUY3Ycvf6hZ0z7Xgh3iMbp5aZwFUGXhtvC45m+xhoo3FSflEnvRQ9/
         5rMcm5zsBAckA2Re9cMnwov/+VLJvw4VY1lX3Xq8ELl36L4//zHHcMpVac2KdyctseiL
         3cIkoF5RLn3BkpDHkhMSgB1nfvrckRGHZeHFu4SjinU8reMKzRTOp+BYqJ5yLLTmw6As
         Cpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882899; x=1722487699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuLrTOMZXwDvrh3Gcss0q0VIdIl/tmC7R+/hGCD5mQk=;
        b=WJqPV2D00AmGziUT8K2eim13HG31IeqkxACDevlxfx/aGrMh8gK0Yf8/dPibIsGzH0
         LEnlcmksZgXEEdPxGe05T5urtq1P170G5ZMhUUAadR/3TGm881ck0vey48ABFu7wbhNv
         QI0K/u+tHiaFdDov5gzTPf+s86vWLBatmvvZ1JUOK3K0hPAeTO831Sm1AfEB4LK0kbfo
         hq8wD/0Dc3DrdmXkQM0nbQUBcywsLkHlMAHo4OAuG4EfjjvHcRkKPpCgW7P6a3zLeV5t
         z7OdHpZ6Ib1t01gZ9nth3LLrs7HuYauTUSRzs3mdNIlzt5C7oSL9W6L8Qrc2lv5eFzcj
         gd1g==
X-Forwarded-Encrypted: i=1; AJvYcCU8HnucJFQpGhdqQxX1Ha/C14m4ZQjzpJjC0lI+AzUnD60gcI19fn1w9jYgHPMwFRB27D1CC0kwHeNOMhJWAni/ruJHBzhErtiAWjHq
X-Gm-Message-State: AOJu0YzKkC4H+77wrCDDlb/njZ51jQ00w1TtZt0o4zcbbYHJ184Rx9u+
	Bue8Del2+B9VDMBgIcomnVy19GSOCq/yuCYdBpr/MeeUdJiCX5iyO7wHEZhYlQ==
X-Google-Smtp-Source: AGHT+IEWwStak5o3MjRefRdeyCr2slwkGT9/t8cXU3b6WSdv7rBu11QlEfyQkbgSO9bxXTIKVaFdDg==
X-Received: by 2002:a05:6a20:72ac:b0:1c0:f594:198c with SMTP id adf61e73a8af0-1c4728035d3mr2753100637.11.1721882899113;
        Wed, 24 Jul 2024 21:48:19 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e62e6fsm505267a91.57.2024.07.24.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:48:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:18:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/12] PCI: brcmstb: Don't conflate the reset rescal
 with phy ctrl
Message-ID: <20240725044812.GI2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-9-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-9-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:23PM -0400, Jim Quinlan wrote:
> We've been assuming that if an SOC has a "rescal" reset controller that we
> should automatically invoke brcm_phy_cntl(...).  This will not be true in
> future SOCs, so we create a bool "has_phy" and adjust the cfg_data
> appropriately (we need to give 7216 its own cfg_data structure instead of
> sharing one).
> 

In all commit messages, use imperative tone as per kernel documentation:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index dfb404748ad8..8ab5a8ca05b4 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -222,6 +222,7 @@ enum pcie_type {
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
> +	const bool has_phy;

'has_phy' means the controller supports PHY and the new SoC doesn't have a PHY
for the controller?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

