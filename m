Return-Path: <linux-kernel+bounces-240675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589839270DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B121C21D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385DE1A38CF;
	Thu,  4 Jul 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbYX1ybb"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B71A01A0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079324; cv=none; b=GKpHNfh5yd2Sl+uoTsUMgfA4974vfHfT4hWKcF7xU+NMqcJ732ZSyxRthQdPe35g6+yS6g99GjDkrtf3A3IenYYPM2ORa4NcpAeaZxLa9qty1GF5GP+DvZ1apIKPm0Ey1gMtVdQkUxKFE+yuKiUuWXLIdoxaLRfD6eDnUJWGNK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079324; c=relaxed/simple;
	bh=4uRnWDBv1UfRpH57XzEtOTniVSipc3ghYR5WXxJ2mWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpXn6GjamrAewuhOUFJJjn2naI+5pd0zae7wSCSljP/98VHfUMySX+4RFkSHH3VfOtcfvwiNOYVcqjxEAdEIQghgcAAIdxFWIXWgBG0mEAWlZ2F7HvL3G9q99yzCOtHU1viXpZYxu2J2vIBdp+ILDNlHgcu8bdDDToyOK7dh8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbYX1ybb; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8d0a1e500so313378a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720079322; x=1720684122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWnn67dS9Y/zsDt+wd6xJaG7sYvUiWiKDh8I/p6oVR0=;
        b=nbYX1ybbjqTYe1YDag9qrUeE8oeAKR9PtG0X1lS2iGTyb819V2MvkYH0h8pAuYufNs
         D8s0D9XvuqHVm0LvaRgmrBAdq/FjD9g1ac1qtDT5J8KM7dfX33TmkguZ9D05GKIu+jye
         mfu01rtn/zvK0TYSF1u2VMzMeaS+8EjQvVyMJXhrelZfh3Pw0FKzqx9ElvZ+FoenlACI
         alGLUNusbcsYMpl3sEdhDuCkG/ImKPXUENPpSPEdEujjp7/NBJR0dC9DYDaeYYs4OVKf
         jeKQw8LJ6BBgk74rAf6ikptTma45v1gwQ6+j85VdRAbXcA7q5m9BPtKQEbCePEuVAdoP
         zFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079322; x=1720684122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWnn67dS9Y/zsDt+wd6xJaG7sYvUiWiKDh8I/p6oVR0=;
        b=pH4/grCGCjVyyIOdsJswsCZVlysiKfpHqUmtUJgR/XISxlOi5en7TsvlLPjzRbRvdz
         /serU1yvvWwxlQq8vLdB9NiiFraygn1Lse95xtReDpYPGS46dEjclvni4q81lCrP+mvc
         USQCgrdwlpwvJy1U6Y4C7qEv/LvqXx0x33YuzsEk3+5n/fUg7ugf/NTIcpXUeOp9jnLu
         LFcPIpwb63cj0Lwn82+Jk0tKHyYwMzBHbb2OYZ+85OxXP4yoMLX7U92tQVOoyIl0BgeR
         YtPqopreK25Cjjw+RDtyClt2J64jLrY4Kx3Q5z7BUGMzPJHYMAubuos4hvRhWygsKy9j
         dTsw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGa455m7M6OeYc7zMnJM4I8QtmIXO9N+3EDd9hji9kTeDCzmMvjWnKNkDlguQRRDmHHES1z22kgTC1BxgqaTb7I1BcRRmwWQDoDpn
X-Gm-Message-State: AOJu0Yxn5VrucU77y8GjSq+X6t/2OLHKsVJwSCzt+WBlrdhR0N/ySRTg
	V6+JCZc6k7S27gDRjMsgWAaPTLBGUXS/m/HkOdUFEM9uy86Os6SlTdG5BbAv8gs=
X-Google-Smtp-Source: AGHT+IG+/k3hB6mC74yudiI0NAU7cypsceC+qk0xYaI1l1jTz+jeizKu61E+H+7sjtNqQfkXVGLPwQ==
X-Received: by 2002:a05:6808:201e:b0:3d6:2c71:ca0 with SMTP id 5614622812f47-3d914da93ecmr916919b6e.42.1720079322063;
        Thu, 04 Jul 2024 00:48:42 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044af3bbsm11626597b3a.159.2024.07.04.00.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:48:41 -0700 (PDT)
Date: Thu, 4 Jul 2024 13:18:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V2 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
Message-ID: <20240704074839.eg2enuj5xtsl7bif@vireshk-i7>
References: <20240702152737.1184244-1-chenhuacai@loongson.cn>
 <20240702152737.1184244-3-chenhuacai@loongson.cn>
 <20240703101850.dtck223pleiiwfxp@vireshk-i7>
 <CAAhV-H74HJr0=8g0GtHj=zZH5nJijRpc90zLLRY_sXJfKFVtHA@mail.gmail.com>
 <20240704031532.5bkh4nr7d3vcvzwq@vireshk-i7>
 <CAAhV-H4HbZ02BdtE47gVyZGdNKj4QWzMSuZgHR6d9RHE36Nv=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4HbZ02BdtE47gVyZGdNKj4QWzMSuZgHR6d9RHE36Nv=A@mail.gmail.com>

On 04-07-24, 15:37, Huacai Chen wrote:
> OK, I have learned that devm_kzalloc() allocated memory will be
> automatically freed at driver dettach.
> But I have another question: can the "kfree(table)" after
> do_service_request() fail be removed?  Because I think in this case
> the probe will fail, then no driver detach happens.

Yes that will be taken care of.

-- 
viresh

