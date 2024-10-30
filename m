Return-Path: <linux-kernel+bounces-388520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50D9B60AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FDB1C22E49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF91E3DFD;
	Wed, 30 Oct 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SwfXv8ac"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE01E3793
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285938; cv=none; b=cWU4jeJ9wZQE96uQcRE4GRk3+xYROlYAw9q7NI2Y87YTzo4IiGLz+zGy12b6I+L6I4eJI/syg7bqprxxvGEYtmV6jk0+8drvvGmuNx+hdQvq3SBClP3ak2NNmNpn3JMAfTADgRGNPGRURCnHwaAv/UQLjgS1x5R2X9+xATiM5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285938; c=relaxed/simple;
	bh=ausQ5aWSKSUZuprbbuF1jOXFG4+asVuUb1pBEXnZqP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvUbRsrGvEiw5cMTQfxe5M1Vs+iZy4oZ2QoMdiecaFtVGweylUyghAboa08IOsBpZhZi14kcFhs6YdvFlK2NslxkwpKex8gGTn/3/AJ7u+KGMYAyiF0nD0ugGXw+78A0ZLM8K7bnczgmg0tQmAY6fUBi9diYyBtQxoPgVc4P7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SwfXv8ac; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cb7139d9dso62638045ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730285936; x=1730890736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lF7elXiFFzOT6P5cvxOSKmSBywtmOCP/Uderu+HlP0k=;
        b=SwfXv8acoGKFCUUbtSFbMQb+gb4iSjE1AASn7Z3qSzRpbxzjJKFbS80zSi2+Kudegm
         TMuDEdNyvJgv2LICAjMW1yij3wa2aptShXmACh3CfE0R8P0tIafSg9lTdxllEgxn0R80
         pWGTEt1zBGr3MDDmzcB6xPocYKw6trJX2X43I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730285936; x=1730890736;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF7elXiFFzOT6P5cvxOSKmSBywtmOCP/Uderu+HlP0k=;
        b=ux+yPxKyZFozhNbTLgYWOl3ja2B1qi/iEl8VpMFfctGwVKgHHvvcXhx9HWKR5CutR6
         YIsJDQCNXSSzkUyBnLIbSmLlt4KcJXEL1OIsN0UyFW4V8tOZdzCQES2byD2UaSqm9CLQ
         QWzvAv16T/PdMXJRN5DVj98crNW8w5wwiW1UfyT4w/sAT5tLWXlj2hc8msJqgvyyscZ1
         NJpLFmzobx+yfWktLWOq3CcnGhJ6aNXqoi6okkeaytZksnD0hUmcS8upOjd3ZUnR4z5Y
         MgSW0NcjqMwPpG2Xl98Nf3xgEGRaHQa5xeLdvghu3cu0AGTnhpNWh4gv3p98uXU785O1
         yqvA==
X-Forwarded-Encrypted: i=1; AJvYcCVLPmESt0qQfD97iWEBZ8j1yfEgTCh3vCzSQg7lIaB51zLBFdk19fMI7F51KerjhF2AtvfbUHZoWQw455M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+khEWVCFhZJd7HkKIqpYpoSiGl2Mzak6bfi8YqNcyomymkXj
	wKj4Mgm49auXN2LjoUljfYDxtOASp8yI4WEDb7ieWpVeuKtECCnfdqXu5KVkfhDUZp6jKObWuas
	9Ng==
X-Google-Smtp-Source: AGHT+IFLh10b2Eh1Nyo78as4ynpfvHJIIzeCClG4dSLNaIRTAGrq5Hf1akED0SsXwzeM6tiOs6m4nA==
X-Received: by 2002:a17:902:dac9:b0:20e:57c8:6aae with SMTP id d9443c01a7336-210c6879841mr206180445ad.3.1730285935654;
        Wed, 30 Oct 2024 03:58:55 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0178cdsm78588935ad.174.2024.10.30.03.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 03:58:55 -0700 (PDT)
Message-ID: <0caf4870-072c-4285-aed9-66d2472a06b5@broadcom.com>
Date: Wed, 30 Oct 2024 11:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcm80211: Remove unused dma_txflush
To: linux@treblig.org, kvalo@kernel.org, kees@kernel.org,
 erick.archer@outlook.com
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20241025204651.244627-1-linux@treblig.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20241025204651.244627-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2024 10:46 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> dma_fxflush() has been unused since 2013's
> commit 7b2385b95363 ("brcmsmac: rework of mac80211 .flush() callback
> operation")
> 
> Remove it.

Thanks!

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c | 9 ---------
>   drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.h | 1 -
>   2 files changed, 10 deletions(-)


