Return-Path: <linux-kernel+bounces-557044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E71A5D2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D453B3B38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395A20B208;
	Tue, 11 Mar 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpjThCiG"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBC1E1021
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734284; cv=none; b=EELbzXm8L0F12cN/5utjm3VbtALmukqjnmxRgkKw1Jh7+4NYI3Xsg+B5QzZAhbhYHIugtXZICLBw8QXTO8lRIkF23L6aARln28woQHkDz96b1iD12foSwnevXd41Y0E8tb9a8dXSVmRqE0YTwyCNymnebBAbSp1dlCVB72J7fpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734284; c=relaxed/simple;
	bh=COk0MdfHW6RlRh6RZLXeO1qkIUN7/KaupGrEVi/7eoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cepEJC9GVt6tyavTl8vTdb2MfE8pvCtNYyGyi8wSINSv2DbCD2KGA6e41TBKBiPulASlMUvEI/toFvO+5fhcW2OrG9EM/N070gCDSsbJS4eR/xfxCadyb+Lj1idUGxJgJotdXHriyNKNoV1DoQuPTZHxxnUXpbpqWHPUZGxnh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpjThCiG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac29fd22163so474827866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741734281; x=1742339081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DoyGMSDjtwoW9bneNJ6irZbWj3vs1n/EVCtg3b03ss=;
        b=bpjThCiGI609q+aZeUrZ009YjAvqny+Zf0t1LPQloMyNNzDsSs4GaOgLi8CBhsU0ZN
         AmENz9l5fZcgigAkZCaI+wKLiOr7oMocIZiImo1Qg1bgApYGGczRTl53BuzXr1365YNh
         LSC+7ILvXhePHgLb+6kp9kH/CCmerxkr3VDTuj3zSNXUmk5QO7JLEeqWRXMPPRubFOVX
         kInASBszxh7HH4xTX/8dLeWivarpB+Y0SczMjQOfNRIbPSNNKzJT5DYJiivgvX06PiMI
         JqzQofUKWxC15eWUdKK4ILtHrO+NoZTUYIiNg7pjdqnqFCuty2Y/8zZ+kDsd63zao8ed
         Iu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734281; x=1742339081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DoyGMSDjtwoW9bneNJ6irZbWj3vs1n/EVCtg3b03ss=;
        b=H+YYJvYxVQhnnXEmv2tyIdd1FIDKvk+z7U6fyn59B9G1t2LQzrY1wWcwc8LZnzusXb
         FigW8sLCaCKjq+1cNpMqiNwBvrkP1lCxAiUOgkvohcrcWZsJhdkMPMDCoWsTCHRZfzCI
         oL9F/GT49xnQs2ze3reJkBsH5e4eQeWDTlsVZZZezlHJtup/JRGr4fVuJVA9c6jJKjuJ
         P6JdpyyN5Id9Vf2xYjwBCJxeKDnFRKj9N6C0Ix34vX6y9sFMsHDSm8k3vout48OINGh1
         bUvs3xQmMhpizJTPZJmjcyZvI4OYn+UXnZ0dbuXgglbhOR5xgamkG8dIwn2B+2f3GTuG
         pqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/WmGsDO8X9G9nrhlCgdE2OtAjio/7dtbMdSjAV861pn5oDx+34WakLLZvnNY1VtgVVTjE5a/K7qYyO78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNfmw/VCxfo/8ddeah252m2DA7D2h8vq5Hzn9wRbyHKhhHitw
	1WmdF4L4y5nhlIxNzUYq6wStJJYXaUCa2tPzVCWowgSD92DS5AbjpCLuiefwF3a9AEm52gGiF9g
	4/cvlRtM7Vz6l4TcCR0ycHOI1z1HslJ00Fuo=
X-Gm-Gg: ASbGncun3gJjQcQjMZG/nPkH6lCJFmojxCMLyG/wrvtq67bHaQWsbeguvVaW2Q0Sq/k
	JGoSkSJSAG5t8v1vWFOpmcm4KXm45HM1Y8YXMtPBno+5XexAB5Xr9MQP04kPybp9kAWjp7gVyxn
	6/rbJj4+X2sepCzD2C+FCaUQA=
X-Google-Smtp-Source: AGHT+IEEErcM9pJk/8Vm0zIXdAghB0zs19W7Ia23xbCKyYZq80ALNxWU3yKq/7e6z2NCSnIIVbvMwR4EbtkAF6VyDR4=
X-Received: by 2002:a17:907:1b2a:b0:ac1:ad15:4a8a with SMTP id
 a640c23a62f3a-ac25274a090mr2868341366b.10.1741734280505; Tue, 11 Mar 2025
 16:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311224412.it.153-kees@kernel.org>
In-Reply-To: <20250311224412.it.153-kees@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Tue, 11 Mar 2025 16:04:24 -0700
X-Gm-Features: AQ5f1JrfM-joKuFJFF8VvgPkeBvNEFKE_wMOY97xBob5wcZPk8JkS9B0dZxzBdw
Message-ID: <CAGG=3QUJ4NztStM3GDxLqMyT4_O+8WuhaYCiK4rin-i40qwCcA@mail.gmail.com>
Subject: Re: [PATCH v2] net: macb: Add __nonstring annotations for
 unterminated strings
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:44=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C

s/__nonstring to and correctly/__nonstring to correctly/ ?

> string" and thereby eliminate the warning.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v1: https://lore.kernel.org/lkml/20250310222415.work.815-kees@kernel.org=
/
>  v2: switch to __nonstring annotation
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/cadence/macb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 2847278d9cd4..003483073223 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1027,7 +1027,7 @@ struct gem_stats {
>   * this register should contribute to.
>   */
>  struct gem_statistic {
> -       char stat_string[ETH_GSTRING_LEN];
> +       char stat_string[ETH_GSTRING_LEN] __nonstring;
>         int offset;
>         u32 stat_bits;
>  };
> @@ -1068,6 +1068,7 @@ static const struct gem_statistic gem_statistics[] =
=3D {
>         GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
>         GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
>         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
> +

Is this an errant inclusion? :-)

Reviewed-by: Bill Wendling <morbo@google.com>

>         GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
>                             GEM_BIT(NDS_TXERR)|GEM_BIT(NDS_TXFIFOERR)),
>         GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",
> --
> 2.34.1
>
>

