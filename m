Return-Path: <linux-kernel+bounces-425803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994FA9DEB22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADF6281804
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0A19C552;
	Fri, 29 Nov 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPC2Vp6t"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9044C77
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898167; cv=none; b=izm3gG2WH1m8Pm7lhsbTOs0i3PHv/7ys4P+IVrMvSRY7GjtVG8zBYc3wEY3PNQnMTnsEB9rqv1H2jB5UXUGME6vLRUGIch2/kWgE1cETE+IK0ps1u5jAO6bWKZE7Jj8YWqgCPVLg6mGYnDH+sQjH9BvygHgH1odWR6EluFwpA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898167; c=relaxed/simple;
	bh=InsIgXgLx7YQgnFJY31nsgNKsFevoHh8zNHdDTTAP4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuWvnj0H50XOFQsAHCAm+P2E8yGgrZeK+As8ow9B0CMQvc6K/CslW5o/Y7APhx0TfCRGpXk5PIz2acheTNGtMU/aMMfBAcR01c3dkrRiuQYjgnzhIz3asfWKX5zKLz/hIebpCa8TzB3QBkCLoUMFkHd+SlIBeZGgYIl9EA5ZmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPC2Vp6t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2142214abd2so16275405ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732898165; x=1733502965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KAS4qmfhKfQCTxA5dEKDiEOUQ8ijX4qkasD6tbLsLDY=;
        b=IPC2Vp6tUBD6IckBjhM4xhIBQtW6h2a6Vb+KKST/25Ev1SZT96/UDRqWq+nd0KZ5ui
         xRiQVgQxuyNr6tFpO+Q21r/SwNqJ+aRmmeFqv8rhSeRgCe1Os1Ar4OzNJgFVwkwPczr/
         MLubFE5MMUtxzTbYbZ1KYTePxz8vaz2plXYks2F2eSIIhhxSF6lxpe/DU8rcQ3to44k3
         6ZTOH9SgvrJgleMjTcvxuzw2J2oIJQ5tXzJdr0FExIbZ+O2tdZhY++KEBH0WrEswuIK4
         AYJjUi6uEkpSINUBb66kQkHLMH47Z+N+WmmC/dAuTJXjoKCfYeAlSwxJG0XGcwwOJthd
         7hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732898165; x=1733502965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAS4qmfhKfQCTxA5dEKDiEOUQ8ijX4qkasD6tbLsLDY=;
        b=YyanWiDuSaiOzMg8KTQjxnpI4CZwWgc9wElby9PA9hMRhcbSXsDhlwzFzymMNKfe0Z
         rdrPNHY5BZLeEG5cEIDT0K9yndrA9kjwJbYLr9I3xWNaMKnoOh2+RDveDjQJFIsPObaX
         uvLjhtphV2wU33IRWwvFxQE0nHwke45yPkNq1P/l8l789hAb/3zUcmqHIvUYiL9Liqn0
         DOpdEhOekGT5KjyUzLZFukMEZFHV0Pr/AllWLNB9qfWRmhQuL+p88K/Qj37OA8cFQERy
         4pV38/4zkLOuJGfMKuEFqzmPYyDxoXEtVxBm6FXPwURvkKg1j8EujylZDkB4G0V7V7cZ
         NbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK4WrGF3Ark4at5ZfTrVvickOwtGF2gF2HQ6Fp1YLeAm9icoCVU9pGE6h0QJbUEiJxkRSOsWSWQng03hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkcCC7SwM/ogTCIjOE3gpkt9VRBvP4IgLyiR6EecWgziRcfAx
	P6p6dlv93eorygyZc1AJ16tr+e6fssIVoTsIJOiu/NzahYUou+DLZTGKPQFlpQ==
X-Gm-Gg: ASbGncsTSD2qXxSe+nYj2M1js4d3NIqbdkjDdhTd7E2rVcQSMboGOQVoAINXprfYBAx
	YO0FH5ANR4K/ioETXYI2iYAW5L+Hc9z/GDD0OGAvd2kfdn0laUR/fPc+kgE9woz/2dFTN5VlUrB
	2S4TYRBji/aBIUJH0F1uXmb9piMHzlImRW/Kcrl3YaFywPc3P4E8+54HUM4rq9NlmkragIUCj6t
	+qVfPUJLb3mvaWcDoRTChn1MIRP4CJ6+dm0yyHIVadYIQLX3K8Q5hjCHV9d
X-Google-Smtp-Source: AGHT+IFsGXl/IU7bXt5NrZfPNWz7fsWHGMuIQFgh7MSCJkj2+YOoJBdoGnq61lBkrYp/j8HLEMymlA==
X-Received: by 2002:a17:902:d491:b0:215:4e40:e4b0 with SMTP id d9443c01a7336-2154e40e808mr23212585ad.9.1732898165186;
        Fri, 29 Nov 2024 08:36:05 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c31a0sm32731185ad.249.2024.11.29.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:36:04 -0800 (PST)
Date: Fri, 29 Nov 2024 22:05:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <20241129163555.apf35xa6x5joscha@thinkpad>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-5-manivannan.sadhasivam@linaro.org>
 <Z0nG3oAx66plv4qI@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0nG3oAx66plv4qI@ryzen>

On Fri, Nov 29, 2024 at 02:51:26PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Fri, Nov 29, 2024 at 02:54:15PM +0530, Manivannan Sadhasivam wrote:
> > Migrate the PCI endpoint test to Kselftest framework. All the tests that
> > were part of the previous pcitest.sh file were migrated.
> > 
> > Below is the exclusive list of tests:
> > 
> > 1. BAR Tests (BAR0 to BAR5)
> > 2. Legacy IRQ Tests
> > 3. MSI Interrupt Tests (MSI1 to MSI32)
> > 4. MSI-X Interrupt Tests (MSI-X1 to MSI-X2048)
> > 5. Read Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 6. Write Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 7. Copy Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 8. Read Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 9. Write Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 10. Copy Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 
> I'm not sure if it is a great idea to add test case number 10.
> 
> While it will work if you use the "dummy memcpy" DMA channel which uses
> MMIO under the hood, if you actually enable a real DMA controller (which
> often sets the DMA_PRIVATE cap in the DMA controller driver (e.g. if you
> are using a DWC based PCIe EP controller and select CONFIG_DW_EDMA=y)),
> pci_epf_test_copy() will fail with:
> [   93.779444] pci_epf_test pci_epf_test.0: Cannot transfer data using DMA
> 

So the idea is to exercise all the options provided by the epf-test driver. In
that sense, we need to have the DMA COPY test. However, I do agree that the
common DMA controllers will fail this case. So how about just simulating the DMA
COPY for controllers implementing DMA_PRIVATE cap? I don't think it hurts to
have this feature in test driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

