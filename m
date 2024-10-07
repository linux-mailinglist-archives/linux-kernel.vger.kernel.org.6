Return-Path: <linux-kernel+bounces-353096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973D199287F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1591F236F4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50118C016;
	Mon,  7 Oct 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR1mJmZO"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A70165EE2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294415; cv=none; b=jfDIzZYOypia3jAkq4vsnQl7dtlvi0ydcjwToE7NT4/CDAidleLfXuT+lP1LoJ7TWh1EHhUEsKcnWiddqiVnkhV2BkNH6ia5Ue3OhW+Ygz0YJPiq7B1hm9hZYovm21AxPDnxw8jrj5H01LREPABeSOEoQVaXgenSVpz5jxoal18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294415; c=relaxed/simple;
	bh=KlFxkdDEvMX7ZRL1WhgreUGSLY9zWUAfebTgKIis0Tg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=G8Sgz5Za22N3nA7mYStOjVZ7d1P5PHR7dITSA9W9rZku6pxQgH11Ryw16dM6O6lgQtPOFfZLC5Env/rS/tw4JIM+mhe0b4/9j77MYTQaLTGo7v048LIYstHJedwWhIAmkezGN+YmQI1oGAnTi+w/n3QC/YMjCS2aaYlgyhduxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR1mJmZO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c89f3f28b6so6093558a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728294413; x=1728899213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIZYGUSm5n0CM1xfOyOcn+J2PQRTi3eRyKONbBJ1NXI=;
        b=KR1mJmZOz8X+xoN7dUgILeMNwqPVbroOKT9SLG/mNdYNEiuEYuBuhn7jdRhJMLD0xI
         7obs5oDAwyGF3EJXpVGYNFe4tHWdhbpxzQM7QTee4yYBJRF46wUl/gxoK/0I7TpEqE93
         gxKbIbhJV3koSz1jVIeGIQEFMxNTzVVwqMNx08IIz9xh0AkGaDWIVHOVPLQb1QvIDqDm
         0h1U+3R0RpTSjY3rEb2kgGWEsX4EDdttX03TMW1Ckr9ZisS/hcTcYvYo/1iz1HvyfQwu
         7mxC5Djn4rirlwP5Pffdb54NzLqcLE93zoEyj24VqIesVBA09/jylaJ+jV9HI31dDde/
         oV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294413; x=1728899213;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sIZYGUSm5n0CM1xfOyOcn+J2PQRTi3eRyKONbBJ1NXI=;
        b=ZlZTDI7Z3WVFJCOKjHZPKeQgYVz/9jsZCOftGMuXHj3bpGjWgAvdV6kcabYJGEzzf7
         v8gAi7dYhKofM0L9hSUKe9vPviIKpJu+pwvHEOd70P6A/cAjFbWsXqmqzgnjz8QjQZDI
         1sa0gJNmU9FIKa6bHAN2fjGW9yQ1NhD1kbptnK1HXVvVu4kFeRyz2/qGQUpfkryAhnWt
         Q+8ZBNjtjElIFMpXAVlDQx1F7/DP+cDFJz5+Uhk5nrBxdRxOPRcMP/D9nvMks34PnjrA
         6Cu6qOUwA9o2I+Ghy9Fdmf4p9RFj5fKBDjm00/t2OvCJJiQJ91F98CjminJfgCw4uxLn
         xqhA==
X-Forwarded-Encrypted: i=1; AJvYcCWkm/FfoVkEIO6186TdLVP0R+i3a+HZiD1aFHRQTlXnYr62UvoDxao2mNnbR2MD2SxDn6efwkv61IJSYEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYvQ13KMAzi0XRi4QXPSwKPj3uV05l6qikM6RwFsMwmZFgyLc
	DPoO7mp7LuE/qFoFDUnghB2Cg9MpEn86/GD8a0ypB/0Q+7r9jOQz
X-Google-Smtp-Source: AGHT+IHEMav/mhqiwv4Rl0XtoGZSLctL+PY6K8s9ycs+1ZRaigkFvSgNGU9ywK47/fmJDNEDOb1TNQ==
X-Received: by 2002:a05:6402:4015:b0:5c7:2209:e937 with SMTP id 4fb4d7f45d1cf-5c8d2e1141fmr9847728a12.12.1728294412638;
        Mon, 07 Oct 2024 02:46:52 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a7e87sm2983791a12.24.2024.10.07.02.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 02:46:52 -0700 (PDT)
Message-ID: <cd76a15e-70e9-4abf-9932-38d520b66205@gmail.com>
Date: Mon, 7 Oct 2024 10:46:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: shift and mask issue in drivers/gpu/drm/sprd/megacores_pll.c
To: Kevin Tang <kevin3.tang@gmail.com>
Cc: Kevin Tang <kevin.tang@unisoc.com>, Orson Zhai <orsonzhai@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed a shift/mask issue in dphy_set_pll_reg() in 
drivers/gpu/drm/sprd/megacores_pll.c, the expression (pll->kint << 4) & 
0xf is
always zero:

         ...
         reg_val[4] = pll->kint >> 12;
         reg_val[5] = pll->kint >> 4;
         reg_val[6] = pll->out_sel | ((pll->kint << 4) & 0xf);
         ...

I'm not sure what the correct expression should be, but the current 
assignment to reg_val[6] seems incorrect to me.

Colin






