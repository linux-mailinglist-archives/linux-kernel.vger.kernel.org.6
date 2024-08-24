Return-Path: <linux-kernel+bounces-299833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD595DA9F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75420B20CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19818622;
	Sat, 24 Aug 2024 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WvhcORLb"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B7F4ED
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466196; cv=none; b=i7oSCZ0KH3/6/easQ+KLIDqYw1RjfAZBoBThjS1/p/WNzQCtv4oStiUwRnsP95xVqiMCCOJGDVgVQgetj9AaKI9N2wWGFLfMlSGZY7k/A0hfX+u9/Ij93gO+MfPEbuGhg8vfEOnDcf5YR4su/DhEFKahHWsuUxUx/K3x6pmX66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466196; c=relaxed/simple;
	bh=i35o0zzTkuuLgSrNUQubaIIl4CJFgxIAVXBVtabL3fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B50efVBI4XFsJTvivUssUVAlA2IuTh8j+83ylRj4IT5ai15hVW1YUcmD2bDIpVeDLez9JVsLlDvV2D4yBLAJ4hJIm8YUw8p/WEebL+/sWQhEmwJhUz8LldjvCNRuopKfyKoiZt7mgCD/MyI3mWHrz7grwQ/xURFPdwnPN90tGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WvhcORLb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533488ffb03so3145231e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724466192; x=1725070992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9zI+L5MCe2KlUtOy00sjP2H1MksZ4qDKvLS3+IXg5s=;
        b=WvhcORLbg+9sVsP/TDYWGk9RhZwrDSe1frya19hNEgUyhed7MpNHo+cqF0AJ1cARn2
         jRNZXIqaEHuX0FfFk32AMC5JV/DZWx75KAInyqHCeCJcPtrgpbvXV8nm3SsiJ5lynfti
         EJF58l4IblTTcAaEgvW1HucsjfSGU29mZKoGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724466192; x=1725070992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9zI+L5MCe2KlUtOy00sjP2H1MksZ4qDKvLS3+IXg5s=;
        b=W8EN9jP7obmaz4e3+F6vLj6fGmRpoUcfhDpe3ezlz+F9mgYSD5jHna1dvX7/F/25/k
         flidT/RtHPU5N9N/KKxOoopMbgJxSIxhXyFiUjGMcdcfSAanV0KCDbwzMIjTW8CbqetC
         92ISrLGEjy8TpgvJgzzQ6nlc1PR3ePlV2boNMj+CWnhyECmghUqwKZt7MWs2wa2IM8nY
         Susl5iCDBndZaz6E2oa4QtK9oaQkkHsd7OgGNYwRr/sroLzbihbLAblHf+6Ue3pTisOd
         EnOa6NewqC/aPszhXU86BYSKNsefGpKKnj+AKlcY+jO4N3gfR+Wk9erU6Qq4Q2GJpzYS
         Irgw==
X-Forwarded-Encrypted: i=1; AJvYcCWYGu4OLlwf8RDrc+mU4PPVYBketRTcUqKXiMzhNoGtVhSIP/IFwcbLTYvWhz1T9B0ZbYMXdc6Es7m1pm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSTtyiKnQOTVkNZw+F5rZ1/8ZSXdyTaskh/4FbwrZ8kO0SnRD
	3VuGsOwZNaOOizeina1uZSI9VSJnhGX2ndEtGYwOEiANPACXui4OzHhZn1tZ8JVYkNsVgCFCjiF
	84jfAIA==
X-Google-Smtp-Source: AGHT+IENAJdaq6QAVZOoRn9TluiNSUBdf07BlYbQgv1DeSDHaZWIei744pm660ZHnMjOwbQhva2/0w==
X-Received: by 2002:a05:6512:280c:b0:530:ab68:25e6 with SMTP id 2adb3069b0e04-53438861474mr3157021e87.48.1724466192028;
        Fri, 23 Aug 2024 19:23:12 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea59541sm710166e87.157.2024.08.23.19.23.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:23:11 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso24141421fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:23:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTTMdVACvp92OlsyeNc1AAkMICZDR4PS++IVAjOCNoV/vy2gyyd36RbQX91MF9MhT0co0E6m+2Rb4XFQ4=@vger.kernel.org
X-Received: by 2002:a2e:4611:0:b0:2f3:f054:684b with SMTP id
 38308e7fff4ca-2f4f5778f77mr20400311fa.29.1724466190574; Fri, 23 Aug 2024
 19:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-uncompressed-distro-packages-v1-1-c8accc8bc9ea@quicinc.com>
 <20240823105853.GC31866@willie-the-truck> <ZskWfKIZkThKpj9m@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <ZskWfKIZkThKpj9m@hu-bjorande-lv.qualcomm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:22:54 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjpXFOMq03cVq9XA+33QGALRzWV4mCND6dYpwAnXRqnmA@mail.gmail.com>
Message-ID: <CAHk-=wjpXFOMq03cVq9XA+33QGALRzWV4mCND6dYpwAnXRqnmA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Allow packing uncompressed images into distro packages
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 07:08, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> But the change also made it possible to install "vmlinuz.efi", by
> setting both options to =y. Was this intentional?

Absolutely. My arm64 config in fact has EFI_ZBOOT enabled.

IOW, the intent of that CONFIG_COMPRESSED_INSTALL was simply to make
"make install" do the same thing that "make zinstall" used to do.

I in fact initially limited the whole COMPRESSED_INSTALL question to
be *only* for when EFI_ZBOOT is enabled (because that was my
situation), and privately asked Will if maybe non-EFI people want it.
So the patch originally had

+       depends on EFI && EFI_ZBOOT

and I asked Will

  Comments? Do the non-EFI_ZBOOT cases also perhaps want this (ie
  "Image.gz" as opposed to "vmlinuz.efi")?

  I intentionally tried to make it as limited as possible, but maybe the
  non-EFI people would want this too?

and he thought that it would be better to just make this compressed
install question be independent of anything else, and literally just
boil down to "do you want 'make install' to do the same thing as 'make
zinstall' does?"

I have *no* idea about what the actual package manager case wants, though.

              Linus

