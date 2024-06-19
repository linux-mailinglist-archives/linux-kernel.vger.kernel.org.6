Return-Path: <linux-kernel+bounces-221663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64190F6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19733B22F85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2C6F2F5;
	Wed, 19 Jun 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KWMx2oIX"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE26139
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825465; cv=none; b=iV4bBqZazKDduSb8xroh+nM3hCUC6pD0zpR+bGfQOiQ3WLyJKvgN/Avu4RFqK3zfyDrCBJdpJFJhb5MZDHDUhbUYsxEWa2li6v0gqkW1GLlKfYigHZG0YdkiHLs3qqfpb5URzpfgIt6dNMgqLhHZNus6VRhu5Ud19MW/cIa45Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825465; c=relaxed/simple;
	bh=ONbBVAYXgWykvvraEBnL8NkxMpKZpr3SVE0PVe+A6Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htutr65XQy28Cy4xNUeeouMBD62uWq1gub99ZH89zumOLoK8dVuzg0iUdNv9p6mc8eTDI6JmXLx1eh/hzT7wC5yYFEPSJ9AbM2106lw/1vOlNbCgM8gpbNupiGY0u9bH6N8/oi41+jD+gQBTQW3gl0CJHhG2MqFHTWo2TG+UA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KWMx2oIX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso1070259a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718825461; x=1719430261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+wN5dEx96D+70+iPxSD0VoqGzqbVt1ZsfN7BnJKyZXQ=;
        b=KWMx2oIXa/cumvmBz+h0GkqKi7WVae6RS8KASNTNcdHAQWYkccq59xCdMMmlt+C9/f
         VrlYy2+PhmwX62T4F2KWBvCp2Jy0tWDNhG8jXzJKMeb011w0NFzFHja9J1+RyvH0CsG3
         cng25kTZvqPtSPwJcNl0D17CBGJoaPP+m3iEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718825461; x=1719430261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wN5dEx96D+70+iPxSD0VoqGzqbVt1ZsfN7BnJKyZXQ=;
        b=F9WHHQp4DsNNBxLDBrQU3fJiak4L52LOQI1oi2WJCh4JEfK0JVxi1CjZJr5HUsyFn2
         aOcUyZAj0a2oE/kGXLrRn7viAGK3YTt0TNz/VYu/rfMf4I9MTTwAtiemZ3Sao41uFr6K
         cwtWc0jSYiVlwZ8cErX0eTbRJ2WJvQdWGOS7r6fYjNzZah/w6VwwVMp/2xXLP3q/v0oJ
         1eIiMmgN4bzdGAWNEUmoCLHPsRyGyLmFAhLiWtFjh+JajBbL/OT3dbxXWEr2UC72ZGTa
         HjWX9goNIdKYqqO44Lhnd0aXjKLY6yOzWAjofIwjTJkL/c73hTt8RAr8tPrWxx7qX4F5
         bIiw==
X-Forwarded-Encrypted: i=1; AJvYcCUfDWVHG27Dnv6gDmTaqpGFYA7QmO/q6mAaJHT7iYEG9DmBryNpIy0Aa0EkRJxVpRW6JWGsBiEHOToukr/PJMq6DCG+92v1vaiKvqKC
X-Gm-Message-State: AOJu0YzBmpa/WZDFC8vMJ9HslKGx22YEq/uJvUL2o0spFlx3bvHLE0hF
	Cd3zPBLwWUTCEGltuSE4NYLt2FmRsCoE/9ewnP7HpyrjR2Q1Mq/OJNTrNHnELMrnocUpQXR9NBy
	iTefe1A==
X-Google-Smtp-Source: AGHT+IF6dki17L0QkfqdTymcCuBcQSxlr+KD6ZSGy2pwu9iJ9TcZ8JEq83ENLIhQ3wGiSWFoFx8MfA==
X-Received: by 2002:a17:907:7212:b0:a6f:bd33:d1d5 with SMTP id a640c23a62f3a-a6fbd33d225mr51400966b.34.1718825460800;
        Wed, 19 Jun 2024 12:31:00 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41ad3sm683170866b.181.2024.06.19.12.30.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:30:59 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f9fe791f8so29640966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:30:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2zwCNNtjlo/pHIRoyzVmvz3yUv0xnHnOCmsoMGizshiyGgFP5n+2WTEAIXc8bshgiZ6fYQicCUWrECulJdsfCbXl/33OQTO8LfREq
X-Received: by 2002:a17:906:bf45:b0:a6f:77bb:1703 with SMTP id
 a640c23a62f3a-a6fa4109c43mr237633366b.13.1718825459486; Wed, 19 Jun 2024
 12:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <ZnKGjdw8xkMZG0oX@tiehlicka> <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
 <ZnKXNuuQRwNxRe4z@tiehlicka> <ZnKbR7IOd0b6GDBI@tiehlicka> <20240619174751.7r2s7iojxbaxpqlw@linux.dev>
In-Reply-To: <20240619174751.7r2s7iojxbaxpqlw@linux.dev>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 12:30:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXL32xG1HWGaVaOkHf+g407upYbvZeZgmhnsxn2R+JRQ@mail.gmail.com>
Message-ID: <CAHk-=whXL32xG1HWGaVaOkHf+g407upYbvZeZgmhnsxn2R+JRQ@mail.gmail.com>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kyle McMartin <kyle@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 10:47, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> Linus, please let me know if you have any concerns on the approach
> Michal is suggesting i.e. a variant for warn once for unique call stack.

I think we should just try to change the existing WARN_ONCE(), and see
if it causes any issues.

A new "WARN_UNIQUE()" might be the borign and safe approach, but

 (a) it won't actually be unique if you don't have stackdepot anyway,
and will just be WARN_ONCE

 (b) I suspect most WARN_ONCE users really do want WARN_UNIQUE

so let's at least _start_ with just changing semantics of the existing
"once", and then if it causes problems we'll have to revisit this.

I doubt it will cause problems,

                Linus

