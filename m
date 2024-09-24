Return-Path: <linux-kernel+bounces-337552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2E984B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609BF1F20D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31F13790B;
	Tue, 24 Sep 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RyH2pleh"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763D40BF2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206306; cv=none; b=Nwytwz/AeTCG5GoG+4363xqOV76UCpdk4yQgMilrnuotgYsn2vThq7CbxfAD47VBUVymEVngHXtYCbYLkYOqjv7COmLx9AznAaoRGkiG9uw+awcBjwmIqECfDBXbqsI4X8C7QNf7rZi7vGyE0bHC328jAuRyQ0U67XUGX3sY0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206306; c=relaxed/simple;
	bh=mNzFKIMr4tsr5PKoLQ3M5UW7dlN0zeCTDohuqUPWGvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIznSaeAtM9MrvXVtuX/UqZLG5A/VjWr+nbc7brJz6djS4pt4LntMPd/C6LcQF76TRcYUf91l4dTKM/0CpF5vhzqmRfzBYyA19Z2e7R2eB5Hc5BysUzZXsA2GsTyPOp27eEoLLiPZCnUtW+9tmRxXCMpMs7fA5AGkn7vBGQArnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RyH2pleh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso564830766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727206303; x=1727811103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/dLA+3q+2Raow4F8VzPJxYHtFvWf+R0tKMvdhGOxhyI=;
        b=RyH2plehzwfmLeIIr4lMOcGO1z9d64+QQ7nEQDaM5w8dA6oaUjEROQLMgRHfoNgw2j
         9zTGh2XHhLlbl8WOz5fgTGfUDJg/Ec7GWV2iVad8tBDcAhRb55uOF+3bXU6A8uEdFudO
         byTljPCK42GeNjgQjJne9Dgy42PCk7GDv8EQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727206303; x=1727811103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dLA+3q+2Raow4F8VzPJxYHtFvWf+R0tKMvdhGOxhyI=;
        b=CiOVQTXJU/00QWeurEFDEzlP8nlT25zpcy5tF30XPaQ0xyYTNJeLtzAAFY8lVEO4jo
         7l4DIHRvGrKonfqVC1Jmncbewm5BYQUOGhXPTuy+lq5F6qdyXr/m2VdcubRGzZpxjr59
         ZyLhd2J4o9qXJwPGp8Zh84cqnwugZjFUe6UOeGbw0kwk7wZjaz9tvZEEULGFedXPeRky
         DcVD0dgqc6K/vfhz6QYDu/TT0wbmGi14jOD75KLTTa3tPy4luqoE4mrfm/y6mRVVKiAg
         Ngr8RSPb3umiVbsUrgviMYsBHnDy2vJvBgk1uFUU+QnPccmSKt2rWYv2WQDPnrQvQOm+
         kW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4qF4sS14NFzzDYMZaaPuFDmSFZlJE1/1KPkfT1mrYJSqe8fw6p8Gm/yzIjcT4nk/t3N2n0yTzKo324rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUzYx5ax3h0zOTAv5irGmRKKHJ8Low268yQpFaPUAXzHWvEMJ
	YL6btsjCYV0v1UlOmn7jlgXA7g4rNEtVivKbB7U59uFEZ05Rfq702HM7KwUYvIZjR1ehf3MNK+3
	pAluK5g==
X-Google-Smtp-Source: AGHT+IFghEurxG0MUEymt/ZSqXZTJl0GqTGCHokYL4mbSflUPJ2WRA80mMHHfuEv2Sn+SP2Ja1CceQ==
X-Received: by 2002:a17:907:9307:b0:a90:1ed4:dec6 with SMTP id a640c23a62f3a-a93a061b852mr31377566b.43.1727206302644;
        Tue, 24 Sep 2024 12:31:42 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930caf21sm122172166b.98.2024.09.24.12.31.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 12:31:41 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d4093722bso506159866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:31:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdiax0WrZ3ah1OTfZ/AvXOpV+hkuIu3mkHSye+Sw3dQAdkekpPGZIYsR/dZ/dZ6LHJ3yJ0S4CXaaNPa8k=@vger.kernel.org
X-Received: by 2002:a17:907:7204:b0:a80:d913:be07 with SMTP id
 a640c23a62f3a-a93a03e08ecmr34079966b.36.1727206300263; Tue, 24 Sep 2024
 12:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924044741.3078097-1-andersson@kernel.org>
In-Reply-To: <20240924044741.3078097-1-andersson@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 12:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieXpmx=+gEuhQSEEZLyQHFLDk5=59j0OtOF==mQdVjYA@mail.gmail.com>
Message-ID: <CAHk-=wieXpmx=+gEuhQSEEZLyQHFLDk5=59j0OtOF==mQdVjYA@mail.gmail.com>
Subject: Re: [GIT PULL] remoteproc updates for v6.12
To: Bjorn Andersson <andersson@kernel.org>, Martyn Welch <martyn.welch@collabora.com>, 
	Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Beleswar Padhi <b-padhi@ti.com>, Zhang Zekun <zhangzekun11@huawei.com>, 
	Naina Mehta <quic_nainmeht@quicinc.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Tanmay Shah <tanmay.shah@amd.com>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Udit Kumar <u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 21:44, Bjorn Andersson <andersson@kernel.org> wrote:
>
> remoteproc updates for v6.12

Grr. I didn't immediately notice this new Kconfig warning, so now it's
in my tree:

  WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
    Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
    Selected by [m]:
    - TI_K3_M4_REMOTEPROC [=m] && REMOTEPROC [=y] && (ARCH_K3 ||
COMPILE_TEST [=y])

this happens with a regular "make allmodconfig" on x86-64.

This seems to have been introduced in commit ebcf9008a895
("remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem") that
added the TI K3 M4 remoteproc support, which does

        select OMAP2PLUS_MBOX

but does not actually contain the proper dependencies that
OMAP2PLUS_MBOX requires..

It's in my tree now, but please fix asap.

             Linus

