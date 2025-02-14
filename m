Return-Path: <linux-kernel+bounces-514621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BB9A35964
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5918C7A458D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29C227BB5;
	Fri, 14 Feb 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ol7xMxVC"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201F222564
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523205; cv=none; b=tFCSZvX+SHXWSZrhAj48Y7Ms4QJzx0C7Nu4iz29uTArIZKU/t5es5x5k3Vxvi/aPLZnCuRS+ILrEeY+bsAq8xiPEPxTZ5y+3TFdgoORxxdtT98U7vTfGaOnwKsgMHOAOM4SqPxv4e0QZrcHg8M9/gDFml8kjt7Eiu9nYSmWCxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523205; c=relaxed/simple;
	bh=oxSLdh0CAtNN9mbiAlU8ndwTUsmha2ZOppGLISI9ek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMrx/vZs59XQ10iLAq4nu7YV9AWAdBmQsKYmLIPcxusN1lomLQZItxVOfx5Rbi68qlUJd2A+dkQ+XpHo0xBLlJZojBi49JY2nyGdThlCAf7+8USJ6Jz9dYA5IQ0rzqyp1LnQt+Ou4aA9+IqZrBFdwJYP5ErjqtoUDd5AgGNk6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ol7xMxVC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f62cc4088so32693945ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739523203; x=1740128003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AYHkDvFZNVkfObVYojFKLXtrACdRdRJzIR6CHM3ZvzU=;
        b=Ol7xMxVCh88aEhgfoiDYhjqNxsucquL3TipwzXjr8YnHTtmOuk5w7EBupCESHf8Hzi
         tbYU162MVc8bdvUcWTzuEh3mcI/Uv/lOlFah1YWNsS8azW7ZbNXAF/7Dfc1A0iTXcjog
         Xt/zalKHfZ2a8TKXLjIpQDVf/ju1nxmOspeKzv2HXX6RMnbHkbtAg3L6gTC4EYFz7dU6
         LcTFxg1+dBGWvV7Dph6WHpCxLiMJSVRLZZZVvdeisQALxUf+92RECEKMTxxNmirmPbWf
         sXwFm73oXlZ/YAa3l2mSbQJboGRYks0TmRlR64w2lXq4courpQH160llJSu+khlsp752
         qdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523203; x=1740128003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYHkDvFZNVkfObVYojFKLXtrACdRdRJzIR6CHM3ZvzU=;
        b=pLleRNMkK4atDlgnzwTW/yYoe+4M2PAJ3L2yCbgKqoyQKLst9SWQ68RMWbcqZtQUR1
         ksiN6H+dzsa7FNlg87OMPpmrPwGNcoiYTb/la9rKjq17pgMli7TIpGR8jnJVqJvd6nnm
         mFg2SGN1mp0r2+q3diEZnimKW7Wx7E2IAcpq3yevQbca9D6hAHC8uGDw7br++zdQv1Jp
         dqn/ed9Ojkup5OZPCl0MnDIxc7m3UTVGxv+2JRl8I5cDxXrAlp3r2TS2HLawb5HPq1xU
         1h10ccXuJ+JenFYQfU0iNuWJ4oZJv6T7hGA5CJitcKuTQU0NcBkvfgFgUQ7yQhtdBSwy
         Hggg==
X-Forwarded-Encrypted: i=1; AJvYcCUra3gqt2GHsykvYs/3xp7V1izdf82GkPhlcGZ8LOKtlLdbc12HjiPECvFo/ne6UquhRYpEA95F1mZvi1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF03FrAVjrk45h8Rnx/XkgUmp2rcLg99wDt9NWZZRVurZliG6G
	8KTNYeOOJQm5lV/DRhT10FC34EK4L6TQD+0n3favKjBIyX41cK7vZph8KCSHuQ==
X-Gm-Gg: ASbGncvdcAEwAenboN4uGGA76YEDRVap92MW34YGHF4sLr3TRTguQaxj8TPdL/e5fLt
	57MOh2Gs0RYLYATkreGBMW9vEz7HWdarlDYffiGff7pq9QM0GAURLLke4x14163mQyrwLvdGZ3h
	574dVzIUdxFrKX+RrRcuXY9Ndly+gZnJbAvrBHwVkgNH62zhlm0s9OMNNpBi2ggZ1uBHb0dZ/Lm
	f/Ob92aU5wj9OlSXm1JXe904v/ChceLczZbr5kwzguE54i//8V4sn2hwCQH+S9lxICoCYe9K3eA
	cRi3rDK/X3j5oJG7HXZLURLgYfa4Z4U=
X-Google-Smtp-Source: AGHT+IEp9nHrk4n//TzcHWHZFgsOhlQQ2Xlq67D0I3zF/1xWdNgg2JYRrRN4bc6mqpBquWG6UVXYBw==
X-Received: by 2002:a17:902:d485:b0:215:522d:72d6 with SMTP id d9443c01a7336-220d213ee2emr115416505ad.38.1739523202739;
        Fri, 14 Feb 2025 00:53:22 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:a164:8397:3a17:bb49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348e68sm24798765ad.28.2025.02.14.00.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 00:53:22 -0800 (PST)
Date: Fri, 14 Feb 2025 14:23:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Message-ID: <20250214085315.bp6hpcsxu2ndegb2@thinkpad>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-2-cbd837d0028d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-preset_v6-v6-2-cbd837d0028d@oss.qualcomm.com>

On Mon, Feb 10, 2025 at 01:00:01PM +0530, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
> 
> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> configure lane equalization presets for each lane to enhance the PCIe
> link reliability. Each preset value represents a different combination
> of pre-shoot and de-emphasis values. For each data rate, different
> registers are defined: for 8.0 GT/s, registers are defined in section
> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> an extra receiver preset hint, requiring 16 bits per lane, while the
> remaining data rates use 8 bits per lane.
> 
> Based on the number of lanes and the supported data rate, this function
> reads the device tree property and stores in the presets structure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/of.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 27 ++++++++++++++++++++++++++-
>  2 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 7a806f5c0d20..705d5529fa95 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -851,3 +851,46 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>  	return slot_power_limit_mw;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> +
> +/**
> + * of_pci_get_equalization_presets - Parses the "eq-presets-ngts" property.

nit: eq-presets-Ngts

> + *
> + * @dev: Device containing the properties.
> + * @presets: Pointer to store the parsed data.
> + * @num_lanes: Maximum number of lanes supported.
> + *
> + * If the property is present read and store the data in the preset structure
> + * assign default value 0xff to indicate property is not present.

'else assign...'

> + *
> + * Return: 0 if the property is not available or successfully parsed; errno otherwise.
> + */
> +int of_pci_get_equalization_presets(struct device *dev,
> +				    struct pci_eq_presets *presets,
> +				    int num_lanes)
> +{
> +	char name[20];
> +	int ret;
> +
> +	presets->eq_presets_8gts[0] = PCI_EQ_RESV;
> +	ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
> +					 presets->eq_presets_8gts, num_lanes);
> +	if (ret && ret != -EINVAL) {
> +		dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);

nit: add ': ' before '%d' to make it clear that the printed value is an errno.

> +		return ret;
> +	}
> +
> +	for (int i = 0; i < EQ_PRESET_TYPE_MAX; i++) {
> +		presets->eq_presets_Ngts[i][0] = PCI_EQ_RESV;
> +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << (i + 1));
> +		ret = of_property_read_u8_array(dev->of_node, name,
> +						presets->eq_presets_Ngts[i],
> +						num_lanes);
> +		if (ret && ret != -EINVAL) {
> +			dev_err(dev, "Error reading %s %d\n", name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..e87c2ffd1e85 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -9,6 +9,8 @@ struct pcie_tlp_log;
>  /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>  #define MAX_NR_DEVFNS 256
>  
> +#define MAX_NR_LANES 16
> +
>  #define PCI_FIND_CAP_TTL	48
>  
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> @@ -808,6 +810,20 @@ static inline u64 pci_rebar_size_to_bytes(int size)
>  
>  struct device_node;
>  
> +#define	PCI_EQ_RESV	0xff

Just a single space is enough after 'define'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

