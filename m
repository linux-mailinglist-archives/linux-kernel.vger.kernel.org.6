Return-Path: <linux-kernel+bounces-254785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35844933790
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24A4281F91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31418641;
	Wed, 17 Jul 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEIk/CNE"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F418C3D;
	Wed, 17 Jul 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199841; cv=none; b=B/cK5OMLjqHXeS1ugMhb+1k0uE2U3x5cusfCBn8qyhxIZcfBpRCYOE1kI8+BwiUiZ9ffXbSejocVnCoIscAUAgsGPRQ7LKha8mwkDYhtclYkIalA4P1Z1YptAntRhWAuRgB6mAEVo+jbEt/60QM4W8KnOWTD7FUCjSQU9z3MbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199841; c=relaxed/simple;
	bh=9+u7VhpS0v0Ayu1qi7neh7YFfB4o2VEa2gNq7VOU6kM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AwHFUdcUejzLcKCWBo8/TuO3q/8RzSIkbdfrgbRE+OD1B/uRhXVne5tEWS1sUOXfV5ny+imfGL9/Z7mZ3kMYiDBtvrJ1XacqGCRcjQzICRebVmGd9yZSB0KNzq55FJGtGfZ+7/VIwPJltspnQS8I4pPSyxCSEV1VaE6TPG4vcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEIk/CNE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso5570314b3a.3;
        Wed, 17 Jul 2024 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721199839; x=1721804639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EBQVSX8cISMGMb/XotZL4r577Dyw3ahWCKqo1wIoGyA=;
        b=JEIk/CNEDWdgqhUz0ZsYhuJ3q/MDz5SwUjjtofpa062hF/s+UJAK8VVuqMn3NTGHMz
         VygGRtfGQT2+jTsiykSTsnMsuJfP8fR3C5hdK7zFCnI18i5wVu+gpgiNmRu89pcffCLP
         kByfgW3lTvhmZeZLpXnPKiOF4tWGughz91hlasQ/ciNAQRCcJ2ZsBgDGWLPfMMp688Cl
         ukFvbBd/DBuK6BRMLg8ZT+T3mYQdL1qRskTwNdvxI8or78vb68GMpcK0OLtf2ww7vzoy
         6Bi5d1qgSO5s4KRFZag6JnZ7FfNgLKT+Dy4QotJ6BmVfdWf+GaRkyiF0kw7sQJg+nHVl
         Ej+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721199839; x=1721804639;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBQVSX8cISMGMb/XotZL4r577Dyw3ahWCKqo1wIoGyA=;
        b=HG8N2Ycs7IGW6rtQOG01sIf6SX4ES/dW+Eyg7pqcdJxG1mBBMBzrHMU9Z3qQ9Tv8Bt
         eWLce8fUEvpZNu11REUk0J0Q3pZaWMrNxGeTE4+BLbc5Vt+UCJHYjoDvZBTYUPCjShgn
         31elxBgAx1nXFse9E/7SZodjV04yBEGvONlcxKk4hDKLCXCMQYtRvUOTy6on26hjTYzT
         9Y2IcdarrlJo2LTxMjNlnFTYjKEre09VtHcTIKqTYuqRbpCCruqIFvc5MtfOd9IM8+QL
         0nF/6m/LzL+DSBSx02qmU/9an9ISXpSUymzVjYg63ILsPRqnPuxzq7/d2HjxHGNAlpAG
         +tpw==
X-Forwarded-Encrypted: i=1; AJvYcCX5ci6SIVTj0S34CPJle0MtabZCEwO8r2SlHSQUtADzdlqqLkIjxZUFZTXAFm07jbBuvRsNsXF9E63XNro7ZcmP9mEe9W4C997j6+ckJXc+AtAPPcxYJaL0qZ8Wa7ugruvHsqPOq00=
X-Gm-Message-State: AOJu0Yw8NKUWY3tVdu86FTb3laFqhXFuIVcRwDyKS9WfKrV21pu7gWVm
	dT+410sPn7FNC4kINlUA+ZBAykOd60nU3csd6kCqIGRcTr+U6Swn
X-Google-Smtp-Source: AGHT+IHjymBQBKqbE9v0z3JpgTA3UbRYXozd9N7g2aRJOa7OB/sK87AzoilQ9r/Nxvkd/59q5soL1Q==
X-Received: by 2002:a05:6a00:23c1:b0:706:5d85:61a5 with SMTP id d2e1a72fcca58-70ce4f9003amr894285b3a.8.1721199838965;
        Wed, 17 Jul 2024 00:03:58 -0700 (PDT)
Received: from [198.18.0.1] ([2401:d9c0:2902::c2eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7da19sm7437615b3a.133.2024.07.17.00.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 00:03:58 -0700 (PDT)
From: Cryolitia PukNgae <cryolitia@gmail.com>
X-Google-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Message-ID: <8e5798c5-d539-4d4a-9d6c-9bb3ba69bb41@gmail.com>
Date: Wed, 17 Jul 2024 15:03:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add GPD devices sensor driver
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
References: <20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com>
 <20240717-gpd_fan-v2-1-f7b7e6b9f21b@gmail.com>
 <deca2345-0961-4d3a-9ab4-8d11c7d240f2@roeck-us.net>
Content-Language: en-US
In-Reply-To: <deca2345-0961-4d3a-9ab4-8d11c7d240f2@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/7/17 02:04, Guenter Roeck wrote:
>> +            pr_warn("GPD Fan Driver do have the quirk for your 
>> device, but it's not tested. Please tested carefully by model 
>> parameter gpd_fan_model=%s and report.\n",
>> +                match->model_name);
>> +            match = NULL;
>> +        }
>> +    }
>> +
>> +    if (IS_ERR_OR_NULL(match)) {
>
> match is never an ERR_PTR.
Sincerely thank you for your guidance, v3 has been sent: 
https://lore.kernel.org/r/20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com

