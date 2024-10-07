Return-Path: <linux-kernel+bounces-353610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108C8993043
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D731C22FDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40F1D54E9;
	Mon,  7 Oct 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AbQ3gka7"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E51D54E1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313207; cv=none; b=gp2NTV1dXoC+w5ix+M6RT4ydQW6vie07EA0yf+Fdszl9Evjvz3HCLSIkB9+S+WpfLVDKC3DSXIYLIK+wWtdS3iRIofnUYeY8MNVMGqktTeSupYj+HJSZ+gBj8pe2JiENtLTLx9W+fqjxMBs+E+KK6Jm1mwpxPad+cgjRsrgdGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313207; c=relaxed/simple;
	bh=Kmt9cHJm8WwS3XspxjzVmwcEHGHmVBkZJdu4NDC3smo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZh251Q8ywPQeQ/WmYCGQL26oRVMWDqHvQOuC13E/WzN4phn8eFZK9V0cjn+8gKD71+5LUPG4ekPa05nsLZEcI1+pi1VdT76DMiIRoMDWbmGDVTQEjEs0KwD01IZqrj4o0megFY7EsrncGb2smQKNv9Nq9B/AJonzb9zgF+cQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AbQ3gka7; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e5b7d54ff8so104534eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728313205; x=1728918005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0KwE80YUYePgxalt01KSjIBVcvG8O10aqSXbDz0ito=;
        b=AbQ3gka7A0McnDohcQXIxVybxx+mssk805CSxaQG/2kIvzyQ5qeAvfgVIVqdZR/2BT
         iYad8oSVhVrR8dO1v4CgjtHOcfPl8ejyJg82T0xm00wk/K9/b4wQPpAR+99AjIxlLxQj
         f7uFM2YLZzeUqCKYEQ7kxeuYcORG2iNqafPDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313205; x=1728918005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0KwE80YUYePgxalt01KSjIBVcvG8O10aqSXbDz0ito=;
        b=GEZO1dLv7Eg2QVPFZjOcKqwjQB74cbvDBqCWj+c3EAlTfVQOiRhfZcGfCSZMiX1HhS
         7TfHBqjzjm1f1oIVYWgaVC+x9dSP2ku5vdxha4J/eoayyL15R21Bj+G9yf54puZMzG66
         YEEajMs3cYhNvWHs++SM9jgb+opDLszX01FJ2v9H3CX7PFhvXhPlkqyD6d2j4KKKAfic
         8nzDIVWAIc3d1Xct5zvY8T1l2yIdpE7y2cwzuLMX9djrS+GDdVDu5xXN0ONCgXKkGhKm
         F05AZuazZ6FJTOicdUrft7WbmknG61cMQMnUYPgip4gbsthG1Sja+PpPwHVy9xJ7BjjD
         TnIA==
X-Forwarded-Encrypted: i=1; AJvYcCVGF4f8W8WGvyW97V1as5yYXQrmVWZsC/JMG5wmw+2mtvKva98EdDOL3/6OhKkKKDQUFZZJ7RlW/5TcIec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLkLMj1fxqQZ804UPy0y+hF4OAqiZYJSSdt7X3THJdwWKJbG2
	3tXiVwg7Q1J2t6itfOVcmNpoSjB+LLKMmSwdLaogRucWVEJyzODwobL66GkQuhgIfiF1dHB1Lga
	QSNpOHnsBEWB8qabe5GcGqok7ecSanUKnPL60
X-Google-Smtp-Source: AGHT+IEgxSO+or+LT/iiFA/sF2fonUe9w7Iegy6X1aayhSdUynY7mkN/5hXV/JGVKok0IKxa3fAcXXlLQMR9UOr4eLM=
X-Received: by 2002:a05:6870:1641:b0:27b:9f8b:277b with SMTP id
 586e51a60fabf-287c22d93a8mr1797632fac.14.1728313205390; Mon, 07 Oct 2024
 08:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <20241004163155.3493183-2-jeffxu@google.com>
 <20241005202025.GB24353@redhat.com>
In-Reply-To: <20241005202025.GB24353@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:00:00 -0700
Message-ID: <CABi2SkWNy16VmXrnPtmE7njb8UzLF=z9J+Ym9titbT8Gw6g0=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 1:21=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Sorry for the noise, forgot to mention...
>
> On 10/04, jeffxu@chromium.org wrote:
> >
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1535,6 +1535,15 @@
> >                       Permit 'security.evm' to be updated regardless of
> >                       current integrity status.
> >
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { never | always }
> > +                     Seal system mappings: vdso, vvar, sigpage, uprobe=
s,
> > +                     vsyscall.
> > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPIN=
GS_*
> > +                     - 'never':  never seal system mappings.
> > +                     - 'always': always seal system mappings.
> > +                     If not specified or invalid, default is the KCONF=
IG value.
>
> perhaps the documentation should also mention that this new parameter has
> no effect if CONFIG_64BIT=3Dn.
Good point, I will add that.

Thanks

>
> Oleg.
>

