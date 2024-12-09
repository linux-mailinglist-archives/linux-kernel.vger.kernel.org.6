Return-Path: <linux-kernel+bounces-437817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D309E9923
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D66281893
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8B1A23BC;
	Mon,  9 Dec 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFwZaRSz"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F951A239E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755109; cv=none; b=HMLaD0vOHCG9EGQbNRDDYpF+ICQp0gBo1m7Hqjx8bvwrvzpLlr6q1WnA13BKylzxTC54udO7+vNYOyev0W3OjjJhyaV//zayiXutiJzQ5phWYDGkFTqu1JuInmXtA3WECSqDwg+J1jKnCPGG8US84ftTxUNkVJBcbDv5S8TGams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755109; c=relaxed/simple;
	bh=sUSQ6w/uPMnUEc5UhN6lr+X2YALppLKGpxU+TDNIH18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8J/eJFPPPLUIMZNCsn4a3tYa5+5Q60kkGESn5NFiW3MRk3xIedM+LT+Tb32ZDQzZgkuJcED96nkHmmw0Zts8ppXa+IkZOcuWXYMDuMtp+i949NZLLkctY7hP6YGNsusibHgbC2VyvX610QeWgZHgztcrlWocHiGjiyKyfynfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cFwZaRSz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so3244334a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733755107; x=1734359907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5siyX/oBYeJOtEu9jJIH1QIRnp2BFKwx7Ms6hrWYqE=;
        b=cFwZaRSzzvmePwobJIIF7PTecRio0H2xJ9gH5KaKSWVqdEuCCkZI7S9UppbDpH1rMC
         jIAvTyEvT8bi2zB9gorwFO6IC3kZt4KcPHz0uVYfY12NsBR9fNPQ1q0t7dPz7IpozXhy
         yrCOTg3PaPo+V16RLWkTgtRxbt9khg/2e671eMMrIE5ESf8EQIoNWS/1EVjU80/IwJFy
         8sJe3AfB2xH70t+lhXYTL5wagmwjGMLx5wF2IG49maY4ySW5k13iEtcnQ7/sjNod+3xS
         GzhJVxKkLGjPo2x8AFcSEFz6vcCo0Q4EsW7J+rT7cfY7zlt30lDlz9xmWJ6d2XuQOyA6
         u2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755107; x=1734359907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5siyX/oBYeJOtEu9jJIH1QIRnp2BFKwx7Ms6hrWYqE=;
        b=bOhO9xchCfb+gp1qy5GfApLIWPb4e9EQuWWI8cjtSF8f4mfGredJRDaF41Ve+aJilK
         yQb9DmOIA9CQV9UHK5SfVguc4bgVJG/ISFdcuE+Orwi6T1IphDeKWpWwNr7TqNGAMuwD
         eD8X+ycLDzQ/R0m6T6X0f2pwqZbIUX40pKKKSmip0tffX7KGptQeycWav344KBfjP7S2
         IGpXTY9b8dBEl6qXTNuPQiOD55HMPB1LorVHfPsU95ludRW9pkps4loH5DJaMGmnv1sH
         uspNyj+zqVRm46DyMp1ehhDq5MUkMwnFY61LMlHMfS1LcQLdBip2Os5DkjP39MAyJO07
         JqDw==
X-Forwarded-Encrypted: i=1; AJvYcCWRSyZfUINTokw1zDgVD/Qj7mbWuCz3UHhxX8+AclP0on8iC0Ki2V0Zv9HFJU8CkCmEtrh4nArvZ40YLfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BtPB85hM0VAsKVnt9WUcqil6qmkspqETCKIB9RqIaFjv3NtC
	Br66FW91WbMpbXjpEAR2ElHhbZm3+hlHTcd6NZ2lUrI9CIzGF88WmWWDV/THxQ==
X-Gm-Gg: ASbGncsTABHytm6kjCQC4R6S/vVHfo2JTQ73wwe9H6c6rql4Y1OMSyeUOM4hZlL06zV
	ekDDbWTUPatQGhCC0RUMzr3mKMPfETNHpagWW3BulGe25E8XDH43GscY7XUjMMNad/v8/FttD1L
	ZtZZJcc1xGn/siMCfsoxIxBEl8n3GFg119gdbRuXKkaDJTMBhOzzXBkxeL2Bs6DjxLmjmcGr/fE
	IX95vLnzvtY3YG+71s0yPfv8ZzvLsTKMfo2jLw+fkO5qMKC56bMtWJURayc
X-Google-Smtp-Source: AGHT+IEjPNjheOz3H9P3KXCwrAQ0y1vhFh9v5UWKuqQE+ayZeQAQXxalmpEVYcnYnJ4nAlOJIgjr+w==
X-Received: by 2002:a05:6a20:d526:b0:1e1:f5a:db33 with SMTP id adf61e73a8af0-1e18712d2a0mr18475477637.36.1733755107284;
        Mon, 09 Dec 2024 06:38:27 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4681b0d5sm2644867a12.24.2024.12.09.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:38:26 -0800 (PST)
Date: Mon, 9 Dec 2024 20:08:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209143821.m4dahsaqeydluyf3@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241206014934.GA3081609@bhelgaas>
 <20241209133606.GA18172@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209133606.GA18172@lst.de>

On Mon, Dec 09, 2024 at 02:36:06PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 05, 2024 at 07:49:34PM -0600, Bjorn Helgaas wrote:
> > Oops, I think I got this part backwards.  The patch uses PCI PM if
> > d3cold_allowed is set, and it's set by default, so it does what you
> > need for the Qualcomm platform *without* user intervention.
> > 
> > But I guess using the flag allows users in other situations to force
> > use of NVMe power management by clearing d3cold_allowed via sysfs.
> > Does that mean some unspecified other platforms might only work
> > correctly with that user intervention?
> 
> Still seems awkward to overload fields like this.
> 
> The istory here is the the NVMe internal power states are significantly
> better for the SSDs.  It avoid shutting down the SSD frequently, which
> creates a lot of extra erase cycles and reduces life time.  It also
> prevents the SSD from performing maintainance operations while the host
> system is idle, which is the perfect time for them.  But the idea of
> putting all periphals into D3 is gaining a lot of ground because it
> makes the platform vendors life a lot simpler at the cost of others.

No, I disagree with the last comment. When the system goes to low power mode
(like S2R/hibernate), it *does* makes a lot of sense to put the devices into
D3Cold to save power. Using NVMe or other endpoint devices internal power states
only matters when the system is idle (which is not S2R/hibernate). This is what
ACPI is doing currently.

Then one might suggest to check the suspend state using
'pm_suspend_target_state' in device drivers and decide to keep the devices in
D3Cold. Unfortunately, it won't work for Qcom platforms as most of them (except
chromebooks) don't have S2R (a.k.a PSCI_SYSTEM_SUSPEND), but only S2Idle.

When it comes to non-Qcom platforms based on devicetree, they also cannot power
down the NVMe device during suspend (as they cannot satisfy existing checks in
nvme_suspend()).

The current reality is that most of the devicetree platforms *do* want to power
down the NVMe during suspend. Only when NVMe is used in an OS like Android, we
might not want to do so (that's something for future, but still a possibility). 

So this is how I ended up using the existing 'd3cold_allowed' attribute as it
allows the devices to be powered down by default and if the OS doesn't want to
do so, it can tweak the attribute from userspace (similar to UFS in Android).

The flexibility of this attribute is that it just acts as a hint for the device
drivers. If the device driver doesn't want to do D3Cold (when used as a wakeup
source etc...) it can still opt out (assuming that the platform would also honor
the wakeup capability of the device).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

