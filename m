Return-Path: <linux-kernel+bounces-261751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1969293BBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DB21F22848
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A1200C7;
	Thu, 25 Jul 2024 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5tUR8L9"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9C2557A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881208; cv=none; b=qTBsLCxIkwXZq/UhnDA62LkIFMsFwqFZQcjCI3JzHty2TY73l3IUL7Oj68jU1HKAbE90oS5fVFHMl+iIYJPO1LBXNmcD9BeneqForP1mz+oGp4Y9WnBcabvs0+kWfN9+PZbzWhMDemVpCkoCtCXp0El1IoZ3hMJV0mebWNcioPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881208; c=relaxed/simple;
	bh=kY0fom2PT3ibinAtblwyjUOcEx2vyt9CB7IUtU19EF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBN35/9rg6IF27Sqd/gVIR8jWZM7yoQo1XAxHwLND6hKzUpfMek3/NQZ4KDAkXr+J7/IoNjqojBzBLI0TSzthB0JHh7BKuaXcbmtq1lOp3uA3OtA+PFg3bS4O7LuzaiHtWQu20D/hZPfVEo94s8oqfMvfz4Vp2t43Zvi/2ZYwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r5tUR8L9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-656d8b346d2so337721a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721881206; x=1722486006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4DmP3fxtSOwdi96Nd0UuEVePAIBxvlXMyWHucrA0W0k=;
        b=r5tUR8L93LsJ6PPjDDtHK2JllOIecu+d7QrSwIaYRp7oYVVJxbypsi4MgW/RmDQ/mn
         G7OUN8ZxH0/+sITHKeKL8vJpHv7R11Ss704Bk0v+bm/uFERHMKtC51ZIQQdre/xjqRoH
         rhl3KTehZIOdSb0Gl624W56zIFe40T/ivWt00pQErld9syB9FsYU7axFzeLT27AfMwWw
         fjCTmYrQ/nvCJNjD58iVf+H4x3g3vjTEneDOChEQjuAFM8rTqLZ8o6nYOajs28j6kH4R
         1/yba9pt++ROTWwqMuu6ulWp9Jj6IDUcEjuElbjYEAgO3CPUYDuKBqOJxfJiZWXNbnvT
         4diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881206; x=1722486006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DmP3fxtSOwdi96Nd0UuEVePAIBxvlXMyWHucrA0W0k=;
        b=gdu6L2rvQDa4TySoTR/HEFdD4Pc0ukCZ++zcJ6TcqyWGGDfRCt3GWYJGpJ1bnUihJV
         iypeYclw9j1avTK6w3OwCoCTlW1LSy+CZ4UmVxM9vip5c3JvNPmZFYtI+vv2cl89alwJ
         S+d879jrsCiDgGHsEwndBvxdvU2CFb+3cWUhXlYalyAJp9MoHzmhs1yGRNc+zVaj8sWM
         ffisQx/skm1eLEGvA+/WLTTgbTzffIUSbxWa2eOqkXp5/8yM/LX4PMdAULUIbwfhCK+n
         bqwmgkTyAmSs7MtbHPZMn3/JJBnnZFETewzg2X9tf7t92EU33S7+6xuyKZXrmkE3v3Wj
         nXFA==
X-Forwarded-Encrypted: i=1; AJvYcCUlsd5ar82mcNJMJEWDanKt2MD+IOXosaj5oFw2jSPVbrSJxNgxEQzYlckICjUySZyeeCEFPgEar8SBMA9Ywa/1XvLyhv+Usq2Yvw6G
X-Gm-Message-State: AOJu0YzkalmIRwGvvu7ResqYCvc/1xJkxlhXrGzu6X1h0t7ede32aKyD
	57UNYdA7Hfqgy6oF4qCCIKVFPSuyIR3u4TzIjkPMpxJ8Y+Owc0qbtEdKL3Ikbg==
X-Google-Smtp-Source: AGHT+IF9TZsz6K8Hhe8vA7NOEy3c5xlX4b0C9eOnbb45IRWGE/FRIYwhph7kpZbJ0Q9QImNE3lbUMQ==
X-Received: by 2002:a05:6a21:6b0b:b0:1c3:ff89:1fc5 with SMTP id adf61e73a8af0-1c47b1db237mr641329637.30.1721881206605;
        Wed, 24 Jul 2024 21:20:06 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7f66esm3964335ad.15.2024.07.24.21.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:20:06 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:50:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240725042001.GC2317@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724161916.GG3349@thinkpad>

On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> >   of_irq_parse_pci: failed with rc=-22
> > due to the absence of Legacy Interrupts in the device-tree.
> > 
> 
> Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> if 'map_irq' is set to NULL.
> 

Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the INTx interrupts
are described in DT? Then why are they not supported?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

