Return-Path: <linux-kernel+bounces-253330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB27931F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DE72821DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75517C8B;
	Tue, 16 Jul 2024 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBu1KjmQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876212E6D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103268; cv=none; b=Fqbrli1ZtV9HBM1tK1sAh4l+VqHyWlEVuMjSbBg3IWu8KFJBiwedWR34p7lqFJCgYiti7og2ROzAkV3pcyBRlDIj2ETy6jKOwTNiAr2jBhpnJGGLXc09FAVb+VF/uWpEIPvKDh7K9ecylVCHV63hBxWWYj2ZrX2lXDWWNz78AWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103268; c=relaxed/simple;
	bh=Q6fMXng06sCrDolMimf4y00YzugvjyxcoCS6h0VSxQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9c8OPbGhtuPp3RretkEI2Njlhf6kOhtV7reLu0hhr5ffy8uT+K3v2No58WZUecsVgubiHt4wMCzFuGgvSaE5tKwKCQ1HS8imuY1h4Bf+SCU4+UP4gWUu8rPG3BT0Tc2QPslfGJFU+agDpj2thvtbLPrDYvIA1R42rOvvl9HwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBu1KjmQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso29971475ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721103266; x=1721708066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m9fUUwB+okzBEhJbtku9Zj8uDK/lXGOdA1PyDueEIS8=;
        b=gBu1KjmQuB62d9UlWS/VeokmP5+zv3GsSu/mmJQOTtI4Rz+xs9Gkq57HFbDpLGKnnh
         NknJBaHOJ2ccXDqXtfb7uzl0hhOY5etn2rdlJup/X1UQlvw0mvvR5cSnEd0tKgTn4OAy
         LmBtmtMI1vJsIiwJ7O3wqikMbsNk6wR1AlCFhatndt3VxeEhaUI4pbz1UhVZY2vT2Fd3
         Xf/Nu3bkWYkHCnodBxAz2Kb6qlxm9THVWcldfZnY3x9LfVLibXj3PHiWTJhJmnXhGrZq
         Bax7TPE8LpS0xijXvE//AAd4IVm+YvnAzJjtgxkDvWuaQiPLg+ZTr9Ud6I1MPK2pMxY6
         45Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721103266; x=1721708066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9fUUwB+okzBEhJbtku9Zj8uDK/lXGOdA1PyDueEIS8=;
        b=LsDvgN51s+Vi7K9Vpc4mErlz3+hCyT3BD0Xm9IDt1ZLJ6Y0QqSQELymHIznZDz+4E/
         vO/seb3pPZlp4sZiHTQqNUV968/d9lUKnIqfk2neOCI90Uk8MkQ5x0p1qvWMf2Rb9isn
         EprYilvMWR4Mwde3ZFZj+jrJ4kYHVALU3yCnP3YwbqtUa9I+YE5yNPT8rwd865wm/CyV
         jnrh1hxzO+HZuP/mjPjcoJfVai0XEHF8uin0V5i+YHxj2b2xDdaU7bLoaQKH6BCreA36
         GmYRnv2kRO61FQc8QmXZPv35dkWVCy4NedNrWTuwReZcRobpTGilvc6fZmGNEH0D34iT
         JtAA==
X-Forwarded-Encrypted: i=1; AJvYcCUUas2oLc2B2A0EXsJhLFn9j6sb4OPokOWWTksX2hVKHyIMEWs1ci+u9/JYNdIhwkL1AYf95jmfpSxH+viesnGvvXqRyqPiAafTsoh8
X-Gm-Message-State: AOJu0YxE/JjJGFkfTKgkgZP/iI+L4XvEdmHZG4x/aW/xEchw6VZJY/SW
	W6OV+h0AkccIPGz4zT3XPEZugF3hiokz2MIvLNqCi8kKngphlMUZu3TR51tSLw==
X-Google-Smtp-Source: AGHT+IE0ztL8RIsOftGMZThcROohqiKseTO2JDvpmlkVCP+8b8LK1YIhEgA/osbAGwBzSst2Of6iGA==
X-Received: by 2002:a17:902:e54d:b0:1fb:43b5:879c with SMTP id d9443c01a7336-1fc3d9811d8mr5861235ad.33.1721103266544;
        Mon, 15 Jul 2024 21:14:26 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fdc9sm48665165ad.52.2024.07.15.21.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 21:14:26 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:44:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 06/14] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <20240716041416.GC3446@thinkpad>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-6-5f3765cc873a@linaro.org>
 <5ea6d478-f2da-4b68-8987-79cc5dfb8c86@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea6d478-f2da-4b68-8987-79cc5dfb8c86@linaro.org>

On Mon, Jul 15, 2024 at 10:02:18PM +0200, Konrad Dybcio wrote:
> On 15.07.2024 7:33 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Right now, PCI endpoint subsystem doesn't assign PCI domain number for the
> > PCI endpoint controllers. But this domain number could be useful to the EPC
> > drivers to uniquely identify each controller based on the hardware instance
> > when there are multiple ones present in an SoC (even multiple RC/EP).
> > 
> > So let's make use of the existing pci_bus_find_domain_nr() API to allocate
> > domain numbers based on either Devicetree (linux,pci-domain) property or
> > dynamic domain number allocation scheme.
> > 
> > It should be noted that the domain number allocated by this API will be
> > based on both RC and EP controllers in a SoC. If the 'linux,pci-domain' DT
> > property is present, then the domain number represents the actual hardware
> > instance of the PCI endpoint controller. If not, then the domain number
> > will be allocated based on the PCI EP/RC controller probe order.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> The PCI counterpart does some error checking and requires
> CONFIG_PCI_DOMAINS_GENERIC. Is that something that needs to be taken
> care of here as well?
> 

Good catch. I excluded the Kconfig check initially during development as it was
selected by most of the architectures. But I clearly failed to revisit it later.

And yes, we do need to use the guard. I also missed freeing the domain during
epc_destroy() which I'll fix in next revision. Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

