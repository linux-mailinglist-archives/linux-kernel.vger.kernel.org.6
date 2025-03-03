Return-Path: <linux-kernel+bounces-544826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA49A4E6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335A38C021B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A2259C88;
	Tue,  4 Mar 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wN/8O2WM"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D11FFC70
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103607; cv=pass; b=mze/y1FmYbjBk9UFc+G1c7mz4E0JZsfZOliTzx9mrezig8vZnIRJ9qqSWKJofLjjCck7hQs4z/UE/f/fzveYzvEDQtP3jfhhKO4m0eCmImnW29G9Vgnm8Goau7/K/8oc11XtaW4lwXxXPf9KUJDg9sy9rlkSsaCHNt2npYv4frY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103607; c=relaxed/simple;
	bh=b+lx7Mhr5F+6MDHZhmiQwGCwKX8l5EMHGINdzkXhal8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvpP+7SWel4FELlxoRu3YnbJwqbJr6yPrPPFrLPqmkfUvkG3kBimH9foDV3F13NwdEjKYYbCUWrqYvxZlPuVUg2Fdc0NziHQd2HKUTl38H+S4Y1WKsLVuAvUE8/jgjcHRZ9A9TpB2AGL1v/VwpEJAbw3K/y7yQl9njO+Fv1Xn0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wN/8O2WM; arc=none smtp.client-ip=209.85.128.175; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id DDB6340D974B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:53:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wN/8O2WM
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g3T3mNYzG12t
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:44:37 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C3B7A42753; Tue,  4 Mar 2025 18:44:29 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wN/8O2WM
X-Envelope-From: <linux-kernel+bounces-541628-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wN/8O2WM
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8EC87420DD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:50:15 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 437963063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:50:15 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D643168110
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992E020CCDF;
	Mon,  3 Mar 2025 11:48:16 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6D20C00C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002493; cv=none; b=ASrok7bygUEZxeMH50PqwRLpRtiJamoAObz+fi8ATZY3DrZNCodPMgeRBx7BwLj16IWjZJqafckPFN8MpVhoT62tHZcYeE3JecCgbxsV9HDLEMHQB585rkM+WlrgSoQGq5OoLlBgBAm4x1itVrZLDwA8wfLNfYTg+A93evDb5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002493; c=relaxed/simple;
	bh=b+lx7Mhr5F+6MDHZhmiQwGCwKX8l5EMHGINdzkXhal8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2q04Kjvqf1caecrVa0hG6pJN+1W1KK2L299XWj3FJ0jDgiaPG8z/u7CMyl2TbYsCFUjN9+b8bgZ/4XJQHNUKfZKNvrtlJFZm4Zh++OZaJA0fpZr/RLg6lydH5J4tGnPxJ6tGazu5PXh4h8eGvKOT4YgrSc8MY/Tc/elD8Atoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wN/8O2WM; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fbaa0582a6so36501827b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002491; x=1741607291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3d27QuSpy+kpWSA5wCmX6ePb2qWRbp1n87DWygzb7ZQ=;
        b=wN/8O2WMt4I5yir/lgd3E7SUqlJ9+m/EGjVskD6DwNQ/INU+WFSV1LuUTum9JOZ4rI
         GzTa8nOlST/rmUPMLQUKoAwVOWjQpkNU+S6Que+nLCk5kHlHRZCXc7gU6Rw8/O5xZdiP
         6dzXQFj6OqNOWXCjPrsd5P6piOfniZmWzpkdLwWQssZXrtXjlzlporGPgVW1Kpsz/wnH
         s+2tw5kdfkkjvm+ySXdP86K0lBYey7Hgxs30Vbr8ewQM1LJv3n27QzK4f6rLr95Nj+Gp
         bTc2vk3wH3hxLZHkMItJKCuflAaHmjg0md6c8fsqsUA+xr+86zeaP08D2bEviwrXeNZx
         B1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002491; x=1741607291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d27QuSpy+kpWSA5wCmX6ePb2qWRbp1n87DWygzb7ZQ=;
        b=OA0oDm+Ed9LZk299o9ysCXzusldoMlkU67SOTwmCuD4MKyhHSDnN/NsktuSlq8m7XN
         hQ3NaYWwgxADHuTafm49TjTjzsFQUJeNW3rA3GKcquF1+hwgtaFhILDBo84B0I5wDP3A
         2cGwarQV2NpyVMXe1H9ybo6daJCYG+BalthKdqsKq/vKbQgSxnK75jY/l4r0uKxFfOAQ
         Liyc5oTc57diOXz2j7WUEttcoTddrIVDfzXtmlUwMAQKLxyXBWswkcs//uVmWJZtBGXB
         hACJM37LR7stibgH/EmcRwC847ayYGN8eP0UdFb3JnijTahSr7/Tt0pzHztUAuLpXSyx
         Dr0w==
X-Forwarded-Encrypted: i=1; AJvYcCWcm8/jPVxQKOm+sIIQ6WEEVatg3OoBss9BoKZO6+WAtvhLFUFzqdUFaCCpTEggCaMftNFVvObbDYlOmWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOQljcxcb47CHqfFS//LJV7sQ3CtXlokGerDuH7VMRwmomSM7
	05cI++P5C2lkwewQQRcUfjxW6jkJTt7EnhpXE5uMUHYLcLU5HpGv40aMPoI3YAgw11jO636CWIc
	UTnEOQ2+NY8sx4H539fK4Cg3WFPgPz/WC2EUv6Q==
X-Gm-Gg: ASbGncvr2rM6XhMdcyMugSrI9Q4rJ6LNV+lVktu6cmHR2skLJhU5qmrKETEtp611scm
	zXS8HNKN+sNULnr0Q2Ev+HhZ0Yony8g224Yimpr+sDEB1nm8AOXMu36pS5YUyDU6KXZM11VUNOl
	9TNgU6CzXHY98ocyaZvwg1Y4Tw+ks=
X-Google-Smtp-Source: AGHT+IHY4RKTZsPxwlz0x+EffBNFnn1gwEl6xaAlLeZ/6mf2UqQ19PPfFUHpUPqZ9jx4BIUjRwHBk146p8gg5ejQdyY=
X-Received: by 2002:a05:690c:45c8:b0:6fc:ed3e:ec3a with SMTP id
 00721157ae682-6fd39496a58mr245848667b3.5.1741002491087; Mon, 03 Mar 2025
 03:48:11 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2309120.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2309120.iZASKD2KPV@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:47:35 +0100
X-Gm-Features: AQ5f1JqlJPhh4XtTkm3850xwbDEaX3GA_R4NEixheKuA3ybh1Xra9hR1TqZF5cM
Message-ID: <CAPDyKFoSr3EmAcJzw36You7BLfq-TY7KkvdtrZ_O4Wq2a=6AYw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Drop status check from pm_runtime_force_resume()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g3T3mNYzG12t
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707885.37746@lc2A+B+L+b+dH/zv8wFtvA
X-ITU-MailScanner-SpamCheck: not spam

On Thu, 27 Feb 2025 at 11:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since pm_runtime_force_resume() requires pm_runtime_force_suspend() to
> be called before it on the same device, the runtime PM status of the
> device is RPM_SUSPENDED when it is called unless the device's runtime
> PM status is changed somewhere else in the meantime.
>
> However, even if that happens, the power.needs_force_resume
> check is still required to pass and that flag is only set by
> pm_runtime_force_suspend() once and it is cleared at the end of
> pm_runtime_force_resume(), so it cannot be taken into account
> twice in a row.
>
> According to the above, the pm_runtime_status_suspended(dev) check in
> pm_runtime_force_resume() is redundant, so drop it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Seems reasonable to me! Please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> The previous version of this patch is here:
>
> https://lore.kernel.org/linux-pm/6038511.MhkbZ0Pkbq@rjwysocki.net/
>
> v1 -> v2: Minor changelog edits.
>
> ---
>  drivers/base/power/runtime.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1982,7 +1982,7 @@
>         int (*callback)(struct device *);
>         int ret = 0;
>
> -       if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
> +       if (!dev->power.needs_force_resume)
>                 goto out;
>
>         /*
>
>
>


