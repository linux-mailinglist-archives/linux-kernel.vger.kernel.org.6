Return-Path: <linux-kernel+bounces-312920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E10969DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9CA1C210FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7DA1C987F;
	Tue,  3 Sep 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4TNSYdR"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC31D096C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367067; cv=none; b=aLGzglqcViBjEsblKxc1xfjd1opf++aTa4Smx/wk7ctN//Fx/JFUjJvoIj99L/1sPdJ8ur7TaFUnw2Y4zAxMo4JqOEWpbtodWXR8dzkLgeX8WdxE40TzVvfqNDJD5RjTDQlo1kZEX4k6nbqnDru6ke6Vha8CwVEiMK6lR+oox5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367067; c=relaxed/simple;
	bh=w0NDR4g3yWZcVdllP+36hvrmByCu7wczMm3XTMj/jGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpuRa4S/G0wAeNWS6Fq1/UiFOa6AF8hna7kQR/txIq2ZKGWWfIh+FjRfT74DNXLXoKzW9LLiiEgjfAEg2lEHRsUmRVcjhjRgWChowxha0S+bPZP80jOOs90R2/NnqMPSr6JeKyBa3Y/3xsiVMZ9trdYyQYZDiYVmBzIBsJoLMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B4TNSYdR; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a7c25e350so3903874276.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367064; x=1725971864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xRSvMnDTMDKxhA7VhtYh7uLTsocsLyQdi8v0n2nl6pk=;
        b=B4TNSYdROzfSRY2GSYbhWSiTJ2y+IProWkB1BIpcDNtrVd8Vg8k38hVWC3aoFTjSZd
         B1U5eIWJZ3QRkNkowCgI5SVw6csdua6+V6O91OmPrSsiNjtjUa1OCVFc0AKuRRNOmAI3
         rQ+QwqN7MrpYOmE2ogJjEkrKYuEjniKLiPcm4IOCceNM3UZx27C1EDr1saEKbzmux6uf
         R7KoerIEh7R7v5timvpeMMnjiyJezffBhktxJ3gr2iQBGMy5qfm5hEWtuU7XxDDwe03K
         0qpxeeP/BQOEWKVTThAxpZMFn5D4xzkxUQsWcjCCxkc8LOivTFrS2hbwS7ZaaaS8nPoI
         pABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367064; x=1725971864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRSvMnDTMDKxhA7VhtYh7uLTsocsLyQdi8v0n2nl6pk=;
        b=eavQ2YUm/Mn9jMAnBVgGKw+I9ZaYo16ADWdZyBjlFilsrto2RF9CaSrIKY2S9AwDmj
         W+T5hOT46Rv7T9G7+J+/9ofJ36HA0oI87ok11uualOsuOAunFRpyskiS3LnCO4LENezN
         KexqCPIU+eCGpHoa1BdE0BeYS+2b27QtEmIj+Kc9r4B8pCiD0t0e6LvvCYXGP+JZ0TuG
         XpaKo+E5tmxZAtlLMmbRIVE59YWz3wJMsXdrWAsuLOWfd1zaCYynhaXke67jTsMZQ+Nu
         YjBFxd9LNmICBREjDPA2JNoPUGr3v3xTVntZ+DIoDQlHgrntxNfuxe/o0ugBnmAALeLw
         JWDw==
X-Gm-Message-State: AOJu0YzhUbgkeYEaXj0oyy+PgHfR3wIhqOK2HNC39RzN2FhSDWrVS+MG
	JzGkvGEuG20UT9BsEyq68vJg3B7xdg3bbS+97ZE3y38t6JnPSBJ6ste8C0vDq+5oPzNuYw2+KIG
	FrTKZpamW7OYb9uyCHGpxTSauF6pVZQ1S5nh9dw==
X-Google-Smtp-Source: AGHT+IFQF8b0/Dxwwp4pWzLNZOOlIYeobiuC9YLSQvh3EAc6u9FMJheFaNSQtuz4xhHdNlC0iKN7ML0RWiRLCHQ408U=
X-Received: by 2002:a05:6902:1b8c:b0:e13:c6ec:2a7d with SMTP id
 3f1490d57ef6-e1a7a1a1cdemr15286662276.37.1725367063845; Tue, 03 Sep 2024
 05:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <010201919996ef8a-db8bbe89-3c18-4dc3-bd0c-6498f09d978a-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201919996ef8a-db8bbe89-3c18-4dc3-bd0c-6498f09d978a-000000@eu-west-1.amazonses.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:07 +0200
Message-ID: <CAPDyKFrZKq69yHnA1w813b6nwy1Bn_A=1c133CSk9scO1qMxEg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add dw_mmc support for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 17:24, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> The SD card controller on the rk3576 SoC stores the phase settings into
> the dw_mmc controller, so the code has to be adapted to implement that.
>
> Although the feature can be detected through the USRID register value, the
> decision to use it is based on the compatible.
>
> The compatible for rk3576 is added in its own group of compatible to mark
> that all devices compatible with rk3576 have internal phase settings and
> don't have the ciu-drive and ciu-sample clocks.
>
> Changes since v4:
> - Drop commit that ignores phase above 270 degrees
> - Use a bool instead of int for internal_phase field
> - Fix pahse typo
>
> Changes since v3:
> - Remove internal phase auto detection
> - Set compatible in own block, with own dt_parse function
> - Add internal_phase variable
> - Use function to set clock parameters based on internal_phase variable
>   instead of multiple ifs
> - Use different commit for skipping phases higher than 270
>
> Changes since v2:
> - Drop rockchip,v2-tuning and use compatible-based detection
> - Fix coding style
>
> Changes since v1:
> - Renamed use-v2-tuning to v2-tuning
> - Rewrite v2-tuning description as the hardware feature
>
> Detlev.
>
> Detlev Casanova (2):
>   dt-bindings: mmc: Add support for rk3576 dw-mshc
>   mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
>
> Shawn Lin (1):
>   mmc: dw_mmc-rockchip: Add internal phase support
>
>  .../bindings/mmc/rockchip-dw-mshc.yaml        |   2 +
>  drivers/mmc/host/dw_mmc-rockchip.c            | 217 ++++++++++++++++--
>  2 files changed, 204 insertions(+), 15 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe

