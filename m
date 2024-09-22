Return-Path: <linux-kernel+bounces-335240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EB797E2F8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5191B2147E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C34CB2B;
	Sun, 22 Sep 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azhFHtC1"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81C41C6D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031674; cv=none; b=DDUl7zRXpDA3YDLJCTPF+0npKQgLC2VnF7rpduvoISvHmBY/yFdgHf85CxvnbnzZUTpeRlf+VBfPTnTDQekCQ55/DXAuVvNd0XeiIG37KAEqdXmc+uwb4GjFuycgD55HudQK3qCIfVuhVRencmu2e4U4Cxe73KUoChQrKzuNrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031674; c=relaxed/simple;
	bh=paPBfgSs6GuYPSc4Qzbu42wEtwC/+ZYFVB/5muVtDf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3L4iBmxx/oHVbPJXTxnUBnQvS+WNXomY8AepCBYZWD0+RI6f6PG8vjWv3opgdho05MBsSWam8uFuNNa+yor3F3ZFUFvTl3mObmtK16xawWSW7QXA7vJ5TKeb834cLi+rcLf2g+3yhKmHVth5fG5mUVaJZ2at4Vto76g2O2BIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azhFHtC1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374bd0da617so2529784f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727031671; x=1727636471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWL/elEPJZ3GI584WAVmwXjrAOEJIOMue+bKTI1OMG4=;
        b=azhFHtC1czk4odv3WPw0YA5FUo9nxnr44grYFAzMRdTO+DzXHh7mmuz8wTYOpps7iY
         rS1RfIKIwrZ0aNy0vfi16CEA2ms55ScGSybR71sDS9rfHxbCbfue361UglHVORTqG9lS
         Zm4RR3U5IeQ1F/cNzzT9HkJIQK5tFdlaCzLHv/VCPMU04Deupt0kqH876STZEJTDkApC
         9zv6AMGwBK/EWAYcCCZ1tA5K3Z+eH/jjVxy17Fi44hp3ZDkKRwiRwMG00kvAlomu+U6m
         GHpGxLxLdTKKO6/y9N3RYN0yPbZkSLte/kRqt/G6YmxLFPD7tsFLxE4QxD/OsSltHaH3
         xZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727031671; x=1727636471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWL/elEPJZ3GI584WAVmwXjrAOEJIOMue+bKTI1OMG4=;
        b=VRsENkbLE9+/m049eQt49OrYrG51auKMmyiR2X4x4PXLePLv+txPBN/RsjBYIdD6jF
         wu1Ed9UuxVaItN4Kvvva8E3ktLdBFnAsUDJRAJDNi6OVWMWHaRlngIO6DPRoqsYVZBnH
         HALDKDfbS+nPGo1tgNzZ0+jLVgU5LeQlxV3e12Rxxl+t7pcORYg5CP2Gi1cHv5dXGr7j
         O6jQ0UDrWTlZy9eZ31jNTUAzGb4LIDFsI+EhpOI9oI9lCGFPbSzJugXnMRzOm6/dO8hy
         l3rmEnZHHp2bK2EuwiECQTLLrc5dOr42Aj3ESRZ+hzLqBLl1LYyT+YiESLXyDJmAajza
         MYYA==
X-Forwarded-Encrypted: i=1; AJvYcCUjM2b0ADfdgWDWDk+m9lg9s5tjDBNIreSOUrqnaC2yIaD8wNpvLb2XzV3zwDAL8/oJGP3gX1Xv1TrnrzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9w2yjd7Fz325TPz+7AkYGUp5C5i4HKQG2H71WLE9+I1KOj5L
	SUaWrXgWuAABRrjS8+p+JGtPMJNMAtBsYYB02Jyr8IeAQU1Aa9Zk
X-Google-Smtp-Source: AGHT+IEqTLc8M1Ob/SxijoPPwNWo/9aE30s0TjvU1Y4Hfk1ytw8qZIyfLWL8wLEoZOcpiorcS0EMlg==
X-Received: by 2002:a5d:6a8c:0:b0:368:68d3:32b3 with SMTP id ffacd0b85a97d-37a422c5dafmr5344043f8f.26.1727031670478;
        Sun, 22 Sep 2024 12:01:10 -0700 (PDT)
Received: from [10.188.212.131] (cust-west-par-46-193-35-178.cust.wifirst.net. [46.193.35.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afd836fsm81015195e9.30.2024.09.22.12.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 12:01:10 -0700 (PDT)
Message-ID: <9bb46e16-eb37-4d76-a917-e0f1e738fd04@gmail.com>
Date: Sun, 22 Sep 2024 21:01:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] staging: rtl8192e: Use MSR_LINK_* macros
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org,
 tdavies@darkphysics.net, dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240921122113.30009-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240921122113.30009-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/24 2:22 PM, Dominik Karol Piątkowski wrote:
> There were two seemingly not used macros defined in r8192E_hw.h:
> MSR_LINK_ADHOC and MSR_LINK_MASTER.
> 
> There is one function explicitly updating MSR (Media Status Register):
> _rtl92e_update_msr - only MSR_LINK_MASK and MSR_LINK_MANAGED are used
> there. However, in rtl92e_set_reg, inside HW_VAR_MEDIA_STATUS section,
> MSR is also updated - covering more than MSR_LINK_MANAGED case.
> 
> This series makes use of appropriate MSR_LINK_* macros in rtl92e_set_reg
> and removes duplicated MSR_* macros. While at it, fix camel case variable
> in rtl92e_set_reg function.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> 
> Dominik Karol Piątkowski (2):
>    staging: rtl8192e: Use MSR_LINK_* macros
>    staging: rtl8192e: r8192E_dev.c: Rename btMsr variable
> 
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 14 +++++++-------
>   drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  |  6 +-----
>   2 files changed, 8 insertions(+), 12 deletions(-)
> 

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

