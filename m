Return-Path: <linux-kernel+bounces-285268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6BE950B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D74A1C21A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD51A2C12;
	Tue, 13 Aug 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cBAWJHMM"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE001A08D1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570075; cv=none; b=ONpnMxXKpaIWpxLquWRJyg0KRJX52ILgEnCoRUaN03RKGd8O5dTEh5SgUjSC4RD1ZHW35RSUkAQgFFuzAbrrLmHoR6B0fynG1cF1NIDGeOCZsIjwUpWqXdI9AZfmcAl/nGELiCCJjcZFYPWLHzDPByQD9N7hmIFO8uAB5vzg4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570075; c=relaxed/simple;
	bh=fVPQXHdsqHUwi9VIGaY64omTQpZNyJFY9/T1nVkDXzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoFuvKQhbVfMKU29nKn+rUAt7xNF758siFNMfH9VlFGc3jgfD5ChsvQaA7kSz4U+nDs041b8gh5JXTFVNpXuHPypUC/DfxEabjwAysGkwNzqKS8qebY+L5b8yqGAMGR1u/6qOy9VR+m58YPUDO2uYJIs7rtdGZvrHda0tH5/RxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cBAWJHMM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fe58fcf29so30745231cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723570072; x=1724174872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxBfeskCK9StEbhEGdoE9N+4iMSwlDDr96ExPJPkhg0=;
        b=cBAWJHMMMGqG0SwxBkMwGyr7v2TgnDa0FcV4IjxH1RlbFCZfaX6cIIJzJ7PmAS2hwQ
         /ULG3W/WoVrAG8TvXGh1L1h2yOiNMyBBqnQFuaJqYqGoICyyLnxr+kOTk7qq/3y40QJa
         XO+j7XDS2HnFFw225Eycr2tDa5Oxyqt+GoCls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570072; x=1724174872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxBfeskCK9StEbhEGdoE9N+4iMSwlDDr96ExPJPkhg0=;
        b=PmrCI/ZfQjfBHTrjTau28MkfMc2cN72BBiOD6t4049fwf9G3+JzQAtDkf5/fZyFIYp
         3978sLwKT4e4fEMp0rSmh+TqSLdyFa2G0H4Did7OySvNv5XoAmzcybcZ+soe0Yr/QXBY
         +PI9nVVmakn/ygHP0faR842sL7WXQv317hNSjDPG2Iq0y0ptjGhfZ4sP2GlF5cFwGUPU
         t3FMkYox+gGsB4LdfePSi1MrnoLGt9bmVqgjn8nw4eu3zF8rrwrQeTjvlJnxNypv8+JB
         RjcO0KEaNLe3rpSzIIENNN2jahs0TGOCpHJBcnGzL5yqtvTCQV6rZn6+qUmuoWi33C6L
         Q+wg==
X-Forwarded-Encrypted: i=1; AJvYcCWbFng9Z+xL4alazVihl+f1DopuheHe8AaJ3UnoYo8AZ4+rHxtbO8qZvZaNPQLTvGWNZx36RkM/hGMrVd2B4fJA6tIETlU834ouBNW1
X-Gm-Message-State: AOJu0YweRjMCyOx2DYfMwq2qPd8lT+C/QT2boTas+q47uO6cGAcTNzJI
	A+dxuAPotAF+DgyNrQzuXAOlWbRAMxWjpXYddJXTW3FpWbJ+AyWU0w616yKcep/v7k5zSkiNpSc
	=
X-Google-Smtp-Source: AGHT+IFxWHesxR6uArDG2zUCAliGX3ypxejxb6/4LdrevYOKbyBhOCJotkZz09hYzCkFK8XAdg9ahw==
X-Received: by 2002:a05:622a:114b:b0:44f:5e2c:1631 with SMTP id d75a77b69052e-4535ba8ebaamr824981cf.17.1723570072055;
        Tue, 13 Aug 2024 10:27:52 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1a7e4asm33837461cf.12.2024.08.13.10.27.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:27:51 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d0dc869bso345612585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:27:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLh9WbeNrLZ4s441VRVR81pi5iMcHc9bsNBVIUOrQZHl/qK/0a/FGZkmu6yX8kY7vi8k4T3QRDVtE8yLR65MS5tvnMkYaeJNWBjkWV
X-Received: by 2002:a05:6214:3d02:b0:6b7:b197:c825 with SMTP id
 6a1803df08f44-6bf5d17293cmr1654126d6.14.1723570070823; Tue, 13 Aug 2024
 10:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813133612.49095-1-charles.goodix@gmail.com> <20240813133612.49095-3-charles.goodix@gmail.com>
In-Reply-To: <20240813133612.49095-3-charles.goodix@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Aug 2024 10:27:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLse_tiiMr8t7Kq0EguzJtt4iqhr6cPUvuDcy8MT0k7Q@mail.gmail.com>
Message-ID: <CAD=FV=WLse_tiiMr8t7Kq0EguzJtt4iqhr6cPUvuDcy8MT0k7Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: input: Goodix SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: dmitry.torokhov@gmail.com, dan.carpenter@linaro.org, conor@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	hbarnor@chromium.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 13, 2024 at 6:37=E2=80=AFAM Charles Wang <charles.goodix@gmail.=
com> wrote:
>
> The Goodix GT7986U touch controller report touch data according to the
> HID protocol through the SPI bus. However, it is incompatible with
> Microsoft's HID-over-SPI protocol.
>
> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> ---
>  .../bindings/input/goodix,gt7986u.yaml        | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7986=
u.yaml

As a point of reference, in v5 Conor gave you his "Reviewed-by" tag
[1] despite having some nits. It's usually expected that you could fix
the nits and carry the Reviewed-by tag on the next version unless you
did something other than what was requested in review feedback.

[1] https://lore.kernel.org/all/20240618-affluent-unroasted-e6d5d34d1ea2@sp=
ud/

