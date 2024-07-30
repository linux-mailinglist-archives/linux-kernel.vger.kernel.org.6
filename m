Return-Path: <linux-kernel+bounces-267129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD7940CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828A61C220FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150061946DC;
	Tue, 30 Jul 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqeIWJVt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE9194099
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330404; cv=none; b=eHdmwuqycBgOhvEHs0DTDGXh6ZMH2ZysTrvYhW8M0mMtYcoaexl8KVsA72KWPFkADf6LPVT+6CMyIQ3mreJPfZxZCpvmFPuZ69e+X2i4TQjXFRlcF3Cb/2dXZbQ2gPgQrUmJdqlW3qAInipJddATH8JZWFzWIdRf5zs3eGQEcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330404; c=relaxed/simple;
	bh=QjRmS85wZqkU1AN0FX7WxfEC2oAZFQRsNmwjnjV8QLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKnZEUgOcuY/zJImmlnW/b9O4HQBbhzaX5iyOqjQvIHEPnVFfQeqLqyv5/eKJtuCApaTft35kvaUZspbBqY8UZfGpR4pAiMAr5GM4NuJvFXblL+vT8pjvEotdZDZfNnkaK7HvI1jiR8+xeVf+KBbP8JV+gUqQ3KLZdckosZ4FbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqeIWJVt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722330401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxxeyuA47wcjNGA3mvbjeqTm8nQHqWeitUh19HMLyPI=;
	b=KqeIWJVt2SycGizAoGmZ4vg6DMYO113CYjjm64aLQUH9b70Sz+4ZAnXUNLmMP91lOnfYRT
	C412GWEEswO+3clAAa7aSzP969/wRHSkXWI8ds4KdIoWXM1P88NP2j9O6b1V5rMSg6Tk0N
	xEiUU7f/dGCbaYPpiCPAr3BsMnChAPo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-EGwznhBEPNSAgJ1dCPw_nQ-1; Tue, 30 Jul 2024 05:06:40 -0400
X-MC-Unique: EGwznhBEPNSAgJ1dCPw_nQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428087d1ddfso6199045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722330399; x=1722935199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxxeyuA47wcjNGA3mvbjeqTm8nQHqWeitUh19HMLyPI=;
        b=N9aRCRlxwM5KjrOmpo7oF7j7jl5Dy9jDj9pAhPmUqI2ekZ7Hur4A7x9c1qMEn0zbEM
         4QcXg/+8o8SfYT8nXfiXRqQ6R9mkQ/2RGFHtHzoEuTAEA5voSz5UvE3Mmd2e7nvlgtBG
         ZLfE12+2NOcpNqAh3Exle5UrmE/3Rysjiz5q3/YnmaYlPjycohjBX06luj3DMKbkIGVa
         ie/awo4rKQ38kesJrlCnhlC3X3JV2a5sC66bAh+qJgzpei5FuC1bbYiduOvD7fCVyFIx
         m9Ml/2xMPu+RkdGWYVgL1325UROiACjv0abI8/tMmjl4yU8AqAM/jLtZj1cTanPJA3Qh
         cNvA==
X-Forwarded-Encrypted: i=1; AJvYcCV9F4RLTEIpP+l9yItIZEBjYArfoDRRU7Yc+BGEFA7heTZVqJIQlKf1Kq1q7AxcaSPhOG3wcYKbjxEy/hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIo3kK2hGhdF9jmMgnZrn1Po7ko4NEaRhMojk/DY9MAtKKs9HY
	nluHel5eazXW8SSByP+5noDFmk9j4Qd0KeYifE56UjhhGlNAFdlJOl/tyTZYUR8GsBRkfE7XdED
	byhazQ33HqiFM5WU7I5EWoH07/KzLGdmK7vM0YHXwLmHqMsjGxP//down8gZM3g==
X-Received: by 2002:a5d:59ad:0:b0:36b:3394:f06f with SMTP id ffacd0b85a97d-36b34e4dbf4mr7334918f8f.5.1722330398944;
        Tue, 30 Jul 2024 02:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmp7LztHoixicCdrLrICu3jCeZd6QkYLefYMR8c0hp+YRMZ0zkEGKJf4kGg2JSs1F38+yLUw==
X-Received: by 2002:a5d:59ad:0:b0:36b:3394:f06f with SMTP id ffacd0b85a97d-36b34e4dbf4mr7334901f8f.5.1722330398454;
        Tue, 30 Jul 2024 02:06:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3686f73asm14032119f8f.113.2024.07.30.02.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 02:06:37 -0700 (PDT)
Message-ID: <35c918f6-1919-4597-9113-398d5c633cc8@redhat.com>
Date: Tue, 30 Jul 2024 11:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net-sysfs: check device is present when showing
 duplex
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Decotigny <decot@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shigeru Yoshida <syoshida@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>
References: <85228e43f4771609b290964a8983e8c567e22509.1722211917.git.jamie.bainbridge@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <85228e43f4771609b290964a8983e8c567e22509.1722211917.git.jamie.bainbridge@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/29/24 02:12, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal, attempting to
> read device state when the device is not actuall present.
> 
> This is the same sort of panic as observed in commit 4224cfd7fb65
> ("net-sysfs: add check for netdevice being present to speed_show"):
> 
>       [exception RIP: qed_get_current_link+17]
>    #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
>    #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
>   #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
>   #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
>   #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
>   #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
>   #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
>   #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
>   #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
>   #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb
> 
>   crash> struct net_device.state ffff9a9d21336000
>     state = 5,
> 
> state 5 is __LINK_STATE_START (0b1) and __LINK_STATE_NOCARRIER (0b100).
> The device is not present, note lack of __LINK_STATE_PRESENT (0b10).
> 
> Resolve by adding the same netif_device_present() check to duplex_show.
> 
> Fixes: 8ae6daca85c8 ("ethtool: Call ethtool's get/set_settings callbacks with cleaned data")

the patch LGTM, but it looks like the issue pre-exist WRT the above 
blamed commit??! possibly:

Fixes: d519e17e2d01 ("net: export device speed and duplex via sysfs")

Also please explicitly CC people who gave feedback on previous revisions,

Thanks,

Paolo


