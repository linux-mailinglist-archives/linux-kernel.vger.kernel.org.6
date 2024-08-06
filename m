Return-Path: <linux-kernel+bounces-275700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC4A9488C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BD81F23B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FDE1BBBE8;
	Tue,  6 Aug 2024 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TTtv82xt"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87A1BA879
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722920790; cv=none; b=L4vsBmebRhYleAJVrfmcAG5YAwzm7NsXFlDIPlNqjBFfhx567vMddg02nnLzBoIumInd8ocQlfjXgUUVZas7Pu+nCot0sZzDccUf5xPLTfY+pAwgmHHe5Esx6n1ZpK5R0sSRTj9xkhf2daUyu7VwoceAAaaKeu1NxE7UIt6wxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722920790; c=relaxed/simple;
	bh=2pkjSfd95zUvLrMKWE6ujE4TtorLVUowbInEA7tvNHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIF5bDikrzUmwt3vmyX64ftIWKUHEkWmJ4uXFIPLdEnW3ebZZrLiC3ToZnmRU8rnC7uD7T4LrsGYmq6KJ33Y4JBXPnLHcDfUqBz13UfIZmOz7aBN0b95uffytXFPz3g6qljc1eQtMKr0loxAGdlr7pSO3Jc01gxJt7KRRKqCThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TTtv82xt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so141366a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722920787; x=1723525587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCDSMY7BT7wntpsqPsFrSxhoevgzeOq2oCwZ5SgFJUo=;
        b=TTtv82xtSJQ68fCg+sb5sXJxRQh0deH6ZWpiMusYXQH1RGedepADTgkNo8hPSwQ1fD
         Z6UXLJ0N3lFpng035adY/A+hoC1iqVeNvqe+R+rRsE6vHqZ26246v1I3/KVYy5P/dpQY
         r3maXmMuOU1TSH9R9eg7mL6Nw3qOIVN44YUs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722920787; x=1723525587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCDSMY7BT7wntpsqPsFrSxhoevgzeOq2oCwZ5SgFJUo=;
        b=FtqPikFuQf0U0ZpcmWWFc3JAoZRa6YB+TXAFKztrABlYmS+PEKCDQHrZsvM8lWjHPB
         1+VuqRP6s4bwv8E5M31+FB4N0Sw1YTA4bDF/YMYek2s0nwUIFubdFqglXFfrXQ9XwV8K
         XOfkjVHEvEDlWYbpUqKzHAfx1mH0L6RkZbKl34TczseplOowDw+Ejt0JXJL4bohhHKWv
         dej7rDv13wqrZzeqWmGc0DXC79GFrLb4X6YZCb2D6qS5SVTEvCgZUKTSLXhK41h8o5Zf
         HDwGKREGSPMZ8o6MJ0PG51vgbGsQJiWkb3lVNtpX1PA7Z5C49v3YPul/vP8TZ36t7qgj
         sgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHEdJBqVbwyMwAm1s05Ma/PH6K/gakRObqfqSV6+tRuaruDTCe4it1FI65oqJ8rDJc7bdBdpuUwdyvGmQwlSMmwNf6UuUEqnZXqmGb
X-Gm-Message-State: AOJu0YzrqkC0HGOsdcanXYn9p5dRGTv5kbsh/Y/HzawrY6i6rkLySfPg
	1sFSVmDVCtwJG28Naz3BV6OfnEMFSlUU92P/0pxO6daJV3qqjaeEhy2G6oEKv9+0vff3SxNkk+k
	=
X-Google-Smtp-Source: AGHT+IGW/l++AClOs+7tjwzlbMHBdGjTbb1zXTQrawS+gQt3GrUSnwQYA2Lh1t5LnVGsoLWTa5N7UQ==
X-Received: by 2002:a05:6402:1762:b0:5b8:34a9:7fd9 with SMTP id 4fb4d7f45d1cf-5b834a980efmr8698506a12.27.1722920787097;
        Mon, 05 Aug 2024 22:06:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c2c939sm5564877a12.33.2024.08.05.22.06.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 22:06:26 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so8599566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 22:06:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0Y8napSg5vrUpeXrY1CRLylwZHpDskD/HvisSrZsQypmdRzx4kZW+n3nAKYuSkBFfudb99UwDuwaxtR5KTpyWKq8sAB+cc5+K58zw
X-Received: by 2002:a17:907:d29:b0:a7a:c812:36bb with SMTP id
 a640c23a62f3a-a7dc4da6efdmr1175852766b.8.1722920786049; Mon, 05 Aug 2024
 22:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-jacuzzi_dt-v3-0-1c4314e8962f@chromium.org> <172243932855.488108.1466847928167694223.b4-ty@collabora.com>
In-Reply-To: <172243932855.488108.1466847928167694223.b4-ty@collabora.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 6 Aug 2024 13:05:49 +0800
X-Gmail-Original-Message-ID: <CAHc4DNLwUAzrE-1-7oH2DHR6fvz4x9ZVaKbjUo6rOy3-kjUadQ@mail.gmail.com>
Message-ID: <CAHc4DNLwUAzrE-1-7oH2DHR6fvz4x9ZVaKbjUo6rOy3-kjUadQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add kukui-jacuzzi-cerise and kukui-jacuzzi-stern
 DT and dt-binding
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:22=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On Wed, 31 Jul 2024 10:47:24 +0000, Hsin-Te Yuan wrote:
> > Cerise is known as ASUS Chromebook CZ1.
> > Stern is known as ASUS Chromebook Flip CZ1.
> >
> > They are almost identical. The only difference is that Cerise is a
> > clamshell device without touchscreen and Stern is a convertible device.
> >
> >
> > [...]
>
> Applied to v6.11-next/dts64, thanks!
>
> [1/2] arm64: dts: mt8183: Add kukui-jacuzzi-cerise series boards
>       commit: 4ba6d1539fdd709ea8e8478c37b014e663cd6894
> [2/2] dt-bindings: arm64: mediatek: Add kukui-jacuzzi-cerise board
>       commit: ac90896833b52ff58c81727f57ed3cf9ffb9db86
>
> Cheers,
> Angelo
>
>
I'm sorry that I just found out these two devices will not be
launched. I sincerely apologize for any inconvenience this may cause
and for taking up your valuable time. I kindly request that you
consider dropping this patch series.

Sincerely,
Hsin-Te

