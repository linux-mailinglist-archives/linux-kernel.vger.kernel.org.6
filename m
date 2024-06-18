Return-Path: <linux-kernel+bounces-219972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3881390DAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126F928399B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF4146D6D;
	Tue, 18 Jun 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/GM+j+e"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712C145B37
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732862; cv=none; b=JGtT9hGq62g6hOJ2Z3h5Y1wBYgfp6moKGZ/sgANsfhV50ZaW0ErhRdak+l4tEppeptdpJUaK37dWWZha7lMul4exf95u+M54kk0WaTqCd2lH7WjGForzc4XEExXU5JXbMvf1Y1TMHrmaLeuBGW+TBD0Zcy/FnJC0NfAb7O5tWlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732862; c=relaxed/simple;
	bh=WtKpZWcUl0e+YJfunJzlBdQYEVufWtzLJiMSdeYhNkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoKQfHgtoOeN4OLCgn2ev8x2SyM+ks7BP02QYrvXbAMRfuC19GOhpw8oo7zuKtuqwIV5XDRtucc6PH9iYYzhaNbQW5pvsBZyk+sl8LNy53BtZFHmjlNbYW9/qmsw6jLwDGaUTITEE6o8/e3gcxw6DJv7tlEnlXYQ4D/Cs/tFRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/GM+j+e; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dff0712ede2so6126316276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718732860; x=1719337660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtKpZWcUl0e+YJfunJzlBdQYEVufWtzLJiMSdeYhNkI=;
        b=s/GM+j+ewxwl5okUZjGHFUX3IFYU94jfOhUo6R/ZlW/k/ZEu+CZIiqohXW9yogyJVh
         UreuH6BJKxxn2X1+jsT1Dt0kL6miBt1KrA9laLRzQJaYH2+jHrIWnzjw4tKS1pTqFDHA
         jGQb9vjf+M3vnWyeHTWf0+d2gBldYgIk17xQMnQLSoOAx76HQyiE2niKAy/9t7gilmEg
         7ccOpHhV/M22OUyUPcZ+NoeZHcR7/Phku9UK/RGUC1NcKtoF4Va/jfpAaBB2hyWbEjB2
         sv91gRujFHCyfhP9vGEHQ36vMqfHiGIYf9M6FfZC1qbCKRCCz7/K1IuDsCW7gicCY7I4
         KUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718732860; x=1719337660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtKpZWcUl0e+YJfunJzlBdQYEVufWtzLJiMSdeYhNkI=;
        b=itCvcfz7hjV9r3Z513awCqI/QqMKevvjJO8dRrzCYIcRRgLIUCW6QITu2VA3mqnB2x
         z978og87GDgnxeyjqstt9CbdMHA9jkKsE6WnWBZYd8tMO1VpUS/iMRZjwiywa/zuiK9E
         7xSq3wU9BT5jqnOx1UGiDzOqZy9i2/2vu28wvio8+C/evT8pdVUEAe9czINcUC9z/IVZ
         rXr1prYxLlic71HxNo1HVjx2Mfi3dyFk5+QuAurd8bubXmtzOsz8ynAJ+okk51SjTxq4
         hU5FEkGvGxLGrT4ghXdczVZ4wHRTG/Jc/9TymImDNM7pREONA48TdpsdQXhCnoN2UVqc
         /0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbl1JVVmCGm+uY3biTQ5PH3EvFXe5/QBQMVV6glzqIp0j61OFqP4aAWDlxBxQxj875cnMjhxMTkScWU7mRpjblPkOcc70TOz4FZj38
X-Gm-Message-State: AOJu0YzTgX0APdqVjnhe4m6m5FwOd8rHAB5h0Pwxm80EsQBQLP55TWRZ
	PuLMeJuR7HkuvDyjg9f7YSVvcDIcKYoOiXpUkpIK9x3tlRjANvmkD0Q4Q+K0dL0LSZHM8kR9ZYk
	sDZizzvo5wgSjIGoGoYd1Dw8kxrLC0mDuRjKOTw==
X-Google-Smtp-Source: AGHT+IFappc3wA7RX8sQbYdiSE7dEKm/VYOIaHva/VzeNskm7446FG29AlCvkzHOdVWauRc4e+y8oo3dJe1/GIgFb3s=
X-Received: by 2002:a25:846:0:b0:e01:bb57:4d1a with SMTP id
 3f1490d57ef6-e02be13b828mr587249276.19.1718732860244; Tue, 18 Jun 2024
 10:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614140421.3172674-1-peter.griffin@linaro.org> <20240614140421.3172674-3-peter.griffin@linaro.org>
In-Reply-To: <20240614140421.3172674-3-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 18 Jun 2024 12:47:29 -0500
Message-ID: <CAPLW+4mnCVdPwA8awj_95uwvbHXniGwCBJQyKztv6_vNOOQgmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()
To: Peter Griffin <peter.griffin@linaro.org>
Cc: lee@kernel.org, arnd@arndb.de, krzk@kernel.org, alim.akhtar@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:04=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> For SoCs like gs101 that need a special regmap, register this with
> of_syscon_register_regmap api, so it can be returned by
> syscon_regmap_lookup_by_phandle() and friends.
>
> For SoCs that don't require a custom regmap, revert back to syscon
> creating the mmio regmap rather than duplicating the logic here.
>
> exynos_get_pmu_regmap_by_phandle() api is also updated to retrieve
> the regmap via syscon. The exynos_get_pmu_regmap_by_phandle() api
> is kept around until fw_devlink support for syscon property is added
> for the pinctrl-samsung driver that also runs at postcore_initcall
> level.
>
> All other exynos client drivers can revert back to
> syscon_regmap_lookup_by_phandle().
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

[snip]

