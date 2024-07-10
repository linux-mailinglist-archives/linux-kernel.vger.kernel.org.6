Return-Path: <linux-kernel+bounces-247903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEBA92D623
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DA428A707
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD7194AF0;
	Wed, 10 Jul 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MEzdOVbB"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB94194A68
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628219; cv=none; b=Sos24gI8d9XhgfBLiH8hdP4xrJp93+tLxBccyZXRWm+sv+hPk6844Tv8o2piFLCpYsoKSboFGSQgXtk/XI/5fXzOyIDJG8puKF3/PfmRz3OCya9828/DriWQ6kqF/8IJzS9TYKlndD7DyDXFi0ziD89jvJPlQl5JGxvMNhQMmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628219; c=relaxed/simple;
	bh=b1jCzpljv294jZ54BFzSlA1N/lX/gcP5LuBmaj4Ng+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4jTq2tPQrnpP+0Tk3IUbc4i7ZSCL/P4oMgj7DcNg3lCq7DNgg/ounqjoYnW+im/cbSsqnZzhkgoLeUIOJjelSGUgwduOK10qXnZCR7UeN5UjdfMhfEu5/+S3q4p4OkSWdDpfduxYhRdPXVZqbOGljR+Y76WLpxR1aT7me1eszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MEzdOVbB; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eeecebb313so26710239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720628216; x=1721233016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcVXn2c1HJMrHq2kPiVMITG/JkIH8gyHy72G2+XXsv0=;
        b=MEzdOVbBIIdgY9DLH+zvsihkBmaOsfg2IzQwf6vdcG2xXdyZBPH8sEFccOW0DNGnm6
         S091vAGAH160VaPQXUX8Tlrn1Y0DF7jbMvudQ43zTmwg5XUgRiV3MZLACGDB2uosZexM
         d0dJX6wsh9B0l2a7lqj2ld67fjRyATj6Mpt0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628216; x=1721233016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcVXn2c1HJMrHq2kPiVMITG/JkIH8gyHy72G2+XXsv0=;
        b=B960lAQP+5+SReH+wUCpeddxN5xBn0fXrcUrx/DBdNFnEWfGVLastNyXcO+vNO37/d
         dWIV/20+YcVYoqfXSheIBKpVvcC382EosMJ5AEwA2Yfyu92dTZOzhvifx4DpIKBGJMEc
         u/z0GmQhYlUavqXcutJHZfQ5wa+VvzeuYXqMagj7H4TOH49eF2BpypL0aqZ+xObMoo0p
         3RcJpI5MTTyeHNRH/6wxQjwr1EV5I9suVwF2iF0/KUDkRKwerMxGBVUThkObijDnlEku
         34GQUzs3fH9X7lNXBseM+jGWVxRsCxQ+EKtzyIblf9atmg4gLM714MH5+D2kLaSpMTU8
         u2pA==
X-Forwarded-Encrypted: i=1; AJvYcCWduMqcUq9rA4AlLU08DxUVmi/fpKTzNUzf4+Fp7XCw3eC9dhewBlPGbOEpMQCGBT62aWzky+NjXqPtAe7BCcDN9vIbz7F1AGbMtzw/
X-Gm-Message-State: AOJu0YzmJdRnzgluaYngr6WJ/16nvxlcFbsTiwR+AzWpMee8giXF/ELG
	CnKlUzJaZOcSFHGEMRHJuc5tcAil4xbIfXD4EaXSOOwyVgiEtpXZ812NpnyB8bGbq19FIQBfBfG
	5
X-Google-Smtp-Source: AGHT+IFLNAXjuVHO+RsZXCAHzp+2VhQVXm+gi17DFvsPlXeiTnPye6ujudJmxfOdyHv0WAe03xGAaA==
X-Received: by 2002:a92:c092:0:b0:376:4224:7611 with SMTP id e9e14a558f8ab-38a59e8a8a6mr55991525ab.3.1720628216546;
        Wed, 10 Jul 2024 09:16:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38b5a638875sm6812865ab.41.2024.07.10.09.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 09:16:56 -0700 (PDT)
Message-ID: <0333bafc-295a-4fd8-8099-8fa8c6b0ae23@linuxfoundation.org>
Date: Wed, 10 Jul 2024 10:16:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240426101824.2894574-1-usama.anjum@collabora.com>
 <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
 <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
 <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 03:37, Muhammad Usama Anjum wrote:
> This patch brings just readability implements by using kselftests wrappers
> instead of manual pass/fail test cases counting. It has been on mailing
> list from several months now. Please can someone ack or nack?
> 

Okay. I think I responded to your other patches that are adding TAP
to individual tests when kselftest wrapped does it for you based on
return values.

The reason I don't want to take this patch is if you run the test
using the recommended method:

make -C tools/testing/selftests/vDSO/ run_tests you will get the
TAP output because lib.mk runtests framework takes care of this.

or

make kselftest TARGETS=vDSO will do the same.

Please don't send TAP conversions for individual runs. You will
start seeing duplicate TAP output which will make it unreadable.

Run the test using make -C or make kselftest TARGETS before
investing time to concert to TAP. I am not going to take TAP
conversions patches if make -C or make kselftest TARGETS
shows TAP.

thanks,
-- Shuah

