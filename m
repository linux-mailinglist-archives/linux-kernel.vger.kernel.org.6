Return-Path: <linux-kernel+bounces-306394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A9963E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0097E1C21B13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBF18C031;
	Thu, 29 Aug 2024 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN6gO2wd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7118C32F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920023; cv=none; b=AfItXFAsbv27bM+u4nn8rAkMgiti52pvEYXOK21mM4NA9LivqZFPqVmairr9TeVp/pLSULUNSjgQ4E3soJXJZRyoRK9W4Ds4dH0ELiCGwBvay55r8kwFYd07n1/ObDfPlGKAaGpmrjWSN8+n2jKAuvtKgu0PhepAdqWTDyqSdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920023; c=relaxed/simple;
	bh=Bg3qnOD/wVviS+JcQvXBgCI/eQDVp+5vsrv7n/OOhkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqnWrC6vHAVJNE8CB65d12Sg7FDHMJlKIymTQDUGxqGBxsIZH2Zklw/mrBikD/HSrFV7fNXXtY9g9TMsBjQrsBIe2tDWbeDQXb7aCDNjovYI/WEJICXMNqfyJDJPZPW3zKzPZUyGZh6+c1sYVKaRBKNrWaP3MNxpPAUJc0IYDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dN6gO2wd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724920020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=009aMKtYz3alNozgyKcZzRLs3QnC7nYwCnZ9axqzyJI=;
	b=dN6gO2wd7tODjZQTVn/wG8h0vgkqYTz6G3E0EvhenputSfqJ14x036jJIGSMMJEllAxiJ1
	48Pft1cazdTaVpXMI3CyM0HNJ9MiCT3phY9YXokIc2tXi+2cif4W8mVeKv2m+DOPXs17C2
	4CZYqPeFmTXIE5gYfmwYBFCt7c1lN80=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-YUNkeSMOOiGPDa_ZKJ4yLw-1; Thu, 29 Aug 2024 04:26:58 -0400
X-MC-Unique: YUNkeSMOOiGPDa_ZKJ4yLw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8680b74416so209157866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920017; x=1725524817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=009aMKtYz3alNozgyKcZzRLs3QnC7nYwCnZ9axqzyJI=;
        b=BuFp6cXXO0ASRmIIEfjjI/jYDCGj4Ejb6cNzTlpFf/i9NmxvpCqfL67X4qw+kPy1Qm
         582+LiGBFc+EGkpyNnc1NYVXYvBSAtNiocPBUBMrRVZeduuUJIqA65uyf/hRILUM1TiD
         0Gh+IyN2z8OMa4+A/APeiqpu+PvjOBAcGVe59d/x7jcA7ERbKrDhFimaJjjeO3YeYAAX
         izJfSPB09bSEwl2uV4CbRAwxX0rMB3r6Qv7OAFucMqd9fDVK+1nRYdpbjk9NztO+Z2Qb
         RlMMlJD3nHeMMo88BFvWsea7+dtWruzWHde1foLYBfFOldCphq65lDvXKskMUREntLPH
         9x1g==
X-Forwarded-Encrypted: i=1; AJvYcCWR7dru3MyvhjfQvMfDAxEw53FDXSye6hax5YGm93GZytIHPBf/G5hJ5DOnaaAJsfHTEXOaJDAkUaKf9aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmkm+P0nwzHZvwOCQc49pw1SzaIvDNf0BcrgT1/LTPSa0qs1J1
	kcuVnZPg0pwd+4I4Yan99W2DZgYNmEYOdIKBUnfOVMRBmqdiKnQb5hW0C29J3/vMS8rqrhoMMk0
	R6CTCq8zfgPQKcuWF7vAoa87BMcRKahmtDIJCDQnjRu2fqjgfahiRzqmjUt2L0Q==
X-Received: by 2002:a17:907:3f08:b0:a7a:8dcd:ffb4 with SMTP id a640c23a62f3a-a898259d562mr216808566b.17.1724920016793;
        Thu, 29 Aug 2024 01:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpgPvAWdmdMwSpjC1P4giL7TG3nksWf9mUuwzWdS9aF/bqlDM5xYu2KySqyBFkeSGzQSLmJg==
X-Received: by 2002:a17:907:3f08:b0:a7a:8dcd:ffb4 with SMTP id a640c23a62f3a-a898259d562mr216805566b.17.1724920016274;
        Thu, 29 Aug 2024 01:26:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c060sm413582a12.50.2024.08.29.01.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 01:26:55 -0700 (PDT)
Message-ID: <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
Date: Thu, 29 Aug 2024 10:26:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: pn533: Add poll mod list filling check
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Samuel Ortiz <sameo@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240827084822.18785-1-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240827084822.18785-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/24 10:48, Aleksandr Mishin wrote:
> In case of im_protocols value is 1 and tm_protocols value is 0 this
> combination successfully passes the check
> 'if (!im_protocols && !tm_protocols)' in the nfc_start_poll().
> But then after pn533_poll_create_mod_list() call in pn533_start_poll()
> poll mod list will remain empty and dev->poll_mod_count will remain 0
> which lead to division by zero.
> 
> Normally no im protocol has value 1 in the mask, so this combination is
> not expected by driver. But these protocol values actually come from
> userspace via Netlink interface (NFC_CMD_START_POLL operation). So a
> broken or malicious program may pass a message containing a "bad"
> combination of protocol parameter values so that dev->poll_mod_count
> is not incremented inside pn533_poll_create_mod_list(), thus leading
> to division by zero.
> Call trace looks like:
> nfc_genl_start_poll()
>    nfc_start_poll()
>      ->start_poll()
>      pn533_start_poll()
> 
> Add poll mod list filling check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: dfccd0f58044 ("NFC: pn533: Add some polling entropy")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

The issue looks real to me and the proposed fix the correct one, but 
waiting a little more for Krzysztof feedback, as he expressed concerns 
on v1.

Thanks,

Paolo


