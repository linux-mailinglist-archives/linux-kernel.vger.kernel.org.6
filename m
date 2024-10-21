Return-Path: <linux-kernel+bounces-373828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05F9A5D59
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41587282067
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B81E1028;
	Mon, 21 Oct 2024 07:43:01 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECF1E0E14
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496581; cv=none; b=pK0eIMrq7xEkP/KCD0mvftjVXUyN7g7uYCqH8I6ArNTvxQlvENFWYs/BE/BI8htKGHXP8S/WcmfB1eXcLVN7a9OV9Ic6jYUZ+21/INvAYA+6QP5b/0TVfbW9cUVgZlKLUSA196AReXwVXhi1E68BFqSNZQQrImbhve16X2w3698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496581; c=relaxed/simple;
	bh=4F38RaSeyiuBzrNIiyM4nOzEmD4QbYnDqNUbbDz9djw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6a7Ecv9zL/+KgLwVWlN/VHoq37oBMnkkNpTlkcG/SqXo7G8MS2Z62iQ4PSwBK5uiloACQMaiRPFMwDkw8mIuG6UoyVynxpgWwwXCee0xT4cO8oHzrzDWc/IQa/mf9yUH388IXX2de7ezWmoDMdncB+x3P43PLpSBapwiP5qBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso3637475276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729496577; x=1730101377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUcD2BmDMlp1A2BQXeSlhDpra3RAM0pJabqaL97dvBo=;
        b=J3zQ6eZq3Y8pKqBYk1PybnqDkFLmetCImeBPhpWPIgQuRI3zrHTb2INXa2naly/JwC
         rf4fEEDM9g+GMbW55As3TlFEuMc9RGSzWick0wTIR1jdeLyNhpLQ2rMmD1HiPlWAl3FK
         RFf1qa4g0ZHMDkUetH1e1Mtl6UWeRh8IQbNiqUyXX9KxBbr4WPBqYhXktOv4T/qBn+yU
         97H2qqBI3FchdKgmiM9l7YQ02VZzlZR4UBsVtAmxRm8pVkzc4YUHiV0AFiwjmQl2bGfK
         FWDQQHqTXJ2h+WBFbDjj74NcwgBuEK6MNLyeLnTPDT1rPq3uNvaKa+iHC/nT0PiyRsbQ
         04Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXP+kLQWSDhqqyItylBBKvLVltEMUSrCcBRwwzrwkZxA49vA88ZDhzRRKZEod940Xj3OabuymO8PfU/cL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzadxmWmwDh6GkcXCGYw2alLzHjwRnNnHj90ZPNXdXiRaDOSlth
	xM3/X/gmH5pr71oFC78mGpyhRJZljB8LotaqkhT9u0b1EeGMc6tGw3PFvxxn
X-Google-Smtp-Source: AGHT+IHE7RaDBw2GTV+Pte9en8Lfg/SCB+46iZHk2hURQnREDL6imM48rQkyssO/vGU9/5Lh48w+GA==
X-Received: by 2002:a05:6902:1009:b0:e29:33d1:a3ac with SMTP id 3f1490d57ef6-e2bb11e5b40mr8976363276.11.1729496577310;
        Mon, 21 Oct 2024 00:42:57 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaec280sm606614276.43.2024.10.21.00.42.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 00:42:57 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so29337057b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:42:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPNfeUKWa35e8oAyk4dSBfVZgUfdsmDn9WSRq0yRaDYAoTf3RDORBB7at2GfAGyrePGuvFEfmnG3hF+nA=@vger.kernel.org
X-Received: by 2002:a05:690c:4249:b0:6e3:2cfb:9a86 with SMTP id
 00721157ae682-6e5bf9ff1a9mr73123877b3.26.1729496576759; Mon, 21 Oct 2024
 00:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxUH2J0BL3FCV6Hr@kroah.com>
In-Reply-To: <ZxUH2J0BL3FCV6Hr@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Oct 2024 09:42:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTEfnSyEYDeNtRHeB5KgMaQANr2JSeAou7Fc9pAkQK_w@mail.gmail.com>
Message-ID: <CAMuHMdUTEfnSyEYDeNtRHeB5KgMaQANr2JSeAou7Fc9pAkQK_w@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.12-rc4
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sun, Oct 20, 2024 at 3:38=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> All of these, except for the Kconfig and MAINTAINERS file updates have
> been in linux-next all week.  Those other two are just documentation
> changes and will have no runtime issues and were merged on Friday.

>       MAINTAINERS: Remove some entries due to various compliance requirem=
ents.

That was quick...
(And you forgot to run get_maintainer.pl when submitting that patch ;-)

So you traded various compliance requirements for other various
compliance requirements?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

