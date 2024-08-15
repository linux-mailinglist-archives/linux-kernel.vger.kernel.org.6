Return-Path: <linux-kernel+bounces-288382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE97953979
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0F11F241A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD647F4A;
	Thu, 15 Aug 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="hI3N54C0"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD139FCE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744296; cv=none; b=JygapjbGgHouQdCSeCZutuX3tsiv4SPRnLXpZe55SIFgRQEGYM8dgN4/mwh64ti2eYRHlKfdH0lmnvZ41qHtm4TRgMuDgBSIQ8Zd2QSYgYURYS38A/RyJ/OKyDcfqig4yNAaxhNFGq7+njKKfY1ua9MyVM839U8+2MzPkYxuvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744296; c=relaxed/simple;
	bh=cHk85tyT4WA9zUGQ8DCybEejXHfLNg19pRozx9IMQK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaKlstsxRUl3aYpV7P9AQW2VqZv1UDxMRqrXzGQQmqjo1ZPsDGrcR+cE2GUeaf40tlqS4g6ySRktv3Y5ixODarHuncAAJtCyA7z05FzNNuzcdogk76UekWLn+ZyfwtCAHyqRRNb4ppp7HIyZgcmIuNbQGvMjqIXtzrzdVyf/r7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=hI3N54C0; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5af7ae388so1008537eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723744294; x=1724349094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHk85tyT4WA9zUGQ8DCybEejXHfLNg19pRozx9IMQK0=;
        b=hI3N54C0KurlNnc3QisRdvbz/EEoGZ75XRTv0GMJpQ+kHoszNHc720pazUi+ZINflW
         Zp4cfrNyWUzVazVL+QCcA4HSmAydMfxCakx8D6TMuDwqDX8Ds6N3Uh7M3uqt3wXsbx3Q
         fFunGZU4CZKsC06A5tp5gsov8T3tvOedBX4KtqRGsptr/95LQ2LLy5yi6yws1YYNYPcM
         DOTUfHghHdQgP01q5KRp0IUVHz57rn1WLctNrKPCddGpcSyq5YBd0VaiCLyU64LNuwR+
         /yWj2CL7SXHDLmLaBfwKiWLl7IBXjuW4PgFy9wlOYeyiy6JHiuJReUMJpp45cDNo5qZR
         bNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723744294; x=1724349094;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHk85tyT4WA9zUGQ8DCybEejXHfLNg19pRozx9IMQK0=;
        b=R4wcxNdLorjajfaCUS0sjK0bS2yhCxwUudAqKwE9nxBjnqCbYsjme7/pl1lICpsy+o
         qcZLkArblrBKmsqWKXhVBpvEnib2rOEJKPZG9j4Pn3D6FrpQyWfbBV2IBabxfEtf8wQf
         gFtZWIcbE1YktIl/jCU1OipM8wSR77j9fuQ1taxnN2hwzzI5qy8aj/pfVKvwkGnVZ5tr
         5PL2JPqykuucgpTdTf4z48nGhi4Tgfsq0jQrXT7+HciZKjYQYo4X7Z00kbQmq8hKrzZM
         hLVBHkrnui1tEb0erDiR9w5o+2VR7pFKPZwZQmsTHUSyVZ7SHM03aGMPAe3c05muKKLe
         mIug==
X-Forwarded-Encrypted: i=1; AJvYcCXAh3EswpOYtH8XD3NiVdZa+ipK6M6ibgRD+TduMzYNIFCv1JG26Slqf9DickvbdPiZhsi1k2/jHDwx2qMNeTqVj+kkNURFXlIMvkDG
X-Gm-Message-State: AOJu0YwzNB9Zi1qWIJmw/4MNKb3yZ7/INkDKjhs5enIYQn9DNsjJW8eZ
	xY239PJxizrgY7ckdaDCaXcMxcrxT1brilDYElf30OVizKJUNLZmqWVnPeRA/GlJK0cYv5ejAD+
	2gIsGQ0OLKdl5/4wIqruKtfjTQElANu6gGzT12w==
X-Google-Smtp-Source: AGHT+IG50L+pt6CMEi8/UvxulV9JQjtG8Tp+1SY2FYA7cK6hMg11Oau24F83MwbxIf/cYbxTOhn+EKgTCyilqSQtlLo=
X-Received: by 2002:a05:6870:9346:b0:261:900:b222 with SMTP id
 586e51a60fabf-26fff648042mr1529797fac.20.1723744294324; Thu, 15 Aug 2024
 10:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d0330f3-2ac0-4cd5-8075-7f1cbaf72a8e@heusel.eu>
In-Reply-To: <0d0330f3-2ac0-4cd5-8075-7f1cbaf72a8e@heusel.eu>
Reply-To: spender@grsecurity.net
From: Brad Spengler <spender@grsecurity.net>
Date: Thu, 15 Aug 2024 13:51:22 -0400
Message-ID: <CAKnqPui5XSBgxPA0Jh9UEv72aVr1uvFqoNeON6RB-YZUj+Fr=g@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] vmwgfx crashes with command buffer error
 after update
To: Christian Heusel <christian@heusel.eu>
Cc: Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Martin Krastev <martin.krastev@broadcom.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, dri-devel@lists.freedesktop.org, 
	rdkehn@gmail.com, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

> While we were still debugging the issue Brad (also CC'ed) messaged me
> that they were seeing similar failures in their ESXi based test
> pipelines except for one box that was running on legacy BIOS (so maybe
> that is relevant). They noticed this because they had set panic_on_warn.

Just to clarify, it was actually the inverse: all the legacy
BIOS-booting systems triggered the warning, and the UEFI one did not.

Thanks for the report!

-Brad

