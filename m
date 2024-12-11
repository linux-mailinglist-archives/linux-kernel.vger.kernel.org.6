Return-Path: <linux-kernel+bounces-441498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7359ECF42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567DA18881F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5D1AC88A;
	Wed, 11 Dec 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MwUzIRRa"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892A246357
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929406; cv=none; b=aofoKGLrUrOsD5Sw2r9syxdaAg7sd+zKKF3DF0yWY0MIf+lv5XOHThGkvyYx4WVvZp4O8ReL8znQzSY2c8JkA+j/5dSQzl1czqtjoC38tfLEMaVANHFGdEYVWxMNQ/Qes4kKvnzGIDsU1dVBkOs5PnpGz31UT8W+096YKN3Vqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929406; c=relaxed/simple;
	bh=aVOR1kMZvNVbb7P0q9FjUu0cij7GPbkbXL4xfxPJLl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID+056RaBfcoI+dut1saczfCxPtqPpUPmDKZ/0qLdI2fgTpUlE8rEAq91QqIC1clBExMYLHoGP5lvNAv5yjwjbtUUc9S3Tc3AKwwOKrfu+XPVe+xi8kd6YNEjSOXZNER4HAq/qXhL7C9hUeArNE7vQrHB6H0/py36fcc7BO/GME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MwUzIRRa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so6940775a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733929402; x=1734534202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8dnWOmRqb4jo70mTPRxjjcmIcXsEdmrG3vEqNYrZ80=;
        b=MwUzIRRaNzeL4PaDqDAzhDptqohaMxT5X3Gdr6qDffXESJ5hbsA03gGIlic5RI9LWD
         rb7CAMJk4J0NTK3zNMGBMw8g6Z6OV4qzYO9zGNlezuBjfPMmAnB8Cakpd97+QRpmr3PX
         NET1PJtwDkCB5EJnLXksdHSJTv74lKrFP5CKcPu8daY2fMTQxOx/cLDdH8vs/muZTzyP
         NmDe3gqg+bdGPyY3ThVyb+mssucI4VGZDnghTEVR7MfYERxa80FNUYIkYPObh0auIzDA
         4BXiClacvIBBSUB17KvzXS9i9gduIeivnKQL/Py8Uy0DjKyXiGd8rvfbginDMHTRaqkJ
         FupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929402; x=1734534202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8dnWOmRqb4jo70mTPRxjjcmIcXsEdmrG3vEqNYrZ80=;
        b=Lq4BQ6cWGxfsWeUsTsezBFgZg4GQfTZQFomDBRJ2tUXYc18QBA7SnyO2YTV2/id7hh
         b+GxS68bgibd+Th56WqIirh18aRuKyoMks3G2gLvsl9PM6F6kZLM2MQj5jM+JoaEFTY6
         y8hEDxhRQchFRNCXjphjzZqMknvIgiCsTh0ug3OlhilAKvN08CqLCWNXtMqGG1LlQCch
         2+P2EnWMdm+NbYHACVPm0iaB6Fu7MudOaOxwM9OlTplb4DJaV+oZneHde3dB5GfXnbYf
         XVjanlNUVXxamu5zghT9GXAUlHKTlBs1+kxyIIbGt69QKuphfARUv+BmEBoNRel65RwE
         BMMg==
X-Forwarded-Encrypted: i=1; AJvYcCU29n3mo76H1SP0xqAKH2afFIjXtFwEtGcz+aG+Y8rsWqvLfZEx5wm6h3geOkerUrOoRkm2rXvXuDjm6Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjGJ0lcE/yRIHOzzRCZGWJkfbL5VZV/REHCkwuqOxy/FGAJV6
	tFFvhLhFYHYG/7iHYgDw7GuWC5E8MW6IZ1HBT+v9tMprw6nyUyragZF6DezFsPc=
X-Gm-Gg: ASbGnct4AmPLmUZ5EZ/6i+NvZLJt91/BoA51VmLkM7nrGoBD+/fo78PgT/jMrw7fgnU
	jCs1yHZWauJ6NfXJtGKcmaqKhzE80UPUk+6HW1U05U/mb5arzvne9Dg8BJ3+NIG1tUd/hSr7bfL
	9kJpSZiYi6cSOPwvdVm+m9NFyWeUQQiOhRjZECmEXS5y8W8QvDbxipv4tZ0upE6eSNO5NdCG8p6
	odc+XPjcqaQ0B9T2Nh9dsYQLlB8FfV3oVqzXrC5pHXMn3OI8JVU5lbBGx9kdV1pCXHSoC0o4Vts
	ZVI=
X-Google-Smtp-Source: AGHT+IEfyZQjkBpjtQkfDUP1SDSf87pLwGAFcjL1PQpmjPQEkDD1ZpqqX5QcyT//c5faDJN6v/FmTQ==
X-Received: by 2002:a17:907:3a57:b0:aa6:2b21:ab53 with SMTP id a640c23a62f3a-aa6b11a3b77mr246814466b.24.1733929402108;
        Wed, 11 Dec 2024 07:03:22 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6801060e4sm524570766b.158.2024.12.11.07.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:03:21 -0800 (PST)
Message-ID: <df3b71b2-086e-4439-89bc-b55f192f6ab6@suse.com>
Date: Wed, 11 Dec 2024 17:03:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/entry: Add __init to
 ia32_emulation_override_cmdline()
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org
References: <20241210151650.1746022-1-vkuznets@redhat.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20241210151650.1746022-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.12.24 г. 17:16 ч., Vitaly Kuznetsov wrote:
> ia32_emulation_override_cmdline() is an early_param() arg and these
> are only needed at boot time. In fact, all other early_param() functions
> in arch/x86 seem to have '__init' annotation and
> ia32_emulation_override_cmdline() is the only exception.
> 
> Fixes: a11e097504ac ("x86: Make IA32_EMULATION boot time configurable")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

nit: Does it really warrant a Fix tag, it's not a bug per-se, just frees 
up some memory?

