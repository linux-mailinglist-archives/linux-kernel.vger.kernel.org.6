Return-Path: <linux-kernel+bounces-436422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC2B9E85B3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5FA1884C87
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03033149C4D;
	Sun,  8 Dec 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhc1fB/e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED01149C54
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670031; cv=none; b=ZqNAHc2ZN+5PIqZHxJlhHOlrL3nzMun2RiJ55JjfQC0oYlaE8f2D6tep6xZSowZRj0UWZS3DU1zqlosfEBju0a7gIdU8/SKqABRjj6kbrLnCFhp1FlopE2KOg5uGjs+sNEqr2VM5e/vjgcBqRo4nAoudlYVd5G+HGVU9Fxluksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670031; c=relaxed/simple;
	bh=x4xzx8Lem/mr+xYSR3X0NJEqfiuesy1NtKgKaIcUc50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmQPnznD9g3iCPz7AKgTSJOcGKT8QfyEBdFd/bT8ciFV1k3vsAQrwC+PB2A2+azLbgcIcsBiTlhA3wL2/RvsPcETOumWGhWOqUh1DVtcXvQW/gFveMk2PwSrqZ/WjPQw5jNWK1l5wLYdtaguO7y9rGhfI/hpXEyqckkV89tF53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhc1fB/e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733670026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu/Z0q4Vu60FRoyZ8QJUaDOJZLhSIepY5+9F9q2m4ZY=;
	b=dhc1fB/eSVWxct7w0gEOl18RpnA+WBccaWpzl90lxh3F2QVZcxx+z1vvWZMwla2ifyt6qS
	0zGGSyd2S7pUY15CeST5IPPhv3wO7AFGDR3mKaNhvv+nbSaKObTckVF7bQnc0RkS3T9A6V
	2SjLWjkym4asNhnzei9aYax6O360hhE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ngOus8b7OyyAE0dC9XCtWA-1; Sun, 08 Dec 2024 10:00:24 -0500
X-MC-Unique: ngOus8b7OyyAE0dC9XCtWA-1
X-Mimecast-MFC-AGG-ID: ngOus8b7OyyAE0dC9XCtWA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa638b40b1cso259309366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733670023; x=1734274823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qu/Z0q4Vu60FRoyZ8QJUaDOJZLhSIepY5+9F9q2m4ZY=;
        b=otSQzSHQ3mW6ZFPt9/iP+aDrgTP1cl7ksDzBYZ/okfz9DlyW/JtFtzJRaHwzQrAchP
         QyP4R+8gRW9rzgWE8XchxKQTr80/zBD1l3cSj9voK38bgJxviisoEynQpZl02d0qROTF
         C/4eniAxNtwi901zOP+d6Tc8goIeEIhxCvLvFKpBilefRxCw4PhtsodOk/RMp1MEQOEj
         heRKs+UvRIyeog7AhCWf1L5YbB68KMbZ/3nRPDM9pqgPSUqJhEwuwE1JXt16S2tNPOEG
         dvH8+i6nnTr8yEM7pwCUbMl6cTyPCT6fodEsNpm3l0iATCCdysVBux7kjYO0a+PsyvY0
         curA==
X-Forwarded-Encrypted: i=1; AJvYcCV698GuULFSK+mdTN3i/JGzjYk8ASLvTrX+miVwlfy8ZUIfqplN0+fKxUSwemXhG0DcMYJgHXceO8i4zCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcGCItiCK2PakxG+5cILk+0CIYARq2qdTBSJC8we2ZQZek2bH
	lpLVwQFK6opYRS2eh0FKQoDHWCJWzKsI2+Lyl6XyfsT6Z76WPBlVmk/jhGmj9miBXx8F08IBgCl
	TNvR4ShqJBEY8kyPl+LaXr+PJBG536bGN/JZ0xApR7Z8fMutaTzx4zEuZaDnSqw==
X-Gm-Gg: ASbGnctFdzKC6xU/QSfWcm7L4L3ISwVnKOA3azqWRhK2kNyJZC2ao7cCjrxeisaxzA+
	cpJFwlgP8akGMNNU7PnOkL4+6WoHxE1RqMxmnBFBiko/nPcA1gz5HiM5dcxDDl4Hi4SYVxd8SCY
	11S3D80G59Jxngh92p55fWXTWK0zhW0IqzrokDXL/Jm58BMBPf6LP90tvzs+BxnDSMmM+bEEeBH
	XQamnPmiwChbJqDpGFo28lzslYYiFs8Xrh+qnKV58Yclab6MJJ3ysQGEVvSXs9kg5oo7IkmZ9q0
	Y2v54BA5PVLLuJn2GScqv/QCNlitUr8bBaRxNYYP5LW3l6hzrvBoayoFzCIGfz87mq+VF6e4Ndr
	pk0UIUYThPeQVubtvGQtI8ywF
X-Received: by 2002:a05:6402:2349:b0:5d0:f904:c23d with SMTP id 4fb4d7f45d1cf-5d3be785c74mr12235313a12.28.1733670023634;
        Sun, 08 Dec 2024 07:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJteicl5lVOGTLWA/QxDEB3FVxTTmR63XUkGcLcCEndIriT4eKMacqujjA6xR4kgMop0uLtg==
X-Received: by 2002:a05:6402:2349:b0:5d0:f904:c23d with SMTP id 4fb4d7f45d1cf-5d3be785c74mr12235285a12.28.1733670023219;
        Sun, 08 Dec 2024 07:00:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3f3cf8c6esm903507a12.85.2024.12.08.07.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 07:00:22 -0800 (PST)
Message-ID: <81b7ac42-449b-43be-9bb1-e1c7ba6639f3@redhat.com>
Date: Sun, 8 Dec 2024 16:00:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Remove invalid max_register
 from regmap-config
To: Andy Shevchenko <andy@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
References: <20241204210209.136976-1-hdegoede@redhat.com>
 <Z1FiEuqjwpyW4s3Q@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z1FiEuqjwpyW4s3Q@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 5-Dec-24 9:19 AM, Andy Shevchenko wrote:
> On Wed, Dec 04, 2024 at 10:02:09PM +0100, Hans de Goede wrote:
>> The max_register = 128 setting in the regmap config is not valid.
>>
>> The Intel Dollar Cove TI PMIC has an eeprom unlock register at address 0x88
>> and a number of EEPROM registers at 0xF?. Drop the invalid max_register
>> setting so that these registers can be accessed.
> 
> Wouldn't this break debugfs facility?
> If that is the case, perhaps adding 0xff to it would make more sense?

Ah you are right, I assumed not setting it would just make the regmap
code interpret things as being no maximum. But this does need to be set
for the debugfs regmap dumping to work. I did not realize that.

I'll post a v2 setting it to 0xff instead.

Regards,

Hans



