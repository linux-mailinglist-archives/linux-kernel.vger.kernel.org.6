Return-Path: <linux-kernel+bounces-512363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC46A33811
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A461016707C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23831207DFB;
	Thu, 13 Feb 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP2UwSet"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B22207A03;
	Thu, 13 Feb 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428926; cv=none; b=NQKrgYlYoMsyfw/szL878jMRuwy4rtxaiBZAjqmZ+/PVyLo8LcivcK9WIUOtPGlyifU1w+8gzbtxjA/x8npcA66chIcBlesWI6ErA0PUQ5bId3uffuZzoh5BuLGiWKTtAPL9nH75My1tMC/3K0QTmdfTjpqhG1ie3PY4dsCkqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428926; c=relaxed/simple;
	bh=xN07ANbvxwpe18nAfOdhYb84OF63vJkSZm8SlmmgDJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUbvRnuz6Vv3JgZT+NZdqi72pOv0G8I3jfLRoOalDgwpXeCF13XJbj+ZqK/FsZEkt4Pnt84NLq2qyJY5KcoZ/jAUJc40P2MBIq+0qpU6qrth44ph+fqA2xMsViN0HiEI9gkXU0g+IEtUfojaPrt0+c8uH6aKDZ/F0/dgv83vCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP2UwSet; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543cc81ddebso499495e87.1;
        Wed, 12 Feb 2025 22:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739428923; x=1740033723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4eySdz77/NciwV/XfatLFkuT5QLK3ZdBGLRjELf2wU=;
        b=NP2UwSetEOg3qodpfmppSnUr2nmfTkEKVVk8U+VdIxzciATYWumuTREPW2UOGHRK/P
         Sc7Avyl3fjJzxm14E97wXK7pzKP94Y9InHxSFutW4PuBEWA1q2x5GklFaWQiIsud4zvo
         xQ/EfcKunYSq5kd30g92XNW5QMA99LTENGtSRfYt+RFNsIflWlwY0ei0iZV2x5s7aHU/
         pgyrkD5m3iz2NhsYc6Cxg2Y7XtGWek/Ik0qxFM9LtdvZDBwzqR0DzwTL0MYQTTYI75VV
         Sds9ufAVf1zTQKduma/VOhbm/0hjmBIDjQOa9L0Jdm3MFa40FrgNO1oyZOKv62Ogsf5W
         shvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739428923; x=1740033723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4eySdz77/NciwV/XfatLFkuT5QLK3ZdBGLRjELf2wU=;
        b=FTJm5nVoEU3I6q1FI37bweBmmNhzpFEtStN8zRTVFARcbAA7Cmry7qM+SH4Bc185er
         YvtjHrhX7R6dAORibjn/kkTH3Et2ZTc2VWyppdLsPjunsYYDw52mOw1Km5lAJqFbf4yq
         3e1VJ8uCU/6dGSj99hJb3duW1pcqXLHmXE+o2rOvWd2g/sUAbjOF/2Nq0SjYPRzutnHn
         P6IWP8t8f9JgG96v+tdhbbh325PqZaztjOGNzMVKlimelHX5cQpg7A2r76OtCTRfixcZ
         ApwJMp9fhGYriVN/JfbVH/kfucl1MRro1z9hMstq3e+i/K9XfMLP6J7XGl7oEl0HnCg8
         G7lw==
X-Forwarded-Encrypted: i=1; AJvYcCVLUxvvppb7CT+qNeM5/ehVOqA2joIf3AkN0bmBg+iddEWjpODg3u+RXq65zf2SclFbL8teXC8St50NvZX6pag=@vger.kernel.org, AJvYcCVtMPYLHzRD6tOslaIFW9ODdGeX1B6JPQUsGwJDYeYzyiO0ckSAkKDqH2nUszwrWHIMQOLWuftJgthKPmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+S65IJlap5/AEqld9PAH/oiQiKLIYONreUeUxf6BeJ9XyHAR
	ScCYbG+HDguqTIS9MtX6i3YOZa0IH6C5iJeXH+kdi3TClzasljDT
X-Gm-Gg: ASbGncvSwHrpEPclVSlcJyMJalmuEH3Cj6S48y7kSo4iR3cAse5ioyrLnjBaIxoqefx
	JtuDD9vI0atfyMV6pOf2UMAr5821onNfmd31ANMQbmMX2zdeOhaVJpZpkUIhD8hoM/vED6vwQlE
	NxDINeMhnKwnxl+nncGRV41Dtro4tRKyymnHofWrwhUApY4dymWqS+xtE/mmvYndXjk8Blegm9Y
	Abp4r+SuyFbH6yPRQVIcTkNE7OZiwSO9zESr80U6ZqWpYpFz9wgxWvEw32zdKMFfasiiE7Y5bWC
	mDtYvFrfQKEBHzmzpCTvE00Rhcjbh+XqGM3R+yNuE8Rzkc2oBySFwXynQLXMow==
X-Google-Smtp-Source: AGHT+IHafetPTUW53JV2MbUCuHv7yV8njco3PYIZ4cqAW9TRqirM7GIDFI9zVzpiiAPjubhOhjUIBA==
X-Received: by 2002:ac2:5695:0:b0:544:ca1:da41 with SMTP id 2adb3069b0e04-5451dde80b4mr620288e87.44.1739428922511;
        Wed, 12 Feb 2025 22:42:02 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10c73bsm81423e87.172.2025.02.12.22.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 22:42:01 -0800 (PST)
Message-ID: <b0efde29-248f-43f2-97bf-ab16b55af63a@gmail.com>
Date: Thu, 13 Feb 2025 08:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Icenowy Zheng <uwu@icenowy.me>, Danilo Krummrich <dakr@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Steven Rostedt <rostedt@goodmis.org>,
 "Dr. Greg" <greg@enjellic.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 daniel.almeida@collabora.com, aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 DRI Development <dri-devel@lists.freedesktop.org>
References: <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com> <Z6bdCrgGEq8Txd-s@home.goodmis.org>
 <1e8452ab-613a-4c85-adc0-0c4a293dbf50@marcan.st>
 <07c447b77bdac1f8ade1f93456f853f89d4842ee.camel@icenowy.me>
 <Z6nTxks3u-ErSalQ@cassiopeiae>
 <d7d1fb8af8857e7ebfdea48213849ea9ba446477.camel@icenowy.me>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <d7d1fb8af8857e7ebfdea48213849ea9ba446477.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 13/02/2025 05:49, Icenowy Zheng wrote:
> 
> Sorry, but I did a fact check on this, and I found that the only
> "reviewer" of DMA MAPPING HELPERS is Robin Murphy, he has only one
> reply in this thread, and the reply only says "Indeed, FWIW it seems
> like the appropriate level of abstraction to me,
> judging by the other wrappers living in rust/kernel/ already", he
> didn't offer to be a reviewer, 

Robin did offer:

https://lore.kernel.org/rust-for-linux/4956d01e-2d06-4edd-813b-9da94b482069@arm.com/

