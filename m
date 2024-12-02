Return-Path: <linux-kernel+bounces-428123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A852E9E0A67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6775528271F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B13B1DBB21;
	Mon,  2 Dec 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkVjBiJr"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD21DB940
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161733; cv=none; b=Ge29+GdDTBya0mdQCrpgMZ1iRJN/0APWudDT/yZ1f0E5e7aiRzgWSilCamp41aO9ItFxYt9kpiYR5AX4Eph97ROG8x7IlAsCzU+dNR+yMbs6Kr22DW1Buyl1K+STDFQX1ye9sg4oiE7SLalT8p2NFNwW/Gqdez97KoGMK97U5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161733; c=relaxed/simple;
	bh=WKospFR6+WV+Zjl/3/4cyAzA9P+WMRVfkoIaOmiAd2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OGPf7CTqmoznLcacTFGPW5SBwZIsAnkg58AtDhxs7iVa9UcZOVbZ7qctCSbVEVK7JfEM+DRrxMbL7VSXNChWsU1eL+M2oUfhznb9TyWN20RhSLY6DOmVSjY6zEciqKacaSl/DyWGcHAB973a5Nt831jnS6kXSWbusLxQTn5Wqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkVjBiJr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso2441359a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733161731; x=1733766531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=S8JMWjbRy8E+huOpI4PWDUpf5cc+KWX17p6yAqPuPD4=;
        b=ZkVjBiJr5/FZks+lfOTjpOzjzV8HcHBXUhvjg1IlFBkMh/ppgV7bb/zeUeVEd2N0Hf
         zzCG+/qHQQmrT6q1OIvHG2n0lrG7p7TfGss6PX92fMn4NpTyTNlTyw6Mwlm2HghRsjCB
         L0EeYoMFKhmy6UO9v00vCOB8ZlTHlvp03ivHqK8CE4O3QftjsbWoecYLXHlyuPMHZy5+
         So3KMzabO6/rmWLEycC4waxadvMJ9GNNz6L+cJ/cZUZvF6YBujhLkov0OZXpXlrXrUcN
         aFWfQwx8pjDpcPTO82AO+3I62TKrkL8Nwu2ooQ6CC2a2XVg2SSZx/Dx1JtRORP74G5IA
         oYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161731; x=1733766531;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8JMWjbRy8E+huOpI4PWDUpf5cc+KWX17p6yAqPuPD4=;
        b=ZgdDXDEzRXr0blyaINFl6wA2mKqv9AFQ0csCR6elUivK0zsiBT7GCGo6yYSpCbPedQ
         sR5XwPF4iCdkbdNSWhotEJk0HBE8muvWdjsndx74gTy7WRGKB8E1Hu3UrBJJthLhvMCE
         E8xoG4MbqR6VRXZir4bkIIhirqlN0nYoJUhwsrLtmV0e9WXng11aoxl+31WZZIVYFRyw
         ZkPBpdxunNC7OSEBpA3fB0CDqaUcMJRF/WAFOE6E5WJYMoxY0JLlZUtgtCp0QtvfXTmY
         CyO3GVj/gucauK0PJWUnXoOKJ6iBuOseLMHYzhLHoe9jvOmcTVonHpo7AMoxPRt27Lwn
         Lvwg==
X-Forwarded-Encrypted: i=1; AJvYcCVzFOd7rSgchQab/tXhd8WXjztWhc9lnu+3SfzGtq9/mPpZkOnK/GUPr7k78FB3kKYSBQ1YwxWffZdFkV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQFceksvc3s5yHZCvveAIJMQv7zmkAR5SaRFLlgemK18uw4s+
	oy4K8NiJWVrPaAqG9o9fET+lmKRiO5DKJp4r/e5Id0nu7XOv0TNs
X-Gm-Gg: ASbGncuMx2FKdSd8IKY/AZJW7JpKnybe31K9imp98xEly6a6oJku2GWCv5t49+uoXRO
	jGmoeSNOYnhGtGT3CIsBdiqMPfXJhUWUOQE3fi+LrkP45yYx8CoTjT+oP0DpDj579LLvWBm58Ka
	J2Ox2ue7wgDw3njqV5lCx8x7CgSI9p/osunIMmnau5hvW1GKNk6GoA3Fp50Mx27pP4M7xMv3GHU
	IL0T435j3pBpnr9YL6Wx17c/CqbpdSolEj4YdbKypg1GOGBxZPh01nYDBaCw298uUUEpyS6eXcV
	Bysu2HCtE5/jFqBsbEAVZv8=
X-Google-Smtp-Source: AGHT+IGctXjbY1GfXjI9+V31YWmakVA/xpMLR9J82y/OAK1clFMOU3x213fpwCCX4aZRO94dpIjiZg==
X-Received: by 2002:a05:6a20:6a09:b0:1e0:d104:4dab with SMTP id adf61e73a8af0-1e0e0b8d1cfmr34054425637.44.1733161731087;
        Mon, 02 Dec 2024 09:48:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb9adsm9082044b3a.127.2024.12.02.09.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:48:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <88c8ede5-47c0-49ec-805d-161293eec679@roeck-us.net>
Date: Mon, 2 Dec 2024 09:48:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: gpib: Fix i386 build issue
To: Dave Penkler <dpenkler@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241202173301.6462-1-dpenkler@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241202173301.6462-1-dpenkler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/24 09:33, Dave Penkler wrote:
> Both drivers cast resource_type_t to void * causing the build to fail.
> 
> With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned int
> which cannot be cast to a 32 bit pointer.
> 
> Use ioremap() instead of pci_resource_start()
> 
> Reported_by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
> Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
> v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap
> 
Sorry, there are some more.

drivers/staging/gpib/tnt4882/tnt4882_gpib.c: In function ‘ni_isa_attach_common’:
drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1430:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]

drivers/staging/gpib/cb7210/cb7210.c: In function 'cb_pci_attach':
drivers/staging/gpib/cb7210/cb7210.c:974:36: error: cast to pointer from integer of different size

Not sure if that really fixes the problem though, since there is other code
which maps the void * back to phys_addr_t (or, rather, to unsigned long).
It might be better to work around the problem for now by disabling support
for platforms where sizeof(phys_addr_t) > sizeof(void *).

Guenter


