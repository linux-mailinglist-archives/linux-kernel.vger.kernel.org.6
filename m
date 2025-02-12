Return-Path: <linux-kernel+bounces-510785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E8A321F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616AF163B98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABACF205E20;
	Wed, 12 Feb 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMMs7dZB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23C205ADD;
	Wed, 12 Feb 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352073; cv=none; b=Wd7gt4klY+If9T2ZaXUebI3ZdIq+lwFcNWS99hXS5fdtdtI/42ZvUkYl3CyeE0vkqGXR7ifXKkqA/Sltof44eKZnjXOePv0qDnx23hsUjlP65WrB3UX89qUlbolgG/+Je8ysrafx1QvijldCI3C3c9Gy7tYyk5ArJEgbGgrozHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352073; c=relaxed/simple;
	bh=ZdCk17au8xwp6xQabJ9SUU2OiCQghf6je+QyJ5T8xMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eg9h2EvcHWST08uNcvbYltk/VaRMkxxRSFoK/cgNvIDHUFjpJuSD8VUkdsjl7eBCk2iMYsUxlARqUvbvvMAxgU8/LUqZ3mxkN68rbDpqFRwOLQYHFt/iA/4xA8IBabA4dXZ2+wvRo6t2A2egPV8Jf4hhgR0OjQDXNEpo5Ra2B+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMMs7dZB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c665ef4cso1864315ad.3;
        Wed, 12 Feb 2025 01:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739352070; x=1739956870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdCk17au8xwp6xQabJ9SUU2OiCQghf6je+QyJ5T8xMY=;
        b=NMMs7dZBkVhdvdW71OGbM6QDA+eZWmhprNBqtuR9+XRIMSNkb1EHTQ0fpD4OVJ9DI0
         Iw69mFQ2ODkrLwxBP7JjkFrq267kuC8SWsQhm1FI5KJBK10LrrVpFJ99V+9TDUwz1jTq
         DrB6/O6CCfaWzEs5FalCAkPI+C9OfVnJJigynVhyn9/DLzg4slbqJJLjpsXA9CpUo4TI
         W9hx54PvLmPgrDTjCZiNeJ6X5bCLfLP/2JfXkjfmB51eE7pRVuoPSKbkVGjXWCzr0rwf
         YF91+5Wb3VPMgpWSgdjM1X7ajSaFGJTuLKzcbqvywekjfMjaSgQNexMY8YhHj1awmWpp
         d2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352070; x=1739956870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdCk17au8xwp6xQabJ9SUU2OiCQghf6je+QyJ5T8xMY=;
        b=Ak0yfJ4pPDs/hLZzBIvt964t53H8YoIyB7GdcczTZkCvSdCrrN+u0Xau7lISJFbFKi
         Fq80cIFN2nYD+QtSKfGnrGTQPrpR+xO3i01vjJJ01lObE/uHp00csq4/H4IJDKYlXV1i
         VUZpmsBi/w7CurOQlM2LvSfvfG/MUqW7VUvLLziueWrUODfS49d5bo2lAJKHoXIOXf+s
         knft/ZLfFKoZFQW2UMdpxjDwLiWIgQx/lHspn/dcUodXWq79SEb/0q5DdwhD8RChWPHc
         ez0QKNDDSNi+nn1Hg1pfhPdebsOG6XA9PNCboBN/Kqxly/jasqIvmO+At74cpFX02Zpn
         238Q==
X-Forwarded-Encrypted: i=1; AJvYcCV67DlfWpD8BTZ5mwFBIKgEzugI6crLOWZLPgrbh9dtMXlAdewE/LuPU75AuVUpsX+tElkYxEPI0KIIdxI=@vger.kernel.org, AJvYcCX9jn5eZRt2z9BrxC+7KmbPk4aBioys0J0GDO/oI32joIu1To/qbGXet7fnghX7c5UJiv/j9BkTVFNdV9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPzs3+DsO9iiVXhy92btZUkubk5UspzOWuVxRaEyICx4tIZOR
	UQvX/hGDQdvbeB9tW7PDIU0cH/GBMy638BDqjouZ1ExZjZvTn+HnOsoW5ZmEJWo58eEWFHnjo3u
	vFjrVoW9EoKiknOXTQHlqRjLSyPQ=
X-Gm-Gg: ASbGnctAgyLPuuEd1f+E/p5K/u8ikJI2NPnGcwR2CaPh1HyE1YNCFtAzPwlE2vT3YBB
	DmhGxmcNEKJCyGTe+eUOsMFbh5w5pQ0nmNOrO+celkvjcnOqc9dE0wZy+zLdDWF3xsqzYQw==
X-Google-Smtp-Source: AGHT+IFIYrNXPCtCpXpuE+cUBbtKtexwn5rrPm2wY9NepWlkuErIAfcW8lAkQqMlLlKPI7uSLLuikxG2ZiJyOJDuxzY=
X-Received: by 2002:a17:903:2289:b0:215:4d90:4caf with SMTP id
 d9443c01a7336-220bdef0463mr36079195ad.14.1739352070395; Wed, 12 Feb 2025
 01:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211225018.2642-1-laurentiumihalcea111@gmail.com>
In-Reply-To: <20250211225018.2642-1-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 12 Feb 2025 11:22:44 +0200
X-Gm-Features: AWEUYZnMCWedaqcatxfni4tn_ELXHzMLDDkwLubYPADMeAbDeWbIHEv8qAemnDM
Message-ID: <CAEnQRZBEKoXeuUXat+EGfGcYMGKpRW-2RgNQWnKLXSxfKe+oFw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: imx-common: set sdev->pdata->hw_pdata after
 common is alloc'd
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	imx@lists.linux.dev, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:50=E2=80=AFAM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> 'imx_unregister_action' uses 'sdev->pdata->hw_pdata' to fetch the pointer
> to the common data structure. As such, if 'sdev->pdata->hw_pdata' is not
> set before adding 'imx_unregister_action' to the devres list, we risk
> derefrencing a NULL pointer if any of the calls between
> 'devm_add_action_or_reset' and 'sdev->pdata->hw_pdata =3D common' fails.
>
> Set 'sdev->pdata->hw_pdata' to point to 'common' as soon as 'common' is
> allocated.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Fixes: 651e0ed391b1 (" ASoC: SOF: imx: introduce more common
structures and functions")

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

