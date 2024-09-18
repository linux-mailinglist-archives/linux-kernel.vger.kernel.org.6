Return-Path: <linux-kernel+bounces-332242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F73997B71F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A81C2275D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445813A3EC;
	Wed, 18 Sep 2024 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GapMs7y0"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5415A8;
	Wed, 18 Sep 2024 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726631250; cv=none; b=XaM0kRqg1ZrJtzRanjB0MjLImHRV/1N7vAGA5yK2GnBKMXGZD90nevB9sNKF3nupXfgiaGCRgws4uJJWky0o+LZlYaKHiodLflFtJB4nJy22Kv45sMhRoOc/HW/QwjrcQMp1IntrnZJojC1CC1Hrtadr0qYF0kdfODRq9Rwz3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726631250; c=relaxed/simple;
	bh=58X/TgvscsT2tXLBMcF9ubejg4ZfQHhEft4gnCGLXgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLCM4XZhEGf1+PWRUHV2VPui4+SzAa0LFg9+XERgn0HhEH64UeOL8ORvZc4X5L3tchqFjr6Qf3WUKyZTV93ctxAl+Q/d6rvUyr4ZNqLeW9n321cAsX8/GrA4JT5INerGGtr+SDE51EmeyipJaL4ILaPhgo3y1hCB2H2eyoodhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GapMs7y0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso5742575b3a.3;
        Tue, 17 Sep 2024 20:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726631249; x=1727236049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfmZNnGUjcPsKd4I6+4/DU7TrHW57wL+hIatiXkEgWE=;
        b=GapMs7y0ihle7FwXnnQDE08abrBXhQrQRN0BCiGUHXrIqvbhySMu8LfPQNI/Dn4VNl
         dVUkwhL9VR1WO6attpxvBc1nXU2z68hluNqs1BJkfHZ0nePXK9xdaElsgcXdALjHO0f4
         rzzTdmcbST90sxH5QHFS0ZgJv/y997S4Nq7e2Y/6Da39iVd7OnV+EwhQEknk4KnW1LjS
         torjvFB3iRFByQ3zKT09mlxeoM2gmWu/WTJ+PjEfUai3QsZVi/8FQnE6VL24CHqx+Vlo
         OihWoU3ccWOO2Lbh8K8Am/7kCmgbmz07ToNCYIifcM8Kd2UG+O1OAIHC+8IiCIVz/GMl
         Q8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726631249; x=1727236049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfmZNnGUjcPsKd4I6+4/DU7TrHW57wL+hIatiXkEgWE=;
        b=MvdbifiByVPKivm7ZK50iVoKCvw519wy57avyRCwiZuEo2dHT32ec48seqLppW9JWX
         w2bH1W3vAgODOjvn+5TV+mufYjpfOBRgpbhYd/lq+g2g6JrPmgO0ajrdOxKFSvMufUQg
         QWzCPadoUkgmT2SKvJ/Z8jDnRiHuTVhKviJFxgqh0L0iBsGaA1nbaMQ9sLH/s91O57gw
         gmcR8GttAdOsxKy/Q1Jkv2MuXCnwFNMjJIFpfbKzPNt8CYqnC568eOtVwe+kiJqQJCLl
         vpM749JZkwVqwRvEACUH8E/RQ4a6EDNWHSMha2HGmrthoz0IEvU5SP/yQhjo/ew5jTd2
         KxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKWSV5LWU8zQAAb8JfTbrRbtpCVSYuKLieQiGfoDrgykAd+l1PLfQo7kl4H2oq4bnGM9B/GG/1nn2+D9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlaxgsWvSagW4Ybon/DCl27j0bmtnaNgAvU1lkTCB1OATdyijX
	n5MbpX+Nynj2qDzT1V/lhe4gjWDcdLlkgxJhGr/qt+5TJyLCnhCF
X-Google-Smtp-Source: AGHT+IE69hNXvpLKjXCCeKPuN4DRnlIE9DiZCWoislIQOQb6yJe5YTwCF/vtg1BivTTOqrbl4ITfHQ==
X-Received: by 2002:a05:6a21:58d:b0:1cf:5370:3b0 with SMTP id adf61e73a8af0-1cf75f00300mr37076632637.12.1726631248697;
        Tue, 17 Sep 2024 20:47:28 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm5877550b3a.34.2024.09.17.20.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 20:47:28 -0700 (PDT)
Message-ID: <a7697015-fb68-49d2-9ed0-4ebb3760ec10@gmail.com>
Date: Wed, 18 Sep 2024 11:47:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Docs/zh_CN: Translate page_tables.rst to Simplified
 Chinese
To: Pengyu Zhang <zpenya1314@gmail.com>, alexs@kernel.org,
 siyanteng@loongson.cn, corbet@lwn.net, si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yaxin_wang_uestc@163.com
References: <20240917032241.27623-1-zpenya1314@gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240917032241.27623-1-zpenya1314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/17/24 11:22 AM, Pengyu Zhang wrote:
> diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
> index b950dd118be7..0765d4d9758c 100644
> --- a/Documentation/translations/zh_CN/mm/index.rst
> +++ b/Documentation/translations/zh_CN/mm/index.rst
> @@ -53,6 +53,7 @@ Linux内存管理文档
>     page_migration
>     page_owner
>     page_table_check
> +   page_tables.rst

Is this work? Could you change here to follow existing style?

Thanks
>     remap_file_pages
>     split_page_table_lock
>     vmalloced-kernel-stacks

