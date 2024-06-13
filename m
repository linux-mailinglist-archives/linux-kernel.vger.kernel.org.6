Return-Path: <linux-kernel+bounces-213750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E429079DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FC81F22430
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2F14A091;
	Thu, 13 Jun 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7J/3Kki"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702714A4FB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299805; cv=none; b=VVEpgfkOEqyqsQcTVrS/k9MqR9d8Ovezrf30D129DEvaIzGb/b8qaCOo8UI8mEX8+6tLBECPqeKTg6dWEmmPX+E+3iC5f9sAaa4qHwdYKSPaV7FpnXsuZV+NEGrUPwHE04jluOlA4XnZQB3Z7zkT3zNLCG3WE+K4MW1GrsD6Si8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299805; c=relaxed/simple;
	bh=nQiDweVW/klqoccVHaFCqThejMLRDTDiNKGZP8SERFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxWLtEQ8NrA38YoTtcEwY1tIZIdIzwHQGN+LwX0gFpTYqVwfGkm3JaKaIPkkrDMHTm3s0MNu3E1F60bJu95lmjOQqYBm/3KiW1yG/dpwFvbrR+qUXw2Gkl3aahGR/fft9nPTRcyy+xycr3fiEX9bNSIu1+iaePKJo4tOwgnhqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7J/3Kki; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eae5b2ddd8so21297231fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718299800; x=1718904600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWKAFEWXLrDJc52wb2CYS7tZPMyOOyhZnNSlFzB+HrM=;
        b=X7J/3Kkihoj2iI84ibKwbukASjpmL35Y+rqH/K5n6lkuuE5P5+e2RtbJAbAiBqdnCl
         e8K4Juh2GhPHzSqzU247V8hta/S5ihNYjQRQv14NDLjRDdKQUMzGnsjDSG885qhtXncI
         TCsxgj9ewTWN2rRgx1wrwABH8v4zB2OdqeF72oGhMGJ5gy1z4R1gt84bft/DFtBTz/GW
         oEo0L1iLNPzH0nteRHZk7xcr92zSNJhypresnj1bjSsgxup2De8nIPGKO7bURUiKREs+
         AAcWOtnQmsc4s9kGLQ/dI0xzQCYepHbqTJZkDrViPhu/IYsS4nzRqfWpEMOUMjGkEbrm
         w5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718299800; x=1718904600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWKAFEWXLrDJc52wb2CYS7tZPMyOOyhZnNSlFzB+HrM=;
        b=NqyQvLH14SqLC4OMWJH2wj0g7Bk2VaDOdF0k3ZjgjyfSJs7f7w0j2sNXmcqm+K9vw9
         jVX23kDNK5srVBg9O3SivcN6rSEzGBgU2dxMSgpVScbTEWJmHaF2qDjVEZweCGt/FxlI
         p5rBowUn22NhNnVyk6zitZgU2J3zxKYqTlh2qgq4wzS7ho83rO7sZt/5I1f9auoa2Et4
         UrsDpQV5/txDsb4KZ1OPlx+hRXQD7Wa1iOaNTTbaL2APx6fDRRVjrVhXtzgszpalgYoz
         K4tEiqUBYfCZ444sE2SGFmJnXlkRsxwpX/Uo18HSc8DAU43u77rBwbjRVfzGZ8DsUErw
         iWWw==
X-Gm-Message-State: AOJu0YwycQZmcDPUJhYjwttZLZFj09krb7pqd6D6PKu9AApjAK7Q2su8
	PSIo9u0VOOQL0/oKmsGtBZThPmLcS3SK3m9qbeSJdpe0/y/WoEETvcOol2tOqQY=
X-Google-Smtp-Source: AGHT+IGt6b57iPGgKOMlgH4lEbT/mnoJM6KeEbuePOr4Y0cQ9OdVWNFNg4ifNbIJ64ZbC30ao5/7/Q==
X-Received: by 2002:a19:e04a:0:b0:52c:6464:a7b1 with SMTP id 2adb3069b0e04-52ca046458dmr845484e87.28.1718299800458;
        Thu, 13 Jun 2024 10:30:00 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76? ([2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287aaccsm295981e87.223.2024.06.13.10.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:30:00 -0700 (PDT)
Message-ID: <75d675f6-d827-4b8d-8c88-29ac5785e5c2@linaro.org>
Date: Thu, 13 Jun 2024 19:29:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix refcount imbalance seen during
 bwmon_remove
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, thara.gopinath@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, abel.vesa@linaro.org
References: <20240613164506.982068-1-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240613164506.982068-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/13/24 18:45, Sibi Sankar wrote:
> The following warning is seen during bwmon_remove due to refcount
> imbalance, fix this by releasing the OPPs after use.
> 
> Logs:
> WARNING: at drivers/opp/core.c:1640 _opp_table_kref_release+0x150/0x158
> Hardware name: Qualcomm Technologies, Inc. X1E80100 CRD (DT)
> ...
> Call trace:
> _opp_table_kref_release+0x150/0x158
> dev_pm_opp_remove_table+0x100/0x1b4
> devm_pm_opp_of_table_release+0x10/0x1c
> devm_action_release+0x14/0x20
> devres_release_all+0xa4/0x104
> device_unbind_cleanup+0x18/0x60
> device_release_driver_internal+0x1ec/0x228
> driver_detach+0x50/0x98
> bus_remove_driver+0x6c/0xbc
> driver_unregister+0x30/0x60
> platform_driver_unregister+0x14/0x20
> bwmon_driver_exit+0x18/0x524 [icc_bwmon]
> __arm64_sys_delete_module+0x184/0x264
> invoke_syscall+0x48/0x118
> el0_svc_common.constprop.0+0xc8/0xe8
> do_el0_svc+0x20/0x2c
> el0_svc+0x34/0xdc
> el0t_64_sync_handler+0x13c/0x158
> el0t_64_sync+0x190/0x194
> --[ end trace 0000000000000000 ]---
> 
> Fixes: 0276f69f13e2 ("soc: qcom: icc-bwmon: Set default thresholds dynamically")
> Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

