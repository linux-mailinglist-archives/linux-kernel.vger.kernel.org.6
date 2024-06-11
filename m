Return-Path: <linux-kernel+bounces-209150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF81902DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921681F22A31
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E3748A;
	Tue, 11 Jun 2024 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2+kqDl3"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285463CB;
	Tue, 11 Jun 2024 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068690; cv=none; b=XFqgbydpHQg+SnfsjG1CNe8Zlm645Hq4RpxzVaQ91RbdSJUGHrM1Yi49cUvn/KPgekNJC5J+PEi3VOFim8NawyF0MOrmXhA9kHIbwrrhnl92abS9maGC3t/Mc1Evd1nBP/NwChxP1ZmnuK+QExNYJfQjW0AwoXrqwgHPVtpHSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068690; c=relaxed/simple;
	bh=BJ7bAtRnijieePgyC4u7Z4bcQw9xBx98woFAA6aqUTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlZAb58/shXp+tVkwNj1nbjawtytMC2VdEBgQU4s0kOaTZcX91RMSDtrMeWDmG/8ekmQ67fbg/XWz8nrRbx0tzLWaI68KHTmhix0aSlsLcyf/WGHmSKZY5C9EfLqRrTa+D0e0i6XjXSg6WPA6DFTdmvT3O5QLGpAgPAvhVN72y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2+kqDl3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c3051aee3fso1420409a91.3;
        Mon, 10 Jun 2024 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718068688; x=1718673488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ivQcwF1+c0bQ5/SJaGZTzr/7wCvctZR1yQr8NL7B8wk=;
        b=a2+kqDl3D8pC+WqiJi0/ubvzIidJ+0apTsVuaSbzf4JfK02BEX6wsRyZJ1n8Y8T2LG
         RwO2SISjuhkfXajNJSogr2p0sR7zUPBjFT+NLQomQDSIjSfCC+7FfUOr/FhowTi3ncE/
         mzQ9pQ3lfgGlaMXxJIaHRR3AmYxWWOzzrJDN2dxGITicV6PpiI4UQe4+jxjeb/jaN4I9
         9c1eg91vUxv5dZ4DtW8V0FgSVYWNQ0Lf1gEiKISRsp1e8PEEJ/HER7O12Z/KmtruyeHR
         oAizGlwldSR7VWUoQL9Dw7PwQ/I386D0ENH8z+/wCmKMfK4FphL4B3J5mdQUH3XFI/2M
         I11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718068688; x=1718673488;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivQcwF1+c0bQ5/SJaGZTzr/7wCvctZR1yQr8NL7B8wk=;
        b=Q/e5XKaYf0OZQu6+EYlx5JzRTdgTiKPiDs3u0e7IqcsZMaZ8Glc+dhgLhyxS2dkIFb
         sYs6K+mUU/qTuasjwKaFdXI+n6o7NIb0ueF0fNEY1lAxjkMJNdu/cX0RhEX5pSigX+NJ
         iHgtnGfsR4raH5X1W6qa8SQtmH44//FqW4NnXESkdeqeyNQ5bvP+BOpBIgbDC6E98C4D
         YYWtJD5lkxP50EkwGjKwXDeif2rrpA6lkVY9eLK+hURlaIIVdODmCYmFWxTQJ0qnaygQ
         ++vLdJT7iBuLFcEexi2TW93g/aDnNuuco/Uw7s6TKQA45YnrYNHa8Bi3kNC1Np2ei8uT
         VNpw==
X-Forwarded-Encrypted: i=1; AJvYcCWRFfNYTNkwLTLSKqrgx7SBNgAQcFxsQLKJ29phBxDR1hoZCU5n0ph6Pe0AVzzYBN7YUgn547t0ld/QywO0Nt2OT09T538Te4vs1sUlFqS07u1mP+ilhO7qkOCmDPiSNc9etpIBM/bCpdg=
X-Gm-Message-State: AOJu0YxgsEGQmvMgHff5HiyDndAXPmiQxPgTYKBCvP9zlcj0IEZw0cd/
	340kwzKDeEL6rABu8DiGfrhzvNtqrMEUqz5+ql0GQTZPSnZ3EigA
X-Google-Smtp-Source: AGHT+IFJ69i2QXWbo9IXcLGTFUkxLUSxxuElGWg2VWv+bzW+GUgKEvvYy7ExZBQ7/ROJYeRwYTb4Sg==
X-Received: by 2002:a17:90b:8c4:b0:2c3:cc6:636e with SMTP id 98e67ed59e1d1-2c30cc6698amr3581336a91.2.1718068688186;
        Mon, 10 Jun 2024 18:18:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31bb3c141sm1709752a91.10.2024.06.10.18.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 18:18:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <536e51a1-5968-4493-96ce-287167b89288@roeck-us.net>
Date: Mon, 10 Jun 2024 18:18:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hwmon: (cros_ec): fan target, fan pwm control and
 temperature thresholds
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@weissschuh.net>, Jean Delvare <jdelvare@suse.com>
Cc: Dustin Howett <dustin@howett.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Stephen Horvath <s.horvath@outlook.com.au>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/8/24 01:12, Thomas Weißschuh wrote:
> Add support to cros_ec_hwmon for
> * fan target speed for fan 1
> * fan pwm control for all fans
> * fan temperature thresholds (RW) for all temp sensors
> 
> The EC also supports tempY_auto_pointZ_{pwm,temp} but that does not yet
> seem to be usable from "struct hwmon_channel_info".
> Guenter, is this intentional, do you want me to add support for it?
> 

When I wrote the _info API, I figured it was too chip specific to make
it generic. It is also at least somewhat questionable if it makes sense
to have all that configurable through sysfs in the first place; normally
the ranges are device specific and should be configured through the
thermal subsystem using devicetree properties and not be touched by
the user. There might even be warranty implications by playing with
thermal parameters if someone manages to overheat the system as result.
I really don't want to help enabling that.

Which leads to the next question - we are going way beyond just reporting
system operational parameters with your patches. What is the actual use
case ?

Thanks,
Guenter


