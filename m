Return-Path: <linux-kernel+bounces-359913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D328799926E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DAA285C44
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB681CEAD2;
	Thu, 10 Oct 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q86ldebj"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0419C567
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588951; cv=none; b=pAP6c1OGfEo5yz5XJixRiHe/00lMa3kRKsEwSVcN1KH/pJEaIDXWPtT8AC2bfMyFLs7N66fqtVtlZPj+oCUE6Ch9wMBP22k/YlL8l7zSSaSh/9v7oOo6dnCm05+9o27RhXC9MhfqLBujRFuflDTIJYODsIvJD+NmAotTeaxuo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588951; c=relaxed/simple;
	bh=PJt84NTBV3zA2YWbvMzz9xgxu9rP/D5hJUr8JrYJh50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkIR55WBo+su8x1hiba4E9XuRWvRR5Q8pWiqatkmi0UPvx9Lxyu2d4V/ZGdZiW0UelBfwqtJKLK/bV8fOhmt003IqskK0Gqigarm3TsZ6t17tiGHrDH+smr6jdaB+OTV3dqwqwE8KF612za+zvny+7EY+KGB6XfjFzwqysjDdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q86ldebj; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8354b8df4c9so41845239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728588947; x=1729193747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJDokxyi+r4GBO9Yss40MqD2aBCNo8jOpjqls79QOlE=;
        b=Q86ldebjtN9De759CTtFp17aX7vh4UndDvJPb0E7B+NniF2f55+WESTn0gfWytpxbd
         JCSouJU9wolxgR/GoV+49FYO4y941phQmcP2ZhxkFU2Kjob3/uqHS7qLNU4ICbU+y5ih
         9Btu/Lcc2+lXoVUYXW90tRnt4x7shXzWivnWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588947; x=1729193747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJDokxyi+r4GBO9Yss40MqD2aBCNo8jOpjqls79QOlE=;
        b=kDVraBnVABchfZsDsAcmr3Z9P0rD8yBo/VWWGBqVPmQljdW709CTJ4Xjl9+AmhmmZg
         pZTxzY6NQMLBcf3cy/ZTCPr0IyRnzrw/bgZOA05qEQgHpe+yPqg/IDMd20Hnw3MoeehI
         7hBKGew/pFzYHMOhGIpTKFJJ20y3Dig8xsv6P8DlBSN1IJXttd9bYalmi274fDxazALy
         yyckHNg0p0cUqVZYEqH6SBxdEdrgxpuymJH4YZJ5SL8YzGWmKpoXGUu0HkQVhYX4P2yz
         jhYXQMfeXScRWaLDGLT+6P1GJCnSSJiGC0WPCNvbVGlIR+PSAEb9C/VexuuptHgDzVmp
         TnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlyyINFAnT6j48iowqxTsoDzUzkjMHZ6TOyewCsbZEz28u7bBbQLdPgYE0RV5qsz5PY38L+vrwDcRV/G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGAGx8+5gJFDvaqKdojgkXNCo7OYj+CleflXHx3uX9oxTOeON
	tR/axH8jiTh7M+zaKg0bPc0ShxjrumYqX4FyZ4RWVbveIXczROLhxotQUzN/aYE=
X-Google-Smtp-Source: AGHT+IFESOaWch7p6IZtRKrxj+S/KmOBRuFIkys5QM17BrsPQ0QuvoGRaPAnO8dVZvY1IJGgLK5cyA==
X-Received: by 2002:a05:6602:6414:b0:82a:a998:ebab with SMTP id ca18e2360f4ac-8379428fa80mr5608439f.11.1728588947141;
        Thu, 10 Oct 2024 12:35:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaeb5afsm358189173.167.2024.10.10.12.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 12:35:46 -0700 (PDT)
Message-ID: <b01158a9-5a7d-41fb-9935-6fd9cfb60a29@linuxfoundation.org>
Date: Thu, 10 Oct 2024 13:35:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2][next] ASoC: rt722-sdca: Remove logically deadcode in
 rt722-sdca.c
To: "Everest K.C." <everestkc@everestkc.com.np>, oder_chiou@realtek.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010175755.5278-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010175755.5278-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 11:57, Everest K.C. wrote:
> As the same condition was checked in inner and outer if statements.
> The code never reaches the inner else statement.
> Fix this by removing the logically dead inner else statement.
> 
> Fixes: 7f5d6036ca00 ("ASoC: rt722-sdca: Add RT722 SDCA driver")
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> Closes: https://lore.kernel.org/all/e44527e8-b7c6-4712-97a6-d54f02ad2dc9@linuxfoundation.org/
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
> V1 -> V2: Added [next] tag
> 

You don't need next tag for this. This patch is in the mainline.

thanks,
-- Shuah


