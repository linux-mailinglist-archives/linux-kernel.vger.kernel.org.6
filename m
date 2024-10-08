Return-Path: <linux-kernel+bounces-355084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B69946FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE5A1F27029
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8A51DDC33;
	Tue,  8 Oct 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiEr00sa"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317E1DE2CD;
	Tue,  8 Oct 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387004; cv=none; b=MI0aa94Ve83FEvMgBXcxQ1VlZZmEZa7tNJVpzEGvm6NbyVpalJF4+vPC6Z5daPopOFT/qz74OH2B9N83Uy+2mbVlfKt/9W/D9uRlhfLfhvsKBt9poGp8BA6c+zT6Hjflr5G0MbFhbo8rhQ4kUsLZRvQN5r9/r3ExAIN0ELCNq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387004; c=relaxed/simple;
	bh=jt0d8aVcbN9/mImxu04IwSDUOWvlL8GJHwYsZMuiolw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaBVB/srWr7mHo9C4LwZg9mWX8hS6rSy//IQ1OSPQ5w+o+drm/ofa69z+LmBlrKtXyZyChX2umcxmN0Hi9hZEdLjIXJ9+cWLPEfTUBKeY9lPqqbhXnbZvpb3SKzp7XiR/Ow/VcH0za/ssO3+U9bt7bCUFygjTKg/QXnHVmOd5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiEr00sa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398d171fa2so6275516e87.0;
        Tue, 08 Oct 2024 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728387000; x=1728991800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OH9XSGEykQKtmARKsC1Ta765UUmi7ZwxnjR/aPv3H3g=;
        b=OiEr00sazGcEs94Bi9U8JP10+NdERWfQnJfmse64IAzbxtjAkX//3wBNHMiPHunXtA
         Lt8biPngTxCsd4kLXBD1l8GPVJVPnajzq4TzLQmw1Bm52HzV+pD/durErAJZLfGtffyv
         wyl8LY8vOYDUMOJOpLFX0NTOlU1XqnXIuOgzwoPcyDtJO2uewX1Us/KD7I+ZvaF41T13
         WOU+A3qtbIe7d9m18Avrv6FvGHYSwtSI37iORuevaZOYlw9V9Nc6v0tNl59MMSHX+62B
         BmFFIc+qsVHnbzqoSW/AG2w3sW/YbET8lsd7QXOfTZdQqcQ5bKRJl00cN8v3Yo8EOOh1
         5xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728387000; x=1728991800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH9XSGEykQKtmARKsC1Ta765UUmi7ZwxnjR/aPv3H3g=;
        b=jCIs1GtreYT7EU0NiLhiW7YyUpLOD9Bt7JLC7W448/RR8BW/0XoWY4cABGG6nzOSHI
         aRJtzpc+CAnE3h/zjfTDfIZTQeKGm+gWiig0euElDUPthYvom3EEQx1EJKaq7W1fwxx1
         pZfvUTlauG1soAfj0SbqLAZs577oUPByjSW4ZycbPXl7KTRUlFtHoVl2W/1WgYpJ1FZu
         0UX9R8rxi78V4PHYVHk6xOY1resNkCp/40ZQ+eSTZ3SYUxrJX/o+3VXM/kZM7ffpLW8P
         JRp0hCgV9nTOqjNSxewC4Gd/6x6qQWW/PvNPrVrcNKrT1dEb2nYy6NYDIFt8NKy3YCCu
         LobA==
X-Forwarded-Encrypted: i=1; AJvYcCUh4u0V/e/ZaRGsAo9oGE1QGBZ38tOzypehg6g3tkmG8Y13M6SH9g/V/o+0cvi34prMR0enxq60MPVdKJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4vcwHbt9J5Fajg8pbZZly5Qn1kur9sfgY1aWxUo/HtLMOdMM
	hNRm8Tdbf4abw+rgsmDYZL8t6PmGvlRalCSKPQdJ7o9SukeanqSX
X-Google-Smtp-Source: AGHT+IFz/5JBXFBqbct0mQ4TJ++s7sHKo3RjOA2QQjMRAz3S8mYxI57LjTrbdMKlWRyxIY9ZVpPZLw==
X-Received: by 2002:a05:6512:3090:b0:52c:e1cd:39b7 with SMTP id 2adb3069b0e04-539ab85be3fmr8464607e87.5.1728386999699;
        Tue, 08 Oct 2024 04:29:59 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec1034sm1190750e87.13.2024.10.08.04.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 04:29:59 -0700 (PDT)
Message-ID: <dc6faf9b-b44f-4c7b-82df-35e2eb0374ec@gmail.com>
Date: Tue, 8 Oct 2024 14:29:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rust: page: Add support for vmalloc_to_page
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
 linux-kernel@vger.kernel.org, lyude@redhat.com, airlied@redhat.com,
 boqun.feng@gmail.com
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
 <CANiq72=XBTi7eGE31m4qTWivGbD-du0qgRGhb6ZUOH28p=K_0Q@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CANiq72=XBTi7eGE31m4qTWivGbD-du0qgRGhb6ZUOH28p=K_0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/10/2024 23:58, Miguel Ojeda wrote:
> On Mon, Oct 7, 2024 at 10:28 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> base-commit: 673d1648244c3840043e09a784164b38c2e2efb9
> 
> Quick note: this is a `rust-next` commit, but this looks like it is
> meant to be on top of Danilo's `Allocator` series -- e.g. we don't
> have e.g. `VVec` there yet so it cannot build (but we will have that
> soon).
> 
> By the way, cover letters normally go with [PATCH 0/...]. Since you
> have the base commit, I guess you used `--cover-letter` but changed
> the title maybe?
> 

Sorry about that, my bad, I edited the cover by mistake. Will fix this 
in next update.

Abdiel

> Thanks!
> 
> Cheers,
> Miguel

