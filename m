Return-Path: <linux-kernel+bounces-187230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92C8CCED8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB581F21FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24D13D259;
	Thu, 23 May 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LOTqYI2J"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748813BAD9
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455735; cv=none; b=Rxk9fcI9yb48aqEWWyPKdgYiTCaD0MIUUKlvgrA1IDVHAq5DvoIYTDTuf+F/oGmH3H8gmhP09kjhsPGhkAxWN++kHxS5zTZrv788wynlUTkfAQDT1F/WTxl+kRpnN+CxBwI5UmP43VRQFMYZ1EJK0KqGwWI1dyvuCjjNQWHiHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455735; c=relaxed/simple;
	bh=b4/uOiVZm6dCYuLpPsVUE3k95DUxAU5znaBJSv5JF1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiPJiT/68jmvxw49OruZS4HZQj/ZsFP/iZNLKQgOenpd0U2OBDhsYlnNay5Kff6FLkc4mu7rRltgoO0J8FZPLYNOKt4s58xOgCR1xqq0mxQqbHzgW7W0kZma9qKt6uC0SBKyyFBqpslrGu1uUtjicdEGziCv9+Gs1C0izb+2b+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LOTqYI2J; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so9169598a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716455732; x=1717060532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6yzAgRpwuvzYwVR75MaBk20iyXv6xLY4no1ggHk/Gg=;
        b=LOTqYI2JY/DJyD2p6dH7RrMUUmaTEE/UwQbd3ZdNd9II3SQa+fnUoI9k+qGQYRU6mv
         FCI365zh2X14z5HSLDX/c7xYwUmtWVC7vaTzDhwiSFh7Ztu42/hfMJPOtzluWevk1hJ1
         9K0FSNmr6SKnj2JP5UFeaor+MsgPuDHXFnsEWi7ItGDwTwjKifVCGTKhhWSd3sk68Ffl
         vWzT7M3ScLz6/NLE1ZKveLRedJkvIesGb9dysPtZiSCw7yJg03KfJtODTPEyvwUU9B3L
         bKzJfLTd5j/iD69ROllj2XGmPhYUIoOxxpNDX3FZ1S44CHexEuColIIgjlXZc4CmNj8Z
         sEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455732; x=1717060532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6yzAgRpwuvzYwVR75MaBk20iyXv6xLY4no1ggHk/Gg=;
        b=VqSYryO9vYYXTvQfTL7NVy4QLhEBweVjgdN88l2eYxDkwcgySgDEi7pnfW5xXHcfiH
         f7Zb0bu35o5+hz2GKkqwjCZYkyG2S2RUlEJRMSxkT5M79VQCbKsnY/riojjaq6MQ7kAv
         GmanLoFn4MYvhXjm8vyTeYKlAEzralBhseJ4Mxne5Aujxvzqd79MD/CBEogQ5ZEcteiw
         aZN/Ktnuyifc/YZTGVKFdfjKIqFeHG3867AYVFREJkIpOVm/fqSjNreXZRjeFsVG5/3Y
         spmYCDBFx49fc0sCde2NIA9Uyiw2aJYDxea5h9ihRqIJklDXf917yzJVmwR/9q1XadI9
         s3fw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5ikMWQ2m2D0Lj0vLuVyuJefCg7eeP4/igz7dRR7/l4B883VH8MAkqIIifJtbICr2uVr9KjmoEJKQr/kTnZQHZYTKVa3fB7NH+W5w
X-Gm-Message-State: AOJu0Yznc+Yo5z+28IoSXJbeiAKkcJpkelIVvWndDaBvDZHwKqNuGmD/
	QXih5+WLryhC4i5niy5q77Cfom4I9vk78L5J4fq31MBedU2HL4tV+L5AqocEq8M=
X-Google-Smtp-Source: AGHT+IFlK6BPcmpQgb/RasDDa8Kay+SC0dzEgMGYxnkZxxnwGN1c9iB1Q9yynHrqPd1XTTXnWvtzDw==
X-Received: by 2002:a17:906:81d5:b0:a5c:e031:faf2 with SMTP id a640c23a62f3a-a622820be32mr341298966b.77.1716455731708;
        Thu, 23 May 2024 02:15:31 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17754sm1888859766b.192.2024.05.23.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 02:15:31 -0700 (PDT)
Message-ID: <feb574d6-54fb-4ad5-97f2-435e2636c07f@suse.com>
Date: Thu, 23 May 2024 11:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Check whether divisor is non-zero before division
To: shichao lai <shichaorai@gmail.com>, Oliver Neukum <oneukum@suse.com>,
 stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 yue sun <samsun1006219@gmail.com>
References: <20240523072242.787164-1-shichaorai@gmail.com>
 <a218cac3-9d9d-4ac9-8ea3-0ea9822b2261@suse.com>
 <CACjpba7yh5Soe_Pr7D3SeTjjqzQB9q=nThaYRGAZu+EvaLfxfw@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CACjpba7yh5Soe_Pr7D3SeTjjqzQB9q=nThaYRGAZu+EvaLfxfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23.05.24 11:12, shichao lai wrote:

> Thanks for the helpful tip!
> I reviewed the code. Your suggestions can actually avoid repeated checks.
> And there is also such a problem in alauda_write_lba().
> I am a beginner at making patches. May I commit a patch again which
> fixes both issues you mentioned?


Hi,

yes, you usually are supposed to change the "[PATCH]" in the
subject line to "[PATCHv2]" and add a line in the log describing
the difference between the first and second version.

	HTH
		Oliver


