Return-Path: <linux-kernel+bounces-205433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334D8FFBAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F4A1C25B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA720154BFC;
	Fri,  7 Jun 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4OdTJpX"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768F15445E;
	Fri,  7 Jun 2024 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739986; cv=none; b=RECfUqsx6FhhW5nv4K5sBYM+h9H/EC1aPAWpyCy4Bc0ESXFpDDQCkgyeH35qmlQdMxoxjB9MkCE0Vzdr9zYbQmhY5Ioutd0ycHOd3jc1740TEhO525mVVdSNzVGa/SFwajWZ83RiYn+QSZWjN023WAjs/RgvHoqdjjAeJhZffJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739986; c=relaxed/simple;
	bh=xxyLTG4PairDBd95BG9wVtDRGiCBMoa8cSAmHUrk1cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ek80SK2WVXWrlM85Aioh7yln2FmlYifkqI3MSdlBjRQvMNaW7vx7BeCKW/fQ/DPjt4/8LKqqzxySAhQKJUWDFSTIIqhhOuejqJrNjqo0kB2Z+pBMCZ1iW9P0kaWZhP4Wjqa9k56RIEwvazaPY4oK6B10LVv8vIeB8U/w7Ry2V2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4OdTJpX; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ba6214258aso884529eaf.3;
        Thu, 06 Jun 2024 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717739984; x=1718344784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxyLTG4PairDBd95BG9wVtDRGiCBMoa8cSAmHUrk1cQ=;
        b=b4OdTJpXTuvU52y4ver1SFo5lYF2pKsFT0z21Jsksa6nU11RgqA0UQ8UJLTgSQLVF4
         WszYKjuPM4KMuDCaIDyUuKEZpRTtdT6xMR49KdbE8VeBACy+HtQen6NSJTqcvUrDNG91
         yofkdF2DgM9qrktd+ycFjAJCr02/hI+ZNnmecE/7x/nVZR6ofdJPO1sZHChZKZ4e6xVB
         NtfJG/UfdXshR9qdNEBbMDb0TLGQFbXLyhTs1Rnsqt1TNx1eJ0gYc2DCv/9L8ycCdNzH
         eF3R/v4xqirneqnzLJhw08wrGhIsosZTgK16a0C0eh1gWymMeqL2XiOXU4Kur79mOOxN
         SdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717739984; x=1718344784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxyLTG4PairDBd95BG9wVtDRGiCBMoa8cSAmHUrk1cQ=;
        b=h/DfEtgLbBubO9wIOpeIIniccwCplo0L9T0rTs/UJlRiSx8gsWRH44ToEMCI6qMZLa
         Fv6pfZU2ywJmb181lKqLNnEIuQ0aPe58hwWNS+EM8sT1Zexs02EGgbGZx74YeOVWEFaT
         tl45FLkzSNwzrseXuX8XQpdDLKSr9fDBNv1QeIWPLewO19H5gOYgmzx/IOteFqfp3+yB
         Bx96ZqvzNTt4/mGbF16xqKeUEMOUR3MgoF/lthwzRCM4Zl5KoOnBoZztHXTHQ0f01Bkz
         CbUpFvZ8O6crbo5iB/NHv8twOchNcB8/uwsZzhUYMuFqkvkK7e2xWBEsMZ09jd2gGVjq
         rzHA==
X-Forwarded-Encrypted: i=1; AJvYcCWpAnk7pwuN9iVGFK8PRSdnDlsNTw4efGceuDYL98r37+ze5cDBuQmMdYsfcRianc9UZZDx9rQ4MmvV5MeV5UToD8YsiwkLjbHbykfRgzIDuQUWv+ylZ8NwAJ2ca02JcvsU+XFjKEG3RuZ5RwihfIQkHYg9pVHiLyNQgVDxxTVfneVbQLvp
X-Gm-Message-State: AOJu0YzOgCyxCyjaKcLMgKSHwdXlmUVQDRls/GBxitx7iYBnPWdM1X37
	zSBnvdx9pH+Tp689jUpnfHqfpIIbqmMZnS4FnCq+3VYiq88i7n+gCenBJ97fJF7NU65e8UM8jA6
	Ovhyq8dNQ2qObpxthBqaFxJkOfzk=
X-Google-Smtp-Source: AGHT+IH5W0gfVqfuq/ypqqH7aZdn4I/XEwBH/PoEos4U0JoETE3oQbpgpTeQjbKwHUafUz1XOtc9aYSxQxGWMq9p/lM=
X-Received: by 2002:a05:6870:ae81:b0:24e:8987:6f34 with SMTP id
 586e51a60fabf-2546444f27fmr1751733fac.3.1717739984106; Thu, 06 Jun 2024
 22:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605112301.8171-1-animeshagarwal28@gmail.com>
 <20240606005332.GA3526959-robh@kernel.org> <CAE3Oz82TsuDq5wAW4TSNeUuR0DTixAQPtJnCc3-5J7MnBYtuRw@mail.gmail.com>
 <b41a781f-33bb-434c-adcf-97f494c689e5@linaro.org>
In-Reply-To: <b41a781f-33bb-434c-adcf-97f494c689e5@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Fri, 7 Jun 2024 11:29:33 +0530
Message-ID: <CAE3Oz811PCdX811Vxcercmc5EfaHmN1k4hacnZG6YiZVdgqsqQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: linux,spdif-dir: Convert to dtschema
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 1:27=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
> OK but perhaps rename into dummy-spdif.yaml, no ?
>
>
> Thanks,
> Neil

I already sent a patch renaming it to linux,spdif.yaml. Is that fine?

