Return-Path: <linux-kernel+bounces-557711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4938EA5DCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9AB3A6DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BA24290F;
	Wed, 12 Mar 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KOODt/VI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BB1E489
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782963; cv=none; b=iBmAyUSPT1ct+oeA+L1xtFXF9l3gxISSb0A61zEDolWb75zsujCPQtIjL9QoBH1+KFC/a4McChcnUTN/RL01sXBG/OOK0AGAes8zPj3HbPVf/zt3hPRgOlRgjFGhJcnDFprS7fp+bivOI0ifIzRKBb27TGoG1Y58bMLB/fRiO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782963; c=relaxed/simple;
	bh=jzP9Aq0KIRIM15I9iHhIMVyyNBjhpDHKZwBXWLV00d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDyGpWkoH0Df7AG39ttLnWrfUMOTHBdunmCYg+bVddAzdv2I/Polkx1bRkqavQOOepDHFXK7XUXmnYOsu9OcwiBgNjKKtSk1iEoE1vzWhNXE5a2icMQc6FJ9PlAf3RntKkOf4UKj+dGdCwlcNsmPe4ygyvn5mhNuq67ktaqQmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KOODt/VI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912baafc58so5012527f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741782960; x=1742387760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUaq01K0C1+/je1dmxCrLE4FQv+H1WtvZD4zSTTvpMs=;
        b=KOODt/VIhtxOS9IVgs7PdYITCgVjuTWw8f5jLnUh43UyUCX6Rm+leuOhYhk8jHdiza
         AJm3XLiR6x7EGm2PrnozkX8kYVJD+fW2XsMdwVe3UMMDsata5Ntz/071qF/cExeDp+Rz
         vfdM226ww+lUUFQ4aKxpYjeFNlmXHpVH2HGITr8PA1/zlwnq1Q9b34h+JpScxSkcJaxR
         CIveM1LKf3kIi1bH5lKE9KpLSGJ4OZsqy+z1SoUKoKIYEL3qVskUeiW2qfBEdB6zWIkm
         EJ84hyO4RBTMgaklIvLRmm9rKkn9eD+djmZnrty5we3+SYajnF78zDDG9sr7io+MbJMu
         2Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782960; x=1742387760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUaq01K0C1+/je1dmxCrLE4FQv+H1WtvZD4zSTTvpMs=;
        b=ZXgW5l799CngD49KdWIwiGeVvlsejWEztCSR6zEP2i14zwRxfiUwuGaVrkFhoUZaj+
         XJh9NfeNe0h5a6e1fdhtrFzognq4250k7ruqAJhG9B4Fnw0tibFRbKzYMEQ1F7azC+EL
         JVauBhZJIxhkqb6zAGAWqX4PuybGuqucWEChpc9n0g0wUDmUUTYcKB2xRFwPC8rtyQQX
         2zPTygVkkd4o8Quq219fssIBe7FUlYTDKgS81F42uR/qwy0S2lxPNruVwIHKsEl+21Md
         yuLomH9ntRmXO3tNiWV929yby+KdKSpZvgtwSGfmAUojBgdLVZ+32lkjyt+2Q5p3y8QX
         0s1g==
X-Gm-Message-State: AOJu0YwTp0Hz1dko9IXyURLA02XY1Gsfw17dkAJATh4JrPnr631Np+sn
	Cd7e6EoSzMJe2iaBL5HfEo/F4emOB6mt6e1GBzxoSKSOl4CuOlViuqJmnwHXuGk=
X-Gm-Gg: ASbGncuVxNHPFSDYtzSXgAwFk+ZbQM1kDnr+uCTiQN96LuZEWsPIufMS3p///R6/ioW
	eMf2RK74E1itkQ2uSzvKMNSGfcbHwNuE3Du77dwi1ZJzkvZkUj8iGUBGQP/rYPKOQREMJGj/Pv5
	lIJ155fpfUWMC0GtZ1A7W6b9RUBmjv5cWqbjdtKYOzldbJcMS39pwQ0sGzaO47/nRFFzELcCNWu
	xg4ecz046SY0IjfDaoAkfwKGqCSQDVykKKWJUx9Gvo6DwBikStzYgzLbXR919sZYxh85UylABEu
	1tdpLSqkfxOmNmY3OdtbxNPnwcIk6PLMy0yUOoSqDY4QZNmx8DOOQL9wtEs=
X-Google-Smtp-Source: AGHT+IFrA6tfodlHT/i+OhShiNyminNv57BdVgInFHmYLhpZouf0CKqE982VoKWLQju/Sa45z4pOqQ==
X-Received: by 2002:a05:6000:1fa4:b0:38f:30a3:51fe with SMTP id ffacd0b85a97d-39132dbb4fbmr16745859f8f.42.1741782959853;
        Wed, 12 Mar 2025 05:35:59 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm20862095f8f.0.2025.03.12.05.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 05:35:59 -0700 (PDT)
Message-ID: <f17b5886-8b46-4edb-9f61-7ff9b60d1b5e@suse.com>
Date: Wed, 12 Mar 2025 13:35:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] x86: Get rid of Makefile.postlink
To: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Ingo Molnar <mingo@kernel.org>
References: <20250311110616.148682-6-ardb+git@google.com>
 <20250311110616.148682-10-ardb+git@google.com>
 <20250311111745.GDZ9Ab2f6-iHLXmRra@fat_crate.local>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250311111745.GDZ9Ab2f6-iHLXmRra@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 12:17, Borislav Petkov wrote:
> + Petr for 9d9173e9ceb6
> 
> @Petr, you can find the whole thread on lore.
> 
> On Tue, Mar 11, 2025 at 12:06:21PM +0100, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> Instead of generating the vmlinux.relocs file (needed by the
>> decompressor build to construct the KASLR relocation tables) as a
>> vmlinux postlink step, which is dubious because it depends on data that
>> is stripped from vmlinux before the build completes, generate it from
>> vmlinux.unstripped, which has been introduced specifically for this
>> purpose.
>>
>> This ensures that each artifact is rebuilt as needed, rather than as a
>> side effect of another build rule.
>>
>> This effectively reverts commit
>>
>>   9d9173e9ceb6 ("x86/build: Avoid relocation information in final vmlinux")
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

For what it's worth, the changes look to me as an improvement over the
previous implementation.

-- 
Thanks,
Petr

