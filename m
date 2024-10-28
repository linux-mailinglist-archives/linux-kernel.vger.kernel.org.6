Return-Path: <linux-kernel+bounces-385606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8611D9B394A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E62828A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C956B1DFD91;
	Mon, 28 Oct 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kjZ0dRzE"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CB1DF972
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140702; cv=none; b=UgVCbhSa5C/JhjW8dGtQjv9pEoLD4gXBI9LYkvQbq9+vXYUQioTy54CL3PGlNRmtQ+Yjzv5DcUFXPG6c1ToTPg4ndR7rhmB/cqrev8PU4crnCrrRFRVtTtC8v2UPSwCzS+x4lk6SfhzI7LkwFS1RPvFiQQa6p96amzuPZoWsOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140702; c=relaxed/simple;
	bh=/g1h6qcI2CBnGpC4qMEsB76ncQV5KUzo21jMr3yqENA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klugKkz+iu4XJROV0sTovtM1rsgeHVnl5MKO5PQWUylzz+FMoICThWWOWk4YKfqehdhynerGOu1vUVRfXqpZPfQm9/dxv8lyME3BaYmI/cQydCsd/swlen5Ep2VxEjgLWc1NhQEuhUf2S6G8ia/cPM/aMMZDyiG8wj7s0BeZURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kjZ0dRzE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so46482981fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730140697; x=1730745497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9XpyBz6UP7eivCbV0TPdXnBGJBN0yhi9aPPtJEQzBM=;
        b=kjZ0dRzEmSsF3tCeJqtjWox0MCTg7TddmFGqFAX7X+EIFchFm3JXswwk9XbJSoOxZ7
         fT+xrVUnJXMVHei5TZez25MoTmjgGloNt7zXEBEOxDQ3U0Phmq/UKTLqSGaonbbc6WJW
         +59YpdSP7/HZfttbz0DM1NUqLiHCEhUwcA9TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140697; x=1730745497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9XpyBz6UP7eivCbV0TPdXnBGJBN0yhi9aPPtJEQzBM=;
        b=Imq5FrrpNAPSJxVW54KlKEaNPBk/q15+SbmYwIUedhwwK8IcVUT9xkl2k61x/Y9ZPP
         jbstftD3bUXBMHrhp0LTY+HXFamiauXSvHyN+DZGHVosQiPUR+oaYPTgN7eeJ+2aYPSh
         TgWXP1LPqEr+tXcPuog9cISFZ/ydF+1vOq1nLfvJZpPvHB2GEnafKNyalMFCSi4GGGHX
         gN4XMFf9CF4bAE54vjrNMuCQZWWypyWsH9GuDllzASosN+WUhbt9oFjzhf61aCs8fZL0
         OpjSd9UKTSK00Cz/0zg2WGnlBtwNbOdgqB5u/AIeA8Nh9E4aXZbx0K20KMSWbF9O6MAJ
         s+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXzy44lrtU0SMCFZlYZ9Y/SQyCU6YQ9sJsl8z8C039msITDtQnm76wdzMIB3b9wX3J7vLLFgg3ta2KQwbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBG66SdQnuPRXmG9HcrIuXCFt6KFQxcxHL0FefUR7OarGf+Z6
	lGVjJIzm9GWP/iwtDC8q8V3/mukiwrI/KCrpo79Uh6vlXxxUj+TRrOjOQTP2yeoSmsBp2SNLXXr
	s7A==
X-Google-Smtp-Source: AGHT+IFhbDsStl1njFSPNoo75Iyi4N32kDaGiiMLhujtUcuDI/+iar6pKmr/Kw/u38NYKlWXFRAGEw==
X-Received: by 2002:a05:6512:3ba3:b0:536:a564:fd48 with SMTP id 2adb3069b0e04-53b348c15a8mr4356397e87.3.1730140696846;
        Mon, 28 Oct 2024 11:38:16 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1eba66sm1138298e87.280.2024.10.28.11.38.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:38:15 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso43911101fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:38:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDCt86b+b6kOVjMGPbFCVA3exz+jpkhqwQVa/YJf8LQrehACaTtxkN9zxRP2IwipH/wrGFwK1gD+nJ64I=@vger.kernel.org
X-Received: by 2002:a2e:bc09:0:b0:2fa:cf5b:1e8e with SMTP id
 38308e7fff4ca-2fcbdf62123mr39763791fa.2.1730140695498; Mon, 28 Oct 2024
 11:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027204729.GA907155@lichtman.org>
In-Reply-To: <20241027204729.GA907155@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 11:38:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XP3WueSj9reLqsDm3-i3K0LMX7SJcf_Z=8E=3rD7E81g@mail.gmail.com>
Message-ID: <CAD=FV=XP3WueSj9reLqsDm3-i3K0LMX7SJcf_Z=8E=3rD7E81g@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix breakpoint enable to be silent if already enabled
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 27, 2024 at 1:47=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Fix the breakpoint enable command (be) to a logic that is inline with the
> breakpoint disable command (bd) in which if the breakpoint is already in
> an enabled state, do not print the message of enabled again to the user.
>
> Also a small nit fix of the new line in a separate print.
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
>
> ---
>  kernel/debug/kdb/kdb_bp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I don't ever use these commands (if I'm setting breakpoints them I'm
using kgdb, not kdb), but this seems OK to me in general. I'm a little
curious why you don't also make the "breakpoint clear" command
consistent.

-Doug

