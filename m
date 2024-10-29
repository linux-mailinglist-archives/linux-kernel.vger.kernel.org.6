Return-Path: <linux-kernel+bounces-387284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF99B4F04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E16E1F23DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44896198A05;
	Tue, 29 Oct 2024 16:13:17 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79F195B18
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218396; cv=none; b=sNZRUcsOlFZ4C1nW785CiCWoXeHb2ZBeQKSOlVTP3rG2l0RwS+GxyQ/TLPQzOrMpjetSOuyFos1AWQ5CJO9/BJGyIGAzeI4ytQwHepDM3/38B1JkeSRf/9ZtKrBBYRXrYOh2QTdBB1N08Uh6TVQN1G38tfN5LrMtOHRvFQ+B59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218396; c=relaxed/simple;
	bh=Zhs0LPU0E3TP4rasQL+oeS5o3Raigf8SyupbdR1yQA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MsDfaq7M5HDNuM7sS/Y1WowpvXOjq2jE5vAmYqAXcxrjkgIzKC6wIvMWHVfVn48vqFPn9mv13NagKPTHjtPwUlMgyd9VNVLeK1ODP0v4YGx6js3wePjrzsBpIq6jklwi5Lpi1ElAL+5RRs/0Oozl4CZ7X3LhRTRyUTCqxrfQoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so7011233e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218392; x=1730823192;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jfDxjt0O59fHl7HGYkysWqybNou5R8ZLnQr94UhTkU=;
        b=NN2OnK5AwPiD2r9GCBVE8bm3/xg+XAM0WNJCP13FVxJTMUxva5sCwbXOGX5ufeKhtf
         ewhgM7uTzTb40Yu7ZkOyI1GDT1lUIavb9+nAcksX3umuGZ2+FF1dKg/bWhNypNWP+D2Q
         xTbIm55356mcqGH1LgiKMSMwB0MTsbw6yhrNDafyiKQjt7iwwteRsJxk1Z/nCmlil8Yz
         HUPXsF7FHXCjEzz8QQXCmoTPWBF9gwpSZ02lRp2U+DhKOLvwoRcavd2bAUgTKfQD9pz0
         OEzG+jHLZRKYate6oCe9nXpZ7FwLkN6JlZV8iVvYMTytMIn2b1v3y+87nj61AlhtgqLL
         INbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcuaD/ezs2n/PqwAOz53swjc6X25mcLFVrNyUH+7DcPIxGt3wUhv2Q4sJn0Gkwa1fh+Otrb4871fpfrhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAH/K9DfLT11nJ/LqTMjQVS/NBdVbK5FZ6v0mfBM1mTdrKUuoS
	kc64c3Mqttyp2lfIeQ3CZlTk/SSYTpVxZDnLSJiepQS5uOFSyFZ34e8HljZv
X-Google-Smtp-Source: AGHT+IGyLvA/M/eDfvljz1Khv18PSE94rORTfee5YeONmALb1+/6RcYou5Drnqobfahx+stsN964bQ==
X-Received: by 2002:a05:6512:e98:b0:539:e67e:7dbf with SMTP id 2adb3069b0e04-53b8903fb19mr106619e87.61.1730218391974;
        Tue, 29 Oct 2024 09:13:11 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f028f36sm482611866b.63.2024.10.29.09.13.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:13:11 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso841572866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPKYpVDD7HmEJc3Pt8sh18ambJU3BDtXIntA+0Z5LeVBO/kcBbwN0hJKOGALqqePsxkWlhL4kJ095XfIY=@vger.kernel.org
X-Received: by 2002:a17:906:dc91:b0:a9a:4f78:c3 with SMTP id
 a640c23a62f3a-a9e3a5a0da3mr31773966b.21.1730218391620; Tue, 29 Oct 2024
 09:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029160609.13725-1-marc.c.dionne@gmail.com>
In-Reply-To: <20241029160609.13725-1-marc.c.dionne@gmail.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 29 Oct 2024 13:12:59 -0300
X-Gmail-Original-Message-ID: <CAB9dFduUf_3N-9=t3O6ePxanjwPiqdQmgKR6O8VoF5BmPG_b4Q@mail.gmail.com>
Message-ID: <CAB9dFduUf_3N-9=t3O6ePxanjwPiqdQmgKR6O8VoF5BmPG_b4Q@mail.gmail.com>
Subject: Re: [PATCH] tools/mm: Fix slabinfo crash when MAX_SLABS is exceeded
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:06=E2=80=AFPM Marc Dionne <marc.c.dionne@gmail.co=
m> wrote:
>
> From: Marc Dionne <marc.dionne@auristor.com>
>
> The number of slabs can easily exceed the hard coded MAX_SLABS in the
> slabinfo tool, causing it to overwrite memory and crash.
>
> Increase the value of MAX_SLABS, and check if that has been exceeded for
> each new slab, instead of at the end when it's already too late.  Also
> move the check for MAX_ALIASES into the loop body.
>
> Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
> ---
>  tools/mm/slabinfo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
> index cfaeaea71042..2c9c86d677ed 100644
> --- a/tools/mm/slabinfo.c
> +++ b/tools/mm/slabinfo.c
> @@ -21,7 +21,7 @@
>  #include <regex.h>
>  #include <errno.h>
>
> -#define MAX_SLABS 500
> +#define MAX_SLABS 1000
>  #define MAX_ALIASES 500
>  #define MAX_NODES 1024
>
> @@ -1240,6 +1240,8 @@ static void read_slab_dir(void)
>                                 p--;
>                         alias->ref =3D strdup(p);
>                         alias++;
> +                       if (aliases > MAX_ALIASES)

This is not quite right, needs to be alias - aliasinfo.  Will send a V2.

> +                               fatal("Too many aliases\n");
>                         break;
>                    case DT_DIR:
>                         if (chdir(de->d_name))
> @@ -1301,6 +1303,8 @@ static void read_slab_dir(void)
>                         if (slab->name[0] =3D=3D ':')
>                                 alias_targets++;
>                         slab++;
> +                       if (slab - slabinfo > MAX_SLABS)
> +                               fatal("Too many slabs\n");
>                         break;
>                    default :
>                         fatal("Unknown file type %lx\n", de->d_type);
> @@ -1310,10 +1314,6 @@ static void read_slab_dir(void)
>         slabs =3D slab - slabinfo;
>         actual_slabs =3D slabs;
>         aliases =3D alias - aliasinfo;
> -       if (slabs > MAX_SLABS)
> -               fatal("Too many slabs\n");
> -       if (aliases > MAX_ALIASES)
> -               fatal("Too many aliases\n");
>  }
>
>  static void output_slabs(void)
> --
> 2.47.0
>

