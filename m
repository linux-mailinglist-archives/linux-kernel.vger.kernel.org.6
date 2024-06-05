Return-Path: <linux-kernel+bounces-201648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FEB8FC147
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CFD2841DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151631642B;
	Wed,  5 Jun 2024 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b="tt+FT3lL"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964FDDDF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550891; cv=none; b=rYCd2jLmVei2HXS3wmhlRk2yqAawXLLpEtGOe1NwEP885irBjPt3VslqRdbHZi4m6G+TvWLJW0jHaEimyY68nJsN9stgsbx52lazNACA8zM7QXONsQoCeQbTk4s00CMOxC2B7jfXoAyUn/LBtuRIN9zXh0T1LAbO7fYf8MJY264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550891; c=relaxed/simple;
	bh=1aAtN/3z/CC+KoX4/Uc468gsc1Odb+4pk0TbWNTH5rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLvtDaZCabK4LK7sFYXejZghHTWuSKCHTh/rBA/ez7K//Zn+G2rGAdsgUyv3ITiIi92JY15JaHksBwzMZ2qyiUCdom3W8JAErDy9V9otLnV67lSS3pB270tKnUQSBx+9E2ElFsqVdPDoujNh/mYikuKTln8z9Bl4lq5oH+dxAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b=tt+FT3lL; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso362349276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 18:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20230601.gappssmtp.com; s=20230601; t=1717550889; x=1718155689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aAtN/3z/CC+KoX4/Uc468gsc1Odb+4pk0TbWNTH5rk=;
        b=tt+FT3lLTJnj8aN+o0+xOkQN/JTcTWZWIjXbRRUlHf8Kr8jVb8sdC5FgSH2wPr9qU6
         381P/7uuhx3VU8IpbzRyy+x+sC7vIGyaq4YI89Oo+XqNuY1b1QbjlkvqcLtlO52+KjTu
         X8zeWgbUqqy1fg3h41yXtLHC/AH1E71YWG3FbgRTltc7wZtE0atG3CeDFruc1tJTQTfG
         PZSGhc51KhJgF1VGI17A/3IBhilLEjbnXg1QYmEPnJFM35BuK0sQ+N5n1sOfw+CxINZo
         MjGNYklVk5Ega603pbts7+IF1WQxVkdsdp/9uEsXZnIDgjaKSfFZspGy8EVe3UeysmLS
         NIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717550889; x=1718155689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aAtN/3z/CC+KoX4/Uc468gsc1Odb+4pk0TbWNTH5rk=;
        b=LQR+VSN8Yw/Z7BS4dBwITkT47fHYH1IL6tUEkTXBlZ36Wz9VZokhg/I8XGdqkCPicr
         JntLS7Bm4Ei5MVWi+PEtpsMcU5dua4x2ggefia7WRgG71Yt6iwROTtJMixXJr6epOPeh
         w4j95SSZ2AI3nOODSvZn/IXwlA2U5prRUDqTvXYNc16QJI1uihMrFJGCVwvJElyE70q8
         Rv/09L/GldnPGic6pWy3m/XEpaasLIMN1NhPVJl4MWKf+DpFX84M3gI6y3CSZMR7zDtx
         BrlZyP/koHg5k7U1vslgrKLy8UolCwMC7czV1iuQNJAL1/LC5B2hFu7lBtFtziIbT58S
         wMuw==
X-Forwarded-Encrypted: i=1; AJvYcCXE0FF6Mw+k48ZASC5nwnf4XBCCt600732YMPh843Aai62CM51Xx9ecmWBOqvbGnIGb9h0SA+sXbE8XrhbcLQEiLyWEpgtQSIcyy8s6
X-Gm-Message-State: AOJu0YzGZnsJ3CuT38PFkXpIf8H3TBog2msGaGXHonL8eWCCnljbxbbk
	WNo34qSW52geQjJyq27XCtxB6Ij2TNG7V/SU0Yt3FQpPny9lLyFdlLoVwnMRyzbjyuEVGsOR349
	p6gNvyLDPnRRIt4PRZf4J6dVclRRbPsChQ1aj
X-Google-Smtp-Source: AGHT+IH5b1wkP6S8DAEsGopYfUuPnn0CZWaw+8yynTwvbj2MBk6B92RfrPC2tnzyTU88t/RNBKA5stTuHDy5P/ggUWk=
X-Received: by 2002:a25:bcc6:0:b0:df7:92ed:365e with SMTP id
 3f1490d57ef6-dfac97ce463mr1085810276.26.1717550888977; Tue, 04 Jun 2024
 18:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com> <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
In-Reply-To: <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
From: Dustin Howett <dustin@howett.net>
Date: Tue, 4 Jun 2024 20:27:57 -0500
Message-ID: <CA+BfgN+LE3YyF3te4m8sWbtH85tU+ERUDW7YR_BFecusVTAWWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:59=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Can you try disabling all of the Framework-specific charge control
> settings and test again?
> Probably the different, disparate logics in the Framework ECs are
> conflicting with each other.

Fascinating! This board does indeed support charge limiting through
both interfaces. It looks like the most recently set one wins for a
time.

The UEFI setup utility only sets the framework-specific charge limit value.

We should probably find some way to converge them, for all of the
supported Framework Laptop programs.

> Thomas

