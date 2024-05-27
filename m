Return-Path: <linux-kernel+bounces-190693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03C8D0175
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDAE1F24E35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934B15EFAD;
	Mon, 27 May 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoPsV5/f"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3215EFAC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816465; cv=none; b=AS0ZoWA/sp08qd2ajKWnBfVIe/1Po61ySz3xJi2tZg3T33A4HAcjZAdNYzE6nX6V2BKcbL8NW+4pQIxdlQ/JzoDPrj51TOblqynSRcf4XfSZ3MIDGIRH+9H0t5yoRLQbU/SsCaV5JoLTfjWvANSFhkAsGodG94APcHSfS6IVfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816465; c=relaxed/simple;
	bh=TuIFBfTPCEqP6bHPkoDibmXslNfsgD9MX9uClz3Xr40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlMryzpvae0P2ZikrfPyq20PQOX7qWStu7CZr4YEoku8RjraqV7xjEg2EAr1s0pNFENz6+YPIDpsqb4R34FLRZ/NlZlc06A8aKgIDlYorBPqlsfS9tt/yc/zC2KAHtmq6cVuDFrTS6sInmpFOe+Rq6nqGu/6PIKrt9sNjS7894g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoPsV5/f; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5366so2079637a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716816462; x=1717421262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PiCS/M86gUVosiM8K3s52DAeVhft4izSu+PTRcDU+c=;
        b=ZoPsV5/fEBCGdFIQuKCZyTCUDWfXaZPDkOUAgGApiJ5ZmaOW9+pwDKQ6M+HEzDhu0B
         KKIjUqgCtgA7qqmjsxTheYGDIg+MsDkYhlYM228qsu4HsStkOfE3IsDw9B6cZtiN6Th1
         GN92T1N0h4rKDQ+nPEzxmw6chh/PEW1J+AK6GMq6S26bS/KcsAVMxTCaqtBUAgnCYFLe
         2RDzfa0bPegmk8hQTsAe487HFQmwBz61t/DnlMmzxJ7XxWmD247lBv8dFEMxWcsfqn+K
         vaK8bJOM2gKHuaYFx4arOk5xoA3/lhuXMgA90ywczx1hGZawyHiiD/KzyFWzyKrj/FPw
         0hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816462; x=1717421262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PiCS/M86gUVosiM8K3s52DAeVhft4izSu+PTRcDU+c=;
        b=phxMIQli41NyEyTrbJ3X25tXX2fqYTTJ26mtGv3HiynWZnT/2P/E+1VAxtZnhNWN1v
         BLg79xKCYwaxDufRUpDFv2QPMvjZOdwSvVpL2V2UCMS/XJ16QXInWSFQ3kyH97nDaieq
         AII2UpdJDp3eD5RMz4rADNAW7sOAHLFdWVVXdBG6RZM0hAsK+TVQ9Sb2HbofB4olmMaE
         7M1FMNDQJ3+JhkBBLHTjWk/YaGYk2gnva0yNtyjZJ8i88LhOKUke5iQc+Hf249xtvCSb
         ntKc9rUOjQytRsAVLyLm9N2zRv81QNUMHz/yIk5vGRVt9jVgzdJ2TN82Vae9oMJGcQqt
         PhgA==
X-Gm-Message-State: AOJu0YxDIHP+PtXkhp31C9deCkbK41x8AET31X1RlmiQeRQP238DiPuw
	h2nZEc1F5U6vPPyiPSflkgCi8T5WqzpOUSCvf+5MU8n2jN0AzXXAPH7ZEYl5qkz5fHZxxe89uFC
	/86CmD2UNkiEAuE6tW0KM7clK7z8=
X-Google-Smtp-Source: AGHT+IFVnPcxnn20cR6Msa0tnRriAja6yhiHKtdshVA25MZLyQu648CM9lajmEybbVLSk/Zbf87ADoFMy1T7v8HuJeI=
X-Received: by 2002:a17:906:7f15:b0:a62:e9c:f621 with SMTP id
 a640c23a62f3a-a6265148c46mr662007966b.58.1716816462000; Mon, 27 May 2024
 06:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527094320.2653177-1-jani.nikula@intel.com>
In-Reply-To: <20240527094320.2653177-1-jani.nikula@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 27 May 2024 16:27:05 +0300
Message-ID: <CAHp75VcWXCeQo4n67cfq0VQaO-+YW-=iqKx+r4NtFfYnJBTBFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] string: add mem_is_zero() helper to check if memory
 area is all zeros
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, Kees Cook <keescook@chromium.org>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:43=E2=80=AFPM Jani Nikula <jani.nikula@intel.com=
> wrote:
>
> Almost two thirds of the memchr_inv() usages check if the memory area is
> all zeros, with no interest in where in the buffer the first non-zero
> byte is located. Checking for !memchr_inv(s, 0, n) is also not very
> intuitive or discoverable. Add an explicit mem_is_zero() helper for this
> use case.

..

> +static inline bool mem_is_zero(const void *s, size_t n)
> +{
> +       return !memchr_inv(s, 0, n);
> +}

There are potential users for the 0xff check as well. Hence the
following question:
Are we going to have a new function per byte in question, or do we
come up with a common denominator, like mem_is_all_of(mem, byte)?


--=20
With Best Regards,
Andy Shevchenko

