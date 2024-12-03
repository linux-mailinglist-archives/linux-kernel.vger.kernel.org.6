Return-Path: <linux-kernel+bounces-428574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D39E10BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813BFB229AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521D6BFC0;
	Tue,  3 Dec 2024 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qbxa4vWV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B141746
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188952; cv=none; b=A+wLZgJJI5CRXmoJknkDesp52WTiqcH0TCLmP13rjxlMK3J1EnTg36y/5MBU1ZTofYZubcaG+FihWc1kHuBbGcDkhqPy97x7QWS3sAX0GZQ7ysp15vAE/elOFWP+2RLIe5sEHs/C1EBngcSHC2l8xpCAo5b88sjwH69LiMNkl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188952; c=relaxed/simple;
	bh=m/fx1J/8tVqA2oNszfbUC0kJgBMJu1/cuMuZpoY0b6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQw0eT2efCz3RsaqipHQTzVTvmeEQLubGq7VlMei4G5Z9qrbsPuY9Tkz7MNPbt+N80igkdrEnMX4lP+/U4xQWKMWXYWvSPj18MPDPN8HmP6KdGUNSJ5zXymZu0VySyhOHatuaiZYxsLw5czrGjBAXJqVtD+D7wTOpWlQtScJdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qbxa4vWV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733188948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPUytPs4xOuYgB/EnXxQxcKY3Ggm37SPyVhQ2/dO7hk=;
	b=Qbxa4vWVNSRrafeK2poN2RlKiF56mtPdSbSXq5wUnLSFIqYvzZyUWFjunvQ5wIU4+PxNoQ
	VqghlrIsLufrpim60GS+7XgndNaqnUV2pIsKqWkN90S2tAC2sRdHottTED81hy6LJ/Wv5N
	2vCkcOGku6IzXCA/VUuBtWZurslEiqk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-3n7uMwmUPwehQ4DyfMdNhw-1; Mon, 02 Dec 2024 20:22:27 -0500
X-MC-Unique: 3n7uMwmUPwehQ4DyfMdNhw-1
X-Mimecast-MFC-AGG-ID: 3n7uMwmUPwehQ4DyfMdNhw
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2156b4c8bbeso28871565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 17:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733188946; x=1733793746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPUytPs4xOuYgB/EnXxQxcKY3Ggm37SPyVhQ2/dO7hk=;
        b=Gz3PEpeFsg0C7NvQRX9hTEVYXoX8p2W3Q9/s0RwQK/9fCMS+9lHrhJweXrcoZUuV4h
         HiSLqV6Bmawxqx4rV2dxT4SQueI00gkUi8vC2xr6smF/qQJzvt120raqJoqLMKvoQwVU
         +fXhdrsqXMHMeImrvEiSXTGuTzcow3v8lSEClmCERiebLfDR4ifw3y+XaTQbh7KO59J3
         Buu1dw1Rf5aPnXHRTatKvm3ZbOUvf1J8glikoAU/mVj9zPkvPdXkCILy6V6lX4OsB1AW
         sPyk2GEcMuv6gGPOd+I6EzKxuRb+9XoCM7/ggiCwzdO/jgLfnmGEiCfAwCO6Du4pkDYn
         04JA==
X-Forwarded-Encrypted: i=1; AJvYcCWCRvryo9k9eWTxzxj3SBuh1mvMAvTvTEuSBet8mx6nqLXl3duPQDQpY29qNp3JX/vPsZ+JJBHXkXw2g24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkuu1SYvsKzI2/keLSvnWxlyGp56b3pwpYOTxG/k7d1Yv9s9ey
	Muj3edNXVvZwTSX4XYZdShV4V70Y7q3LVNdrwmPqAlSIiHpqoAPW0EHyOz0MYRX3DFr8jRdDdOr
	JxL5rLqtrbwO+buptCJA6tfB+6nS7xUXz8fBkVxu9r4ozQ7GBfZ77+xX25vCw0+zv9eONQw==
X-Gm-Gg: ASbGnctM09PaIwtzLEakjJp2c/qK2/zA7mYr/Cmbcgw7VreWQt5asq+/V9P5satS6yC
	J/Z2oHT9s3I2IIQwkLtipVLE0m1clJ6kABAgpvh4DyrtqCPq/zkU9JtoDeBi+leMTupaAW+RpH+
	Ba1LfocHyIHFDvRP2MbFVypR+UbAlvrooXRcezhaUHiCxsj/qKh4Jy9iBrGSXXzijfRYDIZzb2h
	RLbiL9iFIg7h1i2eXWtP4JW5CZ0fCk6Kr0C/F37CJBOQ3lEfV8=
X-Received: by 2002:a17:902:ecca:b0:215:63a0:b58c with SMTP id d9443c01a7336-215bd24bb6fmr8484125ad.46.1733188946357;
        Mon, 02 Dec 2024 17:22:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBV6VFt7DuoJL3pKgqlDpBzWxmRBzOP6uqWUIOrzw83q0XzALRysgqcdQWq3lT5Z+Y++WC7A==
X-Received: by 2002:a17:902:ecca:b0:215:63a0:b58c with SMTP id d9443c01a7336-215bd24bb6fmr8483965ad.46.1733188946066;
        Mon, 02 Dec 2024 17:22:26 -0800 (PST)
Received: from [10.72.112.107] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21538ecb0e8sm71320085ad.63.2024.12.02.17.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 17:22:25 -0800 (PST)
Message-ID: <2285bc57-bd9a-4696-ac29-73bb233c9b3e@redhat.com>
Date: Tue, 3 Dec 2024 11:22:19 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: rsi: Add automatic arm-cca-guest module
 loading
To: Jeremy Linton <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: steven.price@arm.com, sami.mujawar@arm.com, suzuki.poulose@arm.com,
 will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org
References: <20241203000156.72451-1-jeremy.linton@arm.com>
 <20241203000156.72451-2-jeremy.linton@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241203000156.72451-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 10:01 AM, Jeremy Linton wrote:
> The TSM module provides both guest identification as well as
> attestation when a guest is run in CCA mode. Lets assure by creating a
> dummy platform device that the module is automatically loaded during
> boot.  The TSM module will be loaded by udev daemon after it receives
> the device addition event. Once it is in place it can be used earlier
> in the boot process to say decrypt a LUKS rootfs.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/include/asm/rsi.h                    |  2 ++
>   arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  8 ++++++++
>   3 files changed, 25 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


