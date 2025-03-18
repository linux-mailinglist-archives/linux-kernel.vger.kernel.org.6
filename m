Return-Path: <linux-kernel+bounces-565995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969CA671E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762231893C05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E3A20896D;
	Tue, 18 Mar 2025 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWkVQ712"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4C2080C3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295330; cv=none; b=CTLeh1CaXgOzPE+g9GZnwr7KRHuuqVMPar3tQ4v4K21l4ZFF+ILUU1cBbzO3wcoagNXyuAJ8R/PwT8MHW2uWtlml6fXmamp91P0nAd2NaeffO0gx3zg8C09vQ2Q8YXLGCOXUS9Z3eSnQoEHy5L4M+VnBtRtGi7e7cWD9bsItUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295330; c=relaxed/simple;
	bh=mFjQbMbXmrzrA9/oqDco2SadbOJD1AxZiZTUK+/CQGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p115Qj3I3yxBEq5sPe17fAEVJ7qS3KcSolvSgmXtkuoyvduvJ/4IxyAmJUIwscnJztNo8wu7bxcQ/FeJUOTwKh2jIDh/d8wpC3OnR2YvmvKmYvsSsIrr8SIII3SQUqVr1GuWbDkUX2ku7NhAGDR4kPwEjEar1G43cdQ/Lx1L8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWkVQ712; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742295324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHPKRiD5IvPCz4tWY3lFXAHK+T/t5ZDvSNwr48IWoBc=;
	b=GWkVQ712ILoOVcCCfB9uw2S3tZLcTf0mcRCLnoBESkad+QPTTzFsfyTDDiIH+K/Y7gVziQ
	vYueWIiOMEcb1bh/LUYUy/JpkxdFaGB4jYFuDM/hGDjADoRLJ7mt9YTgN0Q+DIAb8wgJER
	WKBiU5yQodfv8TBbt66D7SqeNnQBgqM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-4S_LnmhpOMGZWJkat1pU3A-1; Tue, 18 Mar 2025 06:55:23 -0400
X-MC-Unique: 4S_LnmhpOMGZWJkat1pU3A-1
X-Mimecast-MFC-AGG-ID: 4S_LnmhpOMGZWJkat1pU3A_1742295322
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394040fea1so15529975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295322; x=1742900122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHPKRiD5IvPCz4tWY3lFXAHK+T/t5ZDvSNwr48IWoBc=;
        b=oG4lxzglJS45ohQXHyYdzLbfVOhVb9Ar/amud67LY4NS0teSHibBzmyEQX+sY4qJ8G
         VbjOEJrN7N0uzc6KXBe3dZ/2zCOaK8TKnGg0NlxopN/XkEPFj7x8IirZIwpTHuD91VcM
         WOnyB56AhFqPg/JLsjJ4twM2e2Uvvl/jBe8yVwYsuWlJBKUaQxeNXbS9/QnzLL0blMec
         ZE/qjHWAjSOB0ePENrX7ZjbTuhjnypB9udIDthMLYOFi7ZxvX1HhEiGw05hl0SShMruL
         H7dBBqElvpyO1SipE7tNa7DMfR6a5BFqeOCNlGr0nLYlRbPNGkk7ZHPNVkoiq0siOlq6
         RPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqXDa9/a/tBE/uZNPSIL75r81UL2qsDE09YJ60YnRIOSMjTWJwV5C+h6onrkIqlgeCcIs/3HVeLOLKDug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgmjYFX82N3nxMjH+KTmNOEkThMurLTUWEvWhoVzUtjG8NPCG
	s1SrVHzxV5j/Gd7uEBxBIYzgkf4ZOIaFL0PPSZkehTjVyk7JE3iTkeeBm5CwLLyiTz2lnuV7iJO
	Y9sNq2plKshFXp/VREZztz2yuTNgoofMl0GhHpfa/h7vFnu/3hgIf2rXvMylXKw==
X-Gm-Gg: ASbGncuEQoiN/klnI/KbaHjEThErXuIl8lgUAYVVpqzqmq2Qk8pg5zPPA8V54RADSkS
	7a9t7xJhfMGFZSW/JMN+8GLQg+f08RqKwW9devL+e7l5y8xKArw+fm/b66f/GpzVlDQNzq9fcGC
	qW6NMNvhlYEtVvsXhG+wPjGZqau8mJnfEHPUuI/aiHNbYy0JTiUWxlBuBd3UrA//+chMPYUc+dj
	kVsrEVxpe/6SC1ardmO4+l1iUdtXAcSpXduvB1dxERf5Df7AblFbkMuoDGFsSfy80bPOGFGnc8d
	2IapIwfNUnW2Z8vI/aTRH6zbYWwSivkU2TjBOKOSPCwwuEIno5ck1X8zNPhrecC/
X-Received: by 2002:a05:600c:1e24:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-43d3bcd5e6amr19520885e9.15.1742295321959;
        Tue, 18 Mar 2025 03:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvdAtLAHCC5OhzhAzDzeB18bQRy5AjBp/p9Eb8xmzJT+FhfPVJQf69XVrgDbULlTazB3e+Mw==
X-Received: by 2002:a05:600c:1e24:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-43d3bcd5e6amr19520675e9.15.1742295321527;
        Tue, 18 Mar 2025 03:55:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbf901sm130094875e9.15.2025.03.18.03.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:55:20 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:55:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, 
	Sumit Garg <sumit.garg@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 2/3] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <c5tgxiza47d3md5epw32exddl3wm5pkc3ja76dkex5jwxpmcnj@c27hnr4ezido>
References: <20250311100130.42169-1-sgarzare@redhat.com>
 <20250311100130.42169-3-sgarzare@redhat.com>
 <Z9KhlSr7qG6VooeC@sumit-X1>
 <CAHUa44HEpfL8nmG6qZMYUesSJXWUraUmJE_nwFTp5L8qBaC-jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44HEpfL8nmG6qZMYUesSJXWUraUmJE_nwFTp5L8qBaC-jA@mail.gmail.com>

Hi Sumit, Jens,

On Thu, Mar 13, 2025 at 01:59:19PM +0100, Jens Wiklander wrote:
>On Thu, Mar 13, 2025 at 10:13 AM Sumit Garg <sumit.garg@kernel.org> 
>wrote:
>>
>> + Jens
>>
>> Hi Stefano,
>>
>> On Tue, Mar 11, 2025 at 11:01:29AM +0100, Stefano Garzarella wrote:
>> > This driver does not support interrupts, and receiving the response is
>> > synchronous with sending the command.
>> >
>> > It used an internal buffer to cache the response when .send() is called,
>> > and then return it when .recv() is called.
>> >
>> > Let's simplify the driver by implementing the new send_recv() op, so that
>> > we can also remove the 4KB internal buffer used to cache the response.
>>
>> Looks like a nice cleanup to me but it needs to be tested. Jens, can you
>> give this patch a try?
>>
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> > Note: I don't know how to test this driver, so I just build it.
>> > If someone can test it, or tell me how to do, it will be great!
>
>Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
>

Thanks for testing this!

>Cheers,
>Jens
>
>>
>> The fTPM is now maintained as part of OP-TEE project here [1]. The
>> instructions to test it on Qemu can be found here [2] as part of CI
>> pipeline.
>>
>> [1] https://github.com/OP-TEE/optee_ftpm
>> [2] https://github.com/OP-TEE/optee_ftpm/blob/master/.github/workflows/ci.yml
>>

Thanks for the links, I'll take a look!

Stefano


