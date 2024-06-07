Return-Path: <linux-kernel+bounces-206041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72862900390
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB891F2869D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BF1940B0;
	Fri,  7 Jun 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKm5P7hd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C085194097
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763292; cv=none; b=Tz9N33I+nzyAVpT6bi82QF9i/r1dGFLCHYAtcl9TxX4/HhnTpN2b+AhNf9L4fsG7aITXDRDPNtniLFONGc1vh8vdOIY9c41NEqw0KLlXWZIkRDIBoRWepflJmI1A8Agwft15wekyH5fqit31zAMfkryF/D12VvlP8Le1TrR0yII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763292; c=relaxed/simple;
	bh=GMrr6nUMi/32NxSVbNrqOi4PCeiSQvRtYMkKzAHI7Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me6mcbJhJ85XHkh7SThHTFbiw8aDnIuWtOZHYUT+4pwDFsvzZklVR8VXKtvHQDx27US0dd/E9JqMgxqEBsSvYCTbE9FHx0fcQ2QvbwgTuK9CKAOCRO/PfE4EdZlI7MJT9Iqe4inJKRzbg/AfqqrFbbTbg7Dqtp3Y7gDgoKzwQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKm5P7hd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ceg3v1XYelnaOfRo7wOTHj9bzW3yT+c0QEYcp/FF1E=;
	b=MKm5P7hdo+Smuld/EqGuISvYcaf62Ke7mKHRGrtAJGFZ/h6hpwdKFnER02yTD9nl3KZ0Qv
	4+lkBWqAwBcKwp4oUruSuENonqy/0MKTpH4JTCmVWta2Vf82+ajDsjehJql6Bn3+Rwy1Rh
	07eyJuIfoAxBGAJ89l7H0mbTaODF/fk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-F-mxiniEPAeZDemOgbgNEQ-1; Fri, 07 Jun 2024 08:28:09 -0400
X-MC-Unique: F-mxiniEPAeZDemOgbgNEQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5ba793ceccaso1795719eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763288; x=1718368088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ceg3v1XYelnaOfRo7wOTHj9bzW3yT+c0QEYcp/FF1E=;
        b=QQ9DnDBLDwfYU7elhRbeBw9icd6OAaWFzOaL3XXljPMRTM1+iFueGsPNxqaq3GEHcG
         wXk5zv+t2k/7ZKvUOgyfszZSksmL2TCg9hF+2Sz/4TyzgVR+GfBXOCFq8xXgwLYzIxHU
         d8iPz6+xKUqtQkJwhfUsDdD1KuLwr3+e+dNATq4DhBXvTBkUxdURRqF8ZFF6SgRT9OGZ
         Am5hGgliHA45FiUdZBA3RNckEXeJNxstm+8YVeBQBKLXbX55CbV1I+AcHqcekRgim4jz
         wNSXt4p60FmdYCedY0Wi6Jex9Og3VHgFbM8tUZYSU5tvUU49Jfb+69SSqpq8ezuhGP77
         +dBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPcHb4OTTWyQ/OtP/EBueNfDmE5vbRLI4OEgQ77k5ByQD4Vswma2oI+6wg8EaggpMA3v1T5jN1U/fKur6EI2cNQO0DbmZOyfH4uxiQ
X-Gm-Message-State: AOJu0YysPxfRdZqqmwFCw1C3PIRphtVxqhbXwXjKy6ncbfaSU3XbEy53
	X7+Op5XMS5C+vq+1YPNoZr5FVmxaQzW7yKtPFZUpSMU69rRSZeJ2X5Yq+ze7IMcM6sjTlFGYyDT
	6hCBvVpMM65hmrngNDksPlm0ZR53mngbCfcEkVaC/jGe38BfkiuxDnMx1fB3FeA==
X-Received: by 2002:a05:6359:4c98:b0:19c:548f:8064 with SMTP id e5c5f4694b2df-19f1fd06a38mr299962155d.2.1717763287633;
        Fri, 07 Jun 2024 05:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCk2sIvJKjLhFdiMz1GzjMHjxQ6ETEhpu27Fo9gLowYjF+aM/kNNWu4JIRiindyHdJ+cdRyA==
X-Received: by 2002:a05:6359:4c98:b0:19c:548f:8064 with SMTP id e5c5f4694b2df-19f1fd06a38mr299957655d.2.1717763286830;
        Fri, 07 Jun 2024 05:28:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e4532507casm607768a12.62.2024.06.07.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:06 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:48 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <v23pityqahr6tgkhnfjoloqwhxcef23i6xjvpb23qbql5rq436@3baoli7d5vta>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-2-coxu@redhat.com>
 <Zl7FLw+YrFN/blA+@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zl7FLw+YrFN/blA+@MiWiFi-R3L-srv>

On Tue, Jun 04, 2024 at 03:41:35PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> Currently, kexec_buf is placed in order which means for the same
>> machine, the info in the kexec_buf is always located at the same
>> position each time the machine is booted. This may cause a risk for
>> sensitive information like LUKS volume key. Now struct kexec_buf has a
>> new field random which indicates it's supposed to be placed in a random
>> position.
>>
>> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/kexec.h |  2 ++
>>  kernel/kexec_file.c   | 15 +++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..cc81b8a903ab 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
[...]
>> @@ -445,6 +456,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>>
>>  	temp_end = min(end, kbuf->buf_max);
>>  	temp_start = temp_end - kbuf->memsz + 1;
>> +	if (kbuf->random)
>> +		temp_start = kexec_random_start(temp_start, temp_end);
>
>As we discussed before, this need be limited in kdump scope, seems v4
>doesn't include the change.

Yes, v4 was sent mainly for you to review the patches by applying to
latest Linus tree. v5 now include the change.

-- 
Best regards,
Coiby


