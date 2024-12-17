Return-Path: <linux-kernel+bounces-449713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464919F5533
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD9E17670C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B31F890F;
	Tue, 17 Dec 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dSB2ocQZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611C1F8EF7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457520; cv=none; b=NKfED/3Bo3aCcVU5vtyAmqsPsFjWA6kCWEQ1NEcwaoiwV09oaWoEyK0KczX/TlKJvzg3SW6alCBGpDvgae75U/7p71GGHR8pqG9J0o3eo9iJAyETkTBkQlCbIaM8sMLFukRpTegQr5gcpALE4RN27470MGsDDx33i7GjGXAblc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457520; c=relaxed/simple;
	bh=uF2QxkbdwYGBDuspin/06l8N8afAX84HoqYIkjMvILI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZRc6lCLAT7oDegFN7SQzelzDfE4ifMStP4fYz5tv/8JDf3Gxu7jQLVaNFYZhzj6lgLuzUHIsWhssbHGQ8imyT1YQLmFuGC/bF1o6qPHKA+v9QcOrrOrn1MftNRy1WssCTri8WpsrftM2+kPnCugSIIqYDPgdxz5jBwh6PZoUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dSB2ocQZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a766b475so59074825e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734457517; x=1735062317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guzXMmcogdP4Q7ZaoG1GlbeOyFsvryanY60rqbwUifI=;
        b=dSB2ocQZH5V0lOteUBwcyopIvrmnOyNaJXR94EK3+7phItx4evPRKuP2OyxvAqUIap
         neAunqBuIfpneToZ7CNrn9s3YZoXk+fx6kwr9GTlMe7SJYlvBPS1UWj3RHGaqG6OkHiI
         vS9PaWizwMa5IzvAxxrZ1JZA4QMHQ90qDszNwmJe4cZyiJRsglCl1xMqChusiZx6vuFv
         Xt1JlJF+EXAgUqlH49XKvF7GtkqMo2Ar+JU1EqlRR0CuzJRXtwDZo+VoruqvFhKHlA8U
         cH7j/ZYw3F+WF2dP6IhnR5X97iTz9HRnmQRUYGIBUI+4N7f0AHzAq8hU8CTvpNypKlAM
         WPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457517; x=1735062317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guzXMmcogdP4Q7ZaoG1GlbeOyFsvryanY60rqbwUifI=;
        b=E8gfqHrNSn5Ppij/w2hk0Y2uSR+/nRWqn7wjOL1QF4c06dC8KTLnXl3PaX4RxZV0HZ
         uRNgM6CafyCEswNPZmVhz0nqqtJwaoGXHbCDxXL4TtMu0OPCWA2eMu1LZ6qUYWxl0ZWl
         6oP5NIKUqDmv3txmnTuzFTmGYrse+8fVvgzWVbmCKTmj7Hs52foU6cpPzhpIRXtf+Tt9
         0MZsNZaFjxXCVBOx39elOVAXRnjF+c/fXRxSGSyc+IfL/WlURpVmcNvBk3GF/IVsgnSd
         f+AOwx53BtwrJl8YNnbyWPBvBcnCVDZoJF+gbxC7QwRzBlLA92sy7Anr5L0bkcEsSVKO
         dXKA==
X-Forwarded-Encrypted: i=1; AJvYcCUJhZ3Y3LvolKduyyCwaZUgN7e6zVKcd50trasGfsHlE8tNUnlf+JY/L0vs5yfxF3veBC7T0AN2KxA8mFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTarUpiTTTID4FZVR4/W5DN6hegvefIZ6BBdA5KSfe53DBntwZ
	T5+LFQAhC7asbZ9/LPyeomoRhOMw9R1+jJxSDYDZ77nsxdUzR7GKra3XYQwZ0vg=
X-Gm-Gg: ASbGncti45DRCSUf7oeXAc+4rGOZ6E6mn6xPsMH9eoXZvUqmqvSBjVt5HUe8L3SbQfa
	JCNKZKZJTJQllrPMFpbaviN1Ax/u2nu8v69hMLpTz8oDvfpXGaIlClyNQS0GVb9WVxfxDkrPucR
	d5fQjiGGbgdQ3yol29bvLxN/9Z5McNoGECU19lpcv0Cd9EFFwic/U2Sq0Iln1ysTqwqxAdP/Vwh
	9jOB16cgH87jUylrm9aSSoFjtS4fftvVc4C7gL0tDqbsM2JynkZKVfS/iYP
X-Google-Smtp-Source: AGHT+IHh7ct8eaePkucDEFV58KLJO8R3EO5zdjf3vBCZcZJe01PsEvPnBbD8xACvsgbd8KkOpWoPJw==
X-Received: by 2002:a05:600c:3b24:b0:434:a1d3:a306 with SMTP id 5b1f17b1804b1-4365306d45emr2189525e9.5.1734457516775;
        Tue, 17 Dec 2024 09:45:16 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c696sm177414435e9.17.2024.12.17.09.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:45:16 -0800 (PST)
Message-ID: <7a41a098-52bc-4e96-bf08-fa86b58e0075@suse.com>
Date: Tue, 17 Dec 2024 18:45:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] module: Constify 'struct module_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/24 18:25, Thomas Weißschuh wrote:
> These structs are never modified, move them to read-only memory.
> This makes the API clearer and also prepares for the constification of
> 'struct attribute' itself.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (3):
>       params: Prepare for 'const struct module_attribute *'
>       module: Handle 'struct module_version_attribute' as const
>       module: Constify 'struct module_attribute'
> 
>  include/linux/module.h   | 10 +++++-----
>  kernel/module/internal.h |  4 ++--
>  kernel/module/main.c     | 40 ++++++++++++++++++++--------------------
>  kernel/module/sysfs.c    |  4 ++--
>  kernel/params.c          | 22 +++++++++++-----------
>  5 files changed, 40 insertions(+), 40 deletions(-)
> ---
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> change-id: 20241204-sysfs-const-attr-module-927afe76eda4

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'm going to wait for a few days if others want to comment and then plan
to queue this on the modules tree for the 6.14 merge window.

-- 
Thanks,
Petr

