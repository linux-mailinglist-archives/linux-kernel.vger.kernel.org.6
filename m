Return-Path: <linux-kernel+bounces-401577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053F9C1C75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD9D1F24399
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450571E32B3;
	Fri,  8 Nov 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="xr9hb/dN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D77462
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066839; cv=none; b=psI/PZYf7WHMYlBhlAXjRsbgyhRBbYCrtnYbKdbIMl55QRTBu02CQgTr/3LyzHPIGG9ptAJ5iLXAzZXZ8u7mk3EaXK1YbHMegzO6eDWq8Si11NWWe8d1ZY5+74438nzKiurUi9Xa+lRMVAODTxsmlKbv5SHPalnP/BwQNyczg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066839; c=relaxed/simple;
	bh=w/3bVEVmCsLyY1RQ4E3iWrdcd+dDKQMWvLuCOmFv/VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aUKq4GuWFdA3uHV69PiuIONRVgnmfbuzWF2smY+unAwPRN5HlOI3takBBBkELRgcFOZOInwJ3l/v7OtNABjZYzLJqOOry1zR3wCDAnhRVevuUb87u9PAOZ7d5oj5cu4VmObgDUAiJBw5Pe1QeRgeiKrD277lnujoyeZTYJbNAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=xr9hb/dN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so262749566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1731066834; x=1731671634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJ/QBNPXC+RW7xmA6I4st8O2hbtwshnY8Wrg/nnB/7A=;
        b=xr9hb/dNi3cX9oI5SZSIazuDpTvselhC/vFX7VudA3AYo1okMG/gsltAU7J+J9R23m
         O/pjV22iRe1SgNVVhhGAojTmqJrj+KFSXXn/Gze3+7RS8yVomJVo78QPAY0mfxtGz4VO
         YLfzkvMVi9rLnG1Di6wLTHxEz/0FzzZrEiNBlYF9loG5nrUqqTS0iARvalEFJRGqGX43
         kd4fKsY7oE+I5Mr+dwYlh7RM12Yh+4VI3CNPJbZmooV3+D8EypVTvptLTTvYBALgHw+U
         jSJaGt7KKmHoT8o7L2qll5c+ATYl1ED/+qSmsefkJtDRkAoBT3nYbgVP/Xs71KJ8Ca1q
         oO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066834; x=1731671634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ/QBNPXC+RW7xmA6I4st8O2hbtwshnY8Wrg/nnB/7A=;
        b=eifTShiYCkhf/lo0U1slRJLlOQOGpo6vUM7hsEqzuGS2G6v+RBr+RkAMO4AwCf7Jc1
         oxIGtlmpvZIlTu/iq500OCkiOroLDR5x9CmCVACE9vgzldOdFhXPkZ2Jz0DXaPevLLnF
         ioLbbi6Qa4qroxKhBllZKJis6sv8tKRlgXNQWZXFovC2Y873lErnCk01Cygz7Rs7hpZW
         lxdSQt9nhSM7O2uxi2Ohbo2VvtAbXt+Fadnc6rCAdB3SOmjK5NHguuVsD9ayS1ECINqL
         GgzBKeyCJpSxJ3tci+wGq/2V+fbI41k8hb5OTv5iUGwTWBBDUjNoVHETjpWW4BYxCYA5
         kvpw==
X-Forwarded-Encrypted: i=1; AJvYcCWC6vszFX/EjA3njGkzky5DsVZ4GEIq/3oljeNLZA6+TjphDlT4wz9cHpjwZJB/5GkiVxYUfXxSxzASybs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhEohUq1z32jIaDtSPDyz28IwMG4fToEPY3IeuRph6WbiWFqe
	3LC9MM75uu9CKT7tkLVSzMieVgzq3qs0kX3g8kliHTAbwjdPL/rgYelMLtlk9Rdexk3ZzBm4/7l
	71w==
X-Google-Smtp-Source: AGHT+IF0zBViiYdY08YuBRp5GYZS2wntjfJWWdzCqQ7+TzGaLWpU0dOr9IpZa5vesULSn8sMXYRjsQ==
X-Received: by 2002:a17:906:d54c:b0:a9a:835b:fc77 with SMTP id a640c23a62f3a-a9eefeb2b95mr227960166b.8.1731066834395;
        Fri, 08 Nov 2024 03:53:54 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defafasm223618666b.142.2024.11.08.03.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 03:53:53 -0800 (PST)
Message-ID: <0c4dc285-f218-4c88-87f3-b7c7c786cdba@monstr.eu>
Date: Fri, 8 Nov 2024 12:53:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: use the common infrastructure to support
 built-in DTB
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
References: <20240918045431.607826-1-masahiroy@kernel.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20240918045431.607826-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/24 06:52, Masahiro Yamada wrote:
> MicroBlaze is the only architecture that supports a built-in DTB in
> its own way.
> 
> Other architectures (e.g., ARC, NIOS2, RISC-V, etc.) use the common
> infrastructure introduced by commit aab94339cd85 ("of: Add support for
> linking device tree blobs into vmlinux").
> 
> This commit migrates MicroBlaze to this common infrastructure.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> I do not know why MicroBlaze still adopts its own way.
> Perhaps, because MicroBlaze supports the built-in DTB
> before aab94339cd85 and nobody attempted migration.
> Anyway, I only compile-tested this patch.
> I hope the maintainer can do boot-testing.


I took a look at it and it is changing current behavior.
If you look at linux.bin and there is no DT inside. But when you patch is 
applied linux.bin contains system.dtb inside which is regression.
Or is it intention of this patch?

I think there was any documentation about it's usage in past but never really 
described in upstream kernel.
But idea was that linux.bin requires DT to be passed from bootloader via R7 reg 
but simpleImage.X is linux.bin+DTB inside and can be used without bootloader.

Thanks,
Michal




