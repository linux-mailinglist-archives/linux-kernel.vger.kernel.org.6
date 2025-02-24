Return-Path: <linux-kernel+bounces-528392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A2A41735
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFDA173572
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D147D78F37;
	Mon, 24 Feb 2025 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLxIHTAT"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0881519A1;
	Mon, 24 Feb 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385262; cv=none; b=Qk6Mx4NGiR+1FVkvvGo5aZH6c+oHZXQSer0ouGGE9T3z/V7X9o0gDbp7HTsH8GmfZosj3FbIwRzCOaBnu1RejmvGJgXvkG92zRCB6laiTh+L0GFqYuyQ2S6ipubZhU2JBy2B33cvuVfKbMg94YZfbeT2LSOPWLWXkI0bb4CjT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385262; c=relaxed/simple;
	bh=4yXsV2/LB2SciH7nkwJ9VHcDfoQGnZX60SaMgs0Jh/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOt+WgcSiQ9SYPEzmCyoDzeySKySlcK/fupNOAfZ2i6qSNuo/7aQ9rKZsTPBRLoXkFB09DyZ/ZB8f1cm9ZiNFqgoZYL4v/YT4OdzXKGz0UwZLKG8dqBbJxZMdQOG2kJ04FyoZFhZhFIU+oQKrkLbJ3Tqn1PvIQFR8MK6Y68wZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLxIHTAT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so6163382a91.2;
        Mon, 24 Feb 2025 00:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740385260; x=1740990060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yXsV2/LB2SciH7nkwJ9VHcDfoQGnZX60SaMgs0Jh/U=;
        b=LLxIHTATCEaPlVyff933rfKTEjybNOfNMPmgyrwRQfpXS4jYLIKcnSIzsztLq8q3ih
         VRHppK4VyXne0u4ZjUoFJRNP19tZrPwK7xk9BDyLYQOpvCkjkf0oqmzLg8YLg5+F3CnZ
         ojgveIzSipQWDyT9awIpMizJMBmPg+oXuJlf2R1CNnH/75O2Pm6lmd3GmQK6Wd4e6kzD
         +eZ3Jz4yRAorMkQXd3Im7dE7xvrDmd1418iCS+BCaBBQPFgUIKzpoIGffNkmT9Yj9aVQ
         mgaG01H4FjYE90VFqwxusJ+FaMZ+A1mqVyVX0pqWq74Agi6Nc8Bg5DYBb4x6nAGHGUAs
         0tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385260; x=1740990060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yXsV2/LB2SciH7nkwJ9VHcDfoQGnZX60SaMgs0Jh/U=;
        b=ZKx49l35sTAmsuvrueUOnUERFzve2FTGYvvBxxscMmgG+QdrvDEt4M70vbuceQDuO8
         7jG44ATFVNiFxB2oY7jxPPxPfdJmI4TTlhrhLmGHVL6G7dIaYa/6mnb9geLbPzMqj9sv
         q5a9/TDanSmvaVC2yX1ebTgQL2Kdw26xvXlVGBpwnKT7gBCmg/xEZcrmUBh5A0wREURH
         nPh68sBHVs3g2hYssdDpHu8ZQfdvXhpa8Fj/17xasoSFBP4LmvkZgcWMmtP0Wm68IDui
         TMcKKpBmkXh4EFPdloqivXtlTZx4kwZ5o9qovfvx9bKsxKbG9RCETRKW1V0MFy+kCzO+
         c5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXUhfjW1NMyXaYdQVjTuClaVFQutxYMbB6O6g1Cyo2UlSzl4j09De0un1GY3dvMs2BbneCwk7LVpmWz@vger.kernel.org, AJvYcCXdRPvYSeNruJ9rLFgcIa3ErJTO5Rjl8meHWAq65WFlesul7mwut2DpnIEGAzj6MObD31mP0/h94oGbTruL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ipThVCwZ2fxtXw89W1NFV8JHIBcCxES65oOcsVn8vCCTxMC1
	KWMTBVDRI5s7Iqtgzw6Lh1n1gWkyG0JjQtEFNQaS8/DN4EH55S80OiH+5uYtspzyTKU/xxwQl+3
	e74xzdu1mNyulIX3YCZWNawuv2jM=
X-Gm-Gg: ASbGncvM3f0VrFjrRTNHQg/kYxoHTkesnF8zeuUH2gSC2UdE5i9xXEDey05koq70B36
	zDxO7lu2FMKk2GEOwmkO2BjSVjvvsy46PM0y+1nDa6z++XZIcikrJ0TXBxeij+l5xjdWIpE+sPX
	KOwJhI
X-Google-Smtp-Source: AGHT+IFSIoZtx5tOAmzcah9AyzKdcvqgQQFQ3kwXEXdt9bo6IsFtTyTRuheP5O2mOJ7Yg+7fM9dG3dpRP3aMlab/o44=
X-Received: by 2002:a17:90b:4b06:b0:2ee:a04b:92ce with SMTP id
 98e67ed59e1d1-2fce7b354d8mr18309742a91.32.1740385259942; Mon, 24 Feb 2025
 00:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com> <20250220-imx95_15x15-v3-3-247777ed91c4@nxp.com>
In-Reply-To: <20250220-imx95_15x15-v3-3-247777ed91c4@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 24 Feb 2025 10:22:36 +0200
X-Gm-Features: AWEUYZm8TV1XLlsHGFmvB7e9AgvFyAGTWUyACsVmTUYTvwHG2UC3MRv44aFAl5Y
Message-ID: <CAEnQRZDHage3=xzN6bqbMjHjxuX1aPPQfTrRjicu=8qxoSToRg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: imx95: Add i3c1 and i3c2
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:27=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add i3c1 and i3c2 support.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

