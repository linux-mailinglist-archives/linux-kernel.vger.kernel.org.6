Return-Path: <linux-kernel+bounces-287963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8792952E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B3280F58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187819B3DD;
	Thu, 15 Aug 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="VI9CdU9p"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE217DA63;
	Thu, 15 Aug 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726740; cv=none; b=aIK9SRC7ibn+OCCG5a4NCt99aRhCDazHen3i3MAO49w627Jwnho0Aw0/TTyLFj8clv4uEQ0MzcofR5SpU9rsriJY2dgY5wKfntaGVxITbh7swYg8sXOE5yi28N7IhEUXCGtR+6j9vMOTvu5SyanasWrnI1W1lKH984OOAuLkmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726740; c=relaxed/simple;
	bh=dYYl/zEU3YloE/8ql4/5xTV82V5JC5BtMXJrSGS5L1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMEjs6QPxAe72wcxwnS1pGlaDfydVftyHDvbiOlQhcLxHIQaay02ObU5oJ1cWDZIEqhZAvhYdSKpHnH6ufswmcRS+FXDtQE5blgMv0tleX7BEjQC6iA1Up8ZgYzAKz4AjLz3PfXB/tQusO2Wqd7SEa1swMYGwLrLLKfGSUE3zD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=VI9CdU9p; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 62C842E088A8;
	Thu, 15 Aug 2024 15:58:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1723726728;
	bh=dYYl/zEU3YloE/8ql4/5xTV82V5JC5BtMXJrSGS5L1Q=;
	h=Received:From:Subject:To;
	b=VI9CdU9pAAkAXeAkWkwWIx0Yz898UtfIC9f/Jse4xUKhwIdpgr6qqlR8YgEn8qeEs
	 igeFrEQNMThUWO0NWeyUJ2LEBogJ1RLy+X/HgVxRK7rdyYZ2uwG7IFRzqvk0D6FcFh
	 gvNdW7WDG2pNjtszmd/6hpHjYuc9iuYKKEYdx1is=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2ef7fef3ccfso10442711fa.3;
        Thu, 15 Aug 2024 05:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWjTGHRiTFuHyfQEK1XD6lUAxeWhMkDcaNdelcExPOPC7+QwDvqsaCTbpPUNZ8o2ozEXb4KXHQlvzheKrL2S+BaUYP+Pa1cydO6fSZ9/glBT/xIkZ8LkBlS3wzcXCDrnDbdXVdLLf57d3I=
X-Gm-Message-State: AOJu0YyFFNDFhwLca3/WAeMYEJp5oG52nt9dJhryTPZTs8acNg9XwBzN
	hhuTwItKkIdjfy6Z9Ny/TmRxdeFoiSeauiWW5Mc2o6olu5myA8lrcNg0Ff5OB6fw1X3WQrD7MEu
	drzPaEhGLT5SJrR/+I24FOsNyeoQ=
X-Google-Smtp-Source: 
 AGHT+IFrou51Z8pUpDNFuNloIRa7tvrDFTxZla2TjlRq66JSbVpmhQS3SCT25qlL0RD+hlDEygE8KGpnL8+Hsiab9LE=
X-Received: by 2002:a2e:7a18:0:b0:2ef:2d3a:e70a with SMTP id
 38308e7fff4ca-2f3aa1c6705mr32595871fa.18.1723726726491; Thu, 15 Aug 2024
 05:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812045325.47736-1-jlobue10@gmail.com>
 <87frra2ocp.wl-tiwai@suse.de>
 <CAGwozwF7aR5UypRTe7tNFR+xOfQ=rhqkzYUgBcYH4_LvO9_zXQ@mail.gmail.com>
 <87cymedlrt.wl-tiwai@suse.de>
In-Reply-To: <87cymedlrt.wl-tiwai@suse.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 15 Aug 2024 15:58:35 +0300
X-Gmail-Original-Message-ID: 
 <CAGwozwEyhhDspUTyUwd9fqacKwoUwJJ=ZOHpJ5UfsaBs1kcx_w@mail.gmail.com>
Message-ID: 
 <CAGwozwEyhhDspUTyUwd9fqacKwoUwJJ=ZOHpJ5UfsaBs1kcx_w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan LoBue <jlobue10@gmail.com>, perex@perex.cz, tiwai@suse.com,
	shenghao-ding@ti.com, kailang@realtek.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	derekjohn.clark@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
 Jan Drogehoff <sentrycraft123@gmail.com>,
	Richard Alvarez <alvarez.richard@gmail.com>,
	Miles Montierth <cyber_dopamine@intheblackmedia.com>, "Chen,
 Robin" <robinchen@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172372672790.4770.8191158551034815193@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi everyone,
I created the following Draft MR for the Ally firmware files:
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/272

Please comment on it at your leisure. I will remove the Draft status once
all the sign-off members verify it for correctness.

@Shenghao: can you restate publicly the license of the firmware files and if
there are no issues, sign-off on the MR?

Best,
Antheas

