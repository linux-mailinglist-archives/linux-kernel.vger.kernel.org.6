Return-Path: <linux-kernel+bounces-360972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745E99A1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37A6286E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4593210C11;
	Fri, 11 Oct 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEetEDZk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EB20FA99
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643589; cv=none; b=LKaVFUT4bKj5NU7dLTQdUZtU7cfjELG/BmnRb6kzxeky/daJQtHn0OwxuFNGhXvblzH2/sEIypcgR8B4f7MgQfQqh611i1748MwJfjItJ3vxST3T5CWDEy1+PbrYhMCGeNd6cGu0LXJkQF8YezNegSQ7/jPphojDsOOG0rLwcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643589; c=relaxed/simple;
	bh=z+hoVd7HmcKFQ/KTSjaNHnElfpGbfutvAi0O+nOwq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He7BO5VLmNU38MA6euigViOUVF0FB8l4ytBjqlYGzejCpqwRtrHyCwUFhXcXjZW/rcJMBGpXEQkVlEmjZj1iTiTvfLAbVnwjIwHpT7yY7WGcVX+OZG1WHUmGnnchRZ6yK+TN3ZXo64duITP6CuOwnvFw5oXJoWV/Gp5dLG58Koc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEetEDZk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728643586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+hoVd7HmcKFQ/KTSjaNHnElfpGbfutvAi0O+nOwq8Q=;
	b=SEetEDZknmECjNs84g2tda2hmGutCB1vK+gIJTK/8yMfHgSaxASeGihub392da+Q0ZNI8r
	TjM2BIWpDQFPUDQ99Yzl2zRyIZ651MxPTzbKEjPKg/b3z+v4KErPGAGKjVQwp5qpaA4S4C
	K8olNC+N/lDKL4g5pQgRMQpAm2f7gFM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-l155edFSOHmteR1o2o1EEw-1; Fri, 11 Oct 2024 06:46:25 -0400
X-MC-Unique: l155edFSOHmteR1o2o1EEw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9953ddfa4fso151280566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643584; x=1729248384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+hoVd7HmcKFQ/KTSjaNHnElfpGbfutvAi0O+nOwq8Q=;
        b=ekoF3YILACvODPOEKZhbc0lwpU6b1sXuW7zfAi9RYGUH7bHjDIxfeHrQYpkNuQpTfK
         TO1kzv1n9p892waXT9/N3SDKxcOxX96GrF5e4efLPfKUx5ydue4y32pHaalPT4oTrSTC
         TLLyQ0VAcCLQRPSgyWpQTmYvj0vMJRbgcOvaL54RVjQ1Twq9Bpgw9LlHk/yLPGinH4qW
         DFYM+dS1dCSAs7ZqgZfm+dc3s52mlqQqCNgJUPTsrSMbWLRUdQ0Ucht+iMqEotxOkoXZ
         nNnK75yoww7kQghs9DO1jPWeg5isNa9Wl8UGGgrX7TI2DieLcWSmQp0QS5AXosiQr+nY
         32tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjc0m8s4ZHHgE7gVT4w3kI4qzBWtpoKphxIX0/EsKSV8grY+dvNoMjO5f+zlVxSjysc6Dto197y0WZ3aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwjCpzeLj9Yo2zfUQl+bFMPNQR18OVQzfu6DTQH2oShvW7l89
	BN36/h+9NgK6Ju83l2R5K84a4dTWQnNFbP8JOIuJghViEG2lP+kLQsPO4mWMovjddwaMO1FZ+CP
	3Z6A7bfU+KKU/7yV3v87mmx/x1PaHUGKVbhwEuf0ncRCqbA2iPmrvK4S5AaiWRATf0LWeZWoRTH
	GQSJKXmegswEcg8fNXOxtRgoOlKSzjR4x7NQXy
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a99b930e9d1mr174008266b.13.1728643584081;
        Fri, 11 Oct 2024 03:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtGhhBlf70YMusmFyFxV2Hg8ctO2ko4xKYjA3/oDoChs6bbjyeJoZL0B/QuxqamTFe+DEMr33r9jaigl1hvCU=
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a99b930e9d1mr174006566b.13.1728643583712; Fri, 11 Oct 2024
 03:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004095014.2492813-1-tglozar@redhat.com> <20241004095014.2492813-4-tglozar@redhat.com>
 <20241010160637.4340b269@gandalf.local.home>
In-Reply-To: <20241010160637.4340b269@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 11 Oct 2024 12:46:12 +0200
Message-ID: <CAP4=nvSk1ZWM5NfU1oov+P1245BRuKuSp-6M=fFQ9Xpo1EVSSg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 3/6] rtla/utils: Add idle state disabling via libcpupower
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jwyatt@redhat.com, jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 10. 10. 2024 v 22:06 odes=C3=ADlatel Steven Rostedt <rostedt@goodmi=
s.org> napsal:
>
> If nr_states is zero, this returns 0 without ever allocating
> saved_cpu_idle_disable_state.
>
>> ...
>
> This returns -1 even if nr_states is zero. That is,
> save_cpu_idle_disable_state() can return success, but this restore will
> return failure.
>
> -- Steve

Oh I see: there might be no idle states to save,
saved_cpu_idle_disable_state doesn't get allocated at all, and then
restore_cpu_idle_disable_state behaves as the saves weren't saved
before. Checking for nr_state should fix that; I'll send a v3.

Tomas


