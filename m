Return-Path: <linux-kernel+bounces-364532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4F99D5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC281F23B47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9881C75EB;
	Mon, 14 Oct 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9hQNjy2"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DC1C3300
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928105; cv=none; b=IQiviTE8XVcc7/5OHhlTsPK2BVyQ6eXgoYquAG49hmjXEUf4X7hoqzfNot5ueqfB9l5EmS0dT2f8XMszcccXNUthylagiVSUHIhrtgqg6TUlSzBr/9TnhIU1ORctSs2cuIBQXZVZoOmYzXo7ek4lYEtRzB4TlaFeivRQ/t5YtOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928105; c=relaxed/simple;
	bh=hkA/UwlKxHuClMD9lIsvdvS3GwQC+C6zQ/fSJ3ps2fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZPPPK7nA1OOKqPsjuzu+2g8N2euacBqln/TBcv9YaDqxDXC4GmaMUby099etqnXNs+Ho7lTZXQClTk6TicUlhn+BWkZi59XjkdPxDEp7n295rrgYKeWj9LgOmBj5bHU3E3N4Sno7+8dYAoiz5UUWCT8Ffw5yDRnj0C5WyQOo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9hQNjy2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c9978a221so38588165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728928103; x=1729532903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZHILu6A3GzL8h1J8DM4pk0STE1eNYqPdJWCjpPQNIQ=;
        b=k9hQNjy2Om9GwxW+QB+n+ha118FUjBJCK7feuJFBHsReSaswflow+XrSxSiQVTbe8X
         cJHWZ0fODV9pnWydkaXjK0YDG9nRL3ycT9KlWEggL56v7s8L8HOozyQbaAIhWbb1eVJV
         NY3jsOZkSu/Duc25ihIhEXODYwhhMdGEd4NP/CC4pdvEwjWv0fnE3kVe5uXgokN/1+FH
         oJGGzAVJZHlUZ7zXTC5iZAtSg50CjbNldt+v1q/FhwzkBzQXBoeFKE2Yz8Ktl2j5+sHe
         hj6YYCAdMJKwQdH6TJeRVa4qoM/PTvwfXpvWAAKkUWVv6PSbM4qkxdR4rHdgJVJNAtms
         oO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928103; x=1729532903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZHILu6A3GzL8h1J8DM4pk0STE1eNYqPdJWCjpPQNIQ=;
        b=ND0oZWCdo2y4p3m9oGCjmpoKXMiAmqeHzVYxFbmcx3jQRUPEXGXp7tJXmXd2G2FgW4
         R+6dTMJFcM+59OtBE0Af9ONfuYvU8Yrk7Azt8hbK3zPyT5LUeA2BdcCxLRn3GuYj5XKf
         gGb9c42H3nlJInZ8xknwpuVoXi7mu4Fq4gY6CsGpgH/AfCkCOZ52x8heLDgMJg44yive
         BfyApT55Km5xtj7ULf/0dhMRB7FM1WuuJLp7WIhZ01kaqLl8yAvhtbyEeQ9F0nSIvay+
         JnQ4A1VRPRLeQf+9F0kjzyI+5YMbQyNoKL0TlqIj788kjWGwAGg/hK1U7Z1G8OvQ0fii
         aNqg==
X-Forwarded-Encrypted: i=1; AJvYcCVotDRCBvTItLL9jLbR6QrRa9duwfNQ5Gu40KA3nXEKV50UYQoNS6VyLfiqMlGNTILfGwSOU7FSNXUHKmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VI29zy4UGqV4y5Pe0/21nQfXlQ5ixRU/j4o4jElk20tiAgu6
	abVtQiPB/NIaK5mRoyiE1XrJtEKBlVkD5VXsGddBNkk2pFa5EDdQnhv0afwsWg==
X-Google-Smtp-Source: AGHT+IFHXuRp20dOBhnprIKSxRxy1eZ0bHqbOKCNaqgV8Jyk5O/y2jlCAO3z1JgoqmcK2fbMcYR0Rw==
X-Received: by 2002:a17:902:c951:b0:20c:f27f:fcc with SMTP id d9443c01a7336-20cf27f11e8mr49200475ad.44.1728928103217;
        Mon, 14 Oct 2024 10:48:23 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c348a1bsm68689275ad.284.2024.10.14.10.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:48:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 23:18:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, kevin.xie@starfivetech.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241014174817.i4yrjozmfbdrm3md@thinkpad>
References: <20241014162607.1247611-1-quic_mrana@quicinc.com>
 <20241014172321.GA612738@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014172321.GA612738@bhelgaas>

On Mon, Oct 14, 2024 at 12:23:21PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
> > PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> > bridge device. To enable runtime PM of PCIe host bridge device (child
> > device), it is must to enable parent device's runtime PM to avoid seeing
> > the below warning from PM core:
> > 
> > pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> > with active children
> > 
> > Fix this issue by enabling starfive pcie controller device's runtime PM
> > before calling pci_host_probe() in plda_pcie_host_init().
> > 
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I want this in the same series as Krishna's patch to turn on runtime
> PM of host bridges.  That's how I know they need to be applied in
> order.  If they're not in the same series, they're likely to be
> applied out of order.

There is no harm in applying this patch on its own. It fixes a legit issue of
enabling the parent runtime PM before the child as required by the PM core. Rest
of the controller drivers follow the same pattern.

I fail to understand why you want this to be combined with Krishna's patch. That
patch is only a trigger, but even without that patch the issue still exists (not
user visible ofc).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

