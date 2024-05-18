Return-Path: <linux-kernel+bounces-182976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52AA8C9263
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0901D1C209EC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979386A332;
	Sat, 18 May 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A2X89Yne"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7C26AFB
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716067176; cv=none; b=nkA9mArfFmkExU5fSmN0vEmz/33pvIKxwFzh7IjFrPpLxcBhOYOH8if7DziILOMN+muM9ZuwG3tc/i+9ak+UjYECCGpqlIUJfA1MECdKIvzUsDJEFApk5tzHC+r3Dx7iAVEc9/XN6HT1UcRIaRq6uReOTpxyEhLAEhUvSDEx1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716067176; c=relaxed/simple;
	bh=y4kdoI/Al9pfC5vOqP4j01zfH6Td4FBolYQ8ClWVsEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/OjaNQK0ZwSeIgGq3a8V6lbwIh0kBKvfMfrENyQTBu6Tmtb7ia/niNtDNEwxCKV1clC0E7xiYoIiq3T2fFYP3E5vHvy5VJOrTSOZuTqWwke5G7c37ccAAZtnsDXQcN3N5zZhHanomFF/9PPH0fozAgdjpvtq7nXOzZ76xAhmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A2X89Yne; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so10149415a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716067173; x=1716671973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqFGMDPEvV5FyIcRDEwYmBY9ZJrGM339WB0RNPHgt+w=;
        b=A2X89Ynev7BLmxGWTUvpG8PkNzfQHSAJ+KtXq52Yzdazjn8//DxKoSTVkr7XIunkeG
         oRNYw1JoEwg5+XY0TyjfiR36+NJIoP/VUJXUxOH8mtSefA1KOcnoRyLVjP4+CI3+x/Co
         iSsI/ilSwXhoKRChg9LCPey64Ik/faGt+rYmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716067173; x=1716671973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqFGMDPEvV5FyIcRDEwYmBY9ZJrGM339WB0RNPHgt+w=;
        b=ZuKKKD18eKmVoIvzcZY3xQonvsbFbyPtSldRWAvyjLINzmO6Tk1rCTL/EMT8np2Ska
         HbOwx3iLg+EnOxjZx5Zwtsn14JIdTkn7TmYyBXBpl/bE2vgsf/HFQ5XlXW9Jm1tlEQxd
         fRUyqE/rZ/MKLvnmvA4yiO478COh5iOyavtsk5G9FBJnbF9UJReZ0DzaWW1aseyjeTlD
         tOgUK2JBOdLMEWvV1VBOGc1y5HHWEszDirVBdPeDDOzTAW+2WXmycvA+4ZcWG9lQSJ/q
         zdvALqpvorGjWfco12lNGKW1Ap0ecFrRC2Eca4SAMVpQ/SdXWHYT9Fy5lyNVjzpIrSek
         fWKw==
X-Forwarded-Encrypted: i=1; AJvYcCWXvwG4r3x94/sjjOkNDlCeHZQvB0wBCbahcYeM07eBaT6F0fP6Zq+tPNdIew4UEZw/Dl2qOh82zC2IDTezwId1/nog+wY2vyh8VgJu
X-Gm-Message-State: AOJu0YwT5qfK52XbN2q42xgSo84xurcRG73/vcGJlu/ZunCeKHYWX+if
	ieQu+3PqT4BbrR/bBwNevvdchGXcvhhFwJKlRZgmRe0adEDQXin6HIjS+jA8oBsBZDWgvEmxcRW
	D0bTDpg==
X-Google-Smtp-Source: AGHT+IFa6l7gUBZRZQ48EmWORTn1AO/EGoLuuwNEVuX8/G79c/BCKc2qr9AsbLfrJYPvBd6wjq0U+g==
X-Received: by 2002:a50:9b42:0:b0:572:a172:be71 with SMTP id 4fb4d7f45d1cf-5752b4a305bmr2128978a12.14.1716067173010;
        Sat, 18 May 2024 14:19:33 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb73esm13325499a12.31.2024.05.18.14.19.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 14:19:32 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a609dd3fso785473866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:19:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmsVGQtXY+YPu3bMSIweqE8nUYvwwNANEe+p9XA6Cdv3r8AHOE3RPRXCYmDU7ZXvLNEDp2BJq3dbWRK5mRQK6K5lUHKCTU1RLGBgyU
X-Received: by 2002:a17:906:234b:b0:a59:cbcb:1cca with SMTP id
 a640c23a62f3a-a5d59cbf185mr211918166b.13.1716067171988; Sat, 18 May 2024
 14:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518044601.GA478319@mit.edu>
In-Reply-To: <20240518044601.GA478319@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 May 2024 14:19:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPpNkBikDhCVOciA_bs9SkHH7XakdT0DbknFyiR_4HTw@mail.gmail.com>
Message-ID: <CAHk-=wgPpNkBikDhCVOciA_bs9SkHH7XakdT0DbknFyiR_4HTw@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 updates for v6.10-rc1
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 21:46, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Note that there is a relatively merge conflict; the relatively simple
> resolution which I used when running regression tests is at the tag
> ext4_merge_resolution in the ext4 git repo,

Heh. That tag just points to the same commit you asked me to pull. I
think you may have tagged it before you actually committed your merge
resolution.

That said, the merge resolution looks trivial, so no big deal. When
people send me a suggested merge, I usually compare against it just
because it's cheap insurance, not because it's usually necessary.

But you may want to check that I actually did the same thing you did.

             Linus

