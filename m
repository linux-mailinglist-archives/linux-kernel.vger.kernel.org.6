Return-Path: <linux-kernel+bounces-571283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24948A6BB56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36008189B76F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D9322A4EA;
	Fri, 21 Mar 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSHJTQm4"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D291EE7D5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562018; cv=none; b=F/xfOIpEASZ9u3GdUOV19myWfbli9z6b1bpXpIDverZiu4kfAITYgZ/AC42d+SnjHBaNyz+xI/rhowz/CY0BLayimkaua5mOb+4P6y/e76gGczNw+A6KUe6FPQZnwgwQP9Jb4tm3KShmkcRdtRbxVLEZKmXqaOQSFT+hkn4G6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562018; c=relaxed/simple;
	bh=plwBUBWa9ym9Mh4TJJ3ICNDcswub88W+vU2KUtjaPjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFXZ1IlnC1Nm0WxXF0kGmBLGxIclfdQ5ZeA+w4iraIa6QAniyMk5a78eHkM+6IoWgUfZ3mjCKwefcmxumH7nwqmQBfovPcYgqzfTxvSUV+hQS1llPjoRHfoVD3QblOGc0LYeA11Af+/A+sBgy6XanRNdQmHxNvLCnY6Dt4/d2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSHJTQm4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240b4de12bso2449475ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742562015; x=1743166815; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLOWpBJ/84QqSStkKvu70G+ifFT/ePp0AEqvzzVNHGQ=;
        b=HSHJTQm4gzsOdAXxkfpUlnIASgwID2Qa/SB3VSa7FykybFmUFkH0AGKLkOIz/EAc9q
         ta7siQKSzDUJBEGz51J2LDuhnChHUqKfmBlDD/w5Kanc0tyMRTEaS7JqlKE0wc8F9obR
         bteVDlbqvqJGOsFXoJ9vuwqn40t9e3kcmbFRxL6PndlocfiiH4ufDiDlU3WwYTlco2mx
         f6KTfxhGXmC6MCknGSKN0mWsReQjqcqKvniDfHBj2fMGWii5yk2o3dgkzDfGYNHZ0VR1
         2ZCtqws6lfzCSxJLVLIqpExKbcyQZqAv/z4QZ5RHvu1jB0N/S5bpzierV0HuFMxKNPJo
         kNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562015; x=1743166815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLOWpBJ/84QqSStkKvu70G+ifFT/ePp0AEqvzzVNHGQ=;
        b=pM2PIH+aBumi+UMMLlEQu98CN/IFTakv7h31r/tr2QofQnFGG30wCknMUuRQ38T3Ex
         hQPNFnhb3CUCdo+Ry82dQ9YRPPSk2ZQgpcJ+y3Br2pcsMdxi5sxS2g8PVAtGp1WizMph
         w+LnaXAOAICILG9FqVYjc91XCp6Wb/RbLrI96Y0adbbouhVSXYET9BJ7uSfFdxaFLSLk
         sA6oh8OM8j595QZtPvFMPYkQPprjjtUFwiMyzSBnlQkHIV01wYzAZuD9H4fJQOJP5p/0
         IagDx4n7VIruYxSG4UMrcHGeMVvrU3aSGkX6B9Rz8ZietlpZMl1vVsvolF+udR/pULtt
         Co5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKzcHQZi4YeevdjD9npamwFUHpVn6V0KiS8FmF8HXi7hBRd52yAeVFETBD3T05iQMbbR/LbCpBNzYtCgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKU8cYTpEpxA19LiOvUyC+ZVT6xIlQcmHp9qUEA4ioVJLQlH6r
	6ucKyXC126KPom4vcCGbNiINKwaff9QXQit7h8r3AslMJi0YxfM5OP5wifZy1Q==
X-Gm-Gg: ASbGnct92KYj7IdleYzg832g+QFVe/T2rEaJO9AzGfXN4pOz9B/qaj8XAZ9UR79dpfZ
	aBaqvPsRUkAJufTiSaeksezEcBGZMyP28E1/fVcpxRrXBUpvZNxH6d6RnJ5jZTlD2W3bIKEiU7i
	JHOmnZteklwNOKW6R9io3ACZ8M0JKE/mMK6hBR/KpGEpT9w2PJh/5SjWIATt1Bai+DjikmEtha7
	EFF3788+5QnZqqw7ePwnGS2i7/Pp7iVMwMEuzdXonZGap28Yh4pBQqsA3zebmi2741ZDYZu4vR2
	u56ja88UzSsXFxPAp7rM72beL4nKvfIuXBkY3qKfCkMYPmMtBvHGF8Y0waqRn/OTjF5H
X-Google-Smtp-Source: AGHT+IFTfL0DLPrgepqPKLA9JqmhC76PAJXtBjhi2YTyYHpFIbG4X1nRwScZA52uGahHQ3nMbVLuZA==
X-Received: by 2002:a05:6a20:d497:b0:1f5:8678:183d with SMTP id adf61e73a8af0-1fe42f2c686mr5981977637.14.1742562015263;
        Fri, 21 Mar 2025 06:00:15 -0700 (PDT)
Received: from thinkpad ([2409:40f4:22:5799:90ea:bfc4:b1d2:dda2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4f585sm1602397a12.73.2025.03.21.06.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:00:14 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:30:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v4 1/4] PCI: Introduce generic capability search functions
Message-ID: <20250321130010.s6svrtqlpdkgxmir@thinkpad>
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321101710.371480-2-18255117159@163.com>

On Fri, Mar 21, 2025 at 06:17:07PM +0800, Hans Zhang wrote:
> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
> duplicate logic for scanning PCI capability lists. This creates
> maintenance burdens and risks inconsistencies.
> 
> To resolve this:
> 
> 1. Add pci_generic_find_capability() and pci_generic_find_ext_capability()
> in drivers/pci/pci.c, accepting controller-specific read functions
> and device data as parameters.
> 

I'd reword pci_generic* as pci_host_bridge* to reflect the fact that these APIs
are meant for host bridges.

> 2. Refactor dwc_pcie_find_capability() and similar functions to utilize
> these new generic interfaces.
> 

This is not part of this patch. So should be dropped.

> 3. Update out-of-tree drivers to leverage the common implementation,
> eliminating code duplication.
> 

This also.

> This approach:
> - Centralizes critical PCI capability scanning logic
> - Allows flexible adaptation to varied hardware access methods
> - Reduces future maintenance overhead
> - Aligns with kernel code reuse best practices
> 
> Tested with DWC PCIe controller and CDNS PCIe drivers.
> 

This tested info is also not required since the DWC and CDNS changes are not
part of this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

