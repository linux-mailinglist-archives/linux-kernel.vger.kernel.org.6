Return-Path: <linux-kernel+bounces-196691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55ED8D5FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5AF1C211D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BAB157478;
	Fri, 31 May 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsWkXc6v"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1A156C61
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152580; cv=none; b=NREfJwm6082v/X35Fa9ABPvXxNm/XMVgtxy8Lj7tCcFN3hPaS0tzkOsS22Ven1rXVNMVn4Yt66K9d6AQIA3v59tIG9WDIOAXk0l+6l7LUEgXt58lb2s8zuHqAKNy5DvjW1jmUb5PBv+ujqyHrd1zQbW6+7o/rpEe2a9p6pui+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152580; c=relaxed/simple;
	bh=rGZ05Wtl7/tFqqeKIfV5yhM9avsTsSpt/wX8DUBeUl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtB4a9FBWFdCygpQaYmhQzucf6IVCuDiuW380ytay2/bj6AMoPZW+50/NbCfht9D/QhVDViNsJWF7ObYGTB9Lfge7vnO4j4PZhEx7fkGprulu4u8ucLuAcriRrKC623CYgtuYgqPjI7jImKKXtIqO8BsZRdpHEgLqb9lfDQBsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HsWkXc6v; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so12490a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717152577; x=1717757377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rRp80lBW4FzoN8ncda3wP8nvCP0z9lrK+Jc/IWYduo=;
        b=HsWkXc6vy3EByAB77Ul9Zsx8LSEDqCaS97xpcWD1S0rgCDbugyzcodDnIX5Ll9QzSq
         L+iFuGtE1cvJCF+MJ79ypkPiMHFaoEg4ys/QwM9U8Ugqtpmy10O5ySti3ido5YjJRzrH
         PaDlTUsD9/fI2JkEaR8DWsj3dOU8qkKatA25NOS7JS3c9FeJ7GMdJIWpGVG6RBKOM4Nf
         4bAHjlC6464A49PpcdupEPOYlA8VbgumeFLmefyHQ4Smagk7tWzywW52/aYVvruvYIjO
         WvA1ZKBsjPOzX+22PcvvsE7xlt9DyYuEqAXpne4NV1ldrqJyGugVp8Lya1vmOy8hvUgI
         ohdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152577; x=1717757377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rRp80lBW4FzoN8ncda3wP8nvCP0z9lrK+Jc/IWYduo=;
        b=okrFBX3PqJPZn93Hi7Kkvh+wpT3SL/Lx5nmq17h+5BVoXLOdJhnQgq+AKTEOGUAJ22
         DFcLNS8yP4YaBc0e8Qc8vjMTssgQcTQWdZEaQgISfuRQpXyfiagTNmoUemhumolg41+g
         l/0ljAde9JQwvhdzkYACX7cRe598n1l7DYWvUHz/M6bRMn3AxC1/5mMTsLmuwI2rEMS6
         iPuQ+gRqOUc7pus3tjyIPhy+52e7xnJilbRqFyuJ8XsMAjqhC8DMZpCNNM0qirNV7nCC
         6a1l/mdt00X0W5O5Hd+Qc35ntTyF4H3yRaOuZPM8rt0fdbtk65vEGV1bigJ/NW2XLz5D
         QpHw==
X-Gm-Message-State: AOJu0YwA5Ijsdwqkk1Deuhtj+81VoV/gsBxjrFLWTU4wxapqxWdExqcR
	i8kiLJZscB9/Fbxpmlpsyobp6hxTV92oQSj+0Tqemor9dIV5V0E2qOfn/4ac5j4uRgxXaTkcV4X
	1vhJ+NOMDuemGwfXsdC7mN6wmKjIy91a9n47y
X-Google-Smtp-Source: AGHT+IGNvupsb1UVYookhWaIP+aHUuOsnl1pdEMh3RFuflcTYqmKBlgYK4b83wq+i4WL/kDsRqslbWqCLr6DiBSSCT0=
X-Received: by 2002:a05:6402:148b:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57a33c6bab5mr160899a12.6.1717152576620; Fri, 31 May 2024
 03:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-2-Jason@zx2c4.com>
In-Reply-To: <20240528122352.2485958-2-Jason@zx2c4.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 31 May 2024 12:48:58 +0200
Message-ID: <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:24=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> c) If there's not enough memory to service a page fault, it's not fatal.
[...]
> @@ -5689,6 +5689,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *=
vma, unsigned long address,
>
>         lru_gen_exit_fault();
>
> +       /* If the mapping is droppable, then errors due to OOM aren't fat=
al. */
> +       if (vma->vm_flags & VM_DROPPABLE)
> +               ret &=3D ~VM_FAULT_OOM;

Can you remind me how this is supposed to work? If we get an OOM
error, and the error is not fatal, does that mean we'll just keep
hitting the same fault handler over and over again (until we happen to
have memory available again I guess)?

Or is there something in this series that somehow redirects userspace
execution to getrandom() in that case?


> +
>         if (flags & FAULT_FLAG_USER) {
>                 mem_cgroup_exit_user_fault();
>                 /*

