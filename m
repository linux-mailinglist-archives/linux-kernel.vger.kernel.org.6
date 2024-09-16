Return-Path: <linux-kernel+bounces-330690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58B97A2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8259F1F2382C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF1155322;
	Mon, 16 Sep 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sr5pdGeU"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8874C1B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492563; cv=none; b=tzy2Dsqx4+lfPR8Tfgp0dCy0GWiBoQmN3ijtGzCUbCuS5HQw45HKnZ3fLq7SPvUwHzuum6U18Eje6VvwbT4TyTmUShEKTyMDlRauEAdi+iQq7cJDnQXf393RL+R6pt4N5U1Bc73exGx0aNaV1YqoK0jzqVjjhlg24bXe8G5+PNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492563; c=relaxed/simple;
	bh=2shiFns4AIRKhTvk4uVTiC/091P8kqg35b89Q1fiQYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDXmbtgIuutPXnC3GEa252SLnpyNTru/STOo8v62Puvh8Y8zIWGNRXXdAYEf5+C4J+9gd1SUozZsvPwhSSn+5YEDfIggXs/kyfIvq/aaCRaDFakjgUSJcQTKGFOKj50jDvXDrtIfK0PbsBEH6PWAsK2u6o84K7YSz7wSwhZWpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sr5pdGeU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365c512b00so5176337e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726492559; x=1727097359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ls9W+JYpgNy7T22J8TYpc1bbB5LzQvlCFI+QGPISCHA=;
        b=Sr5pdGeUYyGL8gOGZuj057KThUPAJpVDdtozCgm5DLU8Sp95W5LqxVa0/VWi014j1k
         t9l8hGPXuOTMtkq9WwSqjvfWtwkezJ2DAFp2SfmYrZyQMkiOVjIV7PeCB+uszYohNwKW
         nQyrTZmNw4u5kX9L7Kc6pVCLSxiIqlhSZDh3iqIdwFL9fUjlexFziy0cM+rSJ1HCsGXX
         mbSlnpr0Tb8iHxgXDXy/qI9pyIlxLXXxV2ny4RwgWNXpqFrfBxoFxaV5qGd1HLxri4WU
         2GRq8JLb82ts/cVUeV1iWWu7JgVwSofNa08uCatB5kDYLShemFyacr8CZQFXrwXpvOOt
         4yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726492559; x=1727097359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ls9W+JYpgNy7T22J8TYpc1bbB5LzQvlCFI+QGPISCHA=;
        b=JCjqO4nLowJ8DsrX67ZAvEeGJvnhLby9TH7e8+sex0VG1KyVX8nsJKCNJOsJnjlPnC
         RNEVwMLEqbLTqQsWJAuWyzVjGeHOrRS1PSnc+3kBfbVL9WPGdNjDmx3KxpihRFpLAPjA
         neIkCbDKadPpgW8UwZSVBZQ/qXU8cHXT7/7pbZ10aRklhwxMj+qRtVN0pVUj+2zp0nbd
         Rj5EtacmIlXaAc5h/x6FR2jCX/tjSGHCfcvWe6IF5Ky1eyguXj2OnHuUWL+qjcSuDLI0
         krqezWOQRg3qlMf/zyAJABex/LHqEzKYW6ZrymhS/PjLWE647lKcVDDdeV6U42v5eeUn
         d5IA==
X-Forwarded-Encrypted: i=1; AJvYcCXSCJ27lSM1QhngaIH2EZIqKowGMYbNuM1Pmj+MCw81O2D3nwpPt9yHslwYCTku/Kq6KM6ikefNRmnFWfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9Sq3xo9xB/lctuIWle8kN7eUdWMT4EjG0OdikfeTE5jTMVuO
	ne3kSM3elTavzWD5HzHtt4t9Xa9ay1kT7hG1UTRxqke+ePqLiBrdpnnq+fgyHgM=
X-Google-Smtp-Source: AGHT+IH4vg0e3jbvOI9X3gkE9iKT9Vuk7SRP55iyuY6GatZZovt69UcnZ9L7Aq8MNfu1NO+yj3b15w==
X-Received: by 2002:a05:6512:2c0f:b0:536:7b56:6b90 with SMTP id 2adb3069b0e04-5367b566c40mr6711840e87.56.1726492558598;
        Mon, 16 Sep 2024 06:15:58 -0700 (PDT)
Received: from ?IPV6:2001:a61:13e7:b801:321e:ca35:2127:23e6? ([2001:a61:13e7:b801:321e:ca35:2127:23e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b189d0dsm111485525e9.33.2024.09.16.06.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 06:15:58 -0700 (PDT)
Message-ID: <bf971924-9d91-40a3-a4c2-5b518e2ce2fd@suse.com>
Date: Mon, 16 Sep 2024 15:15:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Jeongjun Park <aha310510@gmail.com>, Oliver Neukum <oneukum@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, colin.i.king@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240916040629.28750-1-aha310510@gmail.com>
 <2024091648-excusable-unfilled-83de@gregkh>
 <15bc0f3a-5433-43e0-b0b0-8b9c26dec165@suse.com>
 <CAO9qdTHrbG-aWetpM_e7zHUhrwPD=7uCHPbWSMoorgnwjKEOmA@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAO9qdTHrbG-aWetpM_e7zHUhrwPD=7uCHPbWSMoorgnwjKEOmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 16.09.24 14:44, Jeongjun Park wrote:
> Oliver Neukum <oneukum@suse.com> wrote:
>>
>>
>>
>> On 16.09.24 06:15, Greg KH wrote:
>>> On Mon, Sep 16, 2024 at 01:06:29PM +0900, Jeongjun Park wrote:

>>> Please use the guard() form here, it makes the change much simpler and
>>> easier to review and maintain.
>>
>> That would break the O_NONBLOCK case.
>>
>> Looking at the code it indeed looks like iowarrior_read() can race
>> with itself. Strictly speaking it always could happen if a task used
>> fork() after open(). The driver tries to restrict its usage to one
>> thread, but I doubt that the logic is functional.
>>
>> It seems to me the correct fix is something like this:
> 
> Well, I don't know why it's necessary to modify it like this.
> I think it would be more appropriate to patch it to make it
> more maintainable by using guard() as Greg suggested.

Allow me to explain detail.

guard() internally uses mutex_lock(). That means that

a) it will block
b) having blocked it will sleep in the state TASK_UNINTERRUPTIBLE

The driver itself uses TASK_INTERRUPTIBLE in iowarrior_read(),
when it waits for IO. That is entirely correct, as it waits for
an external device doing an operation that may never occur. You
must use TASK_INTERRUPTIBLE.

Now, if you use mutex_lock() to wait for a task waiting for IO
to occur in the state TASK_INTERRUPTIBLE, you are indirectlywaiting for
an event that you must wait for in TASK_INTERRUPTIBLE in the state
TASK_UNINTERRUPTIBLE.
That is a bug. You have created a task that cannot be killed (uid may not match),
but may have to be killed. Furthermore you block even in case the
device has been opened with O_NONBLOCK, which is a second bug.

These limitations are inherent in guard(). Therefore you cannot use
guard here.

	Regards
		Oliver

