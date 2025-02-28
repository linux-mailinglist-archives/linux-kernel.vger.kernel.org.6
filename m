Return-Path: <linux-kernel+bounces-537683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AB1A48F11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F93B3E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E879A16ABC6;
	Fri, 28 Feb 2025 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba72oidr"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1823276D37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712953; cv=none; b=GkRKTFtsiYMdTOhykFPWyWMCwO7XZVazPtLuGmw/TqwBjZOzoDZgH8qMINkVBzL86vjODA4VfeYORxFiicCYoZLapdmadnx79n8r77Xjv2wsbnL0mfde2MKvAu1CeOVR90tkZIGLSfJXHbHhwwTq2EWBk1Fr9/8vmo2cLr2XLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712953; c=relaxed/simple;
	bh=or4FRvgPVRYEHVUoqisaxKTAF5oCe+382QEw9NJcR1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZPWhnB5CMO7NRSVTCoY51B81zNNei8HNXVU62liojE79kpifV1wHDKoIwB6XGk1pn3mmcsf27KeumBppjFy94f0FwC3MOPFO3+A+5LbP4bH/W9U3BbNtj/2J6Z7FcbaZDzM2QXVOk6M1t4VBVQpW8ueIf4sOpP+0KE86E3SZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba72oidr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e89bce647fso11133536d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740712950; x=1741317750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaUqXKAuExzL0QlcVz9XzJqgqFGdCUiD2l1s6G21WGw=;
        b=ba72oidrc2QM6D6o9no08nVowgROCodLyEQrCF/oHGDrq/CEbyschETw+nerOI5yOU
         BW9K0a02eK0Nk75QUJyIaUL2pSVYCv/Z/fk+v+b2+byJcWx69a5ZZyZdQ4pZaRciQF3Y
         J6OB3Z+yDC6IwP4Yu1iKW1wbJAOnXocOieMX7/AQeH7mr/osA7l3EieQzsPT36yuzU5Z
         h97ybOwg3wTXqRFNxj0nLxoxszgJXwOhKe1xKHW6Xk5nL0SsFBJud2shyKIqGlR3rT2U
         IkixE4O7P1c0nOkG+vIKXdVJ8BzK7mv7pVcPUzbwb9QXwy64EhxhGNNLkKPaKxfCE+Up
         z7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740712950; x=1741317750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaUqXKAuExzL0QlcVz9XzJqgqFGdCUiD2l1s6G21WGw=;
        b=Kj1+NyDmVem3BMyE51t+p79huMlI3WaNTtwu7yAQBqD4JnMTpyvOLFdwK/Y4te0noH
         r17I88Big/3w9WUE5ryMULZJ0YVhgxN1yZ/st8Jobwl1mfTpzIv5KgDMHXT77tDb2e5l
         /63lzUTBFTc3UUoERz3fbVNnCblxhODaAyEiiC0SaTgmyhkjrZmJKqubCnMTfMjXnMhB
         A35W1ALwoFQFe4wOTnoDpaqGPLVKqF7cZBFtIlV/bpGaIyfvKDKNdm1elVX85yLvSaBu
         P5mWldg1tdx9y9G7c4D30PDSp4o24GxzlP7cuDpmnfhZb2N//veQOMqIr1VNL1FIiFuR
         jvGA==
X-Forwarded-Encrypted: i=1; AJvYcCX61/ZW4SP3Px9SQf+p2i8SMNIF+rBfv0zSias4GWeTLjFoFMcX9E+RYrQzJ89JsX5tvjkQI2Swl84WV94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjELp2lBalE8esfNntKzJt1jZ4z0VIjNy5nEmEgHghG1Fbn62X
	L+9Vn0MOsA2sqXI+tZ36BzYZfz0Y1PzBAJh1vY0wy4bYAvXF+X+PBakL3z5E67ILLoKUL+Bu7MH
	Zc/uBv3RMCh1S1+lYlhErSAXvcck=
X-Gm-Gg: ASbGncsCKTy81YslSzQQoesEkDJA6r3ojdk5rI4qeO3lURTlQSx8P9YS4e13RzTJIZB
	mcYN7/amLiWroKQ4pkXxYR4Yj1OM9m33xvA2m5HkL5/XREeO7S4mNfeZMURti1s14BZ/mNC/dDe
	+i05TUNYC0
X-Google-Smtp-Source: AGHT+IFpEnuTt48F0MQPr5AYdwDVW0ocvrFn7oJ/BfjCvZpWas4vF+WOCAnlj+D5GOaTECzeYCYh66kuuw5e0fFtud0=
X-Received: by 2002:a05:6214:d85:b0:6e6:6520:1913 with SMTP id
 6a1803df08f44-6e8a0cc793amr29070046d6.19.1740712950581; Thu, 27 Feb 2025
 19:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
 <20250227155431.2534325-1-joshua.hahnjy@gmail.com> <20250227161934.GA115948@cmpxchg.org>
In-Reply-To: <20250227161934.GA115948@cmpxchg.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Feb 2025 11:21:54 +0800
X-Gm-Features: AQ5f1JrcDmVjmueHs_T2zF4C0hUbM0cM7wPje4JT3aHJYmA6yWHwUzz1tlFLNsM
Message-ID: <CALOAHbAbiAFo8rMvPCet2ybgTM0DFbKOeZayz5bmTJ6KTG6naQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory
 swapping should be prohibited during the global reclaim process
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, ying chen <yc1082463@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:19=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> Hello,
>
> On Thu, Feb 27, 2025 at 07:54:27AM -0800, Joshua Hahn wrote:
> > On Thu, 27 Feb 2025 22:34:51 +0800 ying chen <yc1082463@gmail.com> wrot=
e:
>
> > Previously, when the system is under a lot of memory pressure and is
> > facing OOMs, global reclaim can create space for the system and prevent
> > going out of memory by swapping, even when swappiness is 0. If this pat=
ch
> > removes that check, it would mean that global reclaim can no longer
> > "bypass" the swappiness =3D=3D 0 condition.
> >
> > I am also CCing Johannes, who is the original author of this section [1=
],
> > who clarified in the patch that swappiness =3D=3D 0 has different meani=
ngs for
> > global reclaim and memory cgroup reclaim.
>
> Yes. It's been the behavior for decades that swappiness is merely a
> preference, and that the VM *will* swap to avert OOM. You would break
> users making this change.

Hello Johannes,

How about introducing a new value, vm.swappiness=3D-1, to disable
swapping for global reclaim?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..4c22352c331c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2387,13 +2387,19 @@ static void get_scan_count(struct lruvec
*lruvec, struct scan_control *sc,
        }

        /*
-        * Global reclaim will swap to prevent OOM even with no
-        * swappiness, but memcg users want to use this knob to
-        * disable swapping for individual groups completely when
-        * using the memory controller's swap limit feature would be
-        * too expensive.
+        * swappiness > 0:
+        *   Swapping is enabled for both global reclaim and memcg reclaim.
+        *
+        * swappiness =3D 0:
+        *   Swapping is completely disabled for individual groups when usi=
ng
+        *   the memory controller's swap limit feature would be too costly=
.
+        *
+        * swappiness =3D -1:
+        *   Swapping is disabled for both global reclaim and memcg reclaim=
.
+        *   This is useful when you want to enable swapping for certain
+        *   memory cgroups while disabling it for others.
         */
-       if (cgroup_reclaim(sc) && !swappiness) {
+       if ((cgroup_reclaim(sc) && !swappiness) || swappiness =3D=3D -1)
                scan_balance =3D SCAN_FILE;
                goto out;
        }


Other parts of the code will also need to be updated to accommodate
this new swappiness value.

>
> If you want to hard-exempt cgroups, set memory.swap.max=3D0.

This does not apply to the root memcg.

>
> [ Yes, it's inconsistent. But it's really cgroup_reclaim() that is the
>   oddball in this. Also for historical reasons... ]
>
> > > when the vm.swappiness is set to 0, global reclaim should also refrai=
n
> > > from memory swapping, just like these cgroups.
> > >
> > > Signed-off-by: yc1082463 <yc1082463@gmail.com>
>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
>

--=20
Regards
Yafang

