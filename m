Return-Path: <linux-kernel+bounces-328205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348C978089
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B52B24DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9271DA626;
	Fri, 13 Sep 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpyoIk5y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE01D9354
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231964; cv=none; b=NaXibnRi8+GQ9ADWBriDY4eNDilUl6PwdewtrMhLyhMqvTXmvRIgW6iFI/q5n25VOTAEx1/PGQLVU1CmTG3blsqQn571+e5SHqDSFpt0YAffhMycKzWIZwb3R1g29C2g2K9HEwNLAC91R06VQ1CpqEVvhHSc1htLGhdVi2O9eBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231964; c=relaxed/simple;
	bh=Z58w98GTT+/pVEgLgwYQuU09XTZYDUL29uYY9jlootM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgDHAnUG1ZGLFKm+/eDZPA84br0SoH7AvhCqACeofPXNDdU/ww72ngIpNSa77Y8no7odIkTrGtLB1Qak8/xRTM0FX6YqDm+zBHBoEVFfsG2/bVk2H5RObGKauTmc84H+IscI4cnZ84FTsGcTDBU1dSKlP4DYYTxUEjt5RiqQUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpyoIk5y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726231962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl05HquAsncJfGKJSFBrSFOKrrN2t2JKKgtLUktSM2A=;
	b=OpyoIk5yxyE9yBoXda//56on19ow4huPITyGoy5zre6ojWbM9Ufb4qsq6jsYIdUOm+j1Mp
	+ODKBFqn7lVOMpm2rwkBZaFSPHqSaxOjgMG2gNdTez06QQOuS1BeTfEpaf+ZECDrXpx6Cf
	HIyIPJjNmm8oZj3XFDeyA+VtRk+seZE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-qQyHstHONC6WXmKATZxfeA-1; Fri, 13 Sep 2024 08:52:40 -0400
X-MC-Unique: qQyHstHONC6WXmKATZxfeA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5328fd5eso19987355ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231960; x=1726836760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl05HquAsncJfGKJSFBrSFOKrrN2t2JKKgtLUktSM2A=;
        b=mvFX8TBEFBYwnypbP/+F4K4kgNzc3snic3Hecyppmb3y602QYBTPZWtXN1JFrgbTD1
         xeyYEI73Zn9PTxszjVx34GKwV8e7SWsTar7OSFAOJDF8QsoJs1zm0SLY9fu/q1LEY2XI
         AdHLxlDaXGx6gtODYgtYbGIZz5+RmAYmSVNBiMIGMOfPIHxZlJ/ormiSsC1J6EXBFZdX
         OOSwSxcvfIOIww0eh0h6IuORgZYTuwmRTu/1AYActeGENMhpYTJxUmOoY3wUlyYsGv60
         fzaehYjMVZ+yZDxO1D4gGz4A0LnJu99/tsjXKk8KRmA2mBiBgQYuJrKAGqO6Mdh1oM3c
         4vTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIhfBw7w66Zu+DngsjbjicS4Nqd+wkZ5IIGCOS2NLvW8B8cY8+negarjUuvKeE0v8qEuacJ8Lidpt7GWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySw0hu1EHHcyXVyjEEO+lv12FsVl0JXsuI4qrYlSo9N04Kfw6S
	x9x3g3LjCgzF9qtI3+MbwXoWdIiyMl/MZ6XHdM2mewxoy/uV4TWLvlfEjKXa/+jXVTtxAok/ITq
	B2SGZIkDOzmPiEs6XAm4KTvu0/ABmPmEqM7/+E3fA6d/bSTpr7wOrIbDCf8JqQNdS6lX9vxbzMd
	MkFYAfVAZ1rGS/B27ctMQw0TfHITnzs2kaBTOp
X-Received: by 2002:a05:6e02:1383:b0:39f:5abe:ec25 with SMTP id e9e14a558f8ab-3a08495478amr60011685ab.19.1726231960115;
        Fri, 13 Sep 2024 05:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwLSNinCxdMGjUdbfB8K3Nj35P1O2ZHOuUti0jQxahFf7ERb5uddFQ5NioJygZfBUzuO8uwTkyZu28jvB7vZ0=
X-Received: by 2002:a05:6e02:1383:b0:39f:5abe:ec25 with SMTP id
 e9e14a558f8ab-3a08495478amr60011405ab.19.1726231959796; Fri, 13 Sep 2024
 05:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
 <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com> <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
 <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com> <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
In-Reply-To: <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 20:52:48 +0800
Message-ID: <CALu+AoStijsAxNvX0h2w7jBt-4sHr0O9AEtyyoxNbLBtgmZB7g@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

Hi Usama,

> > Anyway I was not aware very much about the firmware e820 tables and
> > kexec tables when they were created.   I suspect that a cleanup and
> > revisit is needed.  I will have a look at that.
>
> Yes, I feel like there is one too many tables! From reading the code
> I understand that /sys/firmware/memmap should contain the untouched map
> at time of boot, i.e. e820_table_firmware. But I would be in favour of
> getting rid of e820_table_firmware, and just having e820_table_kexec.
> And /sys/firmware/memmap gets data from e820_table_kexec.

Agreed, I have the same feelings.

Thanks
Dave


