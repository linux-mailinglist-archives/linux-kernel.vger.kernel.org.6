Return-Path: <linux-kernel+bounces-282329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF294E250
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 18:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1C01C2093B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625791537D7;
	Sun, 11 Aug 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQF6LNYX"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A43715E;
	Sun, 11 Aug 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394295; cv=none; b=Ankzeqs52MAVEKBIF+JOts/0R6KhUl9m5tZemPE+irFVYm/u9afOIkLi4wvFiR8nevT1gSr10t+6K+9rPQlNFSM8GPqB07CsWA7kW0Zwu4lKhyGhqV+t2/qFr6Dwx0DQm38qtgjPYWfcq0wvod39qoDoCfPYFbZ/Icj+hm7AZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394295; c=relaxed/simple;
	bh=Y+NTnHleEkqfILvvk4qSrCw+HTpzEe30ogMxm29uIlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drtVwsGUwuvIyG5Xu5jlN3bifCd0wvz0BCWaj7ffRInTv2wNZrDNefS0FsYKaxz53eU4rh+xcQBibFubHDvmu6luoj0bADkyVgsDJIljLRNmtxQ/qAXnaw2PBRZqG8pFBpexZeKYzcXiBawk+WN+cE1zcbLe+xC/isoYHr90F1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQF6LNYX; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-261112c303bso2842683fac.1;
        Sun, 11 Aug 2024 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723394293; x=1723999093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+NTnHleEkqfILvvk4qSrCw+HTpzEe30ogMxm29uIlE=;
        b=HQF6LNYXoUrKCuBQ6224+zCuH4AIVU6z7Yk88N2UAoLjXxV+gz+nyIao8avoGlFxgH
         6h1MUIBPrH9dcTwdBeNXxM+Gnf6zgjyQ/86PU/RPqyNG9tFNSu5Vkp+cOT2XpOQmHYiA
         fyjemRm1orNwAAn0251rvHk06mxrs9pMFcDVdNj/d1A9gZtoIJO3MyEtabZFgsuJ1YGv
         6LzazYBuE+/46QgcMj/JUjMwHWnfy6Umo1nQMTQ+ZDY++q1nP+fQCI+MVIUhgPHUZwJ9
         zqH1MekowTwadynpeKK5iLoeFrppgFkpWE7r3CRgVymreCmnaGHAVVy77mAQlFzUDJy6
         DkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723394293; x=1723999093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+NTnHleEkqfILvvk4qSrCw+HTpzEe30ogMxm29uIlE=;
        b=H/MWtyKIxbeE6Z+l41LF82vl4df8GnAKr+/w5snvHFyQDYmayRYEpT0RY1fbDKQf/9
         57D37a/8sUORCgwK27d3iMKjHd6ZlV1HIQ1DlkqIpUMRGb2pK+sPlnQdg4SOAcaBbE0n
         unlzBTIhKvEvrzidjywTAZLt6CZ/R8LyDo+vRxj56psRlstW35ii2dD1eg4DF4EbNvIm
         BiiPww6PMFqcQ46txCSe/rso3MveowBA86MWK06FNtH6fEulmLzs/GmSKNGA5rogRmB8
         MHWpsFmHduxBQdXhb0G8saj3H0O4hm5arB7vzGR9Df6ANuTmX6uUb54kx5rlGS7tjzSJ
         X/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWuKMSABxplsod+EsF3bKGDqt5iryCAfTOHiPUIPkh842jm2rIzoIV1tfUzGUddidGfBXwqo04jN7um2Fvy/eYZCjO5aNWPIfvWHPPl
X-Gm-Message-State: AOJu0YzFrwu5MBYcXnFBqLBSqlgQoOzKPwbs2b6ei/qcPYYzToI83o5/
	Uw5UZhWwk8MR9BgMdNQfwhGS33DM7nEwVKnZVW3NrgRWGLbqMt7y
X-Google-Smtp-Source: AGHT+IFt4OWbki80dHWLXSe8zfKBrJruDBoPMUW3zsS4VoHmKLWspr7mqFgIFh8+tZFFnEYjguPmZA==
X-Received: by 2002:a05:6871:b25:b0:25e:1f67:b3bb with SMTP id 586e51a60fabf-26c62c426e3mr9228165fac.10.1723394293340;
        Sun, 11 Aug 2024 09:38:13 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c72045928sm1327064fac.4.2024.08.11.09.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 09:38:13 -0700 (PDT)
Message-ID: <17afa9c2-29f9-43e8-8dfe-398eed312cea@gmail.com>
Date: Sun, 11 Aug 2024 11:38:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/sp_SP: Add translation for
 scheduler/sched-bwc.rst
To: Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20240810100955.14901-1-sergio.collado@gmail.com>
 <87le14bfm7.fsf@trenco.lwn.net>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <87le14bfm7.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/10/24 09:46, Jonathan Corbet wrote:

> Sergio González Collado <sergio.collado@gmail.com> writes:
>
>> Translate Documentation/scheduler/sched-bwc.rst into Spanish.
>>
>> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
>> ---
>> v1 -> v2 typos corrected
>> ---
>> v2 -> v3 typos corrected
> Thanks for working to improve our docs but ... if you find yourself
> sending three versions in less than 30 minutes, that is perhaps a sign
> that it would be good to slow down just a bit and be a little more
> careful.


This v3 does not have the changes I asked you for v2, Sergio. You'll need
to send v4.


> Thanks,
>
> jon


Thanks,

Carlos


