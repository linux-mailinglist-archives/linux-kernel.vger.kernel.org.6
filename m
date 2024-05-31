Return-Path: <linux-kernel+bounces-197340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70B8D6984
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0EBB25C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DD17C7DE;
	Fri, 31 May 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xdt3BDL2"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53B17B51D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182810; cv=none; b=CTGsf3O9IgL2VrzkH+euGt/R71qIpR8T+e7DY6WWC1todsR9ATG2Ko28ja7964UPRlXuPV6Cd++qh0JxBhbARge3F1WG1aWB08+psEXzOzio+gt3pVz+eFNp/A7QhB5mK/INoEhtxYqtPINnP0xgT8gYSZzgT8hTaikmkFHyRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182810; c=relaxed/simple;
	bh=E296/Sootdy1zZQGNWdy4Bn1+fEQuepZc3Fj238Krog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajy2RciU1FS4w2C4GtLKrVyW6ua2DR/K4t61qmhgzPUZLtd/BGqDILLAAoZ7/tUbJ2niWNg2q+BJjGjbLjhfNA/Tl++JjLCIH7DqDvpNxdkOZ3+hyVI9qB1rESrQsZAUuKn2l+3yMrR4eiwoqv1PA17eu6MM1zqtdVLG9Anr6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xdt3BDL2; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ead7e95c91so10565439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717182808; x=1717787608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41fiE54FY+e6bgGGsIbRgTEJBX7DPyrtesC8AIAh9Ug=;
        b=Xdt3BDL22gzsFqcdg/T4UgxHlLb9JGTaMPdlXWcilOXYfJHV59WqcsF02AAh3C6o9L
         KtLSBJ1hz9SsKYBDG4WNPdkfoAXLmUe1WPDU+dEOKSUdPjbww8gm9eFstKSEECVAmXfG
         qPeEz5bcQwzrUzvkcyxU2iK6TRtsYdGjjt2YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182808; x=1717787608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41fiE54FY+e6bgGGsIbRgTEJBX7DPyrtesC8AIAh9Ug=;
        b=iic6LAYZsAzirCo2zeROXtdohNlFQt4qq6vGfnpCqaJuNJJnLps7KDUwEnz2O12iIp
         UlvMhrtRXesFcSha19sD1VVrn+SYWgdvArq5Z7SGuDRpdVmXdoc1CZYkI+uvkliqpeEl
         dgw855y7KVK/a+dQBP8XozzGNKQSlhJXp+v3IGgFor/7vA8QOEKp6MnV9WODKAmk4cWw
         CH/4v61ANmrqGpK40hu3wlJHETBNho6nTdXfKtK2Z3g2R62vkYKmlJ+vWvxU5d/vJ/hs
         LZNtxkGLMBk8T8DGYQh3Wd13MlP3BrnBPLBmemueqQh+uLcG8OtF6lOD/t2Fx0YelBXr
         D9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVG2lGkwuXsF3hC5Nis9v6McubJ9o90Yn3qSYFW7TTG9qnM3IFumsXo90bfKn4pMITnoymD3ZBswv0D+gW+nqqUg4DR4Vw87fZuXVwf
X-Gm-Message-State: AOJu0YzXJFoDlCAxQUPUnMEW8omVIAij+h7IxkF8WMPZpqm1ZZGicZC/
	FjD+wqJ5+vUtrdVrdNqcMLl5QSUzuktgqGwvvrE6yZdfINdSIfnSbsCkqJbsRqE=
X-Google-Smtp-Source: AGHT+IHrKoWGzpR+rMVObi2QP9d4WGkPOovhn8D1ERBu3+IYhrknVsI6Qi0EL7KWAFhRyTDonEBaPg==
X-Received: by 2002:a5d:9b13:0:b0:7e1:7e15:6471 with SMTP id ca18e2360f4ac-7eaffee2c4amr334625439f.1.1717182808038;
        Fri, 31 May 2024 12:13:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48b99b0c8sm626884173.107.2024.05.31.12.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 12:13:27 -0700 (PDT)
Message-ID: <f9091516-37ff-43d1-b515-ae8eb3f80e80@linuxfoundation.org>
Date: Fri, 31 May 2024 13:13:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] list: test: remove unused struct 'klist_test_struct'
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: davidgow@google.com, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240531151801.128792-1-linux@treblig.org>
 <89e07c93-a54d-4cc2-8ee1-664389ffcdd7@collabora.com>
 <Zlod5TMzmXinDu2X@gallifrey>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zlod5TMzmXinDu2X@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 12:58, Dr. David Alan Gilbert wrote:
> * Muhammad Usama Anjum (usama.anjum@collabora.com) wrote:
>> On 5/31/24 8:18 PM, linux@treblig.org wrote:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> 'klist_test_struct' has been unused since the original
>>> commit 57b4f760f94d ("list: test: Test the klist structure").
>> Probably a fixes by tag would be needed here.
> 
> I'm generally avoiding fixes tags in this set of changes, since
>    a) They have no behavioural change at all.
>    b) Downstream and stable kernel people use fixes tags to indicate
>       stuff they should pick up if they have the original, and there's
>       no need for them to do that with this cleanup.
> 
> Dave

+1 on using careful use of Fixes tag only on real fixes for the
reasons mentioned above.

thanks,
-- Shuah


