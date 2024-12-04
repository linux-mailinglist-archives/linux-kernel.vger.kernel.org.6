Return-Path: <linux-kernel+bounces-430434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC6B9E30D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5487164AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA1EEC5;
	Wed,  4 Dec 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyajlRYL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7253BE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276396; cv=none; b=cN0LJpCjXgMuQn9QMfD94SXpVlHOXUCzqQZtT5gzHDkwL8nn8iRWc+7L4o92NwWEkH5dv2z7eJ+WQD+NfBs+Nz7AuYxiXm25/+6nMkaF/9YT9aEp0SO6IhqfLt/7KygHkawnwtuYxn18ND2Trscvvv2yP3RiI4jSZrCcR8uYbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276396; c=relaxed/simple;
	bh=5Ol0rnel7frJYPWxR6WOOs6MvPTLmEjvI5btrLgxu5Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pmwfIbkrlB3iKRe8WmJorqfsjqgbtgSgPlKagruzfliubrU/RmFnPCzhOxRRKBY/1wkp4yIiwovZbklTiFjNtExxygcnRzdPcQ4E81ztWh3AvkviH2nglFd4IZN7KCAbC7zIu3lFveU5DVotEpLfR5X5F7W9Yw7HGG2QQGNLXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyajlRYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733276391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ol0rnel7frJYPWxR6WOOs6MvPTLmEjvI5btrLgxu5Q=;
	b=IyajlRYLmvSD3xlCbyEnn4e8941l2CmZKUonJ/09IFnkOPFWJ0lW7QVUCKZ0M7EfYOTHLJ
	bBU9HwpY+QYm9uHFEmUe+vwiuHVQW8CBCGFtUnRZPMYLmeosP7rcgOX1JoPPEJGZs9s9dn
	Pps7+lYyc0EOcQQR1ZAgJ9s7Ub9Bh/4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-vSmc8fhTM-CmzRiPBBRO7A-1; Tue, 03 Dec 2024 20:39:50 -0500
X-MC-Unique: vSmc8fhTM-CmzRiPBBRO7A-1
X-Mimecast-MFC-AGG-ID: vSmc8fhTM-CmzRiPBBRO7A
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843dd952aa7so601918239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733276389; x=1733881189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ol0rnel7frJYPWxR6WOOs6MvPTLmEjvI5btrLgxu5Q=;
        b=TsHNYnAm+0fH9hsvbjdttiMM4N5F1MyG/0i7louhiQnheJqlyBTMI7br5LBKpKo4Hh
         bYtNxROgsjqrSocGVwwY4SXivzIwiPrPfMoLHTc2VeFsAKIZM7eqWJOpNuiuNhBJv1rF
         J+FFHsQIoe+D5cW0mO0biCR3fBKJnIm+N6y900oSTNHRVUMtXMB4Mvf4T/HWieKK6OS8
         ayLtcdIkafgnAXGIngOQAbpPMV+26xqQkhM2rq7NQHcaouJNPi2nFZYqrZyiSsl61xpW
         smk5bwDaABRteQ3afbuP95e/g+kS/sgfEszzBVKDwFyJf9go8U4KkzcK3T0Zp7JL1OHk
         y5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaRHn5VJtNJB02JCwtF9A6cGY0n9O45eV6Qzy7o+foRzVd4hN6Y/glkdBik6UtSWyuQQXLYh+9Osok01Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lxp4Xk5hTChJQQkfK+L9ZQ/sErCA8G48FHqVqB3lnV8eySl+
	6TzKNpz4f5nVF46+yoAcVezMcmEywoUFmQN3I7vdOcOc1dgbOc21I2RtI0UcKHgL8UzfBWHcW7b
	5T2s0eij6FhUBCbNxuIkNeYDVpg8zQAiD0WIAG/3fqf1w2dPYfcxDmYHRfosSYw==
X-Gm-Gg: ASbGncs7TD9x6/9G82YTDc1h30t10Uc4xjentMudITQnGLrNB+QdU59j/tJsp/nG/P+
	iqbasfSCrYnKA4jESVJzCO+sDCx6sUN8VH0Y2cBRFRXa1t5ripULiOBE+1nhOBQRiPedNHCxrEz
	sUJ6wTklgbUTNPr1HpupT13M16wK8QsQAZvUWru7M3v+RCqoDK8wFEyRtX/e/o/YrJH3NJId3G4
	KX/w+PnOuYNdSFD+VrRKMh1Y35otY4SCEhjIvYWUUagfjK/RlgdGZFk8uk9WIyNu5ggbmMAcJdd
	qh7/sE15jcakIfXQMw==
X-Received: by 2002:a05:6602:6c0a:b0:83a:9f64:6c75 with SMTP id ca18e2360f4ac-8445b53ee22mr672219339f.3.1733276389465;
        Tue, 03 Dec 2024 17:39:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErCvEkrixCbhbL7MtaDL5770KrUB2GnE5McK3ptHue31aNm1KT+phjOo8E4QiNVeG2NpNz/w==
X-Received: by 2002:a05:6602:6c0a:b0:83a:9f64:6c75 with SMTP id ca18e2360f4ac-8445b53ee22mr672218239f.3.1733276389188;
        Tue, 03 Dec 2024 17:39:49 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e908b4sm2771705173.158.2024.12.03.17.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:39:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0467ac99-dd3d-410a-8326-df4396d0cabb@redhat.com>
Date: Tue, 3 Dec 2024 20:39:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use it
 in nmi_shootdown_cpus()
To: Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20241203150732.182065-1-longman@redhat.com>
 <e63226d5a0e3e2c942202972c099617aee999c1a.camel@surriel.com>
Content-Language: en-US
In-Reply-To: <e63226d5a0e3e2c942202972c099617aee999c1a.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/3/24 8:00 PM, Rik van Riel wrote:
> On Tue, 2024-12-03 at 10:07 -0500, Waiman Long wrote:
>> Another way to fix this problem while allowing panic() calls from
>> NMI context is by adding a new emergency NMI handler to the nmi_desc
>> structure and provide a new set_emergency_nmi_handler() helper to
>> atomically set crash_nmi_callback() in any context. The new emergency
>> handler will be invoked first before other handlers in the linked
>> list. That will eliminate the need to take any lock and serve the
>> panic
>> in NMI use case.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> I've seen that panic come by a number of times, but
> never came up with a good fix.
>
> Your idea certainly looks like it should work, and
> avoid all the issues along the way.
>
> Acked-by: Rik van Riel <riel@surriel.com>

Thanks for the review.

Cheers,
Longman


