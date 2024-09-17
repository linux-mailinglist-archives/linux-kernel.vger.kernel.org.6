Return-Path: <linux-kernel+bounces-331665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166A97AFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F010B230B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBEA1662F1;
	Tue, 17 Sep 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anI3phN5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D454291E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573184; cv=none; b=gpp+PnxjY7fE8HS74BXWuOcIqJRZNdxiPsmmCboT6dMTPvN+m/jEZJ98QFrZfmS10L7n/8f0mr03p6kwLH05/PpgOGPWjxlUnuhQ7yTFWE56E1Umn3AnUhDv2TSA0ciLeJAhLrshtEEzQXTmtEMvW0fKvbJkZ4MV4vi3VAlBc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573184; c=relaxed/simple;
	bh=dt6levFMxkrBxTkHkAW8cmaWvRTC+fIKiHPD9GIU1DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upbzhsaeBUFs/WL7tywGs6u1JTTm63jBYv6t6IVezQ123RFN7MO09MIDjwEVdUIRYIAu8nQeu1tvnmkr+FHNSNkMJHOcTGYteJiGVCDPi4HmHusTwswy+AX3q1cAbpuitsmUQKRjSdOdUQBrp4wbF/Ee4L3g+Ykm/Oyu6CV+Mt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anI3phN5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726573182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x25FGhNrbRrB7l0EAbf9r+A9zJVW9TzQMyHez/fL9yw=;
	b=anI3phN5mygqPMSpdBmuRQz1aSWeroq+PWFsvrXreELLv9LuVHZh2+Ssy95qWVEcYLdwrB
	ODbTyzTmsUNKhGm11s5Z0SvCH7D1saMqA3XUXvTZp53HigR61Rqm8imfseoQU8gronDWb8
	URwftpuQa8u1/mkDBIuq6s3JjJOicSI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-zh6jmFaoMRWa69-EqcypVw-1; Tue, 17 Sep 2024 07:39:40 -0400
X-MC-Unique: zh6jmFaoMRWa69-EqcypVw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5356908d54dso1446645e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726573179; x=1727177979;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x25FGhNrbRrB7l0EAbf9r+A9zJVW9TzQMyHez/fL9yw=;
        b=lIAWokndjLNrfZfL5fLFJMfbf4yV1puRv8uLaVmVX8/CnlW1t8ynKiBarwyoK0tk3l
         CU/5jSaFSAlxFcTcy2jvMcvOO3Zq4dCtceAuiC5vGkmYKV/18YnPMjNGUTXSNtcfI8lC
         ItXl5e0ZiGvy8l2HxaQO0QxlZcdAz87+79tzo6RsP97lHAFJovTbQgbfwuckFPMWmOVB
         tIWcRZwI48JeVxQeWqmmUfRC9TTtbCThcEszH47XzBEL0Jdk3yoMdiUQJVzWxAT2m7YZ
         0LpmcU8+YczXrC97yskNk0DDdXdRdOULgWpAtxXSBEy4vQbdnOleZl2GE9+n40X5OPMK
         dF5w==
X-Gm-Message-State: AOJu0Yza2kNKiJNfUSW6RoX4Kce6N6hc2AnBYmY4E1pIAHB+GDk3qEsL
	rLdgXR7Y1HfAj3kwR5F2xhHRhE2d1KyRq3VucOnG6RBKpaOU+UQbEc3lDbI2H3KjHIE/n+0xaic
	JZDKmdlM1A5S2wIU0Brcja0C3umrnggOGgQ4bzNLbK8cVOpf9KMt6cAbkkk0Xgrs+rc2eNA==
X-Received: by 2002:a05:6512:2384:b0:533:1cb8:ec6e with SMTP id 2adb3069b0e04-53678fd1244mr9293217e87.33.1726573179238;
        Tue, 17 Sep 2024 04:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIPiQM2QeQhlXxzkl2yNRrunnMhLvrgjoAQtiYKnuUy5KGUQvdORsr41DP3x/pZkWD8Kf2hw==
X-Received: by 2002:a05:6512:2384:b0:533:1cb8:ec6e with SMTP id 2adb3069b0e04-53678fd1244mr9293197e87.33.1726573178642;
        Tue, 17 Sep 2024 04:39:38 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a19sm3571129a12.83.2024.09.17.04.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 04:39:38 -0700 (PDT)
Message-ID: <d289061d-7dc8-41d7-a166-4b3b8dce886d@redhat.com>
Date: Tue, 17 Sep 2024 13:39:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dead code by symbols
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org, kees@kernel.org
References: <ZugliLgw5VFb9yau@gallifrey>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZugliLgw5VFb9yau@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.09.24 14:33, Dr. David Alan Gilbert wrote:
> Hi David,
>    A while ago we were chatting about me spotting dead structs, and
> you wondered if it might be possible to spot dead functions that
> were exported from an object but never used - and I've been trying
> it for the last few days.
> 
>    I'm pretty early on, but it's already got some fun things:

Cool, stuff! :)

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
>    Core code not used for ~20 years
> 
> https://lore.kernel.org/lkml/1690847.1726346402@warthog.procyon.org.uk/
>    A bug! A recently added function that lost the place it was wired up
>    so was currently unused.

That is really nice!

> 
> https://lore.kernel.org/lkml/ZuXOWjvVYa64c1-5@gallifrey/
>    A few small dead files.
> 
> Now, it does take some more guesswork, for example an unused function
> which was added a couple of years back, might be something that's
> there for consistency, 

I know people will find reasons to do something like that, but we really 
*shouldn't* be maintaining / dragging along dead code that nobody might 
ever use.

> might have been forgotten to be wired up,

Forgotten as in "BUG" or as in "ran out of steam" ?

> or might just be something that's going to be used but the
> authors haven't got to it yet, e.g.
>     https://lore.kernel.org/lkml/ZuRGRKU9bjgC52mD@gallifrey/

Yes, that' a valid case.

> 
> My patience varies from Ooh core code, to meh old driver to very meh
> for old undead staging code.

:)

> 
>    I've got some nasty awk which kind of works some of the time;
> but it does require a lot of handholding; often things like inlining
> isn't spotted so gives a false positive, and I'm only looking at
> the objects from a single architecture, so again have to grep
> for the symbol name to make sure it's not used by a different
> architecture build.
> 
>    And heck, I wish git log -G was faster.

:)

> 
> Anyway, thanks for the suggestion!

Glad you're able to spot some nice (+fun, otherwise you wouldn't be 
doing it ;) ) things!

-- 
Cheers,

David / dhildenb


