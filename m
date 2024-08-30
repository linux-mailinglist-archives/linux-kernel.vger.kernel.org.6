Return-Path: <linux-kernel+bounces-308924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC89663D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA351F217BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760DF1B1D75;
	Fri, 30 Aug 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2eMQhH9"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287471B1D56
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027066; cv=none; b=HswhbCwYk6kYD+FbO4dBTM1Pvta4iHxbfrjM5MLbCeW4Pp1kLZWBPBxWgOwOAmYMDiRSiTA/AtCoL+zo5K9Ohkk4FAmEGMIkuaQSZt+A+4iTclJguFPaIv4y3ByUawXlMO5VxxxwzSmIerIZCY2M1G2J9tVlbMdzhd34PgzjDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027066; c=relaxed/simple;
	bh=Kxo4HM8TfxhVMBqZvduTJba+uKnQyaKejzhBmWp0U+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6csiLutxDjHgdvS6JdOfvsbTfANeeR65WoBl2IYyzoXYDKOeldiXjrYqptu23Xn0a3Phdew0V1rfjpGM1ZYKXisqURYt9QBQKJGIefMvZll39pDpejA5T7KPtlKZHeNoL1HGSxvMbiZZwtHniK/Icqo9Y6U2rSCSMccfkV37LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2eMQhH9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5343617fdddso3372542e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725027062; x=1725631862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxo4HM8TfxhVMBqZvduTJba+uKnQyaKejzhBmWp0U+Q=;
        b=N2eMQhH9RLyDAfTGhaQ6A1VYOnC9U+Qnxb3P1PZYUxoFPrJMX6GEdx9zg+PAxvgkLb
         /VF8vKxjnlhAc7WVVE7c7+3GemYQZ9fr6tc3KZETBCy6LdheLzhMuXVIU0ts1Gufjii0
         S122HqHVNrt75WzEuybeWgeZQIBmLbFxFCmaDeU0mnDd1xRexOFPdrhdVVXBnmOji7CK
         o0NknaFoqJnI3qF240zpngIGu/7UbKXffhfYkIFhKLmtIGVwWlZNziXkBSd2KzZnTE3u
         /uwQxa4pQOsosi9utUrJI53GsEeTrsVnNPZp6IzF2+7Vl54hnqFLfaKu9AybD3cfECMn
         8l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027062; x=1725631862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxo4HM8TfxhVMBqZvduTJba+uKnQyaKejzhBmWp0U+Q=;
        b=agtUcIJHbF7uNy+rM9O3ZhnuAMpoCVp0TvhEUbRVeGKtcoVP/jdLxZ8MY4cwc4MWCE
         UKslR8KFQrhIYD7Cl2uHeqe0lnf60P0/uR5B6nyJCYosuoxKRoeh3qKsfAnlc48vWkse
         TWDCQQg6VeaHzi2V4dXCOiPP+OeYqzjewgEoEbZB9F+oSORPxrV4R1XO8fwl1K4VxjMm
         lZO0VrN8noDZAkYROfmO8D0tYvfvgNeOmgSmhYeZoaCgxP6jgdSRkMJy3kuOBS5IJXoa
         kXJUTC9yHxMWzSNB/VWBM78NozqnPNwME51Y/5mQPC/bCoHiN9ZKfRKNFMvzUc+k71Z5
         jo1A==
X-Forwarded-Encrypted: i=1; AJvYcCXMqphOXX070Jh1ZAfBVHXfa0xgEL24zuCoKJhJAatOqtXcnOLwt+Sw2N7nK36kjebDQsk2g5dzfnI7PNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBzLCCSNaPSNVRVBa0840KPcfvaSFMjdrDdQ3AxLoDHg2s8wS
	HuuCdi5+kxPlyOQppOcQmDYYc/fXpHSL9HRAIozc1d8CxzFKYX1m7OgDd7v30qhBmzdNa2XuX9h
	ydmeCV/fwVTFvmVtdXllRU5H+Q7oCwGik7PqIAA==
X-Google-Smtp-Source: AGHT+IEgOnI27T01MkcIfr0sPFDlCvh+HVrjFg8GLB5sUtmwg7JKQJFudrMfin7GG+p5U0cHUwxzx9gE/DikJRKk24I=
X-Received: by 2002:a05:6512:33d4:b0:533:4497:9f29 with SMTP id
 2adb3069b0e04-53546b55282mr1789833e87.31.1725027061611; Fri, 30 Aug 2024
 07:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131907.541466-1-liaochen4@huawei.com> <20240829131907.541466-4-liaochen4@huawei.com>
In-Reply-To: <20240829131907.541466-4-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 16:10:50 +0200
Message-ID: <CACRpkdafzWBQ97up6hMBp_tBajfooTp4fW1E2hvc2pLuB46q6Q@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] ata: sata_gemini: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, 
	dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:27=E2=80=AFPM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

