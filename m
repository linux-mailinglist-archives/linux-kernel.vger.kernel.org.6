Return-Path: <linux-kernel+bounces-227125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DEB9148A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9D0B24A20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B7213A884;
	Mon, 24 Jun 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHiOoroF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8345137C2E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228549; cv=none; b=HxPtwTSeyHO4ryNMkXWuG0RRomLS5wRxUlXmCSiWTO4RsAX3njx6VE5ZFRqVwtxDisBOBFrOr49eFAXAV+JPGQ2rLDbbTOUID3SVzSMZZDHI0271onuvZ+or/Yxh7iDsMKId62ALWAh5Q369LCYN7AzZ4SNJ/NiD29+Rr11D5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228549; c=relaxed/simple;
	bh=1qAwwfNf4MnwCqHDzql7SkOV4rq42uupjeLt+HGb+dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUT1lSdIx+g9T8foy4MDY0pi2RS2dWhiFrcAsWUp+Vvq6GhLk95plHARk6lWMzHGoUAoV/7qpvZbDfUCn1JXf/CGGcJzMfZyH4zU0yI8sVng5ZFxebhK55cK+EkczbblnyOl4pHhvuQXKfqrjMK2A6UY5b2FlI0RkzjKbFBgs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHiOoroF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuWSdEk3j+b8KhLAZNkf4+BDUGxUYnMohmbFl55GlhM=;
	b=YHiOoroFy7KM3wOo1gNbJVVuqkyQaum6uPRWpER7TUx1ZAfubAqJntkgp87jU4evBzsFvr
	GjWLX/Nd6119JaWXyCDl4I6mhz4F3cxZUpqeM2E9+XOCGWlLfJQctXEDzWmUOcE+/NuhlT
	TiLYabrqHpKGsKYuOuVhpavBfafdOP0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-V_uvi1LhNmSxD5irsWaB6g-1; Mon, 24 Jun 2024 07:29:05 -0400
X-MC-Unique: V_uvi1LhNmSxD5irsWaB6g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a724b61d37eso55399566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228544; x=1719833344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuWSdEk3j+b8KhLAZNkf4+BDUGxUYnMohmbFl55GlhM=;
        b=u9weKE7/PLrISuwNBHhmr65Rv0K5qWvXyUXKvuM2WRqTGf4JnT4UDv4GeXP+qLto18
         r9Yu5hgLIl5ivIwoHUVvx9HZLZE5X3zYvjZYSwr69+HVoZDo4sarq2KXxgZNC4AbwC0U
         5h+q5y6DmzD/uLmaAKxKtN5f+QT97y8fijcaU4DOswn9YXpr4Vqt+LCH5RDSMuPMJBTw
         vhSJTKTmN5Jtg/rGfdaS4zDE+ZSUcDZr4+BYQlFT7yiyN9lYpsWO7V7HU03kTIST0Z8J
         yVrVrFFNfN5mc2wADWyeSSd6/evZ4BgVUiZsoMWQeQCdQtgnm/WgenqV2Q+JZu4Q5rRZ
         UnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAw5U9BV6MFYAF1ru0w76CCWaA+Ybf+GKTsQLTbJb8KLM8K8feoKestaqEN/ZesILTPXW5ep/l9d11T8dyKOK3ktuwmJ3y7R6rJqhq
X-Gm-Message-State: AOJu0Yxu6IOc56vnGfxY3H/kw/TngV3NFfAnUNhGTvCP/lisdgDyOpJ9
	c+PeKNrgX4CUGBW4EB9aJBsIEL0UbIDoBtI8u8azJ1RN0qDkPkJ2R250RxH5G1ctBDE/6nnMa1k
	W4tb5Hp1OM37HfIR0zg3xjqwDaZBXVTS/367K4gIzY9j39HcDCA0pIQofegL7Sg==
X-Received: by 2002:a50:a41b:0:b0:57d:17c3:a593 with SMTP id 4fb4d7f45d1cf-57d49dc1e73mr2687908a12.22.1719228544438;
        Mon, 24 Jun 2024 04:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/M9Q8OVoPb4oK46X+w0uQZLqriXcp9PtZcJDwxzPyLqCFia5SxA4gWcpD9ypWDrEgfW6z8Q==
X-Received: by 2002:a50:a41b:0:b0:57d:17c3:a593 with SMTP id 4fb4d7f45d1cf-57d49dc1e73mr2687897a12.22.1719228544052;
        Mon, 24 Jun 2024 04:29:04 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3040ea36sm4585206a12.21.2024.06.24.04.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:29:03 -0700 (PDT)
Message-ID: <22147391-0084-4504-a899-4a529dab1af3@redhat.com>
Date: Mon, 24 Jun 2024 13:29:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] platform/x86: lg-laptop: Support 2024 models
To: Armin Wolf <W_Armin@gmx.de>, matan@svgalib.org, agathe@boutmy.com
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606233540.9774-1-W_Armin@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240606233540.9774-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/7/24 1:35 AM, Armin Wolf wrote:
> A user complained that the lg-laptop driver does not work on 2024
> models like the LG Gram 16Z90S-G.AD7BF. The underlying reason turned
> out to be that the ACPI methods used by this driver where not mapped
> under \XINI, but instead under \_SB.XINI. Those ACPI methods are
> associated with the LGEX0820 ACPI device, which was not used by this
> driver until now.
> 
> The first three patches move the airplane mode hotkey handling out
> of lg-laptop and into the wireless-hotkey driver. This necessary
> because the airplane mode hotkey is handled by a different ACPI
> device (LGEX0815).
> 
> The last patch finally fixes the underlying issue and uses the
> LGEX0820 ACPI device to find theWMAB/WMBB ACPI methods.
> 
> The modified drivers where tested by the user which created the
> bug report and appear to work without issues.
> 
> Armin Wolf (4):
>   platform/x86: wireless-hotkey: Add support for LG Airplane Button
>   platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
>   platform/x86: lg-laptop: Change ACPI device id
>   platform/x86: lg-laptop: Use ACPI device handle when evaluating
>     WMAB/WMBB

Thank you for your patch-series, I've applied this series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


