Return-Path: <linux-kernel+bounces-312918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82396969DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383B21F230E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050C91C9877;
	Tue,  3 Sep 2024 12:35:35 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36E41B12F0;
	Tue,  3 Sep 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366934; cv=none; b=d0Ra6rMb1fhQ76k0kTlGTpZWAznNxPzyGx5QGC2kP9L/IQXDIE28zEGMAPtKGSEGu1EYM5PHfnRWHs3i6Ye3DiFJ6CmLUwSmRMq9ajfnHTedee47nw0qt3O+zqG4ZF8p5/PcAbusfr00aLJhvwt1Y65/Cu6zbKr3J5UOvq895YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366934; c=relaxed/simple;
	bh=pukqGh/nMdQYmxb7CPZWFPfGwfpTJMXvd81j+CMTfxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrKkkrLWfBRpRw8cLh3Wt4ITG08AgAsRGqmHm4pHTENpRdcjewnzi3uXbuoPcY5pJ8oiSMhEKp3iExikmFjjSxR7+Ao9a5F/8diHhc2uFG/l3gBJuBnT/cJpU/84Cky5jCBglTCtemw5k8CHWyATJXl74ZRtxOWetDx9d0M4SlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso4621725276.1;
        Tue, 03 Sep 2024 05:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725366928; x=1725971728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgoCHMHFNIt/XhiUpMbOZHv3vnXPL+Zu29fZEZr3HEE=;
        b=lMv24B6nw5GA7m/lHAtH7difgpAhuxaC304vkYr2w9iSCcSzFPtte0F+NVl8INrfkF
         ZIecd/3oedOYr/PmZCQKbx9cfIglD4wG/zswPkAB9plnp+XfXM/t3MEghzJijc8UIF88
         l2inJ8L56J9fqE8DD98m0592DdNbqhOJ1I+UIi5a6weHgQG3VX7bz60dkC89A7Tsdrvc
         RtSC19nMD+lpRndfqLlqN1MDpzhKu8R9U1Aga8xEH5XChv5r87aO3dD/dWv1jeFN1RhF
         Mp/JpiFmvDQ4JnUMVrM0T5n8iTeo50CE/i9PbxbSUdGv8TbPox23X/0btdoydL/MmcgX
         U1/w==
X-Forwarded-Encrypted: i=1; AJvYcCUBpOOeFqgNfelrMKGIjZnrae5DkiUJSkvvpIml5JxEkX9wqsfo4isWl7xDdnBuFCtrygaYKUmVRCjK@vger.kernel.org, AJvYcCWyBLHVim3qdMn80fgsWZbgKn0NjtpG9VBrC+3ZjnkXVwixnInzbkFc6LbtZbWYfjs5gggD9VtXox0mFA0Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8zVJ11/zSWHuWkhWtobTk99AA9IyCtlCvfH5+CH3sQZ2VsTV
	lUL7PO5GXeEdvnamHJIRCDKjtBQgyZ1pFD+shgTXvRvz3rZhPymJaw5t9k1M
X-Google-Smtp-Source: AGHT+IFqdO4qT6pAN7x3MNZI1r6KD88CJa4+82jbSISdXKPKCouoa+dB5M30qmWLoByklNRMll8YRA==
X-Received: by 2002:a05:690c:ec6:b0:6d5:ccc5:e2f4 with SMTP id 00721157ae682-6d5ccc5eademr80201437b3.2.1725366928473;
        Tue, 03 Sep 2024 05:35:28 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d4988bdbbcsm14650077b3.12.2024.09.03.05.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 05:35:28 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso4621661276.1;
        Tue, 03 Sep 2024 05:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVd2vjor8pjXacJQGeOw3Au8SS3jnmRutdpAkc2wZTIt/rY+i+4CnyWqE/PpsoMuqdwqMlStA8ujH6n@vger.kernel.org, AJvYcCXfKkFoliviKZUvVQly/EJCCT+mk35sdqg7KI84I0mpDQMJaIe9aQMCzgMF/24mTH3fRyMfiC+lB1Vwf2EA@vger.kernel.org
X-Received: by 2002:a05:690c:668e:b0:6d8:a9a1:7cac with SMTP id
 00721157ae682-6d8a9a17ef4mr49319937b3.12.1725366927206; Tue, 03 Sep 2024
 05:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903104608.184988-1-d.dolenko@metrotek.ru>
In-Reply-To: <20240903104608.184988-1-d.dolenko@metrotek.ru>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Sep 2024 14:35:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuJFRrHAR8Q+HkXbaf29TaUFgvxYY4Ua9xQ7mGZoBsnQ@mail.gmail.com>
Message-ID: <CAMuHMdVuJFRrHAR8Q+HkXbaf29TaUFgvxYY4Ua9xQ7mGZoBsnQ@mail.gmail.com>
Subject: Re: of: Status of DT-Overlay configfs patch
To: Dmitry Dolenko <d.dolenko@metrotek.ru>
Cc: pantelis.antoniou@gmail.com, nava.manne@xilinx.com, 
	radhey.shyam.pandey@xilinx.com, austin.zhang@intel.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, system@metrotek.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, Sep 3, 2024 at 12:46=E2=80=AFPM Dmitry Dolenko <d.dolenko@metrotek.=
ru> wrote:
> Is there any place where the status of patch "OF: DT-Overlay configfs
> interface" could be found?

I try to keep it up-to-date in [1].  In fact I have just pushed a
rebase to v6.11-rc5, to fix a merge conflict with a recent upstream
change.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.g=
it/commit/?h=3Dtopic/renesas-overlays

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

