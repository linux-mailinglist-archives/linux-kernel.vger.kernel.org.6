Return-Path: <linux-kernel+bounces-555043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89235A5A4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0B0174E08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B71E3DF9;
	Mon, 10 Mar 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY97QoY+"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2C1E25EB;
	Mon, 10 Mar 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638015; cv=none; b=dB0eak1vV9fBKa6jPrBZU7PRQzsrry5UWAqfjxsW9aSSpibt/VVuCIYBYHWPEr9tBSCw4ZUvKO8IAosHZl+pdw31gb92UCSeVpp9mqOWgbfmHR8MTXHtH2tRHTFsNfaFpKuBDqumh9qX/HEWB73QuZsUyc4Ja51c0XF6VJqUd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638015; c=relaxed/simple;
	bh=rmnxlTh4+9Xr1jUFAwTyqD9+2QaJ00Nmegk4SkJR/WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLN5iERezIEYVQETfxbPjBoqmSx5+fV0WRSkkwNiu/Af/Jw30C/lJt/72W3JzsoF7cssx6ne1vWGtRLL3SG2X6eywu1pQX9a/Fq1/JshQCdyIcpohhYdnuHb4rZYfenz+FhrbGwz1oMMs11FqODHkbGFAIYwe6lbRI0hJchOqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY97QoY+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac29af3382dso246780866b.2;
        Mon, 10 Mar 2025 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741638012; x=1742242812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jy2tDul83DJ+TIghAv8/MHeoWO5YZd6mK9BubhK5z1A=;
        b=fY97QoY++kTJT5F2gjsj/6zwiBk9X+nbFgwBbIm0tzTTW31uwlBQ21btj4C0Cz81Gu
         OipccGFAt52kpHX9Zyv+Sh9KFn4bu51WZTolpn0JoXOUnjU9beGdVK40K9uXrhAIZFvT
         H75ElTWW4dpdukguIHxQskTTg3HoKefkvIFEJq8oCrhhiOEvTwRyTgzNdJ0hzUC2Re79
         5iOhgmChC4fmt97bKuAyGLENx4VVzPjzVKtb8ffps1vOpnfza25HKas1C76Hg7FVYdgC
         bQGcQdpk7BYuUrY34Nep6YRcTIqIbqE1OdMdKLBZl6qRwbrtkupizVXUygksgBd6cu85
         TLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638012; x=1742242812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jy2tDul83DJ+TIghAv8/MHeoWO5YZd6mK9BubhK5z1A=;
        b=tF/vg0lgNYpP13FjO1VfM0My23D3BTNMXT+b4ziKOkCcgnTF33UaSsr4jwhV2To+H6
         qRcFJohZVDbE78/GIi85DAkRqwwiH4RSWUspthfSKAfMUPkOil43vUbHO+Uol8k6yUCt
         7xdabp1wwVrnoDHV9xNV/Majtbpj8x/f94QmIF7p7d6G5yEasjN6dwbGfqQ6oovhuwZQ
         ZyLJ1PVLuIR9jLealygvoy/faiP0NKy+6PRgAL9lhVIVi96/TEahd5U3Abyph9SaG8ny
         u84BspCjHtSOfkfI3AuQ5hj9SFCHNJWWEEA8B20x/BOAysg/ZE/Vi61nqx/Mz7IUCLc4
         ziJA==
X-Forwarded-Encrypted: i=1; AJvYcCWURyQdiY27ATcLO3AuP6ah5E09AKFOy6RM9ms6RdO6ugSGHawAmzMnX5yMNSRtYuuvPvGU2EBYzGQp@vger.kernel.org, AJvYcCXIJ4gGchpVhM5HUwznlyQ499xnmDpH9FqtLJapJ9ISEAlWHurlrUBYtWTxhf58emipeEF7Gzy6mMGW@vger.kernel.org, AJvYcCXkMbN17ucWOhVbMVs0AIs4IFWb/2ghWfxbdTndZ0oIRFmKqRsdKpX19Lr2hISZMK78bDn4qx9lKPnDOGmG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EVhVkDIZ33WsKeJk5WrUXGIGjL8XTMaiRfB06dvds2W4ZbVn
	GR9sli7vxlRVqDxdAAuG1i+KmhzkXWsgqbG1sHeWeOFAVuIqj4ujiYG+QQ==
X-Gm-Gg: ASbGncuV04+68WSnZnzS2vCQM4DMCn2WtzFkDiYNZSdx7Mh0t6En7Iq3Zetn9eqDATe
	OunMO7A5FO+j76UpqWq446KinD1/3lwSDvhHRdhGwYUK4lfpQIgjySyk8tgZApqYBiLjdtz8D3X
	resQBXdrkvSmGiSIlrcg4+PmYon5vrZvcGWlIlnPrZ8le9hPzpScSWCuPHGj2FYSBQrEzmjpj1j
	srRyyHDwAMzXWdQ7r0RKfvopoWPr+UjbZLlK2MeA3wrb5cG3A6DimwLsVnmyRb+rRH1vNHqt5PL
	DUBAMyf9FYahaZRHH5awixTlwO3/ayUeC8CURsUys6j2AK8UCn+VW2KvmvfPBduZlOnk5JqUGYl
	7qjnZSWYfrz8Kbi/un/nMoA==
X-Google-Smtp-Source: AGHT+IGQteszZhsq2RbLp1UONM0XOnkXmRpFq2A6OnfT+EbxvSn6pk1KtSYROrheSGMmLUq5o8HTwQ==
X-Received: by 2002:a17:907:94c5:b0:abf:6d24:10bb with SMTP id a640c23a62f3a-ac252f5b0c6mr1602253266b.44.1741638011746;
        Mon, 10 Mar 2025 13:20:11 -0700 (PDT)
Received: from [192.168.50.244] (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29c95862dsm255417066b.164.2025.03.10.13.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 13:20:11 -0700 (PDT)
Message-ID: <2b120341-0026-4a9c-9ad1-b14adfac50c8@gmail.com>
Date: Mon, 10 Mar 2025 21:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dt-bindings: clock: brcm,kona-ccu: Add BCM281xx
 bus clocks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-4-d6fb5bfc3b67@gmail.com>
 <20250310-orange-frog-of-abundance-af80f3@krzk-bin>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20250310-orange-frog-of-abundance-af80f3@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.03.2025 10:43, Krzysztof Kozlowski wrote:
> On Sat, Mar 08, 2025 at 08:50:42AM +0100, Artur Weber wrote:
>> Add bus clocks corresponding to peripheral clocks currently supported
>> by the BCM281xx clock driver and add the relevant clock IDs to the
>> clock/bcm281xx.h dt-bindings header.
> 
> Please squash the patch so we see complete change.

Squash which patch(-es)? Both CCU bindings and the dt-bindings header
are modified in this patch, as outlined in the commit message (though
now that I look at it, I could reword the first sentence to specifically
imply "add bus clocks *to the binding*"...). What is missing?

(Sorry for the separate reply, I meant to reply to this in the previous
message but accidentally removed my reply.)

Best regards
Artur

