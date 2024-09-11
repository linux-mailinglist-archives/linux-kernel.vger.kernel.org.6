Return-Path: <linux-kernel+bounces-324862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856399751BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6392819E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A718732C;
	Wed, 11 Sep 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJw7e1IS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B66176ADE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057004; cv=none; b=px5Te2VMksAk4q6Js5Ere/ckP9Cm5Dg3h57wJ8KBXc9TYA5sbx37M4xyjPxc42+7e3K2eb/fo142xts6bAEa2M+uSMefIdjUMxRHCkSUV8BSkG8farYKPJY197owqeE05nZHK/g4vDLeicdQ1kf+QMmz7DRHa4NYTfiJDY6uWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057004; c=relaxed/simple;
	bh=y+RXBxHW/fG6dmqBGlPAQwmnNgp07f4Kl7fIHvXNDYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bnB8ZfWAgul5HTTddZu1b2UOUD8qwYyQhy9o/B/uvNx6sxY/hPz8PgeW0oZfScyVm/E8s9g5qxZYwSy+uI7QFD+QLWRLTDsdzyxeQaJ5AT51gKyvomZzsECMvwn4QdtAc7sw3FbQFgDVY27KlvI5mVrC037DQVC3NCU9a5aQCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJw7e1IS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726057000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jar5EI9omcqYVQEDUhE+fTZ/7hHoS8oVmR3xs0BHXyo=;
	b=EJw7e1ISkqCoK0GROgnpsVki1MGubweC1qLXcFTPQIShMNwhEASiLQEcJ7SL8XNNR4lNkY
	lQtAVN/bpgtJcMZZvUBmKNS/FcJBF5oEHk8uiLI5Jo8QMYweTIBEDq0cFRU5/SraXOzo/w
	3hMCz1B+ij4v57s4WwQYvQAq+2mmgKs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-zpJCxpOQNoq2vQoDFTlNtg-1; Wed, 11 Sep 2024 08:16:39 -0400
X-MC-Unique: zpJCxpOQNoq2vQoDFTlNtg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a8d9a2a12so379272066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726056998; x=1726661798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jar5EI9omcqYVQEDUhE+fTZ/7hHoS8oVmR3xs0BHXyo=;
        b=XtNdxZ82EJU5FakI9gswikm2BOkSxi3sKohAw9nZ2MthvJX65tPMHzMrkc8H2uQGh2
         MhzNjGFSuDa6CpezqyxoKSxOPMmX5z6gHxqyhlVVl+gmlk4SGGSIoTNY11odM16d1whL
         NgBWQn6l1DEcXJuxknOz14aaKheFIyGzxrDDG5PJWMmFnD1lJ8jaIBRoGW0spAxKg0p9
         0nkWPy7n37NRv+GO0j1lz+ysJNmo7shVz/IRPXvH70VXC8a6qLnKz9/WXgA0kuwAl8AB
         Y14SkjBGwmAfA33D1w6vW0Ac0R98Qhx1dmzBatc+AjlYRpv7zhEQSNjG0LJyZGqcBGLO
         xx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjDL1zWKc6zVyXE+NsOmqJhCMKd5b6XJfkbEgoXgDzOqH1FEUMLcBQ5lmro9+TcW3C7K1Of52c5zaO29E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4psh78qMdiStJgMO1NSIBt9GG7TaSa9n432aN5QmC1DiWrLr1
	IN8UwuZcVV4t4uR3TpNVxt8lgUzE1T4NdGHG6EF6KGbSB+8zDUkK9PTqCGMQugy2jfr8s1vZJ6q
	yBjlY82LFTLSttU1bAe6eDNFbSMJGc7G+t1C5vfMLE9lvXmpcBh1dcwQtoyHbzg==
X-Received: by 2002:a17:906:4fd6:b0:a86:8a18:1da0 with SMTP id a640c23a62f3a-a8ffaa979damr435950266b.5.1726056997949;
        Wed, 11 Sep 2024 05:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSAcNYDwvGEAKNumEEzE7Ab0XbdT66tjBaKUNiGnTTHHOQNkLYXXkujZLzoc/QacmN0QZDCQ==
X-Received: by 2002:a17:906:4fd6:b0:a86:8a18:1da0 with SMTP id a640c23a62f3a-a8ffaa979damr435947466b.5.1726056997409;
        Wed, 11 Sep 2024 05:16:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25951020sm607845866b.66.2024.09.11.05.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 05:16:36 -0700 (PDT)
Message-ID: <edaa23e8-4b15-479c-a4bb-0f8276c8b862@redhat.com>
Date: Wed, 11 Sep 2024 14:16:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Ignore all LTRs during suspend
To: Xi Pardee <xi.pardee@linux.intel.com>, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240906184016.268153-1-xi.pardee@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240906184016.268153-1-xi.pardee@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/6/24 8:40 PM, Xi Pardee wrote:
> From: Xi Pardee <xi.pardee@intel.com>
> 
> Add support to ignore all LTRs before suspend and restore the previous
> LTR values after suspend. This feature could be turned off with module
> parameter ltr_ignore_all_suspend.
> 
> LTR value is a mechanism for a device to indicate tolerance to access
> the corresponding resource. When system suspends, the resource is not
> available and therefore the LTR value could be ignored. Ignoring all
> LTR values prevents problematic device from blocking the system to get
> to the deepest package state during suspend.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> v2:
> - Add more details to commit message
> - Fix format: ltr->LTR, S0IX->S0ix, space between name and email
> 
> ---
>  drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  2 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 01ae71c6df59..0ec703af16a4 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
>  
> +static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
> +		struct pmc *pmc;
> +		u32 ltr_ign;
> +
> +		pmc = pmcdev->pmcs[i];
> +		if (!pmc)
> +			continue;
> +
> +		guard(mutex)(&pmcdev->lock);
> +		pmc->ltr_ign = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
> +
> +		/* ltr_ignore_max is the max index value for LTR ignore register */
> +		ltr_ign = pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
> +	}
> +
> +	/*
> +	 * Ignoring ME during suspend is blocking platforms with ADL PCH to get to
> +	 * deeper S0ix substate.
> +	 */
> +	pmc_core_send_ltr_ignore(pmcdev, 6, 0);
> +}
> +
> +static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
> +		struct pmc *pmc;
> +
> +		pmc = pmcdev->pmcs[i];
> +		if (!pmc)
> +			continue;
> +
> +		guard(mutex)(&pmcdev->lock);
> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign);
> +	}
> +}
> +
>  static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
>  				       const int lpm_adj_x2)
>  {
> @@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
>  module_param(warn_on_s0ix_failures, bool, 0644);
>  MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
>  
> +static bool ltr_ignore_all_suspend = true;
> +module_param(ltr_ignore_all_suspend, bool, 0644);
> +MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
> +
>  static __maybe_unused int pmc_core_suspend(struct device *dev)
>  {
>  	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> @@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
>  	if (pmcdev->suspend)
>  		pmcdev->suspend(pmcdev);
>  
> +	if (ltr_ignore_all_suspend)
> +		pmc_core_ltr_ignore_all(pmcdev);
> +
>  	/* Check if the syspend will actually use S0ix */
>  	if (pm_suspend_via_firmware())
>  		return 0;
> @@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>  {
>  	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>  
> +	if (ltr_ignore_all_suspend)
> +		pmc_core_ltr_restore_all(pmcdev);
> +
>  	if (pmcdev->resume)
>  		return pmcdev->resume(pmcdev);
>  
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index ea04de7eb9e8..e862ea88b816 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -372,6 +372,7 @@ struct pmc_info {
>   * @map:		pointer to pmc_reg_map struct that contains platform
>   *			specific attributes
>   * @lpm_req_regs:	List of substate requirements
> + * @ltr_ign:		Holds LTR ignore data while suspended
>   *
>   * pmc contains info about one power management controller device.
>   */
> @@ -380,6 +381,7 @@ struct pmc {
>  	void __iomem *regbase;
>  	const struct pmc_reg_map *map;
>  	u32 *lpm_req_regs;
> +	u32 ltr_ign;
>  };
>  
>  /**


