Return-Path: <linux-kernel+bounces-536208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B879A47CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDDF1678C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0D42AA5;
	Thu, 27 Feb 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WefDE7Jd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F14270020
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657788; cv=none; b=Lzt1GE2gkw/bWH6I2Fj4STSTrdK+gNqvalRzlrebkYMLRt3SriD7jxvKryiRwAB/Oq9o1AIfgVE5/CX2kbWEtKD1/FWpq89B7m1bXPSK4Q3Q1ZY3tp9+TgF7MsMsCKbRVltHgtwUIhtgEzRywmUhaB575KTmPDHjl5F5jri62fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657788; c=relaxed/simple;
	bh=NQiCDHbc4sv+CR/8zk750oE11oq5a4gIIvmi+RsiEbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8fYWDyz+x5c5gLqRZUEvXUPZj5i9qQsaTDJFT9EZ/im08/J4lSamXR9SWklJNTeJaXoLO+yS4libx/Hoatd9QxhkcmdaukKXyBD+f/OBP+5qXrsV4f6Yqz5X5ATaSqldfB7GY+G0QKxTsThh+6/CrcaU+Oz76XL72PtbySo8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WefDE7Jd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740657785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5xj3BC1T+wGPDd2kj9+gKjm5LAXNQxtfhll0pXUlUM=;
	b=WefDE7Jd0VtbQSmd2bmud5SQxEic7jWBhNIW6VlGgsenebssU0KulonD38lPrK3+K+0UJC
	LLAXh2FMrwCQiMoehkm0e77FihImfU5QVCBX+fPNqE/M6t6xm+yTTIYdaGEh1UtJvKX6+4
	1c19O+r3jWesTrmQkvY1CpRJjFjPSgI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-fzxF29BJP_yLlJONcnRCIg-1; Thu, 27 Feb 2025 07:03:03 -0500
X-MC-Unique: fzxF29BJP_yLlJONcnRCIg-1
X-Mimecast-MFC-AGG-ID: fzxF29BJP_yLlJONcnRCIg_1740657783
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f55ccb04bso521369f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740657782; x=1741262582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5xj3BC1T+wGPDd2kj9+gKjm5LAXNQxtfhll0pXUlUM=;
        b=w4o7C/V4m+fr0j4I4keOvIL18wJv2GFXQotI3sXsm55LsjcSXDzMuduapROspPO/fw
         PE5QP2LaeEkVbeX1VoR+murCmhptTgZ/8S2qL53GWpF2ZX9Qt0+sc164txp4m4hMpWOB
         fn99aVDlZSek/zp11/Py4CNC3yXrjuKuwkA3AYxKC7b6i4RWUUO99mlBxA7mPUDrzl5U
         Y5Skl7LVg6/9ygsLFCzJzxOw+lJ9/44UUwhdYLs7hyGRSKJRRnlrMsXVadtWODYWkVb1
         cFt6LOHNrv60fxHVI68ZFjLLLwu5cqmlQ117jVSOyP1lwaDY5T/IVDukgi4TEnNduPMx
         5Mcw==
X-Forwarded-Encrypted: i=1; AJvYcCUl4j+yxcaRkm7r7KNTNHKC9g4PqWdblQ6wTSgKN6/QYH8uYf8qYZAAP28oyX3NyNja0Wk/HmFh5kMIwG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWvxxQR6wbn0M8DdMAOdkk/4loPbTME924Hre/ug4xObSMj4E
	ZY9lCF3kxhqqzdF8NxilwDC/ogYLWxjp10TaiVJw/KmmTJ/L9EGD9hqP5p9QWSJ2d3yS+tQrmXK
	ZRs8aGSI+yrbRyrqtm1iDdIYAe/F9sYutBBM8lD+IKKx9WkmEVN5wfm7EJIbkxw==
X-Gm-Gg: ASbGncudpGLzLnRqYBIUabz2xaM3JQt/BN8PYP4qb4UYF3wnAVfu2DykxlD/1c39nlA
	Hg5zCkC1+N/8JUyeUR1n0KcqMWy5NQbdifIrtYL+rRn5LzMTbQmZX86GSxY/YOlhWwXQAqG4YJW
	6Tk1tg+EXhE4crFpNGyusoimvhhbQfdNMNcqQ+7eBohSNkR1H+MxzOx3xEN2LaCswv3v0zCyTk2
	uLVhGqOVSS6+Pkqwda5PoRiun5mpjB9CmqjesSb3iwFohp1twMBQUV3h2qm37eUa43U9spZ4kx3
	4G4qoFuC2BWLr4SqyoWenS3IXvhgli6Te+5mbZbxIVLy+MES3SsXhJPxBtDWWPk=
X-Received: by 2002:a05:600c:5123:b0:439:8ef6:5782 with SMTP id 5b1f17b1804b1-43ab8fd7acemr66726375e9.10.1740657782490;
        Thu, 27 Feb 2025 04:03:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGsmcVRgCFbjb9R4XUkv4ggUO+/xJlQmWBPEfi9kCw3Hg6pcObspvfzXkTMsw8PrznpqnjCQ==
X-Received: by 2002:a05:600c:5123:b0:439:8ef6:5782 with SMTP id 5b1f17b1804b1-43ab8fd7acemr66725875e9.10.1740657782065;
        Thu, 27 Feb 2025 04:03:02 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485ddd1sm1827170f8f.94.2025.02.27.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:03:01 -0800 (PST)
Date: Thu, 27 Feb 2025 13:03:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/21] tests/qtest/bios-tables-test: extend to also
 check HEST table
Message-ID: <20250227130300.607bbc27@imammedo.users.ipa.redhat.com>
In-Reply-To: <3ebde58416b8be1140c569538192399feeccf412.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<3ebde58416b8be1140c569538192399feeccf412.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:32 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, aarch64 can generate a HEST table when loaded with
> -machine ras=on. Add support for it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec43536..8d41601cc9e9 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2122,7 +2122,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>  
>      data.smbios_cpu_max_speed = 2900;
>      data.smbios_cpu_curr_speed = 2700;
> -    test_acpi_one("-cpu cortex-a57 "
> +    test_acpi_one("-cpu cortex-a57 -machine ras=on "
>                    "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>      free_test_data(&data);
>  }


