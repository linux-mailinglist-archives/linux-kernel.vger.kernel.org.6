Return-Path: <linux-kernel+bounces-573835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F70A6DCE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604AE7A490B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810A25FA16;
	Mon, 24 Mar 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Gmg/8sTf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3625DAF0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826343; cv=none; b=cOleMzgOWsh9jQHD0Q64Y/f1YSphc5vosQU3OP+1I76piCQ7vwF2HL6TIzFvPtP1b4yhQtRTRMGmGInjmtf+3IrYDXFZM6s3FM06XxRAk0u/Ub6N3L+v981j90106C9C+IM96u06u0N8mnEzqWktzq/gHP2t6z3A1a+vK/7C8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826343; c=relaxed/simple;
	bh=IoiJglPwGwlJpMC0UMeANARMm2kcf7CCM08KAayvmOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulQ4z/crbyo7H9hNWIAw4keojmgH5iVU67PYCL8UbxTUi8zIlBza9PleO1bHVD5yUHLQ01Sal9IUA89woaGokZz7eOtwllxUfHmYuXBPBOdBecBgfgRyclvGk0vNOEmlb43870goe0pRmhRJzWf9peEujwAxg+nJ+kdIqwPvZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Gmg/8sTf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso33333735e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742826338; x=1743431138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNdG9O5jTJR2BZ94MdoCjTahgOrdl4gZ3SIR34gpAIA=;
        b=Gmg/8sTfsyom6GXNFz3D5cwXI/pwPd3gGm+8dHn6yGbqxZAqxFtneZONSMw37tYPT8
         aVDZ0YCAjhXxDVuk9D/5KauYINP/jLXUk6b8Ys+VQT/4Ian5eF7tKCNFsoPb/l6gA54p
         pOVVDn8pJ0J+QJRL1lNz+rkO2oumd8rqc/i3KJ6GeqEQp5e0jijYu1A7E0QSZtsfHMNW
         yapczrLRXrhYQen0coO/gu4JMMYL1xuzkw7kijnFrSqCTEIVRhxuMdAPRMjbSBCdnKwe
         pCg0p7M6Jd4YrLwP0C3dtps1TO1xFQFhNV7TUx9wCLSJm1XTEu5ibY5yY/FnH6+VcEqR
         gnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826338; x=1743431138;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNdG9O5jTJR2BZ94MdoCjTahgOrdl4gZ3SIR34gpAIA=;
        b=HgTYNBszDrY/6nyODFE2JynsCqi48FP3ipYrDMRMZVq8Nob6XmW9EudJwI4xhWpudA
         e/bc3ivo4aVeV/62DtL2aK2APB55vEgMqYYA+GqhB0B6fyT0vjXu6vR/wt6Z04n3Uceo
         cBZH/EWMKZCb4+6/Ti6DZMQt1ZDgiG2/25ZZQhEHya4D+/MfcRm9GHtObhcEqpcLgfum
         y+rzFMEhGecK++4ydH1jwWZ+lVfjWhLqzuBEECb/lsyYgPNuLOB/hQ3btuLaxYewieg7
         D3tjQCGgZv8ktL2Z1Ddsip8V9Pggm+cJYs2RA+kTaBUUBp8dX0YHOOdELg78mrsNlV7j
         S6sA==
X-Forwarded-Encrypted: i=1; AJvYcCWV7XL2sFUqTk+9bhfduQRaDMQdQoV5pbelBfPES7tGY22Zvt07OUIizIrAnQP99s4sQFeoHALg+Sy/0Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxIQdm53cEJ8bFiEToyTeKqg8CmxgVodvSww/Fu+qwEcRrpNm
	OIb+7iVJR609IcI7WRzQpDWzOKXEaxZqDchMnEl77SCTwQuYbbF91dtrJ5/Y7fA=
X-Gm-Gg: ASbGncsjgtTad6+XPYq5lQ4yx3G9cUmNTwjBdjlt2yJLv5epqKGndCpZgcTX7m3cxxP
	8aUNJAJA5g+xL9mufPQh4zxekSiEOgHg/0+qdS3+dLFvHAjYKnZh3/+3MiKio+Ps5gJnQ2dh+Rg
	SZloGgSQHtrBmWltqs8eApvDxpmm9FmYB5iBTic3kiQYk2ZODCKw5MJlZEM1VY8fE9CPfg4NaHg
	WqP1kZHHryoSCc/2u+BWR3Zk6Lq+Wj/CtisxtNW9MCgkv0XzwWPof9oS+Zjb/WeKX/nnz5EKCx5
	g/QylA40eUlz5Eb6iZltyOhydcaevs4bSk0M/4JYjdKwzWpad6JK
X-Google-Smtp-Source: AGHT+IFacJgdL0YCtYfMpOjSJaGjYTLUuJu+RCC/1A/kfH6d1pa/dPUdShqy13vrh/HjglhK4TnpBw==
X-Received: by 2002:a05:600c:45d4:b0:43c:e8ca:5140 with SMTP id 5b1f17b1804b1-43d50a3189fmr122312855e9.23.1742826338160;
        Mon, 24 Mar 2025 07:25:38 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4453227dsm178498245e9.40.2025.03.24.07.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 07:25:37 -0700 (PDT)
Message-ID: <3ea4b352-c679-45e8-8ab9-84ba074c3e88@tuxon.dev>
Date: Mon, 24 Mar 2025 16:25:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: page_alloc: Add kernel parameter to select
 maximum PCP batch scale number
To: corbet@lwn.net, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, paulmck@kernel.org, xiongwei.song@windriver.com,
 ying.huang@intel.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, geert+renesas@glider.be,
 wsa+renesas@sang-engineering.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241126095138.1832464-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20241126095138.1832464-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26.11.2024 11:51, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid
> too long latency") introduced default PCP (Per-CPU Pageset) batch size as
> a configuration flag. The configuration flag is CONFIG_PCP_BATCH_SCALE_MAX.
> 
> The ARM64 defconfig has CONFIG_PCP_BATCH_SCALE_MAX=5. This defconfig
> is used by a high range of SoCs.
> 
> The Renesas RZ/G3S SoC is a single CPU SoC, with L1$ (I-cache 32Kbytes,
> D-cache 32 Kbytes), L3$ (256 Kbytes), but no L2$. It is currently used in
> a configuration with 1 GiB RAM size. In this configuration, starting with
> commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid too
> long latency") the "bonnie++ -d /mnt -u root" benchmark takes ~14 minutes
> while previously it took ~10 minutes. The /mnt directory is mounted on SD
> card. Same behavior is reproduced on similar Renesas single core devices
> (e.g., Renesas RZ/G2UL).
> 
> Add a new kernel parameter to allow systems like Renesas RZ/G3S to
> continue have the same performance numbers with the default mainline
> ARM64 config. With pcp_batch_scale_max=5 (the default value) the bonnie++
> benchmark takes ~14 minutes while with pcp_batch_scale_max=0 it takes
> ~10 minutes.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Can you please let me know your input on this patch?

Thank you,
Claudiu

