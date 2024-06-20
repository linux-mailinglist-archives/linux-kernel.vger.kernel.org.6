Return-Path: <linux-kernel+bounces-222925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B0910A01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F0EB21E58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E1E1B012B;
	Thu, 20 Jun 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nul1kWFN"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C21ACE94
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897821; cv=none; b=qdV15Fh1Tn9xgWYzSHYgYRY9wObhd8JDyPYP4XipTYotREpsrZFYYrUBIQHOSZ2Em7y7qqb2Cf0At2Loxu2ZJXJkFUuPHV0hpv5JJJRvry5IE6XHAkNvtcvmfKvk8MZLCQCLmW+WZhUilj65yaBo840haQIgge7ZrC0XqTMNPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897821; c=relaxed/simple;
	bh=HmGLrKH86bb7wWe/cZEu3FUJeW6wVd7Bm5N3QuNpaOs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WkixKKKegBCx0NexEo6SFi8GYO2oFrpW8vuoTQsqnPdt7qarefDbE0PlXMeQhA0MxMAAXMPY3/uu4EUo0gczcD7gwF/NGPeGO3tWErgWA1GgVsLB3KbeGaQtXZgaPPnraG/Quj5kRdJUANLUgJqiowRDZOQlsRlW4F8TsQOSUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nul1kWFN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so1107400a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897818; x=1719502618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+THsFPGN8gjr0bBD3aAsxqBIwm7mj5o0sxH3kZ9+ps=;
        b=Nul1kWFNgBli8XtbQ38pZEMvRf6AsJowsV5jyvsJAfv/FmxA4L4pcbwxxw2MPRyYqe
         6NvLU+Qov5BaVrYuWjdZC3wT4eKwHbADa4YyxGv1CeLic3sU8+oOMrI5qmRXVPDRrva5
         k/vFOCe80MFOU/EIgs5EiVB9ZvU9yDgnppul314XyN9GFNru7HRLA3JEjs3dCygrSUum
         kJLNjqsj3/KGEFno9a/GoTAdktcwMsf83g48W/xHrj8T+oluHXuFrFdiBOVrUjNXnSpa
         6bsJaNbFcNcQj64y8lqMTc+WA3nfTyk02aHjh7Zfea5sUPPR/ccrLWDu5JxUE/AbNfTS
         EW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897818; x=1719502618;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+THsFPGN8gjr0bBD3aAsxqBIwm7mj5o0sxH3kZ9+ps=;
        b=ivO7iDAfjLMgAf+zL2bRRmdu08hX+X8hgK6BkgbQMfmmQ2U01qDQ7vS+nGT4lGE5Z9
         OuGpXhWCD8KE+vFkBIeoLHkUUInsI3nOXnRAMlOGJhFBbG7KWco2rykSPRfM23xPkmAH
         14jQc+kscy0v9k6PKIhBKKHaqqxVoqz2OCos2sg9do5js5SP3pQ9vQBcV61EtWa+fCiY
         Jylg+hGJGAF5i/6Vkn6V7sBihziHhII5nYRftYPDwtpigzkdWQ/qeETUiY5d2/vmmY9Z
         Q/0OcUMDQLZyx/i6ePKcwoPJHBA2Gl8pwfTNTsQMZneUTQaiWph22B2hBtP4WaAReWpg
         +Q8w==
X-Forwarded-Encrypted: i=1; AJvYcCVEIU9NmP1gR+oEh/TW/UD8O/vwRTZdkYM8vRvsLPIzyqabP8R4khOEYbQ9tjPiZGmqADnfIMdjMA1BuK0tnJEDT6zIE88RzsbOqj7g
X-Gm-Message-State: AOJu0YymLBfunXqPkt/kLEDevz2bPsYP6kTMtBvM8Zig8+Nqo1RYYkB+
	ycjathzU8MVgdENsCGkq8/5E2s8NAcHV063nT5iv3C0DFl1viEUi
X-Google-Smtp-Source: AGHT+IEasFa8cRm9xlCbtGgdQjNqoQ8OdLMrpJRc5agaNrI9TmMh2PSq4m5lC7Bv/kNVbYD0j/GiHQ==
X-Received: by 2002:a17:906:81cf:b0:a6f:7826:41ea with SMTP id a640c23a62f3a-a6fab646fa0mr308711366b.39.1718897817757;
        Thu, 20 Jun 2024 08:36:57 -0700 (PDT)
Received: from ?IPV6:2a02:908:1980:aac0::b958? ([2a02:908:1980:aac0::b958])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f57b5e7b2sm774523466b.68.2024.06.20.08.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:36:57 -0700 (PDT)
Message-ID: <70674dc7-5586-4183-8953-8095567e73df@gmail.com>
Date: Thu, 20 Jun 2024 17:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: visitorckw@gmail.com
Cc: akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
 linux-kernel@vger.kernel.org, lkml@sdf.org, alexdeucher@gmail.com
References: <20240113031352.2395118-3-visitorckw@gmail.com>
Subject: Re: [PATCH 2/2] lib/sort: Optimize heapsort with double-pop variation
Content-Language: en-US
From: Julian Sikorski <belegdol@gmail.com>
In-Reply-To: <20240113031352.2395118-3-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

it appears that this patch has caused suspend-to-idle regression:

https://gitlab.freedesktop.org/drm/amd/-/issues/3436

In brief, my laptop fails to suspend completely with the following error 
in the log:

Jun 18 12:42:20 kernel: amd_pmc AMDI0005:00: Last suspend didn't reach 
deepest state

Power consumption remains high enough that my battery has already 
unexpectedly drained twice before I noticed something was off.
I am not entirely sure how changes to sorting function can influence 
suspend, but it is what it is. 6.9.5 as shipped by Fedora 40 exhibits 
the issue, 6.9.5 as shipped by Fedora with the patch reverted does not.

Best regards,
Juliam

