Return-Path: <linux-kernel+bounces-269505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E994339A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FB51C21F19
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8421BC090;
	Wed, 31 Jul 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdDvKsmp"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5B1BBBE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440709; cv=none; b=XPNzEP2WG2Fan6z7grDyeuFsQYIdf+ZTEGgy185fcVqh7sZOVdAAj5juue4CTGkWuezepU7/67KD67Wizx/MVhm8V92B2l68NUlofxHExyOMwQY8PS83D+1dFJS5Iz10PJkzVLznClN/bJTl/wK2202B2+FKtPkG4BUotpDIic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440709; c=relaxed/simple;
	bh=jdlkU9dN3MFSfEo6JSYM0jZc5DGdgAnhTeDyUES4v6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBfdHWv3W7ANuqlwR0oaEdmAbi4pGX6V4LVhK/tSwgWRTrYdG0QLTlX1Y/Bkk5ocSvXYxRisSkD+IJv23uKsNwzRX4st9YIWZzbxoL1WMhjaWopvDjwrxE/+/7lvKaG6pIbllr4zfRp9EqCKPn4gXJER6JxylI2CcrzgrutfxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdDvKsmp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso4823592b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722440707; x=1723045507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PRqaWcy2vfI/R788LAtBq22CGKcit9S6EhlviLOYTNg=;
        b=FdDvKsmpviqZmvltV0KAfmfgZFTBO5VCiKxAw+joQoMjEYRYGRud78aIe02sQG3nSE
         OwfDzdnNOco3UOfG/ZSiTNLx4vo6ftbbylGk/WKi8OU+zLoWeufD+b2Xfy9vbcpvqVYG
         qNODi21c31gx8Vu+I7OwgxBBFlijVOvoe87xk7D6+KtNy2RVajPnoJmwKpKaJwTQbpHo
         JmK5OXi+JdC8Emyz2IYCa49DwEDmm0+FFtWn/dbWT7mBaF2JgzhK7HYC+qGDH8K1PcJo
         7ZplHnV5COUHZqBMA7yKrS0Lix/TVHKdLCzfTldS+8JXgj8Qbrcdn+6hFnBuVs8FYDtG
         F6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440707; x=1723045507;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRqaWcy2vfI/R788LAtBq22CGKcit9S6EhlviLOYTNg=;
        b=cXU+HAXeLeUj7iyEBWE9fgwsKQaH/nQfxRedObsqbYfnQX2RusWs1ZkNZrtHFFUr9N
         3cnO4T5cNlSNUpyxmXzPKC//nxSQv/2gyGjs00ZW5GNgJWN7VQrBq+fnHVESKdcDrkr0
         MEPbx8E+DhCqYVAk/xYGu/cSvdJ25Y8wYMHDF3dZmNWSKBGji7+sd8En6XValLSyawDa
         cyQ9vdL4NIqx4r0cNUxeFxV0aPkLojBdrKrZi/7e30Rij1XRYzILP79fx3LkkNpCPyyP
         3AWMJpSg/7puGOeLWWV12zHfEk5Ow/fHc4XCJoqTXreeYQFdRr4KgnjVU7nHwrYIVvqe
         FPvQ==
X-Gm-Message-State: AOJu0YzJm32TZVZmCyK+YK0SK4crcXeaistSn5OYEFZ/8AaywpzQtqY8
	VO3dyE6rKg0BYfMsYCfftHZxHYUjGo9/z6kfTf9J5JBBy+M5Ej1+
X-Google-Smtp-Source: AGHT+IFQHgrar6mSr4do+g+zqkAqZam+VAd49kE6vwLmsOTFWyqpKhuz5KtJElTGV9IBSC3JKxUUaA==
X-Received: by 2002:a05:6a20:c781:b0:1c4:8650:d6db with SMTP id adf61e73a8af0-1c4a14d9a44mr12209420637.40.1722440706611;
        Wed, 31 Jul 2024 08:45:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8745e6sm10118845b3a.158.2024.07.31.08.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 08:45:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a4e61258-6c70-4b7d-9f6e-08eec2f3f545@roeck-us.net>
Date: Wed, 31 Jul 2024 08:45:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 12:23, Linus Torvalds wrote:
> On Mon, 29 Jul 2024 at 08:29, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> In summary, quite impressive in a negative sense.
> 
> Grr. I think a lot of the build failures end up being due to commit
> 466e4d801cd4 ("task_work: Add TWA_NMI_CURRENT as an additional notify
> mode") depending on IRQ_WORK, and that not existing everywhere.
> 
> I pushed out a tentative fix as commit cec6937dd1aa ("task_work: make
> TWA_NMI_CURRENT handling conditional on IRQ_WORK"). I haven't set up a
> build environment for those tiny targets, but it looked fairly
> straightforward.
> 
> I think that explains at least most of the 'tinyconfig' build failures.
> 

All "tinyconfig" build tests pass with v6.11-rc1-43-g94ede2a3e913,
so that problem has been fixed.

Thanks,
Guenter


