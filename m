Return-Path: <linux-kernel+bounces-337233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A33984756
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437C71C22B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADCB1A76DD;
	Tue, 24 Sep 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO9ZP1B/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778A1B85D5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186981; cv=none; b=lmZ5E9/OhWKQR6yXvEdMq6w4YjzBZ9qkXAg/HOHftr+zCh7tRwWP4sFhRoAMUzapCCvdIS5HI+fEEKmmrs+PXHL6JA2WztG5j2nap2fZnHJh/H9x+ni6uJjeGR9jYi6BZIDAKXpsDQpt4nTCmUPvYYt0NQl7pl95meHDWUeJyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186981; c=relaxed/simple;
	bh=OBLErykB3NOifdAG6kiHF8mypDg+/GNYUE+gK2oxT6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVc5YDofmueHLdVGKWENo6fH7yMXVdMBWQkUnh9r/AocoIZo04c5IcgplsRRr/WZEC5Mjr3pNW2aIGrj3JVI2FTSmViEgksMn+q1sU/DL8RNzl2/H8tbQsGtbZiws+CIKwcVyBwWl9uxaCi/PolCryVk/JLIOEA9DVnW7Va1ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO9ZP1B/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71afb729f24so624618b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186979; x=1727791779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DWPPsseQZtFXVrMTipU0htzgSzrx3BRYWs4uJMipp8A=;
        b=WO9ZP1B/lDGKzG0N6bcAT1g+biXVPOWaPkhUANTgmlb1+SDbRzsajz3aTB6HAQOFlT
         ANu3lwC6tX5C+RtrBadHTdnZxQrr+TXcynMC0mVrwzyOJWDkROJf2On/xr2VD9+iSo9C
         VXwRTk3rhbTffC8p/b/TFOo/IaW+mkXGgwke24JBzkXO2SIxXVRxkmezYK6BbMl3YFUt
         o3VMz3p+Qetty8m1Q7rYj+YKsZsHuso1GerTOJ0nvCmY1srPoW+NQ6hnIrRQlV5qXskK
         RbBVjOTNNBcJTpw6K4i3Kw3GTtXLYAu/tjK6rqmZtH64pI6AAi/9T4d49vW+fY2HYJZT
         BdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186979; x=1727791779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWPPsseQZtFXVrMTipU0htzgSzrx3BRYWs4uJMipp8A=;
        b=mxzrrzzLxNeUtp30saDk0jGGL8GFfdOyXoq59EfwG+c9wrqlk7X9lJijc5H7TClcU0
         9CjgHBtEzlzXwa2+v8XMz4jMT+9ZHu1H7+Vp96Guc94iNkQUqBXJRmQJKzeh+GATjL82
         6NbcZ80ZC4+QsiUgoWhkS0g5RL56+JXN6/JmYHdV0o5VhGJqm3P9I1UL6vMlL5C7sYxW
         GWNhvUBS6EsKf58ixEHxZT54dZjgOuw3SoD4nyjtSGaD/+9rwA/vJYnGLSpSeijtZMu7
         mRPB6RjwhWk81qIH8XpKoz+aHQqHKiyqUYSBMYZvukZis3ABR/K6h5Uv0D4Hic3sSn9R
         yGIw==
X-Forwarded-Encrypted: i=1; AJvYcCWoLuGGTowNofsGNPEWvDqYKRR38Ydp5EYRdDWahS7Nnb0ribaVk5f5QZFcL6A17qRSWU7c8IbLx2Vaxeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEiXLUZzaHL9H96FTjjIDyFhZuz36fe7k5CC19e3Fl5Ar0SHzt
	AYW8ge+2fhpaC+ycRUeIL7v6b8aZXTGqm3V+vbJ084VKbZeZntBYBcWNIg==
X-Google-Smtp-Source: AGHT+IGF+wfnHvrOK3/zlRD1zZC8yPevZNLcT0wZYNnlg/JsZuxLWplkxeRUKnvuukxbi8U/uV0oDw==
X-Received: by 2002:a05:6a20:c908:b0:1d2:e888:386f with SMTP id adf61e73a8af0-1d30cb4f76cmr21255493637.42.1727186979412;
        Tue, 24 Sep 2024 07:09:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c4e33bsm1224442a12.40.2024.09.24.07.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:09:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2ffaf46e-2ed4-49c1-ba0d-82e69b54773a@roeck-us.net>
Date: Tue, 24 Sep 2024 07:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240923235617.1584056-1-linux@roeck-us.net>
 <CAMuHMdUkMWjzT_vT3E7yLgopPWWP=BS_G8Ui22M_b8sZaCWSxQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdUkMWjzT_vT3E7yLgopPWWP=BS_G8Ui22M_b8sZaCWSxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 00:47, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> Thanks for your patch!
> 
> On Tue, Sep 24, 2024 at 1:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> SPLIT_PTE_PTLOCKS depends on "NR_CPUS >= 4". Unfortunately, that evaluates
>> to true if there is no NR_CPUS configuration option. This results in
>> CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig. This in turn causes the m68k
>> "q800" and "virt" machines to crash in qemu if debugging options are
>> enabled.
>>
>> Making CONFIG_SPLIT_PTE_PTLOCKS dependent on the existence of NR_CPUS
>> does not work since a dependency on the existence of a numeric Kconfig
>> entry always evaluates to false. Example:
>>
>> config HAVE_NO_NR_CPUS
>>         def_bool y
>>         depends on !NR_CPUS
>>
>> After adding this to a Kconfig file, "make defconfig" includes:
>> $ grep NR_CPUS .config
>> CONFIG_NR_CPUS=64
>> CONFIG_HAVE_NO_NR_CPUS=y
>>
>> Define NR_CPUS for m68k instead to solve the problem.
>>
>> Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options")
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> I think it's a bit premature to add David's tag, as v2 is completely
> different from v1.
> 

Ups, sorry, that was an unintentional carryover. Anyway, looks like it
may need v3 anyway.

Guenter


