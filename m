Return-Path: <linux-kernel+bounces-174581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C288C111C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74502838E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050A615E5D2;
	Thu,  9 May 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX4t9A7l"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77215B152;
	Thu,  9 May 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264240; cv=none; b=rmA8ZAlnbpFTz05/Eo07XOYdrfflifgVnwuetYT7ehq+gu268BkuBamtMUmZakjGZKlbMdFPdFgve5RFy///V/Y3TCZb4Ybu2hUaEelSWGZl/S8WWnO1XIhitbiCedfK4Vql44Qa639MXIXFU8aBf2ZrMMXdygEp1Kl+JP/c8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264240; c=relaxed/simple;
	bh=PR9G2+1CHGEwlck4+knT3SclL6xiZ0MN+KWBAeb4SgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHGT8gx+eL3bZ+8jkj+wwmkGXtcmd7/37NdMEQ6AmGPj+qRfKKN8M58pbZo7jwBxsdxHbgqx/8JkPQbG88gO6Wqi2ssdOeQ+p2naU7MRGwhu1XZQYvplSdIW+Ak1TrQF7qgP0Ib1yNJZbGbdwjOHPSpHv+pvfZ8fqYIAof6p3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX4t9A7l; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db13ca0363so14091921fa.3;
        Thu, 09 May 2024 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715264237; x=1715869037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR9G2+1CHGEwlck4+knT3SclL6xiZ0MN+KWBAeb4SgE=;
        b=JX4t9A7ls4lCJj/9+cV4MTbqRxitdzRPrDXj2gtN+miQ2bPUB5+KE+cTqoWl/h7Uta
         iSuqA6wKDt9L/naxXczpaYFPCDNjavup/KxBQteVc2T5B3XOV0BIgmxty0Pv9RKgh1YQ
         j+bx6aJFkdGsylb9tk3Tduy0/V5lKNd28U+1ovg/bEv0RIydhnIJOR/RJSO//2HO6+cD
         6cuw9zHqZUllZ2B5ex0IcVYXDAuzPoo8izGmWQ7X+bPmFVxF3gSmt9NeVipFWjqAc8Dv
         9T1f41gRNOZhQiM4HSgHD4j8Luk2U0Q7Mld+pGMUTwXr0gybYMsyp6G/I5TA1niJdExH
         SSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264237; x=1715869037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR9G2+1CHGEwlck4+knT3SclL6xiZ0MN+KWBAeb4SgE=;
        b=VUZJiZIOtvncpA843OwEM7ZIG8Cbw4OYpDeYvf7dXCqk0wWLP71f0zxa29/I8eGFiY
         4H66R8He1QJ5H5TstmvcHeeKTzPwu0k0nyMzISE7sgy0HG7yyhCn6tM2NJXsEtE2/7h4
         XdG/iqkRNdc9pJ2vHqdWnV/XNeFWzfpBhpsQ/L1AOVigJc9zfcBot9JMG75a4oLBc7OB
         Ik2SFRM7rJFj9OD9+Tovf6YFdpcgRlHu1i/hOgATCZSa+lfspqwNEeT0SsMwm09DOFRi
         fR6Czyx+TzYhUk4wqZ+1clqGIkAJ12YpbnWTnDCErAuU8BgB7ivPlmFpXL1tzMLqE9l0
         9rrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVtdlpU82s1EMWM/zfwPZMP84ucTP7sCY8NqjP7oqZAfYiH6LkwhGKsVY5QXIENPAcNn9caPFdoLMUmu5HknaPdXQmD+EcTnc5Nxh2lZ+HE9Be/uP1iwRLkWyVinQ7wrbMezQSJQuohg==
X-Gm-Message-State: AOJu0YyuTIkyckDGugQ7s7+uxjM8BDuSL+cMYwYtwJalkLlF37MlIkTv
	5MdU+b5SmZc+eSvgeERWkv5XgQe9k2M6g9IBCYDVXYey3jghLy9wzoXrI58jLJETji7rMRbtEdE
	MrQee35SvrpebSQqgtVOCjbv6Bd0=
X-Google-Smtp-Source: AGHT+IH1luO5MtWwUlZS3dA3xdyuezrAkR1FJS33ZArvaOKKJhaSuwDOzRbI/SpjZ8kqdgtXsFKIWLpcdaeOImhaLSk=
X-Received: by 2002:a2e:2416:0:b0:2de:8697:e08b with SMTP id
 38308e7fff4ca-2e447084518mr49281291fa.26.1715264236601; Thu, 09 May 2024
 07:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715231698-451-1-git-send-email-shengjiu.wang@nxp.com> <1715231698-451-2-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1715231698-451-2-git-send-email-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 9 May 2024 17:17:04 +0300
Message-ID: <CAEnQRZAAuA2Xq-Pj3uuGAgtwz4CQh0ZNJm34Mb0mrgMcsjPiWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Initialize audio PLLs from
 audiomix subsystem
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	shengjiu.wang@gmail.com, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:36=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.com=
> wrote:
>
> Initialize audio PLL1 as the parent clock for 8kHz series rates,
> audio PLL2 as the parent clock for 11kHz series rates. that PLL1
> and PLL2 can together support full range of audio sample rates.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

