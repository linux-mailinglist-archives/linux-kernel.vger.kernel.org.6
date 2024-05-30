Return-Path: <linux-kernel+bounces-195676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D838D5028
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9141C210CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE902F873;
	Thu, 30 May 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8idBfHv"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129A2E859;
	Thu, 30 May 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087869; cv=none; b=atEk78fQyIMIeUnNqSFGp8PS9zraAq+yytHi+x7jPXEUkC03cwAVfO89zSMAXdFTirkhMnmN9xuNai3d/KexHNZCuT1ywihAvXoEJyVAeplMMKA7CiQseDhGB0cPpE324GOCMroAAS4f7jdsrrpsk2V8wBbvpBhrk+F2VHlYe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087869; c=relaxed/simple;
	bh=Cqa3IcNO1G7aG2ZtMHv+vFOnMk+bocKk1NucDnJXoBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiPz3RezlIYytMHEqAnemEK0l0dBLPdIK9aHxtF7xjvDPhSCJH8e7y+CkMBcP+anaoR53ANy9fMN+jH69c7QVi2JzzgYU1ZZAg1Mlt2RVP2yfNRisxb4NOLqvVt8Eu48HV6xhlV2v5VjIbh+C9RcMFBtXEPGULwKYdFU5Zm2IYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8idBfHv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bda9105902so154391a91.0;
        Thu, 30 May 2024 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717087868; x=1717692668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=O0YornlgzDiHU0b1iyt2cYQQUi/emeKM3MOtCSfqTII=;
        b=S8idBfHviN1GDc0Tq9ZFNBLjVUQaq4WlnG8wscZqG2L0cGezFVpoaWawRayvNEY8ww
         fXd9NxXCwfg0hE1r42U/XEHKyfthkqQcqhL6Y63pIZWrbu7ZH/c7q20tXJUMesInaiZc
         d9DChY8Tz4hcvtZpxnHTGqfOdATicRrRitMAL3tLyusamHivokQB92SZLBn0NlrtI1GW
         azy3SS+b0rD6tsU73W3q5ectx29H2IWXwlvdk+HoIvRKWvGOXDhIi9L9vbuOuLtnb7Lb
         CjIOJSKTenLLYPpaHYBRKk92nr+O5zhnGQwFz0nlvep27wpWUa2HDjxDKq+GPyQ8YZys
         Yikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087868; x=1717692668;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0YornlgzDiHU0b1iyt2cYQQUi/emeKM3MOtCSfqTII=;
        b=c4LMj+7PPKDmfauROfWcD7O+SoeRerZG/+pJbZT9UBFZwp6MWwzqSXHU0OMZC+w084
         nt2X6yxvNqGj4ER3AiO7nlZkK9hQcVfADw/D0zho3NL7PauF9wSkKoqIJYyErgA8YcLR
         VSVYEzbDilB9vHN+8gziDb26VXmZ0aV6PAVT4+HVjwq1eXXFgrAdI7S4y2pW0FBZeBFd
         z5GmzBKuDHxF4dMvCFZ7/YYxh7AcOo5MAQH6qRRq9ToWXTbbZYgUnI/swcvUiCYw3CVG
         sTRNnWN5bvtxnR29WUxd+C0JctyMhtm5XokqVWoanY6AcI85tE1Bv06whdgq4t0pdaXd
         kvIg==
X-Forwarded-Encrypted: i=1; AJvYcCWnEHq39E6C/YtpjD6gj0pWLESEE0YDUm123CXhBg7U5bnQGdKiwUv4zi0ZCZp0+VOsiTcjlQX59swWad7NmYRVblxEYfdYRqoiO0/XFtLf3Hu9ivZuHEhQsuIVASkoRA5ck4C7HgQkhmsVvWDtkL6jYqmJSh6ZJW9mHaKIzgjwApe5eM6s
X-Gm-Message-State: AOJu0YxMHm8bdE2MHCtiNhcvWxqPookVNxKSn0kNY6UrAd6fmKUkyzFF
	qugBeyn8uEc3fQ/DsChv/ELuBg1mFcng7Oqssep/lPRtOQajhtwjWk58GQ==
X-Google-Smtp-Source: AGHT+IHdd+OgjxcLPJ7VubuHsbn7ZmU+jx6myTo6XOWQrRp3RplJlG5tQHXuY6cwwqpIoVQ2IZRQEA==
X-Received: by 2002:a17:90a:9205:b0:2bd:ebd5:8bf5 with SMTP id 98e67ed59e1d1-2c1abc43045mr2734190a91.32.1717087867550;
        Thu, 30 May 2024 09:51:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a775ccedsm1913563a91.1.2024.05.30.09.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 09:51:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f0b2c682-ce43-426c-92f9-008256f08eff@roeck-us.net>
Date: Thu, 30 May 2024 09:51:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <fa79f3c2-666f-48b8-b39a-f598107b2293@gmx.de>
 <0dc7a7c6-a426-424a-8321-471569ee6835@roeck-us.net>
 <bd197671-4fef-4cdb-8472-b46151e9008b@roeck-us.net>
 <5b9e47cb-3d9a-4d12-9d48-fc03111a0240@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5b9e47cb-3d9a-4d12-9d48-fc03111a0240@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Armin,

On 5/30/24 09:45, Armin Wolf wrote:
[ ... ]
>>
> # i2cdump 1 0x51
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 51 18 0a 86 32 03 32 00 00 00 00 00 ff 3c 00 00    Q???2?2......<..
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 00 00    ............p?..
> 20: 50 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00    P?..............
> 30: 00 c0 01 00 00 00 00 00 00 00 00 00 00 00 00 00    .??.............
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 30 10 12 02 04 00 40 42 00 00 00 00 b2 12 0d 00    0????.@B....???.
> 90: 00 00 00 00 a0 01 f2 03 7a 0d 00 00 00 00 80 3e    ....????z?....?>
> a0: 80 3e 80 3e 00 7d 80 bb 30 75 27 01 a0 00 82 00    ?>?>.}??0u'??.?.
> b0: 00 00 00 00 00 00 d4 00 00 00 d4 00 00 00 d4 00    ......?...?...?.
> c0: 00 00 d4 00 00 00 88 13 08 88 13 08 20 4e 20 10    ..?...?????? N ?
> d0: 27 10 1a 41 28 10 27 10 c4 09 04 4c 1d 0c 00 00    '??A(?'????L??..
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 

Thanks a lot. This is again Montage Technology's M88SPD5118.
What is your DDR module vendor ?

Thanks,
Guenter


