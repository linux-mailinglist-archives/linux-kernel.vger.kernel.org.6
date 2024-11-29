Return-Path: <linux-kernel+bounces-425173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A69DBE7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B52B20CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1913B7BE;
	Fri, 29 Nov 2024 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF5Z4spk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7C1386DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732845359; cv=none; b=oRZESa0mocdKp29J8UyJpQecKOgRVf2Zpok0919bwIWQf8qfZT9HpqcFTJJ1aY2jV8YGgZeh+1GPSDuim/cpJ4778KIRK0Jvj3iRHcQqNQ6DGmdCZTvLWAUELZ+GhWVazLl7t18D7Xii6xp52TWpmIoC4BRXxbxTgMzENAVc/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732845359; c=relaxed/simple;
	bh=MqX0qTp9JfCjCifnZ7wTnaeXTQO7L5dTGgOAae/o5kI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2dPrzMzHGrUSql8MxQoUJ1J7FKvTUHdCosnYbspxpuiMr8vGZa5bCJ4iTjKkzY1fG+5QsZdmCLDT733nzFEa58ix1jpRUQ02spAhJ/quv0LCt+ETYpq/5bd8By7Fwg4+r4x1mvuryTymL6X/GL8B5mXGE16DIYQxCX1oAUJh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JF5Z4spk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732845356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BM51VYFqtZtrDnTV5fzydYek6oljiWhcieYf9SGUCmk=;
	b=JF5Z4spkbnTvw2Ro7t+0+ppwKB8AnYI2Wync6Hm6qcDhIZxEExn8mzCXRpnj4NFVhk30uW
	HZ/iP76uUu9suQau2pLNbK8SJhI5o+fn9Ymmdv1e6mc+mpSORgDwGrZ2YiA2UHfC/59OTC
	Y/JzPShSpNgHrGLtr8r3xeur82i4fGE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-4L8upS3IM-qm0Hfp53cWDQ-1; Thu, 28 Nov 2024 20:55:55 -0500
X-MC-Unique: 4L8upS3IM-qm0Hfp53cWDQ-1
X-Mimecast-MFC-AGG-ID: 4L8upS3IM-qm0Hfp53cWDQ
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466cc5287ffso9374931cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732845354; x=1733450154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BM51VYFqtZtrDnTV5fzydYek6oljiWhcieYf9SGUCmk=;
        b=IZVdFHPVkYtS+4dDJMKI1NAeJWfcznQFksn7PmaK86XHvz6QAuDAnv96/a9x4gwWBe
         hLsfRkK2aaY4E/sL3mO2FjdRUb0gqRWu6TSLVlMqWJBt0iNnhEd82lBQ85njHmxc0wSj
         BItlderZ4VYP0Y6GHF1pgB9qBHZx5FAZnjMGnwn1BgYMEcuPRsfU1uMqYMbWeyDl+MRv
         fyyWGLUDAHGCe0BHKZwaUN1h6ONJknq2gH6yt8XEQrLDHZv06Nfmxf0/KRNpj0K9pa/B
         5K3whsb8/5zLJW8DUHKndgSzIzBGd+MbtCWKW/B1XQAUrrYDFi7dXQ3hxwDl89JuPJJt
         O6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXJTiS2dFDbKSX54NL/uc8wNi6xFBcieRzYNXbzggFKbNqJiKWHnS1KoboFVqDBOUf46z18CqO0KrsXOY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDDGXdUXS3RFeAgMmmDU8Wy5mh8UfaAiQ+j9WKCQHLmHF15dP
	jpvWLlkjoTZJWJ9O1pBEov56/6QduLpUoLdRzF07YPeq7KCfUmVKNrIfu12oC9XrPSTUdyEIRrc
	oeeZJPpYm9U3+PkB7s3hzLe5jzQGQ7RQIaO+1FnpogI3p+8+5mgfp5FNi4XKWcQ==
X-Gm-Gg: ASbGnctcSlYAKocI1qkgBfbrzo0gCtG1LwaESkrYONehtBSTXdBy5PqPx6DosprFXCO
	QRyIbzfgX7th+odizFmjFAlb2BIpGC6DkywBi1ojtXBVtIW8wX3fjYwmRI+Ufrgs1jaI7sulxlE
	FXQXuiszwh5dkF0Um0YSLg9aPoZ5uLm9vllCTu66mqgsZF9fHaJLLUHcvfT5cS8iN5WLA+PI7At
	DKcpFp+w5lfxDzJhQtDHg5N3xj18sFXHjq47bGVtnpefPCcQg==
X-Received: by 2002:ac8:5f0b:0:b0:466:a51b:6277 with SMTP id d75a77b69052e-466b34df859mr112107631cf.16.1732845353273;
        Thu, 28 Nov 2024 17:55:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF3jF9PKejzXBxWERsFmoOMOgNMqVamnPapG5mbsdU9fDdWau2LKGhipr8Fz11CNm4/siGDg==
X-Received: by 2002:ac8:5f0b:0:b0:466:a51b:6277 with SMTP id d75a77b69052e-466b34df859mr112107361cf.16.1732845352939;
        Thu, 28 Nov 2024 17:55:52 -0800 (PST)
Received: from [172.20.1.227] ([70.25.108.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4054cf4sm11929791cf.5.2024.11.28.17.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 17:55:52 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <89cdf387-f75f-472f-9f4b-e3582d1d2c93@redhat.com>
Date: Thu, 28 Nov 2024 20:55:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/nmi: Use trylock in __register_nmi_handler() when
 in_nmi()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
References: <20241127233455.76904-1-longman@redhat.com>
 <20241128092800.GB35539@noisy.programming.kicks-ass.net>
 <15662315-0332-4c0e-95c9-928329a094a7@redhat.com>
Content-Language: en-US
In-Reply-To: <15662315-0332-4c0e-95c9-928329a094a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/28/24 8:06 PM, Waiman Long wrote:
>
> On 11/28/24 4:28 AM, Peter Zijlstra wrote:
>> On Wed, Nov 27, 2024 at 06:34:55PM -0500, Waiman Long wrote:
>>> The __register_nmi_handler() function can be called in NMI context from
>>> nmi_shootdown_cpus() leading to a lockdep splat like the following.
>> This seems fundamentally insane. Why are we okay with this?
>
> According to the functional comment of nmi_shootdown_cpus(),
>
>  * nmi_shootdown_cpus() can only be invoked once. After the first
>  * invocation all other CPUs are stuck in crash_nmi_callback() and
>  * cannot respond to a second NMI.
>
> That is why it has to insert the crash_nmi_callback() call with 
> register_nmi_handler() here in the NMI context. Changing this will 
> require a fundamental redesign of the way this shutdown process need 
> to be handled and I am not knowledgeable enough to do that. I will 
> certainly appreciate idea to handle it in a more graceful way.

One idea that I current have is to add a emergency callback pointer to 
the nmi_desc structure which, if set, has priority over the handlers in 
the linked list and will be called first. In this way, 
nmi_shootdown_cpus() can set the pointer to point to 
crash_nmi_callback() without the need to take a lock and insert another 
handler at the front of the list. Please let me know if this idea is 
acceptable or not.

Cheers,
Longman


