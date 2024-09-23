Return-Path: <linux-kernel+bounces-335919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2E97EC92
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA661F2216C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066519C57D;
	Mon, 23 Sep 2024 13:47:17 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E8745F4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099236; cv=none; b=tEVE9GBF5GX85azFLdiiS8mhx5wulukYAx7UmRDmNV8nmhaYT9H2bOeCgI5dGWO4X7RKtebDDpUqBmQ4QQBvYlemB2yerWH9D/0no7Dpe3ndk0zNlto0cXRdGf0Rbo2YqJ9PUwR+ax5CQMDRiPLYO70O3OtHrQAUy7NgQefln+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099236; c=relaxed/simple;
	bh=D9Hi7rR16B5H7uuf+DnDWQKz3GUBIKsunz0gVz//WPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1lz4GVGmlguWNORN83id7adJxo4jvFO7a1p/aDn1trXy5+yeybaTj0JC9nT1+jqQiERO+FS03ZmlozBbYnFhs2BF1qh8VvQIFbHQkY97yIhUVHgxjTw1n+oP1dWrmpAXykEk5tcJWHiACYNmSXTjROqe4PETbEz5in3GPEsOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6da395fb97aso31368017b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727099233; x=1727704033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxBzN9kCmUuaEuwFMHnCTnsJ7u+wfKBwx0KriTzLD4g=;
        b=mozBwdGl+2E7HfSS1EI4rNaWDF7UpT9Rf88ABPa7ZTYvLy2iyyToq5xTwbv3dYZPUG
         h+p5kLUVFFZ/0mLtOU+50LubiUAFgFLVTSqaLDldVRMprnIF4o5C9CzgjkAMZy1UDSzT
         5zizv8eWn8H03F8TWi48bNqSJeNPzdxZY8tvutC6zNYcgtXbjOMlqinQQ40Doc9sLEJL
         n1O7w3XpaoMPczzQPmwb2LTTOtx1aR6vIfi1mIgLCEE1h5jKzHOJacxIBTuC03HqI9Cf
         WfKna4x6/nzVjegQx2yN5DHvWAMiXBkcvoJQAbd5qaz/MibbI7ffs8Q7urxk4KEZyix7
         H6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKS62BdJrnPrQbHV6C8AiKyyhn8ajqzGC7f9wEq0ydYwzyKC15fAgLR2yTjBTDTDyCSFHlrP8jZqDMaf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLWBp72LbqknEUhdZZvSDRbv5e2DiUmm6H5ePQ9hcDX0gDmmp
	3ByFrIo77SftD9zxketVNZxsDtSTYA8NgX16bkTdEWAdRDrhZMPoPOV5gfdT
X-Google-Smtp-Source: AGHT+IEji1QDOYsOfh1bTQpAjc7eaeuGkooqP8ftcN7Z7Flsrk8LOuNaetsYaRyK+2wTGCMgpZJPQg==
X-Received: by 2002:a05:690c:3612:b0:6dd:eb45:cf11 with SMTP id 00721157ae682-6dfef01c08dmr91125707b3.43.1727099233387;
        Mon, 23 Sep 2024 06:47:13 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2ee789dsm34268337b3.109.2024.09.23.06.47.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 06:47:13 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6dbb24ee2ebso36814607b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:47:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc5FhrwdBoaaqy2jXdm/StT3Q7Urs3nr++9PLZyEog2Tv7jtsIxq7vUHJSOjWbcLEtTacuQzzmsIfaEgg=@vger.kernel.org
X-Received: by 2002:a05:690c:48c1:b0:6af:eaaf:2527 with SMTP id
 00721157ae682-6dfeed87f8cmr96365137b3.18.1727099232718; Mon, 23 Sep 2024
 06:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922225041.603186-1-linux@roeck-us.net> <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
In-Reply-To: <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Sep 2024 15:47:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
Message-ID: <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Mon, Sep 23, 2024 at 3:39=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> Interesting that you get that to boot. The q800 machine crashes for me
> when trying to boot it in qemu with the latest upstream kernel, in functi=
on
> __pte_offset_map_lock(). It bisects to commit 394290cba966 ("mm: turn
> USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options").
> Reverting that patch fixes the crash for me. I guess you are not seeing t=
hat ?

I never used qemu -M q800.
I have just verified that -M virt boots fine?

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

