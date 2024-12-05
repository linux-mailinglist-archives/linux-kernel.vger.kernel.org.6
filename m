Return-Path: <linux-kernel+bounces-432751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F79E4FC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B901680D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97681D4341;
	Thu,  5 Dec 2024 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Lw6zYR8U"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41B1D434D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387565; cv=none; b=df35Td8S8i3jWp9kw34su6uazhfPfmykVbSmCviAkfuGIpPY4IqSVi9bW/75RmW1dk0zedmvSMDGGr6mW8JNEtCYppGCGC8enJYEUYOYg4M1hSpRY+UDMEjF/1hSkXddUi2P/hDm1KlzHbHvuZ49O9PL/anum5q71Pk4HcWH1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387565; c=relaxed/simple;
	bh=EJPt+tqdGiqNz0PpQpFiRahH0cHhTtaiS3IKrYJT9bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgn12z9TBoEUXQNtAkvTpriYIJ/a111gslmHAUSFbej0IcCR4SfCapsxBYkMMIm0MUGt0XaA1dgh32Ph9P1zmMIrnRjN9ZOFCpnq3sBIh86XGC/ij8KcqtFN/80Sk8Q2JgeXHQXfxiGRlHn9TNS4z9tMVJ3uNpBzV/oasJdCVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Lw6zYR8U; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa55da18f89so90152266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733387561; x=1733992361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJPt+tqdGiqNz0PpQpFiRahH0cHhTtaiS3IKrYJT9bs=;
        b=Lw6zYR8U68nIgqAW60VowqgddjDSCaZ55oSvj67SHUBD553XkGx4FeFDutJjgnwADp
         cRaViBRSpDgTjL7VVC2OU0qykFVWFJtZjPLyCh6cXtFW/xuB9AFbSv+tZ6FeuUSL17N1
         +d2r+sF7MB8v1aDEhf1gQbzlLRN7R6/3rmGscaVHt7QRVPsCvuhOBcWupfvuGkNe5ZLt
         VdN/ixqm0gSyxCvQkmVAqUHvyJmb2Zop9EQgWYPqP/42TSVXQ2gCsa6wZn437z7yB+bx
         CmK9u0FZIMSoWMpGNpgwPjF/FX7zu5K08TQ6BPrjbgG359sulb9zenljQJyIu3QNFTJQ
         UiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387561; x=1733992361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJPt+tqdGiqNz0PpQpFiRahH0cHhTtaiS3IKrYJT9bs=;
        b=ULpf7JIY3u0w8BlIlPId6gNpLeSF8l/ul2vGSNroyrYIo+7uF/1khI/A6lshCl0wEX
         fLv7J2xpd/xM2P76iaCMB2OOmUmFUWx6WUuDEF75uQOoRNip8dArZMfG6GSEez3NcUnU
         ip4zRm8wV8R/bBsQ2jhgzwmXTAiMYIxJOUVDYbrN+PS+uuEdz3VoSYr/Lx9wpHVHzOuh
         ZfAxOl6et8Cifo5DCa/HpJ8q2oiaQkpP11dhc4az+v0gGQ1ZGSE4bGa7GLaesEtM7mwH
         TvuX+un/sXGk79bXQI43y1Sp6DW9wkYoYHEBSYWn0yCz4yXYhF3tQhET2QLpm8khayBU
         wcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOUO2sphO8Jjcg+q0Vr/PkXjrYDf/jr51WeAdASQt5nXdMW0Xy5iIvWAwuRCeMg38xxwYgFDi2CELFUPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI91VyFVReyOznLlt4ZJweZhNakFZPtRTsyN7PE/Ocd6uv1FnM
	PRue6GcUdcps4RtRuuXkB+6iTw82xeWhhBJew98FcER/pTqISbRvYLgvNmzMbS0PeWo48Y7OSUQ
	SOsz1R+92aZGLsCfVTbAqdmofCXNNAOqPTpOIGf75LYV3YvJgVkI=
X-Gm-Gg: ASbGncuXXUP4JNmqYQ/+OOZXPg3oHaYSh5MQ+WvVNgVK81+4e+T6G0zu1KNvXcH9zXE
	VC4mIXJ207/GurVMK97lmoyA1JK+WzPPvLlRMQ5TlbrpoXtO666yp0IS8BvSR
X-Google-Smtp-Source: AGHT+IEfOOIUAP+qzQLjr/PEbT9YYByWGvZ37kA/qsEDsa9dd02Ei0bVAjizMWSWGf9G5Brf6kG2rT73PAYZKr6E8eM=
X-Received: by 2002:a17:906:9c1:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-aa5f7f3c39cmr623289166b.55.1733387560655; Thu, 05 Dec 2024
 00:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com> <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
In-Reply-To: <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 09:32:29 +0100
Message-ID: <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 9:06=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > Pages are freed in `ceph_osdc_put_request`, trying to release them
> > this way will end badly.
>
> Is there anybody else who can explain this to me?
> I believe Alex is wrong and my patch is correct, but maybe I'm missing
> something.

It's been a week. Is there really nobody who understands this piece of
code? I believe I do understand it, but my understanding conflicts
with Alex's, and he's the expert (and I'm not).

