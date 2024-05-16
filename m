Return-Path: <linux-kernel+bounces-181641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EF8C7F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4471F228D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E52D03D;
	Thu, 16 May 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/imWOJQ"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85C2C6A3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715903734; cv=none; b=gXVR3FtowUM9k1cwTDQ9iHxV+invD2xcdRMdkeIfqh/Y7jvMF3U5Ke7zi6wjyijDcxHHggPLcLL8xbPTHpPqlbq/eykcVgg6Yn0BgZIMHythoAhOy5dxeiylN8t2MWVXqKc2JoRbvGwgvMGyN8AI3g2j9g/vbBLEmIBvID4JThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715903734; c=relaxed/simple;
	bh=4pwCjRrdKlshy11Q9Qidn/PkDr98ccPmPz4v2MD8UlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yuz9Ng3hubv/6Pme9fH/z0DidEKkoWT41WcGt1VVkbZ6eBNckghPb8FYCM5XSuVVq85afOi28V21z0xswqAVhTOvlNw8THgRYb0IwU2a8Xh0m0kCzoyQdMc+0pSM5DPgW94eXqJ+6PQjDRxZVFJ1bh6w6ZZ+l7uB9m4K8OJwF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/imWOJQ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47f01a027easo2430264137.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715903731; x=1716508531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gLVcqBV3F66KdisazNL7hONRkMphSyVVTtUEh3IZ/0=;
        b=E/imWOJQUukqIhTYGUAHSeDRJpe2R/x3Oe9ByVALnfK124hIndaA/8Mjmdr2phBqKM
         u+NeUR/kYgXJZTF9KDzqa8/qGoIpf4dNDMHyidkK15c1c79VKQ9BgcSSlQxV2Ylk5OYp
         4ec+y4+bcN2lFZNRS7toy2FItQ7CiMxRTwZQJz/tkxw4T0w92KbXAqZWDRqe23pZOOwJ
         xCetOdesSvIbcayGyrlV6mXFWl37iPVGpEyelL8b5X0eIW+Z8L5S1lFhZiBygIHTPRQU
         eWLEnmom0n++EIvDSroYuCc3OrBHxEaHTp8Bz01kT9VHoRUpoWm2rOCma0ULrHayezss
         8oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715903731; x=1716508531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gLVcqBV3F66KdisazNL7hONRkMphSyVVTtUEh3IZ/0=;
        b=XTAgLSz2Eb37QSkBL8iciQ5Sie8Dc9z/nHGGPgdf6UZfL4iyMWjZx+9EcjsGjhPs1y
         LJprBWTt22gTKlFDCw13Ae7UWPKklmmfQS6R6VssOgKST8ymWi65ebc71D5EiqtjirUb
         jP9hITx2xnYR36hIydqhfVU7IZ2WpYiXiZ0dApC43jXf+KWp2qAJlp2mXXedPZdYa3AJ
         hpobBkj9BHew59gwzfMbzfis84+Tk7iJlyTDYeqEui3Do9WkTqTVSoVw6bxwvW5A5EdX
         EOHWlQpB68Jy0QdSB3zZVB7lEswsG3pAs9vaNgOYNNABKTL1vQoyL3TdT3GRoy61BvLv
         /giQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR/X1n6R2UMkwTcbYBUjTrQP5MScAvuXUTpavVxiHHvLq8uOoRzP5pMf9RzavizhtKmmxg2VefYt90Cl4Ymomx5IACE8Mz/ajAZ29H
X-Gm-Message-State: AOJu0YxbcDxY3DQvxypk0LW65VXjmskx07lrLORDP2EphezxZrdmcVtL
	TjEr0Kg/nPbUtpmThUNuRnb4xjMQLL5AQZwy0mKf8+Vmb7yJ8DlRsrqLokgkr+9JRF/PD9GuQkY
	utHzOli9FDw9byDL59+FaZfI4y5MdCti+wMxX
X-Google-Smtp-Source: AGHT+IG+/22HSGO1aEWyeCTPHI7nYt0GiaqCsKk1aiSbOHC0OUQTiWABWrFf6IIzcykO5qWDSD6ZOxcp/txXENrYfSk=
X-Received: by 2002:a05:6102:5089:b0:485:9a12:cae with SMTP id
 ada2fe7eead31-4859a1210d8mr3163573137.21.1715903730652; Thu, 16 May 2024
 16:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
 <87v83gllv8.ffs@tglx> <CAFhGd8p94sHpDc8MApZK7q9iEQ_C8c5frwZx9v_bTnhwtAM=HQ@mail.gmail.com>
In-Reply-To: <CAFhGd8p94sHpDc8MApZK7q9iEQ_C8c5frwZx9v_bTnhwtAM=HQ@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 16 May 2024 16:55:19 -0700
Message-ID: <CAFhGd8rTHPiKG+XOkkUihj9r8k1=n3zgitpM9X2aQf6zhp9psQ@mail.gmail.com>
Subject: Re: [PATCH] ntp: remove accidental integer wrap-around
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:40=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
> Isn't this usually supplied from the user and can be some pretty
> random stuff? Are you suggesting we update
> timekeeping_validate_timex() to include a check to limit the maxerror
> field to (NTP_PHASE_LIMIT-(MAXFREQ / NSEC_PER_USEC))? It seems like we
> should handle the overflow case where it happens: in
> second_overflow().

Or, I suppose we could add a check to timekeeping_validate_timex() like:

if (txc->modes & ADJ_MAXERROR) {
    if (txc->maxerror < 0 || txc->maxerror > NTP_PHASE_LIMIT)
        return -EINVAL;
}


> Thanks
> Justin

