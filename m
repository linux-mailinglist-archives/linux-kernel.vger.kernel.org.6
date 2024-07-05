Return-Path: <linux-kernel+bounces-242865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FA928E15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DF01F22B51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23517624C;
	Fri,  5 Jul 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJo0o3xA"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD71E497
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210603; cv=none; b=ElChI5/SuhfMBnSSti0gPZ4PU/AQOG9oqW/UpczI69vnl2tOEE3RV89mjq1UWqVZPtUlsa4FyhEkCwWOqQS88MnOq113sXq7fEiz+K3qrZ9+AquAj1AYnvTl8viylXETSZoyx7Ei3vRxQ5faHzjdQPrZnxE6yriY2j+hGCHd5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210603; c=relaxed/simple;
	bh=T0Yezoe/XJwes714mKbKM0egw+ZynvAnNMtDEZXPuzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8ckmGWSO38Vr/LiIlLc4pFSivPRv/Z9dfkHXTDQYWPJsF8hRG0aePC1aiLiCw2wP2dfAcmVUbw89+GTmxFoAcfmkiZTKKoxmJ55dkz61H38F8iWg0MWeaxJFpWXEoqoiqKQWk0ZYtmzw2cRgweJPPAWJoyQeoZznQd+gpb8H0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJo0o3xA; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3745eeedc76so1406255ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720210600; x=1720815400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hICKxoDUywMdQbtGCI28pRH9+4hLvJaqbu+wfwSzwBU=;
        b=RJo0o3xAfO3V80L/4O1LzcmbaqVQffRTJr122T5a/pRCo3AcPOL/4Hafaz7EXskuUV
         4GuzzIM4FoTQo0zOw/IlrN6kq2VLfkuf/1Qn7HYOTXsTywHhfMU2T91wrWPM5xIRcZ1n
         xKCuEuqzq9/X9r6TZJOYYubPdqkyTLRPwdVmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720210600; x=1720815400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hICKxoDUywMdQbtGCI28pRH9+4hLvJaqbu+wfwSzwBU=;
        b=WtgHjcINKBbnRVfzWnFcOd8FMZv0OAb/vrKBhGDsSl0fArr0aOrnNQlQzDB4aTFwiA
         Z2BHG3NkTqh6bFBxeIxYthW9yPefQ5hMycp3+oNq3IAzf0ZG64k68Y4M836+AMlfmXgF
         4+7JQnjwFMCOiV7D6E4p339u94DDDzRUrF1vum7teXcPgbomZupJfh3l64mlVZhX/PuK
         /HFwHkd5AKzfOjRRGW0vClFrOrYgm6wDf9Uu/oQDVgeP4EExU6sIeKUm9wz7cAwTgwkd
         4yh3pMn4YTCtpQ6GXf4usPvkAfnWrMNvHEq5qaKP2r81ll1a2sJzLdSRG88W12d4XPHp
         qZYw==
X-Forwarded-Encrypted: i=1; AJvYcCVm9BXP/n6YaotnD4tQECXKHpXqTGbIYWQ8pUTCVQA0gYlu7Xut1t3G97Dc2iqQEfy2VbG3+KBJnAPDe+zsp0zjyA6ufrokpQf1u2IK
X-Gm-Message-State: AOJu0YxShUA4/+9yrWTgSwlpVeBd6opoF1XRuAU5OSM2BOd4fa+lit33
	5y9AnbvL2bxJYHESqNn7ZRqWcXIIpmKO1H9vT1kb6o5ylRTKccfnbvQM6prQ+aI=
X-Google-Smtp-Source: AGHT+IFxJeifz5EcUyoQ7zGXVAt/YfV1u/9+SuLU0gHe+drTSap9H+MC4G0IQtB9rf9SBDEaRTKPgA==
X-Received: by 2002:a05:6e02:128c:b0:382:56bd:dfb8 with SMTP id e9e14a558f8ab-38398710577mr53428745ab.1.1720210600102;
        Fri, 05 Jul 2024 13:16:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad22cb6b2sm40055505ab.14.2024.07.05.13.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 13:16:39 -0700 (PDT)
Message-ID: <d99a1e3b-1893-4fac-bf05-bcb60ca7f89c@linuxfoundation.org>
Date: Fri, 5 Jul 2024 14:16:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] selftests/vDSO: fix clang build errors, and
 Makefile cleanup
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Lutomirski
 <luto@kernel.org>, Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240705195736.34039-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240705195736.34039-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/24 13:57, John Hubbard wrote:
> Hi Shuah,
> 
> These are for 6.10, as we just discussed.
> 
> Changes since v4:
> 
> 1) Subject line on patch #2/3: s/mm/vDSO/
> 
> 2) Added Muhammad's review tag.
> 

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=fixes
for Linux 6.10

thanks,
-- Shuah

