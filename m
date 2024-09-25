Return-Path: <linux-kernel+bounces-338399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4D98574E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3640D1F211A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08C016F0D0;
	Wed, 25 Sep 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhP9G6VI"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B59165F1C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261056; cv=none; b=q3rrzSyGuWtxJ9j1ttyYdrhfX5oGHMhrpSoHzIkmsZlHCR1APtJpjkQLeUYAS4I+zM98C3ry/+4cibOATvd2igkUC7ZG6rObr9bGgslMFSt6gAXYexaTixgJ40ukl3BqTF2LGKSj8ttZdcVpX0EgXrk/dqT4ZCJeaUVn32HDi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261056; c=relaxed/simple;
	bh=6vOHl1VdYn2VePnbuw0FDYDOxo/fTsYaSPfeyzNpL1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2/3CDDmaLqB1tVchgssR5Z/TAW7BUGzK3oo2IJTlUa+HiB03ZsOMWi2narAIeRR1nYUfWCdHGKnA/g9iNy7HZ4apFX0ZTCDHCCO9G+wIH55eQiUWDtkShOSs9l3xF17kHd7JlMdFtpdYF1iJhie8JFIrIAWaYoIJRwYW8FuCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RhP9G6VI; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-710d9b33303so4817814a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727261053; x=1727865853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p18jL2hLutiaep38fb0ejRXREkRooHh3eI3tmn6pG+o=;
        b=RhP9G6VIw+NResls66q8PhQPz8eP4a0DhBiTjxZvVUdUz0Sh6SjS1XyvxzbiiLuZEz
         baXqJ8OxK+/ZFMlUCzH9IwixZwbwj5H/WJDeRNKyfibmwdhgpEc4CBhM6hPQqM7YIZ87
         AnShkv5OmABC4EOJ9UsrUIUp0IsVLxX0egdmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727261053; x=1727865853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p18jL2hLutiaep38fb0ejRXREkRooHh3eI3tmn6pG+o=;
        b=oIbrIvsHcY5CE/vX96Tbz2uBbDLzObozt+rQrYyOE1M8xyuWlmhw0MPfc/eyqDXmHE
         fy+wOquWaHaon4zB8KocKv54m+vhP9cdaEY9fFejBmFHHg0Xs87fUNk0u9h+gQ4eGiM6
         G2KkYvGi2VJAoY+Dg9SRZIf2nK92aGwZttMlQLSzHxIBy7uB18FZAaO9XTBFGw7kRLew
         8k0Up3JZUgdY9idS8PHS5qMCK6lTG3O6K/TrysRZamCEsdI4BEAD4OPfhjBy3XlUJSRc
         DFIR9fP7cqhvc+wjtx3upRFumdRBtCPgqE90FyChnowuVQH0DfYQqYCZKOntSYUU1MwW
         4cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVy2U3hYRLqZblUctQf+JA321VD98lGkkXmUfEqVgQF69vkeKBxlVypUleDYYoEkR9ygo1d4mEgt4LhyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMyUQIaaKkBv6OpUsvw1EsOfOCp7+qt8axs3vlMDutLfDcsSn
	quxW7eFmaUzpbNhiOj152kAEUKHeX0XJ+dY47EtIzc9cWBWIPsXXRHTnFqsq+dXHAO4SD54XaBW
	Sunwnd7846ZNy+5tEuTlFGOMQkMvONvffQ5UK
X-Google-Smtp-Source: AGHT+IGhoxWoyLCZ1aRxjjHIcUx8YFuna6OqcImZMuxL9OA/2tyXvCgmuAskMzvWBQ9WRNUkhBGHynShOaLw7Va2Cdk=
X-Received: by 2002:a05:6830:3894:b0:70f:6f4f:e8d9 with SMTP id
 46e09a7af769-713c7e2e146mr2486302a34.20.1727261053556; Wed, 25 Sep 2024
 03:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919094212.1902073-1-treapking@chromium.org> <172676985046.765320.3471835988677145017.robh@kernel.org>
In-Reply-To: <172676985046.765320.3471835988677145017.robh@kernel.org>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 25 Sep 2024 18:44:02 +0800
Message-ID: <CAEXTbpeATBYmHpCYAGhiecVeH=+R8=E0aLLscnKV4QyVbfrWJw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8183-pumpkin: add HDMI support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 2:18=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Thu, 19 Sep 2024 17:41:49 +0800, Pin-yen Lin wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> >
> > The MT8183 Pumpkin board has a micro-HDMI connector. HDMI support is
> > provided by an IT66121 DPI <-> HDMI bridge.
> >
> > Enable the DPI and add the node for the IT66121 bridge.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Co-developed-by: Pin-yen Lin <treapking@chromium.org>
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >
> > ---
> >
> > Changes in v3:
> > - Update commit message and fix formatting issues
> > - Fix the label name of vcn33 regulator
> >
> >  .../boot/dts/mediatek/mt8183-pumpkin.dts      | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=3Dy mediatek/mt8183-pumpkin.dtb' fo=
r 20240919094212.1902073-1-treapking@chromium.org:
>
> arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb: dpi@14015000: power-doma=
ins: False schema does not allow [[76, 7]]
>         from schema $id: http://devicetree.org/schemas/display/mediatek/m=
ediatek,dpi.yaml#

This warning will be addressed by
https://lore.kernel.org/all/20240919112152.2829765-2-rohiagar@chromium.org/=
,
and it comes from the dtsi file this patch includes.

Regards,
Pin-yen
>
>
>
>
>

