Return-Path: <linux-kernel+bounces-574716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0EA6E8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B0A188F150
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F71AB6F1;
	Tue, 25 Mar 2025 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiD4tO3x"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5131A8405
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742876046; cv=none; b=mxTTZaeoySa/8rDs6dyOYjJFORm9v8o56bvE9hLlbrj0tGWqXH4Uir4fhO3pHFSh04etXpGv4gFXhBtl9rbjaVeylKoSyDzYA7J7E/pCs5craOmhtRReadkMYgyECC6jouPLPb05rVi9HRopWf0DOKKWScNinp/x24zLyU8D8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742876046; c=relaxed/simple;
	bh=y98SWtn96zFUA5flEj6eCHOx+ST7dgVeq/T0SU3XEEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXJv9YDX3AntbtwpheXPNoDl/lZXohbr0MHXh7udDguj7YZs8IAjrbD/4twzM3s0kS9K8iQj4UvU8h7NTHWTkrCKF56mAlgUyz58GyrJYCYYyQLXZTAeVzMpdbtCh71FoW+abilJuJKxZjI0LEXVKUvtv3Y2Itj5Iuz4kfFFgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiD4tO3x; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301493f461eso6160236a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742876044; x=1743480844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGjqEIRvy5ufGz322dZ6TjygJmIz1ZAwO38o43Ens2Y=;
        b=EiD4tO3xRVppMBeTmo52uckDEx/zcL7nHX0eOjpS7DKknhNhM5rjQF14yixnXW4sut
         xC54pMil/QVKr3zjIrdFfTJG/byzdiAsAf+/L/Qait6MpRLbYKEVnzyJOBx7gEz3KbJi
         CrB6MnNUz/qJSExi2g9YktZCr6erX4+qsDge1X8sCtvTH/M6IiGjj7c9zILiToxvZeXL
         u9YtjmGQldz6WykVUaD2qTUvGRHXAIa0msEOkl/BEHRRxSCkm/0FQ+WV7fUv4AbDt/Er
         5jYk56D23LdL5RKMTCAsxFiBLIZ9WWZWcP0y/85Rt59HEnIUfjp3MucdwbthxkIzLW3h
         JIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742876044; x=1743480844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGjqEIRvy5ufGz322dZ6TjygJmIz1ZAwO38o43Ens2Y=;
        b=eVbRdC2X4Df0nl93XnT5FBZkiIZcMpLMrfnii3UEPdRx7G1fPm259cNMmIYU+JWq75
         bPd3TMGnK7lmgf+3DPMNtfg0CVREVHBvslHk/MSzzSwmqOZOs68FyXSgVSsUmk8BXv8a
         FkgWJW6RkbMjRAV0FPmYulvfFVkgMx91TdasXFQaTr11Ut6WO1SVWVB7fwJ+NHA0Ra19
         1o60hgC5zEVL8wazi8fwGj5utZW1eVDY+643BBMznyT4394Xw065BKZRQR29Vs1iCZKY
         FKTUwl6gxdHwiKxfnyFGdetM85exG7GduyDMq2w/nAqwBHnHIhGLOJX44Jbfu/9SuGnu
         2s7g==
X-Gm-Message-State: AOJu0YyNdkMpnKCmBzV9AksL60e+Ml8wj60gwvy9RmV55k+4ZAFK0+cg
	7EmQoOoqLKE6GbW/MhnpGshECZYdytcG00RVrbA6l955x5Lp443fbkSWA/H9bvVCsPaBrBfnQVY
	G9hnJLjEnXh+cj9kzlPvEC3A+yI1coA==
X-Gm-Gg: ASbGncvwjdsiOmR5FHiMdG/a1VLefAWPoYjqFPNT/QNgpK40gWHAY0TSa5Uw8lxZ8S2
	Kxy6SpXOs6iA6w7j0VZDm/8Hl7u/WzYpN9QHNwkxTmL4v81sO07xWJUOgu81uTX6RwK3GVIXExl
	2AGrFjNI00Jo0VmL68UVdJLPJP1cSKkVfwXPjam79fepRQSvgENfcJWsLA+Rl9ehh+OiV4Pg==
X-Google-Smtp-Source: AGHT+IG0HER9cFU5W8UP5cBX4yR0I3uJ0EUZl+nbAojw4OT1rrQk34DNRxrbNBd7UEc4w7mXDBesKH+V4YgvfSLBL0c=
X-Received: by 2002:a17:90b:274e:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-3030fefe0e2mr22167394a91.26.1742876043480; Mon, 24 Mar 2025
 21:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323191004.112743-1-johan.korsnes@gmail.com>
In-Reply-To: <20250323191004.112743-1-johan.korsnes@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 24 Mar 2025 21:13:52 -0700
X-Gm-Features: AQ5f1JoauUoTTD4iy0YxikFe-arJKhsgJkAepZEG4dYQ8OwTukgRHVGm1HM0KUA
Message-ID: <CAMo8BfKO1GqgG92egP36X5imG4hWMG_S8y=cLLdFxgKCnKoqAw@mail.gmail.com>
Subject: Re: [PATCH] arch: xtensa: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX
To: Johan Korsnes <johan.korsnes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 12:10=E2=80=AFPM Johan Korsnes <johan.korsnes@gmail=
.com> wrote:
>
> This option was removed from the Kconfig in commit
> 8c710f75256b ("net/sched: Retire tcindex classifier") but it was not
> removed from the defconfigs.
>
> Fixes: 8c710f75256b ("net/sched: Retire tcindex classifier")
> Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/configs/common_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Thanks. Applied to my xtensa tree.

-- Max

