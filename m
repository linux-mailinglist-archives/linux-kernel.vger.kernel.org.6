Return-Path: <linux-kernel+bounces-359518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B158998C90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CFB2860F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301F1CB311;
	Thu, 10 Oct 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crzy0hDu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03081C1AD1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575960; cv=none; b=oMWU72Vto1F3UM3R/+nSkvntw1oT9KMvqllIhHk8X/fvBusQGOKOEEuu93+LQ/opnHoJ9ForN2fEtBmYUPnjGWCMLcRjBwRZk8bw3n6B8sSjvPqTcE2h1w9nVDWPwV/VmpgQwyg/APqOFdbprHWM7y2gwjFVDmsLtlVZKfB2Xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575960; c=relaxed/simple;
	bh=Hp93bT39L5NxcTeJsn/SDhi7NcZLFrq5s197x3O69II=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=St6cpFfCEBTae18H5sgpwCAruhrR9F+mEqSzvrRexCaL4BkuSBH4atRJqdGeFt9DpH8tj9Vafw89uYJ1PYBeCaOw88piM31P/krQ5Ltpmch6EKISBgjIerkT6AeBmdSkkj9AAjCE5qV7RXNftfLNvone0+Ts6W+Zix/vmgmEiGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crzy0hDu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9950d27234so160509166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728575957; x=1729180757; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwbGM2GBS24VwCv3G0yCYJQXN3/p1wbB4ScKP62AMAA=;
        b=Crzy0hDu5O5hfK/hcDHRSKRaUy3aeWP35T+WiuqFi4/r/1cr02JsT6CSh9zG35hgyJ
         qn3tt64raP7or2zjRaz4h75AndoXaTnqIFA6jgf1cu4Ne1VPQhh0h5iY9RUR4sKyyggv
         ZhTQSg/Xm6m9Wc9WkzpF0UzDwLpElB1ncwwJlaoVWP+s7zAd1dxJWOBbRFWAmt4s2/0+
         82WMvluo7z9jB/w5ysITCR3oUsa1UOAy4aiDPrAmOIGTKE17dyWMBpOz8bdimCMjuM8u
         u1OgnLobUdnXuFKnzy99KCm9EKQpYNKHNrE/YH4IrI5ZdeKgrRSfKMGURay8jXqI9kku
         5Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575957; x=1729180757;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TwbGM2GBS24VwCv3G0yCYJQXN3/p1wbB4ScKP62AMAA=;
        b=jK+dmI4hdfeFCEYlPYZ3vwaY/WZxmq2rWmQzN2RKV+jwoVKj9oO0qgwCwAwWYmTEuj
         0QNPL8fIaHkh5L6FvkfaZLKFcS+sRTLwzac+nvSD/Gxlz1QuLkCeMYsg82WTvb1iFWep
         e4qDE0TxIRQF1Zi6v4m68bJW7VjU4cTHMOZ8AdzUe1+VYoOv+7iezN8f44YJg/N/hV4M
         lBlcfx0jVRX0ZxE1HKuBvUhumaYCPLtxA3pjPsUmLVHzOeS97hCB6pjpSvknNdn+LMAH
         k6y3oZNY+kxujRrlZbRDq35Xf7TlnBt+mQ2o0tF/lseFAOd+xFdowxPpOsrt4ej20man
         IqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+LuGY5kcJQTKc/CELxmy5dz56NaCTWA2m/qmEZZUWtAfsJo4jMJsY69GldbJKxM18D5S+ePXwkfpLJSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3BxBTcmAgMxOCFr6rySSxcsa3APPkci+logHiMaJnE1hO+Nl
	J8Qfo09fmJpyz5Jof7dxYfsP581c6kBKaugA7YHj5dwID95/GOeQ7/EVMuGB
X-Google-Smtp-Source: AGHT+IElbzBU/j/0Stgy5/nLvDDKlh349Y4ohJfeszQYxvSNuC6NwtvuuGPvY9h7LABNl5BavOlG5A==
X-Received: by 2002:a17:907:972a:b0:a99:537d:5d10 with SMTP id a640c23a62f3a-a998cf3aee8mr538206466b.0.1728575957212;
        Thu, 10 Oct 2024 08:59:17 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a80dc6bfsm107133666b.162.2024.10.10.08.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 08:59:16 -0700 (PDT)
Message-ID: <ec6a9eff-89b0-4fd6-b3b3-5b234ee79f92@gmail.com>
Date: Thu, 10 Oct 2024 16:59:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: drm/amd/display: Introduce DML2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Static analysis on linux-next has found a potential issue in function 
dml_rq_dlg_get_rq_reg in 
drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c

The issue is as follows:

         if (min_meta_chunk_bytes == 0)
                 rq_regs->rq_regs_l.min_meta_chunk_size = 0;
         else
                 rq_regs->rq_regs_l.min_meta_chunk_size = 
(dml_uint_t)(dml_log2((dml_float_t) min_meta_chunk_bytes) - 6 + 1);

         if ( == 0)
                 rq_regs->rq_regs_c.min_meta_chunk_size = 0;
         else
                 rq_regs->rq_regs_c.min_meta_chunk_size = 
(dml_uint_t)(dml_log2((dml_float_t) p1_min_meta_chunk_bytes) - 6 + 1);

it appears that the second if statement is checking for 
min_meta_chunk_bytes == 0 and I think it should be in fact checking for 
p1_min_meta_chunk_bytes == 0 instead. I don't have the hardware so I 
can't test this hypothesis.

Regards,

Colin

