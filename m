Return-Path: <linux-kernel+bounces-396317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056659BCB6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CB01F23A48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B71D31B5;
	Tue,  5 Nov 2024 11:16:20 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35ED192582
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805380; cv=none; b=tVVh9MlDGuvCXQldOUqiOsqEUTwPmYNSqcuMNWD5iv/DIznyBezHDurnmuJHbEJ+i6JpITGzqjyBNeDSZ/kOgM+DgL9PXe4EwNwq2e2PTnoAGgxxFWaNDKicVuYJTggujZt5xdjV+fdkuVWNsaeiZ78dpfFfJ97Qam1uCRlj22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805380; c=relaxed/simple;
	bh=RQPh1D947TKzLE1f4ASFKIoCc3le035rVvblBWeTovs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDn0QcAbSq7K4T2xTOoh5HsKcIo2cVvkC3mw0bqA8Hp+FfC9WLYfvx0KTUosJzJUjOL1brGtYVshRy5+iCJoxXAOBDOCgE20miePYtoW7/xhOJs2+W+JXqpA0r1+dD0GcNVjlkEPpswMNSvtH6dF3CCjL5GB6QAEpb0SHmNH+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e5cec98cceso42268617b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805377; x=1731410177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3/fy7sgqquY1ABbaxJy+CpHhoUy/FOlWc4sY7atYCE=;
        b=fg3I72M9RaO7lSXt2Ny+NRU/vIi+1tM7e9+IrGFiFm9ggxS9O/DH5/WKCewkVLp7Mz
         tMY67bvRTh/9Q/yQLprPdSV2NMQR08ZCxQF4cb+b5FQX0EMl9h2wPidc05nNjAgvRzWR
         8CLUk0gtl5BMV3evdxUhECfsFS+CrpxVHTFQLeRMXXWfByjY/GBlE9Emr9UbBylQI3w2
         sFESRTIb0Pj/0D9xESkOHZjLvwxQLgXhLFC/iJ3mitWT1KA3xW2ZnpYoaZvQXgD/LiNH
         9upXO9StcXSowngZgDzmNb5/yVneHInuSQDe6s5SDlRTBMVYxUYX07+Cx9q7TCFqBK/i
         JCTg==
X-Forwarded-Encrypted: i=1; AJvYcCXEmsSQ0fdL0zQbuLJLf3+RrckRZzoH8+INo3kLDfpIopbGD/M82FPgphwRW5JoyFF2rr+2+0RD91KN/QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUP21MUj5zxOcefWGRFZbLOAOgtbJi0nq2VF9fFlHP4RyyWFYI
	vxjEd5+IoA/zqPudzgc4rHvGaMPm/zn86Py2XTNx6QHVDn6uhBrHh2xIewte
X-Google-Smtp-Source: AGHT+IFkIySLjNHaFtUdTNFLE7TZyz+amms42YHUwWkeUe9MNMHN3SDKVUr6zlYSTqJvPEgxuZfgRw==
X-Received: by 2002:a05:690c:c8e:b0:6e3:2be1:a2dc with SMTP id 00721157ae682-6ea52374db0mr188647557b3.11.1730805377057;
        Tue, 05 Nov 2024 03:16:17 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c45c68sm21553667b3.96.2024.11.05.03.16.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:16:16 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e290554afb4so5324497276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:16:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqhmXae6sO/kNxSr8XMFSTqRmSukJzaGvNUUGq6jyLJaD/MIda0gGdqLMPWsl6t0nMNTJcsRCZaI8slro=@vger.kernel.org
X-Received: by 2002:a05:690c:3512:b0:6b3:a6ff:7676 with SMTP id
 00721157ae682-6ea523295b1mr189170117b3.3.1730805375773; Tue, 05 Nov 2024
 03:16:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030195638.22542-1-arnd@kernel.org> <20241030195638.22542-2-arnd@kernel.org>
In-Reply-To: <20241030195638.22542-2-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 12:16:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW1Z7QoZa4RtAMzQaM+WZ=JtrEGPpHvfuOb3YVm8m2K+w@mail.gmail.com>
Message-ID: <CAMuHMdW1Z7QoZa4RtAMzQaM+WZ=JtrEGPpHvfuOb3YVm8m2K+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: select 68020 as fallback for classic
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building without a CPU selected does not work.
>
> Change the Kconfig logic slightly to make sure we always pick
> 68020 if nothing else is enabled. There are still some
> intentional warnings for builds with all platforms disabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.13.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

