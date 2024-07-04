Return-Path: <linux-kernel+bounces-240809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D00BB927313
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D565B243E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DDD1AB52F;
	Thu,  4 Jul 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDxutweV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD21AB51A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085412; cv=none; b=MX5keFVnAGKxHiqJwZSoS9KTiVr1XA2zwalCENzmQkkqWWENxD+rir7cB70oALFgNX3kr6CYRol9ZvgRD8w66OeHGmSAHiR+B/r4DXfgDvKCHGdmaMYTdikimDnEmuOquwulip4BpEtv/kkuFIFva3TjIwRRb+u3qU+y/sb6MZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085412; c=relaxed/simple;
	bh=phdmX/j/LbFHeyRQEwiYO6ssMoxuSZN3L21D3IE3sVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZnFb1Rdgnx1e6wOJgLtaBuJKnMlIIgrDpkDJ02xGu77hlgr8hEb+Gp+fEKsW0m4Vm2rCnlOL/1LwtHtuQ8aRkLWW0QWINb+omD/+E6Icb1ik+h6sMAQOMwddSJW5t3xRH2XlHytEoMvqaOnp/eex/m/eOvuyJHlmD49wLlKMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDxutweV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720085409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4uXprkwlvPamWZYVoqyTd1YcwUNvxNCyRkcYrhT/QQ=;
	b=gDxutweV4LNMyOP8OPsulLH7bkMXnygSv34nw7ymnAXQ/ET4X3MYlbKwajqkZe4Fd51fKk
	v3yYG5OI/2HHkr6B9suqo8QnOCSmWz/0AqqxPMtibusxgZTT8NMvuq3BL8er2OiCaP9GZW
	W1G9XyMM9DhJnAqI2CCOZqzp6kQwmlA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-MHjEEAsJP5u45cfMl_u7WQ-1; Thu, 04 Jul 2024 05:30:08 -0400
X-MC-Unique: MHjEEAsJP5u45cfMl_u7WQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee87546e5eso4774281fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720085405; x=1720690205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4uXprkwlvPamWZYVoqyTd1YcwUNvxNCyRkcYrhT/QQ=;
        b=LpIDGHrdNdpkx3oyCXVjkkb230CL0lKZ1TIGAKmq2A7F0ctiLCtNqoqtHDzDFbh3dP
         12J3JS6arEwei7w2MgFtr+sYezLb/0nggz0X9z66NAxvQIZsySA/CW/PzOXnDenBUOpg
         39ZGl3jNnvjCswSh1vdLyFVniT1ZGtnPApCG1m8FAeloSp+uJAtnytyRi4ipcAHvATbn
         SmO5ClXbZZ9lozz6HDGjRL4JRBFG8WAgSGaK2SRCNchTwlVSySrGa8VOlXc/i+PzlHbu
         Ls1WvOhuC59sIAXnKb66EUF5QcD0DyMoM9zSL/y+XvAKAMmbdY6FByhEU9ZaMDAhMn0O
         bw2w==
X-Forwarded-Encrypted: i=1; AJvYcCWF6dCx/D50hvLwZvMm5HtxVpsTL1/GPsPMDKlgMjn2rJZ8O2Q+N0A36LJi2pSF4/e7Ca20Li5M0Em+ouL9jroMnT/vq3V6cABMPqjx
X-Gm-Message-State: AOJu0YyXvct5COdbobDPUMAMQVnE8yUNPp93kA1dI06tHvcW/OhgNmXF
	4twoieZ5xYIfLmeticW/EgpyFxQeOKFoR5B7rtr6LG0fcUlneG4b0J9ZtpXvO4i9nMQ3wwHDeLf
	TjJ4Jc5JGXP5T3QeOqWqKbDEneGHOXcZtufpq5VgT9H+83Amr8p0AJBMeCcBRenFNW8fA5Km3
X-Received: by 2002:a05:651c:b95:b0:2ee:7caf:db5d with SMTP id 38308e7fff4ca-2ee8ee2a014mr5687591fa.51.1720085405211;
        Thu, 04 Jul 2024 02:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDFDIi+xuW7Jy4FRnZjDg1+mTBblmfBJkFovRI6uIWmzL2R/6mOOqlUN8xD5v+Gn3jiKKuLA==
X-Received: by 2002:a2e:9b89:0:b0:2ee:4da5:be67 with SMTP id 38308e7fff4ca-2ee8ec7b181mr6771311fa.0.1720085384344;
        Thu, 04 Jul 2024 02:29:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:680e:9bf4:b6a9:959b? ([2a01:e0a:d5:a000:680e:9bf4:b6a9:959b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d50b0sm16650195e9.7.2024.07.04.02.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:29:43 -0700 (PDT)
Message-ID: <df3b1122-1c05-4bd5-bbbd-2e7cff2934aa@redhat.com>
Date: Thu, 4 Jul 2024 11:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/panic: Add a qr_code panic screen
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>
References: <20240703154309.426867-1-jfalempe@redhat.com>
 <CAH5fLgiMJZYhSiBVc7r3HP0VTCNVG=FuD68v-ni4=54t5vVPwQ@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CAH5fLgiMJZYhSiBVc7r3HP0VTCNVG=FuD68v-ni4=54t5vVPwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/07/2024 11:18, Alice Ryhl wrote:
> On Wed, Jul 3, 2024 at 5:44 PM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> This series adds a new panic screen, with the kmsg data embedded in a QR-code.
>>
>> The main advantage of QR-code, is that you can copy/paste the debug data to a bug report.
>>
>> The QR-code encoder is written in rust, and is very specific to drm_panic.
>> The reason is that it is called in a panic handler, and thus can't allocate memory, or use locking.
>> The rust code uses a few rust core API, and provides only two C entry points.
>> There is no particular reason to do it in rust, I just wanted to learn rust, and see if it can work in the kernel.
>>
>> If you want to see what it looks like, I've put a few screenshots here:
>> https://github.com/kdj0c/panic_report/issues/1
>>
>> --
>>
>> Jocelyn
>>
>>
>> Jocelyn Falempe (4):
>>    drm/panic: Add integer scaling to blit()
>>    drm/rect: add drm_rect_overlap()
>>    drm/panic: simplify logo handling
>>    drm/panic: Add a qr_code panic screen
>>
>>   drivers/gpu/drm/Kconfig         |  29 +
>>   drivers/gpu/drm/Makefile        |   1 +
>>   drivers/gpu/drm/drm_drv.c       |   3 +
>>   drivers/gpu/drm/drm_panic.c     | 338 +++++++++--
>>   drivers/gpu/drm/drm_panic_qr.rs | 989 ++++++++++++++++++++++++++++++++
>>   include/drm/drm_panic.h         |   4 +
>>   include/drm/drm_rect.h          |  15 +
>>   7 files changed, 1340 insertions(+), 39 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_panic_qr.rs
>>
>>
>> base-commit: 3f5ea7ed705e8effe9cfabf912e769ccb6b7d389
> 
> I tried to apply this patch, but I can't find this commit, nor could I
> find any tag that it applies on.

Sorry, it's the drm-misc-next branch of 
git@gitlab.freedesktop.org:drm/misc/kernel.git

> 
> Alice
> 


