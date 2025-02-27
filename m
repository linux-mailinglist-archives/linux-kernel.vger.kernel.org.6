Return-Path: <linux-kernel+bounces-536207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6434EA47CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628AF1714F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017B270044;
	Thu, 27 Feb 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4nC7htN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0051270020
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657756; cv=none; b=QX0WfIMhzwOzzxWG4F1G/kUW+bFcA0NWAJdp7UkKPG0xyJ+MXIklx9hE5daaEvA7/VFFXTQsv2oA9fy7glvOJb115EHwnpUm1kx1A/RdOpyfcu6y9qNEHkJQc2xuAUM9lM2va74UjAGiHd2vZabv45kWgD6AL8ihfySTEqpDyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657756; c=relaxed/simple;
	bh=sIv6btbCBsAsSIbPfrtYRtcbJOBVH1rc6NeySocU1q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTYa6o21jnWScSszzZVfJYechz3Y8LWlC5tzxOyl7WKk9d0pJDxZfjPlVbSwLNaorJlSaEsZp2cJsMEKRz1RG5dlt+ip7GV+56rE25lwT2iPsSDkUW3t2CYphWnkspdI1mC6Cu/OFQR5o1WQL34vrU71d9+5Yt3m24FMmP3AjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4nC7htN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740657753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRugfuFghPEgI0qvuOa5TFgOLvAsHNbtLdSfrep5L8M=;
	b=f4nC7htNCrn8SYLeMljLmwbUYRpwmI4dgIw2HUV0xqUGJn7HiBgOlb4Q7gtcaeI/qdT6Xg
	aVHWqB2+0Tx1MVn7wdP6Iass9NIm2ldLfOP9n4SfQZ8faadST21K5Phg7wEY7qPgDA3TRx
	KY4e3tjmvF3vaiREnyu2RK68JZnTO60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-JJgG7OKvOE2zROxuRLEA2g-1; Thu, 27 Feb 2025 07:02:32 -0500
X-MC-Unique: JJgG7OKvOE2zROxuRLEA2g-1
X-Mimecast-MFC-AGG-ID: JJgG7OKvOE2zROxuRLEA2g_1740657751
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43943bd1409so6808075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740657751; x=1741262551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRugfuFghPEgI0qvuOa5TFgOLvAsHNbtLdSfrep5L8M=;
        b=kO/nABXljdQWYGbH+Y9+1FqjY5JnqB849taAZvpimPy4OzNsuuGDl1p+x9asZ4947K
         1QN5kNGrnlS/RMx7AYKLAFVHKZNrz5mTWq4uzxSD0PcBuX7n9pL6DpL+ABGa3/MVaGZd
         yxdURhTT6NcAS5DP7XkF/NX3gRWRi4rELlSZv+kwQE/OLzrXiFKwdaTKsNyokipuECK4
         ilJ+RuFQ+Tq9nTSU5Wa4W8ZuawKIJ/GZH7es0fBnV8LxwITUH9JZ6KpnvFarcOkxoVul
         KPpE8vpIit83jQityF8pGXH0KCZ3Ur1tRReg35+McI1s1GTiNiIuGUnPbp8aqfUtPFAz
         qMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGfBpSpJlxfxSP5AU/Adr4ABM3hWG8B5E9PAy80OUKmMVYWFEAXTsxdcw3YGwW5aOkd+QCMpOt9CwC1ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzmJH9JNaP661HGVHWpMnRYZerD9YXssaRW1CoLkTWn/I7ilsA
	bKq+VNtl9hTDwEL8zMMwaA9nXAy2hCxtw9GX2gwP7mUxkY6DednLnzphM4b919NqFuIjOscseBl
	OxLvQc+RAeUoy5D4m6q551PGvqt1RdYzlhb2h1FA7dwcgEg836G0f7TfNuuzdHQ==
X-Gm-Gg: ASbGncvqHV33bpaAHNtPdvTLoC9VzfCRpxvwFTe6xqA2r9zPzW3/51TSu+PMWvgoLRG
	rUueLzQ9DwwElLGn6P/sI+pzQjRxHpNf+BVGFKsWLgZcps2FuV4ZSUrZVlu2vhJ7lxcrxVh4SUw
	Ljiey4TgwQEikgTRevOXP0ZS1JqE+KB4NVU5WT2Un2VN1aAIbln5xFvEdAzMjMbajkh38QPN7Be
	cImz9L4GNJyEcfpGBXtaNRONWaKepPr7pI4jMRUxVzF1PIVvZYWUS4kLCX86YKkzYaX8W4COqe6
	wdXpBGMxUFcuafPaSfPpLrxB8QZLswM2ZkxSi2KDcCsFjH3JbcJFxNbw75yIYBw=
X-Received: by 2002:a05:600c:3b13:b0:439:8bc3:a697 with SMTP id 5b1f17b1804b1-43ab8fd1f46mr63821675e9.4.1740657750922;
        Thu, 27 Feb 2025 04:02:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVj831tgv3cAm8RnxFYJohIJajXsS4joOm+ny7cS7e39sJEvV3VKtNW1GtmtP6yTlAOfg1JA==
X-Received: by 2002:a05:600c:3b13:b0:439:8bc3:a697 with SMTP id 5b1f17b1804b1-43ab8fd1f46mr63821235e9.4.1740657750568;
        Thu, 27 Feb 2025 04:02:30 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27b1c6sm21022525e9.27.2025.02.27.04.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:02:29 -0800 (PST)
Date: Thu, 27 Feb 2025 13:02:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/21] tests/acpi: virt: add an empty HEST file
Message-ID: <20250227130229.2a0251f0@imammedo.users.ipa.redhat.com>
In-Reply-To: <3da2d197610ada25dacaee54d113fb87c5448b04.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<3da2d197610ada25dacaee54d113fb87c5448b04.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:31 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Such file will be used to track HEST table changes.
> 
> For now, disallow HEST table check until we update it to the
> current data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/aarch64/virt/HEST           | 0
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  2 files changed, 1 insertion(+)
>  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..39901c58d647 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/HEST",


