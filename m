Return-Path: <linux-kernel+bounces-427208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7503A9DFE12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375F0280F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7A31FBCA0;
	Mon,  2 Dec 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afrSt0j0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E215A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133919; cv=none; b=CwZ1M+/JjLDLoL4Z64uUWQYYTJcki58z52dQ5NGWXiEKQXOWrxzH/lNxe1ogdpJmZvCFeJMQbrwoZH9XAlIGF7Iary/KFXFsYOdD/CQxF+ywfVIDKvl3K3LpOcg9WgmmQ6QKUL3WbPLpbZTe55p2XHjthIdR4e7HzLhvr4JZiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133919; c=relaxed/simple;
	bh=CFokUjz4OzXkYfuCMx3mFfBTch+bmlT3hb3prDvegrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeUWPvTbl64A7rHR2RLNkXQLXSTk7ucZLwcuN6E9NIeqhDuqWgE2eRi8w4WUU8OxQUzfFzNOrsoMMYk3XoYBaQD69JLe4loSlv7nCUe1r80Zu6/KIJraRLrzc9549+YuK/DcZNyRkx/oK7rL8F8Rk8+g5jWGf93FMkke7IddOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afrSt0j0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733133916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OrPaqjsbcgeweoMhNllMsBWtFbTQTtneD0XhvQpzBI=;
	b=afrSt0j0nwl/JMxXwuFT3XpC2MRdCdfWKv6K+tifhbpwl3vCGvF0i7RXMwLlKHtK1vh3o9
	Md87gvCXVn64Cc7lWl9plZXUa/q59xBkHWP5WJQYg7mh3DDMftkdBsXYntP4qpw/e2bRfY
	O5fTLAJn00b+kGKCk/M1P5DYYMa9/y4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-ih_FwoNhOeykiPsEKzNT2g-1; Mon, 02 Dec 2024 05:05:15 -0500
X-MC-Unique: ih_FwoNhOeykiPsEKzNT2g-1
X-Mimecast-MFC-AGG-ID: ih_FwoNhOeykiPsEKzNT2g
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7fbd9fd86d3so4035671a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133914; x=1733738714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OrPaqjsbcgeweoMhNllMsBWtFbTQTtneD0XhvQpzBI=;
        b=scPfPPs+dybxcYv9Gh78HsSAeVSs69qCe18ScMEGorXPW426PqVs7he4hL0RxmSDuN
         OrOeHn9E2mR5I0phqpjOTT2k0rJ1GmDl57DMwh4QiRsaX2EIZMqTErCJtneMIEYsck/N
         jYItW34eiM7lRgQWfQVRYANRSeEYfVBvXevqbVsHdmp4Iy7YB/cbKj1kgJKM+R+uNu0u
         TqhniNxEY8tWzZiWp4GVHD6skUBbEq9LcXzYyCoM4sXTlgEeg6llkFqhinJIRFDiRp7M
         hduY9UyhqPA9nnO6zuKiePojD3zhg2RXfGCVnT6/YzZiTQLQbSGoW7XbF0ZjJgysRFv3
         KJug==
X-Forwarded-Encrypted: i=1; AJvYcCWKFD6ThFTVMkv7lA9qAhl51yeBs0DrMm+4jVwV0V1WaUgUfCEVz10HlFiFYnqGVsSjkQby+GmJC+zaoyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3wD9/Ak/RHopFLYLM8txKDHe1rz8iS4E36BqKR14ioKXNL6l
	yuz5Z5zhgqHXLftNRSMhxLLvzipbC9E4bweLdnizS6Aod0+SDUu2V/7gBcjKbUN5hWrUA/AWsWW
	4xEFmpErtaYVXKFJcYy5B00rgw1aSvD15XGKuUVnli+P3d4IW1FCRsZB3uVv1aw==
X-Gm-Gg: ASbGnctLxOt8fZCoEJhzG7Og18HLCBpIMdc7mL3QQDCt21/icnT0yp4aPsOh1czaUiB
	U9Xi4UkORTTV6tYgdWFAzTog0Pb6J4Rjp9WP81jR53ny64lApJctWdtCF+0adgOw+TqgfFRaaKz
	f5VRgkgL2U3GLsJGCE/68af/Iqx/0O24of9TVvJPbx8JpFi7ApBfSRmKNdAw9ZhDK8M9kMjdu7b
	nuW4CryObE5F6Hgh3gO2/7LQbYDbP2R+/TyGociuQ==
X-Received: by 2002:a05:6a20:741f:b0:1e0:b319:fc05 with SMTP id adf61e73a8af0-1e0ec83cf22mr18681092637.12.1733133913958;
        Mon, 02 Dec 2024 02:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB3NSbvHNFkIbyngZ4ixvt1XNNHTdRsVlMICP66j5qS+PJTaT9IAiRRpmMF3Ih7NXyt+N12w==
X-Received: by 2002:a05:6a20:741f:b0:1e0:b319:fc05 with SMTP id adf61e73a8af0-1e0ec83cf22mr18681064637.12.1733133913634;
        Mon, 02 Dec 2024 02:05:13 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d4946sm7438932a12.14.2024.12.02.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:05:12 -0800 (PST)
Date: Mon, 2 Dec 2024 18:04:58 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v6 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <ry7sz5vcsergpc7cux2eotoj7eid652dw3fqrivhq3vhsbv7fo@vrinjqre7vbt>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-2-coxu@redhat.com>
 <Z0kbMm0HCZQcD2bI@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z0kbMm0HCZQcD2bI@MiWiFi-R3L-srv>

On Fri, Nov 29, 2024 at 09:38:58AM +0800, Baoquan He wrote:
>On 10/29/24 at 01:52pm, Coiby Xu wrote:
>> Currently, kexec_buf is placed in order which means for the same
>> machine, the info in the kexec_buf is always located at the same
>> position each time the machine is booted. This may cause a risk for
>> sensitive information like LUKS volume key. Now struct kexec_buf has a
>> new field random which indicates it's supposed to be placed in a random
>> position.
>
>This change the generic code, but you don't mention this only takes
>effect in kdump case, won't impact kexec reboot case. I got this from
>code, while this should be mentioned in log.

Thanks for the reminder! I'll put a note in the commit msg.

>
[...]
>> +
>> +#ifdef CONFIG_CRASH_DUMP
>> +static inline void kexec_random_start(unsigned long start, unsigned long end,
>                      ~~~~~~~~~~~~~~~~~~
>This function name is very confusing. I thought it's a starting to
>randomize at the first glance, then realized it's to randomize the
>starting position of range.

Thanks for raising this concern! I'll rename it to
kexec_random_range_start.

-- 
Best regards,
Coiby


