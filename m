Return-Path: <linux-kernel+bounces-292010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC8A956A10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603C61F248F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39EA16727B;
	Mon, 19 Aug 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doCPUDfm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AF166F39
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068646; cv=none; b=MLQB+CnI+CL/53x9jB+qH0xZ2hwGVDMO/5mGWBOQNcvxpsGcSgYKEBg/efTUQ0kWtnnejDV7ekz6D6TB4SC7sbfJbjOjEVJbAZ+8khbJchlC1BE/smu2At1EI88uAnW4zsXFGm9heDbgtdZksXmc6DuUeWmSB5kLR4XwDsfJAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068646; c=relaxed/simple;
	bh=ij/RhKXAEL9cVBO15IYVkcQPnrzyZPTaGryR8ECRDDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHSqAnOoZiz0m0+fr0eJHbQwD5f3exgxaJD+5Mr+WqItgIW7A0neI4VzCHEtLnWTYYTNYAfqZmK93zub31hvIkkX/lGxH1qOJoMWZIIYsPT9sWGZk/0HiauMACWDAeqXl5L7CdWdGWYLB3wsPaiZMmXEZeHJMnxF4jX9rRgbQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doCPUDfm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724068643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84PhB6eF89FFZ8ucHgT9n7pmJgWbulzk/3Qj97ioNCk=;
	b=doCPUDfmbb9RrUFBJlCBcXdCJZ5jLv0wcfehRVkb44p+Z1Ce+DKEfTTdNk1soeIlJVfxnj
	LntEIU7uQ5d2DAUEFdBlgxHRZjV0GHsSusJcgdGm+C2A056qfsz94e63Ar0T9DTfzKWQQo
	7c0LSBLcoBkK41qP0uqYuwDeleyxJjo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-wmehSiH0OnOJK9dE6WQvjw-1; Mon, 19 Aug 2024 07:57:22 -0400
X-MC-Unique: wmehSiH0OnOJK9dE6WQvjw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bee990ad19so2158316a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068641; x=1724673441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84PhB6eF89FFZ8ucHgT9n7pmJgWbulzk/3Qj97ioNCk=;
        b=FEdc7/QEiMquCTV5wLU6nNapstmRI5N3ggRpqhMvTBN7JT9oYGvasRyoDAIsvb64v6
         ZDVMIY2OqbHl0xhz6ad13GDAPaIZ1K+kz16NjAEPoTLcZqtO7PAiV6K/RFA4z97yBahx
         2pb/id9l7cHSttD83SnAYLoasiGXb06mqJEcOfdviZbmNrHpCoCAQS7vtpREKIK4XpIK
         s2CSJKLX1v6o70RJJ6OLTsf/Tghg67Xm95zaQAR9Ftnd5gEGXLeUJW7xQ1+m1OGu2mW7
         +4QNIZbnOfBrpn+qatv95PqncsSPxIDFWkur0hFHtmkrc2IgBgDb3mt3nf5rYZ4cHGs3
         5sPw==
X-Forwarded-Encrypted: i=1; AJvYcCUhg6BsyxW0/1ojWuM+za3uXhHbhkeNwEZnV1myewCv8eHdjUz9GLa/BcxEVzq9WA2jxxqF/Kz7/duWjqoQOmAcv+4c00FHDtP5CuHm
X-Gm-Message-State: AOJu0YwPjBOnFea/WTVs/KLA0en6pizPHjTZLdZNaelQx7XPnGPT8kuj
	krGdJxBBb2zrJc8yZPZl0OuSEVQLCxJ59m6RBBvhSN5gLOUuBnumK3yfqEW+id3pjkKLwcb2RWZ
	6w7393LnDLYgE+9Zd8hat7wsJievZX1t2QODAJ+aHt8+7Gl6jB3YadmiUBXAF/Q==
X-Received: by 2002:a05:6402:34d4:b0:5be:ecd9:c73e with SMTP id 4fb4d7f45d1cf-5beecd9cbf3mr4997303a12.2.1724068641332;
        Mon, 19 Aug 2024 04:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnRo8JGhy8S0tLVgxUpCSUbuvlldmz7SLn5JDTjjd9seJwXdLBAybiRE42CshwTS82wSQmig==
X-Received: by 2002:a05:6402:34d4:b0:5be:ecd9:c73e with SMTP id 4fb4d7f45d1cf-5beecd9cbf3mr4997268a12.2.1724068640890;
        Mon, 19 Aug 2024 04:57:20 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bed05f0a30sm3999829a12.30.2024.08.19.04.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:57:20 -0700 (PDT)
Message-ID: <1edadffb-67d9-476e-b0f7-7f3fc34e9592@redhat.com>
Date: Mon, 19 Aug 2024 13:57:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] OF support for Surface System Aggregator Module
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/14/24 12:27 PM, Konrad Dybcio wrote:
> Wire up OF support for SSAM drivers, to use with Surface Laptop 7 and
> other Qualcomm-based devices.
> 
> Patch 3 references compatible strings introduced in [1]
> 
> [1] https://lore.kernel.org/linux-arm-msm/20240809-topic-sl7-v1-1-2090433d8dfc@quicinc.com/T/#u
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I did notice the following compiler warning when test building:

drivers/platform/surface/surface_aggregator_registry.c:278:36: warning: ‘ssam_node_group_sl7’ defined but not used [-Wunused-variable]
  278 | static const struct software_node *ssam_node_group_sl7[] = {
      |                                    ^~~~~~~~~~~~~~~~~~~

One way to fix this would be add #ifdef CONFIG_OF around the definition
of ssam_node_group_sl7, but then future devicetree based surface devices
would need more #ifdef-s so instead I've solved it by squashing in this fix:

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 495cb4300617..ac96e883cb57 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -415,14 +415,12 @@ static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);
 
-#ifdef CONFIG_OF
-static const struct of_device_id ssam_platform_hub_of_match[] = {
+static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 	/* Surface Laptop 7 */
 	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
 	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
 	{ },
 };
-#endif
 
 static int ssam_platform_hub_probe(struct platform_device *pdev)
 {

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> Changes in v3:
> - Drop unnecessary nullchecks
> - Add MODULE_ALIAS in the platform hub driver
> - Fix MODULE_DEVICE_TABLE after rename
> - Prolong the '----' comment to 80 lines
> - Change the current-speed bindings description to ": true", in
>   preparation for krzk's serial device bindings reorganization
> - Link to v2: https://lore.kernel.org/r/20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com
> 
> Changes in v2:
> - Fix kerneldoc
> - Drop the drivers/acpi change (oops)
> - Style fixes
> - Don't assign int to acpi_status
> - Don't scan the bus twice in SAM core probe
> - Link to v1: https://lore.kernel.org/r/20240809-topic-sam-v1-0-05bca1932614@quicinc.com
> 
> ---
> Konrad Dybcio (3):
>       dt-bindings: serial: Allow embedded-controller as child node
>       dt-bindings: platform: Add Surface System Aggregator Module
>       platform/surface: Add OF support
> 
>  .../bindings/platform/microsoft,surface-sam.yaml   | 47 +++++++++++++
>  .../devicetree/bindings/serial/serial.yaml         |  2 +-
>  drivers/platform/surface/aggregator/bus.c          |  2 +
>  drivers/platform/surface/aggregator/controller.c   | 67 ++++++++++++++----
>  drivers/platform/surface/aggregator/core.c         | 82 +++++++++++++++++-----
>  drivers/platform/surface/surface3_power.c          |  1 +
>  drivers/platform/surface/surface_acpi_notify.c     |  1 +
>  .../platform/surface/surface_aggregator_registry.c | 47 +++++++++++--
>  8 files changed, 210 insertions(+), 39 deletions(-)
> ---
> base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
> change-id: 20240809-topic-sam-5de2f0ec9370
> 
> Best regards,


