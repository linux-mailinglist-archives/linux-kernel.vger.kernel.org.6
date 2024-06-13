Return-Path: <linux-kernel+bounces-212422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC3905FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168C61F2217C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB5B646;
	Thu, 13 Jun 2024 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WArGPxdV"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C0652;
	Thu, 13 Jun 2024 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240530; cv=none; b=dZdm2mlywwPp8+CncWLWddWT3z55TuZ03OB+njWY3jqfBip0AJa7uoBgWTt6yUxkDt+iHoMwaz4W1CIqnzilCkS58ksaj8LYKCw1hgoQTJE1XeNVAXlkhdvxacrGQWh3AUB2RlPJnnZOhgUyde3wgScVZmdh4kg+kc9WXbvmZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240530; c=relaxed/simple;
	bh=FNx9Jh1yLycyyMcUdEKiG940dNY+WlgdL4Yhrylgyuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCUMGiVzdpRdd3lNCS5IfdI8JngOMeflkKqTlnf8kVZSI6DZYhfRuUmr2A8QygE6I8AQfdfniw5VJJz4g/QH4s0p3Wf2kEn/Gp6sh/JaGWk0OBG9wBfidwqZCZiDtaFyZudpTe+4xRv3GoP4vgseuzyb85rYdOPuo6doXCfUfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WArGPxdV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so343538b3a.0;
        Wed, 12 Jun 2024 18:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718240528; x=1718845328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Xq6ZkM15jzoghR9TLrjerber+lm1cEhTFqwWoIvG4=;
        b=WArGPxdVIMRYSl+JYst7HuXJ8lP/46cMfTdO3yV/Q8Pey2gG3Qxs4W6T/mKnSkOTkd
         d/yntukI/ylow9GW5b4A2ErVOMAby+BuaFNr/aq8TzWAoaVjZz3ZGbjNsf/50U79Vj4S
         GTgiegUxJiEFwCSXW4elc7meTfarih17OSVUTemNA9/CYN7SsqfWp8nxf8VY1iTImdVQ
         uFeySGptJcBa0qq1p99vJuWRwJtme5xuR0+wqcQPtR9+QQfRbLF1rtjLbiYjgRm/3Zil
         tklpb6JOnGT3pONdwLK0ZM2Gm99cK0+aYkR/S/ouclA4U+XUfFCyz5x5fBnG4lw5FOZU
         TFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718240528; x=1718845328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Xq6ZkM15jzoghR9TLrjerber+lm1cEhTFqwWoIvG4=;
        b=CwrjdLXvjaJUWOvIDGxk7T0TJobbzueXx0tQovoEj2HV4LNxl4zA80TVIt5P/zwN7w
         rafEJdjLdAOnh2hgXUi0mxG99WFXjkxBjYTREX9Vy31e9BP/ugvbsM/StjRVs3bjMoOw
         f+4eotoMU+QAaCrCr3Jl5fdgqonVhnJkehwrfwvDUyXZJiKQnWhRDMQah3UPSzGVE1QQ
         K+gtY4axN53mbM6Xm+GN9ZlsCWlPJ3qUcppOwOXR2BgO5CNBwaIZB3P05BYQ2cPQtDSh
         NjUDal0Gv56uAS+iUZG/8UhOXfGf3Fgj9v4zYwP5/bjcOQLycGvDdgocnprNBQmqh/ZC
         bKgg==
X-Forwarded-Encrypted: i=1; AJvYcCVZU4NLt/5axQWnqMQNwthre7dxbBYvCPNOw+VU+/LwQ5p7xBF4Mgfw8eCAfj/Kne121MVm1KwLPZXJcljOvpPEbebI2fOgUE/rHPId
X-Gm-Message-State: AOJu0Yx+ZvbDNWLYpKNoG5sp7uZTVDcprXAvfP+l6E8YLRT7Q59jL4+P
	09xxl0Q9mTwk6rRulDSrh/dpSgnHwO5asH2e+r0/n6y5a66Qp6zT
X-Google-Smtp-Source: AGHT+IHpSCZh9ZndiS3WXN/BKrTpInQB9J5Jwp3euxS5dpJhfBvbO15sRs3yrgSPm60pqSZOcvlRbQ==
X-Received: by 2002:a05:6a00:23c1:b0:705:a0d9:ad11 with SMTP id d2e1a72fcca58-705bce2f3fcmr3740671b3a.12.1718240498347;
        Wed, 12 Jun 2024 18:01:38 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91dc5csm192169b3a.10.2024.06.12.18.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 18:01:37 -0700 (PDT)
Message-ID: <51a1a35d-631a-4576-bead-31d826bf2c75@gmail.com>
Date: Thu, 13 Jun 2024 09:01:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Update the translation of
 dev-tools/gdb-kernel-debugging
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612145048.57829-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240612145048.57829-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/12/24 10:50 PM, Dongliang Mu wrote:
> Update to commit 6b219431037b ("docs/scripts/gdb: add necessary
> make scripts_gdb step")
> 

Reviewed-by: Alex Shi <alexs@kernel.org>

> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/dev-tools/gdb-kernel-debugging.rst     | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
> index 17b5ce85a90c..94c15c258726 100644
> --- a/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
> @@ -34,6 +34,10 @@ Kgdb内核调试器、QEMU等虚拟机管理程序或基于JTAG的硬件接口
>    但这通常仅在不依赖内核模块时才有效。有关此模式的更多详细信息，请参阅QEMU文档。
>    在这种情况下，如果架构支持KASLR，应该在禁用CONFIG_RANDOMIZE_BASE的情况下构建内核。
>  
> +- 构建gdb脚本（适用于内核v5.1版本及以上）
> +
> +    make scripts_gdb 
> +
>  - 启用QEMU/KVM的gdb stub，可以通过如下方式实现
>  
>      - 在VM启动时，通过在QEMU命令行中添加“-s”参数

