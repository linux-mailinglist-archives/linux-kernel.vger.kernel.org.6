Return-Path: <linux-kernel+bounces-431238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD779E3AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2EF3B3233C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1321BD4E5;
	Wed,  4 Dec 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7DGUd41"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC21BBBF7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317973; cv=none; b=hPfn7XXM+uetuseyVZROBrtfSbqP7HeVhS9m21ngVpwYbSw6bnjrs9FljL48SFzEC6zW34N2c48ECX9oht+CJdt3zz63pCTGoLS3OEeCJhS9xGR8+yQ4CxsSwrCCIJMvdeiXtpy8/KsvLFe02S6UCQCHBq+J/Oj5c5zcfkkdXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317973; c=relaxed/simple;
	bh=2HJKOIuJLqfPSxLF4SUeKEsuoD5JlQ3K+6THnKZJGSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adq6Z03JEoO+pT9oIdJxq4z/BFwMWEvWI2u++28z9I5wM31EDSw4YrvoOIJCaCsGVQXlkbQNvbHa5Zpvva32ETMkgkVtbVVloHjo/1dR6ixgLIvHZ9SAfbvRfeVNPZpJc5+FOU0NFo+/XTwBprvHSUzKTz10ZHHPdMO9OmreECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7DGUd41; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733317970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0OdfHAWE083Kg3ZyFOHbjW6Kan4rzbMlwnGwZHkV8g=;
	b=O7DGUd419BZ+d/vy2OkdzGWrC0MXLQhSOxFRHnZMv9vEc++Q9cPm8dgM0WjBMw5RpHj3TC
	As881mTRp3Riaxsc5IvD9Lyr8sbXGyGyOY8uUohqwjj+iTWadM7ajrFid+tZxSz/im6frt
	GxrKwGDLnFK5Q2qnMKd4nBm9Li2l1RE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-6VNcZaieMhqnHJQazqZBpw-1; Wed, 04 Dec 2024 08:12:49 -0500
X-MC-Unique: 6VNcZaieMhqnHJQazqZBpw-1
X-Mimecast-MFC-AGG-ID: 6VNcZaieMhqnHJQazqZBpw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43498af79a6so5147125e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733317968; x=1733922768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0OdfHAWE083Kg3ZyFOHbjW6Kan4rzbMlwnGwZHkV8g=;
        b=TKh4fk42wvtvgcxnabXxlegub0q74HmIVJBjezfzlbnGkIIs0100wQOxmKv1EJjUCz
         CxBd5eRqp3Q9+0bkyB38weKw7yFOPJBVQpCQwjHuPd0wti30VUlLQGQ4j1kqpFJGMKEL
         72cCRF+hINR/+iErP6AXfFvwFHif7AgC9nTnUTjns3OQRoYmmbKOFUp6zF+ETiewdhDo
         1QQZxU6/s/zVD4/FTRlg0QqJvQvK4usG2ySbQ3TxurSvnae/zDnZJ6g53GEZ27LgNshO
         dgzjUwKdqGg6Y6bvBysrZmH9clF4031ET6XI++ckdns/ncEplmLUAUF+wdGXJLKvGICz
         fGBA==
X-Forwarded-Encrypted: i=1; AJvYcCXUcKF5Q6URxmOnGvib+/y286xhhutEO5tPpD6DxREI23LGAO3DH5bx67VSV3cR8q8k5Yy1Xpns1764EjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaRbyKWN3VaDxmc6H7JAWxAIy+yEsPHSae98WIKUeJwlStKhs
	H5v+fAg6SRHAkhhMQGuLzRImRLGHrOy5uG6FLixnG1+E44FDGFLwS9oFX3X0dfk92hL5a5ACy/P
	BDqY0Kf+WFWUEjcSpzXNtjL+DiSI5IKK2UCorIgfmQP7bv/Q6m8p5fl0bqTrK/w==
X-Gm-Gg: ASbGncsT1fTPaihjor0H8m8rJ55Wibxh4bZdQ08Nh9pL6CRlzpnJMBcsSqH/dl0GQBf
	02AHrHjpRkxiP07kOjZzyTs6xx1HaaWotKlKOSrnrceA79JiRrRU8hloewVXbk8lH+wBrh7yld+
	FRHOFzRnrdohsYShxoZHAeunfOaX0QJo1/Cd02ngU1OWn5OGqxaLELCY3OeX3Ft6W6y0ezXLuC5
	fevTa+QRzlGyaOX3rHlOisWcivH3AKGvl7hMpNCAMvSSuM0xwVfY1JExU+vN6/SdoTlFVVXVSMK
	WzCZw+j5yGNI6QHa/Kqnjw==
X-Received: by 2002:a05:600c:3b16:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-434afb29148mr209412525e9.0.1733317968240;
        Wed, 04 Dec 2024 05:12:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQxAZLZpmjkLzkDFbywJOF+ghsGV+U3VvgxLTvIQC6dHR7uta8PxKFS9O0+ohwhZE2ziMhZg==
X-Received: by 2002:a05:600c:3b16:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-434afb29148mr209412315e9.0.1733317967956;
        Wed, 04 Dec 2024 05:12:47 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e06c485fsm15131424f8f.83.2024.12.04.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:12:47 -0800 (PST)
Date: Wed, 4 Dec 2024 14:12:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 08/16] acpi/ghes: don't check if physical_address is
 not zero
Message-ID: <20241204141246.37a7cb9d@imammedo.users.ipa.redhat.com>
In-Reply-To: <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
	<95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 08:41:16 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The 'physical_address' value is a faulty page. As such, 0 is
> as valid as any other value.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index edc74c38bf8a..a3dffd78b012 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
> -    if (!physical_address) {
> -        return -1;
> -    }
> -
>      start_addr += source_id * sizeof(uint64_t);
>  
>      cpu_physical_memory_read(start_addr, &error_block_addr,


