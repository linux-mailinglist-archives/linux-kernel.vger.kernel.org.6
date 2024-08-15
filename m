Return-Path: <linux-kernel+bounces-288005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E40952FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B2C1F220F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01521A00CB;
	Thu, 15 Aug 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gN0cxHhm"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8418D627
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728957; cv=none; b=luI4YnpXQOjWAZCLG9s1mMktbO66EzAV9opGC1u28JZjnUQvJcqR6NhcESEXEp5M2093v4Q5ekx79/J4DSI7ReKRRulKuyno9ZIWbT/1976C0rQgwYQ8FxbZG7X3CLeNRX8K/dK4RXPNLEzBKmdCVLAodkbrn4m37gF0ewNmgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728957; c=relaxed/simple;
	bh=dPfoCiNBb3JXOxL1BjVezvPLuqyy87eRqnp20tLF5tc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owncN9tAloSVljY9fNmvzBWuktDq2R4W4HNsre73ETCwYD5HnzsUEDzGucrgNMf61TxyIQV94AMA138vN11gJ1RMgk0K3IeafnKrOAZCUaB2mcTeAxTQOeIpSUUiPiSz16Je0gWEsGfYhQ2I75L3h/vY4Wmr6HdhvIwxmdtfN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gN0cxHhm; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE7D53F429
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723728952;
	bh=Z5UFM6jCql770Z7anv34dNUzaqaODcHWZimSfHmsQlA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gN0cxHhmkLxlIvAvQnIC16SQv9chExEum1waAC3YwXoiMC4cfnN/H7IDS9V3CYuvC
	 ZPFdjQm//WfBonwR21c6yE2XuR9GV8/Kl/69b7deesyHjWYvnNuYL1RgHMjiuD2caH
	 x57Syn3NdT/29EiypY9JLmF8XWw47aXJX0De4M0w55JlvGbJ6rjs7PqXxJdSID9SpT
	 lIwG2SvuEzG02EFXftbZQP93RP9v09VNX5xT6Ca4VlOl10U04l9ogLrpnhNU41+Wmk
	 FYPvcUFbqPWFzAkvFq/pLBgY6DaBQIId0lxF8QbGyAt6EFHpDek1te7c0sAWgvEKeF
	 WB/YZkQXqgyYw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44ffb762db6so11490931cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723728952; x=1724333752;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5UFM6jCql770Z7anv34dNUzaqaODcHWZimSfHmsQlA=;
        b=sIwhKuCH3DfD3qajgGRQ3I/kzE9q0AFhAUNJNOywElAoq84MGJXmnipHU0fQTCBrsl
         cE40yWsdusJUXz6KpdKFgSj2SAjVUM2vx3BtATwwBu2J5rAyEva5+W+PfrkwCHWyq2eZ
         YyRiB1F7P/AIZVe4vRyDpmatkm9dNSn9avPHWNbhwV3WVml2nV6ByKr8f/AHaQZBCwXK
         2ov7M7bLHIId6QZ7qJDpOBf3dMdQyVROnxCS9c46/SYnVX6S+wRIS5AYIZd7kcLEeuAY
         +6uS69rNGVBsdklxklAJes4sDjfPwFJC1JZ19mKa6o8mzotpLbAD/p2SpYWJ4b94w8mQ
         Ipsw==
X-Forwarded-Encrypted: i=1; AJvYcCUHp7vyGH4737WFALbvnlfkW01XxJoICmeip4w7E/4ln7kSWKveEmPok3IHbKCVIN7H3c8Q5AcOO5/0a/g36A5Cy6mBbSEzJwbLmRfx
X-Gm-Message-State: AOJu0YzHcAoRYrIv1DYLgWVdjKNaIWSCz6TmjMPCz6ZrYAFejYKwyuwd
	0LuxYeqApGw+KdDfAlXggACbSKr0MZ6r64hW75ldbB1NgYP+kam9BeDWLZqj9zA26FWz+7n8Tcv
	US/cHAdoFxSpk4ioma1ZVc9fv4UvOwyPkh4E0dX6bVowSz2V+LlBqZbnJhQ9yQTR2WC6/6rhpqr
	qgubgIeB07HU+EODZcyWyH9TGx6Y8tmJpNY6NpBmmnsqe/VyHdjc8D
X-Received: by 2002:a05:622a:2486:b0:451:8d59:9c2b with SMTP id d75a77b69052e-4535baaaf2amr69274861cf.19.1723728951861;
        Thu, 15 Aug 2024 06:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqiC54ur7so/hBdoMSAGpHK9JEALQBpn2eQz5+W592+eOzqpSFskWCFTHKjQ66+ydxlIf9iWgPRpkKAp1k+eE=
X-Received: by 2002:a05:622a:2486:b0:451:8d59:9c2b with SMTP id
 d75a77b69052e-4535baaaf2amr69274601cf.19.1723728951484; Thu, 15 Aug 2024
 06:35:51 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Aug 2024 06:35:51 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <87plqalyd4.ffs@tglx>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx> <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx> <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com> <87plqalyd4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 15 Aug 2024 06:35:51 -0700
Message-ID: <CAJM55Z_R6MaOwxSrBwnT8-1ZvMuUjiwhT3CuwMLYVd2qoGG-Yg@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Thomas Gleixner <tglx@linutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 05:14, Emil Renner Berthing wrote:
> > Emil Renner Berthing wrote:
> >> 6.11-rc3 + these reverts:  https://termbin.com/q6wk
> >> 6.11-rc3 + Samuel's patch: https://termbin.com/7cgs
> >
> > I think this confirms what Charlie found here:
> > https://lore.kernel.org/linux-riscv/ZoydV7vad5JWIcZb@ghost/
>
> Yes. So the riscv timer is not working on this thing or it stops
> somehow.
>
> Can you apply the debug patch below and check whether you see the
> 'J: ....' output at all and if so whether it stops at some point.

No, I don't see the J: ... debug output anywhere:
https://termbin.com/3vez

/Emil

