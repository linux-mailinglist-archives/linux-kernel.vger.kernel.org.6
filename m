Return-Path: <linux-kernel+bounces-168903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CCA8BBF88
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 08:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3201A281E8D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176763CB;
	Sun,  5 May 2024 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8OZwuB+"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C0524F;
	Sun,  5 May 2024 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714892325; cv=none; b=rkxHkvicxZDEAArXkaOgETACGIybqMhZIJ+y628WqpppYaQ09/yhsbGCKp/wEjK66z2LWEw1ugJuayllTlM3wQBJWvwrXr/Un3NWWp2f4SmWYS2Qkjf73TYoKGvPKNcyZDI964zAcj5SFt0dCcfG49S7mrHpIfU2KZZqszBK5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714892325; c=relaxed/simple;
	bh=2PBKlYW1qzVbuyWWgJD7yyagzyu9p+LO9Q6duh0Zt1s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ocpbVx8FBAsLCUrNmxknVzjS0EcnjKyg+7u9qpF3wKlxj7Ky2ZKQkg+bCN5M6L3BD+oPO+u7CABCBG9ecDjWalDLJCn3v7VGFMKQXaNRvT2zEPmkcP+HMnflgm3XH6vfYtoACsRd+glRd5z+6FavfLd8jlNSFtYvwxiTJM9ETC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8OZwuB+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2343ae31a9bso635059fac.1;
        Sat, 04 May 2024 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714892323; x=1715497123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4vpukMfzbAPwm14bol0ui9iQpresRYINtD5OwU6MD8w=;
        b=Q8OZwuB+o+twuVZmal+koXoUGXv5n3sBK6loUtKUQRQmZeVq4mIWGpvJHNWfcc7YoH
         8QUr92ObNtHvZi+AGyxP9MyIc8vFz9S5noFnWmLilOs7FBx454nbXhLsbdEqwpNqRg+R
         b9v3LLF/hQ7PFkXd8Dgqe/d8bGgb4/oH60ijBqSAm4wbbjUWcIwSRwXLgFE7eS9MKDRR
         DXIo7dX8Duw87tx51XK88mrrZDNHDWurUtAoiYIH68NjdjmAgwwx+eSU+FIfwPcwE5bS
         Hy40TKdsuco5WVh67ECiIPeBpFu+E8UP3v+XlZVn5QkdIB1xdzMnbbdgA4tz51NZYqgd
         BsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714892323; x=1715497123;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vpukMfzbAPwm14bol0ui9iQpresRYINtD5OwU6MD8w=;
        b=MexVUVcgP76xnBX96ZqLEv4XqPJZO36sagdvDxhjqntqBEGjmWwTSr1fsfMbnTWIIv
         6SSS/HAjrsR39vSqr9VAL/rejqSzNna+zsxf5aKDvFq0K1z6cl2Zo06cctVtaQMa1QMy
         uOjTLcu2YwaML71NrEbP9inHYPR2FtClqgzlVkAMBu7ZopmaeWX5EsfxZ/KFbfa5WdF+
         DDjzZxLIQfc2MRuX3euAxdp2NdGDJYSv69tAfGGxi9l+DfodvhIYCNvutphA6QOCGisD
         ku4peERRrAQp/n8BCXPTfbAmswFZ1qRvJEH4jho6Bksdn2py0QS59uqcrTSt4M5le+KL
         VGZg==
X-Forwarded-Encrypted: i=1; AJvYcCWew2zJeVk4mGgdkJ7OCoSRkDs299YO4WBNWBzRu93KUyUigfrjxI3+ru5k1Dkgpvvc5Vpbpt4xzuzVG5UasSzzV+bn4Bb1ftRrnlIPfrOUCXrHW61/QBwgo5AaCxm4x0n3AlqlJV4q
X-Gm-Message-State: AOJu0YwKZvVCE0Nbnu1xYkYdczhSpt2YPzC7ap1gDbeiZL+Y42Mm6PNT
	4dgOgeGB8Zh30bBex8j2gAqr9hthwEq4GFpsovE1VLWZD6aIFWDOSLL1v6MI
X-Google-Smtp-Source: AGHT+IGxsol5QytOUZjrb7i4kzhX0EYbteDvqcJ1KMaH4YM2PAb0vAHAIZVrR1XXrGxKuvnKhD+JZQ==
X-Received: by 2002:a05:6870:5387:b0:23b:8a84:2e66 with SMTP id h7-20020a056870538700b0023b8a842e66mr8989034oan.15.1714892323379;
        Sat, 04 May 2024 23:58:43 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:54ee:ba66:1638:6278? ([2402:e280:214c:86:54ee:ba66:1638:6278])
        by smtp.gmail.com with ESMTPSA id nw10-20020a17090b254a00b002b0e8d4c426sm7847133pjb.11.2024.05.04.23.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 23:58:43 -0700 (PDT)
Message-ID: <5c699755-0317-4485-af69-0a4256dce085@gmail.com>
Date: Sun, 5 May 2024 12:28:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: mux: replace of_node_put() with __free
 [linux-next]
From: R Sundar <prosunofficial@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
 neil.armstrong@linaro.org, christophe.jaillet@wanadoo.fr,
 u.kleine-koenig@pengutronix.de, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
References: <20240410175804.5195-1-prosunofficial@gmail.com>
 <2024050443-coerce-bonus-977a@gregkh>
 <9574a4a1-a7b8-4f35-88b0-754c4396b02e@gmail.com>
Content-Language: en-US
In-Reply-To: <9574a4a1-a7b8-4f35-88b0-754c4396b02e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/05/24 10:50, R Sundar wrote:
> On 04/05/24 21:48, Greg KH wrote:
>> On Wed, Apr 10, 2024 at 11:28:04PM +0530, R SUNDAR wrote:
>>> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
>>
>> Please fix your name up for the next version.
> 
> Hi,
> 
> This version of patch is sent  before comments provided for naming in 
> patch v1.
> 
> The name and nitpick was fixed after suggestion provided in patch v1.
> 
> https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/
> 
> 
> Link for patch after fixing name and nitpick:
> 
> https://lore.kernel.org/all/20240426164705.2717-1-prosunofficial@gmail.com/
> 
> 
> 
> Thanks,
> Sundar

Little more explanation on previous mail:

Nitpick mentioned above , referring to is  , suggestion to rewrite a 
"nit in code" related to indentation in common path.

https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/


So along with fixing name , I fixed that indentations also as suggested.

https://lore.kernel.org/all/20240426164705.2717-1-prosunofficial@gmail.com/

Thanks,
Sundar



