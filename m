Return-Path: <linux-kernel+bounces-526954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F9EA4059E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232A97AEEB6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837581DD9AB;
	Sat, 22 Feb 2025 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBPosaqP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE013A3F7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740201387; cv=none; b=s82P2Vl1+kj0F7Bwbjrk42PsbL32I/+4EDyp4wZEd/1G+YXN9pYy9eCK91ZE6kRor5yId6+KSJcvhr3Z1h3ZXinp57n2/sJTkfNLWD+98FlCOh5lwa8HRoEObxukFOT7amzmePM7RjrojWtDgwTmwjUaQpSqqbXpIw3s1nLDp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740201387; c=relaxed/simple;
	bh=wtNVlf3XQT26ODw3OGS2ndhc3JCo0RmEFrk8nQBsM7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk0o1o8DOuNu02Oxl0MH9d0Ctxu8OBvE6ZoJX0Vfpj5UeIMVCDy0Ri3NtaeXaPTgGfpWgOFdqT3IoprzBpJSmi+oc/ocWrRpm5fCopUDdQgRBslYkEEMCdxDNm1nPwJpnG2CreRQWFzEI9LU+NgojcKoLFKWFe1p9aXBMrvbv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dBPosaqP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3092643f4aaso24490871fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740201384; x=1740806184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVU0YAacU3CPA7LBjjQVHcZVAYe0I9EDkRANIrm2Xy8=;
        b=dBPosaqPUYjNBNgvuMx/t+hBjMegD6D9yjcq5VJcP/GVe2CMbQwYv0cjH+ZDxRofqE
         qG9yZaIQUc/YlBnQljnX9dwPThdk/dVrlKa6dZzrNUavUCMi8DARExWQ1AKlGhjHKhwJ
         ZeT62cXmmMfscEK0AWV+YKxWBnHXo9m0Bxv9eqvdkZlFJ7NmcCzZxSRlktDR6a/1jWZj
         lbzYQl+Kjk1s0AszKv3E1c9IOFnMIcJFS4p3+M0np3IT9LtrTc/B2nRF6qXAhMjFCBhP
         GX1no5ubaMU2qSJTJdEi7rRCWhr5isPtOw1OwG/SOXHrD+MHpG64Y+yqvU0mMDOjq/MY
         8ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740201384; x=1740806184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVU0YAacU3CPA7LBjjQVHcZVAYe0I9EDkRANIrm2Xy8=;
        b=DJS5uhmryol5R6yVJ7T0D9XGyzLq7thLPDUYz1xkeVmZcSh4k/j6IgKe/YunM6RuSK
         8R9aKpPl3ZT2yqef87egE+Vp439CjhGYjririZLoUUkXkMK4SGY7UXC7msGy8mVaN4b6
         XB4X5JTBryjIF3Y8Zmm+RgdwFu60SJ1rswyaBuUlKDDKT/UbMv2gyd4GLtoIFlexjzsw
         x+hZy43abZUZCQs78b0WKLXwhEl1MMOTuC5y1PaDcb2WrI7X7xA9RZ1d7zU3rvy/kwwy
         gYnSXVfl0JPHT00+5kQ1u3rl3Blxl8FgBmGj9t7uCUcHWBqzJ+JTN4zTjNvcMAwqzfih
         TM0w==
X-Forwarded-Encrypted: i=1; AJvYcCWGSoLQSEV/tLDKEEzWE/NLlgmxjr/nUJ15qFVaxOqB8KWa1H7c+JU4gZ+H2wcueKA+XMXo+2B9KoDUFKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrtdcJuxPJBTMSO0JvdStbnOfjhtwjgNE/ei75DJwO3l8IuIBn
	2u6/J252IwHsmwzMXZJg2s3jUqiuWzYoCqoCcCMLYMYi9Dt/pFP9T2Y86I4sMA4=
X-Gm-Gg: ASbGncsXth8f64PrY49xBrE9upxMOHoDbGByNbmbL8oGSvQAxJ2MT+JT18FqVC31Q7O
	0x+mwFXDJ2tDObb2JDrJxeFDGmwbDCRW53dbajAJAq+aezyWuzEX3GJVLG/gP2cTs7RWbwzvt4d
	EJ9fTX/2pBXyijSEukHHCA+wOmjQW9K95lVSfRwN7+g6b/EgYcRIDCycqMDvdTuNFlo+20ExM36
	gbbaqlVBseX3Nhqjw7MSX0tSHossBUdyVX8NahRXLi1Qb8STnWRQRzEcOLxxl9B+4HkhyYt8gTR
	knEhJ+wf0zwVIdba2kfEcb2wf+FI6P0X+rQO0jJ1ghDrk2pID6qYsABx45dfPeGiXijrNEbHhXM
	3khvJug==
X-Google-Smtp-Source: AGHT+IGUz3dETrnXBm4GATMpvH4STrOmJ2kxSysNuaoNAmCJrs3j7Br8API+6W+CwqlJMhs6QlWQag==
X-Received: by 2002:a05:651c:cc:b0:309:28c9:54c3 with SMTP id 38308e7fff4ca-30a5063fcacmr34146701fa.12.1740201383604;
        Fri, 21 Feb 2025 21:16:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a23fe35adsm22358781fa.79.2025.02.21.21.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:16:23 -0800 (PST)
Date: Sat, 22 Feb 2025 07:16:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 1/8] drm/hisilicon/hibmc: Restructuring the
 header dp_reg.h
Message-ID: <5bv6hja2dn6wcibdwfngs26dv3xxoltuq7qv3hsslw4rd5nw5g@ftslsijavujv>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-2-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:50:54AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Move the macros below their corresponding registers to make
> them more obvious.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - restructuring the header dp_reg.h, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h | 98 +++++++++++++--------
>  1 file changed, 60 insertions(+), 38 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

