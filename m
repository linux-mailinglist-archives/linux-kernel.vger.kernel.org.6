Return-Path: <linux-kernel+bounces-423044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E09DA1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268A5B248CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44241145A16;
	Wed, 27 Nov 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ol4YEaIy"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98048126C04
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686761; cv=none; b=HlSJwRPnc0tEeu5kmMHUA0DFhGUT+FJ1xO46YHFcL338ZAzMEnVf04C4DeU4xTgLRvBKUcFevi9yZVguq9xi9xsBj7CAZux24EjnztrjJOSZEq7Id4WMYSBxytCbQ4DoP2a6jwa1hieGaEZm0ltyUxq9CLFqaExuDybMDfx6I9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686761; c=relaxed/simple;
	bh=8wSEK34xkLhZtXK37T+CTmIrQOnSc9SCmTBnCKGvzyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrWs0aZ4A4bd2ikKSx0+Em22N9Spnlh6bTHNsktIhPrhBimBymejoDiVQx/4iSDepf9ZUYK0T9XpdxQPnb9KpoJ58FwVONEHoncQDDXx/F2nt5P7D/kSf1SsxhiGZkNPUAuznHzp6iLg+I19p4RYOEnxilsF8RA2Iy/3Cqb88n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ol4YEaIy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2973b53ec02so2364188fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732686757; x=1733291557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=voChsGLrkE+GyaA+f7Vgob8Q+nkDeOaBSaxqsWvFCZw=;
        b=ol4YEaIyHWy4qYTvNq/kWp1PjQWmCQ3vbU2NZiExLKWnsCdKhb3UdyjkIcmS+5hG+s
         lvF2sDAuLdhbt656dYo1J9PonQsR4dHfY7fp6VIQkzqxoMBNZxhrNUxHGBYm4wgMXkcI
         5B5GkEhp0zRmo3zdBxAiFu4eP8icsOzMEqsUrieNw/4gnyUnIS/Lj0Y0/YnhNVTpuWfv
         0+UPt6nPW5KpnCi5tMj4IUgSJG3hAzVuQ/sD9byshMBDqjtTZFtG+fpomWkVKdVKVlnR
         6OBG/yOJMOqfn4wLndp5gCF1qlOWjsNCgN7kE8cl/fOWSr/TNi/0QG3ToBgI8qhELfbV
         0klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732686757; x=1733291557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voChsGLrkE+GyaA+f7Vgob8Q+nkDeOaBSaxqsWvFCZw=;
        b=k1QqS1M8XzDIz9xHTuP+DkhrRKbUfoxYSnGDTxXtx39uyYaVoQmMiJpkq2tal5h5Qd
         hrx4O26kABIXy8avm1WYJN0GxZxguY9GsJ5fwrKwcVtgIlroJP+bHM/n8d4HKlwyvGeS
         ptBvPGHtTFjCR+S1BJafTIkoCfu/dEWlK9h5bgiSFm9x6QtGl2A7GmcDqgvNaXgx2vhA
         Dp3GHJOkQsY7KrxLSLoBlE+GP6LRBklPOzFG6l3uBAaAk1crLnUADJSf/VSop9dDFpt2
         sTvWu7kBOZvFQsVbtncs5in8kpmCpJgTLkvZ4jEQSfaBfVq7+H5ynyZ97LivLbxgW7Js
         q6iA==
X-Forwarded-Encrypted: i=1; AJvYcCUwK1o3nNGQYRWwPWl9LmCGf2DQfcwug9o3ARwndoXT+RTS8q2ea9dARw+3pgpfsNLRahMmD40didtRlQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNelyzoZf3tFbQalstn96+auYz9gePqogMpEQy14mrwfHijSb
	xadN89PAn4tpRwd1X7UOjr0flADYG9YKGeJsOOh2g/SQIbvmnBoxc56MsdZvbA==
X-Gm-Gg: ASbGncuiiunisp9V9QciXi4wHwobAK5yPfEf/baJRt2w0mWgRvQnEnf50SdGa04iXJP
	l8+vg5vQAUjcbwM4RPH/qICjmP8Ihe1X+vFV6ye0WcZBvZ2I+H+bKFwYmkuuWQUUMOL9nof1Pdh
	e4A2QaQFrPW0fbKfDtPT62cTKxMsf9NZmvMAkUL90Dji+ZXCS3xCpJpcyT99qg1RpLhaSSfzbnC
	Z+K80ivl7tkCrBvs0XFt3kmjrOVIRD9rGSbb4epHpFKbaJWAT9t/A1Q58qf
X-Google-Smtp-Source: AGHT+IG7pDpk5fKyrnoUxeCSQMQse/GQ2TUI1vIZqymr1dnKy51d2wQ4iwswjQ06MZVyqtuFQ0gPXA==
X-Received: by 2002:a05:6808:3087:b0:3ea:4c84:174b with SMTP id 5614622812f47-3ea6dd54d6fmr2023349b6e.31.1732686757722;
        Tue, 26 Nov 2024 21:52:37 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72512262523sm4351749b3a.72.2024.11.26.21.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:52:37 -0800 (PST)
Date: Wed, 27 Nov 2024 11:22:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
Message-ID: <20241127055233.zs5egsytrz7yorjh@thinkpad>
References: <20241126210443.4052876-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126210443.4052876-1-briannorris@chromium.org>

On Tue, Nov 26, 2024 at 01:04:34PM -0800, Brian Norris wrote:
> of_find_device_by_node() doesn't like a NULL pointer, and may end up
> identifying an arbitrary device, which we then start tearing down. We
> should check for NULL first.
> 
> Resolves issues seen when doing `echo 1 > /sys/bus/pci/devices/.../remove`:
> 
> [  222.952201] ------------[ cut here ]------------
> [  222.952218] WARNING: CPU: 0 PID: 5095 at drivers/regulator/core.c:5885 regulator_unregister+0x140/0x160
> ...
> [  222.953490] CPU: 0 UID: 0 PID: 5095 Comm: bash Tainted: G         C         6.12.0-rc1 #3
> ...
> [  222.954134] Call trace:
> [  222.954150]  regulator_unregister+0x140/0x160
> [  222.954186]  devm_rdev_release+0x1c/0x30
> [  222.954215]  release_nodes+0x68/0x100
> [  222.954249]  devres_release_all+0x98/0xf8
> [  222.954282]  device_unbind_cleanup+0x20/0x70
> [  222.954306]  device_release_driver_internal+0x1f4/0x240
> [  222.954333]  device_release_driver+0x20/0x40
> [  222.954358]  bus_remove_device+0xd8/0x170
> [  222.954393]  device_del+0x154/0x380
> [  222.954422]  device_unregister+0x28/0x88
> [  222.954451]  of_device_unregister+0x1c/0x30
> [  222.954488]  pci_stop_bus_device+0x154/0x1b0
> [  222.954521]  pci_stop_and_remove_bus_device_locked+0x28/0x48
> [  222.954553]  remove_store+0xa0/0xb8
> [  222.954589]  dev_attr_store+0x20/0x40
> [  222.954615]  sysfs_kf_write+0x4c/0x68
> [  222.954644]  kernfs_fop_write_iter+0x128/0x200
> [  222.954670]  do_iter_readv_writev+0xdc/0x1e0
> [  222.954709]  vfs_writev+0x100/0x2a0
> [  222.954742]  do_writev+0x84/0x130
> [  222.954773]  __arm64_sys_writev+0x28/0x40
> [  222.954808]  invoke_syscall+0x50/0x120
> [  222.954845]  el0_svc_common.constprop.0+0x48/0xf0
> [  222.954878]  do_el0_svc+0x24/0x38
> [  222.954910]  el0_svc+0x34/0xe0
> [  222.954945]  el0t_64_sync_handler+0x120/0x138
> [  222.954978]  el0t_64_sync+0x190/0x198
> [  222.955006] ---[ end trace 0000000000000000 ]---
> [  222.965216] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
> ...
> [  223.107395] CPU: 3 UID: 0 PID: 5095 Comm: bash Tainted: G        WC         6.12.0-rc1 #3
> ...
> [  223.227750] Call trace:
> [  223.230501]  pci_stop_bus_device+0x190/0x1b0
> [  223.235314]  pci_stop_and_remove_bus_device_locked+0x28/0x48
> [  223.241672]  remove_store+0xa0/0xb8
> [  223.245616]  dev_attr_store+0x20/0x40
> [  223.249737]  sysfs_kf_write+0x4c/0x68
> [  223.253859]  kernfs_fop_write_iter+0x128/0x200
> [  223.253887]  do_iter_readv_writev+0xdc/0x1e0
> [  223.263631]  vfs_writev+0x100/0x2a0
> [  223.267550]  do_writev+0x84/0x130
> [  223.271273]  __arm64_sys_writev+0x28/0x40
> [  223.275774]  invoke_syscall+0x50/0x120
> [  223.279988]  el0_svc_common.constprop.0+0x48/0xf0
> [  223.285270]  do_el0_svc+0x24/0x38
> [  223.288993]  el0_svc+0x34/0xe0
> [  223.292426]  el0t_64_sync_handler+0x120/0x138
> [  223.297311]  el0t_64_sync+0x190/0x198
> [  223.301423] Code: 17fffff8 91030000 d2800101 f9800011 (c85f7c02)
> [  223.308248] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Hmm, again of_find_device_by_node()...

Thanks for the patch.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

