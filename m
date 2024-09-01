Return-Path: <linux-kernel+bounces-310135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0696755C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5CB282A70
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63B13B2B8;
	Sun,  1 Sep 2024 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mimhIgus"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED704748A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725173471; cv=none; b=pmLtI0UrHr/tRG6RjOFt5Ps3WI3tkwF2Pd4jYpbQfIuarluhTS38I2Nzph5/CSpfOBP9H8BiWZwDi+6A5Z0niDscyCJNb1l4JmIo4VOxEvd9W/9m1jKt085E5l6DXeleBLpAYvaLt/En2+6QbdxpUgvFouzLeDHU25DU7p5zL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725173471; c=relaxed/simple;
	bh=kV7gjys+8Wloie0u0pMQxji6rrpC6bQCuX+7vzpw2xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg1GBB1VoCIBXCznWC9fBcNcROR6FYSH7TgjoAH8pOzY4lyE+x2EAef6IVz3Um+dmIS4s7cjjNh7qjLkJ3zH+Ri0nWGgS761U2KDDk3g3xhAMpWZiMURESjRhQsABbO937u4O8AMg9y3NlqMv0dq27L3bnQcIEXob0bEXohWQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mimhIgus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717F0C4CEC9
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725173470;
	bh=kV7gjys+8Wloie0u0pMQxji6rrpC6bQCuX+7vzpw2xY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mimhIgusInQFCzUHU9PvkKUQOVgWpHA4Vq/Y97aqhe2h06zQlJXLmqRmpEPTf1JjN
	 kLqHbqKx7xun8kBEOeYS/bxij2zQROWoqQ0nOyM1gqNOewA8VAHvkv9rX42OKFx/mJ
	 +cIdKFtnZxMkBTCUrZA0iEfxmdYfDIH13lpqyyHbUTQnt47xM1w/sHdjlRJk2ZXlIK
	 ZYtQtcVlrulphATIO1oMwhC889a4Bo3WrncP2e7FLQlFRjZ3kBGPekNEiFuPPX5EjX
	 SgKfbrgqE878AB02YE+C7Rv/238Kf4Clc5VBMZO+4AMYKfZrtmNES1YufonSG7lFGh
	 ELHM0oYgH5Z9w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5342109d726so2330236e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 23:51:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwotRY/qWWPTaVemHT6sOoDkGv7seJBGHtJJTJb60uenVwmhMKL5i2/nkyusq/Kn+3sTOYcY7mPTxcpi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVM+sNeQtGFp6kLVP9WOQ545/UetNKmSOQuFXL/ShAm7YwRRMv
	gnoR9anTQi1s4FaFCykK6SwZ/JVblZoaG93wut5JS78frz2dj3LnhiXpBYwX7OeZxd0TWHiPCIw
	sVgh10/b3JiUiLgdp9a+j+cYRfZc=
X-Google-Smtp-Source: AGHT+IFGL7jZC0mVVSf+pywW30GQNCHTVJuGhcv5VnimmEbUKcQnQHWJexcNhjDBgdiKnZr9CzV3TZt64vT1+JAZ7vM=
X-Received: by 2002:a05:6512:3d0d:b0:533:3f6c:f899 with SMTP id
 2adb3069b0e04-5354633a60fmr2223843e87.24.1725173469117; Sat, 31 Aug 2024
 23:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831101045.1381258-1-masahiroy@kernel.org>
 <CAK7LNATtOzj175_Y0qQz338FRG1GYCrsorA=jWG+Go1Wjn9rnw@mail.gmail.com> <8795e8da-981a-4876-99fe-8a4edb2185bf@linux.dev>
In-Reply-To: <8795e8da-981a-4876-99fe-8a4edb2185bf@linux.dev>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 1 Sep 2024 15:50:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfpge7Hg8+yq3uyWD26D=kMcB3pKuoN+BGLfrOFFNgLA@mail.gmail.com>
Message-ID: <CAK7LNAQfpge7Hg8+yq3uyWD26D=kMcB3pKuoN+BGLfrOFFNgLA@mail.gmail.com>
Subject: Re: [PATCH] ARC: update the help message for CONFIG_ARC_BUILTIN_DTB_NAME
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 8:02=E2=80=AFAM Vineet Gupta <vineet.gupta@linux.dev=
> wrote:
>
>
>
> On 8/31/24 03:13, Masahiro Yamada wrote:
> > On Sat, Aug 31, 2024 at 7:10=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> >> Commit abe11ddea1d7 ("ARC: [plat-arcfpga]: Enabling DeviceTree for
> >> Angel4 board") changed the default built-in DTB from "skeleton" to
> >> "angel4".
> >>
> >> Commit fd1557923b2e ("ARC: [plat_arcfpga]->[plat_sim]") changed it
> >> from "angel4" to "nsim_70".
> >
> > A typo.
> >
> >  ... to "nsim_700".
> >
> >
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Vineet Gupta <vgupta@kernel.org>


Will you pick it up, or shall I do it?





--=20
Best Regards
Masahiro Yamada

