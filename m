Return-Path: <linux-kernel+bounces-284484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAC595017E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185261C21CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374C17D346;
	Tue, 13 Aug 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC8nBdWD"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7C13BAEE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542366; cv=none; b=dUr6tNBBYhgx1IKQ9MVtdG7rwGx7SY+koP7jkyg5oVcBPCxjZP+Ykp2N+NnAVe65GuA8h92ai4m4p0Oqlzo2HxtrSjyzKAbQbKz7rRnCDIanWmaRtqS7fUKOPWz90rq/rfUogaUg2Dd2LjhnhhEPdXTVOSMsM+dTsoJcdt7sqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542366; c=relaxed/simple;
	bh=l6e7A0IDq7mkPkzQ1qjSba/PhdTk5haqUlwQXaeprdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jb1NZi+T+MXKcyEKhu7+qc3f8/IP3a8MxBP5ucrbSpgDlCs/hUDFGXGXEwkYnVZq9awXHbS1UwYXkZJtPMctDd+h0BFmWwqaRl8vtKTXBGSs+WtAjhNLudMdM0wlolzmdTaEXIb2Rwn+C7fTyrUwryXFKVXjMeOCovRtezSsiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC8nBdWD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f136e23229so55538711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723542363; x=1724147163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCU4m0eTNfhGvosHUciY0Bb7Ljv1Q9l8LFOR0JmgTwA=;
        b=UC8nBdWDKcCv6+aqhfYoWcMj9bN2jpqErF4CPl5I0FuX9YIgKxnKDOIXgKuCpoOw1A
         slBgnam57mScqCPT1L4uMCck/eeUTdDxATnzNO5sqk0UQZyScJKwbUQPVHPdlzvDK4l2
         XOMUAs+xJDKmDtFuRgcEhYFsuOX/4875wLhJgq0xfno6SQ2BXRVs8bLDr/mzQm5JyMNj
         ZDqgxssTExtM7Ofzaye0+dlEleGONyiGwFjsPcIqC/fOOMUE/2MLRNrI4GGuQuOIkLZU
         h7xpS2CZxbQPjSLoq6AChUi8gspye66KTqLEnCn7cyP3j3gbokCpaTVpUwdr3e0Og3t+
         43Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723542363; x=1724147163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCU4m0eTNfhGvosHUciY0Bb7Ljv1Q9l8LFOR0JmgTwA=;
        b=cry9ckCYZ24toMj959sXf2vLUT1WmjPV1ycCwYokXCZWsJumwh1iB1ENn75c0PQWi1
         nRR4eHX7y+eOo++7ZmCDtkuJXPNszb0rGkcqAwnQ3H0JFQY/m+PHZ3yFIPbRsCxjltOK
         G7xRpz372B88ffObNdOzqSzwuNSY+YiuDyi3XO7aSQiUlSnEmLuy4TPZQpkf/FRa+0LV
         xlYlgNc60QM3lvsmBq3MKaikH7gW+uy8OBgj9lLwEYvZhmJ+lTPv2J9X831zgV6aFjHX
         /MSAiAHrqXJadlj3+6w3CjIcfN/ScHxQrowqYa6RgPLwJj3WCTdyHCjSzT+oJY9nJb4U
         0qUg==
X-Forwarded-Encrypted: i=1; AJvYcCWdx2AqerbpULTTwTrFX1t9rkn4k6T0ZOV9ainATXWgJwAl9MjFbj+2lWrnoW6OL3r+Z7q3b47mgEXnvJj0yolToke0P4yZRuhoinDU
X-Gm-Message-State: AOJu0Yx+X9irWyCGMPck3by9/11KmVaTzig3LGxO4VPFm3nRgvFNMPlg
	/fmjlfVFKUUhF8x8SeGM7ZMRXxD5iNY1aEWlUM/4cSLkb15jpOCi
X-Google-Smtp-Source: AGHT+IEGWsW0Cv0bIyZ5I7NHIlXrkwD0yIrupihjQlHWIq5d8O3UGWCn8eWdj9XxolMUsJMZIt5DDA==
X-Received: by 2002:a2e:f12:0:b0:2f1:9120:c920 with SMTP id 38308e7fff4ca-2f2b727f17bmr15232291fa.45.1723542361823;
        Tue, 13 Aug 2024 02:46:01 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291dff7b2sm10751121fa.56.2024.08.13.02.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:46:01 -0700 (PDT)
Message-ID: <2e9b5edb-a1f1-4d2a-900d-347838551676@gmail.com>
Date: Tue, 13 Aug 2024 12:46:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] irqdomain: Remove stray '-' in the IRQ domain name
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Herve Codina <herve.codina@bootlin.com>, Mark Brown <broonie@kernel.org>
References: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
 <20240812193101.1266625-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240812193101.1266625-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 22:29, Andy Shevchenko wrote:
> When domain suffix is not supplied the fwnode case (not irqchip-fwnode)
> uses alloc_fwnode_name(). This currently unconditionally adds a
> separator. Fix the logic to make it conditional and drop stray '-' in
> the IRQ domain name.
> 
> Fixes: 1e7c05292531 ("irqdomain: Allow giving name suffix for domain")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


