Return-Path: <linux-kernel+bounces-402926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AEA9C2E88
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FAA28237A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B075A198833;
	Sat,  9 Nov 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QTBkzIuk"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE31537C9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170173; cv=none; b=Tu1cuSTiX4FSg3BmhM5Mn4ym1tMTmKNpYR+rE9YEYIO54/UywtSOM4ccIktHFAqnRzjAe58mJSRDzWi8vXA0oOykV7eTXJ211cne6iz8sKUugv/3DXrBZewdQc8cnJyxONtS32oIUnYmDDcXv8BygYcaFo44z3K6C8bzlU6ezG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170173; c=relaxed/simple;
	bh=1zw4x5pQ+s0kBi09AAI4rx8p8hKJYjtPeE1I8rzMFvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUFNX6cGo/I5UsIY8NEscRb18K/CljRlOTYEEipmYfPnO311aRkFEFT7avxhhM/4CCUt0habxDIpvmhTh/7g4O1O7P1pTcN0SHqEGmTfMxDLLQ49AqNrxLKw0OGqIzs2GeVcetBeBWITM71U7di7ZAEqS2Bu5b6exV6J2RzvSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QTBkzIuk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15eadee87so217372985a.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731170170; x=1731774970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiyXTt78v6KIZQ1Ji+ZoKsI5Ur+Se/pukGeJe0h1QHs=;
        b=QTBkzIukXO/v+Oq7d1nDN7ZAVuCYSprCwhsPH2i5zCp1nfOCD2/eHG689p43iarI9j
         ZZt1vZoPyqeobWR9z9WELOFMpkYR7Pr2Af5eJvSHWJ0IjrJVaufnZvDA+Zurr7ZC2UFD
         y1DnArp+Jn10dEvA0YaFct3RvrPAXjM5UKlnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731170170; x=1731774970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiyXTt78v6KIZQ1Ji+ZoKsI5Ur+Se/pukGeJe0h1QHs=;
        b=YBUrdHJwV+RBuJePijxsmcx/SMiHCKAh9E3ivoVvOiblVdpcYuVzfXmFMJMINVwFTN
         rd/13/QvovBPpJJySKzvWLXz93TG48knzvV5mOaUSNztodMlwetJ2mCPfKZ8R0UkG89m
         rf29Eb3cKtnqF6ObaomELRDBebsR8ACN0ciprw6WjzVLZSD6qZ1nQT3+2fq2wdXZjM8E
         y46/IYIIx3ezhsbyRM60lvfXWxKInjEPoeh3z2bJKvv9TlTA5/29J5cKyU5gIupZZPn1
         n780clst/3/teaZZMrQRn8Va6zuPFjR5MmGx13lpbG5Hb3I9Y+OycCOKJuYUKGBBGJrT
         USzw==
X-Forwarded-Encrypted: i=1; AJvYcCXlQ5dk5ubtIMjGfEoMLnSgC2N8dD+FGdwmUGEr0VE39T6NYGJ0ASPBtLap48rBbdpOJLsnUfmobQgifwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydfit7REd8ES78LvxesJ65lEsYs1Kg/ZAmWiVuyIe6Y3zV+tUv
	Z2hlqKrNGNDWrdCg/28MiFGgM84xQc0yFdPztx/qRbSSJ8G4K5EDBwKFYi/1Cw==
X-Google-Smtp-Source: AGHT+IHR7LHF6bAJTfqfdMdT6vSoZ1qZIMt2KdNyCPNQiI/13HtKv9OHU9ir/QulbNCGPSOqD5aPSg==
X-Received: by 2002:a05:620a:24d3:b0:7b1:547d:9ba8 with SMTP id af79cd13be357-7b331d8c12fmr867466785a.21.1731170170256;
        Sat, 09 Nov 2024 08:36:10 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac63da6sm272249685a.58.2024.11.09.08.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 08:36:08 -0800 (PST)
Message-ID: <f89f2fee-35d9-4292-b2eb-b4bceda78030@broadcom.com>
Date: Sat, 9 Nov 2024 08:36:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mmc: pwrseq_simple: Handle !RESET_CONTROLLER properly
To: Stefan Wahren <wahrenst@gmx.net>, Philipp Zabel <p.zabel@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Marco Felsch
 <m.felsch@pengutronix.de>,
 Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241108130647.8281-1-wahrenst@gmx.net>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <20241108130647.8281-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/8/2024 5:06 AM, Stefan Wahren wrote:
> The recent introduction of reset control in pwrseq_simple introduced
> a regression for platforms without RESET_CONTROLLER support, because
> devm_reset_control_get_optional_shared() would return NULL and make all
> resets no-ops. Instead of enforcing this dependency, rely on this behavior
> to determine reset support. As a benefit we can get the rid of the
> use_reset flag.
> 
> Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset control")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


