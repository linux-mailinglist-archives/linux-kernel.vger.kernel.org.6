Return-Path: <linux-kernel+bounces-275411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C1948548
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211B6B226B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DDA16DC04;
	Mon,  5 Aug 2024 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gZtJvkt6"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5211662FA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895681; cv=none; b=mq7KNhDQyKqbt4EnZuAmrh6ZWGaPbJfuEwcHzjUZsDrbz4Ob7vu86mzxy0ldnjx+82q4PFQwnjLtRm1uh3ILM5LXn+a0aDOXjsbPNZmZafXCM+CGF13RQ54lELCfT5LDh/pn7WEZAkDJfkbv7JNT9YyOZnNj0yzKO/2mD3OJMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895681; c=relaxed/simple;
	bh=U4J3FzJ/j6UlXBl1SDUKqstnQBbHFmk+w3DXKJ+vGw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3TChOXdkZyE3g8Ic02n0zmFRxhBqs+GVCmzb+iwVgqU4TU0QvaJI1q2q1yFdbGrdnX7KOngnSB7mHPPnXcLzTzyBRaEXx5eEtYxR4G/JVDpf2WlZn+Y0Hv6u8O6MEk/cIWSG3b4L1q+4sWk9D7IrQ5LLqKiOGHxj1frs7MsONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gZtJvkt6; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-38252b3a90eso252585ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722895679; x=1723500479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMlYsZhKej2PxVHpyW2LcZaOqCZDJpfHcgQxGaH7HcU=;
        b=gZtJvkt6teJFV0iTnwA5m9xvB4CxoQY9Iw1hKux+0GAGhFZEMeygsuEKE8yvRXYvOm
         yrrHUfoepy9B9/yIjBvNsPVoUogr9tXnYsbIcGsaI/l9E/BXgRnxpIGiri/FfkxsiGR8
         zhvvbGQ8XGR7IkoQQiuNTlETY3w0LL6pUyPDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722895679; x=1723500479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMlYsZhKej2PxVHpyW2LcZaOqCZDJpfHcgQxGaH7HcU=;
        b=KiOVch1OKIKyTZP88LPvt8llM1W9YRLzNdy3mdw1vjlmJXwN/7g5fxd0p1K7KMOjEW
         zATSOOcwfNyZKS7eR5bydjcSC4mi30qj7jqwmCWfezTscjD+Y1RIbAl6fgwN3ymdAc1y
         Lbvl3TnEkQ7zmf1452BV3jZ15eaS2lFSgN7W9JkhSAWNTpcw/8c/fVFjWAdO+DxkhSmP
         FYo+vc0z7UVvmdIfBYUfq7HZzaIi6RvSkfEQwbb+CAFaKowACIcnVUGYppG5iERlMhwY
         xllLPLwWtXsL8tcxzEuM4ChqeZzY3LW+z+VbKJtAfBu5a7OP3B85grUi6Xayt/pYwKJ6
         68vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL3hCaUrf17NRKW8vPXRKLcywmT8OIEValG48ypGtvUl8GOZkYQ7Ez/JGyoJiVYiCZYGzCi7/VIKjeYgut3QUzSu5dg9QIIj2h/3Au
X-Gm-Message-State: AOJu0Yw3WM7zy2HeBqV7uSmsY5SQaPnm33bul/x8F82oZWijjot9UQOa
	PH37jgXQT/QkqJ+KUp4oRSHa1SOx0A5fZVAnePd6KFMZuAj1qWdfuH2vaXL6EMA=
X-Google-Smtp-Source: AGHT+IFvh0bshiOD89+mdd8yvM145zffYxh0bObuw4NtQ/Z9pYep6bZ5A/17MM6f8GUt5Iti22210Q==
X-Received: by 2002:a5d:8185:0:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-81fd43d5bf1mr743191139f.3.1722895678776;
        Mon, 05 Aug 2024 15:07:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a5c329sm1875989173.169.2024.08.05.15.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 15:07:58 -0700 (PDT)
Message-ID: <602cf3ba-7d42-4c3f-a672-573f19b946fb@linuxfoundation.org>
Date: Mon, 5 Aug 2024 16:07:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftest/devices/probe: Fix SyntaxWarning in regex
 strings for Python 3
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org,
 gregkh@linuxfoundation.org, nfraprado@collabora.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240805103742.10844-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240805103742.10844-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/24 04:37, Alessandro Zanni wrote:
> Insert raw strings to prevent Python3 from interpreting string literals as Unicode strings
> and, consequently, '\d' as an invalid escaped sequence.
> Avoid the 'SyntaxWarning: invalid escape sequence '\d'' warning for Python versions greater than 3.6.
> 

Change log lines shouldn't exceed 76 chars - Refer the to following doc

Documentation/process/submitting-patches.rst

Include the exact warning you are seeing when you run the script.

> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
> 
> Notes:
>      v2: Imperative mode description for the inserted changes, added previous commit tag fixed by this patch
> 
>   .../selftests/devices/probe/test_discoverable_devices.py      | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> index d94a74b8a054..d7a2bb91c807 100755
> --- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> +++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> @@ -45,7 +45,7 @@ def find_pci_controller_dirs():
>   
>   
>   def find_usb_controller_dirs():
> -    usb_controller_sysfs_dir = "usb[\d]+"
> +    usb_controller_sysfs_dir = r"usb[\d]+"
>   
>       dir_regex = re.compile(usb_controller_sysfs_dir)
>       for d in os.scandir(sysfs_usb_devices):
> @@ -91,7 +91,7 @@ def get_acpi_uid(sysfs_dev_dir):
>   
>   
>   def get_usb_version(sysfs_dev_dir):
> -    re_usb_version = re.compile("PRODUCT=.*/(\d)/.*")
> +    re_usb_version = re.compile(r"PRODUCT=.*/(\d)/.*")
>       with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
>           return int(re_usb_version.search(f.read()).group(1))
>   

thanks,
-- Shuah

