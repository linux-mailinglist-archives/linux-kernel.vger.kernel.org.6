Return-Path: <linux-kernel+bounces-307222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F0964A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75E828547E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBEE1B3F1B;
	Thu, 29 Aug 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7O+dWA/"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C57B1B372D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945984; cv=none; b=P0YCNvsY9ZNVyzGNaL0f12IdGvo5VqTmsauiol7z+O8F/anb6ozmwmqA+nlGerdjJu/5Ey2Tw/5xA9zXrCngClkDav42sRzsGBIoPxRbiiMjis0K5XZp5FWN/Iob7RvdcMRiGXddqEYh3duLDk1xOqpDlG5DjUx+9wiMWvwPIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945984; c=relaxed/simple;
	bh=v3OcNkfLnfG25Gk8ZY6Wtd6ik89Ax7YMmcRQdVTMIFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFzpZQgsbEbiPaETAppYQ4ajv9Bn0kf3dPzdiGSp45Jw04+ZyoskC9fMCOEw8181lpIkj+jQzrqtRcG4S6EddwqKCuOq5qH+HJZtN0GF18da87CBqiDmauNrhpwKoL6XWVNjBTpBZg1G0Gw63T02uZQBTrZCJhq0Z5JznBAM1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7O+dWA/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4567deb9f9dso281741cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724945982; x=1725550782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D74+30M1YnAgX4+r14pJtBtSFBM+4hW1bBlbUxfhno=;
        b=B7O+dWA/gQbAaP8YodfBHBNYSYN6yTUEYmA2CQ5hGNVUQfLL1oMn+VuWJZxn6RXYX9
         jut9PE2n6HtM3hlu1FLJsL+M4/fSDRIRwn53UvJBTq7FJevnr+f5n9AsOOoNV5psD2Yy
         ewHvuL8KDMUCXwJ/FhovsNGWnvoW5pGJNrU+0jB2RnTJ4jfEPPbZTIQR1aFnFyE+Mv13
         8HTSeZXI/IywlepxgL6SktJkQI8RveDZo5YeJOcgaCnVnNfsuVuRxIROVJNaRroh0MXs
         6fDazr9wrKRDMO17gbXfPuxiCi1eFsU5dz0XpK3NO/4dPC2+nD3pH+gHOAflTomAYp9O
         qcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945982; x=1725550782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D74+30M1YnAgX4+r14pJtBtSFBM+4hW1bBlbUxfhno=;
        b=FafdP8z+M4GHqJ2mhGQwDdeMDtby5ZhrhbNtJmbJnxtKMwoDueifDMfvHaAoanFlGt
         Enlo8tD5jauGdCMcqVrPT8HU6YsuTouijyYoXBmbLA90iX1lH3h8Tc8kI6t3dM7uXGmW
         RSJ9pL0FKU9G3eXWl66Bv0qWEJLvGJKTBk1IKqL7OQZN3ueZ6784tqdk3n1vu4plFDmP
         AuWFakgxyJ9iVLiLDRaHejU9sIfeB4AW8E/p/uFvtdSpwsrzDFdd6I4xNmBpj5JnCyWp
         l6cpiBl0ehC4/pcYovHRP/f01h/zovyH5g+R9cXWgZJv+mKau4OFkbczfN5maIGwAnrN
         WJxw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6in5Syuhab4i9UaR1OTvJb45e5hQOWJqLG2qYHv5XCLwqYDaz0UgswXBtnlZpptEV2T87Lm5cbDD3Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwETaT3al7MNzbuiIkEdallIqGd7oPzH0tdgk/R8qdD2K+QH2Ll
	w153vJIEpKZx36kQrOWM8Pxq7I+d+/gq3u68JVRjmMGMWTA5J5WTm87S4EmSmrenmJrBsBffL6c
	/MIwJqavLJgIC7D1zCr5ApsxsnzuJHLdzGLZpQiicg4j/T48B1CFP
X-Google-Smtp-Source: AGHT+IHUDTzW+IIm6ItotC2tMRbqdsyv1SRDW9WKLnf6aOtEqex4+UOqP5ebw6vSHRryEwjlG6iOoV85JmC6QmNZCt8=
X-Received: by 2002:ac8:5e4c:0:b0:456:7f71:ca78 with SMTP id
 d75a77b69052e-4567fbb875cmr4356491cf.4.1724945981739; Thu, 29 Aug 2024
 08:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809072532.work.266-kees@kernel.org> <20240809073309.2134488-3-kees@kernel.org>
In-Reply-To: <20240809073309.2134488-3-kees@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 29 Aug 2024 08:39:29 -0700
Message-ID: <CAJuCfpHLD=rK_xPpZ89t+E=S77dr=0Gq7+L9BLkojiqN+TC0FQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] codetag: Introduce codetag_early_walk()
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Jann Horn <jannh@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, jvoisin <julien.voisin@dustri.org>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:33=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> In order to process builtin alloc_tags much earlier during boot (before
> register_codetag() is processed), provide codetag_early_walk() that
> perform a lockless walk with a specified callback function. This will be
> used to allocate required caches that cannot be allocated on demand.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/codetag.h |  2 ++
>  lib/codetag.c           | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index c2a579ccd455..9eb1fcd90570 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -64,6 +64,8 @@ void codetag_lock_module_list(struct codetag_type *ctty=
pe, bool lock);
>  bool codetag_trylock_module_list(struct codetag_type *cttype);
>  struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)=
;
>  struct codetag *codetag_next_ct(struct codetag_iterator *iter);
> +void codetag_early_walk(const struct codetag_type_desc *desc,
> +                       void (*callback)(struct codetag *ct));
>
>  void codetag_to_text(struct seq_buf *out, struct codetag *ct);
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index ef7634c7ee18..9d563c8c088a 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -154,6 +154,22 @@ static struct codetag_range get_section_range(struct=
 module *mod,
>         };
>  }
>
> +void codetag_early_walk(const struct codetag_type_desc *desc,
> +                       void (*callback)(struct codetag *ct))
> +{
> +       struct codetag_range range;
> +       struct codetag *ct;
> +
> +       range =3D get_section_range(NULL, desc->section);
> +       if (!range.start || !range.stop ||
> +           range.start =3D=3D range.stop ||
> +           range.start > range.stop)
> +               return;

I think this check can be simplified to:

        if (!range.start || range.start >=3D range.stop)
                return;

nit: Technically (!range.start) should also never trigger. In a valid
image these symbols are either missing (range.start =3D=3D range.stop =3D=
=3D
NULL) or both are defined and (range.start < range.stop).

> +
> +       for (ct =3D range.start; ct < range.stop; ct =3D ((void *)ct + de=
sc->tag_size))
> +               callback(ct);
> +}
> +
>  static int codetag_module_init(struct codetag_type *cttype, struct modul=
e *mod)
>  {
>         struct codetag_range range;
> --
> 2.34.1
>

