Return-Path: <linux-kernel+bounces-531354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10CA43F73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34BE19C108D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78FC268C75;
	Tue, 25 Feb 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U//oaj6w"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4A2686A8;
	Tue, 25 Feb 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486731; cv=none; b=Y+i7xeJsCiX/++CoPHJWCFRfMxabfrP1+j8aVLHC2ZOJtZVfgAhygp7HuZVx73UtPEZL2/HSDuVBpg68OQJGhLC3v70OXgEOMuUifemX2Q7WmRIQUn6llsN1fZTZYZFwSLxKUaNvoQPUydpqfC/5WDDDiizPhYjDKcRQG4jet64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486731; c=relaxed/simple;
	bh=1pyD4SZ5Q/Lc9AqUwjBxII6k9+7yhxDr5m+K9ELoDbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE4ce1+xTag8NngqpnGBlwb1oBXwuMVT5NcgExm3r+092qJHTAOA07DCcQxc/CAX5wX/YWEDwQzmMUrOC6EcycwmtTngow3DoNpNpb7qyvPD2IlWPegPNb0DYQn6YWiciwUnMGR0oZeOvu2pvwkv4lJOP8mdM4MhXhgvHZAfiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U//oaj6w; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso6249760a91.0;
        Tue, 25 Feb 2025 04:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740486729; x=1741091529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hQ9PSnky3hzUHJ3r5I6w65ox232hzZUXn+oYcw3lsM=;
        b=U//oaj6whFaW1Y9WF2s+r9c12W1TMarw1dgqGToyjyAEadXNzQVrJIq1FP1gVUB4Y1
         s0NjCbLWy+XZoVi2sd+ZYuLO8AbG5Z1egr50nAKIbd4CEePEwd104cLF5Tw9z7SaAG7n
         mR9IxSIy63IevXJOPTTL/3id625o2TDfXQGJGUkzufBU9W94orx+Pv+Gb/DgmfaAdTLg
         1MdmkeLYw3XGe/c/5n3bevrduoeIcgPk7HUXroK44rKisSA5eluGISYT8AGI0fFgtZH6
         PWAkPFezVmg2+0fLIEMXyt+oX2GhRnIPHSYUVExzNHUcTaLkQ3XcV1VjVY1Bt33Sqdsf
         gQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740486729; x=1741091529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hQ9PSnky3hzUHJ3r5I6w65ox232hzZUXn+oYcw3lsM=;
        b=xKltorvYcBqAh1Yvc+hazOp3hqiCmYPWM5CF2yt1xva0dxbLh2g/0L1d2ClZL7Gw0B
         ZLrZULD30j7UmAvBb9LNepAGrpAsiVFXDgl17gWHhH0oAxlyxDMRxAR1cCY2k+gfMLGL
         1UT4c6yC2yoIMNBjovLI4Nb8+WMCU9sndFaJDh6O6TZ06LcKCLZ2FXShUHPX6TGvE9k1
         6zd8XfAy10pmy2g/iTEwy4VZfbh1iQuevFEs28hYRnX+/OfSLMhUulxKqa24czxRrcx/
         24YkwbOrsL6og3RrH5MuSGvqsWnBLbU6TNbIxMApbCnFBWokRnb7T2RGWP6yz2NpMMZH
         WYmg==
X-Forwarded-Encrypted: i=1; AJvYcCVLUrh8F3OLec9OaQNlXDx6weaQMXzxv6OSfLRBaURVW4m/QVceKGCDTSbHZp3gUtQnYqNp4qXdAejoqMgG@vger.kernel.org, AJvYcCXmURMu4Fj/GbJAomrFrVGHl39JpgMPAF/YCwucn0A1qfE9fAcphJK4Gp6S4QB1/Ge36X9I9kSrXMbB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2eywYVnrFKwIQ+stC2vwIL9x8nZrBqrz2Rj+VkQeaqBRmKHaJ
	xIwBzTuj0ew6urgwwVnG54+MDeJ7T2LXMrRefjcyo2oyRWUWaNRWEBz6SiUS3Cb2GgyYFizzMys
	bmPxu2lbWL0NKnitdgsjdq3QdIVQ=
X-Gm-Gg: ASbGncs78N1IKkSRyIt8OOSJhXi2BrdkNKy7jLw7owj1xtz91GzqVv2fPk4CQiXypdP
	1fpp8zNAPNNa7aX0qOyuZFppJYJXiAyaPF7znDQyTEFX9ODtV0C+pEBcSBg7scBzmV2yhoDCoG8
	kCvxtX
X-Google-Smtp-Source: AGHT+IEhj54F35PZEsJYYrzaWJyBanI+coj2uAU8OTJp3NVm093Jk0fuCJf+AJB+0L8a6Juozj6iHZgPqCZQO9GBPqA=
X-Received: by 2002:a17:90b:2751:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2fe68a312b8mr6037629a91.0.1740486729075; Tue, 25 Feb 2025
 04:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225120707.2658709-1-m.felsch@pengutronix.de>
In-Reply-To: <20250225120707.2658709-1-m.felsch@pengutronix.de>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 25 Feb 2025 14:33:45 +0200
X-Gm-Features: AWEUYZlyvb2cM0-5vtqGVculafUAJm4OWsTkAKrC0Tw7wQoPYmnk7k-oBG7QuOM
Message-ID: <CAEnQRZAoPxFN1ce0MEY34KpJO=SS4n33ehABH4auxWTDq8_R8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: imx8mn: fix micfil dmas settings
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: "robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, Sascha Hauer" <s.hauer@pengutronix.de>, kernel@pengutronix.de, aford173@gmail.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joy Zou <joy.zou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:12=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> The third dma cell is used for priority information not to encode
> something else. The NXP downstream kernel use the third cell to encode
> more information:
>
>  - Bit31: sw_done feature enable/disable
>  - Bit15~Bit8: selector
>  - Bit7~Bit0: priority level
>
> but this was never mainlined. Therefore drop the further information and
> just specify the priority which is 0.
>
> FTR: The sw_done feature was mainlined without making use of the
> devicetree.
>
> Fixes: cca69ef6eba5 ("arm64: dts: imx8mn: Add support for micfil")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

For all series:

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Marco I couldn't find the cover letter for this series so I add my R-b tag =
here.

