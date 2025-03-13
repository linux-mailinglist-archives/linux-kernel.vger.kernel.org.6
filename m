Return-Path: <linux-kernel+bounces-559843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323FBA5FA88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B3E18960EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA226980A;
	Thu, 13 Mar 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVW923+h"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C313AA2F;
	Thu, 13 Mar 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881474; cv=none; b=SM115/1l9XEEgXZm7n8RSPXk3FxqHsSHFCN8IpfgLeB2+M4+zqSSXINrzTuS44TZw/c08lV1PFyvCXR04HtjuGXNDLzyfBkghVhAIiqMThVY+SBSW+xGj1snGA18tMm9wa7mMIZw1A/ARNRg9eSNsojVIH8u5iM8BfMfj/UWzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881474; c=relaxed/simple;
	bh=wsVHJl/JBkTgSntYBokc5Rh4gbYnUSSGiEC4ASDdvSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dxq5mJF/DBCax41N0w9P0tPfns1gu8pTYXvLTXga6mG1KVpUKSKZBXjWAQfbHq8BU6yNH92fNpPoc3wRHGCp8Rge8z9Re74jvodr1Z9ZqQ4AlcEogA0BzBooCcTY779FBr5hwAJ8a0484WwD6ZibZh6ejwXAn7zbSlSqRmcPvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVW923+h; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso246488766b.1;
        Thu, 13 Mar 2025 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741881471; x=1742486271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsVHJl/JBkTgSntYBokc5Rh4gbYnUSSGiEC4ASDdvSU=;
        b=eVW923+hvzyRTgP7nZYiayj7gRimM7n3PNsdOy4CEeizrTE3qNoTbAHrCfBIhPtHJL
         O3oNbC4leaRPBl1l5kXPz2CokHVqHjDz1jn6y73Lu9LFUM3Y+vFePR1SEfBmg44pC21Z
         VrUhCdJYk2cEiKTJByCFD5aVNT1xxQSJd4SMe3Q0RQh9LPI2r6sB2xyveqsc8fD+xsPj
         nc2Y3voDD1sm9724Z++0yoWGH5wQEICwB2XiEonxnGAvCdLbCWtbui78TbYbw++pHjK9
         OJLa5MhsNOLl7/xSQTJfHsWVNqn7hAaD+wI5gYaSdVGFfPytWP/93HKZ1C5SLxo1JpIx
         NYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881471; x=1742486271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsVHJl/JBkTgSntYBokc5Rh4gbYnUSSGiEC4ASDdvSU=;
        b=P2qMokDOXi0H+dXq5WoFm49+Ei4cQseHoJR14BuaLwoBwtaXXQ+wUoXqHC/5hxxekn
         ONXg++hrWrgQBNM6MP1BOC19nPHqiLMJ5wuIBXlA1IKWU6Tp/LmjAv4LmJ4TkTvjd4Z1
         xaFIxL1eZajafoDM8enkxGUJfwGuWWL1Lxo6TKzmdFalTc73TxPK6K25jLSuNcUv9N/H
         qv98hmUWcgaDmd7El2XOEhXbT4z3QbMMkNRi3eN6tp7/Po7WuAXMcZ9z+RRVAM/ReryU
         VlTBkIFOBesNJIfdAk3I5P37kLxlMWVbOXIoV/D7ixPH5bFL3hH/UomLIT0UcYX2aXph
         Bdxg==
X-Forwarded-Encrypted: i=1; AJvYcCUYCyZmbgablNLrOfQL/kai8nwg65pk//0hXql2/5S+/Yb3JPsLEPI1J8v6jzX3u2m9wSxj9ZM1seBetZzxWLFImfW5Ag==@vger.kernel.org, AJvYcCVTP1jhJ+S5P/sN4pOG96TXj+gIdB20iTVPQBxasPj+CbwPQ5zJCz+2g+gwlDQGegE3Fx+kXFi5lqUKz2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo28e975Ta2C5MMTneLJUyR5UchRaX+YV9C/Kb447Pss241kce
	epWwyouiEApd7CGaG1QLc1risGitts4hadyQV7pdm4orOjDDVtrqK1xWqJ8+f3REA0054749HUS
	i9gE31wUE50aSh4y1OOQqZDZEfTo=
X-Gm-Gg: ASbGncsGJK1C6MKKJKJ2xfEaM7E/k9lJ7lTMTBsNA2pcdcuOQ0VVtF1zwewYMExZhjs
	HzBRjrgM/bHFognrqLj9oz86OdvTVhvf6ke2h2fYdAZMfg0Lsiv+QrLAZK917xiBaDSuD7LCd9S
	zlvn67oh51k70eN3mO4CeWv98z8Kyz
X-Google-Smtp-Source: AGHT+IHz3CyhULz6if3wOZDZfYAXpu/QzovfbrVsmiDpMwn9wTNLYmixELc4AOHIDMdSL+kGdQ2U5XNJ5hU3jkKap1Y=
X-Received: by 2002:a17:906:c102:b0:ac2:b87f:2856 with SMTP id
 a640c23a62f3a-ac2b9ef0699mr1632556466b.55.1741881470984; Thu, 13 Mar 2025
 08:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313085526.1439092-1-yong.liang.choong@linux.intel.com>
In-Reply-To: <20250313085526.1439092-1-yong.liang.choong@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 13 Mar 2025 17:57:14 +0200
X-Gm-Features: AQ5f1JoeydCTY0ct3jQvg3g3hDg30FqmLjKONZosLZx3N8F_3YQT7lk3Qkctx50
Message-ID: <CAHp75Vcjqv+j9gkZiQ_LtYE1F7YH8ZweHVTa31AbPht8_Knnkg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel_pmc_ipc: add option to build
 without ACPI
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	David E Box <david.e.box@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:55=E2=80=AFAM Choong Yong Liang
<yong.liang.choong@linux.intel.com> wrote:
>
> From: David E. Box <david.e.box@linux.intel.com>
>
> Introduce a configuration option that allows users to build the
> intel_pmc_ipc driver without ACPI support. This is useful for
> systems where ACPI is not available or desired.
>
> Based on the discussion from the patch [1], it was necessary to
> provide this option to accommodate specific use cases.

> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20250227121522=
.1802832-6-yong.liang.choong@linux.intel.com/#26280764 [1]

>

No blank line here, but I think Hans or Ilpo may tweak this when applying.

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Thanks!

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

--=20
With Best Regards,
Andy Shevchenko

