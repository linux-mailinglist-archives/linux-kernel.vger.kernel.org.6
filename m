Return-Path: <linux-kernel+bounces-513312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8452CA348BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63842161CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00D1E7C3A;
	Thu, 13 Feb 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JwXF4ZR+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A71D54E3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462370; cv=none; b=E/BeXIb2pWMZZrGHEaSjSwwaCvnL7vfG5WZ3fcYrqcYePeB5YCNWQr4ttHNDKoVH7ORGmjCnBBhyFlKmXcWXDJGUXcEHlU1WRh2fJAaNOQ5wZ9t/Bh5XznFuDty/g+h+NE4OXMEt6gn/rKmtz6Gz+OvzA7+KX1lqe997BwF01As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462370; c=relaxed/simple;
	bh=xPGcVznUvLeFy3uiczY40uRubCYunGOPAh3g1r5/5j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhMFIiPkhQIODQyFzyTSr1NkQrOjMnQZcb63UgZF62aHP94ZOViHyZF6OvyLgEyMefCVciDSgsKV1sC2c996ZyEhzhdKfQ0xQPKHxP2VCFy8q38uEzIIi73ZVkNTmKpNMixddAU6qQulvBBv3Tz95y2095fYheFMnd4faWl4aVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JwXF4ZR+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab744d5e567so195801866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739462367; x=1740067167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPGcVznUvLeFy3uiczY40uRubCYunGOPAh3g1r5/5j8=;
        b=JwXF4ZR+zSLQklfH8u39dxGYOiW9H08Tlvar1VUnElOC00ZbPYluj9HoQ6cND1ES3u
         LY0JvnyTWfEYhUYyCRnGSNL1Qm0OOQBS38VfMQUQFUqlFiAT8i+7fIxTRD3bgywgC3Wx
         2QodNpZyw2ylOdunv+rZGN3jun8U1LFxmnipa11uPEdYUSwskh/dcZ4Q341dnZo74eCX
         KZpVxA837SlUBn5u1GmBvLX3BkEg0USzBNZy0saN0OZRaLuKyxxDj8iGcM0kv8svuHYh
         gMjf3VDt262hXNusWT6ufoPH4Pq2WknOB9OswvDuU4Mctvw5YKAn51PtCFigFBKyk7cg
         mXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462367; x=1740067167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPGcVznUvLeFy3uiczY40uRubCYunGOPAh3g1r5/5j8=;
        b=swbMGRJVL41wNVjG/CZfOY6KowU29Xw4rpNYyu6xxqGQjJwzcGSQttc3ecREyonMSf
         SSHFO8Mg39hNY+0X8n0gCJkVZLSXjwIVMo9Uos/KGwtSYBRpB6lDdPI9rxJw9bbM4U6L
         l2iSv/mDKkeDj16EWVbQAbRRSMfLPKaQMHZ76/rskbqkHSVJri8WTFHg9jZUSG1Wp0P3
         88VVOqOu/l65k7hqIOZBBgQLQKKzIqjuRBc+h8LkzeDWNuFpivbJyK5OUj5AQr7ZSfc6
         8vCF6sCvQWe1qXlYqeNiW1XkTqArz5al1k85HOqgDWcOw0z1zU8oedcCcoNrd6w5XFn5
         +g/Q==
X-Gm-Message-State: AOJu0YyqVMgVZ+RxsD4RUp+kXXm7l/9Zub0aQ5zTdDNaRXDkFiImx7uN
	ySAhC32F6xIeweempmvpYXAVSUemMCwY10ZMbi6Nc0a2zMRgN1F8sAx93WueAy8=
X-Gm-Gg: ASbGnctGpat+iDH3RTDgmM5mVD+DUfO1vn2TTU2fME72xAJsmL/hZqfmatfLe7/Iw7o
	TPFcDydUfQ+6wZ9f60BxFZJLPekrUAQvxk66WK4dvYObnq63/LIATtpmmkCJoUYgWxTVP66wp1O
	5KRwKYSctQ0yZEeW3zaZ4qXu7kC4qnzbergR9zyhr1JfbkWYb+rlE8/Scg0OhWuM0sU8QD2/zaj
	+UqgmgwUd9aaHhiVpZWKjWAqpGd8umxJ6GH2K0U0Aug1JyBB260+KaUTKlgjtYRJWwqUaZWcwSv
	y2afFGaDC4mk1l0dIRo=
X-Google-Smtp-Source: AGHT+IE1Ar+qat8FNp9iK4XzjwY3o0QaCkr8h1CdQyqi/nSCp7oGodOaTwvP54IAi0qXjPHA1g7F8g==
X-Received: by 2002:a17:907:c283:b0:ab7:cd14:2472 with SMTP id a640c23a62f3a-aba5150b35bmr293992266b.23.1739462366827;
        Thu, 13 Feb 2025 07:59:26 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533be1e7sm156907466b.171.2025.02.13.07.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:59:26 -0800 (PST)
Message-ID: <450e8088-c239-4738-a996-834734f770a5@suse.com>
Date: Thu, 13 Feb 2025 16:59:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] kernel: globalize
 lookup_or_create_module_kobject()
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, petr.pavlu@suse.com, linux@weissschuh.net,
 samitolvanen@google.com, da.gomez@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-4-shyamsaini@linux.microsoft.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250211214842.1806521-4-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 22:48, Shyam Saini wrote:
> lookup_or_create_module_kobject() is marked as static and __init,
> to make it global drop static keyword.
> Since this function can be called from non-init code, use __modinit
> instead of __init, __modinit marker will make it __init if
> CONFIG_MODULES is not defined.

Hm, we should later clean up kernel/params.c to use __init_or_module
from include/linux/module.h instead of its own __modinit implementation.

-- Petr

