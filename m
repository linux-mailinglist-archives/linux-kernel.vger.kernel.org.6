Return-Path: <linux-kernel+bounces-258362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C19386CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 02:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839BF281206
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908484A31;
	Mon, 22 Jul 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JJ/sTkSn"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFD23AD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721607320; cv=none; b=XoV5zOxlZhJzpKKzoIrVfHPkFATSvxZbNgh/VvGujufamAYIqUGbFWVI6gF674+IZ17zAV7MiXVrj6tCdO2n1RKFchUepR79EFtKTw4mw83IuiBzUc8WP83vJCHdN/4srUOzI9O98pmAJxeAN6+GU2nwYSrgUZZdfLaM9JK7NTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721607320; c=relaxed/simple;
	bh=4Lbvqiw93G2zHnDDYZ8Omb+j3DFInAVl4LQ2gZSThOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR2WFZW81PYep8p3/fpQjE5iQsDN6K365FYcaJJGU1vjkzSWkBbaVgSuplQk5Cp0760o/LNf+4NtVjq2y8GVWxuXB1aMcNxLgaqNTsZq7GuBQP70Azap1hmVThndE0Q5Q/i0/D5o66BbTcOCT+7PG5aq4UvFHOP/R1vmn2dTDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JJ/sTkSn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a47e2179dso141735066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721607317; x=1722212117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk+ZewaFQX4J1b598U+n7tTY7Ck12eH0e7NaScJUzQE=;
        b=JJ/sTkSnj4dWqLFQWOqk+S24G6i3Z6RGXAQc6AFTUwgfBjsZ74NkM9O0Ze7xG4TlI7
         B45ifVecEO+TnTb8QmTUX1vCRZRnODYTxCs2ghXT+mVVOr0hhy+3PeBNUamr19YV8EPe
         eYG9mtMgJoCXUGCd4xR5LkT2IGs90U4jaA/gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721607317; x=1722212117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fk+ZewaFQX4J1b598U+n7tTY7Ck12eH0e7NaScJUzQE=;
        b=rofISwtckfIf5x1XS2qpsWKp6cRy0izhO4G4NPgjYW6uHRb34KA/THwIE+4fMQlaRB
         w6rT4UbeEuN9/xYS+R+sj5NUfBEvE7Ev4BqJkWUsZMUwKYwYJxfM7akokY8rP+Z6/GFG
         pLZIf8WnhO4WaIOUnMBZHhXrXGllRqqCFCQ+umcdV1N00Cg7q0bmRzbxJsVIaYeu9eu9
         Evh212t/zdJK9JRA0slAydcgKT/MnX9OgO/2Xx5aLegq+HjneiyDHguqBGyM1XIX16h/
         X0l5NfQWmz91DHfxtVcqk1K0cIGspCpBWJOMVgJiC64OYnK42TNm1fTo0mPEOHJnYf5P
         8RRw==
X-Forwarded-Encrypted: i=1; AJvYcCUeZuSds1zAGNW7obfEekbvX+EFHGpJyfCaOsN5RrUma4gOUOOqNEB73uVH826BKtIZ881BThjGAO5X3XOPHwezN6iSrooD6ClQl2UL
X-Gm-Message-State: AOJu0YwyIN9TrF+jIaRlzry8u9fT614pEqsUagO/EIPSe/Qy2SpZ0CRN
	vGtUkbFv8ND1KRHpTKS20pZkwArS0jEd5RUTUHAt7wlAm96x9hbZfOWx9Uzjg7k/6Gm4D4aW/Xc
	nxIM=
X-Google-Smtp-Source: AGHT+IFyu3+/xpS/AbQmyGmpRgssd80qHwVpc251oTyNfvk6CSxA2pC1TUHo1YC6G9FDeeb8JS2AOg==
X-Received: by 2002:a17:907:980d:b0:a77:bfca:da57 with SMTP id a640c23a62f3a-a7a4c445b67mr323008466b.44.1721607316976;
        Sun, 21 Jul 2024 17:15:16 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8c1ae1sm348325466b.109.2024.07.21.17.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 17:15:16 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7b237so2864083a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWFTd+0VHB7UiSeqwz9s9Gd7JeWoaTqUy7X4IhiK97LxLzv/MnQQiuRcSqntobNkUZDClD/EyXk/m/cIE84nUr/GOAY4mP6JQyxhni
X-Received: by 2002:a05:6402:5204:b0:58d:81ac:ea90 with SMTP id
 4fb4d7f45d1cf-5a47c2763damr2803143a12.38.1721607316164; Sun, 21 Jul 2024
 17:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721145415.fbeb01a853962ef91334f3d1@linux-foundation.org>
In-Reply-To: <20240721145415.fbeb01a853962ef91334f3d1@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jul 2024 17:14:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPuiT+qqWXYb04AssPqo8FYMpjE43OQR4y91wtqxoHdg@mail.gmail.com>
Message-ID: <CAHk-=wjPuiT+qqWXYb04AssPqo8FYMpjE43OQR4y91wtqxoHdg@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.11-rc1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jul 2024 at 14:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> - Is anyone reading this stuff?  If so, email me!

I do actually try to read the explanations..

However, I also do build testing, which seems to have been missing. Notably:

> Ho-Ren (Jack) Chuang (1):
>      memory tier: consolidate the initialization of memory tiers

causes

  WARNING: modpost: vmlinux: section mismatch in reference:
hmat_set_default_dram_perf+0xc (section: .text) -> default_dram_nodes
(section: .init.data)
  WARNING: modpost: vmlinux: section mismatch in reference:
hmat_set_default_dram_perf+0x6c (section: .text) -> default_dram_nodes
(section: .init.data)

and sure enough, default_dram_nodes() is an init section, and is
accessed from hmat_set_default_dram_perf().

I think the fix is to just mark hmat_set_default_dram_perf() as an
init function too. Testing that now.

                Linus

