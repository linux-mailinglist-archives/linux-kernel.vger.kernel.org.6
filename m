Return-Path: <linux-kernel+bounces-426101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009459DEEF3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 05:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF49B21698
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53C13B59E;
	Sat, 30 Nov 2024 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UH/vsxZt"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE103FC2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732940998; cv=none; b=WOhTgrq9GdXHf0AStBdHzwnNCx2ZaReMOZ5rLeafVbOktK4bkxxqoxMFU46+tfiKxGjOeKQJ89Pa2H26+0HEjVVHdyf/8gH4ddDFao3OZyWUShv9wuJZoBqt88HKDakLsBpwTM2U2P5Qb1zQMoRdKXZh8/Ak1+VculHFx3yhCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732940998; c=relaxed/simple;
	bh=eJCHodo93LsRfSnjZlhq/9mthbu4qhH5YeukmDnl100=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/ShITDGE8jgvXF+u7UUNbHKfTDCTtXYHfFRL0lVSjPadevWKIENzRVMbTX0TWIhowOIrkT6ZL1O8LaEziihoIISPpYe9UoDiEeRlELj5QXpee2YvjAeI43ui3gRcxEc/LnELaZ1o1WL6nvEKMBC2IfkI2B/yr8RHnpwCHqKyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UH/vsxZt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so4457398a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732940994; x=1733545794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMKf0aAkTvoFZcRKLAWGSKUXjtHVT1NNnWsxVoZ3Ync=;
        b=UH/vsxZtN51wiiBmhEa9kk7TA96cdJ1t/kmTNyrmfJkmFVF9h/ep2hThaA1fUkSeo2
         3oDDWGo5CH/++taD57x5sJKgwnXN5Nod7gavWBOlD523HbxmZU0MoEZfDnde+tEDo0iH
         ZEy9AAM91mXV/dK1Sslc0gT12LTKXv3Oj7DyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732940994; x=1733545794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMKf0aAkTvoFZcRKLAWGSKUXjtHVT1NNnWsxVoZ3Ync=;
        b=gx1w3ZAZgmx5bn7bHNlmFAG1kRArr8qvVxF/KcR/7tX0LZB96ZBTZrluP3/Cu51oUn
         mLbHeuRqTaykw1ycN9ewzBd8WQtUYmJ1QxwFC0mrp4ahELJZ8wk+DXADsJAmC+gqBiay
         ofnQGDaSlc+vqbQQH4iX8xJubUaFUaxFy6F2aQsdYKF1q8xuZr2k/dGMKyGGCQCgBGJ9
         nd7ozbrqRQxy+WEMMWejG54eO6+SPfXoBoAoJFQWPF0KRiqniCntBrt8ow2TbXYiwmSy
         woeT9nh9RwPlqYigZANexNfrTWURDloiBNepLMmfOxvUZ0Vm0sDOvpE+EWMnFCsNivMQ
         EHHw==
X-Forwarded-Encrypted: i=1; AJvYcCV0TRlBgPDBuo2LEG/HCUVLwOEqJ+gZ8aOHvQQFG+FXsgR6MUk6/GeUehOtDPyTXqLZ4c4ulq8uT9IQYvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4a+SoqRFOTF/cvI3Y/bQVN1HSAYjkUSsuBgscLL3or9nZsEIq
	CfBID8Tmmk8Tia3xrZa7ZNGRX8mEUDs/zLCMgFMQKJi9Dkf+RRUqgrkqHpmd9e97XGEEpHohDo4
	YplzAWg==
X-Gm-Gg: ASbGncteYr/A/mzFE5Cbs2aUHS3/514GtRmYnaIc0Oai+knsEOv2nZHatIN3d/lnsgk
	qDl8fkzThZUdGrz1kQKBuToQA4tYpt7Xe6QrCirr/VwdNOU5lA0hCXAzowtEVwezvHZP6eX6e06
	iBJ7nLuDB+UNpH9eujI8/irdbjLVRmtFalVIm6NwOpmE1wox6AokbVnW4Fa+Y77/zm17kNGrHup
	d5++c5aWF/LIp6EIDYntjSVSgwEEGN+PmVxk+4JG8wk+guIVamjNuA0/y5f+z7zQ7OwpAwbL/lJ
	3XJyVnVO1iBjoD4JfZDlIz8z
X-Google-Smtp-Source: AGHT+IHvxbCZtLp6LkQMD8e9LahHNhGA6WxplQj6aWIRJvjz0dYmmXU/QsHlfjzakBru9aa5gLFoIg==
X-Received: by 2002:a05:6402:2696:b0:5d0:9aaa:3c4d with SMTP id 4fb4d7f45d1cf-5d09aaa3d1cmr10940174a12.14.1732940994155;
        Fri, 29 Nov 2024 20:29:54 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8dbd6sm2420473a12.57.2024.11.29.20.29.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 20:29:53 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa55171d73cso633738066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:29:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6ZrNuc41CHbqpyqy+OlHXdHAuOmfuBEbvDM53c9NrIzaDtnBtiMny7gZaIoHrpcGdWZxW6IrfRCOVtQk=@vger.kernel.org
X-Received: by 2002:a17:906:4789:b0:aa5:2056:f43 with SMTP id
 a640c23a62f3a-aa5945355cfmr1271655966b.10.1732940992140; Fri, 29 Nov 2024
 20:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzpFOhQN3yCb4+OpLsfYVrq4mLuUS+SP=H=gq=qSLDz7g@mail.gmail.com>
 <CAHk-=wh74-reWGqpP+i3O8usrS1Jr12UGGMCfaK58_0aK5Lw_Q@mail.gmail.com> <Z0pHQ-Uxgj2snWvm@sashalap>
In-Reply-To: <Z0pHQ-Uxgj2snWvm@sashalap>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 20:29:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wismrb=xrr_S5aCuJq6P1svhhbiaUMSJb9BXMpOppzMMQ@mail.gmail.com>
Message-ID: <CAHk-=wismrb=xrr_S5aCuJq6P1svhhbiaUMSJb9BXMpOppzMMQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.13-rc1
To: Sasha Levin <sashal@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 14:59, Sasha Levin <sashal@kernel.org> wrote:
>
> I should be able to reuse their config and just add debug info, no?

Sadly, no. Not unless you exactly match their compiler version. And it
looks like you don't, because the line numbers make no sense.

For example, this is the thing I would expect shows exactly *which* of
the roundup_pow_of_two()'s it is that causes it, but:

> [    4.510096] amdgpu_vm_adjust_size.cold (drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2083 (discriminator 1))

that amdgpu_vm.c:2083 line doesn't match anything, and isn't even
inside amdgpu_vm_adjust_size() - or something it would be inlining -
at all.

So I'm afraid it would have to be done at the KernelCI/LKFT side.

            Linus

