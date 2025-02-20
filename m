Return-Path: <linux-kernel+bounces-523169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3899FA3D2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A55A16A90C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898C1E991B;
	Thu, 20 Feb 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4luRZru"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0C1E47A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039700; cv=none; b=Wl1S9V53C9HjUJaXvCy9xJwwT7s9L822sLHLtUT3iMVUFeQwiBnfQUTbn2sbypCFJdvWL4g1+QPKLI5smHRUxNFLrdyDcUt/eAHdPpqAzvy3HrZ3PRvN/mD+95EFGN/Xz3DV629SKVAril5VOGArygQKfS/Zbhh4oNiBhDzaqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039700; c=relaxed/simple;
	bh=DhSWZ+LnqyXxtYIOPMoINYFhyYorGyErQ8agFapfXKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CH5RDrY2H1fzaKEOWOziMGuS0TKXjS1+u7zwwoCtwCQ1BJ6R3lNM7MllNYSTMo8Mch/Y/Ok+ZHHX07xci5TnT9vq4LkwM57Hoeu6SE8cqb2ceYPb3n23M4jMyC98TC9NUkNM0SIxOoJm4BZ3bODOBUgRvn9PFNEwi24JUU0/C4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4luRZru; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so1230775a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039697; x=1740644497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0My/IGnAu2uHnB18eW1eQLeiw1eTtEqdmu5EKWaXMI=;
        b=b4luRZrudbjLTte7t83IvrSSkY1M7BqSLLWBlC7LeCoheLbsRV9G4neaqdHMkqKB+A
         jYbn+CPxvwi3tgL72G9E7VPKtDJCQOFOmGm8cBipHAkyd2hlx10XXCsUTq2CXxoNvpZ6
         6FLprdTFu5w0UerKOHqqwVQrUp/NNLTPtL0diPZ0SP+ueTi3RiO81R7Wff9U+InUzA0C
         vfu4wyhyWF7VWEZE2F3zScUU4k7pz0zxWqrgTNfRNpkG46fGvKLRQRaC4+BFZjVuJiEP
         c38lMLb66f3DGYxmreefnpaVYHSgNaHEdsdy6o8tjYw9IxHk5xH+DemXdPhx8vs4/ue8
         Mycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039697; x=1740644497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0My/IGnAu2uHnB18eW1eQLeiw1eTtEqdmu5EKWaXMI=;
        b=m4JVsEK0zqCrb9lsrsBpqsSZjaFBKG/lV0gDZbgqV63EuZXHHX8R1Aphsi4albtdcR
         RnVb+jKcGbbSEjeqGGD/fuBVpu1ZEm2mbTqJ6bf/T5VuuMgQsp4Ak2nDjWSlNETx37Ad
         q1AaKHeT+qc55BpDfnPbvGSecYdlew4I8VBhzHLJG+7wzYGhU3kpUHqAPQ3OqmHN/wkk
         anfWqspUQmXfFnKeansecsS5syBRY211rJSDt7kka1TD/jRMpZ1EOQ2BB7epBlUN1juY
         M08EPh3EdG2W4pKYqtqAEZYSeb/UCQ4y917Y+dmCviTAhQeA2q/OClKqm4eAsbElOsrG
         KMJw==
X-Forwarded-Encrypted: i=1; AJvYcCXe6zt83qmX5tU8r7lRpXpnHKNSg87ZoP1eWT1AcyedfxDh63RL321I0Lq+ABbpwHE3XD4ml+0dnSMUcjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJVHxbUs7TOee/LklxAO7ZcLcXNjL9ZIjOPKZfVhPM76ngP9P
	FRG2pRgHDqFoWFAgWQRLRuZ2btOlqlv4IyNf/BEIjuF7/5Xa6ybTAfHTYhQn96y8vJZjx/m9OvA
	9cNSCo+0Zu9XA7+B9WbfyOVhEtMPEtci0OEs=
X-Gm-Gg: ASbGncvA2ERLjvZdl0D3PebrEZXmbSTLq9yo2Xq+3UZLwLfqnPXcHupDCJG8ggP6rM+
	vpAoK+HT43ER9qlVbgluIij2nMxGwbpFy6YRDxoURcPChFIhLksetHHH1EffTDIJFnIcaeLrl
X-Google-Smtp-Source: AGHT+IHdcQTzN/ZyBxiJ2XxJrOj9cR/iZnDvdLIe7MJjIt7l9Sayz8tDNRoUzfXldl11nL9Ekj7qIe2XSwES1YuHN64=
X-Received: by 2002:a17:906:6a0c:b0:ab7:db5d:44ea with SMTP id
 a640c23a62f3a-abb70b36c02mr2262813166b.27.1740039697170; Thu, 20 Feb 2025
 00:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11603b392e2899b44fce61bbc8626a1aaa32b8f0.1740037706.git.geert@linux-m68k.org>
In-Reply-To: <11603b392e2899b44fce61bbc8626a1aaa32b8f0.1740037706.git.geert@linux-m68k.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 20 Feb 2025 10:21:00 +0200
X-Gm-Features: AWEUYZl4rQIYbMyfzqYq5tF3XFCtTFLr0W2jUlYHGwI2blIFaJ9vjMhs_t7KGFw
Message-ID: <CAHp75VcMweeEa=oAsVOLefuUKx96YJVg4ifdqT-uySPLXWeAeg@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: MAX6959 should select BITREVERSE
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> If CONFIG_BITREVERSE is not enabled:
>
>     max6959.c:(.text+0x92): undefined reference to `byte_rev_table'

LGTM now, thanks.
Do you think we are in an emergency to send it for v6.14?
If possible, I would prefer to send this in PR for v6.15 as the
problem was from day 1 and only bitbot found the configuration so far
that fails to build.

--=20
With Best Regards,
Andy Shevchenko

