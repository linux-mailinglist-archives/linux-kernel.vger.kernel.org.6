Return-Path: <linux-kernel+bounces-335959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164597ED25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C51284101
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD2181BA8;
	Mon, 23 Sep 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbh/wSHZ"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A944198E91
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101426; cv=none; b=VU3TigR/GVh4FxNtJOjoa0MpMx/rojRBKfjg67VQ54hcNYm2xQk+yFqgTGc+snBZzyr5pW+02M2Bh8mowkOsOSc6CZ8GGac/v/mXkLu7bk4nECUj1EDgvlg6SXpMc7SZZlapE05n3+nccA8VDn+eEH0KFxquRY3HiQOdlHBklEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101426; c=relaxed/simple;
	bh=ElvABRr5VjpnwP1zIJazjGAk0ginLE0uvF0oEQoEwgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZbf7Iq0MiN17C7iNS/3kxI/0wBd6zSV9MAuUq997kc7okKerWxo3Y6uo34cwfudqSGzfI2weO1jb6t4wfXRHp4cFFC1UHv1nG8Fj8yc6d8MCHANpRyssh2xjoi7j4eSh9avCv0PVBpPxJq7hkXxPoS5pWpTC8wUcIo0uQGGVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbh/wSHZ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e04a6feef3so2189022b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727101423; x=1727706223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lbzh5ja4yUukHa5Xx2/b5igvA7/x1XnV940OLZCShnI=;
        b=fbh/wSHZbG0fDmTbSelN+zZ0Kx6bWtFVZSfQUt0ldcUABrgQRVsaCCXLDXGvkjV3dR
         ta001TAmF1yvY7a1NbLJI2SEvAOQbgdlqdY55Bz2P+yuAApTJdEdCv3uc/+kbYmV7chT
         HnlZGp2ntAD+yQvvSWrfoLcd7CAaNZ6QhoVk2WymjOkexgvEnTtgTzqdmZHfYcUHhV2e
         y5xwYB9Ea1Bi/liIzp67DuQJwpe3IO9mfMFxFb5+ubH1FSGdcArXGdDAVEqWRrJlwu4a
         X/SkXEMRJVURSABVVohfeu5yRYr3AHHnzMQ2qYOY7kgvSbY1hBaEvE8YYkwXpgzZwI1m
         nMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101423; x=1727706223;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbzh5ja4yUukHa5Xx2/b5igvA7/x1XnV940OLZCShnI=;
        b=akVVwsCC4lZT0U79XkD32KrpbpkovP9ej6ShVDF5nPPmm3PE0diIIhVvF7A9UpMMBR
         jz/a8WkVcM22antYUB7l0+dB3bC/7QgLCidOGPLTEs5xJH3yFRzNwoYOBXJzQ9wjrWMv
         cULWwDsyEdwv1HYo+kR2yMiz9Xh9fRqG7k6g9u4FvN3Aimrp+3RNufkxGUZsaI1NbBTJ
         HqgqS8qAUl+6O5YfPuBOtWOcKAMoc0qY0ToemISeNTeOcspp75mofhvCkVDqyifUxCv3
         Hu/A+MVPVbrYCXVnhd0WUySJK46jdLeI4D/zK2QClqjLPZyX1ES17dW5187Ml9iGW/b2
         VtYA==
X-Forwarded-Encrypted: i=1; AJvYcCX67HIB4P2qDwHueAyy8mJqCAbPMcRbEyNM0uqI4ZvoKFwL1zCUsugJOw3uZ39JNGUssQRtwJpw3CJFjLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDG7cEQ9oQBh3tmCmu7R2tAkiMBhvEy2oMALcWP0BlaQC224i3
	+Hx7HsVlPMZVPV7MSujn7cTR4QEKO/xadW8hauantOoHw2qbUsew
X-Google-Smtp-Source: AGHT+IEXGk0Tzkbw8soq0uJdJ4wvjmVd/QQYLxq6F8yR8dHnNWDibFc90TWyOLj33DpfvWKfmFoowA==
X-Received: by 2002:a05:6808:309c:b0:3e0:470e:71e4 with SMTP id 5614622812f47-3e2729a5b64mr6209587b6e.33.1727101423086;
        Mon, 23 Sep 2024 07:23:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49903e39sm13266169a12.31.2024.09.23.07.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 07:23:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6769e87a-b2b1-47c5-87cf-a536c4b27ae9@roeck-us.net>
Date: Mon, 23 Sep 2024 07:23:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Huang Ying <ying.huang@intel.com>
References: <20240922225041.603186-1-linux@roeck-us.net>
 <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
 <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 06:47, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Mon, Sep 23, 2024 at 3:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> Interesting that you get that to boot. The q800 machine crashes for me
>> when trying to boot it in qemu with the latest upstream kernel, in function
>> __pte_offset_map_lock(). It bisects to commit 394290cba966 ("mm: turn
>> USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options").
>> Reverting that patch fixes the crash for me. I guess you are not seeing that ?
> 
> I never used qemu -M q800.
> I have just verified that -M virt boots fine?
> 

m68k doesn't define a NR_CPUs configuration option. The new "config
SPLIT_PTE_PTLOCKS" depends on "NR_CPUS >= 4" but for some reason that
evaluates to true if there is no NR_CPUS configuration option.

It is interesting that this does not affect the 'virt' machine.

Guenter


