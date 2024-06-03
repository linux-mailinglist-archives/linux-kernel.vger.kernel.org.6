Return-Path: <linux-kernel+bounces-199273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92FE8D84B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5751F23A36
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7CC12E1DD;
	Mon,  3 Jun 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f60kxw0t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159C1D54B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424237; cv=none; b=g9hOr9ytNlJex1h/xsqxKyj7ipVyla1vdxiBMuiKm460HDWHWE7r2y1X1LPc3wEWkNbv5vC++qYeTfsXByxE+40YKcFcU6s2D4z5D5J/rg1vfozxAZtu2+EXWRBBebrEoGBG+YsGIvxeH1JNK01M4908g9hEdYcuimpjTfYAVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424237; c=relaxed/simple;
	bh=mB42GeWihI/UnySxYDKsPF06FNhZIZVrKClUa6ZXkK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzsdJ3FueR0jhR0261A7bltNLoAaYNxBbcEX/EhPugrO9mzlmltPqKY7rlQJos4LzdT5hDUb6Fmt0Pcf8IzskAa59A315al8AtoSihly9NcSNtdPNaGy6FL/sANrXRaylWUXagsNYXeAVo5oHGVTeFJ2UU/OF2AK1qYKutuST3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f60kxw0t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717424234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLk9HWXXmuijfDLUc7HCk2M98+TmBAchEzBPpKKETig=;
	b=f60kxw0twgK7HfJe8hMvgrKoQu7Ubjbse6TJ9FqJHRKsNPUXir0P2fe6qtByBV0Qxs2Dgw
	GIA2dihdT2s8Et0lNdB/sxCG1utnkQhYXXQFzXuuT2KNRat6cHhb1pTQoyo7goP3HUAqnX
	T1mem2eP3ICmSdKQiDbeo/HVVetBDt8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-9MTR0zIvMFu9AA5lLeyJtw-1; Mon, 03 Jun 2024 10:17:13 -0400
X-MC-Unique: 9MTR0zIvMFu9AA5lLeyJtw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e212ee8008so556617139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 07:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717424232; x=1718029032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLk9HWXXmuijfDLUc7HCk2M98+TmBAchEzBPpKKETig=;
        b=Tjepy4tymo6dbqUbBdjTo81497Gwty9aFFIve6XgQIUzcnSTh09YZyPpGxMn9fZTp4
         bmyssDXyhBrHGwLIhmLy1hM7KXXC0FcFoP4NABCddRZXJCrUIbDuXELOPh4fPzZ7C0uW
         fIrl1eLiigqVMkUeFaf1I8eMDFWObul9fpXfByedmBu7jKqq80lFykfP1GyQIF1gCZaA
         QgYtRv+nlrDQKUDgsjv5Qdy6YS3k0IDrFo3/WF4/jyPH2rJ7gDhcwAk1iTPzKNdQq/gO
         afKu5+OeGJYb5oSL2mxIa5IX3d1rW2RKUS13hkqCLIA+BV+uGlHjBkffGi+EDUw6IUjw
         xn+A==
X-Forwarded-Encrypted: i=1; AJvYcCX6HVX9licaYeOuDp+EXuIDQfJvBi5de/845d6PHQ2uBgBqNsziKqx73R+/Ndohzw8FMO5QP4jQZPsvHYnCwOD5RPmyz/TYfcMuGGcc
X-Gm-Message-State: AOJu0Yw+7XqwSgmoybG2l1mTslJtd4rw0u56udls+LH3L+6X/0eQS8mV
	XTnfAIWWxLvdq9uX/3spZI9AnAbPt/Yoykyv6e0EjjpTb2aCulK6YvvIiUHw/eu7lsHZ5r9bZ9W
	th+B9xqcH+lr2llIiCHYXq8MfeHd8/Lg+tunVzVdbociw4VVPOFogrgKdFT5txA==
X-Received: by 2002:a05:6602:1603:b0:7ea:f970:36d9 with SMTP id ca18e2360f4ac-7eaffeac9aemr1169893239f.12.1717424232576;
        Mon, 03 Jun 2024 07:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSK0JZd22UF2ZfugGWJ6NPGbhYoYtjjYlIjpAxF42ITiFy/yYyDhpybZ0dOX6ZyTHfgp5QxA==
X-Received: by 2002:a05:6602:1603:b0:7ea:f970:36d9 with SMTP id ca18e2360f4ac-7eaffeac9aemr1169887339f.12.1717424231706;
        Mon, 03 Jun 2024 07:17:11 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b5f1291571sm131336173.16.2024.06.03.07.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 07:17:11 -0700 (PDT)
Message-ID: <7e8f8a6c-0f8e-4237-9048-a504c8174363@redhat.com>
Date: Mon, 3 Jun 2024 09:17:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
To: Christian Brauner <brauner@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Howells
 <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
 <20240527-pittoresk-kneipen-652000baed56@brauner>
 <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>
 <20240603-holzschnitt-abwaschen-2f5261637ca8@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240603-holzschnitt-abwaschen-2f5261637ca8@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 8:31 AM, Christian Brauner wrote:
> On Mon, Jun 03, 2024 at 09:24:50AM +0200, Wolfram Sang wrote:
>>
>>>>> Does that fix it for you?
>>>>
>>>> Yes, it does, thank you.
>>>>
>>>> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>
>>> Thanks, applied. Should be fixed by end of the week.
>>
>> It is in -next but not in rc2. rc3 then?
> 
> Yes, it wasn't ready when I sent the fixes for -rc2 as I just put it in
> that day.
> 

See my other reply, are you sure we should make this change? From a
"keep the old behavior" POV maybe so, but this looks to me like a
bug in busybox, passing fstab hint "options" like "auto" as actual mount
options being the root cause of the problem. debugfs isn't uniquely
affected by this behavior.

I'm not dead set against the change, just wanted to point this out.

Thanks,
-Eric


