Return-Path: <linux-kernel+bounces-269946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E381943920
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500D21C210B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71A16D9AA;
	Wed, 31 Jul 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQrt5S6b"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C449625
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466592; cv=none; b=KRQ+dmVHnjTGATUFaJkw7lOIqklZvzo4icMTQ5zi1TMEOdAI77dWl4pxiwxsBc2ZPEc7ofYvPLX+ctGNsMdwIrzJ2sOuFuV0r965Lhj20DZMc04MijvsFEgqn+qL+RZ7DGlfXDQdRA06fMf5xs9y/b1lIadPBZ8RdUv6z1S/m0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466592; c=relaxed/simple;
	bh=Ebosq3cwyBruwiE9aeSWL/53cRFfmjfzUGrFTcpmIpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djlLv7T8czy4E+CtasRgE4yk4jDzj+9ElVtIFXMi9XfoAz06399Op9nAeUMWqvKZY71xIoxC27alRSd+TgZabuBSDz4m+YOZOVbId3P+PUxFdGHOWmPLCwMKjITjQ2nou0VUiMCSoblTf9CV4j1Mh82T+M9fcVkIMtizYjpV3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQrt5S6b; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39633f58414so1614645ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722466589; x=1723071389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsGqV04G2H9TtXqt68J+lGioNnr8QfMZ/BUMYQBEazI=;
        b=FQrt5S6bxBz+raveuUNwV+ixdjlcS9Xg+MljzOJXQhkHmdWP9jiIND2c/jYRhiMRS0
         igPDwS+pKHEug1kLC9Qv6uUbBtROZ8efEmMV9Sq9duk1hXS3RlswnBdEpg8+i22uQyY8
         OajyFQgnvHZK0hfexC9NLBrFzZP0/0PU4elnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722466589; x=1723071389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsGqV04G2H9TtXqt68J+lGioNnr8QfMZ/BUMYQBEazI=;
        b=O8IC3DbJ/sQ22fKn1xml6QeM5cLP85ht0y6OUeOxLfPh9Mk9BfwAlztcYTLJg5L+XF
         4EkGWldI8thtl4kOwTG49fSudRiQDdCFzTQhgjnBToX0WXyKkaAs//DvkwVVMMfxwHQa
         9Pj+qtnKyMeLVd+cNfuYPOusJJnNf0CSkvbyQ9byNeiRZ1+k2pOMKLieYSeOkacr/kp2
         g/S+NJwKDfdixHmggpUgf36ULddDzUmhoAT6288kVw2IDeHC74kW9HRr4ez74H0vU9qz
         6EXLZcnnuh2jkE4SXsUZQUFM4/itsrYyeh6S7QslvFMCsfUAL5Yb0UbgeOm+6/3KqmcC
         ejEw==
X-Gm-Message-State: AOJu0Yw5ShYMfberxYHXfZt4sdn21AXFMt/yE2N+XhcVGYziCpi05Nt+
	nXrkfN4i0wWwjUc969MBbOKr2zwIQcB2mBT9DdSgcelTkpmhl/tU96SRLDVXINk=
X-Google-Smtp-Source: AGHT+IFk6x+qB+GTV+ysQrTShT6g6IwHZ/ny273g/2Uq6eWdA30AiD9pAfjELmXhs3BUfTPkSYxX8A==
X-Received: by 2002:a05:6e02:1547:b0:39a:eba6:69f8 with SMTP id e9e14a558f8ab-39b184c57eemr4190315ab.3.1722466589625;
        Wed, 31 Jul 2024 15:56:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39aef99c7f4sm39799725ab.87.2024.07.31.15.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 15:56:29 -0700 (PDT)
Message-ID: <24794ab4-d22f-41ae-bb1c-83175835e509@linuxfoundation.org>
Date: Wed, 31 Jul 2024 16:56:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tools/nolibc: add support for [v]sscanf()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/24 12:32, Thomas Weißschuh wrote:
> The implementation is limited and only supports numeric arguments.

It would help to add more details on why this is needed especially
in the commit log.

> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (2):
>        tools/nolibc: add support for [v]sscanf()
>        Revert "selftests: kselftest: Fix build failure with NOLIBC"
> 
>   tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
>   tools/testing/selftests/kselftest.h          |  5 --
>   tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
>   3 files changed, 152 insertions(+), 5 deletions(-)
> ---
> base-commit: ae1f550efc11eaf1496c431d9c6e784cb49124c5
> change-id: 20240414-nolibc-scanf-f1db6930d0c6
> 
> Best regards,


