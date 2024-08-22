Return-Path: <linux-kernel+bounces-297095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05F95B2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EB71F24014
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15198181B86;
	Thu, 22 Aug 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UfQLBYi0"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6317DE16
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322929; cv=none; b=u0aIWGuFc1wN5JaHnpcUmK6iqO3Kcpxi5NbALSpaSwUBwylbmE0v/evdNzowqblEup9xIeO8S1hPicrs15JBkaaVFabk+kCiNkTpkIA7HF8SqvcQISC+qfzwzWEVHbVpi1FSxFqG3ar+ZOdsHkfOqgR52ubSaptBAg/3IdHKd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322929; c=relaxed/simple;
	bh=Zr7XPwrtEk3qtd+gx6KyV19j72eTMSccWfQQdkVH9B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXR8S4Ob7npgmzXqRhF92lNJQAVHraC58ivacBQWCzYK3DwmRCGzrtg6+nl2sgIc1NcvkrMmeMqQevZM+91sBmL/Mvd3PhKv7ODbP2QT948G4eBfY9LapjIVPwnxvOOMRRge8KFr2V0KbBxtelbHvQ4d5AS0TfquD+dNaphH5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UfQLBYi0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3cd4ebf84so7318201fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724322925; x=1724927725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/p6i37or0QISD6fmH5m5OZHLkmrLXz/r/0MMJoGQsE0=;
        b=UfQLBYi011JLpNa01J/SQMCyA8Rzw729b54O3xxekLSR57OcD0L6JXDL5TLUYP9fq9
         wgNveyQkREuhRPzA5gD/DiHNW8QFa5HHpK2Smz/sgbvn/iMUoSFjepm29FJDbO4ljxG/
         7Q8FY9mAl5x+lHw2yDF8SxPK6R+ungv2MjKbGt9WA+xUMKl2tZddfr17fRbbURoRjreD
         /xxV/RD6vHVCYjtfCi7/SbWi/iIqbjyFVHRIdBEs6K32DauDeF/smsvfXhjRjmGivbBv
         SM2+mWjq+1OtnnBva6emZ7hCt+pcHe8eywmeUWTySOpchDRpREStV2UeGkSJ5wU41SEE
         FwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322925; x=1724927725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/p6i37or0QISD6fmH5m5OZHLkmrLXz/r/0MMJoGQsE0=;
        b=Nf0wR45LxLJRnevoUYiPrTOWiRPJNtHBfApr05MdY2g4YFF03Dry/PS+j4ivwv/+tH
         t9LXkz2DvliCvCC5+GUB28i2T8STDfPoDXAR9pujV0rlUz1BT9jHLngAO4m8ehh6aG+z
         znKsxDerZD03C8EdzY/3y6wr2dMQbQcd47KSE3jwyuycOSV7eJSJ2voQCie9VnDaxJf5
         C/j/gsuG3sKRoXZwJY8zKqYWIZ0Wx53IVW+FirRY2S4iUjx7imHF44Q4tjv9LiawltPt
         titlJ+6T2vH9xmEJs/R9YfdJkexVLtkYTCViUZsxpvYR9xGjAb/V0Jf4R8WnKJl7rdGS
         /fUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCeVwrg/0elVlQ9su/laQpfeqDEUl+z8VY8amCgGjD6Y/V2OL86O6ELOvTZSFRR1eOEf+qKNe6Ft8CYEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxh7JTtz357JpKhCPffL068sHOv3vFdJV7RFulO3cheg2Ke1+
	m93oAjowSRYi7B/N78ZJPRcqwd6iYZZ5x03atbSSCrumqXdwNJesp5FbmeMy1N4=
X-Google-Smtp-Source: AGHT+IGdsE1iYvV40D2msT5q26R9UmfrcxBs0mu8KXtbUxmxjfHILnwDSACtQevE3PyiAHKFLGBQJw==
X-Received: by 2002:a2e:a985:0:b0:2f3:ea86:3727 with SMTP id 38308e7fff4ca-2f3f88941e8mr35284061fa.24.1724322925314;
        Thu, 22 Aug 2024 03:35:25 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3e9540sm749547a12.41.2024.08.22.03.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 03:35:25 -0700 (PDT)
Message-ID: <a3701a9a-5b42-4581-a150-67d84601061c@suse.com>
Date: Thu, 22 Aug 2024 12:35:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: scale modules with more reviewers
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kris.van.hees@oracle.com, samitolvanen@google.com, da.gomez@samsung.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240821174021.2371547-1-mcgrof@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240821174021.2371547-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 19:40, Luis Chamberlain wrote:
> We're looking to add Rust module support, and I don't speak
> Rust yet. The compromise was reached that in order to scale we'd
> get volunteers committed from the Rust community willing to review
> both Rust and C code for modules so we can ensure we get proper
> reviews for both parts of the code and so that we can scale.
> 
> Add those who have stepped up to help.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

Cheers,
Petr

