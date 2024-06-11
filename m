Return-Path: <linux-kernel+bounces-209568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CC79037D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906961C232DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D7617A93A;
	Tue, 11 Jun 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm3a4IW6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2E179957
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098209; cv=none; b=L9cMMMBD2iFaRfbuqVrdOEBuo2AqrcaG/N8n+n6RMlpGPKo072+JBcMMvdBfAElf8XoX7fadNzsRChU/onEYNZqzsSyS+AhG+6LfBNBWpNW7a1GYcAzIR5q8IHV02TBwIm3kCnZ9/YarFVSXuxw4p8lKcZB0zeE6PfQ2p3BBHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098209; c=relaxed/simple;
	bh=oRF4fJcuFF0VQzfxlzwnEOvv9MVUO7PD9p6bsjxxJWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JCHPf9oaVm5srIZAGkZ7cnjXG2GqOPYfXlkjTKQS/9J6nw2ZHrDhC/6Vm1M2EtaDrxVYd8ccN07iAQmx1nT/VrGcT6WT3C1VmwpY8dsz/Upayi6yrXlCPxvWW/P4KA+hdGKLr8rlJTRgG91C9qujp/FpSttKd3kcv7rVf7kN/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gm3a4IW6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f04afcce1so93785466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718098206; x=1718703006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYwTeOx15XiM1cO3X3rFudAeXPUDdn9iEuiRZ/UR+9Q=;
        b=gm3a4IW6C8xdVUNcDR7MS14DXALHt40a5NFBrzutCpn7fprpBcxTdCGKjQMXIxiKQL
         YeoZSkhmdSloRfFUQb7XIXLfmB/pCjB5zsNdRVOmGWEu2jLc3BmHoPFCeLHjtRZfY8WI
         xXtQzIsaNPdq/9TZSpMFW44q0D++XQAjKjlG54gSWHoodE6fa5vgZmT0CmmMVgrFAgqV
         ABj649iYrvJFzNViGQxMDCF/P07SisLAHqX6Vi6zDVeBTkT5D/J/1Qd7mRKCBD5UkZ3W
         IB4qN9VgbXJvSzGyirm4omfTCjDETlrNelxIeEx0uAZVksVkL5LG2KBoRtAYFGpLSGgM
         wvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098206; x=1718703006;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYwTeOx15XiM1cO3X3rFudAeXPUDdn9iEuiRZ/UR+9Q=;
        b=Dg/8BuqEDvZq22+UJOyBREEB+jZUb0FCYzgXYTIkTgCmByGjLuDsrEDAH+kSO+Pl7+
         6kGINZtqJhLu0sUtTX/jOWbXoLO3cRZzhw0TKt7bSMtn99ENTv4VrSu6X+l+uCPrIlkf
         A7Y59fSth4RjihYvKajdl4gpO6jd5ch2yjiSHsGuhOXxCHrkHTnmhDEH6xdrK4VpBw/k
         9euwHwBbYAyNnkCHEzQ57rpDOD9YGlkZXJGL77VzzGQbL8pSPzWtGpX8rYCSMx4icfBq
         vd82F25PTx43UlwPMm9NLl4ZbAQNjYWlpJ1yWY/ct5o8nnTvpDPNzzOmetrfenNs8haf
         7CXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU7ZOuiLUVNeL7m2QmzKMnR8A56exRoEI/7n7rNFRHcK+svIay2CqADliCw4DGyzLYBLxDTX+Elq3InS560eZDt6Y/LYERj3u9jtGT
X-Gm-Message-State: AOJu0YxLByC56MSU1rW4QlfM+TUKOwGCkafNr6Qrca2i3WwtJEy+fJDv
	+BCcW/HNIBCchR5ciDR4nO0WPT2Eb9NSnjejK2v/TZkArZtNZUfiyF4Zf6iSRIhWL6ViT5SGcJW
	EHsE=
X-Google-Smtp-Source: AGHT+IG8u11F/w8MKZrcJa0IPQI3BlkZm7Vsfe3fiOz5lykU9FYa3FCQvw0EKaTXu1w3QdFV6Dxqlw==
X-Received: by 2002:a17:906:5608:b0:a6f:722:a1a7 with SMTP id a640c23a62f3a-a6f0722a461mr642345666b.67.1718098206066;
        Tue, 11 Jun 2024 02:30:06 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm735715966b.110.2024.06.11.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:30:04 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 quentin.schulz@cherry.de
In-Reply-To: <20240507122256.3765362-1-heiko@sntech.de>
References: <20240507122256.3765362-1-heiko@sntech.de>
Subject: Re: [PATCH 0/3] Small changes for Rockchip NVMEM drivers
Message-Id: <171809820467.51273.1855586931419664049.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 10:30:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 07 May 2024 14:22:53 +0200, Heiko Stuebner wrote:
> When the option for legacy cell dt layouts was added, the
> Rockchip OTP driver seems to have been overlooked, so set
> the necessary option to allow seeing the cells again.
> 
> And two patches set the nvmem-type option in the device config.
> 
> Heiko Stuebner (3):
>   nvmem: rockchip-otp: set add_legacy_fixed_of_cells config option
>   nvmem: rockchip-otp: Set type to OTP
>   nvmem: rockchip-efuse: set type to OTP
> 
> [...]

Applied, thanks!

[1/3] nvmem: rockchip-otp: set add_legacy_fixed_of_cells config option
      commit: d4d688ed8f312dd1cf986c956251acf6176f5085
[2/3] nvmem: rockchip-otp: Set type to OTP
      commit: ee65a6c12badd3e0891c9096d6db7a0dba655c1b
[3/3] nvmem: rockchip-efuse: set type to OTP
      commit: bb503130de1212cac2c368b373b0192eb7c59ab6

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


