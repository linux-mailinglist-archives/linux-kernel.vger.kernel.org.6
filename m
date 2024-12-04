Return-Path: <linux-kernel+bounces-431906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC09E4519
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CD2BE14CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01F4216397;
	Wed,  4 Dec 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgDi2Eo6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3390215F74
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333026; cv=none; b=j+00EHYUyDvrUwF0mOt9DKRGXT0vbHh2WvrCTxfxLCq/Zo57/efrOOLb0Za6CZLuN7YnOJSx195+Ib+649oajwTyHKVx/3nMWJ5WAXz+72kiKo5VZ0Hetowi8lwyph8ZP4r/m/PxyaDs0WLNL/1MedzCcm0DlDKK//NJjYxindc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333026; c=relaxed/simple;
	bh=LwkbNda0AlATuKv92PCUl9fssZcwlhvl6lk9Xi8KPC0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B74hYM2RaydV3/6XsxiCafzRGdAi6gTKPdDkjx1/TlXeznjr8CJWE1yREhOuNDWzqEc3G4xVSfV2N/mXnK9t8kWa3CQO8u1eaUY/dGoBkmJr4eWuuRHXYQ8cqGnqgS2pz3GcYWVcNPeNoYoJFbMaoJbZ7j8cWOGDlqjk4ynZieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgDi2Eo6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733333023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+ZWNY5P+zt/m9IpnbkyDiy2zbCyQCf7Gakg1s0kGOs=;
	b=cgDi2Eo6gx0Dw6Lks2YlVMH1gyDu+bgFMunBfDaN0WZVsoJMIAhlaXNUHAOJ6wya8lfKon
	b9p8PNkQslovGVR4ykbgEcSOEM2nRD8ZTt7wvqAzjDL6A9Aadb768d1+8Yg1qZNJnUkbxo
	CHB2Jqz9EglG7V3EolRVlAe6UJHoksY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695--bs5CNviM7OrUuYCBLKSug-1; Wed, 04 Dec 2024 12:23:42 -0500
X-MC-Unique: -bs5CNviM7OrUuYCBLKSug-1
X-Mimecast-MFC-AGG-ID: -bs5CNviM7OrUuYCBLKSug
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843dd952aa7so685348039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333022; x=1733937822;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+ZWNY5P+zt/m9IpnbkyDiy2zbCyQCf7Gakg1s0kGOs=;
        b=YmGDvz1ADog/6IYUDCFaKo6/Ez32+kJoh3Kd8L6OMxufP/cPWOKXQ3Xqa5ZCa9WvCw
         iF4VdKIfoxGVEp668EEBC964MbuoV3Ae2cuXRvtmptdXvKs/nqfrgSpuBd0Fo7ozReYM
         37jtEm5ES5B5zMdwvyb08Ir0uROUKhP5/8oO+lkKPRPHLNMiyYBfrn/Cci1R4i3jsXwu
         WCO8BoqwbKDVXN595GRD2Y80rH09Dng4AYORfx3jUyrm3Uk3mPi7eyOR+QzSKRPZy96O
         /KvbAG2ANC+4xfrMJtyxYt6OjXz4qws5XoY84pNlFhuvy6GOKig39jiLY0r9r5SfF6zm
         vdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS633BZpoNvxzAO30sN+DWdohWXiq7vsvsiny0rVc1jjhdfVwqV0YP5sVmunFSNOjtH7VLwLPwmj63gto=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4ArVJP/8455bMWGgt5fCS8DtTrrVhYTQx5yGrrK65ZDHsQWk
	aI1CULUN3rGUa6if1CcRT8xMJSIfIhloCkoW2cG3vsxXEN5ZLF2n07Ox9Bk2XKjL6K8DYta+FiT
	FvCqAvf+cEuQOLmuenNSFautUAotWlbMISt6hlbLTtBY96mm34Ql/sbRVnvwnlg==
X-Gm-Gg: ASbGnctMm3DMFrrfT0Z5+e2CfqlLUJIXTEyqm9YhCp3aNEySx/9f6JaJrAcQ5OXzQCN
	TX+qO2FT8UsuavRFW7d9F6ac05rpzPhsuBfGY47BEx3tyBQuE9rSNci55m1GTpgJYQX5bRThotT
	d/qYbKiGZ7qh4ZR90r91Ji+Js7aUF+5kMujJh0QjUN9l9qo3Nphvqr6wtbWpiZkKbnKvoJW4aCq
	9puyivWdlUgMYjdAN+fPye4wQEUCNGQ06hrgXzC2kgdTYk188dhR3GCQAWnFr8o1NcU9M1okH1t
	JQlvHhWML7RuGvaP4g==
X-Received: by 2002:a05:6e02:1a02:b0:3a7:c2ea:1095 with SMTP id e9e14a558f8ab-3a7f9a372a3mr99589095ab.1.1733333021821;
        Wed, 04 Dec 2024 09:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+bmsL9CiExMkiA2aNU4XX84GS7OBhKPMa4IBKLMTVEEm3liyKRUGm+iI89XKCXh2DTz0Q/w==
X-Received: by 2002:a05:6e02:1a02:b0:3a7:c2ea:1095 with SMTP id e9e14a558f8ab-3a7f9a372a3mr99588815ab.1.1733333021550;
        Wed, 04 Dec 2024 09:23:41 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7e2d06013sm23149985ab.13.2024.12.04.09.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:23:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com>
Date: Wed, 4 Dec 2024 12:23:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use it
 in nmi_shootdown_cpus()
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20241203150732.182065-1-longman@redhat.com> <87h67jsif0.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87h67jsif0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/4/24 8:10 AM, Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 10:07, Waiman Long wrote:
>> +	/*
>> +	 * Call the emergency handler first, if set
>> +	 * Emergency handler is not traced or checked by nmi_check_duration().
>> +	 */
>> +	ehandler = READ_ONCE(desc->emerg_handler);
>> +	if (ehandler)
>> +		handled = ehandler(type, regs);
> Shouldn't this just stop processing right here?

Yes in the case of crash_nmi_callback(). I suppose it is a no-return 
call. As the emergency handler is supposed to be a general mechanism in 
design, I don't want to make too many assumptions of what will happen 
when the handler is invoked.

What suggested changes do you have in your mind? I do make a minor 
mistake in the functional comment that is reported by kernel test robot 
which I will fix in the next version.

Cheers,
Longman


