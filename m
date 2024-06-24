Return-Path: <linux-kernel+bounces-227626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE09154A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C307F1C21DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7719CCF7;
	Mon, 24 Jun 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1zaXE/2O"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070419E81C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247578; cv=none; b=iDQOPeKkS+cfQ9a6LrLFxvkveP3EUz7MAWhV3eyoNp3raMTY8VU+1HnjsqIPWSQX/ljRzmRD+E9yLt6n27wKs0sURQo1FEPzgBbKeLlvCF8xo/9lQ6aRSN0+fuWCVdIUM+/xgvdQueTt5+nVF/jl0BsLnH7xAcdrelhSNwTMvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247578; c=relaxed/simple;
	bh=j3mtCDro6szPMoGWAAjyIwhY8Z8hnROYefTX4WK/Chc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOuAmyGxBPN8dVqhh4Dh37KY+9gLTbRzVXCFejh6cPXxex7+PcR8m1g4k9Z4/P1nKnAPro3uLy8J5XahS3GFCRFetlRsqW3ih/693aeTsX+bR8RnfzMAOeA+SAK2WOIfP8XtAlrK5KO1Mno/T+ELKwUJe58HHGk3q7O9Zh6osbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1zaXE/2O; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-443586c2091so1101cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719247575; x=1719852375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMSaelTgm9+gZJLzvg/KOZGEZUTdUOqVskLSww0Rudo=;
        b=1zaXE/2OmbLVH3YFlvHlhrCUNdqVIEoEgQbgiPzkP7DCI5I4nTGOH50t/YuZSEK9qi
         HpcuI0bwf2BrNnccQ6Wc1aM+E+IELLJpNWRQcVLw4p72m1WlDz0cuZxqhBv0D+1b3rZl
         vF/qOHLKcfCTSYSeUm7825gwkfw73ef5h+fItFYtr117Km0c1M4PF19F4GGcwvu19ko2
         /TWa5T59en6SS4doQGbtMd77MEkjYgMm/Ufu2F9i/gyEiAtUmPZUqdkxBRisHFR2sYtX
         DSyFsx8MNNngg9oyskxOsFXEH3QXHnkhb9MZETW5pZIiV8uorpsG24CRAE4GFqX9bh5T
         +T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247575; x=1719852375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMSaelTgm9+gZJLzvg/KOZGEZUTdUOqVskLSww0Rudo=;
        b=G673WpCRUw48EXgrVKawM4FSucd8bR3WY/6PxLDZ26ihfdkXYJobvA4pLS+K9LoyKw
         X+rs9p4dWG23mkLJ38FQj+NQjLLr4eyENqJcbmGxHZidiobq/rii02Y8HPU3IbvFVSjk
         ELrmk7LJ4JHQJQMm+WWFi4MPEtPjKnlCjWq09ygxDQYJi2RfTuiBaf5SlhcwgXicUzlC
         5Ih3pa2g85UIL3FxuT2KMChFnzAPhVFhPbdvtyypIsy/c4u60D1tEo4tLlhmOX386bFM
         M78w2wlELknEmkr7eAWiJ1jAP/8GVbMebcJDBOCW6/OlH0TS6XGmMH7Q6CvSMze6swj3
         LF6w==
X-Forwarded-Encrypted: i=1; AJvYcCXai3B3SXn8LEKu2FDi0G1nMiiM9Y0k3UfJdgxKALeJbdaGtkwt3K+lXBAeGPYbP/Ew/MRzBr6LdTJompJK4js3yBk3sVTGiKov2EgO
X-Gm-Message-State: AOJu0Yx8l6K/wgSiVnwhYYyQTfKDpkG+xhaTXBgMXmZoOMoTKRDsWrxp
	UGeYTosvrA7l061fjQuU4HdEnd9WIZO+bBXv7x727l1bXn2YZaHyKCr8Ugcr2Qj9nn/afNPDOh0
	XC+MnrwIfUq4DTrJeBx3Fv8jxyR2ZJLOZjJmX
X-Google-Smtp-Source: AGHT+IFjApab6MaKv6PsrlmopTYXcXjrUWTT++GwSbVbvFdm1I8gzP3WA9e+zP+3yfQBYNCgLHo0PSNfLdJekbpatUs=
X-Received: by 2002:a05:622a:83:b0:441:54bb:50eb with SMTP id
 d75a77b69052e-444ce39fd5dmr5217641cf.28.1719247574572; Mon, 24 Jun 2024
 09:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com> <20240624141926.5250-6-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240624141926.5250-6-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 24 Jun 2024 09:46:03 -0700
Message-ID: <CAD=FV=XsRrB_Y=_rTTDhvzQPwxr+_LuY-YUjfm5H7mY8YgxG0w@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] drm/panel: jd9365da: Add the function of adjusting orientation
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, jagan@edgeble.ai, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 7:21=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> This driver does not have the function to adjust the orientation,
> so this function is added.
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V5 and V4:
> - 1. Change dev_err() to dev_err_probe().
>
> V4:https://lore.kernel.org/all/20240620080509.18504-5-lvzhaoxiong@huaqin.=
corp-partner.google.com/
>
> Changes between V4 and V3:
> - No changes.
>
> ---
>  drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

