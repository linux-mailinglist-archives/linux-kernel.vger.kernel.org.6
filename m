Return-Path: <linux-kernel+bounces-288796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48EE953ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19C02846D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80C1A288;
	Fri, 16 Aug 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkLW5WhT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17596BA27
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771349; cv=none; b=rbeVqoeQuN/w2+1XkjhV2UucUFGkSUJpItsWnwrPy65Il69kN9Gtj0/LstkMm9iqipmRQ9zma1X/N5eY8XGfgqVMbIYRuQm6po5RtyjuHyleoVBIUbbrFzi6jXl0Tl7DD2Npz6h3qI7L+H+dzMTlqhPS7z5Mn7/ms+EQnEdcqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771349; c=relaxed/simple;
	bh=8SoY/RcZL5ysEBphgPDWAnEB0sIKwXTAtWX4HJeM9YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRwimBIbflY0YaacEY8qWWeAvZjRW5LL/+GLmpj4TgRVRcuzNvBSJjWGXcWbss9We6C8nvtKkcJUQhT+O0syRwOO/orUbvYIOeT7zOmxugvIXYYUvLngGysooULT6Y+pbefGUB4X0VIhgxWL/+NF7JAnmU4UFUtbRVXM04aB2Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkLW5WhT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3aced81ebso1092611fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723771346; x=1724376146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DI5LZsgOl8aoOKJy/uiScPnu9gA+ziq8FjRrJurEzmo=;
        b=nkLW5WhToNoLaO1iGQ2XkIEYpKFeBj2LCwjRowJKSLTq2HVIqsjtKBCRiEQCDF+H9g
         pakMXIatoeaGlyaJ4I1gm0xhkWLu70+O4yjP3ErfskTZM+4iWLyO7DdpdtwGA4R9tQO5
         E0GysTJ/93xf3eCTiIB6Oo7yg5i+9XslOki9GRv5bnBd+mq8y0IueHmCidieXAq5y/Xh
         032EP9T5JdpJpccBGDNbNZPNyL8hpSyHuDv4KpDTer3F7U/Xk6h+j5/gjnKoKt8EsWnU
         kYNFmWPbxsrUrSbU+49CZ4dkuPOq6feKQ5q5U6LV+nd3YB1/8+aQfmHlZbN3XJr/tmrc
         W4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723771346; x=1724376146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DI5LZsgOl8aoOKJy/uiScPnu9gA+ziq8FjRrJurEzmo=;
        b=N9PgDS7hEfnYq8MMVjFzxlfPMgIZqhnwahKfwBGQuDJPCWAa3dbUbszVKCEnsEagTm
         jVmmt5C/+HZJ3SYarmVf6HWQb3obY4RzxYd/T72t4Uh2I/v2eXhPwO5c/pAOfmf44q7a
         dFbFgMi8fTebzvUfX/VmS0hkPhDTs/NJUsDZpbwfa+pGUxHgiIBn+sbVZT6hQl6r8K9y
         07fSL7bJ31TMq/DwYc8BcaggPC6Uoja/yrno77yhALtGIb9sTsO0eUk1dICoUEZVAroU
         uFYgR1ukuJU5yqu+UvPVcN/FirRcOmnVBTs3It/iTrey+cIQI4jPIuoWwGLhHBd+0MN3
         MjLg==
X-Forwarded-Encrypted: i=1; AJvYcCXIqTpVY915164PUz0bnbu7qL3u9BfrzMmbZJK9priFv+sertIBwy1cLSKLAlcstDnimp8+YAd3Qt7WRog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQmqxDlP5LdxvlE7ikFb3XwtikPef3QmksW00yriBlIdPRu5l
	j0yQmlxcuF4utos+pJiP2llevLVqsdi4zF4tGnQkLw1BH6o6srcS
X-Google-Smtp-Source: AGHT+IEhcf6HuGbBoQ5gcZ4LtFttdt9jlXEbr+4AsbcDJQ1pi3IgVmWwgOsfgnNH+6dYTWILhQVlNg==
X-Received: by 2002:a05:651c:2211:b0:2f0:1dfb:9b64 with SMTP id 38308e7fff4ca-2f3be60b118mr4640141fa.7.1723771345553;
        Thu, 15 Aug 2024 18:22:25 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:6f87:1ca5:9107:75? ([2a01:4b00:d20e:7300:6f87:1ca5:9107:75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5bfsm63699085e9.46.2024.08.15.18.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 18:22:25 -0700 (PDT)
Message-ID: <64ab3938-9c0a-483e-9094-64baa1524d4a@gmail.com>
Date: Fri, 16 Aug 2024 02:22:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kees@kernel.org, davidgow@google.com, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, erhard_f@mailbox.org
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
 <20240815160148.be83228a7804c6389393429a@linux-foundation.org>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240815160148.be83228a7804c6389393429a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 00:01, Andrew Morton wrote:
> On Thu, 15 Aug 2024 01:04:31 +0100 Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
> 
>> The 'device_name' array doesn't exist out of the
>> 'overflow_allocation_test' function scope. However, it is being used as
>> a driver name when calling 'kunit_driver_create' from
>> 'kunit_device_register'. It produces the kernel panic with KASAN
>> enabled.
>>
>> Since this variable is used in one place only, remove it and pass the
>> device name into kunit_device_register directly as an ascii string.
> 
> Fixes: ca90800a91ba ("test_overflow: Add memory allocation overflow tests")
> Cc: <stable@vger.kernel.org>
> 
> yes?
> 

Ah, yes, sorry, I should've specified the fixes tag in the patch :(

> 
> I'll grab it now, but perhaps Kees will handle this.
> 

Thanks!

-- 
Kind regards,
Ivan Orlov

