Return-Path: <linux-kernel+bounces-447696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4F9F3614
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC7E1675A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DB207DFE;
	Mon, 16 Dec 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n9Gxngyr"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23A207A33
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366574; cv=none; b=SUcOHgqfXOrq1+gW2IQ5NjB0qVsmlpa89zaTAO+7AQHUU6+ZVjArmbm7f7sFZSFa2hP++wS9dBVXsf6a6dKN3AQMLHyMELS10+d9whpLp3S2xOIseEaw2n5ozhrMITGTci2UHo+1gK3ikm+96WNsvUMWCisVA0jPDzowmum4crM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366574; c=relaxed/simple;
	bh=meBuQTqibPCoCdQtPAplVWCvCzXcGb+673eHerIjR58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD5QZ2YAe3UviZUvMN8pkcjLHBk1zcziAfUpEa4Hyf/X+qCgedLhVppqv138JmT5AlKnfSrV+Tg1Sl3D9Q837sj73NhTAPA984pv5Ji26XJjEbenqHLLpF6rL4BjeF51XYEnsucgxs4WXOqUyGmn/B29fCVSCHPUnJ+hobQLJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n9Gxngyr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72909c459c4so2692399b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734366572; x=1734971372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z59GLf8XiBlzN9yul/97/9j8EsBiViggAMyWm18iOo=;
        b=n9GxngyrYMbk9LZD4DISQHuePWYstw4KQq8OqQGsjcRNmMvo+VKKCrZGNTusEl9H1b
         BgtgfYuuPxAVl3bHYBqOL63EQAhxzo4GOJF9tnG+tjX3X8YyEx2UWEuUWf01AwyYJpSv
         t3l5YbMA4N3rLtin36AAl08WC1tdZRaI5hEEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366572; x=1734971372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Z59GLf8XiBlzN9yul/97/9j8EsBiViggAMyWm18iOo=;
        b=masG1ZVAHa/JYyxD8FhHlGasLV/2WHPV+c3rAykLsifaG+zxditcomRsEjUSVckwEQ
         JkpXaL5TcXrSd04nauENGHv6ex0295WiblpElWFdD0KcR0SaKLkP5KyNoFi5F8bh/7Un
         OI8zOMF6y9/VRQcIhdo+jdrioymp4R0LpWIvKYw6fjGU1/FFqHzys+P9yedr4gApRYWE
         CXdFPEJYtyiVeTiuUY9g71y52RTSM5Et/32s8OU1wKVCkg3wLtDkNFrobfs5rvB8eluW
         sdwHfQ8U4BL+j4VF25fDcKK0w8cqv/8wyBJDyxMbKlX0iBHfSKiblPScGmPpSgpaRtCk
         GevA==
X-Forwarded-Encrypted: i=1; AJvYcCU1btEuB93dh82c4Y4Dv0fFN+H/p/88KsKsH0PPuYhlyEcIqnp7CxPhwo+rCThVHxMXWXVui7GycKNz/+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2WG+PggdbyET4oKUdLZzGqS9SLcoqqLzD71p50g81E22NyDP
	8EFi1KBZ6YWxF5cnraJiTxane9wdXi17mfg6oSD2yI2Py0R5wmI7vBvKObjpkk7uBzYR4+lX+28
	=
X-Gm-Gg: ASbGncuOOPRYKoZUWY6ViGzPUVPocrGXAoY3jAXynyx2NV9FntJAGWmriLs+a569awa
	imFC3SQ+0NHAA1Q34VEjnvWf9HfsuXYiZ3HN6Sp+MAq2iiUvSjJnMIZMwgPYLvU9fogf4Ix2AJ9
	BhZS98UlQKXly3NNQVx1+ogW0U57q4Y3A9lfr0hYvI/hgOpfo1hPxR9GOQ/q6BJycaKj46t1s8n
	BJK8l/5D2pQ0jwk8aUCqsVsKnokxgTFAg9iY6yx91tswQgPxNViartp4nM9JamcgTAzpd/rS/6i
	AkGuON+PSKBp5k8uZtWhmkU=
X-Google-Smtp-Source: AGHT+IEKWZngvXh0L7tfITCEkUVaACE3nGn/f03qZFFxRJXSNNY7GQXwkVjtU5Co8RMjn/US5G/xjQ==
X-Received: by 2002:a05:6a00:90a5:b0:728:e745:23d8 with SMTP id d2e1a72fcca58-7290c261b59mr20466984b3a.24.1734366571805;
        Mon, 16 Dec 2024 08:29:31 -0800 (PST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad9d2sm4949505b3a.157.2024.12.16.08.29.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 08:29:30 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc88476a02so3303372a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:29:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx8m/xqxTz8+Uq87b0jZD7Ix+BVswJYs6SDS8WI95UUUOGDllyydHG3NHt+iz4ypSAXH8VGhCTZx76Q/w=@vger.kernel.org
X-Received: by 2002:a17:90b:5105:b0:2ee:ed07:d6d2 with SMTP id
 98e67ed59e1d1-2f2902ac693mr18968712a91.37.1734366569425; Mon, 16 Dec 2024
 08:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-ipu-doc-v1-1-e07f0b4f9065@chromium.org> <Z2BOAHleNCsuCoHq@kekkonen.localdomain>
In-Reply-To: <Z2BOAHleNCsuCoHq@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 17:29:17 +0100
X-Gmail-Original-Message-ID: <CANiDSCv6vC5uzeswB__biC42j=01-kZkoKYW2FQv-cDAULiKtg@mail.gmail.com>
X-Gm-Features: AbW1kvZi_6EfyZOTZs3A0KuJkDkszn8E8Jb-ClaSZjICowH_1EO2R4Flpkq-6vk
Message-ID: <CANiDSCv6vC5uzeswB__biC42j=01-kZkoKYW2FQv-cDAULiKtg@mail.gmail.com>
Subject: Re: [PATCH] media: Documentation: ipu3: Remove unused footnotes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 16:58, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Mon, Dec 16, 2024 at 03:51:28PM +0000, Ricardo Ribalda wrote:
> > These footnotes are not used, or they are used in a codeblock:
> > Documentation/media/admin-guide/ipu3.rst:592: WARNING: Footnote [#] is not referenced. [ref.footnote]
> > Documentation/media/admin-guide/ipu3.rst:598: WARNING: Footnote [#] is not referenced. [ref.footnote]
> >
> > Remove them for now.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> You seem to have written the same patch I have. :-)
>
> I'm about to send a PR soon, however if you can get this merged before
> that, let me know and feel free to add:
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Let's land your patch. I already marked this as duplicate.

Thanks!

>
> --
> Sakari Ailus



-- 
Ricardo Ribalda

