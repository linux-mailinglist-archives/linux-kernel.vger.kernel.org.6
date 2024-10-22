Return-Path: <linux-kernel+bounces-375413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F739A959F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68787B21ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE4139CEF;
	Tue, 22 Oct 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhg8R15G"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAB139579;
	Tue, 22 Oct 2024 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561476; cv=none; b=sPxBRgmn2VZbojLn16uJ//fWirG47qXLXjVNPhrNWYfquZd+FS3VsMGbKHTl9gs3BiBguSaN5LXEFMQp8UEd7zkSBJTofq5Os6D2OpVtX6pd/N5MxORARa9Lm4BA35JwVNBZVFzvdnId64O47wSWi0TDZ1bg/6NMlY19HQI2T8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561476; c=relaxed/simple;
	bh=07zBLYch7GL0n69PEYwO0V8mfmfGo+b8cMiif0D6eYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLFLEBrDXMUAA735YdGPoIpF4K/axn1gumF8IVX3TtUgmm5GRMQVKaufaZnWHqSL2Ft/iosANeZJfyj530XxPkTdRxgFapXUzggN3T2xnUuo/hVCrHY21ARlTTgv4PcpG98iFukkkdaPGW7U/vr2wKbJ8r/eeq5dY3u44Bgh16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhg8R15G; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e38fa1f82fso48120937b3.1;
        Mon, 21 Oct 2024 18:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561474; x=1730166274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSMVGCI9riN35yGE749q/buxktIJIHH58ViXU0EzOI4=;
        b=Qhg8R15GtEu8DExenyD3DKOkh3IvN2YV9cjZKrqo1nl1XZTK7gIPenrn4PlZLmOJOc
         hZu69qncjZ1/cpG/2oPCbhNQrQabnZuZ1wyb1G6tk8MWnTcysdNfdhZXyIvI1h9qKRrv
         Yk1UBuaC7kD16eaKD5e7jqcLSa4aQpiDQQvkONZQH9FZP/D7Wv5bkL/fxB+707Raz/Dr
         Z7M/nWheBv9ga5JAIEdUfssmFRBMHrnyJnJh9Xa8vSvISuLIdD8+KkQbAtDPTXI3NlzU
         arbspsmzh0ZGMplUEQF0lXBqW/qImMJZshA+ibJr5Fpff5i/pr/coKs/qdg8heqCGmvK
         Wx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561474; x=1730166274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSMVGCI9riN35yGE749q/buxktIJIHH58ViXU0EzOI4=;
        b=wwvooFttTq05saIRvwaAVxweSvKUkwL7rvh3vrAuV76+hYk4uB8DNwVnazWmzvx33X
         N/D51zkOaHpSnvnNwrSsd8YV4wBLjr6hbib9+q3ieiLEKv0SZ5jr/2ww08n/JNu7NPU8
         CNvB6qvmcdaYMZoOKYaOCMBMSo70I/lnz8SXif/68+xHvJSzX9Z+nx34aXoQSYhrKEr6
         kaJBW8Alrd2kAWCnTRv+QrF3e9bvbNTF72D9DXo3ft3g5QCfFbJFxSeewM9MTpjVM22Z
         35U6k5K61+tNGP/b2GS/XYVZazlnDlsom5MjKdS90+KWbHbbmarwH4yiMl8igD8UzYMJ
         5bPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDm6hZkIo4yx5bfzal2oezztv39fRPWnZWzO3lv61Xq75kZ9kUxfD/zssED+L5uOQr0qJnrAapkLM=@vger.kernel.org, AJvYcCVHzIJXvsdxEk4J79W1U0/77I31oFcmik+A8UuVxb4J2jTjYglXQ/yBxiDnp78uFrHQfkmvT8Jlwum8v9oI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08aA4VMZPXiCZOtLGxiKazvqc09D1k2ZR6tv6SMQkH2jFhpFl
	7WgzHWAy4ssjYK7FsBT5mj/tGeqdKES56qF8VdsMrcCH4fcm2URg
X-Google-Smtp-Source: AGHT+IGlpW8A7cjCdn12jW7LguHSoE1Bk/dF4s9NRCn535XgYqtfEHiunONeihkqd2hMKB/sqKk+6Q==
X-Received: by 2002:a05:690c:6787:b0:6e3:b8f:59d1 with SMTP id 00721157ae682-6e5bfd51045mr127755067b3.31.1729561473978;
        Mon, 21 Oct 2024 18:44:33 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d2d311sm9100247b3.132.2024.10.21.18.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 18:44:32 -0700 (PDT)
Message-ID: <638d6ade-1fff-4fe3-8963-41b9ccea23a6@gmail.com>
Date: Tue, 22 Oct 2024 09:44:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] docs/zh_CN: update the translation of
 mm/overcommit-accounting.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org,
 corbet@lwn.net, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729327831.git.dzm91@hust.edu.cn>
 <d426f3f3d9aac061c20c3b766c17369f4e60f398.1729327831.git.dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <d426f3f3d9aac061c20c3b766c17369f4e60f398.1729327831.git.dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>

On 10/19/24 16:54, Dongliang Mu wrote:
> Update to commit d17ff438a036 ("docs: mm: fix vm overcommit
> documentation for OVERCOMMIT_GUESS")
> 
> scripts/checktransupdate.py reports:
> 
> Documentation/translations/zh_CN/mm/overcommit-accounting.rst
> commit d17ff438a036 ("docs: mm: fix vm overcommit documentation
> for OVERCOMMIT_GUESS")
> 1 commits needs resolving in total
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/translations/zh_CN/mm/overcommit-accounting.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/mm/overcommit-accounting.rst b/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
> index d8452d8b7fbb..f136a8b81859 100644
> --- a/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
> +++ b/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
> @@ -16,8 +16,7 @@ Linux内核支持下列超量使用处理模式
>  
>  0
>  	启发式超量使用处理。拒绝明显的地址空间超量使用。用于一个典型的系统。
> -	它确保严重的疯狂分配失败，同时允许超量使用以减少swap的使用。在这种模式下，
> -	允许root分配稍多的内存。这是默认的。
> +	它确保严重的疯狂分配失败，同时允许超量使用以减少swap的使用。这是默认的。
>  1
>  	总是超量使用。适用于一些科学应用。经典的例子是使用稀疏数组的代码，只是依赖
>  	几乎完全由零页组成的虚拟内存

