Return-Path: <linux-kernel+bounces-339490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047DD9865D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3599A1C2465C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DAF84A2C;
	Wed, 25 Sep 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GcTPePXU"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C343AB3;
	Wed, 25 Sep 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286063; cv=none; b=qghS5xJDHm3TN0nnUEjTYGHAGwtObuB/YhmbCS5fIDQtFpTUPX4ZAs28uDlDdnM2ZOiCRLgUq/b/5dUPUWdSBxALhK4HWaNpZ6X2u9R8U6//nntnCem4EP7kHTYbTptk3UEg3CIgqNcMRWhQS77ENChrtIhQ3+L95seP43C0Hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286063; c=relaxed/simple;
	bh=ndiDy1mSgmRg6sFvbSZ4TS1m80BKoGDmWCExnl0BG5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOR9s4w8/+LaGF0OPgdrFZ0rH+Qk5S8ir25Rg/GOdP8l/58LoPbJlgEDqeXlWFWDPmKx0OBZyOZtBKQCFuBD3eY8fzkpQw5xyy3EHrLyz47qJ6gcuW0MsKAZCYBzXC6tAD/8TOFw3C7Nttc29PF0TDDCwMO0e7oOtOL/FCSLPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GcTPePXU; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1d4368ad91so1085243276.0;
        Wed, 25 Sep 2024 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727286061; x=1727890861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndiDy1mSgmRg6sFvbSZ4TS1m80BKoGDmWCExnl0BG5s=;
        b=GcTPePXUf8D+6DjEngaWnrwAle6piOUZRL+15sIFZyL5s35px/na2eSbyd1XFZAmFH
         POPp+xwD8xAd9Hg51L5s4UdFYyPPyUKJbqmHErfAHz2xF4Uh2LMFR/xwHOP599zHhfUG
         5kGCEwAyrhVykqQSnqJh3I0rLFYirUI6So/KUYrC/tIAbX/DBXMda0/cpC6rTVxUdQ9P
         UPESsKQNacCBWEf2db/q1JU1/D8nhUvbN/uQ0UMi3UrFAe5L4sSZVHxKywWX9rVJ92Xv
         5/Ictuz4zZh1qTyM7ZknmU9anR79EZjqHgzndWCMdY4uoibXY4aqeYxC1V9GGKxXgrYR
         2Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286061; x=1727890861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndiDy1mSgmRg6sFvbSZ4TS1m80BKoGDmWCExnl0BG5s=;
        b=VOYsYc85VTnFH/pvxAlYf4ZNWjkFWUXrdxMjeOws5yyJ10sC6YDOhPzvcMthwRKmW1
         bxyel9fP336Zp2KNL7wHeuepKSpGWf1A3nRuf/JlUky0qHEE+rcciGO1nlfUxj6ZYVcK
         jLaEYlECktPbz5Mgq0F6n2WrKYmblC1+7s1zPVUanJVwWPXbYewa7mKsHyBrbWAxlo3s
         T+r/LXHCHfVUT7rE2vzXr49MknA1zl3brSMcpKTOtZbH86uYsSIi4/J671BZoes8+8gH
         AiaQxvCwEq56WPQPxI4YmRFCW/kSCKqRDQ3/fP+GE8ENC4siLfyZUaHH3v9t+U+mZSPv
         inLw==
X-Forwarded-Encrypted: i=1; AJvYcCUTb+X3z99BrDHbgyiKgHEbyAhq33RAPyVrNGc9v+pcS+XXlxMuVWOn/RoUZ47ua0I2xOum73ANV28EDeY7@vger.kernel.org, AJvYcCX6Bhc/KwWNIh18SJugVutZnFzgrBapIlsghzNT0h9L0UPb+e5bxum5GFpw89jzHJysza/DbaN8Hjtx@vger.kernel.org
X-Gm-Message-State: AOJu0YylZBtjABDVEi7oq7NeICVK5r6OFW43TUOyMC6L0WPTjl/3a9/C
	zcH+IMpqR87muf1Qzpb+vnm5Gi+06kZm5u9lUBijcuf7rmshoJ1kFXxqYyH6VFukriuIpIF7yLp
	6JIBXFR9G8neklXoQMuYsDQYB9aw=
X-Google-Smtp-Source: AGHT+IH7V/blepTOk6kqhUyemsLlG5MBzFmZ7LiPRLoJn+pnqrgFqcO2vnQoG2KBg+pcrZuj7dlo1P12eL+WmXKFAms=
X-Received: by 2002:a05:6902:2d09:b0:e20:29e9:23ae with SMTP id
 3f1490d57ef6-e25ca96a25cmr413662276.17.1727286061032; Wed, 25 Sep 2024
 10:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
 <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-4-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-4-0b20ed4f0571@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:40:29 +0200
Message-ID: <CAFBinCAuo1JkYA0mrsR6drs7ezEBtj2zZ1EaLhYwuCN9t3uixA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] ARM: dts: amlogic: meson6: remove support for
 ATV1200 board
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:08=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The meson6 atv1200 has a lot of dtbs check errors, but since
> no active contributor have any boards with Meson6 SoC, plus
> no upstream GPIO, pinctrl, clock, MMC... for that SoC either,
> let's start decommissioning Meson6 support by removing the Device
> Tree files first then remove the MACH_MESON6 in a second time.
>
> If someone is interested in Meson6 support they should bring it back
> along with a few more patches for upstream support of further
> peripherals.
>
> Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

