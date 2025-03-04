Return-Path: <linux-kernel+bounces-545399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC7A4EC87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56CD7A3E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0E1E505;
	Tue,  4 Mar 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d4gTLTTm"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E22E3368
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114656; cv=none; b=hPUodIMVWv60+V655i9CoGE8zZ6dBm/t5G7XKW+zV/H5mziVbYP46ChYDo6oWP67Agv9WGY1tpA0OJu0o0RZFjEJpJ0xrXtFrGnJPl9NJlQZ6L0q52dAbyEsy2E5N8fO4eT52N+9Ae+OYUbGdl8+e3L41dXrHhM9L9HDUEp9o3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114656; c=relaxed/simple;
	bh=6T9FhHb/JWtxunhRwlvuECiU9TmRmhKYSWtxW63z62w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeSpl+CMsbwhQBawq6bO0VkixcahIvOkCUaYz346AiAkfC4g7KHNsN3fdHsLmQ5Ao5lGKBN4StI477z9tCfoYK0oYuXLN492W4F1RpAdIpEEQZbdCfjgMexH26VM/J9FvsVcD+CUp9AkJozHyYH8X18ziXcth15/itSK1hLyZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d4gTLTTm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf538f7be0so565820666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741114652; x=1741719452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwUaiWfoPUpRoeAAS0kH7mr77gvmAjedPgmddxc8NaY=;
        b=d4gTLTTmnlbE2Ks+8QbeE9nKPcCbZe0jXCXY/vFYf/BvDR5O6gCjQvremTOE4ubTht
         FZ0FdKLmhvZ8MRKu+4XoEmo3oKIt8/LJeceycUoYe2RMsn2Mh8B4X3yFxE6bXJg8wPcD
         9SO1Z6AgNeyohS/bxnTwLYja8sQdJUqWMyTtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741114652; x=1741719452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwUaiWfoPUpRoeAAS0kH7mr77gvmAjedPgmddxc8NaY=;
        b=EftcUmMc1tn8M2aUQYUjdnwITWH4hclf3t/hW2f1W+F+kvc40Hwzc79UVhJyl1Mo3/
         hXBNJ+iQCY+0zQWZyr+/INAxruPrBilUdoyAOr5QAmxA0oluXd8n85DzQMJlyxaSc9FW
         C0GF/g8nXEdS6M4IVy8KPnMMUNiO7+QeSgnWwb4GA1vjTU2307kbnq926SQ4DoDTLSmV
         YT/03SKz12aOM4OuU1OK2P7x9NiKlhHVaaIv6rEzQiutRtifGRK4/z/biE+Z4aPih4EP
         9E26M/m0ssuatV2lwQbupqEjJI8v0oof1tIXmdufk8ApD1hW61SHz1SA7XUYgQieHUaX
         +t0g==
X-Forwarded-Encrypted: i=1; AJvYcCUrZXKxWC6ZKB/SbOFRHOJYACK1hL9O5rfoDNjkCuY7/Z/Wm6IzeAEI6AVIXg7vLEWaJY6IdgaMtZrsN1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoEB+miwBDn/UrEnMjMRZAmFayPKtbcBLxgg6j3BEA1CDFCiFV
	4ucYP7/7ZBp6vGH6qrWrUu0uVv/8q3DECdEBmuc3hj1TQmtXsnj3Kjk2R1xfd2KOydEDEF91PU9
	9reBf4w==
X-Gm-Gg: ASbGnctAr6EZ4/5bpPCpxvO4FjrBx5+QEe4soAbLimzZ2c3IkqreB1B1ZZ2A3dKkmVw
	EN26eBia3hk7smklEY/XY8tJVeqVVX2PjwGjz1ZtYkrH2L9D6R7oD0RfIwA4y4Ii3BE5yVavYKz
	xnH19BAJHt3CnPiBL0NsmF0MnTb3yIxl0a8s/ibZRDW7jkht7jXYbjX/V67rBBfmawmfPd2gEn7
	3S69mo1WIobWOe+6UL9Jazrg8sxqGGYWhv8iANibY00CNHZB8DXdvD37G5Pj8d4gr1YueOP+VWL
	vCF1LE5cd2JqE1sSXcW4S1KMh8xNNiNW0J55gNyH+e1I98+aIuXokWQYAsgvtKkZKt4HYk5Bp+d
	2ZIj1pAHEgyY1IaB4r8E=
X-Google-Smtp-Source: AGHT+IEIw+Dr6kT0ozUjSr7fy4FfY4XSauA9HeKs4+NdMhy77HwurKaspcq64SGVyZn4XJ+tmJlWyg==
X-Received: by 2002:a17:906:7950:b0:aa6:a87e:f2e1 with SMTP id a640c23a62f3a-ac20db0455bmr36645166b.56.1741114652365;
        Tue, 04 Mar 2025 10:57:32 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac052702e83sm336921466b.21.2025.03.04.10.57.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:57:31 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf518748cbso632800966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:57:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiUByvCAFSecr8NYXX/8lV5VrLHmN91ok3tcy6wffKP+9MB9/C/CpyBgRlR5LjX8EDo4/J/U9RzlcEM20=@vger.kernel.org
X-Received: by 2002:a17:907:da9:b0:abf:497d:a23d with SMTP id
 a640c23a62f3a-ac20db01cbbmr33101366b.53.1741114650914; Tue, 04 Mar 2025
 10:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe> <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
In-Reply-To: <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:57:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr_usyxBsXKRNlYO2C44tmlzyfAvMqXf0CKg8l-nZ0GMDd02O2gmQZ-lCU
Message-ID: <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 08:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Random ugly code, untested, special versions for different config options.
>
> __builtin_frame_address() is much more complex than just the old "use
> a register variable".

On the gcc bugzilla that hpa opened, I also note that Pinski said that
the __builtin_frame_address() is likely to just work by accident.

Exactly like the %rsp case.

I'd be much more inclined to look for whether marking the asm
'volatile' would be a more reliable model. Or adding a memory clobber
or similar.

Those kinds of solutions would also hopefully not need different
sequences for different config options. Because
__builtin_frame_address() really *is* fundamentally fragile, and the
fact that frame pointers change behavior is a pretty big symptom of
that fragility.

             Linus

