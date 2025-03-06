Return-Path: <linux-kernel+bounces-549478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD74A55306
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246CC1697DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F312255E54;
	Thu,  6 Mar 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1zoxz25"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8331922ED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282009; cv=none; b=X5YTWkErQuEfki5x6VoibdqP+bOmIeL8l76zwreHmNFwrLWKiBeoZJJOFfDrrEemX7dpGe1QEIDVyWAPp8nw/4jIozky4jWZ4rRYV9PYOJ6WtZfBAJa2sA76jUcOIa+avdPc8KfUFBxnFj64O1mG47jQY8LD7+GvDCG9XcLVirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282009; c=relaxed/simple;
	bh=7M4ReNQ6MsdzfiEljvJghpHsdtA3ty01aDzhlWb9TVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXhqLkDrxei5i5OAYf3y8xZ2qsmKOUQ8wj/en/PaOeq8ublDRheRY3zTqei3p4K7ULKCuMSUooWifs/45SRGZpsSUAWlZpqPIrsCLkUUJB6KC3XhihJGnDMcUTzSu4xVWNkr4SQ4Iy8iHnWoMZ2HlQqO+Ehs2KiS2pIQbM/G+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1zoxz25; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso23717565ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741282007; x=1741886807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUVuOcA7Xkw74Zp9Xpn/wz9xV/4PaE7REr6k2Oyker4=;
        b=c1zoxz25jfD1udSHF+4xaad4sGYMGS7CkdcIj4j+QFeihMpUp5sBXdL1RiSbuD/Wgb
         Ag8q4qkntRC1vWmzWY84QntrsGUEnfdEr/56yeGxMt+DS+7eQi5A36Q7UQlNQ632m9Ox
         OnxphzGaLTLMFm7Lm890W0cVnbQSf9IvYqQUkYLo2WzHF6W67h8m/gzdj7CRneWo2WjH
         br324WbbhK6Hyn3QsM1Y7T8/P54EuSFHZf3ECg15sKtonpzd1J83clFixzgD4IF8nuYT
         GrMBJx85htZXt158nytVkGbY9gYtEaaFiNApSOW40fpG99NeR3qnwv18SSUFPfi4bb7N
         3ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282007; x=1741886807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUVuOcA7Xkw74Zp9Xpn/wz9xV/4PaE7REr6k2Oyker4=;
        b=r2zAHzIVJ9f5uUDZqNQdRgm8jJLvVQ48DIWq0CFER6ZIwt9DE6pI/0/kKFeDPMuj9n
         pNPkQQym+2JYISvZsbzjJp0n7xk+qbxxwByVP+YZ0cYoBbauCceTUzPPeGVpPZTpXXer
         0qXM5pRBNfjRSF3vD1+LJ8YarV+6h5lUGOVLGCxq+WcqQ4NNn0/x5gRl7yoSUw3O/J82
         q9AFovQ4M/NmRTBUwE54Q0JweKwYSoMZxilwsiJyWvKr5rON0Fy8qmMbqFPpRB0wL0fU
         klrhlULI1sjFGe/aWYpTn0QRaaWS9e5+8f7i66/RGseaAocwF2BQeL5GqT2HJQZ4A13o
         o0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUnSh6abBeghrhTZE+ZLKKGRNWfTbsyZCS70e5BfAcvaWueswOWco5i4/4psIG9CPcCX5J003XSF1ZGjt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqtOBWL2pef4omWD7olh9PAyugoA7eZQ6In/uqy8F3xnu8xTD
	cn05Dv/8UOzo3gUA3jUOUfepTJc6TOZAravX3XplUv+CDIX/KKYc
X-Gm-Gg: ASbGncseWQPVUeTyeKy9MyDlGXQaKKa/wtsjaTKC8lJBHLPo+z2J6GqRyD5maEGbOKN
	9jGPhqqBpunvCgQc6eYvoEsgPekwGZJooP3az20JAdX7Uk4UZhOii5dpl/JC/oGti5lIWycDFNV
	BrwkfTdEQWnsI31J9iIrvWilCBekZoV8cIgxN1yzB6NRYbjRgfy2LUhXvFBhKaAdiV/OWNXVUB0
	P/oq1sTx7hMtsTprCex8euQ49aAcmYC4kTUlmkU84uGODveQZFfZ0s8hbsAO3+Jk7d/n4eFmTmw
	lRPmBoCzHonAgQCmoxWfGEd9mX4YuqWTufme73lg9/ByINOf
X-Google-Smtp-Source: AGHT+IFKdP0qD7QXqNn7oGh20oobzZkggOG/O0IBDwU5pBdo9xJWaSDjC24OS3qtDcYgOWvBmDUaUw==
X-Received: by 2002:a17:903:8c6:b0:220:be86:a421 with SMTP id d9443c01a7336-22428ab798fmr1452305ad.38.1741282006768;
        Thu, 06 Mar 2025 09:26:46 -0800 (PST)
Received: from [10.3.72.248] ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa543asm14920025ad.228.2025.03.06.09.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:26:46 -0800 (PST)
Message-ID: <cec91b2e-d639-4d9e-ae85-33d27f634800@gmail.com>
Date: Thu, 6 Mar 2025 22:56:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
References: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
 <20250306-clever-lime-tanuki-e2fc43@houat>
 <CAN9Xe3SDyC47HWww1eH63aZOiM-WF9BGxztM3yh9bf6ORuY7VA@mail.gmail.com>
 <CAA8EJpqBy22eWZjccT5_UM2PQGjiG4ZEfrb6S_1tP1w962rd8w@mail.gmail.com>
 <CAN9Xe3QQLze9ZBbWG=KLYHzaFLZsmhah6GrYKmKMCd62rYP=OQ@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAN9Xe3QQLze9ZBbWG=KLYHzaFLZsmhah6GrYKmKMCd62rYP=OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/6/25 9:03 PM, Anusha Srivatsa wrote:
> On Thu, Mar 6, 2025 at 11:29 AM Dmitry Baryshkov <
> dmitry.baryshkov@linaro.org> wrote:
> 
>> On Thu, 6 Mar 2025 at 17:10, Anusha Srivatsa <asrivats@redhat.com> wrote:
>>>
>>>
>>>
>>> On Thu, Mar 6, 2025 at 4:31 AM Maxime Ripard <mripard@kernel.org> wrote:
>>>>
>>>> Hi Anusha,
>>>>
>>>> On Wed, Mar 05, 2025 at 07:01:41PM -0500, Anusha Srivatsa wrote:
>>>>> Move away from using deprecated API and use _multi
>>>>> variants if available. Use mipi_dsi_msleep()
>>>>> and mipi_dsi_usleep_range() instead of msleep()
>>>>> and usleep_range() respectively.
>>>>>
>>>>> Used Coccinelle to find the multiple occurences.
>>>>> SmPl patch:
>>>>> @rule@
>>>>> identifier dsi_var;
>>>>> identifier r;
>>>>> identifier func;
>>>>> type t;
>>>>> position p;
>>>>> expression dsi_device;
>>>>> expression list es;
>>>>> @@
>>>>> t func(...) {
>>>>> ...
>>>>> struct mipi_dsi_device *dsi_var = dsi_device;
>>>>> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
>>>>> <+...
>>>>> (
>>>>> -mipi_dsi_dcs_write_seq(dsi_var,es)@p;
>>>>> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
>>>>> |
>>>>> -mipi_dsi_generic_write_seq(dsi_var,es)@p;
>>>>> +mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
>>>>> |
>>>>> -mipi_dsi_generic_write(dsi_var,es)@p;
>>>>> +mipi_dsi_generic_write_multi(&dsi_ctx,es);
>>>>> |
>>>>> -r = mipi_dsi_dcs_nop(dsi_var)@p;
>>>>> +mipi_dsi_dcs_nop_multi(&dsi_ctx);
>>>>> |
>>>>> ....rest of API
>>>>> ..
>>>>> )
>>>>> -if(r < 0) {
>>>>> -...
>>>>> -}
>>>>> ...+>
>>>>
>>>> The point of sending a single patch was to review the coccinelle script,
>>>> so you must put the entire script you used here.
>>>>
>>>
>>> I was actually thinking of sending patches per driver this time around
>> since Tejas also seems to be looking into similar parts....Thoughts?
>>
>> Have you discussed it with Tejas? What is his next target?
>>
>> I was hoping he will have some feedback on this patch and we could take it
> from there.....
> It *should* be okay for me to send all changes in a single series...
> 
> Anusha
>

There's 5 more panels that use dcs/generic write_seq(). Maybe I could
work on those (himax-hx8394, samsung-sofef00, samsung-s6d7aa0,
boe-bf060y8m-aj0, jdi-lpm102a188a) while you work on transitioning the
rest of the panels (excluding these) that use other functions in the 
old API? When either of us finishes before the other we could have 
another discussion about splitting work if necessary. I'm open to other
suggestions too.

>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>>>
>>>> That hasn't been my email address for 6 years :)
>>>>
>>> My bad. Will change this.
>>
>>
>>
>> --
>> With best wishes
>> Dmitry
>>
>>
> 

-- 
Tejas Vipin

