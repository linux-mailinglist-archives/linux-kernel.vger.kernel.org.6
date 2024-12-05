Return-Path: <linux-kernel+bounces-434048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FCB9E60B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCCE18849AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF71B412C;
	Thu,  5 Dec 2024 22:35:32 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A81CBEA4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733438131; cv=none; b=nT0JcD2Sd64Idm46lx0RpKxO77ZwdSfO92lypAZLRdwZZisFEcbPBC+beMqV7VvvqknuDJ19X5sfCj6RBhahY7QEu1uP5g4SM2aulrlheXO0WT1tjfzlWW3/py+IjbuyIuunRQt9xEnE4CKQUlvR8cdcCqC9qCWvlLtW4E/gvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733438131; c=relaxed/simple;
	bh=2NOL9msOvgRoeaBxY0bns+dpAJnTLo16D65qGElnkpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pn/4hi5JdHI6duRk0zS+Gt+9uEjxx34Mrbs2leAV/YlmWnW15t++0mJZ8qnWsLxPouy4qKzBHLqSkhHwgRs0QSIB/DBzKAILGgIqYXfe0P9y9jblM2jG9POzRMdCbzz2Bm4jEFrX3IOgTYCw0MjcZnAC3+SwIjseUhtyM/RI01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7250c199602so1557950b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 14:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733438129; x=1734042929;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtEYOiTLjn6+EkNb1gp+QTu4LUIf3CrgnNhL4DA6X8E=;
        b=oy2/8wisolaEx2OiuJo2abrYctu+y4CG+cuPdNbl1h9p8hfgC8jXAcC9CMwewOP6kS
         h7ciRpjA+ZKyhsDC19UjKEVDhOAadegikaffhnk2aQN1OSWPzzbmg8QiuS3Kn6vpI8Kt
         MQ/U4NLI8v27faa8MetACNpvleB5h1BsWQMISSuYSDsToaLYV4qNgsBfMnF1zPWYSggu
         o3pwXdI8uSjc2CnlRJqBRnA/zTa6tdSlryUkjLncjYTTUmMKX0lzlCDwPo2D+Pkerptx
         At8C/rp07xiJ7HLGCFcHCy7HE0OmEO87spUv6zET6ENdD5j8H6voSwQqLd892I7KBLDZ
         gMHg==
X-Forwarded-Encrypted: i=1; AJvYcCXv7rz9fgYUKzu+rBlfkCN3aqwPj8RXmcR11bUwwTuUgt9u2vsKxh4tCyCyAjVqCJHK4jVGQKyHajVUCxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vctgJgrqXpS8TmUppvUGjVao9rw9svgZbuhHCXlTfmA/NIP+
	6ljiKnmORSgr4dYmK7saRxOQ7D6n8LtpbAOhgltnstkSkgTPQSvpCB/SEDsrkA4=
X-Gm-Gg: ASbGnctliXiWZrLtIZN2J1SfwhWMwTNmv2eQF+HI3wmqpUT9rCrY01V5Pq7MSlTqc5K
	g7CLdeBmy6U44A4Oa7CKLADGlw7UqxWvRXM78FH5mHGwmgWWkW+Q6sq93xm7Mj9VTd+SKk78lRP
	QY2DqrbRJctk13wRkvVs4wXqgDsTJ3rh1Ob55CCPBFUx34AyVAtr6XzBCwUk8ZhnqwEqGf01X5g
	5u8hEf1S43CGpqg6qzHWwRsUAaZU/Jm3okDwQ3A/uCxpODZ
X-Google-Smtp-Source: AGHT+IGb+Gho/439wgyLRKr7+nVR6NWlx9kr/iI53YBtIOzs5C+yxoRN0cNAmYC6YxSr9ZD94jwklw==
X-Received: by 2002:a17:90b:5448:b0:2ef:2d9f:8e58 with SMTP id 98e67ed59e1d1-2ef6ab29c49mr1173721a91.34.1733438129083;
        Thu, 05 Dec 2024 14:35:29 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff844csm3801590a91.8.2024.12.05.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:35:28 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, Andreas Kemnade
 <andreas@kemnade.info>
Cc: rafael@kernel.org, zhipeng.wang_1@nxp.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix using cpufreq-dt as module
In-Reply-To: <20241125051302.6tmaog2ksfpk5m6u@vireshk-i7>
References: <20241103210251.762050-1-andreas@kemnade.info>
 <7httcmonip.fsf@baylibre.com> <20241104201424.2a42efdd@akair>
 <20241125051302.6tmaog2ksfpk5m6u@vireshk-i7>
Date: Thu, 05 Dec 2024 14:35:28 -0800
Message-ID: <7hplm5hi6n.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 04-11-24, 20:14, Andreas Kemnade wrote:
>> no clear idea how. What aliases should I add? The cpufreq-dt-platdev is
>> not a real driver, so I could not create mod_devicetable aliases to
>> match a given device. It constructs a device under certain conditions
>> depending on the board compatible, so no simple list of compatibles, it
>> contains allow and blocklists.
>> 
>> cpufreq-dt then binds to that device and that one can be built as a
>> module (which then made cpufreq-dt-platdev also a module, causing the
>> trouble). I do not see any benefit from having cpufreq-dt-platdev as a
>> module. ti-cpufreq has a similar role and is also just builtin.
>> It does itself no real work but provides a device cpufreq-dt then binds
>> to.
>> 
>> Handling module removal would probably need to be added and tested. I
>> feel not comfortable having such as a regression fix and for stable.
>
> Applied this patch for now (with some changes to commit log), as there is no
> clean way to fix this for now. Got reports from other folks too about it.

Oops, I thought I had replied to this earlier after detailed explanation
from Andreas, but I guess I didn't.

Thanks for applying.

Kevin


