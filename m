Return-Path: <linux-kernel+bounces-331523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8297ADE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B0C1C21B49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854315B0E4;
	Tue, 17 Sep 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlD/j/50"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678114F9F3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565317; cv=none; b=G9rM2NySfL4pSDGIfsFsQC/c+l1zJh/rS0YCJoJ6VOtT5BWMBlpB9d1/xWYsVULkaqzKpJlKT+1hXhiLiHrHBQ18RbTzT+qvkElnaGaxNOgdKwcGFZoANWipzSB0QnSnDR2WlD5Z7ROncoOuTJB+Xl15PJoSxsZEAiCYf9lbSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565317; c=relaxed/simple;
	bh=cjEYW79XTC4Iu6xUIwM2glc4xAoMLOLjRaHlrOxzPjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdJawvNV2S+pKlf+kezhhGjAfbZSfnlonvuxYGBoy/KGScCs1dWqohpxD4Hz5j+SVRv33m8s08vMAmfB8c7SeY/KCNEJWomglP4dH4xBV9cXoEp9OnK5XeALsj6uUhPJh9T+PWtgTuTrvX6m6c73SrmT0grDWNxuGRgIl/gOyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlD/j/50; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726565314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKky4UPm9uDnWvji516fng+iapLQ5mCU5oI7sv9KVko=;
	b=NlD/j/50xfG+5m7ISiwwqpI0gFy0uStaXJt/3hlkXWJVi/g8lQMW05VkQSDuKNaT/QhIRw
	btTiD9e8BHh6IFoGsGH2DqprGxIXx53+1t3wLY16UmY9tUzMx896sOWuCcKBx4VJyRbCT6
	qXmfKLDhWt93BOKPL9Wnpotec1MHTiA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-K5B__49NPHaMEEupJgfqdA-1; Tue, 17 Sep 2024 05:28:31 -0400
X-MC-Unique: K5B__49NPHaMEEupJgfqdA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb471a230so41996475e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726565310; x=1727170110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKky4UPm9uDnWvji516fng+iapLQ5mCU5oI7sv9KVko=;
        b=IZ9c9OiKaSFup/8ug6R3sqPGzyb99mAOZNz2rS+3Xq5rYkn/dIOAa47h36vVYMDQGD
         OFSQsPRh8s4o0a9QAQgG7yUoNxo5BRtHw38Ksu/w0x4aYiN+nE4ocS2cBzRhcVcRdrOU
         0Y/PongNLE12bkG5CeaeutigOM2HvMYt4vcxXU98m5c0wjFo0djslOfQPqOjlzi3LL92
         Pea6jqqeksbvE4Pd1+rxus08Xf8pybIRiBZL+VW4N7QZ2Kwqg2fnIeq9IoRZswGLjIBU
         mlAz6i55dL8x528TsdwajqcOuTOvCVuC9G9HoqKaElH9ZQA50E7vsvSIZITWa9zzCzOO
         aYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9nm7v3JIWPxmEp41HmB5K+VCsIU8/yhp07wkM+8k/1pzc0KjhoBrN/jlD/wpj8BOg7Lcq/frq7s9yMdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKxU6lhbiWERaJ55PIpJJABo/PIcyqI8QrsTCd53nu6atCwcK
	nQKobNfhNyC6SpNW9vGwiv18DbXoX/KkEykgz8xa6SLOSFWskbj356M9Xjxgi9Z2pgXIb3Bkpdu
	50dGjsa5Sam+03ySE/NqIrwm7lzQ6VuishepkLmeEYp/HdJOz/OD2H1Ler/2PKA==
X-Received: by 2002:a05:600c:4707:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42cdb56dfa6mr147009535e9.25.1726565310181;
        Tue, 17 Sep 2024 02:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+fhU2hQzDjy/E/ZXG2LagaJrZJDNZUK+L06+Bq+ORmLe1kVeMDNQu2vADH2mK7JepZsg4uA==
X-Received: by 2002:a05:600c:4707:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42cdb56dfa6mr147009205e9.25.1726565309593;
        Tue, 17 Sep 2024 02:28:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780025asm9061262f8f.72.2024.09.17.02.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:28:29 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:28:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 04/21] acpi/ghes: simplify acpi_ghes_record_errors()
 code
Message-ID: <20240917112828.514d9255@imammedo.users.ipa.redhat.com>
In-Reply-To: <40b209cf75717796c658b26d0ecd564f63dc8656.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<40b209cf75717796c658b26d0ecd564f63dc8656.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:25 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> if physical_address is not defined, just return with an error
> set.

no need to mention that, as it's what does now.

> 
> That reduces the ident of the function and prepares it for
> the next changes.
> 
> No functional changes.

this is enough to describe the change.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 56 ++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 35f793401d06..17b7d9e10f3e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -417,40 +417,42 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
> -    if (physical_address) {
> +    if (!physical_address) {
> +        return -1;
> +    }
>  
> -        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
> -            start_addr += source_id * sizeof(uint64_t);
> -        }
> +    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
> +        start_addr += source_id * sizeof(uint64_t);
> +    }
>  
> -        cpu_physical_memory_read(start_addr, &error_block_addr,
> -                                 sizeof(error_block_addr));
> +    cpu_physical_memory_read(start_addr, &error_block_addr,
> +                                sizeof(error_block_addr));
>  
> -        error_block_addr = le64_to_cpu(error_block_addr);
> +    error_block_addr = le64_to_cpu(error_block_addr);
>  
> -        read_ack_register_addr = start_addr +
> -            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +    read_ack_register_addr = start_addr +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
>  
> -        cpu_physical_memory_read(read_ack_register_addr,
> -                                 &read_ack_register, sizeof(read_ack_register));
> +    cpu_physical_memory_read(read_ack_register_addr,
> +                                &read_ack_register, sizeof(read_ack_register));
>  
> -        /* zero means OSPM does not acknowledge the error */
> -        if (!read_ack_register) {
> -            error_report("OSPM does not acknowledge previous error,"
> -                " so can not record CPER for current error anymore");
> -        } else if (error_block_addr) {
> -            read_ack_register = cpu_to_le64(0);
> -            /*
> -             * Clear the Read Ack Register, OSPM will write it to 1 when
> -             * it acknowledges this error.
> -             */
> -            cpu_physical_memory_write(read_ack_register_addr,
> -                &read_ack_register, sizeof(uint64_t));
> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack_register) {
> +        error_report("OSPM does not acknowledge previous error,"
> +            " so can not record CPER for current error anymore");
> +    } else if (error_block_addr) {
> +        read_ack_register = cpu_to_le64(0);
> +        /*
> +         * Clear the Read Ack Register, OSPM will write it to 1 when
> +         * it acknowledges this error.
> +         */
> +        cpu_physical_memory_write(read_ack_register_addr,
> +            &read_ack_register, sizeof(uint64_t));
>  
> -            ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                             physical_address);
> -        } else
> -            error_report("can not find Generic Error Status Block");
> +        ret = acpi_ghes_record_mem_error(error_block_addr,
> +                                            physical_address);
> +    } else {
> +        error_report("can not find Generic Error Status Block");
>      }
>  
>      return ret;


