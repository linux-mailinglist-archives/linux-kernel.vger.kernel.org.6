Return-Path: <linux-kernel+bounces-264823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E193E8D4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18511C210AE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CE5F876;
	Sun, 28 Jul 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GqmvyEL8"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5A3B1AC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722189897; cv=none; b=IvYQ9cehEFWFLunlZGagVh8d4aNsEJb1DMZDEbtILnERf8GXP1UHtXZJOeXxFH6Ticg4m40Y757CmYhDMkD+N3GB63l0UHdY/dY1Gjt0DF6Arca9/6U0O8xRYXW7IeGgLZXfCFLxOqZcLZuofpLVU94GAMkBxbwMDGKC5NBk3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722189897; c=relaxed/simple;
	bh=CP97C4DI0v3YH3ZdnaXwZgXJ/js41Li8sJOyNwiLuVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mw2HSDclpz3MfLUPbhRmNm/bsZI9hcEuAKi/A/HL/Sy3aWMpbdvAtNX7Ft5A5d7MttfT9vfochDiW2xOVVE8pUKow/Qyd4RH414zbm2Gq+WzZOcNQkup6asODVf7zPRt9zs4E+qiu3hGO3SyR5XArXpeLgHyHLSC6HPGNxIlDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GqmvyEL8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso31959931fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722189894; x=1722794694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xx+JcWmCLFNs3uFPu/ZR/9mBRzN/vwNYIcCoPtFGjmk=;
        b=GqmvyEL8Hr5asXFOA0KAbv+ORiLVxDnuzw53d8NwwVQ8xeRCjyUmyYYuhekLJ5MQ82
         ZFxmS07hWIQxtxiAA+MTvGZKzGDjGQXDg6SKN6BCsVwmkW82WghEnKUazD04QqgiAlf9
         W5rNlPSF//FkanAI2+WPQrmZfes/BebYL9wMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722189894; x=1722794694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xx+JcWmCLFNs3uFPu/ZR/9mBRzN/vwNYIcCoPtFGjmk=;
        b=J6e5X2DlkpgSmJJCLzEfDpx4NBQxevUPfoVVQp0PAP3rWa/n9xfs0QSeEFb9cQGLGy
         jQQA+k59ureOMQZjLYc5SCrPRfFKPY5fop2LV/CHbLOm72QPYWmNhKhbvaQP57WwGtZ6
         CKBSe6wdzryrik1kBNDyXw7lCzKvK12CrfyyafRugWKtSnEcVjAznJQo6ubrZ6UwJxEd
         fShk4HPkbFFC41o6/e23uMtLHFbgffEYjE7ZUZpzXY3jkKUmEiUjdxxp43KlatalyOlU
         5xhW8dE6hNm26iiS8PQEy7nhcCxPfkn2rXJ2uPqp4/oC8Lf6VsgFIrLTDqzbTPTs1UEs
         BSrg==
X-Forwarded-Encrypted: i=1; AJvYcCV0sTpMA0ReRpyfZA12pOr8t+TbCZ1GAxx6yOICeusRshYl9q3f/M02BSPlxBepWgIwlHTixJTExHBhn/m+oOO0PKQUhHnF8dlkJ/Vm
X-Gm-Message-State: AOJu0Yw8pK/mqPh0V6Bl71oVSNRCfnY7XFUXj7PJXXvQJMCsDzvBTWL/
	3WDlDgs8e2uo4p+p6Hfeb37f5I6hPY4UMVwpVN37rewRBVlv6peHcFIeoUOHF3d1EA9LDU/ch/j
	ABciSZg==
X-Google-Smtp-Source: AGHT+IHeq74uteAaagP+t+ZWmvyt/Cl1Q6sevpPECPSW+ZrywqTqFx52lxtQiv7VYoLjtr8aq8rPXw==
X-Received: by 2002:a2e:6a18:0:b0:2ef:2f4b:deeb with SMTP id 38308e7fff4ca-2f12ee1828fmr31728111fa.23.1722189893451;
        Sun, 28 Jul 2024 11:04:53 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d075468sm10291941fa.114.2024.07.28.11.04.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 11:04:52 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso31959741fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 11:04:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWa3cUgCdRQXCBsfopgYnBsQgiJDxX+eXflMjWhIAULqC20xWwzrwL5IAJ8tsBIopMYnv4XNQrsbDHDp49K2dC35iqV1KirA+EWwQ0h
X-Received: by 2002:a2e:81c7:0:b0:2ef:24e8:fd83 with SMTP id
 38308e7fff4ca-2f12ee47096mr39079221fa.38.1722189892347; Sun, 28 Jul 2024
 11:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at>
 <CAHk-=wjK1ZLk8TjejsRfDUH2Jp4=FPfD_GQU9z-m=bm75+jBMw@mail.gmail.com> <2116767413.129257.1722150789677.JavaMail.zimbra@nod.at>
In-Reply-To: <2116767413.129257.1722150789677.JavaMail.zimbra@nod.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jul 2024 11:04:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOQVJjX9YL08cbeLFMm_EW_NdZ8mHb9i3+=y=6sGK6mQ@mail.gmail.com>
Message-ID: <CAHk-=wjOQVJjX9YL08cbeLFMm_EW_NdZ8mHb9i3+=y=6sGK6mQ@mail.gmail.com>
Subject: Re: [GIT PULL] UBI and UBIFS updates for v6.11-rc1
To: Richard Weinberger <richard@nod.at>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 00:13, Richard Weinberger <richard@nod.at> wrote:
>
> The issue was detected and fixed two weeks ago:
> https://lore.kernel.org/linux-mtd/20240713073519.25325-1-richard@nod.at/
>
> But I forgot to include my very own patch.
> So, the failure is totally on my side, I'm sorry for that.
>
> Do you allow me sending an updated pull requested?

If  you do it quickly. The rc1 goes out in a couple of hours.

               Linus

