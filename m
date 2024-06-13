Return-Path: <linux-kernel+bounces-213375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BD90745D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE9B22527
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DBA145A14;
	Thu, 13 Jun 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psgJ/RS5"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB6145323
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286673; cv=none; b=VsaUzzf2EGazUY44QZlxjPdMaicppX3d88QhJ3wwB66rBYew9FWmVvQ/+rmNfaKpfsltmarsppdaN3uyqZWu+haI73YKWrmNWGjT4NZlnbdgeNk3/JN1yzsfil0lkpYeXkMzKopZQvN+nWarAo+0TpdRqPkDIW3VRB/79P0aK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286673; c=relaxed/simple;
	bh=9DB5CWDdovNpAyvyJicZ21mV8l/P8uO+dL6TwGZ0FeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMVc2cI2goFBr4GeryHYiVHoESVzddSSAeEz4VGmQJhAWQccEK26B62cmEfDqUyijxMbPYpGD6ryrbJxRodzqZJH6ACmXpWqOpn0eNAmiqw/DEyrLFuX0PKaFixcqhour+PgcpSGqwmrIZIbDZERyu+6vgp0d9hyqP61RZ/t13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psgJ/RS5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so11278421fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718286670; x=1718891470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DB5CWDdovNpAyvyJicZ21mV8l/P8uO+dL6TwGZ0FeA=;
        b=psgJ/RS5XYOHyzCkYpAqnB01xkMGgDQ8SEho4D2kG3uovsY+u+vaLNS56ygxZ0+kP/
         AAt4qTgVF5y/eIuBlklYCsmE3f3T+w/44yqypYTE0oyEDBmgiCxGcPWCBo4pcPTCysQB
         WoNGKhbxRpQ3KwwAVpqIS0C8PObpUQJqEdpWKtDzHNeJiH37ONQo4uRejavpOFAqegjN
         Lq1BTyYMLak9FdaXofSWt/mTtoLowm3bgAjyuJi5DbNmEDCWhcIEdJUqavwkdGd4qQ+d
         LLFk/WPiZK2Hf9vn0EnXfZwBqjLWwO7p5lhw0SeG+Ad6/skwQL8VGpPoTfLsUWcxXI8M
         iprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286670; x=1718891470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DB5CWDdovNpAyvyJicZ21mV8l/P8uO+dL6TwGZ0FeA=;
        b=hlznuPlXBLuAS5C/7eIE56GUG8rBpbI5ojXcsmlwQBmwRPp4npDC4QrMfjBimPIg1A
         Ak7WxdvfpkMiA/pQZS789zm9+BuaEeblDES+ZvVxAYpyWogfVl6hN17W850BcFRYlh7z
         P7cxpq5ql/4tmOTabu2zYNs/ZfLFblj8BF8gAeePsGYkiklNrgxG5hv5hIb8DSZ1vfr7
         gMOt826VefDbkHehKFs+UT72UIV21CqbaM/5vZLUOETM84w2lZp+ZXUfdq12VVktnDam
         NMA9IhFhW6sMCgOuu2/BeXsOeNwh0me5cfD4Rsoizab2T6ZIbxjhs1d9wHR8ZqSB1IK3
         MzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOjrLH3Z0wOa/IskBB0f7VIFOfJOZWZCv2tgCXGykmjm5qbqk7NfG9He89V8O3IaJZ4CbWYA+hXsVgYyHSCHisqf/851v2iOv8gbrl
X-Gm-Message-State: AOJu0Yy+ZBVPnhH6ypvklNtyoGc1FxknpsG5/cS66Ug6ICIiT1alp3uw
	gWi9DOJOwTfsS3EVwC8cN1JZWt8EQZzG+R7cSVQyff80mI+3LNPYIrQ1Z8dAAZAoJqDYk/P3AS9
	3LZh5caKSHJULP1j8QjpQtFlDeCR7HB3eJiwEuA==
X-Google-Smtp-Source: AGHT+IH4p1YTTkM4zLDeTkFNAU8ZVNhkkssMARE/QWRZvq1bxj14r7yOxfkzqyBmozT0ChjHyBmtRk9DyfRWl++9Q2M=
X-Received: by 2002:a2e:bc17:0:b0:2eb:fdd4:cd5c with SMTP id
 38308e7fff4ca-2ebfdd4cdf7mr43674191fa.42.1718286670356; Thu, 13 Jun 2024
 06:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121203009.9257-1-ansuelsmth@gmail.com> <65d62b60.050a0220.c7b96.614e@mx.google.com>
 <666ad6e0.df0a0220.f8b16.4a5e@mx.google.com>
In-Reply-To: <666ad6e0.df0a0220.f8b16.4a5e@mx.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Jun 2024 15:50:58 +0200
Message-ID: <CACRpkdYJoNRpciyQE_A6dkb8f6Jsy4+qwb4w9K3bss2mkZpp1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Eric DeVolder <eric.devolder@oracle.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:24=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:

> Sorry for asking again... but any news for this?
>
> I have also added the 2 patch here [1] [2].
>
> Been in incoming from a long time and I have seen other patch getting
> accepted. Did I do something wrong in submitting the 2 patch?

Hm Russell must have had some concerns, Russell?

If for nothing else I think some Tested-by:s would be appreciated,
do we have some people who use this that can provide Tested-by
tags?

I would rebase on v6.10-rc1 and mark the old versions as superseded
in any case so it is clear it will merge fine.

Yours,
Linus Walleij

