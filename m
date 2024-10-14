Return-Path: <linux-kernel+bounces-363805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5799C74D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49873B22F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4817ADFA;
	Mon, 14 Oct 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="auzNomyl"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10E14A4DD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902375; cv=none; b=Hc3X/QLwtCjrvUKwWLlsi0C5WoQ5V0389vR9PFm0vfpLp0YnK2iuE0ZNyvqYP+jnIP7gk4Uyi5KElN2SE2JEj4O4DxVcGYMi+53ox1VwMTI7Xwqm4WDpr2T3hv9Tbcqky8w25/jYnanxUiCX9VtVEoi9EdMiSqbcQM+Rudi/4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902375; c=relaxed/simple;
	bh=vGJpjQ49w8gK06HPVUKE6WRHK8KhkaqN4tjSHC1kO/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4Ntl78HfC/eLOWDUtg5XqYPtFL1O0VuXW19NkR/vlBItHd02BSp98zzuQhXivYXtuZAX+VChXnqfagyt+0Vrt7MD6ZzDFyUqTV8DQElrwVatfeJKmuVuw+tD6EuXDw1pUXS5rC4pZrEgVAtfxxlWhyU7bJUIYO771cHQGtFPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=auzNomyl; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d431b0ae2so883245e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728902370; x=1729507170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGJpjQ49w8gK06HPVUKE6WRHK8KhkaqN4tjSHC1kO/U=;
        b=auzNomylk9p9oZSTvyl5JvBTzNPQYp3p6lgXBoIjsiBkwIApzOi/0Ln8wTlSOuKa3u
         88SkYVbpH0dgE7/NS4GA3h9Zx+lMp5rvQXOucYr0wWOiv7TsNoRduZVWrx0au1PLUXgk
         rAHJdmgAMNzOtUMCO2VV1B10e0xZcXPxS36l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728902370; x=1729507170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGJpjQ49w8gK06HPVUKE6WRHK8KhkaqN4tjSHC1kO/U=;
        b=ZBv7XOKbdZfBPYl0+psiaYg/bEu8u15D4BkdraS2ga6VDwy9BKjz9YAV5FxXl9lb6X
         ciP8hxCgNg3htQ4xlCuJZtQ/PB/6dB7X2GHLNP1eeribGU8/cHBORfBuov39uxvKGYvh
         p/wgZnSR9q/8XYrfnEA91YmxhKTPjWYFV2P5g8p4xGzxHqvqrrxqVsjiEMvjUI1C9xIw
         zAMAIcfBzyg5w6Tbmw6IVfyQTGotHIrt6ETtuQuCeY7KwFn4iz2y6yfXPoezWo+qgFUz
         VognoKegmznEw32LOAxMc1HlxMLue3ltcrrU36d8/zjpm/2Gkse/2VerB30pdrIId5x3
         jCWw==
X-Forwarded-Encrypted: i=1; AJvYcCVdUKOnC2+oiGF8Xp/WgUwv+X4c0R/pXH6bmiO922zji7vFsEwzpFmWz1v+xCjxCURSQCVR15WK6gq/mog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzscV8S57zeKf7xv0b5wsgmnbm04YFwbHGTQAg12yMAGDP+Iy44
	bTm3OHGOFGrF2vzS61OTQVSZzwVFafqw3tY39ZV5+37A3GZI7k9eykpC+RXslnBbHaEHwTXAT0k
	98Q==
X-Google-Smtp-Source: AGHT+IFU5CPZnZlOO2snNsejqiFjvIJKd1LHjHoQzP8J8Pc+4l3HkEMX025DyU3BkjIElTEbsBCLKw==
X-Received: by 2002:ac5:cce5:0:b0:50d:45e1:f32c with SMTP id 71dfb90a1353d-50d45e1f5e9mr2420577e0c.2.1728902370249;
        Mon, 14 Oct 2024 03:39:30 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d3054d673sm884698e0c.23.2024.10.14.03.39.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:39:29 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4a46fee3b16so1202374137.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:39:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXI0gESDxqQE9iGDxRWw3br4bnxOosBorhGTkXTljeRcb2iQ9GL5+VaZxbMOuwppoorHzsoersETTcHjiI=@vger.kernel.org
X-Received: by 2002:a05:6102:2f5:b0:4a4:8502:491f with SMTP id
 ada2fe7eead31-4a4850251d6mr1181599137.7.1728902369150; Mon, 14 Oct 2024
 03:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094622.1720289-1-fshao@chromium.org> <40ce7287-7fed-4670-b16b-695c36535661@collabora.com>
In-Reply-To: <40ce7287-7fed-4670-b16b-695c36535661@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 14 Oct 2024 18:38:51 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhwn_ec4-ATNkEzUOpfUtZPEOb0niXpr202U5ysytsNxw@mail.gmail.com>
Message-ID: <CAC=S1nhwn_ec4-ATNkEzUOpfUtZPEOb0niXpr202U5ysytsNxw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8188: Fix MERGE's alias IDs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:34=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 14/10/24 11:45, Fei Shao ha scritto:
> > MediaTek's ovl_adaptor driver requires the alias IDs of the MERGE
> > components to be indexed from 1 to 5 to construct the MT8188 vdosys1
> > routing path, since merge0 is particularly reserved for vdosys0
> > according to the mmsys routing tables.
> >
> > Update the alias IDs to ensure that ovl_adaptor can find the correct
> > MERGE components, allowing DRM to initialize without issues.
> >
> > Fixes: b13ecb7c6f67 ("arm64: dts: mediatek: mt8188: Add display nodes f=
or vdosys1")
> > Signed-off-by: Fei Shao <fshao@chromium.org>
>
> I prefer that you resend the original series with this fix squashed into
> the right commit instead, as I can still replace the series that I picked=
.
>
> That makes things cleaner, so please do that.

I see, I'll resend that later, thanks!

Fei

>
> Thanks,
> Angelo
>

