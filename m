Return-Path: <linux-kernel+bounces-177762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112E8C4454
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727FD1C23144
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2FA1474C4;
	Mon, 13 May 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4wJpNJh"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA457CAA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614490; cv=none; b=Q//wIwUvKqx3VqJnwmpROcbWcoeQ+ncU4p1nlzr/6i08y8pa2Omo+sCcPRm6oSc4SiGJC+InVR8AmppzgU/fHAVXZoDm5QybUFFsfTWWMrKNkvSExKRZpGhc8fiMo0UwMoiO6mrSxNsHw+4mbW9JjxWyP6byfWo+4MkXLOvW38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614490; c=relaxed/simple;
	bh=dQimLPdkQBWyhxxy8uQKegVXghxi0XK56ACrEWcUCdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ry/gzXjQXyqYKuRFTMZwkfuSCQ5L6y+CPwMiax8xr1TTdeKCG6G9JoUMm6NHxLTIjeb6WC7J4Nzss09ERc66p8+PzpGJ4RDT5CRj5zi5pbuOoXJen2f5o+BoKUOB0OHSLNS85b2V/g8G85s0nbuLdtAQI5iIg8+Amqb05jHGLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4wJpNJh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792b8bf806fso394240585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715614488; x=1716219288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WArF3JKHQHCUYXKfERnzvCoqB2LXbZ0I/ZDhfu1022E=;
        b=O4wJpNJh1kqL6MRqdcDuzqyHcekodN3J1ZiKkSPX/Ghya7XZm1rlzTHAqp4N7MnZqX
         fNqZF4h8nOyFuWD8jllpdPhj1HsMEswjmtE3PYZXE5i7dj1bKlWHvh0iDpZy0D+byb/i
         22n7JkYp465p4LN/qgvsDyPWXtq1cs968FJZC2k2wRjO8Crweq7zQfSEwKGOLW9mHTKf
         WTc4yR51SyHjlJEP30dLdyNXaJ/CK1M5rgFOkpqW+TOzh61fwhgSF1FmH6eYkwf74iZ/
         orincZe2njR5ecM3tVs4SJmmuLxPvgp+CO4atukoQbkIIuCIm3yDMijOVqehRATk7eFi
         dapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614488; x=1716219288;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WArF3JKHQHCUYXKfERnzvCoqB2LXbZ0I/ZDhfu1022E=;
        b=RqfgVVkuy3hbLLUGfkxlkE/KjNw7jSz4tQLu5Nbp49CMh+2gmw9lIxyWwwlRyuSm/D
         x1fxK4ei20Kzj1fMMnxKcR2rItk+BKyBx3AwfnD6zqEGkRBw1CUJMxyCkQnILBrmq2Z8
         iM088KDAhHB2T2+uTd5uPeAyJ/EsQCPQdcc07bFpwyX6d/u5kbR7zMqZQFqTsYHmH3RG
         NPpvzTljuVZl/NSwmshaUQssMSg+SaU/Jys7yrX/ivlZbkcPfNc+GwIyVr4qSQKAQScn
         9gwVfbIf8KjR6Afbf8xD6kVpRW4DbS+36PpFb7F4KmFGpxeeCgDF3ZrI25aP7YD9NRCR
         5gJw==
X-Forwarded-Encrypted: i=1; AJvYcCW6M0qBba9lmoH7hOqWywjurOSmkV+t4Ku7Q0U1OwfxWXNbdq2f/pherRbC8u9RIVZMg1mh89X6eLm+QPZh7sHrGPmlq6xYdkZ2YNbY
X-Gm-Message-State: AOJu0Yx9jWrhSYY+xW0789rAzPS3hPQh7n729XpX5MM7UY6Sd/Ady3AL
	Lq6hq+bR9JgZ9D6uyuJ0xtcPbBYuEtoWl6QkAqUiPzrGZvF2oCyw
X-Google-Smtp-Source: AGHT+IHuzlporWHE19lc0ghxDrNQPey/qT9Hx8BkhgQvnoEuyW/01MqS24bY0LjtDqMcCqbGNokyWQ==
X-Received: by 2002:a05:620a:2197:b0:790:f7a2:3b24 with SMTP id af79cd13be357-792c75af7e6mr1072127385a.41.1715614488258;
        Mon, 13 May 2024 08:34:48 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf280390sm465460585a.35.2024.05.13.08.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:34:47 -0700 (PDT)
Message-ID: <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
Date: Mon, 13 May 2024 08:34:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org,
 "OlteanV@gmail.com" <OlteanV@gmail.com>
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 5/13/2024 8:33 AM, Stephen Langstaff wrote:
> [Corrected emails for f.fainelli and olteanv]

What is the build problem?
-- 
Florian

