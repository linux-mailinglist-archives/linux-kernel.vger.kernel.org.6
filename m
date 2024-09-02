Return-Path: <linux-kernel+bounces-311729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09DE968CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9551228216F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E7A1C62A0;
	Mon,  2 Sep 2024 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2Ew/16f"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A518028
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298649; cv=none; b=f/PN+Z0bL2Q9CPB7B91D1jq93XKCh0i546tGAp82iMxvgfKqR34LiI9wKhhaybtE1U0SlijA/5ZtzBkHeqiY/47N6Bl9ZjXLykeu6Y5dSutV6varxw25vR1DWRMiJvL2vUT5q5rET7813YVNBAjknG66iQqvEU8SOZfCG9ZE+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298649; c=relaxed/simple;
	bh=R8ofBeXTUxkXx1pjhLBpfeL7s4Dr/Qkwx/twKDs9v7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJ5KKkxzIxAalGCaeMmVvJFtKafSzjL9z8nJ3W0Z8eANKiyVdztFUkI8cxhDpmu47MCDqHU0vrvA3xCXkGDJWI4AuESnBOXi8F52kGCCQaiiwKr6XfIXhvyvYHj2hSkoXM3O3f/hYMULso5FjcFOsDyo284YiZxSRh2ztWG4F2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2Ew/16f; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-534366c1aa2so4611198e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725298645; x=1725903445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibmpJbas6vW0Ls/BRv2OtSqexGSYnkIyXeM8JWd5d0k=;
        b=F2Ew/16fa/MyBaioLGubZ7y2J7OBbo58ZbpBEXp/rag5DBd2aMTJgOzSS12zDHt/Bw
         vZiaGE8KLNZcIBO8ej7k+twvK5/lzafW2Q6zzH1DbiEEBnR2D4wQ+8yxUPYQ9XSu8Dt5
         cjsD+JvJFgqIa4vyNAFlk7DuHHaNFZiSZc2rSpP+mNhl0pLBYOGzowQY0BwSWorQNyh1
         1W7J1vgVLpGJ7k4fSjwwBXv0C4nystlGZaTKPYe0x1KUPZIHAS8BiW3rh4DBiO1B9rXW
         YYPxn3z4XVAW+BX60Op3bj8pI9cqcYX3CNZzH6uxEKPxJg94DYpBSFSHfcZjk7YToQVu
         EcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298645; x=1725903445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibmpJbas6vW0Ls/BRv2OtSqexGSYnkIyXeM8JWd5d0k=;
        b=SoHBRBT9c2KAomWXurWN0kUW6/SUpKcEzNK2r4lB7m+9x3GuiVp+eLE1I0YndKb8UL
         bfo7V7fwRIi86Jd9QUXoAUGMvNLLsUL6e4pSO2Bj6wnTLREJrdMu2oZ2BOFNsGlmTxQG
         Napd7mVJjttiL/8vwuOprq+0cQBXvuaN9Ax9/xZc4N49j+68UXFz9pGyhoOfY3XAsd0s
         KJAixpb9XZL32o/3OEIWRqEcm9P9j6wOBLGAC4VjT6TO12j54txmDOZJoKwGv6EoQfHw
         7wq7y8AavGJu1juuqXePSdexHJ1jcKpgZxZmRBqtDrarouNtt4CIcEG+zsyua9wVNDsl
         06Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVGquaL4uZoDhkkHtIXxAZwyU4oFfqDq7poNoAU81v3NJUs5gmI6kaDKLtt1CYfEdxuluPQqTBLOAkH0MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2YNo5y8JXhZkeiVKm7GkRcZkNvHoAWK5DnF7SuYteH6PjzcN4
	OWUTIawaLmmhxXMrUFk3EsuPtckhmK9I499SlaBIUjZ3pX/tjvD+P/Ot1Q==
X-Google-Smtp-Source: AGHT+IHAJ83XUAO0vx3AzvPzn9X3Z1pPwBgDfvvtixBuJpPeTVS7Wiey96LreMv45WtptTzA3a+inQ==
X-Received: by 2002:ac2:4c4b:0:b0:52c:caa6:13b4 with SMTP id 2adb3069b0e04-53546af5056mr7946363e87.3.1725298644196;
        Mon, 02 Sep 2024 10:37:24 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3dbdsm583280266b.131.2024.09.02.10.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 10:37:23 -0700 (PDT)
Message-ID: <1a7aa388-0917-46bc-8c3d-b6219d472070@gmail.com>
Date: Mon, 2 Sep 2024 19:37:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] staging: rtl8192e: remove RF90_PATH_{C,D}
To: Michael Straube <straube.linux@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240831100809.29173-1-straube.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240831100809.29173-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/24 12:08, Michael Straube wrote:
> This series removes the unsed RF90_PATH_C and RF90_PATH_D from the
> enum rf90_radio_path and adjusts the size of arrays that are indexed
> by values from rf90_radio_path.
> 
> Compile-tested only.
> 
> Michael Straube (5):
>    staging: rtl8192e: remove RF90_PATH_{C,D} from enum rf90_radio_path
>    staging: rtl8192e: adjust size of rx_pwr for new RF90_PATH_MAX
>    staging: rtl8192e: adjust size of trsw_gain_X for new RF90_PATH_MAX
>    staging: rtl8192e: adjust size of brfpath_rxenable for new
>      RF90_PATH_MAX
>    staging: rtl8192e: adjust size of RxMIMOSignalStrength
> 
>   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 3 ++-
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 2 +-
>   drivers/staging/rtl8192e/rtllib.h              | 2 +-
>   5 files changed, 5 insertions(+), 6 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

