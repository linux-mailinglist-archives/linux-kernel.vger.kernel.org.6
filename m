Return-Path: <linux-kernel+bounces-256262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04357934B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE5E1F244C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2A78286;
	Thu, 18 Jul 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFaQ9bQ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468968286D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298400; cv=none; b=AG5wShxzn4//aOihoEsPGPM4paO/Y16wDSRdkqUi2DtBgP/RRqRM8IAdF6X3r3lhWZqmrOMJc04mOSP3tMjTYQVcpLgnr9wu1qgVqibkbTZw/lKrVaaC+6x59UfODSq2vXzfwH27mY8cCOCHwCIyIm895MMH+O3HLg8PZJUI3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298400; c=relaxed/simple;
	bh=f9NK3pcNldZyGO0AvxCCKOmkTuD3DOyCdryA06ySy6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJByEkWxf//tYagM9zKgfcZCtkswllbgqFgNaaw5Q7T6DvKNcfRl2q530FcWqDXvw2HGFSrBuYYWv+rIKWDwYign92eEBF/FtQOU6kXj2nMsmhJk3/UQELYAtu9X4172M64ORlTUJ2o6rQwzv+NNe4jIOEtoZlBVFFvrElkx1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFaQ9bQ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721298397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh/bzG1PC5tDGqcltdbZCQ7StmpqIUdkI5gshOOPTZE=;
	b=PFaQ9bQ6IQ90hkID4GegKC9mqjgNjMtajEzdi7bbFXTfL3uFOlO4zBBhMRrrhR66t6XJJT
	DaC149Iq76tJkuafUSgQbgWd16FM2qXBJXTsU1386MwLvpW3aSW5aWGUw7ECBuL2tGbPNf
	SaQXNwbwlNmx27m0K9b6ZpubtBtu5/0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-s6kWQawcMhuycADFkk7EPA-1; Thu, 18 Jul 2024 06:26:36 -0400
X-MC-Unique: s6kWQawcMhuycADFkk7EPA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee8726f1a9so733451fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721298394; x=1721903194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh/bzG1PC5tDGqcltdbZCQ7StmpqIUdkI5gshOOPTZE=;
        b=BE1HWKHc06LKNgKtSK4S4HkPRmUgaUVcQd5/iLc/pLVz5wb6zcPIB4OKm9AP/ct7AG
         yfWKDqYLF3ThS1zQkvV406ROCPm9tF3eemXsIzoUUkkXW95I5sgSu3T8vhHCZFJFYkGl
         jgN9PRrzFEx9q0BzrU3v8D9WFGi4ciUbzmQyET8DKbP+m9Hh3QioWGMeXX5R16ZI3keq
         FyKkxFMPbLjEs29+2toCzggo+XmQ8E39H4n6aVqQ7B3nl1LOLp+PJSDW+seCwf4Wp7du
         K4vOGHGVk6L3iO7TpvAP7mAOtoUz8E9dp7H1SUY2pQHtUuzca7vdkhKlk5Ow68gdCuwR
         7new==
X-Gm-Message-State: AOJu0Yy4IPDFaSxi1oLwBn3Qtjgl6yAeTfmp8YwVnLldcYDC1waXlkAp
	fRZdFOjazjrgencwskO2w/WtjtLYV6K3Q5QXEnwa0YlElaQomcUGGEs2rLPisHO38lfC9ZBrMPS
	1GProZk9godjV3Qz5PD8EKUjNTQiSkpqD3U0BWBGSHoAeCtzDljqov3/jpIUaeSCCWFj4PQ==
X-Received: by 2002:a05:6512:3c9f:b0:52c:dae5:af2f with SMTP id 2adb3069b0e04-52ef000d1e2mr235611e87.0.1721298394087;
        Thu, 18 Jul 2024 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHOk1/oIRkFnzMMYGTQCmQL072G5eWo9tYrROD6I/tWxlW00eAyIj8ZEtQ+LvvewGwTBm4pw==
X-Received: by 2002:a05:6512:3c9f:b0:52c:dae5:af2f with SMTP id 2adb3069b0e04-52ef000d1e2mr235594e87.0.1721298393694;
        Thu, 18 Jul 2024 03:26:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b1825asm5429695e9.15.2024.07.18.03.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 03:26:33 -0700 (PDT)
Message-ID: <69e8f371-89da-4188-be3e-51d7fb7f89af@redhat.com>
Date: Thu, 18 Jul 2024 12:26:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6/ndisc: Fix typo in a comment line
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
References: <2c153a0f-87aa-4f4a-83cc-c17798f0795b@web.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2c153a0f-87aa-4f4a-83cc-c17798f0795b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/16/24 10:36, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 16 Jul 2024 10:28:37 +0200
> 
> Adjust this description for a condition check.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


