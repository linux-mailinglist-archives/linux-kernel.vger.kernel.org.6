Return-Path: <linux-kernel+bounces-381220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1329AFC17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82811F2339C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C01B6D00;
	Fri, 25 Oct 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EmI2siGf"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50F1C4A29
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843661; cv=none; b=oLWECYPgg+55XKX3pBnph3CL6EfjFS6ZV99pi7FnvTsN1tLtTPZMtcpbWkcKN9RWJRnFmCXO5D0w/z3A0AeyqscvvVJGmFtYdaL5q5+qa+8IUtkmhzuPkEWAbiAFIG4fyL2gK9AFRaIQ+GVw9o7ju8+V+UmMZd+Vi2H/Qm/UbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843661; c=relaxed/simple;
	bh=CMzPrmjSeQgyPIDRqjhVnnO2Md44vEBUyZpNM1GWQMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqQBJ6S6e8zzqftlMcteqqsmpze2GCXD2sMFwDuvCvsFL/tzPQdiyDT1i5/Yu2KSS/7+OsgoQfJYvFOrhYG4VjVpCVQ1iDmlZ/4ECpCCOgDFQBLcKYWHe+MOPWoOfCV82vip9lh+IPl8kXTNOAjikdxGTd8jESGxtpqJ5x6w3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EmI2siGf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1204268a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729843659; x=1730448459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMzPrmjSeQgyPIDRqjhVnnO2Md44vEBUyZpNM1GWQMc=;
        b=EmI2siGfVjtQNg/ofTz/itnuj1Z4ORiOncCTvKodrzKH3I6LAUnBzWo+4E7MSB+Aq0
         QJErzIrgKsEPdIy2E6Cyl6cU9+uL2QfiGYQVb1kQDSejV+F2m/hjxp1RpWH5zzhxA09r
         ++zTAWkjqidv0NorNN9gDhB2LhGf/w3OCnTsZ5AQMKIaq0YcBB4VHQFgm0zZSm2HuriB
         jsyJGRl78DIzA8u7+USX1XdaSRXUIEm7Lbx8mHiLSVnldzDEfwZEjEbLgZMRr9KGIQB6
         tT1C+LpdrjO3lSTMBip60uNOtffhZOuuSBzgIIlkx9miu9nTBBSBnyevYur5rzyI9q+n
         T5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843659; x=1730448459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMzPrmjSeQgyPIDRqjhVnnO2Md44vEBUyZpNM1GWQMc=;
        b=TXgX/wjMxhBXQq0jFE2s7bgNjy4+Y8mA72vPWp/q+RAw/eK+qhtzC+elmnIMJfJ4if
         BrtLp2QIrKXHxHhIQzDuf5m4KZyzlWe8xFt7Icf3qzsq5vZVK9ip5nQ1coUIsIHIrR4A
         mBno2Di44mE0gCKqL/0liIgYTgqcE37csDcjYTlYzziTQdrX70sAB1kfkYEoeQeV7ABD
         CzZgiRNz8WHT0CwL0jbQTPThGqmu/LxE9ufTJP3dUdHgp4i8tTRr8GQraBrhRmmHM9Qi
         HWYTI14EOoSPctkCQqMmxzdqmQ1ynUI4AJj3NO6PPfW8nrVE0TMnP/lrU3S2Uy6sFdH9
         0IJw==
X-Forwarded-Encrypted: i=1; AJvYcCXu+2z8ofbD3BbHfKgDPfFm+w1ikXDCAQhvGT/B1c668OBpiGliW3aHbhFtrREjQAsxlngb4u6OF9Gc4Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThlzmMK/c96NoUddSJIqR/eDZQKVbQH0Az7I/K7F5ofusSf7o
	1IMmO9mPYNrnQsZtQWVSeQiv5zBJdOexAJ5N00NA8kPSXCXXdCwCeFmlJUDUyrPaewAoWUfLIUL
	JN2QG41heU0Y3eu5qbDiU4R0Z1n6nmf2LogQJ6A==
X-Google-Smtp-Source: AGHT+IGW1lxVwYjgZLZEEGxXj/E49c9ozc4sLvlK3AOIA3FBQVBY6vPoD9RntfkOGL5I9pzZ2gxz9e7HE1ZOJMkaPZM=
X-Received: by 2002:a05:6a20:4fa3:b0:1d9:857a:585c with SMTP id
 adf61e73a8af0-1d9857a651emr5605791637.19.1729843658910; Fri, 25 Oct 2024
 01:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org> <20241025-pci-pwrctl-rework-v2-4-568756156cbe@linaro.org>
In-Reply-To: <20241025-pci-pwrctl-rework-v2-4-568756156cbe@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 10:07:18 +0200
Message-ID: <CAMRc=Mf1ytmuXWW+1YvqMPBb_DzX2_n0kL-W6SgyPGsMrnq6fQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:55=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> This makes the pci_bus_add_device() API easier to maintain. Also add more
> comments to the helper to describe how the devices are created.
>
> Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

