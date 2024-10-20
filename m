Return-Path: <linux-kernel+bounces-373141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7F9A52EF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B2B283368
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F117C9E;
	Sun, 20 Oct 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsEBMOad"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440B14293
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729406795; cv=none; b=qL8Z4bBs5v3eWDWD4UNA/oahtRpjCI6XXBY/4tAiiVKZ5foQ2M6uxtWS9xdK02K/DZx02uFibY5NT0hfL/Nz/wUPxFRfi4ZAlMepKbQ5R5XJYbdnj2F29zmKFprhtc9M0UIGpLReCt7ZEGqSAYx175TyE55cB2FiEIPULQdfw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729406795; c=relaxed/simple;
	bh=ZlyCCkyVPL2yKT00heHTSzI0lN3NkFnYnQuTZTl1LNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hQ4av+DQK9MW/XiKI2x8siAiRM4Y/S9SsnWi/iuzHAO3OE1Ly3GZ61MguUxQPfOOX4cm1ypIt9OiweTj9+tOFkCCYdtal0omypJmLYeDe46ZAyb90HCTYgh+PTuH74BF75DjEbnKcaA5bUOexoCbsn8AmqWTkuryiWZP6DWF4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsEBMOad; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a16b310f5so438099866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729406791; x=1730011591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COb/MxWpslExjJ2y+aQE3iXoY1WEfCLC1KSfvE9eVgA=;
        b=FsEBMOadMDvHKGpJX0mytmBc4VsH83dAK1k6wKzpSHZ5eq5Eq2GJXqxEJIpCEFLu2A
         funTkZl2pHV1UXuAfSMAAs/EfaHwXXvKDCAdeXkOZLxXzH2XgNpgGaF2BuF4pIbEp5ZK
         J8kyHktSFtOwmGDSesDmZS6KjNjdiW7mlBNlwQu/7EiWN49GhDqP1TX2Or8/lNSSS4Cc
         oB5UMlj11z7/BkLpmJLTRnC9KQjhBJAQrNN4ASRtv7JM+Qx8bvZUYnZIs/2gFeL45YnO
         VT0zEioM6ly4zMvnaRHuJn9LOioukBZSnVuzlS73gryzryvTK353gxHN0OsR4r//ZY2F
         R6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729406791; x=1730011591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COb/MxWpslExjJ2y+aQE3iXoY1WEfCLC1KSfvE9eVgA=;
        b=nmD8Rak4inlFBaUWk4xl4xp/jg34TFnsv29XM5dHk9uQY818sSpDup1dnX8U6g42pp
         ddkjFqAD/eSUXRpnB89U/rW25i7sfLwQ7zk8LCPzy29WQPqisXPRlJkxGmfoenpkGhMY
         RZ7v7an+Ira1sl78Cg1pj1JMBSb2P8YrNauty4UOR40I7xXkEtFMSHNmWnc8bLjZewgo
         iNtak0lIVwdX4cTwAuh0HALlavn39KCO/kw52ga9PGwVjGQfjVN2NlulmEB7neCrIhPv
         IF626AXBe2ykKzDiQSJL0Cui6GHBfpyuH936BQ2wfwcpgiYpfMrA2dneyH+C8eXv6+zu
         wXmw==
X-Forwarded-Encrypted: i=1; AJvYcCWxaUfkby0bWSyHm4qukYH5fKn54rR/9vmYLMkptcPB5CW9LLoj/21/+jPvEOY82/jE8iUhj36fFLeJz2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFHXKnuWyhv2WIVaCKSYcPPN1mrEHK8HbsWM6KnghtorCotS6
	OQn6ERG3WCc01+mz0rRQLsZVTU/c5/CfLqqKeQ7VJGgXn3kZuznh
X-Google-Smtp-Source: AGHT+IF1taH6Pjk0sXMmdA8WLKyW4JszvHTsr0o07xoXpAlDSLSG0xE4Z3umM7V5VWkMSuBmhZlTfA==
X-Received: by 2002:a17:907:3f23:b0:a99:e4db:4909 with SMTP id a640c23a62f3a-a9a69a746e7mr789527466b.15.1729406791126;
        Sat, 19 Oct 2024 23:46:31 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee59dsm57997866b.71.2024.10.19.23.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 23:46:30 -0700 (PDT)
Message-ID: <7a491d10-9af6-4ddf-85bc-fc483f6d66bb@gmail.com>
Date: Sun, 20 Oct 2024 08:46:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Assistance Needed for Kernel mode driver Soft Lockup Issue
To: Muni Sekhar <munisekharrms@gmail.com>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>,
 kernel-hardening-sc.1597159196.oakfigcenbmaokmiekdo-munisekharrms=gmail.com@lists.openwall.com,
 LKML <linux-kernel@vger.kernel.org>
References: <CAHhAz+iHsEaEkhEFNPyiiR-N-eLYYa3dFArO3rLvGdGKnWbm2w@mail.gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CAHhAz+iHsEaEkhEFNPyiiR-N-eLYYa3dFArO3rLvGdGKnWbm2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.10.24 21:09, Muni Sekhar wrote:
> Dear Linux Kernel Developers,
> 
> I am encountering a soft lockup issue in my system related to the
> continuous while loop in the empty_rx_fifo() function. Below is the
> relevant code:


Hi Muni,

I am missing base information.
What system are your using?
What kernel are you using? Version? which git repo?
What is the driver and device you are talking about?

Thanks for your support.

Bye Philipp

