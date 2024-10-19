Return-Path: <linux-kernel+bounces-373045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B2D9A5100
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 23:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040DF281AA1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD661922CC;
	Sat, 19 Oct 2024 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuK/34Eh"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8C156F5D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729372995; cv=none; b=PWyV45CBZTFmSRjFBgegEEzQoNHid99541O1TMKeNK2YwZQHrEUWFWGbeM0eS1ahQNgUidlDGQDf9sP0M7bCA3BMASRm9z2CDyWMyFP0gLhJKNgw0z3zAePmciqpb+jHBMf1Q1iKoHQJVgMviYjTHfj/mFO83TA5OF/jLo2M+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729372995; c=relaxed/simple;
	bh=PXtwVjnVjQKoXbQM4NJN+9cX/Urz9TXJ+s86mTb6bBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfkwN3/VCrLd71h3Ay0fVnqn9VHEs2maibxs+aRuJ0dH2K41eefQcQcy+S0u7I+WkkoLvJUsntBigoo5FRZPywX66R//whfRwITzioXcPNhwn+GB6KAikmoQsgF+rn4XrLfXcqCqaHeEB+hGZCEZ9kIFo4iUk7Bq2PCDcP7r2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuK/34Eh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c805a0753so28046295ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729372993; x=1729977793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3y5VRCiALIgZNUnReYDuyg0/iOLQhzlnG2JHcQbtA0=;
        b=JuK/34EhaZFm0rYPDrWFs36QItWqMU22ZDzTVnCqdp4/57kaRKWTK6OgaJaMdUmYui
         KKSzE9qGVzWQ2yzYAsznl+ZCDdYQFQ+nJIs2Q5Sn8LpEwLmso4YOHfRP9a4a52PEsZtS
         9AhKwEJQPalzHWFYoPnu5mvFtrWBkuU3Bxea2uhPmrvYSMeeOdrzQg6jo7/kEZVt6N9h
         JDdQVE0ccXDnhfpYMkBZJNcsbUadu2Holy/098HWGh+xrfF4rVeAwmo+RudvO1OFufng
         loupclaYMGOg0h/jld+iIeB83GKG8kFXCOxBtok1R4HwG/bQ7fR7Qhih2dgAiepg/T5N
         Ncpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729372993; x=1729977793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3y5VRCiALIgZNUnReYDuyg0/iOLQhzlnG2JHcQbtA0=;
        b=UQflZFP5wCMD3zHsFW1Vcfhl6fYEIV9m4gLPSLEAthGTc9FO4DMPTBpnwFdrnojr5e
         MQD7vAuEmEZ/DX/y/TnTNpleMgnjmuVLqvLr+e2bHjB+/q1/HIP6NmKIDurhg358ffHD
         KYGK50R4NnBI/tmyaY6kmYRMcw1jX6UEvEVYjMQ583ZP4FSZpYjKzV+Hx8JpLg9wJhm+
         h579P15EfbbjZBG+Kil7Dzilr4KMOPLPYuq8Gg4ld52SRh5qULsQHtwVKIK4/iK9iR5m
         K+2YoWdywE4VNbnM6eDul55lOgbnb7v2WvU6dCMS4g7FHFfP4Yylc86lH9zjlTqMiNBJ
         zJqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7b6EpB1KBuo/cNqKd3KOif7DI2HfpS0HSCD57FWJlU4//rpDVw5Z6bRzDuZYUFH979vKhMRiXxrsO/NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmtxSqIvx81G4hR0NJL+TU8+Uyi+8G9uH2IluKrn+Vf5PXSuJ
	W3+qqASpnr0hrAQ/8wFf5lhf1HpkxeIfPoIIrtjlYY2as28zAOQjjQGxRVAork+r+A==
X-Google-Smtp-Source: AGHT+IGfrACc3yzkehCQFBfdzP9s4oLYjJ6s/6yvr94Z/VbhIAJWAjB5R1nJaFNwF99DvpyWCirbGg==
X-Received: by 2002:a17:902:ecc9:b0:20d:27f8:d72a with SMTP id d9443c01a7336-20e5a955803mr87535415ad.61.1729372993161;
        Sat, 19 Oct 2024 14:23:13 -0700 (PDT)
Received: from [192.168.0.108] ([115.96.37.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd64asm1524575ad.153.2024.10.19.14.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 14:23:12 -0700 (PDT)
Message-ID: <6f86e245-f5f4-4e12-9bdd-efb4dac7d805@gmail.com>
Date: Sun, 20 Oct 2024 02:53:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix typo in vringh_test.c
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 perezma@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241008145204.478749-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shivam Chaudhary <cvam0000@gmail.com>
In-Reply-To: <20241008145204.478749-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/10/24 8:22 PM, Shivam Chaudhary wrote:
> Corrected minor typo in tools/virtio/vringh_test.c:
> - Fixed "retreives" to "retrieves"
>
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   tools/virtio/vringh_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 43d3a6aa1dcf..b9591223437a 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -519,7 +519,7 @@ int main(int argc, char *argv[])
>   		errx(1, "virtqueue_add_sgs: %i", err);
>   	__kmalloc_fake = NULL;
>   
> -	/* Host retreives it. */
> +	/* Host retrieves it. */
>   	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
>   	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
>   


Hello greetings,

Any update on the same.

thanks and regards,

Shivam


