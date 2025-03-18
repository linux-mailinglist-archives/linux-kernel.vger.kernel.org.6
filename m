Return-Path: <linux-kernel+bounces-566513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23199A6792A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B7C885FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC2211491;
	Tue, 18 Mar 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvW1qwYn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2F2101BD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314751; cv=none; b=f2qgLP00BA1y569re+ZzAJ2xxFuU+SQgnpi0VcoMXwHJQCG+e0HateXR9CYX0bIVG5+Dw3uKAWs88Alfol/89Ev9FVlu8xFE8P5M95wSP5vIZb0iVcRtZD26mLmzDstE0e0UGFCTYOBMfJn9qEQFGE3RXFbQe8ylDJqzRovlcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314751; c=relaxed/simple;
	bh=VuQm2jFESaPBbuqwjoKGcVK+DXK4tuxwWAqwbEc2gtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrvhIAMKlrOWVWKKG1nt1anNRX1aCBIomWslDbY3iTnyRMuDmLYDcM/sgLo4s5o6sy7vGfjQwClRzjyBELfVy0gRzcNhiDNAbV3o5jB+gIQXfkvSHocQOn8Q1AQkbUl5/E6lcuONfeVQwGvcQkdgc1lHpJXpNXkuTIsE1w+yhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvW1qwYn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742314745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EU2Ic7I1sUvSKCy08C9Tv8GAj2wePPRjqEZAXSqjPhY=;
	b=RvW1qwYnZCDh6LC9UVFsK7B1xrIuGZwJ0y77m5U20LhyqpnTNKgOT/r4ZivNsRB4LA5ZVr
	rntMlLgM6lvo4gUuGUmhq4kacLdX79iRZQKQxmBvASZFKP/cPPra97eZP0QcvyvJvxrHGg
	GwpvZ23ik5BzRCAC8Vv4ZfYQKhNcG9w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-101lfkIGPpWQ4pfx-Du-Kg-1; Tue, 18 Mar 2025 12:19:02 -0400
X-MC-Unique: 101lfkIGPpWQ4pfx-Du-Kg-1
X-Mimecast-MFC-AGG-ID: 101lfkIGPpWQ4pfx-Du-Kg_1742314740
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac287f284f8so421640166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314740; x=1742919540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EU2Ic7I1sUvSKCy08C9Tv8GAj2wePPRjqEZAXSqjPhY=;
        b=nI0bKZnY9KxUeWreysGKL8O6ykYyCSuzfjWy+aFlxS2D8ZhbpiSL4bety3qZ07gnvB
         p19pMCxvigaN96z49NC8TDUH38bc3G9CC6992eHPn6em+pMdac8f22EJseoh14WvTm0D
         1RjDTPltBUVady+N8l6LdUfHIVt6Kz80G0B4ikVDz4f8UMy1hvslIdHb/Z1hbL5j2NSx
         JbF694xqeszzG8JpYpofUcww73y8B9ydU6YB8/XgWB8u26kHUXnE9oWPILmkLdOFFKSQ
         Gw/FqoFmAWh5IVhu8ot1X8WkY4uNAKGplyIx4SLn8j57FjPVB5qjU40bAoPBCYDnep+r
         KxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNbhSNm1AYzljcv4sqgywSXav3lu5pdpz/TEziaLHE3/aPmt31Bg35gn0yyI7sQ8dZ5WvZL7dGhZABP7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS6SvUaIXOH2wqnVD4WJCSw2Ot/BEetbeIMu/dSz6Up0RSa1G
	YG8ZHi2lXe+uBxwMmNw0mwMcAfgX69+W0F9M85CB1MaOoETsycXCcqMT3REIyNpoeTrx3fVZciM
	5MEF5/o1KzfJwQrnnx3HUrzFzwhHmsxZqV/KMzVYPGm5/NRRWJ7PYG91g9T7Jxw==
X-Gm-Gg: ASbGnctDeGK0pPT3tpMoPcVDo1KnD0Q8/mz3/yNDdQTXjQxC1mChayqRXM0ppXmyxVb
	Q+Q0EHzMPRW65xN2U2Ixvk+xr/8NryTC6E18X2mFTaH4PKav2p7Dx7lpWdZL8Cf4wN1Kpiku7gh
	IaGut6uzqpEVzGrQDFTtIY7Glp4lVEwc314d+FwoqLINEDYSkDDqzsSrYKiRxCGWeiY/GoqOaYM
	Yuh8OvdhL+G6/q0mAJSnFNqyM+rpp2y8StAICAt8l9/P7ER1839BA9TU3FeFKYUyRhhkhqFs+uC
	9Cw+RtMACbmWKRfGGnS2kFOArqFWK0KrBZAolj8FshP2IQxa6daJRwI1ELU179QUVVBZFadOxiy
	eFzqkxCehLM9DHoA5BJPnt5varXszMazCmrbdFiagZWXqphd/eohMxaL8rvPp+23aSrWn
X-Received: by 2002:a17:907:2cc5:b0:ac2:fd70:dda3 with SMTP id a640c23a62f3a-ac330445086mr1687697866b.35.1742314740307;
        Tue, 18 Mar 2025 09:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzjMM3CLmirwe4h/1Hf9RQ0UnvPgbhViJ1GHQlrn3tDmefjP8E2y4LgrMP7j+PJOy9U53DA==
X-Received: by 2002:a17:907:2cc5:b0:ac2:fd70:dda3 with SMTP id a640c23a62f3a-ac330445086mr1687694366b.35.1742314739884;
        Tue, 18 Mar 2025 09:18:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:f271:322f:26b0:6eb5? (2001-1c00-2a07-3a01-f271-322f-26b0-6eb5.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:f271:322f:26b0:6eb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefdbsm864270366b.3.2025.03.18.09.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:18:59 -0700 (PDT)
Message-ID: <cf45e4a4-b1dd-4485-81bd-e65ab729f073@redhat.com>
Date: Tue, 18 Mar 2025 17:18:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS Vivobook 14
 X1404VAP
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Anton Shyndin <mrcold.il@gmail.com>,
 All applicable <stable@vger.kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250318160903.77107-1-pmenzel@molgen.mpg.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250318160903.77107-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 18-Mar-25 17:09, Paul Menzel wrote:
> Like the ASUS Vivobook X1504VAP and Vivobook X1704VAP, the ASUS Vivobook 14
> X1404VAP has its keyboard IRQ (1) described as ActiveLow in the DSDT, which
> the kernel overrides to EdgeHigh breaking the keyboard.
> 
>     $ sudo dmidecode
>     […]
>     System Information
>             Manufacturer: ASUSTeK COMPUTER INC.
>             Product Name: ASUS Vivobook 14 X1404VAP_X1404VA
>     […]
>     $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
>                  IRQ (Level, ActiveLow, Exclusive, )
>                      {1}
> 
> Add the X1404VAP to the irq1_level_low_skip_override[] quirk table to fix
> this.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
> Cc: Anton Shyndin <mrcold.il@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index b4cd14e7fa76..14c7bac4100b 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
>  			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>  		},
>  	},
> +	{
> +		/* Asus Vivobook X1404VAP */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "X1404VAP"),
> +		},
> +	},
>  	{
>  		/* Asus Vivobook X1504VAP */
>  		.matches = {


