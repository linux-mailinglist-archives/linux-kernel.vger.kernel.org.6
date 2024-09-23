Return-Path: <linux-kernel+bounces-335701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1A397E957
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C71C20EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C8195B1A;
	Mon, 23 Sep 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mqd31uB7"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24651953AB
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085951; cv=none; b=a7cH6Cn0Jg6O8vBxpj32g/kulnnkhBO+UPc3uDS0tIoNzss17v//564cSKmD1KRfDZzKGzqiDUnkGpn0Zy/p6ei3BycePjlsPa3vzyAutWLQEweISvhhjE/WPMY1KWm/7OzV3twdenA6Z8q2WLzmJ6039OuYTDDyMRljq4+z+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085951; c=relaxed/simple;
	bh=5xJdtdhV7q8ohpMQklnYYogPu+uXAwCgLJrxI+TZY9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thExtfouPRlWZ67wsZ8TDIK3hYjhA6RIHG0IzeEdlwnUhp+oFetHhlIqaiYEYV1TJwOCRBoCPa8VvSMYfrSpSWp3WLh7Z/l9x1FMZRxN7f6bnvkdlYNW9mpC0Yjf8gYBpTsgsxil/YJRepBdYMqc6agqQSF74SXY56+znvctmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mqd31uB7; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-846bc787b3dso1135436241.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727085948; x=1727690748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xJdtdhV7q8ohpMQklnYYogPu+uXAwCgLJrxI+TZY9k=;
        b=mqd31uB7KcsIHxUWDYAnn6mtL4OBDDEFwMc/hx3S0lQ/tHtOD2ucBiuIBtCoZN1Lin
         C//mJHp8Mi8ezyw/5smkcmNJHFY4PmXJ9cD/G8psv3O7HJE2xlMkmMhO8/L2n7gP2Sra
         +DHOGGD8K5ZwaGsbXm/m5rT1+H+wO4pes3NhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085948; x=1727690748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xJdtdhV7q8ohpMQklnYYogPu+uXAwCgLJrxI+TZY9k=;
        b=PK/79YJ+fy1YntWT1RJPk2sHic5ER5baLEaEgCojoYdvUfqyLrBr3O1PTVzaa2S/MA
         xnCoWDb1r4KtZxYsINTKTKlBmfzaQYo6WbFPk2ANSaF0DcibXLw7PGWBsVlkAbz5obgg
         c8pMb43Lkvc2VyXqYImC0evp+XdeON0R68+EaroPdg1bWLx3vh4z+KQsMkx4RX+gk5OG
         LLyvKummLsmDBM4+HCR3dsricMllL/p/cgkMwv4BcoU7e4ucUTvwGS3KD7hhnVhdG25I
         lnsjQk9jT9eM3T2C2+2NmHUBNcqMFeNI2Ohm47ClFpV99GWc9VHWZ8rKjlmKmRN1lm5E
         OXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVco11aFTfY2UtOBTde/6s9liIU2WaJU782H8dnLUunRikaTRBqDGEWLnK1yV9LEC5bE98xoKoGzl2Wmyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKtYm5ZVBEX8LggP+jXh4c61SlVFlSFoBXv1nfBo8Nfu1jq6M
	4Mmlrs2nQSj++T3vLv9M6idtm04FKiNaztkfWIq1v5rKN37LiAxWS9PQjk1ad2E288NaicbyuvY
	=
X-Google-Smtp-Source: AGHT+IElw0mIr5KAceCtdgBlyfCBaNr/voDmw2G9YG9PeYP89zcnrn4S2ayem6iqGfy3a9GOFho9ww==
X-Received: by 2002:a05:6102:5488:b0:493:b9ae:31ea with SMTP id ada2fe7eead31-49fc751eb59mr6889635137.6.1727085948209;
        Mon, 23 Sep 2024 03:05:48 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49e6ad8b475sm3681430137.0.2024.09.23.03.05.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 03:05:47 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846d414ea6bso1108822241.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:05:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0Zj9bk6Wxi8OGp6idFikJopN0e963meU+35rhV2G6IDxFfXUcfYfYC1rfJiZzPTgZCsH3/GbWRQ3D7aA=@vger.kernel.org
X-Received: by 2002:a05:6102:41a6:b0:497:50c0:a6cb with SMTP id
 ada2fe7eead31-49fc7626228mr7350845137.19.1727085946795; Mon, 23 Sep 2024
 03:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com> <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 23 Sep 2024 18:05:10 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj6AdVHoBUJsduHiGfpRRijTx+zJ5e=a30+pYENqO-GOw@mail.gmail.com>
Message-ID: <CAC=S1nj6AdVHoBUJsduHiGfpRRijTx+zJ5e=a30+pYENqO-GOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Wed, Sep 18, 2024 at 4:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for respecting the max-link-speed devicetree property,
> forcing a maximum speed (Gen) for a PCI-Express port.
>
> Since the MediaTek PCIe Gen3 controllers also expose the maximum
> supported link speed in the PCIE_BASE_CFG register, if property
> max-link-speed is specified in devicetree, validate it against the
> controller capabilities and proceed setting the limitations only
> if the wanted Gen is lower than the maximum one that is supported
> by the controller itself (otherwise it makes no sense!).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

I confirmed that v3 addressed all my comments in v2 (with some in a
more sensible approach), so
Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei

