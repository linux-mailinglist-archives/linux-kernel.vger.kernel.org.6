Return-Path: <linux-kernel+bounces-282339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552694E271
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6BF2813F3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415EB1537C1;
	Sun, 11 Aug 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PRqDzAlr"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DA27447
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397476; cv=none; b=HiJYL49fNITEBBQ4rQWZc8POsO3RSjjVsLbqu0O9MFxVQebshPcC+XTxTwEGurODrHzbe5dLGB4n2JpG6UYNQzUGEyJkiZisf/xGq1jBH5U9zWsnsJADxL71Z4h5wxjDFVyNkWtePjO8ddzFcMUJXam4VhNf70tlGsnMebdgvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397476; c=relaxed/simple;
	bh=FC0BeQrrg3JgnM+t47nGsCutXFQt2N9z7kh7xJFOGdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMdmvXSwjtb20j5I923EFHLVkS4IN7YI1hyXbQh0635hNgBKOphp8jl3qMwRhFKlJ9XJ6e2iLATpWeDEaGhSI6HcsFVWcuexxhA1rLviOdgF6fAglBFyfWObZuQGNRVwpkWAe8qmjpsMaQbwMFaxzUDi9pbCNScXixu/YnrqonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PRqDzAlr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so4158286a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723397472; x=1724002272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=64Vxt1oz6yjVIL4QnAS3rC5j/oelDefv+ytj+ubdXHU=;
        b=PRqDzAlrqB0Q8YS0T8TYBkNdtONNcSZ6rcemKZ2x6E4Zxxl9RvQ1qWTMqeY8vI8e+O
         7JvGxTnEkvYtc7ockYXSTriu4+A19MTtt0b62QG4BOQxCsUzq/vBa1TcB8G10O0O6huw
         sUkV0RKCqSU03MIGGgJ9VPGEYksuXn1Wz0254=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723397472; x=1724002272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64Vxt1oz6yjVIL4QnAS3rC5j/oelDefv+ytj+ubdXHU=;
        b=VYXJzM3s9xxPBOBomBxerP7iBypYNw4cvQkJi/UJB8ouCeejqA+PvLHIJqLNfctODX
         lB7qVyu86zQAER9EbbAsYr9MJYOu0Ld2YnvPG5PDxmxzDYXefe/Yd6apgldpkjosrq2p
         +AqAFXi00CFBD2ZXPPmnPW88MN/JYoevrps1VLWmbSBl0iukvL3/Fwl6hvs+oYxnA6kg
         PHD8k1kBI0yUDGnbPOum03sYmS4CdaRjckCRFytRkRiyLBmUsaCs/3Sul6W1cqdfctOV
         mDgSdnebrBev/3tO4VlMFjSvx09C5gF6Bp30SkiX8OxrEmL1xS0qDY0i58TBkGxbdlWe
         hhVw==
X-Gm-Message-State: AOJu0YyqHyg6fS9JpxbkY/errv/1H8b2vPEofNBc+jBdSOJ97/xKGI2j
	+SO1os4svhzYnu6s5z6zNV35hdPnR+yHtqI2dZTIKEnZrN4FPYwpv8A4fkjIiU2lhrMHlIGczrU
	8eJU7UQ==
X-Google-Smtp-Source: AGHT+IGyENXRg6JWsbz+ZvZ+Fn4yPjdtK7UFvxxPMOpFW1Vu2DcHQnRCB433qWsuAyB07Thx9z6tDQ==
X-Received: by 2002:a17:907:3f93:b0:a80:5b8c:c586 with SMTP id a640c23a62f3a-a80aa161fbbmr576376366b.0.1723397472118;
        Sun, 11 Aug 2024 10:31:12 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2423fasm160904566b.218.2024.08.11.10.31.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 10:31:09 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so4312147a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:31:09 -0700 (PDT)
X-Received: by 2002:a17:907:3e02:b0:a7d:a28d:8cd1 with SMTP id
 a640c23a62f3a-a80aa5a592dmr458233466b.26.1723397468985; Sun, 11 Aug 2024
 10:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
In-Reply-To: <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Aug 2024 10:30:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw=FsFkF9EhF1ZzM9QUG0Az1_hk++9GU3ZffwafDLNgg@mail.gmail.com>
Message-ID: <CAHk-=wjw=FsFkF9EhF1ZzM9QUG0Az1_hk++9GU3ZffwafDLNgg@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Aug 2024 at 06:58, Thomas Gleixner <tglx@linutronix.de> wrote:
>
>   - Don't make acpi_mp_wake_mailbox not read only after init [..]

I assume there's one negation too many there, and it should just be
"Don't make acpi_mp_wake_mailbox read-only".

Also, while parsing the merge message and looking at the patch to make
sure I got it right, it struck me that it would have been really nice
to have found this "non-init function writes to __ro_after_init
variable" automatically.

Sadly, our section analysis is purely based on "this section has a
reference to that other section", and thus cannot see what kind of
access it is. And I'm not seeing how to try to figure that kind of
thing out without lots of work (ie objtool kind of stuff), so I guess
we're stuck with figuring these things out manually.

Oh well.

            Linus

