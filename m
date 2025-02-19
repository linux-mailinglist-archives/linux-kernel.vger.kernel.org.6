Return-Path: <linux-kernel+bounces-520859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F5CA3B027
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B47F16CEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881831A9B27;
	Wed, 19 Feb 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcN0zwnV"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06F8F7D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936581; cv=none; b=k1F2eGeLLKIa0dtc+GINoz1aS3UmgSsk7NQeeplyqLJ/7j4UA7CQZxlpIdn2PfUz3QPJO2hpJUTQklkgfwBAqtMiyFOgaIc3ukpjWOBU3ulGq1oZg5s+H6uDs5WHSjqGqU1u7VaRmKHiXe4W8Xq0dGmPegrNlGr77hZ7wFQ8gtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936581; c=relaxed/simple;
	bh=rt8OZok4krwD/vISwT+RLOvyIFREjov9zpbLM62Rv8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrhOm9DopquZUu2eFKYbWU0aJe+kaLePMeWRe6CuHyWmz2o0dwPVqeq4j206C2Vt/ZCAy2jzEcGpVpZ8vxRFZuqpAl4UI67lJcYRr+KdfuK1dkjnerOgC65eFkwSHUd6XU/+YyTwubttLC9HuAYESuTaqEuLSXTfmS+ngtubZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcN0zwnV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d398bea9so86764985ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739936579; x=1740541379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzzzNklTSdOBRiVdzYnFdDhkqK4+d5jKptup1SFuREM=;
        b=vcN0zwnV/BNNY9xGJdeTr3JxiH2L9fOsA33GkEG+U1Wyp0rWtvlUTQlAXb+F8Md3rk
         +LEfJpdwz2Zbg51GHxG1ZJF2tvKiVpbr54YCUrNtm609lVTczSoDlBZM8mXsQ8Ejv7EP
         6wJoDfNFBpHDihKcDJMtV5zUtH/EFkGxg4N3ztZNYLl8ArACsAzR4aKw885aVlGEzee8
         oSttYhWg6FC0MwhraVL7dMtYJ25zQtkqv2QrThVtPQGoR/DReKlfbvO5dBflL50Mbryq
         2YI7Y27UjfQD0d6JSU/1fMtvpv7hRLsa0A4GMZa8oc0pTbOhJFqHiaXm6qBq5GpD06jr
         OUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739936579; x=1740541379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzzzNklTSdOBRiVdzYnFdDhkqK4+d5jKptup1SFuREM=;
        b=xLj8sRuPJ7GH0Ee6RZNuLbH/L3bpDp261AqFgZ9ScsF7BiKyE/drWCgeVLFTLsNM6G
         cL/vXSigd05EaMiRg258bJE+kp92xAVOyXRJvs+19YFUjwvNjZjRCAG9REcciSLwrZqr
         xwQcrJ8zz0FiXLH5O5XcKWD02iNaGudwwGT2JLQVJlgFgJvw0sItWDGjWw0wCkvLmT3b
         9bWDzaW6BJUGMlx/sTgIzFTD2fXemxaDjJnbrnPASsK1+XiPVHmuOH7zQBhHUz4RkPp0
         B3ryWHvBm+Ff+0AgMFO/uBTyT0LvSB1nNeLqO+zPVDUttkCj5yQMgiIcPl7bM+gmLLk3
         5p1w==
X-Gm-Message-State: AOJu0YxIiP7mRz9l2qhIW5HnhW9m+Xg7mGHLSl6bypKkaG2MRCVrLmRH
	qiOKL9rx6F+bLua+Yu1rtbWp9PnfaULrzHkL+V7cWdVtn83Qy/SnSOO+ecLusg==
X-Gm-Gg: ASbGncuEU0/SmwnGRxLyOgMAWyfYV1n8Zc5/uxYopFTm6uCi7X3Z2B2SMbSxJR7g3yg
	MvF7uNGgU1RxaTmOMGRMDjx3h2pk86+0Ek7BAWZHpA8z47tP6HXDTEYKj3/ZJT47Jv+ZXumkyv3
	RzW3kyGqQovx912kQx+WOORuo//to42w0aul9NFQ/knBIDmzLt4i+yBK1U5nRL0xiASQPubrkQo
	Mvn39fQaPYv4Mqk+m/GBlrOmS/wm4HL5SKgt6x66QeiyW/l2oEEDNFadtqkWiwleJhta1rK8Q+z
	4oWjE/pY8FSEHXao0+8/Hn6ZCQ4=
X-Google-Smtp-Source: AGHT+IGnSkIYwRiNrwLaXKiKj/KL0r5B+zTe86T9DDgnkUKidbTIZVM8Yj1hqnJGGJXPq3VCAE+zTQ==
X-Received: by 2002:a17:903:1c5:b0:220:f509:686a with SMTP id d9443c01a7336-2210407b939mr285989715ad.29.1739936579463;
        Tue, 18 Feb 2025 19:42:59 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364403sm94758825ad.62.2025.02.18.19.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 19:42:58 -0800 (PST)
Date: Wed, 19 Feb 2025 09:12:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, bpf@vger.kernel.org
Subject: Re: [PATCH] tools/Makefile: remove pci target
Message-ID: <20250219034255.oadrso2u7xppjmo2@thinkpad>
References: <20250217115159.537920-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217115159.537920-1-liujianfeng1994@gmail.com>

On Mon, Feb 17, 2025 at 07:51:52PM +0800, Jianfeng Liu wrote:
> Commit e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to
>  Kselftests") moves tools/pci directory to
>  tools/testing/selftests/pci_endpoint, which will cause build failure
> when running "make pci" under tools:
> 
> linux/tools$ make pci
>   DESCEND pci
> make[1]: *** No targets specified and no makefile found.  Stop.
> make: *** [Makefile:73: pci] Error 2
> 
> This patch updates the top level tools/Makefile to remove reference to
> building, installing and cleaning pci components.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Thanks for spotting!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Fixes: e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to Kselftests")
> ---
> 
>  tools/Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 278d24723b74..5e1254eb66de 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -25,7 +25,6 @@ help:
>  	@echo '  leds                   - LEDs  tools'
>  	@echo '  nolibc                 - nolibc headers testing and installation'
>  	@echo '  objtool                - an ELF object analysis tool'
> -	@echo '  pci                    - PCI tools'
>  	@echo '  perf                   - Linux performance measurement and analysis tool'
>  	@echo '  selftests              - various kernel selftests'
>  	@echo '  sched_ext              - sched_ext example schedulers'
> @@ -69,7 +68,7 @@ acpi: FORCE
>  cpupower: FORCE
>  	$(call descend,power/$@)
>  
> -counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
> +counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
>  	$(call descend,$@)
>  
>  bpf/%: FORCE
> @@ -123,7 +122,7 @@ all: acpi counter cpupower gpio hv firewire \
>  		perf selftests bootconfig spi turbostat usb \
>  		virtio mm bpf x86_energy_perf_policy \
>  		tmon freefall iio objtool kvm_stat wmi \
> -		pci debugging tracing thermal thermometer thermal-engine
> +		debugging tracing thermal thermometer thermal-engine
>  
>  acpi_install:
>  	$(call descend,power/$(@:_install=),install)
> @@ -131,7 +130,7 @@ acpi_install:
>  cpupower_install:
>  	$(call descend,power/$(@:_install=),install)
>  
> -counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
> +counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
>  	$(call descend,$(@:_install=),install)
>  
>  selftests_install:
> @@ -163,7 +162,7 @@ install: acpi_install counter_install cpupower_install gpio_install \
>  		perf_install selftests_install turbostat_install usb_install \
>  		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
>  		tmon_install freefall_install objtool_install kvm_stat_install \
> -		wmi_install pci_install debugging_install intel-speed-select_install \
> +		wmi_install debugging_install intel-speed-select_install \
>  		tracing_install thermometer_install thermal-engine_install
>  
>  acpi_clean:
> @@ -172,7 +171,7 @@ acpi_clean:
>  cpupower_clean:
>  	$(call descend,power/cpupower,clean)
>  
> -counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
> +counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
>  	$(call descend,$(@:_clean=),clean)
>  
>  libapi_clean:
> @@ -219,7 +218,7 @@ clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
>  		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
>  		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>  		freefall_clean build_clean libbpf_clean libsubcmd_clean \
> -		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
> +		gpio_clean objtool_clean leds_clean wmi_clean firmware_clean debugging_clean \
>  		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
>  		sched_ext_clean
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

