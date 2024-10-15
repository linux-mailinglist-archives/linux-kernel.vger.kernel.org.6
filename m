Return-Path: <linux-kernel+bounces-366915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF8699FC36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105221C24A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C6C1FAF1B;
	Tue, 15 Oct 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqE24gxc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76441F80A9;
	Tue, 15 Oct 2024 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034227; cv=none; b=Hf799l0M3QufUverjeIKz1lmvDOZFHCW3yv1PoOysHrdXyITukE38JGgsdL9ya7Qotiq51a9gTRQa1A/yy8LzoPUDoCJ7tZunRYnHQgzn2/roe5rSLV3lomXCgW4tqFbQJ7wa1phGMDrddGjhzGzRON/V1lTqMN3lxxkNQ4oWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034227; c=relaxed/simple;
	bh=yNEQTDJYd3zDwO4vw237JOdlRcVHD6pdhGX8t7IxIyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgAAQ0q+qm5XeWE1kNmPbaRmXUPTUnlVG9PMFgcl6XVT80oR/oGPiPfVvk8OtUbd4nEoWARRaD6mqJ/0rMW/rnlXr6xTgT02wmZ2ILhaQOJK0sbIbStmbFPfZEKyVjeK1asfTuWx8K8dKycf8x9xCzwquue9/WiBhsyD0JDfy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqE24gxc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431481433bdso7947595e9.3;
        Tue, 15 Oct 2024 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729034224; x=1729639024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD4CywG5G4jHbhFsfPy0Spq5T4P0b6fgkLacmkiZ4vE=;
        b=WqE24gxcIlP/4XzHylmsty6ybZdFKSt28A5tEbGj2Qgvoc/tMogVcCy4WLXiVFk+wP
         P+QTdnLAOZnmjMfT6mXNuKppXpWXazrDHFOxePQuQLUDkLNCFrQnA7Qfxaf2EahV9rnQ
         zcATysD2Xuw08EnQX7GJEh4cM55m+IcY7DfgHonvu3qmQ73hpthwG8zFh1Go8Bm6LmfV
         lHpJViQGdbawC/Dx4JWeoYnO1vBuUTlEbx8OAIisiRkU4+uoC8LHGFfKgR1xQRZAKtQb
         T5NXNMcFEAKYeBp3IvYTPf/n/hmylmlcvs+uRsPBBGgqPFMgjroA3ZcgyeoR0qZ8+TkK
         e37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034224; x=1729639024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD4CywG5G4jHbhFsfPy0Spq5T4P0b6fgkLacmkiZ4vE=;
        b=wHpe5SAyfvQ4EUJMvMshZXR86vi15ccOmhMpC010txbOPEi8vNwCoyjdGC2n5Y/mqa
         1a1R1JQqOLgrqoyEkcIpFIGu4D0bL01UlI8dDw7k+30HRIAFuhnUcP5zrWCexqwaFnjx
         KH8tvLG9ca3b/3T4C1zk2FLSyk1L94zgHohc7ctzgbKwi9HMU1pP2F08wNaLVO5Ez2x1
         vN9yrycXQwBcfDl6OTELiv/HNdsVJyyLRdZrYrg+w9jPVMzSkw0eFZi6gcfCtqcchw0A
         dLF6ik8MxYcuQTRIba4dHPiNZkzZb7/LXIH2OPDv3L4J75pqPOJV4jBOA3rPXSb578DJ
         BYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF3vZV/F2QbtYucPXtvrXA7S9dzjZKLR26MqNmnjyexeB77h9VleAnh5Y+Gf/MMQ+Lh7FlhtvdSkB3@vger.kernel.org, AJvYcCWjkI6lLoB/+RkJAPAeMtH8+N4nIpfhKcdfjGuUcI6VvEQ+BwYc8VvPJmph3XrkxSGCKCJz3od+35o=@vger.kernel.org, AJvYcCX8s++bfvinDkcq7dkIfMDssJpWaRmjm9UOSAfTLSeg/i1lGbazGHEc0QvZwJhY9oKTh6Maq9yVUYApUT5p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+I0855fF6h+N1x4r8x6G3xbnb7oE0ZT9vFCTKb7gAcunyUQ/e
	NQ8XMzerp/2//QFlCPb+uV2Njt1cWuxBSY17oY3rszBynGQR5GxX6Bx+n7eCkiyQE3w5BSrfmEL
	4YFOWTib4vLCmb0pjgn+DZIWJmOE=
X-Google-Smtp-Source: AGHT+IFfPTgIz4rA2XwAvHVPueqtZhJGmRZFRE4ddHUTGZk/+1SCzJOPWNfvCkOwGnD81zjFhcwyV1EKACC9Xm8QGCQ=
X-Received: by 2002:a5d:6647:0:b0:37d:453f:4469 with SMTP id
 ffacd0b85a97d-37d551d506amr10150361f8f.22.1729034223715; Tue, 15 Oct 2024
 16:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
 <20241014025701.3096253-1-snovitoll@gmail.com> <20241014025701.3096253-3-snovitoll@gmail.com>
 <20241014161042.885cf17fca7850b5bbf2f8e5@linux-foundation.org>
 <CA+fCnZcwoL3qWhKsmgCCPDeAW0zpKGn=H7F8w8Fmsg+7-Y8p3g@mail.gmail.com> <CACzwLxgJaOL9RXkhAZEosmFDzp-D4=gGfhSh3d5scBRBaq76pw@mail.gmail.com>
In-Reply-To: <CACzwLxgJaOL9RXkhAZEosmFDzp-D4=gGfhSh3d5scBRBaq76pw@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 16 Oct 2024 01:16:52 +0200
Message-ID: <CA+fCnZf8YRH=gkmwU8enMLnGi7hHfVP4DSE2TLrmmVsHT10wRQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 2/3] kasan: migrate copy_user_test to kunit
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 2023002089@link.tyut.edu.cn, 
	alexs@kernel.org, corbet@lwn.net, dvyukov@google.com, elver@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	siyanteng@loongson.cn, vincenzo.frascino@arm.com, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:52=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> > Too bad. I guess we have to duplicate both kasan_check_write and
> > check_object_size before both do_strncpy_from_user calls in
> > strncpy_from_user.
>
> Shall we do it once in strncpy_from_user() as I did in v1?
> Please let me know as I've tested in x86_64 and arm64 -
> there is no warning during kernel build with the diff below.
>
> These checks are for kernel pointer *dst only and size:
>    kasan_check_write(dst, count);
>    check_object_size(dst, count, false);
>
> And there are 2 calls of do_strncpy_from_user,
> which are implemented in x86 atm per commit 2865baf54077,
> and they are relevant to __user *src address, AFAIU.
>
> long strncpy_from_user()
>    if (can_do_masked_user_access()) {
>       src =3D masked_user_access_begin(src);
>       retval =3D do_strncpy_from_user(dst, src, count, count);
>       user_read_access_end();
>    }
>
>    if (likely(src_addr < max_addr)) {
>       if (user_read_access_begin(src, max)) {
>          retval =3D do_strncpy_from_user(dst, src, count, max);
>          user_read_access_end();
>
> ---
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 989a12a6787..6dc234913dd 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -120,6 +120,9 @@ long strncpy_from_user(char *dst, const char
> __user *src, long count)
>         if (unlikely(count <=3D 0))
>                 return 0;
>
> +       kasan_check_write(dst, count);
> +       check_object_size(dst, count, false);
> +
>         if (can_do_masked_user_access()) {
>                 long retval;
>
> @@ -142,8 +145,6 @@ long strncpy_from_user(char *dst, const char
> __user *src, long count)
>                 if (max > count)
>                         max =3D count;
>
> -               kasan_check_write(dst, count);
> -               check_object_size(dst, count, false);
>                 if (user_read_access_begin(src, max)) {
>                         retval =3D do_strncpy_from_user(dst, src, count, =
max);
>                         user_read_access_end();

Ok, let's do this. (What looked concerning to me with this approach
was doing the KASAN/userscopy checks outside of the src_addr <
max_addr, but I suppose that should be fine.)

Thank you!

