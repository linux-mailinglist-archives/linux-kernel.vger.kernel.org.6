Return-Path: <linux-kernel+bounces-370594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103139A2F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260D41C21979
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F080C1EE00C;
	Thu, 17 Oct 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRMpR++E"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9C1EE022;
	Thu, 17 Oct 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199412; cv=none; b=NSjA3gzHEo4sVKtESZTXZa/G1y5saXeFlc24BC4GZ7nr06i6XZbyCEpF4GiKPE0YvF6o5TPT4eswG1EeW4OvoThjITwS28FFdPrwoF/70xwUCOsvrfy8kL2lK2zsf9V/acTR7LGIkgcpvPhiYAhsRztirQ6kqiznBjv3OAWCF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199412; c=relaxed/simple;
	bh=7f0RExRXih7zxFfG9mYRj/8yPVSBaFMqZ3qljFJhEw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ytawjqe77VROtj/vdfcMOUG5cOxxAJVuT5i/lku96jj1LhyTHsMFktzYHdyfYh7wTKtiQrczARHdranc7ol8qOYGW7pN4plQv6dXNS9HLp5YX7wF3AOYn8ShzFt3pNviO5dNParYGpMwgszsDVECxioGIgy2Q/3ErtTK5zeWaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRMpR++E; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e6c754bdso1467873e87.2;
        Thu, 17 Oct 2024 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729199409; x=1729804209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uumOThIh4B8vpzXdzAhjzFm80xhgepCJRIY9E1mr/Zs=;
        b=PRMpR++EFBMC/jNSurk7dpEwXk4bcn5xhp82QWtjN8rRbIuOp6dmbTqggXK9775SOW
         5cfdiSSwTP30lOC7+vWyOoTWCEld1hg2RgbSoHe59aaV9jbAHeQxpnupa/cahQehUe07
         S1aCJQo+LiNQBC4MVJHGSkOBiY+/2S5SPEoKjnrl4Tl6P5BVNsiGz0Gtsa5NWrwfZf94
         9Ig/j3vljdT7bB6Np1s+gafV9RApqt6iYR2+nLw16OFZjK9jSXGAM5A6wqxlXx9G7BqM
         T/MHTQ4U6YgLEMwsTthe7599M4hyKOtTwb4QRbG/RbKrpKeKNweHzjXqUrm42sg89h9V
         xExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729199409; x=1729804209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uumOThIh4B8vpzXdzAhjzFm80xhgepCJRIY9E1mr/Zs=;
        b=IwEkgPdExyYKn84ZfGExHBXVdFbRkloKCDfUoNu3GPoWi63b7OOLLSvVgbUYv/SDsU
         R42esLFfGaaiey1VWILSaWkX+frNhPrR7eQ5v+F40AM+GZkDf5ujJzJZwOVDwGqaspfJ
         e8T04DtEHJZbstuTLm0sKCnGh5hupArvaIfFok3MitagDyIqpupBwOaY71aBYZTMVFaH
         NjcxeaXb7GxOisR3Bz4T6GP+VLcjd8WR+v0TYZmvzPyjp3FAhb4+IywBIEKnnmejk102
         tWNvpbBA7h0vVOveSRWT3PoSrvMALtDDUcIk3LPIaOtD71NUore1wUCLfLyKPU9JsKFH
         dICQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQk0SvZERE5BdgmQPOXijH7+3G3RfRwpB0hwAFUbwE7ahPo0WYfSVEdG48jHtvLGxXkDi/cVb0tT6rirg/y0ZvGIpIoQ==@vger.kernel.org, AJvYcCWVr37jNzUJewzOKPLd/DnvuqWXkDvDl2rl/OmfT+H4cvVYsMEbcTlUJAC3iCnFXFvosvfpoOT0u851X2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YygkwAKwPc+9SZirflvRMEHUIAICfuRLuVv2EhwcRzG+vmrf221
	UG0wre9qJF5ZE0oeJJm+KZskZs1bPQJ3GknOFHKDwZgXYUIApx50
X-Google-Smtp-Source: AGHT+IH9IuXFD84Kj2OeekLkVwkasGpWvwN7ejE5UpQdq+IRs56VOrjk1GXQc98GSa69t1E7h0gcZA==
X-Received: by 2002:a05:6512:128f:b0:539:f1ce:5fa8 with SMTP id 2adb3069b0e04-53a1550b9e6mr151336e87.49.1729199408386;
        Thu, 17 Oct 2024 14:10:08 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:a5ad:82b9:3ea0:80bb? ([2a02:a466:68ed:1:a5ad:82b9:3ea0:80bb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68ae543csm13565266b.74.2024.10.17.14.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:10:08 -0700 (PDT)
Message-ID: <09999c3e-e03b-409a-a8c3-37849fe50878@gmail.com>
Date: Thu, 17 Oct 2024 23:10:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] platform/x86: intel_scu_ipc: Avoid working around
 IO and cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ferry Toth <fntoth@gmail.com>
References: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Op 16-10-2024 om 13:48 schreef Andy Shevchenko:
> The first patch avoids using a workaround for IO (which seems unneeded).
> The rest is a batch of cleanups. Cc'ed to Ferry in hope of testing on
> Intel Merrifield (the main platform that uses these APIs).
>
> Andy Shevchenko (3):
>    platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
>    platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
>    platform/x86: intel_scu_ipc: Save a copy of the entire struct
>      intel_scu_ipc_data
>
>   drivers/platform/x86/intel_scu_ipc.c | 142 ++++++++++++---------------
>   1 file changed, 61 insertions(+), 81 deletions(-)
>
Tested iio_info (mrfld_bcove_adc), host/gadget switch, power button.

Tested-by: Ferry Toth <fntoth@gmail.com> (Intel Edison-Arduino)


