Return-Path: <linux-kernel+bounces-418933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B49D676A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 04:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4810EB21ABB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 03:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB1F47A5C;
	Sat, 23 Nov 2024 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnYfm+P5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9B817
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 03:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732334150; cv=none; b=ZP7qvTLRs5bRdBhb7ca9EHi9f8EnAJ0eFSbRUCQ4ehoQ8NXlFL+BF3fKcxttxSsHv8bhNP0JtEfsbPKeTaikxvhogeKx8d5+z/rQXk/8EW+QoJ4o9KCytJs2o6pKN9I6GYLC7e/zhAZoKxfZpthePf81n0xFI0PreJ4q8gXcL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732334150; c=relaxed/simple;
	bh=X5hu1MVm7T9lclXS5IawjFTKT7MQBuEM+MdzJtoFJeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG1OPaj7YMCNF09oW6e50bzXHWG8baIRkQmM+Sk8ZUzgECbgJyLXSbKbFvoEGPxZ5ZWkO+EVSfbGIkGsD2vLs5Z4Ht19g2UWlXEQa+s7KmybUxmvbMLEmCE4JgzOkdhVn+zLqVxwvitziiJLonLPoVJT557H05YslYfoPiItHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnYfm+P5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732334148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5hu1MVm7T9lclXS5IawjFTKT7MQBuEM+MdzJtoFJeE=;
	b=KnYfm+P5C4/OVKFl6pAvf99+bw0VAO0/QMdvOlkflLTQ66YUgbMgNlsyP7lJUeLCciABV5
	7VK04NBJfC7Ugtq7kcheVeq0uB2FApHOJrJ4sTaUgLMPXXeft6kvJ7cXFjYP9EAjMIe2sD
	HcnOPhHnOg3bpBUI1C99EXEP03Ke0Ec=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-g4reo-yaOJiIZsdh9gVteg-1; Fri, 22 Nov 2024 22:55:41 -0500
X-MC-Unique: g4reo-yaOJiIZsdh9gVteg-1
X-Mimecast-MFC-AGG-ID: g4reo-yaOJiIZsdh9gVteg
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53daaf10af1so2299169e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732334140; x=1732938940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5hu1MVm7T9lclXS5IawjFTKT7MQBuEM+MdzJtoFJeE=;
        b=BNQTarQEgJAkNwzTg06NyPUh7JndvmDrdfeFdcP9Ntgo+XU8DxG+W3tnS3aWmQKsWW
         D31iENNN/ZZwjqd3JLVGeZL4rGNjfSEgQEQc67DyIzmrLuHv0ccXVtHZPy59Qbm1HOv2
         Dd7Yj+w4fmST+cx0Piokp7dkyx6zFBhKeNIk0z3Wf10ZtJdfjx0Kh6H6msWu1JDz/1+v
         19JuzNhrloP6ciEKJrEWTZw1nAMFain76Oh80Nc3qDWOtwPXzNBkUnXWE7E5Jj91ayE1
         9BFlRQxIe+xN6LrwubZ6y7tHd5HIZ4pGzoMdgdZgu/6mbffRL83rI3vKEbq7X135jHf9
         Yu0w==
X-Forwarded-Encrypted: i=1; AJvYcCX2dObPdh2Yq8GBUviA5xTsCa/mJGZIjlELXcOrnlrfz56Kku7fqC1xiiuZ3rE7vUWBEfM5YxrxhQQzCHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eCsNrM09brUDLfd5+Kdt/2D+yNwqvbIJshvt8BGgT5XVChig
	fyYZo+XAN4MGWjmFaJZedHQVs7jw78PQ1YuYRuigUErkCnL0U+Xfnh2sN1B872tbLGM/HB+SdXz
	XUfhnk2p93sptAXVNRrzmtwQMKbQbq+LFV81Ef06hzLt+8zs31uIomIHgUZ4bx+3QJtTvv1N4fX
	43mjHj5yZLSjqkJvbl88OpGThjP1qYHuysNhB+
X-Gm-Gg: ASbGncvx3uEWpV+WmXfXvhx/N3EsKLwSKyNL9GuR/KRa9OKDuDSQNzgqxmPh2WQtQxO
	3ahLxl2wmLlzumqFxxv088UxltiTmOfqa
X-Received: by 2002:a05:6512:b93:b0:539:fd10:f07b with SMTP id 2adb3069b0e04-53dd3aafefemr3243573e87.55.1732334140032;
        Fri, 22 Nov 2024 19:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGenoTOZDbDMjzO/mQJh3mBNjX4OIQpj51uXIgG+SecnhLJy4tqKW2g1ksKPMca0C9DJw4hVhPMJl+Tb7V7zzk=
X-Received: by 2002:a05:6512:b93:b0:539:fd10:f07b with SMTP id
 2adb3069b0e04-53dd3aafefemr3243565e87.55.1732334139666; Fri, 22 Nov 2024
 19:55:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118114157.355749-1-yukuai1@huaweicloud.com>
 <20241118114157.355749-6-yukuai1@huaweicloud.com> <CALTww28JrdXoNXQNPxx2Sg9L2iL20jZZ80Y-qZzqcyF780M1fg@mail.gmail.com>
 <e6843d53-c7f4-2e38-0a15-91b49afec8f1@huaweicloud.com> <CALTww28ZRFo6BwqzriVpoOuqbfygKrU0HuOhhUxLe9cBBDY-ZQ@mail.gmail.com>
 <e3319ea0-f9aa-6048-c620-4e72f2b10b31@huaweicloud.com>
In-Reply-To: <e3319ea0-f9aa-6048-c620-4e72f2b10b31@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sat, 23 Nov 2024 11:55:26 +0800
Message-ID: <CALTww28kr5TzWoeMrS-W_etfhwQGQHDQ-DeakTEALUGDE9FNVA@mail.gmail.com>
Subject: Re: [PATCH md-6.13 5/5] md/md-bitmap: move bitmap_{start, end}write
 to md upper layer
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:32=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/11/22 11:14, Xiao Ni =E5=86=99=E9=81=93:
> >> Ok, one place that I found is that raid5 can do extra end write while
> >> stripe->dev[].towrite is NULL, the null checking is missing. I'll
> >> mention that in the next version.
> > Does this can cause the deadlock?
>
> Not deadlock, the bit counter will underflow and reach COUNTER_MAX, and
> bitmap_startwrite() can wait forever for the counter.

Hi Kuai

For normal io, endwrite is called in function
handle_stripe_clean_event when sh->dev[i].written has value.
For failed io, endwrite is called when bitmap_end has value.
bitmap_end is set when sh->dev[i].to_write is not NULL.
Which place does extra endwrite?

Regards
Xiao
>
> Thanks,
> Kuai
>


