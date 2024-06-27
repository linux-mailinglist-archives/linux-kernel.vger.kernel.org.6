Return-Path: <linux-kernel+bounces-232073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FA91A2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA551C20B02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6213A895;
	Thu, 27 Jun 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf1enubo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94326139D0A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480838; cv=none; b=Pn438nGfcjzco3j6JBpzT0YiIlhboSG7Xib1AXfvgET5vZy3Pvb4B7eR6lw5Qn1I+v6a+wIuKwpv+gt8cefVESNLrzUO4OeA+7ceYSKoLK+xI0TxtI6QPNPLypR5OYA5wJ4WaCZCiIfXG5SqxHfRXQap5ymIzh3c/lnmehYdsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480838; c=relaxed/simple;
	bh=e/sox5BtCFoGahC1lVAtTuyfJ5meNt0WBnGdBiIhExo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KM2cvKq70Qjox+iAwIYZjusDayvTcCwILM9P7I7FVmGxi1CXYB4h6OaXY+JpwVj0I7pfCUuqrqkK7ZBAYOwJRnVTCzwbEKjTUuq3LWzfQh0VCoKSmCAxKNDyeNMCMXQWhUpfjGYbOWdlW74HQ/KyMChDdGaYRisg4vjWRhFXptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bf1enubo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719480835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6AFX5nfz39aumDkQAmzBwU8o/lxwEczpOvC7mGT7iE=;
	b=bf1enubodS84a5IrgdkVosT36vfWz5LSPR876zv69kTQFpRX+SlO7MzevSYOWZOnDrbDDd
	JwcZ5GsTlaOJwJsYEJpIsNgThK/Do8Rjx3yo1oFpaCAyzEGJXGjcOgG0iyBlWq/wWBtsbI
	+Wbo8YC7zLHfEHVV8mLVCRwXv80eQnw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-ZYVsIuDuMZeKzTR_I6GP8Q-1; Thu, 27 Jun 2024 05:33:53 -0400
X-MC-Unique: ZYVsIuDuMZeKzTR_I6GP8Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-424fb2df2bdso14712025e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719480832; x=1720085632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6AFX5nfz39aumDkQAmzBwU8o/lxwEczpOvC7mGT7iE=;
        b=SMfBce4LYkNJwrEZFA/4MLZGce3N+MCEpfICsyFRyjsx53WgQ28N1anrK4jKCu51i1
         VRRGkbpfA6ig7tF3t1hmdtJ9UP7P8llVaCknqPVpf4emiNhZkCEKokhO03YBxfdLvFLU
         r1pKbkoNa3OnIoPvsu6+DzAjnMuM8Dlgmhm59p+w/w4T5NWYfDAzZ7uy59iFtqw7ob0R
         RU5lYj5uBL9Jzfa5qTVFIT6M61ixa8V8A5HmpfPUNY7NDSUakEzEM+9WyJ+4+AKasaVe
         VzgNkIjhRkkYBzLfvxoNa0SzSHmUar6ha63ltUUUEwlz72yietGVE1cBeVmRTmfnFw15
         kTxw==
X-Gm-Message-State: AOJu0YxJCM2HUNvnPm0FZYZTECI2c3xQIljObaaRURFClaom+LTxaq8X
	hp05P85Uc3iyk73Q4ZrBEJbNz/ufx7fMdxBmjLoW2bRYhwzQH8TigEw4taaxL7wo3NGGpheKGFJ
	t1YZ4gKCQIaZSefGIUd6OdD2Rqo+DHcGXLIh430WcmTNMXxj6AmVhZI0VE8z24H76wI4eNi4g
X-Received: by 2002:a05:600c:3042:b0:424:aa40:88ae with SMTP id 5b1f17b1804b1-424aa40890amr48959915e9.3.1719480831923;
        Thu, 27 Jun 2024 02:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe+RUZ6pKhobfeQq6jzOfedhVDQl7pDRHuuC8ZS6m+6Gkz5l5rNbQkC7wzlbXnp376LNbQzQ==
X-Received: by 2002:a05:600c:3042:b0:424:aa40:88ae with SMTP id 5b1f17b1804b1-424aa40890amr48959775e9.3.1719480831607;
        Thu, 27 Jun 2024 02:33:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c84245f0sm57318985e9.33.2024.06.27.02.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 02:33:51 -0700 (PDT)
Message-ID: <fa16b034-5511-4db7-aa83-9ece8bc07c89@redhat.com>
Date: Thu, 27 Jun 2024 11:33:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20240626]Kernel Build Fails on repo
 linux-next-20240626
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org
References: <32f20573-7e3b-496a-8c02-9234d410113e@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <32f20573-7e3b-496a-8c02-9234d410113e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I think this patch was merged by mistake, as it was not yet reviewed. 
can someone revert it ?

-- 

Jocelyn

On 27/06/2024 06:21, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> Kernel Build fails with below error, while building with 
> linux-next(next-20240626) repo.
> 
> 
> arch/powerpc/kernel/nvram_64.c:79:17: error: initialization of ‘void 
> (*)(struct kmsg_dumper *, enum kmsg_dump_reason,  const char *)’ from 
> incompatible pointer type ‘void (*)(struct kmsg_dumper *, enum 
> kmsg_dump_reason)’ [-Werror=incompatible-pointer-types]
>     79 |         .dump = oops_to_nvram
>        |                 ^~~~~~~~~~~~~
> arch/powerpc/kernel/nvram_64.c:79:17: note: (near initialization for 
> ‘nvram_kmsg_dumper.dump’)
> arch/powerpc/kernel/nvram_64.c:645:13: error: conflicting types for 
> ‘oops_to_nvram’; have ‘void(struct kmsg_dumper *, enum 
> kmsg_dump_reason,  const char *)’
>    645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
>        |             ^~~~~~~~~~~~~
> arch/powerpc/kernel/nvram_64.c:75:13: note: previous declaration of 
> ‘oops_to_nvram’ with type ‘void(struct kmsg_dumper *, enum 
> kmsg_dump_reason)’
>     75 | static void oops_to_nvram(struct kmsg_dumper *dumper,
>        |             ^~~~~~~~~~~~~
> arch/powerpc/kernel/nvram_64.c:75:13: error: ‘oops_to_nvram’ used but 
> never defined [-Werror]
> arch/powerpc/kernel/nvram_64.c:645:13: error: ‘oops_to_nvram’ defined 
> but not used [-Werror=unused-function]
>    645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
>        |             ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:244: 
> arch/powerpc/kernel/nvram_64.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:485: arch/powerpc/kernel] Error 2
> 
> make[2]: *** [scripts/Makefile.build:485: arch/powerpc] Error 2
> 
> 
> This issue has been introduced with the below commit.
> 
> 
> Commit ID: 7e72bb7504d1192ab89809f6192dba1b06f4fa51.
> 
> 
> Regards,
> 
> Venkat.
> 


