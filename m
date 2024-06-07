Return-Path: <linux-kernel+bounces-206044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2671900393
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2111C20B9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C667194A5F;
	Fri,  7 Jun 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AO+G4K1T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0C194A49
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763313; cv=none; b=OAapIENxR/VRGjFQvem2QpI4gMcS0YHcxJVj/+rkwR1T7ETjGUPWpxULVySOI1hh6+bk/gFB5xTp3vrC6pWU2sCYfNqZfRQ5dijJGRj/Lnr6gF+7VsDxBJeFMUp3zrYnBm2yZZZ6QBXDnz/d8/ZxS1Y6NGyFr2rx8nTc5/ExHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763313; c=relaxed/simple;
	bh=jtFMpYBXTKwIn9TmGLRQUSYPmImRTFr8n8rOPMFw55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwZdpvKzxJmAYrPgBsJ5Tgd7YxWXsimNItvbHVnYRpnvlslu1KHYqgJg5k9OF2iz88wqUTJt5a1h9rIc1UlCxwhauWGvbQwx1fWCn9DMj91Oju8L+pqB9RCeushE04jconViTnb5JpHlzulZq1tccr+qTc2TOEtb5Bzo+f+hgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AO+G4K1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=He3juNVz7+g3hFu6GqowX6vOVAQdnb+Nrnrk3E6C7kg=;
	b=AO+G4K1TKz2gK0R0pqtOFBQX6onHl98wIbPyiRfhHVxxkyFNhUIYy3IoUNP9/mGxz82KKj
	WSmR/Xs2s7evk/LbG+hk2n+E5u9XPiXkGtFhSQil/6GsE74C/WbqLq+0sKhCLORHuotMZx
	h01a/uArvEpTyBGNoLBYyM/Wh0OWQzI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-zYljstsCNx6nRlpZH3Mzzg-1; Fri, 07 Jun 2024 08:28:29 -0400
X-MC-Unique: zYljstsCNx6nRlpZH3Mzzg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70256c09ec7so1831452b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763308; x=1718368108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He3juNVz7+g3hFu6GqowX6vOVAQdnb+Nrnrk3E6C7kg=;
        b=TsHi3qPSrlqHqd+4nl9GDdUgq2am2gW4lbysm9wvgHLXnQHRuTDhNOJLFvBqhKRGHa
         8tBWxbglTMa+drA2O1KFvtAEPR/TB90c2ukHtARb+QXC3Ws+Kq/RzN1RPpjo730b8k5t
         ti8iNVftAT1gG3pDtt+B5c7EzVWHYQJ9597/h2ir4cofP50V9WirQdPbxhjo2zVJj0mZ
         Dxa7APHbJ6bGF39dAeyelAyFLqXANWFGvSMWusjtY1z7CN5bmOTRcbj9MOZNHS2T92/b
         Bx1H3Vhua96di469qR1Zb3bdG+uRsxoSoZV+4IID+f1PxDZ6O9uNPxXaQ4DJZzeV1iuL
         INoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJRKHedSMQGq2a/33ladBkkCGaHsS8V9Gsuad0rGjnowPeymRdlB5CpD3Ue6BuEyuRCGdksCSRXG1WpsmV/qtflk36kkPCE4F8rsU4
X-Gm-Message-State: AOJu0YyM7Bf4PpDmhaWQr/7dRsTb1xLwQdm+0fiqn42UH2ZIBKENFZMY
	iZHpprL8kY6l1MQQHtcn1RxoGgVP5aeG+xL4uVnhG90nVUudCwXq+3TdWKoCWkNuwSuWdZPPYaj
	W7Rz2zplwQdURQtGUeho7CbHZVbPyZglq3rEwD9BIqc2dFR6ic4e/sPrRDHu5pg==
X-Received: by 2002:a05:6a20:5509:b0:1b2:b688:8823 with SMTP id adf61e73a8af0-1b2f9ccbbf4mr2067782637.54.1717763307800;
        Fri, 07 Jun 2024 05:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+eTCa/N3Ta5x54zKKmmxUaASggmCvFDY6W9QdUswmmuERq2DgCNCpJ0Fqi3DwJXnyUNChUg==
X-Received: by 2002:a05:6a20:5509:b0:1b2:b688:8823 with SMTP id adf61e73a8af0-1b2f9ccbbf4mr2067761637.54.1717763307117;
        Fri, 07 Jun 2024 05:28:27 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd530d25sm2478986b3a.213.2024.06.07.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:26 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:15 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>

On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>.....
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> new file mode 100644
>> index 000000000000..78809189084a
>> --- /dev/null
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
[...]
>> +
>> +static unsigned int key_count;
>> +static size_t keys_header_size;
>
>These two global variables seems not so necessary. Please see comment at
>below.

Thanks for the comment! But I think it's better to keep these two static
variables for reasons as will be explained later. 

>
>> +
>> +struct dm_crypt_key {
>> +	unsigned int key_size;
>> +	char key_desc[KEY_DESC_LEN];
>> +	u8 data[KEY_SIZE_MAX];
>> +};
>> +
>> +static struct keys_header {
>> +	unsigned int key_count;
>                     ~~~~~~~~
>                     This is the max number a system have from init();
>You can add one field member to record how many key slots have been
>used.
>> +	struct dm_crypt_key keys[] __counted_by(key_count);
>> +} *keys_header;
>
>Maybe we can rearrange the keys_header like below, the name may not be
>very appropriate though.
>
>static struct keys_header {
>	unsigned int max_key_slots;
>	unsigned int used_key_slots;
>	struct dm_crypt_key keys[] __counted_by(key_count);
>} *keys_header;

Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
maximum number of dm crypt keys 2) we only need to let the kdump kernel
now how many keys are saved, so I simply use total_keys instead of
key_count in struct keys_header in v5,

static struct keys_header {
	unsigned int total_keys;
	struct dm_crypt_key keys[] __counted_by(total_keys);
} *keys_header;

Hopefully this renaming will improve code readability.

>
>>
>
>> +
>> +static size_t get_keys_header_size(struct keys_header *keys_header,
>> +				   size_t key_count)
>> +{
>> +	return struct_size(keys_header, keys, key_count);
>> +}
>
>I personally don't think get_keys_header_size is so necessary. If we
>have to keep it, may be we can remove the global variable
>keys_header_size, we can call get_keys_header_size() and use local
>variable to record the value instead.

Thanks for the suggestion! But the kdump kernel also need to call
get_keys_header_size in later patches. 

-- 
Best regards,
Coiby


