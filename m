Return-Path: <linux-kernel+bounces-173173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BC68BFC8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328C91C23397
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D382871;
	Wed,  8 May 2024 11:44:55 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F582492
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168695; cv=none; b=Wm2V2FwIVd9K//oE/dKkpPnCWbl7ZKC6ICYxygr3y2eOcQHmiLn7xYRUGTNcMHM74ChUmnj+4ACu2BZ8thtwoX5rqzKQneb2s9+EQM6Zyeh40f/MZ33OGL/PI1YohDfQKtsxxbpDsFucX1lYI3M/fR+TncZozRzuO/sLNoFOxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168695; c=relaxed/simple;
	bh=Tji7GiPNotKO9wzv99gLTkUyJlpMOyW/ti0VSFsUCTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxo92jSPwXHkXlmb8KfItlnJqe3JNBiXZasZms6ar0ZsBNNDQ7wSsmE+A5aDph57+JxHKl+zo0rOSIcMhU0ozupNU0C4Dy1tVeApBRJbblNoN4YHGni1bChaTZgFYC3kNiSat9uV0XKmKIzFNTRrHDeUe1DcLCVmnAoQkt8MgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61be4b9869dso44300267b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168692; x=1715773492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tD6uk6nyfWQJri7TBNWjTfNOLRhSaC+EWWwCRebNrC0=;
        b=HleOvjYbq2FeriwjKgVKntdxnnuNsErTXMjqQWRcPybpOOgsxM8Qfv4H1mVNS5I3B2
         wntEc0/JUKTYQwOSxxTCxeYexxLfEpvW/xJ4r3zZvWgMcFyd/8kV5xVyQlIHuKyP58Q7
         kefqwCTspZC9uYMjJ6fG2DdI/VA9DwTPJsWjhKIeXDmebN+jYpskZeuiz6nkGmZ/WZQf
         BH7neWRQIRvjSOcyhUi8FRiPXEKRgd10zesSeGtL9FHGi3wHXwDBoEUrYDR4V4uDzGpj
         3lh3dh7NeqLtmj+4MfQPzsfiADUlXCtiwzHjEQNCljueSf+F+7F2HSKj8xpIGCPjWZH+
         qNFw==
X-Forwarded-Encrypted: i=1; AJvYcCWTBLpnd0+4ceSn97EWWDaE53juxKLP2pedysKOCal/uRvG2lC7sbbPHSrWd2Dz8Ao6QA9wUg5p0buBTBMkJWYCDFMp45y7JD92jzKJ
X-Gm-Message-State: AOJu0Yzn6ukQq/2GLdWS54wf8u0S4GXoUrsWqDv+vF4IzT6L+vgRJfxn
	A24lcYmZpwsxhSh2HKpDvMZA1eCK6Qupiay1uzoHaXKDlhN1102ulCaG4i1mxHg=
X-Google-Smtp-Source: AGHT+IGHYgU++D0fE28KKf4OZsgoVeACDE5sxmMzk6yAHQhP4q3814+oDhHgK3EEZMWd3SspD+lW/w==
X-Received: by 2002:a0d:d850:0:b0:620:34a3:d8b with SMTP id 00721157ae682-620862f4ec1mr24365947b3.44.1715168691003;
        Wed, 08 May 2024 04:44:51 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id g125-20020a815283000000b00617c48add4csm3243075ywb.73.2024.05.08.04.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 04:44:50 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de60d05adafso4308804276.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:44:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgoXBC4qsxM4kp3UVkmM/kLG27rK0ds/S+TJQ/9zPCj1E4kGWj8zNxJv4br3LfDYjixcnrRUqJGZsPp9mvsimfUFwPg1Owe2spMFd4
X-Received: by 2002:a25:d352:0:b0:de5:5ba3:c324 with SMTP id
 3f1490d57ef6-debb9d2dca6mr2272321276.38.1715168690511; Wed, 08 May 2024
 04:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403122851.38808-1-schnelle@linux.ibm.com> <20240403122851.38808-2-schnelle@linux.ibm.com>
In-Reply-To: <20240403122851.38808-2-schnelle@linux.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 May 2024 13:44:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUw86JMgrStxFozDvhCjwynsHgXnPinO4YWXQf_VvWHKA@mail.gmail.com>
Message-ID: <CAMuHMdUw86JMgrStxFozDvhCjwynsHgXnPinO4YWXQf_VvWHKA@mail.gmail.com>
Subject: Re: [PATCH 1/1] m68k: Let GENERIC_IOMAP depend on HAS_IOPORT
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:29=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm.=
com> wrote:
> In a future patch HAS_IOPORT=3Dn will disable inb()/outb() and friends at
> compile time. With that choosing dynamically between I/O port and MMIO
> access via GNERIC_IOMAP will not work. So only select GENERIC_IOMAP when
> HAS_IOPORT is selected.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.10.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

