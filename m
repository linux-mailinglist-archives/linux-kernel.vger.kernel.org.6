Return-Path: <linux-kernel+bounces-425805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578359DEB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F4A160F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295671547FF;
	Fri, 29 Nov 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUBzcXIO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BD44C77
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898289; cv=none; b=NZp0Oqc4MBO3DOzrU2ESAlfjZdi+sc+2Fm4sw3IrhOpvqPcyYlkKj/N+r4lSUyTLhcR5VkpCQS55qYJx2Kam7bkc1nmGFRHqvLj2LO3oR5vySEYX+/QUXm5gVgJ/gHjLIaEQA+cqivDEhUG4nIDU96CKb3ix+TqIoEuSpar7XsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898289; c=relaxed/simple;
	bh=7WjikKFNZ+HEfrOK2PPdKEBf13sxhyHfG6cbbVBGcx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV19zX4rsHPvUzX22iYj5QUxbua/EDoxA/fbrG1y+Wl/DpvIDB/90yKt9hdO2R9DjmRt5qcjT30ANFjNqXuvuvEFKKMK5f4cTJ8eSuiDLdrSca7WG0x8nzYQ9HlJY40pEPaLmsQ2qwNP1eHRj3Lv+jwpgQ6vCUdVmXNlDxLEsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUBzcXIO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2129fd7b1a5so18030755ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732898287; x=1733503087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNj/qfb7oRR2PWaMb8I3iLUkmdoRJW2FZIUwVWDq9j8=;
        b=xUBzcXIOkZyTCSykVrAcEh42lpJYmP+jTYcVwwB2pCEcIoDCWw7BEA3yYDxIrO/K45
         qGSRIN4zTtsHqt9ApxOlsiDTB61OW6GIGb4nPnB/1EHVD/oqx8ieEhZxGUnzXGQmt8gD
         yPkyTpOKpFxYWytMVA8KAUHCD5WZEGKy7g03KV9/DyYRN7kZzAJFGLviQvAfXk5sUCgI
         EoIRQGKKI5hqKk2A3LGW0OOLdetWT8Kv1Vv0UlVvJu9piCH8b58RPSqbDtHX2TeB02ct
         gjk3DwxCjS5LPKL/2kKJYYw3lS0TSARlAcnMo1zHUexxH7YHatLuWcWun9QKU/ExJiWV
         WgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732898287; x=1733503087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNj/qfb7oRR2PWaMb8I3iLUkmdoRJW2FZIUwVWDq9j8=;
        b=uQ7vJxbl+4m73+m5Rumwci7y8xZgY5Utkr7u53pTkPHm6R3q894sHcdHoByjB3EUDN
         6gGWydFrkWkzy2WAigFByl5NXphsW6RO1OOC5LLbtZrvI+MFr6F1DENEVhBlQFLO5e1i
         9sDP4rimvVMj4FX08V0BbPkIA5ejSULw86QwL5fh6ppewas9LmkkfGXWTzYYbbheMlqr
         mGFXff7F87wQ4Zzzn7bCM1neaPvommxe9ECNTCdmctbcwksVCEgwVLKdQxkcnpTNJypk
         gVJYfs+5CMDZY3E3gAQ2/OoKTpRGHAmPQv1QJEZTO+55S8mHSI2NKYemE5Y7IHyaOJ94
         yyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJphnTg17jcwzGYbAaGjN/xNkrYCno+bznYGj3bohjxdMqxzl341PqgQdcDdELWsbXXtJG7098Y0IEsgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCl+/s5oa5NaFO/QsY1HlnBb1x4XlsoIpZlo4+nfpSnPTIi+RZ
	B8htHDyjfUNb4eoxV9az9bTedz8fJXkkq3U1iDuEYuzXh96Y/RhFgTDJFfWnwA==
X-Gm-Gg: ASbGncvIX3f6oiDt44B1O8lM71hg7eaShC8zdUhIanqw1M1DA3aJ5VqQf5JcoY0K62y
	cf5gs1E1wCI53pjNSFH/7GN05BCkhBa9su5hYfJpvSpyDi+a4dioElrxZi2cUhOIQ5UlGnHSQD2
	6u/gbGqM+vbPbmGMhXqjQ4MAV389hX28PfbIXV+ESi3qcxs9hreZ/lUdx+T2WPWR9wxNfpYkhGt
	B4WZyRbfqGoapwQcS0LKQdU4r8cEcW5O/5X8znBIUCKEiaWb8lGs/KK8ZeV
X-Google-Smtp-Source: AGHT+IEgR6eq5WPd71wOgh5UzKE552haFJB18tPtmtwFe0e0t2hbHfrj7ESMfTuQV+Cku7fnAEDKAA==
X-Received: by 2002:a17:902:e549:b0:215:4dad:727f with SMTP id d9443c01a7336-2154dad73c3mr23798135ad.50.1732898287401;
        Fri, 29 Nov 2024 08:38:07 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152199d5c0sm32447185ad.218.2024.11.29.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:38:06 -0800 (PST)
Date: Fri, 29 Nov 2024 22:08:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: bhelgaas@google.com, kwilczynski@kernel.org,
	bartosz.golaszewski@linaro.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH] PCI/pwrctrl: Check the device node exist before device
 removal
Message-ID: <20241129163803.osh6yrub42hqb5yf@thinkpad>
References: <1732890621-19656-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1732890621-19656-1-git-send-email-ssengar@linux.microsoft.com>

On Fri, Nov 29, 2024 at 06:30:21AM -0800, Saurabh Sengar wrote:
> There can be scenarios where device node is NULL, in such cases
> of_node_clear_flag accessing the _flags object will cause a NULL
> pointer dereference.
> 
> Add a check for NULL device node to fix this.
> 
> [  226.227601] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
> [  226.330031] pc : pci_stop_bus_device+0xe4/0x178
> [  226.333117] lr : pci_stop_bus_device+0xd4/0x178
> [  226.389703] Call trace:
> [  226.391463]  pci_stop_bus_device+0xe4/0x178 (P)
> [  226.394579]  pci_stop_bus_device+0xd4/0x178 (L)
> [  226.397691]  pci_stop_and_remove_bus_device_locked+0x2c/0x58
> [  226.401717]  remove_store+0xac/0xc8
> [  226.404359]  dev_attr_store+0x24/0x48
> [  226.406929]  sysfs_kf_write+0x50/0x70
> [  226.409553]  kernfs_fop_write_iter+0x144/0x1e0
> [  226.412682]  vfs_write+0x250/0x3c0
> [  226.415003]  ksys_write+0x7c/0x120
> [  226.417827]  __arm64_sys_write+0x28/0x40
> [  226.420828]  invoke_syscall+0x74/0x108
> [  226.423681]  el0_svc_common.constprop.0+0x4c/0x100
> [  226.427205]  do_el0_svc+0x28/0x40
> [  226.429748]  el0_svc+0x40/0x148
> [  226.432295]  el0t_64_sync_handler+0x114/0x140
> [  226.435528]  el0t_64_sync+0x1b8/0x1c0
> 
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Thanks for the fix! There was already a patch submitted to fix the same issue:
https://lore.kernel.org/linux-pci/20241126210443.4052876-1-briannorris@chromium.org/

- Mani

> ---
>  drivers/pci/remove.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 963b8d2855c1..474ec2453e4b 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -21,6 +21,9 @@ static void pci_pwrctrl_unregister(struct device *dev)
>  {
>  	struct platform_device *pdev;
>  
> +	if (!dev_of_node(dev))
> +		return;
> +
>  	pdev = of_find_device_by_node(dev_of_node(dev));
>  	if (!pdev)
>  		return;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

