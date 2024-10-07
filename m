Return-Path: <linux-kernel+bounces-352922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82267992636
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F49281C9E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DE717DFE9;
	Mon,  7 Oct 2024 07:42:33 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FB17B4E9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728286953; cv=none; b=Njq7BkNSW6aUC0MOUsUmp3xXgpngeWIbpFuDmXRayXvf9ZbvqawxH2ZapJ7axKrt65m6GPvI2PtfCmXzhxo+tn/S38/YyP6xaT0rU4uHm7PvkBJoJORgbmOuCFB+ysvh2TjeD8VaLFopaHiU3LYJrZR7p4V0N/938LPExh1PXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728286953; c=relaxed/simple;
	bh=rJrL9Tz23EK5BD2voTjI4jO8k31YKDC8EWha+hhRIFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dOVJm0BXRVI8CLDb1vpuaNOhrvshoexBVIhcxgVx4mehw/KjBvxklGl5szP63dgVxivpg8MmWUD/xV5uvF13Jdl8D89bA5jTsfIoUIDP52mljM3U0PeiJ+t5rZh5Ra7ogm3IPPfpatijoq9hCvD3GXyB/UWyJJUNWZPDzrKduQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e2e427b07dso8590067b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728286950; x=1728891750;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgPOl/0kTe+u/aiEXHRLAG+cVZX192T+BdDVS80oFS0=;
        b=b2NUbrMKInKfqlxN2ZPi2Q7mokBwmM9cr4i+Iqs7CqY1fVki2x3JX8nqyoX6C85+dT
         D3PhjAyrMoFvg4pSv6/Li6JjbfexwywvZp/oLemnnG6YBPCzQJtPG75Or45d+V45/+NT
         ywlFLcFp0pJFM3eF6+tuFkuLiDb4AvZmer86rSoIkhe5XIdfQ7nPgtUQHWMA+Hs/drFG
         DM2ecxBM6nhqYsMDSU78toBVpPkeHe9yivv9adeaUG8S6SUy37oLp0wIBZZ9zmPHdNJk
         LrDBHQOsIo+rGhdSHPPURTwqAk//GIjYM6Gx7NcxpmZp7RE63V/2Lo0kIt0sEziQwDUX
         flMg==
X-Gm-Message-State: AOJu0Yy6+fx7W76CTuOTMULNaQgn95zXVCxHhiFXEsTE4dDTvffRYdGs
	Wv75WlWSw7EQANPeGQDciSTTlpqL/HxLRBeIvshh/I/4ChQvs8etJtlH32Ok
X-Google-Smtp-Source: AGHT+IEWG5jqWmZaapNLaiGD0NdKJS2bOEDkhBhX7HiQM4Pft/+CA/EnHOPvPlBslvRO+FOVQsvQbQ==
X-Received: by 2002:a05:690c:2e8c:b0:6d4:4a0c:fcf0 with SMTP id 00721157ae682-6e2c723373dmr60173697b3.20.1728286950616;
        Mon, 07 Oct 2024 00:42:30 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d926d8a0sm9481117b3.28.2024.10.07.00.42.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:42:30 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e427b07dso8589967b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:42:30 -0700 (PDT)
X-Received: by 2002:a05:690c:6d0e:b0:6dd:fb47:2184 with SMTP id
 00721157ae682-6e2c7017679mr92402937b3.13.1728286950020; Mon, 07 Oct 2024
 00:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
 <20241007065437.1842113-1-geert@linux-m68k.org>
In-Reply-To: <20241007065437.1842113-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 09:42:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKz_yO6k-vxaOvxP9hq+jpE3v2nc=x8o9Fepzm6faMNg@mail.gmail.com>
Message-ID: <CAMuHMdVKz_yO6k-vxaOvxP9hq+jpE3v2nc=x8o9Fepzm6faMNg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.12-rc2
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:54=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> JFYI, when comparing v6.12-rc2[1] to v6.12-rc1[3], the summaries are:
>   - build errors: +1/-11

+ {standard input}: Error: pcrel too far: 1060, 1061, 1059 =3D> 1059,
1061, 1397, 1060

SH gcc ICE crickets.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8cf0b93919e13d1=
e8d4466eb4080a4c4d9d66d7b/ (all 131 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9852d85ec9d492e=
bef56dc5f229416c925758edc/ (all 131 configs)

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

