Return-Path: <linux-kernel+bounces-256083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2DB9348C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB73F1C213DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD176046;
	Thu, 18 Jul 2024 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm/IeXka"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58D2CCA3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287639; cv=none; b=WJiI6o883A9QpYMw5Za7HDmpyPunLcKIL/2T3CWLT3eyoBTWK0bKjiRXv/yxy3o6XkM0TgNJ0wVfyDNHXlyQ+fUdozKUi9043JHjxEOBLbMvzH5XshhOHbt/aeEKE8lQUvSlxhRqcoXwvWxtcIS+wgWGKGo+hregWu1RLuor6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287639; c=relaxed/simple;
	bh=zid9Eci7AL/wuXicikJDMg3PEiGhMgezty3o/JUcrUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfkEFKFy4bIU94imrH7lV0EHEoatTOwKmq7HCuNwL/2bn20nNiG0KA8TOcv8Ar5g1AskRZ4TQQRTaueuDnbpYUxgRcLSSFzYk4vvTd2k1q4JBC5XxPXCjMXtSdt3unymYrab76RZf/4IViS5OPM//m/c63j3nICNn1jJ/k92Qts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm/IeXka; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eee298bd2eso5977941fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721287636; x=1721892436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zid9Eci7AL/wuXicikJDMg3PEiGhMgezty3o/JUcrUA=;
        b=Sm/IeXkae0EJSVlbN5stpyYFk4AHdbJywNbVJg+L7lDKMq+3uS7pLIIGkUAELYMU0b
         fWTX1bD+bJU5KIQOOJpshRy0w7PC6BhoIySyzTOYuWCsrxh6AOm6V/ffaVFyHIB3bT6z
         Z07lHtKA7YqDbZrRpCRECtLucavJGyUlo5mB4lFNGCRbJomlJVBaZkZYfvmIwx9xH/My
         9VXBwJkwRueOBITsMwVUWju3OeKehD2auEy206UTBU23rJBWLumhdzBUmNNe1FDUOGZ7
         mWIzF6flzZKBdDfa7oAlWRRBkWLO2Zet/qWTcbO1L+rn1k1ST5xkbQxojLFjVSRMcAth
         expQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721287636; x=1721892436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zid9Eci7AL/wuXicikJDMg3PEiGhMgezty3o/JUcrUA=;
        b=N+Zs4PwNUAPzph2AEJrrwj61fITZ9Lp/pXMkOkBI1Ra9NDrOqfmieb8BvCoC3bepZu
         vBe7oWYXDRD7yaRH4YIAF3yFfUPmgH12r1VFQfXnXo4bNkkRzg8VHSiFx6LmNvHeWu8/
         Ctsyq1haF+v8UorSqUffVkuTuHTMwundNt3lYOdmPNpgQh76VhQ3T6Vy6scDnOyUr6Xe
         Q3pcXyKkGwYnC5p4Zcl/0po+7VuqzrW7MwlrzEvXzPIbHVodn9lu69hKYPAUch//5QAx
         gE435EA4V92QGe04vnjB8+HvuVq/h7ZMAImm94ttYq/e2DGaQBGPhmNOfzl6YUopJj81
         Y1/A==
X-Forwarded-Encrypted: i=1; AJvYcCVbLFavoOcjMRvaqLb/QW8x8WiTREIxfvBkQkN1sb5BPUedCTz30ObybIkSJotPI8IV7c8lEDrnwui5ZVv/Py1j3m2A0xofQfP0QgkQ
X-Gm-Message-State: AOJu0YyHe1Q3IndtFSLyVYe/ZQfo3UwLYGKDRuh0eybYJ32siTbrGf84
	lsKOQy5+e6it9PXBbqTujvsTp8QSs2qOn+1Nockz05qFhrLYTuCZlmQ+BiUmvnH6RvYe8ZQGm2X
	7woVr7MQKKZ8b5P2Kqn0iI23RFrs=
X-Google-Smtp-Source: AGHT+IED70o1aCre0RwafgD6xR5+66MGuC3J6+RDdJ9d9CMiMZTvDzok90+au7ixSfYa/otoyPdA2/PO0WStrCtA0Ko=
X-Received: by 2002:a2e:97c9:0:b0:2ec:3fb8:6a91 with SMTP id
 38308e7fff4ca-2ef05c6e430mr10818681fa.19.1721287636094; Thu, 18 Jul 2024
 00:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718063242.52275-1-ubizjak@gmail.com> <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com>
 <CAFULd4bVO39emR49thto4w6LZX0vS9eJKE75u26aCFk7CRVrVw@mail.gmail.com> <3E2205B3-C2D9-4D4C-9847-1CF0BFF68D72@zytor.com>
In-Reply-To: <3E2205B3-C2D9-4D4C-9847-1CF0BFF68D72@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 18 Jul 2024 09:27:04 +0200
Message-ID: <CAFULd4ZXQzxq4ACOZUKpZKmGFomPxHxc+LhmXZ_uEVizjWbXiA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Use __ASM_SIZE() to reduce ifdeffery in cpuflags.c
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:59=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> >> >-#ifdef __x86_64__
> >> >-#define PUSHF "pushfq"
> >> >-#define POPF "popfq"
> >> >-#else
> >> >-#define PUSHF "pushfl"
> >> >-#define POPF "popfl"
> >> >-#endif
> >> >+#define PUSHF __ASM_SIZE(pushf)
> >> >+#define POPF __ASM_SIZE(popf)
> >> >
> >> > int has_eflag(unsigned long mask)
> >> > {
> >>
> >> Just use pushf/popf. gas hasn't needed that suffix for a long time as =
far as I know.
> >
> >Yes, this works, too. So I guess we can also remove the comment
> >explaining the reason for explicit suffixes?
> >
> >Thanks,
> >Uros.
> >
>
> Yeah. You may want to check the version of binutils that fixed it and put=
 that in the comments.

I have checked that the build works with 9 year old binutils-2.25
(minimal required version), so the fix was applied to an even earlier
version. I guess we don't want to burden unsuspecting readers with
historic toolchain oddities, so I propose to just remove the comment
for good.

Uros.

