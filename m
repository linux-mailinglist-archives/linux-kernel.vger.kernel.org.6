Return-Path: <linux-kernel+bounces-264455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7B93E377
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 05:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CAB2814FB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 03:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8A28F5;
	Sun, 28 Jul 2024 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TrX6Jr8q"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A47A32
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722136005; cv=none; b=OIhbI9dsi6GnBtpV7qBMLhDqZHRaXkkP4vUoXBuLugk9W1T2lNq4iTtECuRjyq+YaxrQkf2RDSrjTi1aemLzo+Jh7+heaSRN/26tPFFgct4qUDi5TxHD9bxNdnOx0Ik/G82HzviVhSYj3uFA6vshZ383knsL62ZNX3PDY6TR+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722136005; c=relaxed/simple;
	bh=F4EhYaLokNUrGCOVJDpLTctYw0ySaD4y2jKbN79VXkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUuP+GoUDkKQog3WqiW1qwUl+QOkS4XG4hoyqHyFB7KE2cpxp9NHgVxVv5QPW2MAPgabK4CMHl6tYtOq5ZchpYHiYmV/InhwXOgRj3Z6qiszjCQndevgXQ/Y0uKHOtEzvlSw1uwN2v9zDnvR58TnMv1glXBU3u8fWCkHp8zvxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TrX6Jr8q; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so305796866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722136002; x=1722740802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ClALVvYZ7xtCv1Otg8PivaNpPZc3HM33yqHaJy0R9VM=;
        b=TrX6Jr8qWnVjA05C463wXFtyuOd/i6fLuPyMeyuivKRKFEpHXg2nXJPhOAw060tQtu
         V0QacEiaphSon7d8aXD1DIH5f1xruwScphGRmTmwSjEHww24iZNmZczGaU2UYtvZbAvt
         yz4TH+xi/8n9M54yZruVP1rr4GjR0wah8NSIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722136002; x=1722740802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClALVvYZ7xtCv1Otg8PivaNpPZc3HM33yqHaJy0R9VM=;
        b=b9Q0TY3R7L0cBq/36gtnIuNyiQjycSaFrxbag2/GRbw8K/lnfCh/ECNjBL3qi510kn
         iK343D/o4HKrRcYsvlMWSA5GHRuZKw7WjgOYTD7YhMgUokOSwQwTayQNPgS91vyEF4O7
         HCVvXQG42SEypl5n/1LY5SN1Z3ozmKAC7feeQBE3ADsAJD/qN3cMTYgksFqODiJ/1z03
         dy/vgXXNlSh9O1lrWksHHBtms2T1kMOk6iGBa2gc8cKQa1YcnQIif3bGzOZjIia/IOn3
         vs0YnYLSVtEb0UIa+BB1G0xhBbuRDrlaTV+3O3Apn2s4jaE8ULswEKKvfyX/lxqvyvPL
         HDlA==
X-Forwarded-Encrypted: i=1; AJvYcCXedENiMZgTr68x1AWXl3l9NAyX7zRDG3RG0WMPnwAj8VaRZBnibT/P8UlE8LSQcHPBZWG3lQPl8EzAU5205qy2mMiz+2xIUdofla3k
X-Gm-Message-State: AOJu0YxQy6u552bZOz1d/MPEpav53QjhKk6GbFQtpcz6DMZ8krj2AB+X
	hstxCH46LQrAHwkoAQzVsJ+etgylPyeC8EYL0anzKKaVVq1bCs9mqdjpAE/Uz8zg1T15DZOFm7c
	l9L/p/w==
X-Google-Smtp-Source: AGHT+IFbKh4sOvJRLpHGSb2CC8eNjzYmXB57Sh+OLWy0P09pB438vZ+EcG3UQo5TuKL7hyF5XOY9fg==
X-Received: by 2002:a17:907:874c:b0:a77:c583:4f78 with SMTP id a640c23a62f3a-a7d40081a0fmr217589966b.39.1722136001473;
        Sat, 27 Jul 2024 20:06:41 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad902e2sm342195666b.146.2024.07.27.20.06.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 20:06:40 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so1750018a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:06:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnu0FBUAOGMS9/cKbCw2ItD7JfZY2gT1TFR8QVTMT1H3DKsfesc9xfM5/2rE3oPJoN8yR4H64fWqyNPGF5OGqlUOVYjVvrPPHx/YQq
X-Received: by 2002:a50:a6db:0:b0:5a3:3062:36c7 with SMTP id
 4fb4d7f45d1cf-5b021190521mr2579570a12.7.1722136000501; Sat, 27 Jul 2024
 20:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at>
In-Reply-To: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jul 2024 20:06:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjK1ZLk8TjejsRfDUH2Jp4=FPfD_GQU9z-m=bm75+jBMw@mail.gmail.com>
Message-ID: <CAHk-=wjK1ZLk8TjejsRfDUH2Jp4=FPfD_GQU9z-m=bm75+jBMw@mail.gmail.com>
Subject: Re: [GIT PULL] UBI and UBIFS updates for v6.11-rc1
To: Richard Weinberger <richard@nod.at>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 13:58, Richard Weinberger <richard@nod.at> wrote:
>
> This pull request contains updates (actually, just fixes) for UBI and UBIFS:

Does nobody actually check the build output?

  WARNING: modpost: drivers/mtd/ubi/ubi: section mismatch in
reference: ubi_init+0x170 (section: .init.text) -> ubiblock_exit
(section: .exit.text)

and yes, this may be harmless on x86 (and several other
architectures), because the exit.text is dropped at runtime because
dropping it at link time will cause problems for altinstructions.

BUT.

The warning is very real, because on *other* architectures, the
EXIT_TEXT sections may never be linked in at all, because something
that is built-in never gets unloaded, so it never has a module exit.

So __exit literally exists so that the code can be thrown away when not used.

And now you're calling it from a non-exit place.

End result: the warning exists for a reason, and it looks like commit
72f3d3daddd7 ("mtd: ubi: Restore missing cleanup on ubi_init() failure
path") is just broken.

I could try to fix this up in the merge, but honestly, the fact that
apparently nobody bothered to even look at the new warning means that
I just consider this whole pull completely buggered.

I refuse to pull garbage that our build system very clearly warns about.

                Linus

