Return-Path: <linux-kernel+bounces-564000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0054EA64BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E841E1886E94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAFF236A70;
	Mon, 17 Mar 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkM2zrTW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9752356C5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209512; cv=none; b=BPPLt5wZQQrmG4j9Ey8CMRnT9tEYPvtzlrvfSkOyo+FtLxkdC90FZiDZfyCAl758pbohj8QrX1tGRVvys1EBbNJ7FzmMiM68CZYhemv/ELi6rcBDeRteQ2Dx6qSCj3kJq4b6GJ/TkTU48cJaQMdI6UxCQ1sxdU3u70tJJ9QnqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209512; c=relaxed/simple;
	bh=q1p2RryvxXZOam8aZ9xn/h3XCaJjpYdoRqVclsSyld4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjY4JuNJZqH3QiZCHrXezgFDEGwL6JzdZnb96YmvGuuNmc2fOKrjk5HvAuy1UNr9CQlu613NKNmgZxr9bRQ+PA9ei3UrBhHqaowjlPYZ6ebMbm982KOpbcB8e39RxGVt2oAjxwKHU01+5inlx0+H0YLguVBukZgxCEknlLEMCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkM2zrTW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742209509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBvUwzP789HFV3ICxplLlIM9nxvDPZjAQBuQvtsW2zo=;
	b=hkM2zrTWl+Hk+PdGLmBbyvzqS2tLp5NJSDogGCflxNGAbqZzddBNmg5HDK3mft9BFu7M2V
	vNlGGhXbn6g85hJE/9RDYAIgSHY3HRG5ijYBgWsk91CESTnUxcOeaNXHbGJOI2zzK2R136
	NOztZK/B8HVkMD+EqesyHZv7XALd2fs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-9wW5EQebPyOx_nmgXhEewg-1; Mon, 17 Mar 2025 07:05:03 -0400
X-MC-Unique: 9wW5EQebPyOx_nmgXhEewg-1
X-Mimecast-MFC-AGG-ID: 9wW5EQebPyOx_nmgXhEewg_1742209502
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac384a889easo22608566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209502; x=1742814302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBvUwzP789HFV3ICxplLlIM9nxvDPZjAQBuQvtsW2zo=;
        b=bFHyherut4V1ocUqkGKu3ZxbFQ3wgeidwdut0l0jfJk43hy9EjsGQKkhkoIjXC3S0D
         ured6iRO4Au07BC30e/9LC/Lq1wDUsn71efZfp8mi8PA0xV1RNiKPH9YELwsEdERjIs7
         ZEqqsYH/gxa3clbH37jceBOGgr/lGBS6bzY2WdO3Sxys7yN9zuJtqIOwYyBZF6yP8spy
         JyB6apkXiww0HaQC17uK54oyJsmcsWK/OqnvPsIi3b9W/KX28jb0vijEDv6aBOR+LJ9x
         8WXeXRVBjCUiqa7/MBBjyseLyir4CD3bIYueAwVsq2zSgeqRgN32rLLqQVgOWdzNzAWX
         oHPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSq3HJ67EOmGyk4ifC45PA8wsM5pbSlee2XNbFnKMIxA6ZPStXWwTcsepbxxv5+i6GYmxQOSlgQK0eZQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCu3EDhauPh9D7c96I/oBtAcL7YtCA/siBbI70HLghkOqTCGa
	CaXqKGjhVTZW8L0nlu8mBkMCvApmafRc9zgTEp8ZCmTZnY01RV/uTsM+8YO8NbpyzOh2amG/YMg
	tDhFplyuP/lswDfQjW1WSp1LlDc06z8XNDBB3PAP5Sok/XQ7UXhE0ki8bYTb99w==
X-Gm-Gg: ASbGncvFspJOidNuU4adZg5ZQguKBif1Vybj0I2qtCZ70dgZYrlwEP4r5r12D5puz5b
	HPRkBq9VqIAjTcIg8bsb+5RJXyke2VuMyzpIhHLG1BytR2v22jyM6uEXZh0xTEDLPIX8pLrvXNG
	MNXrpAKiZ+xA8wy3n8y+84qiGb3RSzz3zReG24nEYBMhYd7/i2UWcrW7570mEvtcIhyRP2fA0vb
	6L5hTEzG5NQRBAuYZGNZ4GI4Q4eK+nO+oNhYZblMBHhKt9xEXzAiLwHK1ilN28K1rnm1EhMOS8S
	URdh0tQAEf1HeaUJCR8=
X-Received: by 2002:a17:907:c247:b0:abf:6ead:2e57 with SMTP id a640c23a62f3a-ac31250719fmr1579389166b.24.1742209501684;
        Mon, 17 Mar 2025 04:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg67v2/9e+4jJswcJERm7K//dGMJHq/JlGnG8h8sQJj6Ko8ZyvaXXpwZPR+bSl3ASos+fM1g==
X-Received: by 2002:a17:907:c247:b0:abf:6ead:2e57 with SMTP id a640c23a62f3a-ac31250719fmr1579386766b.24.1742209501267;
        Mon, 17 Mar 2025 04:05:01 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9fe0sm654695166b.55.2025.03.17.04.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 04:05:00 -0700 (PDT)
Message-ID: <4e37c7b2-85bc-459e-b2ea-2e362c16e9aa@redhat.com>
Date: Mon, 17 Mar 2025 12:04:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Input: atkbd - Map FN-key for TongFang barebones
To: Werner Sembach <wse@tuxedocomputers.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250311180643.1107430-1-wse@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250311180643.1107430-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Werner,

Thank you for your patches / your work on this.

On 11-Mar-25 19:06, Werner Sembach wrote:
> TongFangs firmware sends scancode 0xe0 0x78 upon pressing the FN key.
> 
> This patch maps this scancode to avoid a dmesg warning printed every FN-keypress
> and to enable userspace to use they key in other shortcuts than the firmware
> builtin ones.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

This laptop specific mapping really belongs in hwdb, 0xe0 0x78
translates to KEYBOARD_KEY_f8 in hwdb and if you look for that in:

/lib/udev/hwdb.d/60-keyboard.hwdb

You already find several entries, e.g. :

evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pn*:*
...
 KEYBOARD_KEY_f8=fn

And e.g. also for some Clevo models:

 KEYBOARD_KEY_f8=f21                                    # Touchpad Toggle

and:

# HP Elite x2 1013 G3
evdev:atkbd:dmi:bvn*:bvr*:svnHP*:pnHPElitex21013G3:*
 KEYBOARD_KEY_f8=unknown                               # rfkill is also reported by HP Wireless hotkeys

these first couple of hits show that 0xf8 is not
universally mapped to Fn, so putting this mapping in the kernel's
default key table is wrong IMHO.

Regards,

Hans



> ---
>  drivers/input/keyboard/atkbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index adf0f311996c9..3598a21d9d014 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -98,7 +98,7 @@ static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
>  	173,114,  0,113,  0,  0,  0,126,128,  0,  0,140,  0,  0,  0,127,
>  	159,  0,115,  0,164,  0,  0,116,158,  0,172,166,  0,  0,  0,142,
>  	157,  0,  0,  0,  0,  0,  0,  0,155,  0, 98,  0,  0,163,  0,  0,
> -	226,  0,  0,  0,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
> +	226,  0,  0,464,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
>  	  0,  0,  0,  0,  0,  0,  0,  0,  0,107,  0,105,102,  0,  0,112,
>  	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,
>  


