Return-Path: <linux-kernel+bounces-441602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C89ED096
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468A71881552
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03D1D63CA;
	Wed, 11 Dec 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GllGALV1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28FB246353
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932699; cv=none; b=M11Umc7Dx3wip7aeM8vgtX714p6nv//qrotOOywXnjYyLepBhjX65Xluv9Z/vks92fdtwhE1Xv/P9Pu1Gin//G4rBolihkuSY5UZF++eXd3r40JGMPL5w1TtUk88f9ZiEGVG/t3AOQstKuQcc5ymbkd+5RP+azWKEVmXZQzOvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932699; c=relaxed/simple;
	bh=u5FPtsbtyhtQvoKP0pRC+TrXbN97+rv9LHzoWEt9c+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jM/ikxxEpS4QfSoikRlwqQGByNHWLT94jSu4B+y6iv9RJnnptkG7WiF00fnNKbK6bovszFVV4WfnRLQVN/HEvGcLLGf5rUuxhthOo69fMFhYyU6PqoI1LvNsS1thFSl2BS/m+1FRfN1SAws68XbYK8vI6Xj+qeHScaESW0P7ABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GllGALV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733932696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5FPtsbtyhtQvoKP0pRC+TrXbN97+rv9LHzoWEt9c+c=;
	b=GllGALV1o2ZzoAhO958W3icNu3KQ/mlktwgeDI+RtDYcpgvSB20Jn5xJYbNrGkOtO4p1hC
	wrMcjy/WDt2sPiP4uXsD9jFtfDIG50n7T5+4Uylq71KaX2aYF3vQPqn2ofxBdb3zvT4NUc
	XK05eor4m/vOk8AM0IqMSGQtB7GVmEQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-dR5U3M6NNyuI4DZNS2CBFQ-1; Wed, 11 Dec 2024 10:58:15 -0500
X-MC-Unique: dR5U3M6NNyuI4DZNS2CBFQ-1
X-Mimecast-MFC-AGG-ID: dR5U3M6NNyuI4DZNS2CBFQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434fb9646efso28607275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932694; x=1734537494;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5FPtsbtyhtQvoKP0pRC+TrXbN97+rv9LHzoWEt9c+c=;
        b=OCcV1k9G0h/9UZ8su9yK9l1TryiT68hv6ApmVGRtiNH3WhtFCbj4XJt65BiLu42G6q
         rUoWYjUZF0pFMZDk9TavFWS2V+pn3O8v2ZXpt4p9d7gyzYqeZhlOvFUegieaAHQoYPmK
         AO++p7GLu1tliSNeHlZfedHfIw1MyPMbqS8DKjNobk3w73AX1YcwlNPbp3v64HGXFIxN
         5bjR3U+YHZ2KVGAMGyswmz4msxbwRqMe3wBVxyGKGUtX3mYTOp4iZes8D4FzU5RN5y0f
         85E/w6wtiVRjvfoPO53CAk3ssKzHL4yVYfW62a1xcVVkuODhA+z2oGW6KL2UYwOqlK2K
         jbMg==
X-Forwarded-Encrypted: i=1; AJvYcCVUjvWlz1B2NYFLYDOHsjIneU8nijv0e1cu5pS1C2FOn5lO60DcZllUf5O/6W3JzPLQZHQJ9f09ygXjjc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/N61/OsHeBefccD8cFw/0+lb+3dY2K0VTQbKt6GQI6hgGtQ+
	zfJpgD0DbseOytwMurrxst2cjzgSj+Fo6DvfEv4Bv6F/eUEbeafGt1mEmbfUNN3rjVMaQb46W9t
	OWGkSQXiE+DTZm18YfUsvPZK/+G9xaFVo718GvkCG/zGMbJZy7NNrqgH05+3FwwxPNMg6DFnPi5
	trSisrnKGnOHRICjMDTTY5L8ZJI33Xi9L3LpYAMb8cSDwq8A==
X-Gm-Gg: ASbGncu9v874yp5z8Dv8APUIA14oFnfLq8/P5+gOJZ29DbVnrrqkhWxnvB/EUcAz5Vp
	jwUuiECHLyeZlyh/NuoQpvFWDgUqPH71JNQlM58uxMsiVBYTHLu+LGRRRwDBAuENMVstO3/GtN0
	25OeL1CMybZGKCvsXaBODHCIBjt/nogwJLAWwZzOlAIiQuCkWSNzEDx1NwAy3dwI6rkbZNzoayJ
	eb4u1HE/5rPKcl+gvkB7pZMqD/qWp+Rdpfk7DPFLUScFD7w
X-Received: by 2002:a05:600c:1e26:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-4361c4340b1mr25695065e9.33.1733932694449;
        Wed, 11 Dec 2024 07:58:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFprutvbba6ZR7/j8nTrsYjZz6d5zu0hrQpa2vP/BMX99OK/a1xsU9l2Z6qdO1DLQkX02yY8Q==
X-Received: by 2002:a05:600c:1e26:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-4361c4340b1mr25694805e9.33.1733932694060;
        Wed, 11 Dec 2024 07:58:14 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526ac03sm270452565e9.4.2024.12.11.07.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:58:13 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Michael Petlan
 <mpetlan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry: Add __init to ia32_emulation_override_cmdline()
In-Reply-To: <df3b71b2-086e-4439-89bc-b55f192f6ab6@suse.com>
References: <20241210151650.1746022-1-vkuznets@redhat.com>
 <df3b71b2-086e-4439-89bc-b55f192f6ab6@suse.com>
Date: Wed, 11 Dec 2024 16:58:12 +0100
Message-ID: <87msh2rz3f.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nikolay Borisov <nik.borisov@suse.com> writes:

> On 10.12.24 =D0=B3. 17:16 =D1=87., Vitaly Kuznetsov wrote:
>> ia32_emulation_override_cmdline() is an early_param() arg and these
>> are only needed at boot time. In fact, all other early_param() functions
>> in arch/x86 seem to have '__init' annotation and
>> ia32_emulation_override_cmdline() is the only exception.
>>=20
>> Fixes: a11e097504ac ("x86: Make IA32_EMULATION boot time configurable")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
>

Thanks!

> nit: Does it really warrant a Fix tag, it's not a bug per-se, just frees=
=20
> up some memory?

I don't think we have any issues with early_param() functions without
__init currently, by 'Fixes:' I meant "this fixes commit ... which was
sub-optimal" and to help backporters. I'm absolutely fine with dropping
it if that's the consensus.

--=20
Vitaly


