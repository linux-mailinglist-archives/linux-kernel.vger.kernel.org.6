Return-Path: <linux-kernel+bounces-321803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B769C971FA7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B981C21C50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47A3172773;
	Mon,  9 Sep 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAN795Mw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046F16E863;
	Mon,  9 Sep 2024 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900878; cv=none; b=SITAtPsxFqdBDWN8rUIapdr9ctclCU+rNPO4gWiCjTHUGzuX1wd+bS9sDBVNcLnZJN9M8FpkW7uHvckXBDAb1rzrqM3a+/m/wA24v0bWMk48dQmK90+e+b1B7Vc0wFOT+w5Ue87TcgJkwzlKZqx78mNYi22UcvZArZkkCtnY3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900878; c=relaxed/simple;
	bh=Uc4oqx8r89F4d4+RzZSNlTAqTVmyJPYUt1v3A7TkYQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrP1Uzz03EonYkfXyfOAVt0GhqwW5fC+B9Y3pyN0CUfDLxYhl0FKNqhNGqvqb+JFqPU+Ugb982ODuTDrvTP01FnmTBp2SsJLCyIDSLDfJOhHac4M1F1axab2cQIS2a/sTqjjtTxEKH658NxSzk5Lu0axOkRrWUWHVoge2vfFEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAN795Mw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-206aee40676so37684645ad.0;
        Mon, 09 Sep 2024 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725900875; x=1726505675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34uAdb11uQLhNV94N8X2Oy4kl9xBRHlRVWNj3wha+FI=;
        b=DAN795MwzAtTD2JnD5h7MHeA4VzNrJAQxKsTtqkKGHYjlQNKMOjlgYmij5aXsgQOAZ
         8k4a+dYZ8sjJa05lu9ZEKy/GuP5TXsl8lKbZzawwF3hqiOXYo8W2cT77UMzMR/sLVmu0
         8loivxPE1ODfFANS8Z3pVkV5MdAqtEznjCQsCRjXn4wVdPvy7lAMKNS2wMnPcBT+BUIX
         VzD6umy3VL3n59aewcIiFX/TVWl0MMM5b0mbY9SUA5KHpw1xLLD6qmENhbZ5WV5RzpjK
         c2vZ/A5WYqfbF4UCSKE0p6+nkgKiez7TpCKfJ9mG/Q47NUNb8/BCb/LVrnpEk5O+9MHx
         n0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900875; x=1726505675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34uAdb11uQLhNV94N8X2Oy4kl9xBRHlRVWNj3wha+FI=;
        b=Py9F10rzGULkwaEhDfJGAU3HAhJC7oTy5t7D5yZ96IJsEtLbrXzAO7deVxhmad7t6c
         x/Ma7zKB6kgvv59Sbckd6kJ3PAx/Y2eMJM/si/dU7mOULBQPUuLnXWMyID7JoYO9RHVV
         tIKeQRc1cp/4O8yO6KYV3eyCmiSMlahSKxCga25TZIqwW4Agtc1cqoXzBpUEFcr4ERc8
         niAt6gRi+hTN2orWXuHKtGCnWt1wHvWkAnEXWP2V1GP4Z8gd5tsbGmwJ/QvXtwbEUiB3
         sv6cQKTGn8lBO6oyKqmPJpRkm/ShqWoDMaO0ZQTPMyTcfL8+e4S0rjT1InJXDzgVV+Sm
         nbOw==
X-Forwarded-Encrypted: i=1; AJvYcCUzjSYDbLcWI3Hljz7betE+wpOwkhoEneejqTT4cqWMPD32uLKeWXiyHb945IIpWEqeA9lVDr2xLb8kVq0D@vger.kernel.org, AJvYcCVkejobCo/vcaBZmaWeETDC7tuep2TsGKVVp2evMUk8yn5MwfLHOYX3D3y9bAu83q9Udob9ZFiL9e4bLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1W8tZM7Rm1FpXHmbV6VdVRMTmk2Q3utCnmEZpt2Fh860gKpi
	DRkWPdDw6pH47sR2gt14F9YzXIfQzvdkzFdBwW7QLDqEOdhQGOBGxSIZGg==
X-Google-Smtp-Source: AGHT+IEPGGj4yMntuV1n5JimriAHUvZB61rHZ3WiOJ2P4bbZxHRSqeTpyEm6nDPkscapEuRKR3ODeA==
X-Received: by 2002:a17:902:d503:b0:206:9caf:1e00 with SMTP id d9443c01a7336-20706f44b7bmr93553475ad.25.1725900874983;
        Mon, 09 Sep 2024 09:54:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e3276asm35888465ad.64.2024.09.09.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:54:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 9 Sep 2024 09:54:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Conditionally clear individual status bits for
 pmbus rev >= 1.2
Message-ID: <43cfe2e7-6b53-4ac0-8dbd-aad6d34a1ba8@roeck-us.net>
References: <20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408@gmail.com>

On Mon, Sep 09, 2024 at 11:30:28AM +0200, Patryk Biel wrote:
> This change adds fetching PMBus revision and using it to conditionally
> clear individual status bits while calling pmbus_show_boolean, only if
> the device is compliant with PMBus specs >= 1.2.
> 
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---
> Current implementation of pmbus_show_boolean assumes that all devices
> support write-back operation of status register so as to clear pending
> warning or faults. Since clearing individual bits in the status registers
> was introduced in PMBus specification 1.2, this operation may not be 
> supported by some older devices, thus resulting in error while reading 
> boolean attributes like e.g. temp1_max_alarm. 
> 
> This change adds fetching PMBus revision supported by device and
> modifies pmbus_show_boolean so that it only tries to clear individual
> status bits if the device is compilant with PMBus specs >= 1.2.
> 
Most of the above should have been in the description, and "This change
adds" should be "Add ...". See the "submitting Patches" document for
rationale.

> +	ret = i2c_smbus_read_byte_data(client, PMBUS_REVISION);
> +	if (ret > 0)

	>= 0 for consistency

> +		data->revision = ret;
> +

The code needs to be be further up, ahead of clearing faults, to have the
faults cleared if the command failed.

Never mind, though, I made those changes and applied the patch (I want to
make sure this patch is upstream in v6.11 final).

Thanks,
Guenter

