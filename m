Return-Path: <linux-kernel+bounces-536382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5AA47EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD5A3B64FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506EF22FF2E;
	Thu, 27 Feb 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbBXR/27"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7222F17B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662482; cv=none; b=iTw5NycBOOL5UEBOaELl1HH5LYeE6FJCZ/kzgmLcynOjZGxsixt7+sej30kZVj+7kFjD5kZNAtmKKTQfSIwWhqxiQARft4j7fi0xS5yHLEzxgWSQ3HcF+M4tN88cZC8BZ9NlazYKiqNPrqiFEXypNUY4jBwuNSCKQx7Pt+69z2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662482; c=relaxed/simple;
	bh=4/oM/SIFPmKVKkI4M6R4PfrqtrObp2kZJlU3j484Ca8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piQAWao2cKAQBYxK2c5u8uG3w2FiTduBIbCLcmrTMh5Riz55XLn/jtX6cZL4OW/Te2Ukh8c0sMiW14UJTYLEFkuXZvslfMRS482ktraIYjhfWfo+jo9us05yJV0VTiVKE3SmDW0hr+oz8RWIGPCzMvQUVijKU1l7IvdaC3g76QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbBXR/27; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740662479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g03yAf4l5F8h1WORiHCVOwuwaIh4if8iQdl0nCBRXg=;
	b=EbBXR/27vMhxnoh0hPEHiLLGgOjpjkRS0bQFmhrF46Qe8zWz16mBCkxWtxqlEDBWf1yNN2
	2HH4FwwUk20lmG8p8muCqMoKlBnAwAGMI9RcFIfhZ4g1Q9pK7vaPyIWblExsf4OBizzgdp
	PAwQoqkBvdIY/M6KWn1NSMlHaqYdK+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-OAdfW1YCNtec6C1Mdmh5mQ-1; Thu, 27 Feb 2025 08:21:17 -0500
X-MC-Unique: OAdfW1YCNtec6C1Mdmh5mQ-1
X-Mimecast-MFC-AGG-ID: OAdfW1YCNtec6C1Mdmh5mQ_1740662476
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f34b3f9f1so612150f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662476; x=1741267276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g03yAf4l5F8h1WORiHCVOwuwaIh4if8iQdl0nCBRXg=;
        b=Q3fcFr5V3V94onbosMixa1Z5hIHdP/7ozIHAH5+o83jAvCZTxShmwq3o1YXKD+owg2
         yJHejMI7KLSB7aHDvnYsPLDbDt8pmaHSvDUkuvXur75kcgOMPsN6C6erL5jfZSKwMkMV
         ei40ccsg1yBrC07pzJGxiW0e+HrZ0x2y6DP+4TlH2kn8aaVbUBZhzE3LpEvlwnyCMf3g
         EOb5KC8HuBHIaTwrfUEciTaNudZJaW47cn5d4qzpn064D7eYvWJX93iWokJyGgdV0yvF
         R6X3be9s5/OZ0l7cgsbZiQjpSXFBYmCqbHU1OJ6IZRrLicL34pxp/ReW/jC4ur2YdTqA
         5RZA==
X-Forwarded-Encrypted: i=1; AJvYcCVYpXkWR78ThtjhJ2AMTbL4PC5FYwWPaLkNxTRtOl3w3ZD7S+FX3Cgz2zhertuAD++XrmJXAH+UgsFt7Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WDFsP+jQkJ3YhT++02jdef9zkfJOF29AKfEo0GMhybTBN4U3
	Lnm2uZoAJKFtixsknjoZSOCvI36DXJqiDiWR2rpQ8zfkcBwTtNTIkyEhhFjihaja+BPSJA+bCBp
	lXXa5BqcexgWyqpzegl1Z/j6rhpMrKjcCMDlHfAv3Q+yl9gR+oLnREypDGllOmA==
X-Gm-Gg: ASbGnctg4CjEiRvfHipQLi2zRAAerxe4mrH3MS/pqx55bpRMW1fGY+I+06I3VD3mh6b
	D4CKSDBsWZqjbyF+tAkDO1EkzewdZ7f9O9xXejQW6NaGpHTGDRrZfe9K9snn3Z5C6+4bXPexii5
	muOygcACTvCOSnaZSU0dFRChOjbbOAyyMfIgEM/jOJ9lFmwbTnJliK12hHXdq/7kd4Ys2ABT2Z1
	ALW+7cPoFaJj44p2MGMOSCYyPQc1eszInUQwSZls0IZ2BALPgURs4eciG4TuY7ZdJbkOldwd7kV
	6oDtVYDqQ4i242S7MMj4dbtnn93PA/P9wnByiYFBq2nXPy4tMTmXwWhmJ0gRSOs=
X-Received: by 2002:a05:6000:1fa9:b0:38f:4fa6:bb24 with SMTP id ffacd0b85a97d-390d4f8b44bmr6722051f8f.39.1740662476243;
        Thu, 27 Feb 2025 05:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9t5CiNJn68RP1oVWTt+sQVksw+R8XH3ts91h1zl+/D1v9evidsONkhXfH4w9mAtjPHRcpsA==
X-Received: by 2002:a05:6000:1fa9:b0:38f:4fa6:bb24 with SMTP id ffacd0b85a97d-390d4f8b44bmr6721993f8f.39.1740662475792;
        Thu, 27 Feb 2025 05:21:15 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c43sm2009977f8f.49.2025.02.27.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:21:15 -0800 (PST)
Date: Thu, 27 Feb 2025 14:21:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Dongjiu Geng
 <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 19/21] docs: hest: add new "etc/acpi_table_hest_addr"
 and update workflow
Message-ID: <20250227142114.350e4cd7@imammedo.users.ipa.redhat.com>
In-Reply-To: <205abbc22ce816d88aa6c1c7058607fe35aae1ea.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<205abbc22ce816d88aa6c1c7058607fe35aae1ea.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:49 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While the HEST layout didn't change, there are some internal
> changes related to how offsets are calculated and how memory error
> events are triggered.
> 
> Update specs to reflect such changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> index c3e9f8d9a702..f3cb3074b082 100644
> --- a/docs/specs/acpi_hest_ghes.rst
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -89,12 +89,21 @@ Design Details
>      addresses in the "error_block_address" fields with a pointer to the
>      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
>  
> -(8) QEMU defines a third and write-only fw_cfg blob which is called
> -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> -    for the firmware. The firmware will write back the start address of
> -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> +    where the error block offsets, read ack registers and CPER records are
> +    stored.
> +
> +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> +    contains an offset for the beginning of "etc/hardware_errors".
                   s/^^^^/GPA/

> +
> +    Newer versions place the location at "etc/acpi_table_hest_addr",
                            s/^^^^^^^^^^^/GPA or address/
> +    pointing to the beginning of the HEST table.
> +
> +    Through that such offsets, the firmware can send back the guest-side
       ^^^ see my previous s comment on that

> +    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
> +    a single WRITE_POINTER command for the firmware. The firmware will write
> +    back the start address of either "etc/hardware_errors" or HEST table at
> +    the correspoinding address firmware.
                          ^^^^^^^^^^^^^^^^ what is it?
perhaps it should be "fwcfg file"?

>  
>  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
>      "Error Status Data Block", guest memory, and then injects platform specific
> @@ -105,8 +114,5 @@ Design Details
>       kernel, on receiving notification, guest APEI driver could read the CPER error
>       and take appropriate action.
>  
> -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> -     find out "Error Status Data Block" entry corresponding to error source. So supported
> -     source_id values should be assigned here and not be changed afterwards to make sure
> -     that guest will write error into expected "Error Status Data Block" even if guest was
> -     migrated to a newer QEMU.
> +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
> +     when a SIGBUS event is triggered.


