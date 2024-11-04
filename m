Return-Path: <linux-kernel+bounces-394489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE429BAFE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA0B284258
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92D61B4F2A;
	Mon,  4 Nov 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNqCnmFT"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A71B394E;
	Mon,  4 Nov 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712993; cv=none; b=pFFYiyt4wavsjZzQY/7RSgIJ8kVJoo1sOM9yrX6GOiYOwQL0WD/+lv2BbOrUSUYeiigihqbTh/dDPdOrF/4r4LFClVoVlNlPVGoKgZJW6kOVCSQJNWTJJe566e5f7hfNOu12MQ67QOVDeomd5wsD+ZJzdgAZvKq6f8UXIDTRGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712993; c=relaxed/simple;
	bh=gok7PLg2LR//FOKvq8cJUOZJBw0XYdN8K6mpHSj6oVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao7C8G1dU4f4CkDIb66JbyLbGb4gQHRUmbsg2RIRB5nf/95v2Fxqq4G6BmSLzSX0gwU2WAON0idqnrA2Zp6hNpCjNXt8jLWTXk9ag4P66XSS9dF2djRQelHHFDMZiOoxtOdauK/xItdMQW+HiJo1UCe9MNot2kiA1moQtePi61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNqCnmFT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so2872727e87.1;
        Mon, 04 Nov 2024 01:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730712989; x=1731317789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quThUg/PJMTKJFSoaK0MvK68qOexoSXBSHDzDK3aznw=;
        b=mNqCnmFTRtAXHV93AljOyZwmaMxwYkJCsujwp0yZbs4LwDwXXsmfZPhCb6adv8r5w+
         lriH7cD6+vy8WWuLgT6CZnUPTlO6meLQ864+n38rSmnJBi2vRF58nco+iP6tvW7XTQ+4
         kcauPI8FfnghqZsPUco+4speQ1oQiq+NC6IYISttbXtT8WDE2gZUDrwG9z7wAi1L5+Wr
         El1AvC0S2e+jtjqF1NkTqIU2CM21bX+6rpYz8pF7rH80D4cqps+7dtCvzWDe0jgOAyOO
         WrnFlZon+fmmHKSaGTNFL/jWujckO83gMJcfMJWnlPilXgiP/c2L3TSs62KxwvZW6gLL
         qcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712989; x=1731317789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quThUg/PJMTKJFSoaK0MvK68qOexoSXBSHDzDK3aznw=;
        b=AA1hmc9usfxGECeKxkb1ewGGjL/+GcecNtxMtSBUf9YJ8U7avygFeoB0Im6Wk3K0gS
         E2suNiML5UM4FjrLiGiI+1Im0Suvam2xXpDtWmgEPaATJDyVguGMiqWOdPCPnevFOAUC
         MlMIT9he2EEBXsQrlBXHhhuM+IjhYQk2BIQLzHtxLM79vNfw2+2Uci7Py4veHzpcKRqi
         hLa1SbWDL4iREJNPbtKVET9f9wTcAzAySXcuclogBUAR9MRoO9guqryuTcQIQw1lKmc7
         YDT39NFW24xNBbnrZ/cB3gBy2KqmVdwymi9wgiuwvPQccgephzDEup3zrhBTb4OGZJnM
         Pu/A==
X-Forwarded-Encrypted: i=1; AJvYcCWFzZ0wdgF1gHcEmoI3ps0YfPFfheya9OxW/IQkt+vaS71iDiQh4uhrpcfKng6us1xypB0XYhf7Q7O6f7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbuhcMHOoXAJAinfF/h3kfgbs70FSckqUIQk40vuSEJ8IYcB4
	/VY2N65kLLPnWHpy2cTj6lTXVoeE15Ii895944z8Q3xv4Ki74H7JuJwxyw==
X-Google-Smtp-Source: AGHT+IEkAB50j90ekmdDsh9tZsNoRnbnnFLy8Pyq82foywNTzoyFECiMK+UirFntAhUIaItLZmrt0g==
X-Received: by 2002:a2e:611a:0:b0:2fc:9759:4e3d with SMTP id 38308e7fff4ca-2fd059396demr72229321fa.19.1730712989384;
        Mon, 04 Nov 2024 01:36:29 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6496sm16119341fa.73.2024.11.04.01.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:36:27 -0800 (PST)
Message-ID: <f6889ce1-f1e0-438d-a9e6-4340a92cb6ef@gmail.com>
Date: Mon, 4 Nov 2024 11:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 a.hindborg@kernel.org, linux-kernel@vger.kernel.org, dakr@redhat.com,
 airlied@redhat.com, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
 Andreas Hindborg <a.hindborg@samsung.com>
References: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
 <20241104090711.3000818-3-abdiel.janulgue@gmail.com>
 <CAH5fLgisLyW-d9rsHJ8Vp8HpWh7PZxtkXooVQyMTxs445Ah4GQ@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgisLyW-d9rsHJ8Vp8HpWh7PZxtkXooVQyMTxs445Ah4GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/11/2024 11:31, Alice Ryhl wrote:
> On Mon, Nov 4, 2024 at 10:07 AM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>> +/// Abstraction of dma_alloc_coherent
>> +///
>> +/// # Invariants
>> +///
>> +/// For the lifetime of an instance of CoherentAllocation, the cpu address is a valid pointer
>> +/// to an allocated region of consistent memory and we hold a reference to the device.
>> +pub struct CoherentAllocation<T: Add> {
> 
> Requiring `T: Add` is very unusual. Why?
> 
> I don't even see any additions anywhere.
> 
> Alice

Background here:
https://lore.kernel.org/all/ee45ae5f-133d-4d38-bb4a-d3515790feb4@gmail.com/

Basically this aims to restrict the abstraction to non-ZST types. Are 
there better (clever) ways to do this?

Thanks!

/Abdiel


