Return-Path: <linux-kernel+bounces-266483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13552940086
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37ACE1C221B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B983518D4D3;
	Mon, 29 Jul 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL0H54vN"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AB18A93C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289149; cv=none; b=t1nYvsLRqTtmfao9jxBYnJD38ts0Va6R6KXPw+2GVYeA/5vw7mCqsb1PMxR6NZY+d7K7Y3nZ8yTlvfgp55NsfsYKGA9lva4pLxMCem6oJBUNRg+sk3kNBuOE2f8i6QQgfw27lo0ehSgI9O3uDsXk4lDUdfPpJegveqXN3oGl9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289149; c=relaxed/simple;
	bh=ZKY4QE8q3VAnLTSURlWscP30jdf97HBeG7B0gjM2qT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itL+YR/fZ3F5YXSMZxQILb5ghxpOIGdta72L8IyV26qOIy4Sy5Yv86BnIOd9/uRPjKCwZ0rEGCrHGd/9nHPZvkJyuq2jXW9ZJ7c03RdSk0Ig9AbTfROCSahdkD5m9hGwc4c6sf8ieaIrsVvZPk4Ur8TgWz7biiHxagefMQUYcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL0H54vN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so555714566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722289146; x=1722893946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xbu478JrkZGqTN2SecfNLUxeWNK8IU0WdYOsK9KhOXk=;
        b=EL0H54vND2FoxEQFCs1hD24XoWsBHhqYDNoEJn4U5NZcu8WLEOS1cW3FluoIIE8srJ
         3GPLVMGdS9FkO5CdgqeUnrUC35eeKx6nq/INfnLnBuInkN4LOrupT8kv8XsVSmAn4bi2
         TQFYBj3ikeKn0Xt9qdOywF0yZ0M7l+mWOWf19PXllFKuWN63pvF+hYuk+DVCh+W9rqxT
         hD/67jo10RpnwBrIrEPBT52dwAT6G/4C4I7Q3GxNL37fcyEMYNiaLIlDmVSNHjyqO/3O
         K24ZdkAhKK1Ca0zrM754PnG32mN27kRq7kiXkXz/iylsuuBEREdj+bKY6sfbeZPDwv/D
         7+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722289146; x=1722893946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xbu478JrkZGqTN2SecfNLUxeWNK8IU0WdYOsK9KhOXk=;
        b=LtVgBjCeWGE/jcUaWfcmDX2R1UCuYjAYDxHppQ1SWFFLAL/nfs/h/fkVZRDQGVJRUz
         KJyWcIryAjWWYSJXwe7EOr2+HR8rTTuzsToJQck0TTNCyGj2ekXWgl6vcLQQNU60Bs1b
         Ce9dSzrYwWYDeK4uV/JYxFFB9YVXqI61vrMV2kjCyRYlu+N5fpUt7yYXdBqsuL+DGoVo
         GC+re5PLbwk8FkrC/xd0lpV8dpKkXteZsNHRRxIv2CT19QLaO5Yfs9Qot/adiwTmDr4f
         l9hfWPVR1oTKW5pznUwWefawm9/iVEwZsXLhOEeQgLjaBCspOODKLPQGTNTopTx5h4AK
         g0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVSC4FXtV38/i9SRz5VSZGG9mO62wWGxXEqmOE9VZaMXWrdqKP6wf4UdPtkAAYlGAYQoYa2l1jZZq9Kgd/g63MC23ImpP3//efGt0OD
X-Gm-Message-State: AOJu0Yy9uc4+DfdO77/Nhr6C3RUjDl9/as1GoGOEEapxxBKnZFLv+9vu
	uLTtNKQ7TOvYVfUeIdCMmYmH5AeJPsVk4TwjRiYSwL9HRiEznouU
X-Google-Smtp-Source: AGHT+IEZFU76rsbjWXI+oaAFvgWT6s+1N+HIyBNRXxzXfgCzC4udfKj7bBkOXZCqGHkgVami9ZYrgw==
X-Received: by 2002:a17:907:d8c:b0:a7a:b385:37cd with SMTP id a640c23a62f3a-a7d400a0393mr445509666b.30.1722289145503;
        Mon, 29 Jul 2024 14:39:05 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4148fsm562108766b.121.2024.07.29.14.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 14:39:05 -0700 (PDT)
Message-ID: <17e81b06-7778-44f4-94cd-6a2b1fe5c7e0@gmail.com>
Date: Mon, 29 Jul 2024 23:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clang-format: Update with v6.11-rc1's `for_each` macro
 list
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240729-clang-format-for-each-macro-update-v1-1-9c554ecfec3e@gmail.com>
 <CANiq72kFpS5BE7Ea8=Z6SUi_Y2RAt5wsssHyqL3ocgR1UOHJMg@mail.gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <CANiq72kFpS5BE7Ea8=Z6SUi_Y2RAt5wsssHyqL3ocgR1UOHJMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/07/2024 22:14, Miguel Ojeda wrote:
> Hi Javier,
> 
> On Mon, Jul 29, 2024 at 9:56 PM Javier Carrasco
> <javier.carrasco.cruz@gmail.com> wrote:
>>
>> Note that commit 4792f9dd1293 ("clang-format: Update with the latest
>> for_each macro list") added the macro `displayid_iter_for_each`, which
>> is not part of include/ and tools/ (it is defined in
>> drivers/gpu/drm/drm_displayid_internal.h), and the shell fragment used
>> to update the list will drop it. In order to keep the macro on the list,
>> manual intervention will always be required.
> 
> Thanks for the patch!
> 
> That macro was inside `include/` back then, so now it should be
> removed from the list.
> 
> Of course, if we want to include internal headers, that is also an
> option to be discussed, but we should be consistent either way.
> 
> Cheers,
> Miguel


A quick test threw 326 extra macros that are defined in internal headers
under drivers/ and arch/. Including internal headers would remove the
need to update the list if a macro is moved from inlcude/ to an internal
header, but the list will need to be updated much more often.

Best regards,
Javier Carrasco

