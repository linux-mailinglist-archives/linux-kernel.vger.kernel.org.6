Return-Path: <linux-kernel+bounces-215464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F8B90931D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D45B236CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547B1A3BA1;
	Fri, 14 Jun 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhhUXeAn"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16416D339
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395208; cv=none; b=Pjg+FVrhSDxki3UIqerfsx8DKCBsQKUp9DAAW5vTxZ2sppCkwbEeAnDOMuqQJIaqfTNmUJj/hx57TcZEctGHR3cVF7/MQd4CSpBPvr6UfERRJDlO5Ng3YiRlB1nEqElqTh75E0hCKPaXC0NLVXfN4NNW8l0YosKdL5fuB03VGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395208; c=relaxed/simple;
	bh=UecWv9IJeqO0ogDEFKZ30msCBczVQJG5/sT8DUT1gZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hMrr4uyvQErik8Gze8e3gEh+c/kT59qDEZh7KqW1vP0WvPXI1m4ztauWSi3xhQCqfcMW97FcyXiMQxSChnspwKA6uhK1c3O+WP5rJLbE2b/ugu8Y6P5GlR2UHY02lC39zSJU4CzSXmCxb3i3GOBAFxvTZVay/Thi7bVr5Kneals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhhUXeAn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f2f5ad1d1so23382166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718395206; x=1719000006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sffmBRRqxvVZKL+gZwYpJ+2d0Xa8nclbjp8aHRZVxo=;
        b=LhhUXeAn19Lem4aLVuVLFqh60R/NnQnt2pZbNScUCFAapXJxvAqmkZVpQ12Ypr2HIZ
         d8OogiURlMaX+LGJ/so/VoZ8AT5t3bGD80aqMB1MxanPoqKJLZrlHOevFlEWl8vxcpOd
         ZZuTeNxDy1QbyUq2vbHLs5zysV3ZVs/SVYewmCLk+C5iSd1g/r28mtS6w4qFQoCv6BSE
         ct3tVdWQm3tYtwUAHqf1UoCsiEFPUfOMWkZsz7eyQuzV1syX0Kl63rEaCWRtVMb/Uxn/
         tz5n/jdHMYW8pwGhbk1cG1v+GYlTHoRjAvNd4NxEbwornz+vT8DVSwrCbQnlxR9zDvD6
         k80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718395206; x=1719000006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sffmBRRqxvVZKL+gZwYpJ+2d0Xa8nclbjp8aHRZVxo=;
        b=C1EX0lnb81cse6w6+gn6WTZHJI7Q0DHpuOiOO8HffFa3kAR79NK2VF/Qno7ljUEmrg
         6g03s7S6Q29hyF0444Zb8+STXwSNKxno5dbz2L6asje1DaA4hlsUn7+hRJbGrnfMsoZp
         rWjMrvpRk9s/Ed4pVGNk3kfGRf1TJTIFpkGLYk676SZ0tlgD8C6xxsC788gOou5ZW8+F
         JNDTQxOKlldvUHaD2bQ6I+L8tRRL1rDSOR3mKWzfpF45y5n6eyJ09aNt46UjtKb8aqW5
         CzgLDrNX5k3BkpKmDZQ+3lDX9WCNGei1NLo6MBYhhHymYqg3CIl/XhjMoEAUYzu0b1FG
         eiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWRMVI99OLQ/tVeqPRYsjWni3tal+gGxqh9THMGEp1Zx+eKqvcpcIF0yHcYc8sNikHqrPpOdVRUCHnJTiqUdpn9g29B9dgs4HUg/Vu
X-Gm-Message-State: AOJu0YybOEUDiXZfj+CFGvFzd45EmTDV2ceF8SmCW7eoOWbY3JCOlrUZ
	hNR3NhTFMRgQYoE3TBTod8JJkZbJwtDifJJMbZxB/5r/fY7MKOMTPgJEIA==
X-Google-Smtp-Source: AGHT+IHuBi11JQJsVJTkYZSJBQdsXFWebGBbRzzvC/b2FAzj0+X9BAS2A1lf02+zZ0XxgNKvQEv3Qw==
X-Received: by 2002:a17:906:f5a3:b0:a69:edd:3323 with SMTP id a640c23a62f3a-a6f60d13971mr290842166b.2.1718395205371;
        Fri, 14 Jun 2024 13:00:05 -0700 (PDT)
Received: from [192.168.0.104] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed359bsm217076966b.137.2024.06.14.13.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 13:00:03 -0700 (PDT)
Message-ID: <4a18cc93-5495-41b1-a40f-7873954200f6@gmail.com>
Date: Fri, 14 Jun 2024 22:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] staging: rtl8192e: Cleanup multiple issues
To: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1718309120.git.engel.teddy@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1718309120.git.engel.teddy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 22:15, Teddy Engel wrote:
> Remove some unused constants, macros, and structs.
> Capitalize a constant.
> 
> The patch order matters - please apply in order.
> 
> Teddy Engel (5):
>    staging: rtl8192e: Remove unused constants
>    staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
>    staging: rtl8192e: Capitalize constant RegC38_TH
>    staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
>    staging: rtl8192e: Remove unnecessary pre-declaration of struct
>      net_device
> 
>   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 9 ---------
>   drivers/staging/rtl8192e/rtl8192e/rtl_cam.h    | 1 -
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +-----
>   drivers/staging/rtl8192e/rtl8192e/rtl_pci.h    | 1 -
>   5 files changed, 3 insertions(+), 18 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

