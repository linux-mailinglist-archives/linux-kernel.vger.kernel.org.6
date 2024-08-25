Return-Path: <linux-kernel+bounces-300548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CFD95E4F9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150571C21430
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 19:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8AC156225;
	Sun, 25 Aug 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6Px275z"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC128F1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724614873; cv=none; b=CyC2JqKAxmynraGzH5Uvlkix7uXf5iwD5vp33N/OiTPQYKZxHSrR4cqv2uI+FnnyxLfOMJ+dLrK4m2AKuZD4qLPlmX9BdJaRLgzsDU7C3JYRsy2JjAYTsCyiiiOfAL7kOPbVq61bOUCxWImO0VX0oH4BAtQV+yWa7xu0BGWPu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724614873; c=relaxed/simple;
	bh=j1L05yXBQ4GUue1HO1qQvgYs07UsdMOkGMA+gJWHjKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQlKCfdy/zb0Xoj450Fjy5p68HiasC8hpY5aiRaGlRenR6Hp4yfgUZS8XB3kr2R7uzb6WfQeBEwkZvTEHaj5L1iB8mjk7kqF7CJSp4aZsKWEt8l9+0mn5u8n/4zl1oG8tYomkt7arIlAv18VCAM1Q0vydiK3RmV6Iw2x1Ydpjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6Px275z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86abbd68ffso343711466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724614870; x=1725219670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1L05yXBQ4GUue1HO1qQvgYs07UsdMOkGMA+gJWHjKg=;
        b=B6Px275zFF8BYmK7QXcD4t+vfDo767vpTvrhLb5EvjtDuY+Cc4c28HrOHrJjxqgJuD
         IYuVuaZQqVDeWrhlH+waT/MyaZsy2zbPO/4wQ2pPy4X89BZEPI3mTGaBN4VzrIVdQLDb
         fAoebMiTJRygs2Pf4R+4JKiJGAjTh/PhCB8xK6WuH0jFlreECg8wi3F0od0xP3kLvzs4
         p20Akf/djkr2A/KnCxjsya2YO6/61t4gPTbfQ3BJEYCI0HF5PWisjQuJeTwzd8Ho5qQR
         HjNzvSRk2l74OERyb0lPSGvuXNp3f3/NSnnTWBl56dESThUANgp2GFzRbRqSAbMqwfW5
         e0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724614870; x=1725219670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1L05yXBQ4GUue1HO1qQvgYs07UsdMOkGMA+gJWHjKg=;
        b=wT4YtllJBWnbs3ZfmnQB+ZuReCSH798vqE49K8so00oYrGXBB9/ubr/rzVrBS6baUP
         hfgJg/NteV4ekmt5xv5DkqUNVPDSWOvCqbzhK4KAz8bNHwU5X7182knrRyvQhuyTebP0
         ljb/RP774zjo1MF1zhVjR0cFT59tCcsXX+S4Bc5RRDnFu7pm+HMAjzKtTjBGuUK5mMeX
         iLp3uIcDh16rK27OICWWyj4VZ7e7P+XClMeGg9fe/OcTqzQdla8d/S1cgfBYoO8XmOxr
         PA2d5dJ9VX90HxTSVAdLDNrtlX+c0Bmn/VSbDwr1spWGN8CMl9nMiPs9Wpjq/pjG4d0D
         kC2w==
X-Forwarded-Encrypted: i=1; AJvYcCUXlfRr/wfpuPzjqP5wVjqWZ/YW9oL8WK/qW2+MEGUt2lAkPEy1qwxapQvUJis9UA7WGYOYbj+DPDZQLzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTebwXa5cq+oNidKOU/N2klHyYfm4TI4f4Xog+eGqlW6V9pnz4
	AJqWlwCzrMNhE+C6g3DehS45x0IpAG3587alwc52NXS1mmYM+eNWLfmgl2On9QDVCszwTHFx+dr
	wtdZ6Z0EsBGycvijQaLsuh6bbMnpRg+Jh
X-Google-Smtp-Source: AGHT+IGrbQwHe617+0dnnmaIpmeE+W3mzJVUAYY/BBybCdWz+UQEx9vhaWprhNp0asXOCQVT4uZreudzrgByyNeKZ7I=
X-Received: by 2002:a17:907:9725:b0:a6e:f869:d718 with SMTP id
 a640c23a62f3a-a86a2fae427mr882065466b.21.1724614869511; Sun, 25 Aug 2024
 12:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825132617.8809-1-hdegoede@redhat.com>
In-Reply-To: <20240825132617.8809-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 25 Aug 2024 22:40:33 +0300
Message-ID: <CAHp75Vd_qkmpekrGUAR96kE5D5Ry3z-sifTzqGTjov-yueMAEw@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F
 DMI match less strict
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 4:26=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
> turns out that the 2G version has a DMI product name of
> "CHERRYVIEW D1 PLATFORM" where as the 4G version has
> "CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
> unique enough that the product-name check is not necessary.
>
> Drop the product-name check so that the existing DMI match for the 4G
> RAM version also matches the 2G RAM version.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

