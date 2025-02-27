Return-Path: <linux-kernel+bounces-536416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C989BA47F42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9A0189159B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182B22DF8E;
	Thu, 27 Feb 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZscCeqjT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B317221574
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663250; cv=none; b=C5aLyECVUFvwM6vyDWjTsb2MCQJisOH4EqAJB43X9hH7zHGRPcQwt07LY/vf2qfxK+CjkmWMkqwbI2xV8P4vL+lLhPlbQ7lvWP234G0YF7rFkT6e+ljkceC5mZkaLW+Fa24kTWZ6Jz7Bxnke2YiLCx3a1D30c0dvo6marzi4QWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663250; c=relaxed/simple;
	bh=xFE676yswlPUkveJrw3/9s8mQ9wbSeq1Si8WEKRwYBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBkrOtLKasnegaK2lMSuVJmuVnnX+/XnzBN5v7se8aqsB44SETPWEqggvBVBQ8MteUWofv/TLhygmuBiu/X5SjNPBq2QGUV1EiBvDhjIKVgphEbfh1Lo6sdDAoG/SQhYsb+sUI6kFzXO9TqSGwIRbbyApvbnwYQQwASnFplFGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZscCeqjT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740663247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+B6L4n6BOi+geOHGCelQa4PK6UgYjAHyRQzVn6Mv8Y=;
	b=ZscCeqjT++bnMw5O0CT2EYXXZOXTptvFaBINqDzwST4MhyOTqFBsAlewoqXkk/VhVXH+GN
	rm8wzLP6MODUwEuXXQ3CoYrQ2uGwJL6K2kkJ0L5PvHVpDxhA1GcLeqKeFAREKz/iIS9WBW
	3W7+iXI9Hoo6lPHspYmsQY+nwAjq3z8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-eBFDSKgkMaWUq3_nPkMBMQ-1; Thu, 27 Feb 2025 08:34:05 -0500
X-MC-Unique: eBFDSKgkMaWUq3_nPkMBMQ-1
X-Mimecast-MFC-AGG-ID: eBFDSKgkMaWUq3_nPkMBMQ_1740663244
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f3bac2944so413158f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663244; x=1741268044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+B6L4n6BOi+geOHGCelQa4PK6UgYjAHyRQzVn6Mv8Y=;
        b=wFlMWtn193Cy809mdXVdm6uXPEdR3+f1a0YLLAadYWLR7R3APa2YZK5Yvd+mygrkcI
         CTc/yjTlfdk+FcypPn76xrEC2GLhV7p4REPwj1jR1IrPpI8C914Es+nQPDT9zv9xUcfB
         c4bErAKCid6lTgSLOz/cWhKKnI9zglClcytiecclOC7VIXlfIoiHHtzNDHKcfuDimdzN
         kHVXYZ/jdBi9YrtCbLLxapnoMFE8c5B3mpIuweohDalUtif91KsS5VwiEcrNilpIJ0oG
         FlzdonEAyvDJA5DAqiOfTYiZcwq3EFferFo/DdMkVPRCTRI7ESAeDmOyy0XcC4c9zUyJ
         5hqg==
X-Forwarded-Encrypted: i=1; AJvYcCUmIDniRxJSIeSyso5J5xdT63R5GSQtwOYpKKuMurG8NMW+K+qBK/CjVKPfGl01xtMZnJtyjEpoon5mCpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7xzHQLPVurvG0u2hP/P0f49OYwbcxtNrraZjJsFkrhjMwqmx
	adUPTWY/u8J8V7e5hLDYTj5ezESlTOyuXJvYX3sJIcig/aVDDif7zv9YM+RLzM3QNjMiR5VvmAR
	8hcB1St1UlLoLTb8uxNBjKkjUqSzO7pB27OL3XKqXiHgplHUvqPKUnAFSr7pBqA==
X-Gm-Gg: ASbGncs4Gv1s6JE58Nz2EfCnr872pheX8QTd6OAKJlBcVlbPfZ4zh6GCl6R5IwzfNT6
	WnjB0zTBP9zIfo0fQW9NxM4YV2xCqie0FSFqrKtnxXIR68+THwc3QfRdNjuqYkAqRM3pH6cdHjV
	wB9SxbfXHNohOkq6kyhrd/q7MV8rQM/yFyo1egAnCKGhrrVffijtAcdSjBoQuKHUbslRI0Ntiln
	WT5DVlOk/+aXCwnxJfe4P/6tgudJIrnrr6JB7lcp4bXUhf1ToVoc/ShfwPXPNfUJ5LmhzZsGfAU
	a3tpL6lIVgh00PeRFV3rds6L5RSv+iyYuPwIAltsE4+lm1o+Edil3p0UBZrxYtU=
X-Received: by 2002:a5d:64e9:0:b0:390:e3c2:4638 with SMTP id ffacd0b85a97d-390e3c247bcmr2178799f8f.45.1740663244468;
        Thu, 27 Feb 2025 05:34:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPgXKZGzQZi1RlXVPrwC3mmkAF2LYR36JJd6HlYn8JsxhoUL0knF3kKMZithcftiX65fGmwQ==
X-Received: by 2002:a5d:64e9:0:b0:390:e3c2:4638 with SMTP id ffacd0b85a97d-390e3c247bcmr2178773f8f.45.1740663244089;
        Thu, 27 Feb 2025 05:34:04 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6aabsm2087622f8f.26.2025.02.27.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:34:03 -0800 (PST)
Date: Thu, 27 Feb 2025 14:34:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/21] tests/acpi: virt: allow acpi table changes at
 DSDT and HEST tables
Message-ID: <20250227143402.2aae1c20@imammedo.users.ipa.redhat.com>
In-Reply-To: <11f37e677592494c7e73b2ff5fad700e8726205f.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<11f37e677592494c7e73b2ff5fad700e8726205f.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:44 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> We'll be adding a new GED device for HEST GPIO notification and
> increasing the number of entries at the HEST table.
> 
> Blocklist testing HEST and DSDT tables until such changes
> are completed.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..0a1a26543ba2 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,7 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/HEST",
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",


