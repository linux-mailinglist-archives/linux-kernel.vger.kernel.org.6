Return-Path: <linux-kernel+bounces-241630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D7927D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F0284390
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF79130A7C;
	Thu,  4 Jul 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d3+4C7LD"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106240BF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119154; cv=none; b=aR60BlCdNtbTEk1UZrJOKnPAcnJxKiWSsLZ1dxTN/wJ5ty7GFwFK2FHOoNvrlBC5rYEDYsrt5sGzI3Uh8S1iY9TFR+osmRM0/t9hP7QYP0WsHifJdAEmXivx95PeZxezDDC9tH7iRn4xWd6+vJXGM362uPqu9Dxvkhjh06Fv2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119154; c=relaxed/simple;
	bh=+93Aq5gRk1QUFv6/zcEDBVacdtTPGRpPKUqs9kJAJBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2qkDF47QK/yC+QYeSxiqkG2cJ/qtKjlpVvu/j1isMDc3CJWc/XtiWueXHcW3vmgEA+oDTWJ09/8oplyPMr2h4tt1UbBI2rTCKEBgMKI3TYubRg6WQ2Cup4Phx97Se2ttRnaWOizbrJRTtrBsYcWzrMmAWkV2A6JYzDQr7yBOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d3+4C7LD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77b4387302so118271866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720119151; x=1720723951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ebaU5nRCNutbW0xREH8nKuSp9Alz78vjbtHSVH4o2bA=;
        b=d3+4C7LDkn94nA+MKC8uVImwrNaC47CZpMfrmERR4YACo/6EtA1K5tkVClKg6/MQdw
         sgC6jO5FbciMaiJuG1yJjR3+Zasmvd4egF34edvji+bN17pxv7CMFFL66ZNbem3Be/Bj
         eyRhrCdFfsggMcWrpiIohIXPZKTfTMNOGwLFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720119151; x=1720723951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebaU5nRCNutbW0xREH8nKuSp9Alz78vjbtHSVH4o2bA=;
        b=ItrjXZunVuw7Y/kHSDyLPBZz6nAwVGysBgWQJBqrNTpK8mHVAuym1Tej73orqg3KAT
         Pdvl+kg2A0V4giCipdin65izfOA2K8PPWD+KTwCO9kDzBnhNvTb8Tl897PteHZ22ao+r
         NO0/2lSKHMCYjZCQRdJiDoEWQ4rxsC1HDRaesdR5QQHcXh3TyPL9QLbF54JXsNwG3Uxl
         nwu30L8+6GBAjAkmYFuvnggT0bejA820rdk+jtx4UaF9YcbREwfhK4G2UGyTutwCYpSD
         isnObLfm0jj5SucKh25teBaAtpy6aV5P0MFzcUUTL7ag4VSuhLNz/zOzwvoZ3CdZG3OE
         psTA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfyxAEdGd6+UgV3uA0qB8dXF90bUYljqkHBkdjpxeC5nq6ZVVuYE+bkjb1hQ7ws4AjeKljfmjzGNxChZJkUd4ul+weZoiBv7NVtwM
X-Gm-Message-State: AOJu0YwnK40xf93m8K78MrAoI+G9fCs4gxV4zIMJPWLDESk3TiPJ9VMP
	bS/3jD4/dAxr9aTxPichCp6Wik1FbO4ZGScfjc0gTabBF31XJniqw/wsOgX8KwhMY1sjevL2Waj
	uEosxMg==
X-Google-Smtp-Source: AGHT+IFOSXBA1INFpiTIQa7gafG41EbdvNIhpjB9Z2eAQWxXRkvwW7fro1CnAngs0Y0Ibl+bHe3T7Q==
X-Received: by 2002:a17:906:34d3:b0:a6f:3155:bb89 with SMTP id a640c23a62f3a-a77ba72759cmr176873766b.70.1720119150854;
        Thu, 04 Jul 2024 11:52:30 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72b4125807sm575015866b.86.2024.07.04.11.52.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 11:52:30 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38028so1244129a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:52:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoQeiZYcpmZqdEAFjWwUXrYkCWLRm9IQ5UQ309Z/vCYbDeFwkt63KkxWwhp06g0Bc8WeAcO2DBJGsKEt/SplOnRqOIgi6RSVomVttW
X-Received: by 2002:a17:906:581:b0:a72:b287:1e04 with SMTP id
 a640c23a62f3a-a77ba48debcmr132743466b.34.1720119149587; Thu, 04 Jul 2024
 11:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com> <Zobt_M91PEnVobML@zx2c4.com>
In-Reply-To: <Zobt_M91PEnVobML@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 11:52:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
Message-ID: <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 11:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>
> I addressed this in the cover letter:
>
> | How do we rectify this? By putting a safe implementation of getrandom()
> | in the vDSO, which has access to whatever information a
> | particular iteration of random.c is using to make its decisions. I use
> | that careful language of "particular iteration of random.c", because the
> | set of things that a vDSO getrandom() implementation might need for making
> | decisions as good as the kernel's will likely change over time.

Jason. This smells. It's BS.

Christ, let's make a deal: do a five-liner patch that adds the
generation number to the vdso data, and basically document it as a
"the kernel thinks you need to reseed your buffers using getrandom"
flag.

And *if* it turns out in the future that there is then any major
reason why that doesn't work, I'll take the 1000+ line thing, ok?

Deal?

                    Linus

