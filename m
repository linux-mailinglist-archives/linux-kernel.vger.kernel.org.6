Return-Path: <linux-kernel+bounces-362642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE4A99B78C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDDCDB21A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416A1527BB;
	Sat, 12 Oct 2024 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYh1EQcU"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D517BB6
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728773388; cv=none; b=omZwf7a0fLABaIAVKuoZCr968jCkYXDuo1bQaiVSERwjaURIn0w9r4kSKl3Kqt7WcDoriG/aWnvKmUet2XmN8SAzGDV/YPFUvpWRZQvXaxcP9xNY+Vdou9PdfoHwJtzr+NNBhXy2azDYi+TE1fovPUG2RQCXjKIaxvZMrIOJ49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728773388; c=relaxed/simple;
	bh=/kvmH1T9pt3qp69BVyqcbqDU0m/FfOMa8xod8gzxi4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjnzo9Seb6zxKcH1p/kaEmlL/uSsWm3LIqKCSTwYh6AsMEPH1EZqAwmqa/FCOq67Gdq+nVyK4TkAU7gpBENxwdoTutn9JbbEFpeXy+lAeB0jlZ30roDL4PIx18ESjAahSJaYc9FbCGMhPgN0fpE6EkfpvvbcaDHBnbDh/rUVdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYh1EQcU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so35572095e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728773385; x=1729378185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiYmV1p7PV/Xl9HB+YzDHEFG1quC1dKoP9wDR4TCjTU=;
        b=jYh1EQcUShCfNLVhbsPs2oZt+jY+rEfSQAS9xM1gIx8jEe4hD/QGSZjLD+xYxvuump
         vq1Jn3PaqkPt9BQb0LNPmRpp1vyZZ0M3TdPSoWY9kjPzeXCiVEhHxXskYwJdVKT3V4FY
         y5Njq9zKpYHz/jyBB/UTRDIuYw4FWlBKA8rP+almvlfJnZwz0L56r8xytPDXA4107bxK
         kV06wSs0JaBg0QOGUC73zpMxtkWdLBH7BuQJRvFc1r8COeUQ+8piATOaai4gpPyztTGv
         9xGs1o89bxBrSD8jOIfqqOlyyIy5H7h3pEg8v4u7uUGC97POEbV7Dd3qXP2srmrg4PGT
         ViLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728773385; x=1729378185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiYmV1p7PV/Xl9HB+YzDHEFG1quC1dKoP9wDR4TCjTU=;
        b=wAGthkK423+X8WYuyWuKHSEriAZZxImVq4Xa7Zq33qby8LDnVsfC3LOuZhhgIYzzsf
         D3lJCzuAdTPTziA6nLrzMuzmOTkyRwAXzr46ixa+Mb2h2uGfGlVMa+dSETdsh9dX/Yp7
         kdmR+GE2w3E2fVEpFYQFjJBnJfgDkg/YsHoRcky0LYMfKgV0yAWzTEUJGmG+bflq2xBX
         Hm0WzpZsv7PoYX5jkIUdTbO2M01VIwcd3Ui4+GHLA+KnWhzaIKh/CbjVnApA/b9H+4Rr
         IapPGv1wgaPMk/9UjsVS5hUwnc/WxtpBVXOViE5CfG+WE2hcmb7zUb/UFQ877cj0PAb8
         keDA==
X-Forwarded-Encrypted: i=1; AJvYcCVdcRbpMuEATDcqXoYwrn7qLbLFV3HLurlxC0ZnL5ssJj2VM4VC3If0ph6veJDJce+2hud2obS9AO8nifw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0F7OXyN47Knd7DQSCP91wVO6TicPjZ1BoRlbjNkbu6O4aMng
	XJ5O5+codlqNodqo7WdowXXsjyhxQHbtiqHuDL1bXinQfbdX4Kuq2xV9XDWRnRqtmF9JyZAKABB
	Vf/SW7EcqPMNlYzsNNLotyLH3zIW9VQ==
X-Google-Smtp-Source: AGHT+IH5P363jOnHG0JHPBbabw6H5Dy1Dd3sxUGHcb0+I0f+LI29mMIIx3jR2LB2UK5U+aj4sV5wrThGfxGMS2lBwMQ=
X-Received: by 2002:a5d:540a:0:b0:37d:47e0:45fb with SMTP id
 ffacd0b85a97d-37d5ff86f1dmr3202479f8f.21.1728773384724; Sat, 12 Oct 2024
 15:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011114537.35664-1-niharchaithanya@gmail.com>
In-Reply-To: <20241011114537.35664-1-niharchaithanya@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 00:49:33 +0200
Message-ID: <CA+fCnZd2yG9-bC=3nvDHLvkvz86x-4p0ewBoi4V5T40+BhQJWQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm:kasan: fix sparse warnings: Should it be static?
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 1:46=E2=80=AFPM Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> Yes, when making the global variables kasan_ptr_result and
> kasan_int_result as static volatile, the warnings are removed and
> the variable and assignments are retained, but when just static is
> used I understand that it might be optimized.

For future reference: please write commit messages in a way that is
readable standalone. I.e. without obscured references to the
discussions on the previous versions of the patch. It's fine to give
such references in itself, but you need to give enough context in the
commit message to make it understandable without looking up those
discussions.

>
> Add a fix making the global varaibles - static volatile, removing the
> warnings:
> mm/kasan/kasan_test.c:36:6: warning: symbol 'kasan_ptr_result' was not de=
clared. Should it be static?
> mm/kasan/kasan_test.c:37:5: warning: symbol 'kasan_int_result' was not de=
clared. Should it be static?
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@i=
ntel.com/
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> ---
> v1 -> v2: Used the aproach of making global variables static to resolve t=
he
> warnings instead of local declarations.
>
> v2 -> v3: Making the global variables static volatile to resolve the
> warnings.
>
> Link to v1: https://lore.kernel.org/all/20241011033604.266084-1-niharchai=
thanya@gmail.com/
> Link to v2: https://lore.kernel.org/all/20241011095259.17345-1-niharchait=
hanya@gmail.com/
>
>  mm/kasan/kasan_test_c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..7884b46a1e71 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -45,8 +45,8 @@ static struct {
>   * Some tests use these global variables to store return values from fun=
ction
>   * calls that could otherwise be eliminated by the compiler as dead code=
.
>   */
> -void *kasan_ptr_result;
> -int kasan_int_result;
> +static volatile void *kasan_ptr_result;
> +static volatile int kasan_int_result;
>
>  /* Probe for console output: obtains test_status lines of interest. */
>  static void probe_console(void *ignore, const char *buf, size_t len)
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you for fixing this!

