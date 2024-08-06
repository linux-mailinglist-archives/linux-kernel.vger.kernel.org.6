Return-Path: <linux-kernel+bounces-276765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD394981F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4581C282B12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74E82876;
	Tue,  6 Aug 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fR96ObKM"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B440856
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972008; cv=none; b=lMfoh+6/U8Am/+OLq8LyzO/02Lrf72Cr5MTz6GP1dnzElYLmnCKcSXoqJ/Lv3ytpG0+sNjvilv0BZpYcyxsArBPm4mTFHOiIXFr48bw5AtY7wMk183WvNhBA7K7fvSiTjmKJcp3dn2ZmRPzWksUCz2nXg5TTZ+oLpmD+JrPYeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972008; c=relaxed/simple;
	bh=kEjS0Ayy1UsqDx5AQafkLma4l4Xvn+3UjNDx3CYeC/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnMfThrvMrfwIx1pyIgX7ez3Gzo8Q/psFQpCLpBRnfBRyAw++q2cEc735vvtlKey3tzPp5sB2ujGV/aiSIAp0Azzn45djXyrfV59JvS+KLElnDEhHR4JC4DswhSfNupuWoZECPmf8EaIQLIDwz/Aboq0q0/fgLdmsFUXfHUjRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fR96ObKM; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39b37b63810so760565ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722972006; x=1723576806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbftMZKhzos0fLJ4SvbMIcU0NMKxz9kCCYA+eLZ/ERM=;
        b=fR96ObKMIbYW5r9z8pzmNwLrniYpFYm3RYCChU7yEGGYrSr+nmWm6xPZlWwpb5mCcZ
         9H9u2CZuE1s6yfooKi8cZU7J3cBsbk7jzrhTBKaJwpAyYImmiiMwumzLfL/vwShPxJ5u
         dVW1MK2CL1+B1jxS9ol0ZUf4LOhaGembnxBHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972006; x=1723576806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbftMZKhzos0fLJ4SvbMIcU0NMKxz9kCCYA+eLZ/ERM=;
        b=MHxk//C6Eg+B2fG2mW5zasjJGx7EGTv6rmFU0+/wxFOZv3aX5eMzVXDAJY91rr0YfT
         G/VsG/4uTzz74rZpqyaRgIrxp6Jwdo3HYK4H4wghiNjFdYEbINjK/QVCMGWbXAn60/+6
         TkV7P36m9Y2RL+cOpbLmRmh2dgdDeirltfcIj6Xj4KW+F9ZYZNpa/6f2Sze7zL/c+0BE
         +1xQCGk/sNVC8tZqRHBQKFZl2Li9YK0sTMlUHuMiT7fSYbR+OsXv3QRlktiFvObg79OD
         kzM1mLaU8rzz+D9ducnKXiAFAGw3rlkTNjtZBAtZw3X2JM0KPGEpkfUO8HbjIN4GH6gZ
         efOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKHCGV4W1kT7yepyd4k1vWrBJGBPD2Y8JHJEI+JxoJbLb8cV3OLL9opn0S73mDnDrtiwfUNuii9PJ1wocwOQ7Kk1lRTLum2cYHPdz8
X-Gm-Message-State: AOJu0YzaHNsw+fmjTFxL8rMHhzdKl1kiBCYiUe4sNmwwFTGF2/aVFYvL
	ODTQ0Te8M9U7GU4H9oNI5N5wv1iPwMoa0xztHtxyG0BxYBE3aAfT5752PeaVCpAc9YK64Xw6yf3
	I
X-Google-Smtp-Source: AGHT+IGaAOcdLmXTNycIUx62YClvbDdtWbTFKJdV/405gNx9I+8HDQuqLekfdhRxqYYDfCVemrNFww==
X-Received: by 2002:a5d:8b0a:0:b0:81f:dccd:844e with SMTP id ca18e2360f4ac-81fdccd8609mr771851839f.0.1722972005960;
        Tue, 06 Aug 2024 12:20:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69878b1sm2339577173.2.2024.08.06.12.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 12:20:05 -0700 (PDT)
Message-ID: <9bd07238-5540-4b6b-9532-8e3590cf2b77@linuxfoundation.org>
Date: Tue, 6 Aug 2024 13:20:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-fixes tree
To: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Brendan Higgins <brendanhiggins@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240806091818.7b417ee7@canb.auug.org.au>
 <CABVgOSmpcXOKFVYOm4jgJ7STxhA7o2k5SfQgxn=fzkAZYyW-rg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmpcXOKFVYOm4jgJ7STxhA7o2k5SfQgxn=fzkAZYyW-rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 20:06, David Gow wrote:
> On Tue, 6 Aug 2024 at 07:18, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the kunit-fixes tree, today's linux-next build (powerpc
>> ppc64_defconfig) failed like this:
>>
>> ERROR: modpost: "__start_rodata" [lib/kunit/kunit.ko] undefined!
>> ERROR: modpost: "__end_rodata" [lib/kunit/kunit.ko] undefined!
>>
>> Caused by commit
>>
>>    7d3c33b290b1 ("kunit: Device wrappers should also manage driver name")
>>
> 

David,

Looks like the above patch below is still under review - I can drop
7d3c33b290b1 for now to avoid build failures. Thoughts?

thanks,
-- Shuah




