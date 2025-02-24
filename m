Return-Path: <linux-kernel+bounces-528741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F9EA41BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5407A849A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A125745D;
	Mon, 24 Feb 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHKrH7o5"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B90257452
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394270; cv=none; b=DcQDFBol0ju5ovSz0ykpD8lVCUM1a1gi7zEj3ouDD1Ra6GrAHmsReBsfSe3o1tHG0K07uC3mcj4/OMbnEGm7ycBkdTF+bUNXP4XZMgPbvfLCHfUvBFyNIuy5t7ijIVIoHK0wSgHSYZ++toDJk/qGtAChf1Jihy+oPYjl0U68XAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394270; c=relaxed/simple;
	bh=j9ewN9UcK/O8IjxS4nzCWkIr6XMGt3xZkhfiGiwkBrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSSA8x3AG+GuyBfOubEw5kHp+9w6SM9n8Bee76gvL/V8nLBkNywerfE1oyA+cdVAewp82Erehd5xjf+1TbXPI3dVHMydvUtF3tTWZXYySFLEPTQKsuhV3mce+NvVBTo7qslx7V2hN6s0Z3aC6UbvwytA43HA36IpZyE2TW8EV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JHKrH7o5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-546202d633dso4266987e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740394266; x=1740999066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9ewN9UcK/O8IjxS4nzCWkIr6XMGt3xZkhfiGiwkBrw=;
        b=JHKrH7o5la5ka56vx+4hCUT6En2tXkWzjY4vlBzl6WEshLbvuNTMCgV5Ajp4qsy9Ad
         aXXV3wuRCBeiACzpJ+uusacLGmwTkhngdwomHdULCUthAOR7xn9YHXp8IFDO/rRq42jt
         YxpQU1rRGkUCsDHOKxOjLjfURhQfTwtBdn9zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394266; x=1740999066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9ewN9UcK/O8IjxS4nzCWkIr6XMGt3xZkhfiGiwkBrw=;
        b=P29KPhe3yNygyAPS/GIwUwfaAiGlv6LMVgkWeBId+Gy8wxcHQcnTXuxckMuEzJ2XXO
         jXWE9SpyiVPZnAQvSmAlBaIeFKsl45c3ZHzqi/d0hvWzVhND5oCREBlh7d/1bFtFN7Ok
         G/3/EZfeMT6huFOO+tp2Oz3mQYjW7V7RmMXJOTMtq/OYAdRb/6W+8ASbDkWS0kLORk24
         /YLllzFek+tDNJQGMbwsGG/YCLz8HRDQvNv0Yx5PO7iN7xmI1//w26SH908ucWgoo2Vw
         /oKtuQXo8ZphMNSZAGvAIxTmBYJBnTwaXJ9VV5KlTKeZgyKjWAYQaF110xk2sEFyArz1
         C4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUSVX30MvAzwfGBNKuyb7A911oYu7x6+ULhEfiKQZsrXItKRLAua3UXtS0mkvwxubD6Myj7hJRC1II/pBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNepr/vN4ej0D004OtA+HlGwI7EBx/X0Ejune1TQU1cs2UKRQO
	aVpL+fLLxiqRdooljE6xICcutwhUDDA9pQjzvk+IejYWLGMNxqCXu0KobyndPNS3b1eLtUcfrqj
	m1QV96De//Lqptsa7xavdwu0NA4kWAnXlJ9KA
X-Gm-Gg: ASbGncsXHC451MVoEZ50w8U9iNZCXR0W56dNeeCU1kQEJrkM8nT+LEs1gc3ChcQtsfq
	6tlVYyQBFOKqZS0tIyLlRZpMGBtU4gVmxjzqntsnxEzvbkibP87GbOtCj0BZUqkXUlrSTuYKODe
	vf67XSLY3B5OtwjGH8Qh8aOX9gLAjF8k7+DCw=
X-Google-Smtp-Source: AGHT+IHt7LwH1FhfjAD5OKjp2mvKbAZ/8l+aQ1Ipxz03xtQO7zWSEdSFIHFgBDAxXVoiGz8lGaTL7HUC1kS6yhy7A7E=
X-Received: by 2002:a05:6512:3e08:b0:545:1d25:4604 with SMTP id
 2adb3069b0e04-54838ef07c7mr5016745e87.13.1740394266393; Mon, 24 Feb 2025
 02:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com> <20250220110948.45596-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250220110948.45596-4-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 24 Feb 2025 18:50:55 +0800
X-Gm-Features: AWEUYZkS0SprGNFPq1iPBVTH9fxdvLxcztVS14fJMBAWX6iv5wuTONgtw46vcv0
Message-ID: <CAGXv+5GwY28s3m5jXX_CqKfK6iehJRhrwbEvd2=7Qn3u=L=mLQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] arm64: dts: mediatek: mt8188-geralt: Add graph for
 DSI and DP displays
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com, pablo.sun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:16=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The base SoC devicetree now defines a display controller graph:
> connect the board specific outputs (eDP internal display, DP
> external display) to fully migrate Cherry and make it finally
> possible to make Chromebooks and other board types to coexist
> without per-board driver modifications.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org> # On MT8188 Ciri (int. and ext=
.)

