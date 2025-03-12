Return-Path: <linux-kernel+bounces-557347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B8EA5D7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F73B035F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493C22DF91;
	Wed, 12 Mar 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVNtmS5K"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50508632E;
	Wed, 12 Mar 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766132; cv=none; b=pAV4q4EpjAcLzoh+6hcgdsuFtkQJ2aV8vy9cHfvuZBmrD6aa7s4PQfg86GyfhX6BNfDy0x0XascVClbPpTTwuDzjTIBvTI6HNW7V3osEyg4g0EbMSvWBkTXkEjWhdARpC0HiVOXeFhlr5XJvlzykoBDelrGGNIK5mKmxU7lbGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766132; c=relaxed/simple;
	bh=A7opc6of0uvyt+izwCispQoBCudbTP6hdCXEIYMX7iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dh1jY5lCq/xDzAE/p15ohpzROW8c1HHDIbWhQ0jxJ4zPBzmcpu6UcHLY39Pi1G5+QpMqYr4HBnZulqL1hBDnN2RN4K23Gno2MZ1n/fkq+nkN3f2U5JB07M0msnMsh5ZcoLOzbOwB8PBOsqUudgaqN4sa8ZC9NuNIeQh9nV5p1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVNtmS5K; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so253696666b.0;
        Wed, 12 Mar 2025 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741766129; x=1742370929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj5UzkJh+c6n0dhgXeheHxyYgb3hNGKyADmZDMM90gE=;
        b=BVNtmS5KIynnRURUBq3v9AvQJTNI5iZEJlnolv0u5Rgz737sVhvMf5ptlN3apXcHUM
         vf5IhNvMSALX1AKHHyUjm8mJk4I7sonPh99Y8DLrDA5dvnh4oU32r9dT1raO9OfGl0w4
         SqI+eQWBqOnkmsGWui+r0e7yhsCd1Dc2hEW+EbTFFl1JD9kKPx1h2P/5V0j1inejibG1
         PCv7oWT6i6xvRe28hjyKijrc3iYgkKb1hWO7A+FWh3X71FUj6n43kgLaBYBXpK91b5Jt
         zpMQK/+uWESLF86AWJUGQcoDTKDPgJtv2bU3bsSBAEwqYV8parLgiCFvSYYO14bEOBMf
         ckYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741766129; x=1742370929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj5UzkJh+c6n0dhgXeheHxyYgb3hNGKyADmZDMM90gE=;
        b=NKV1KtzgQltHDcSNehuNa/Zc5i/8aNYnCFU8YfavtNbG+eEnJQCIAfP8X9s8I4A5Ac
         Ix+7wdKcFIxdfTld4mTFOXE5uU+32kSiReDYCgnQhgE3YRvtlPUFb6Cr5ziJelEZGmr7
         X0V1p9x1wGhFIs8jSfdRH/9jaRMZJJj4wzwCfro4UGQaoHiz5RDZZYuj9MrZYy0nP1LY
         5nntUuDlzlChbDrAh2WP6rcSQUSYR4KJFETq2SRp23FDok+JuB/JG0ad71HCr8agVC15
         7GvB8RDA1W8z6e4Tvpi1+bjpe32k3EIdqohNZWcyWcgoD8YyANROQrahxUnNeFS1abJU
         pB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMMn0FOVp5xWyiObh6E6xEvLw/YpnOrqrxtKaVTQYI5GgoyaL9MX8mMlvaO/FriMh/Sxc+rfoIKqjGXfUqsTVwoHbCTA==@vger.kernel.org, AJvYcCWeOMX0BROyJPMg4yv0wcBqY8/2WRhpu8OxCDIw9IyWzmq8GBOjFfPMQnEc20CXTzCXYaIptUS3Ew/Hb1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZBxnME7PeBpWEcCX2KIEvPBc5AIifwod0QwkmwPo1/1a/XbK
	WxnuJdzlA8gLYE6+ZfQa62t98PSK2+TQjl/XIXfJ5b5/S4XwoV8jAaeLfQ9a/llT6Fa8l+SR+pG
	o1uLnckmWFxZXJVdKXikmLYXIdvg=
X-Gm-Gg: ASbGncvYUwOOR2fZCi9c6DcSHgCVCsls5Rx+0PHC7M1+WS5LtgLHDGhGo3yypm2RSPg
	B2Yuq/vvwakvcm3JNLSKotAJuURZR0LGcFpu3vX68vRpnrXgzqsIy43QbVSzF0rzfmcdsaxL4bf
	3Ucl9I1C939x87MrQI4qY0O6+MxHfO98kPoia7
X-Google-Smtp-Source: AGHT+IFhp5zEhDkcFcQBIOSZdBpn4+YesT8GbKRiTezSrgqkTSjZOnYdhkWp0KghWLO9P7lGlADU5MOm4lRfmUGj1bE=
X-Received: by 2002:a17:906:b20a:b0:ac2:84db:5916 with SMTP id
 a640c23a62f3a-ac284db5ff9mr1700286066b.31.1741766128669; Wed, 12 Mar 2025
 00:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312022955.1418234-1-yong.liang.choong@linux.intel.com>
In-Reply-To: <20250312022955.1418234-1-yong.liang.choong@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 12 Mar 2025 09:54:52 +0200
X-Gm-Features: AQ5f1Jq8etvGVZ1GnV5dG3EvZtajo350JiovFCO5GqzSraOmAbSAeAQsTgx6c6I
Message-ID: <CAHp75VekTbp++4yw4yDhtB96K+C0w1uHiVih5x-jO+TWRLiPmw@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_ipc: add option to build
 without ACPI
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	David E Box <david.e.box@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:30=E2=80=AFAM Choong Yong Liang
<yong.liang.choong@linux.intel.com> wrote:

Thank you, my comments below.

> This patch introduces a configuration option that allows users to

s/This patch introduces/Introduce/

> build the intel_pmc_ipc driver without ACPI support. This is useful
> for systems where ACPI is not available or desired.
>
> Based on the discussion from the patch: https://patchwork.kernel.org/
> project/netdevbpf/patch/20250227121522.1802832-6-
> yong.liang.choong@linux.intel.com/#26280764, it was necessary to
> provide this option to accommodate specific use cases.

Make it a Link tag, like

"...from the patch [1], it was..."


Link: https://.... [1]


> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

This is wrong as either it's a wrong tag (SoB --> Suggested-by?), or
missing Co-developed-by, or wrong order (but in that case David should
have sent the patch).

...

> +#if CONFIG_ACPI

Better to have #ifdef, but see below

>  static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_=
ipc_rbuf *rbuf)
>  {

>  }
> +#else
> +static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_=
ipc_rbuf *rbuf)
> +{ return -ENODEV; }
> +#endif /* CONFIG_ACPI */

Since it's already static inline, it might be more natural to have
this inside the function. The current is usually used for the C impl.
+ static inline stub, like

#ifdef FOO
int foo(...);
#else
static inline int foo(...) { return ... }
#endif

But I'm not insisting, it's up to the PDx86 maintainers.

--=20
With Best Regards,
Andy Shevchenko

