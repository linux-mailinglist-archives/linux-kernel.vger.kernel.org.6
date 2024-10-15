Return-Path: <linux-kernel+bounces-366603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3299F7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CD91C22E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2571F80AC;
	Tue, 15 Oct 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eOvnh2Mq"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AC1B6D1E;
	Tue, 15 Oct 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022431; cv=none; b=EhNiBochmaFfJfprDPEuX9xA6oUPdb341X/WlFDpciSmWZYjQr0tGyzoS2p/xT6MNLIGjlS0KFLmSfBwPfB0RanRCTJLfwun5pabdIPfWhx3siYYIdREgy9BvYNu2/z8aL8r2B5tr6jz2LJUp9qx6AGyQzGffBkV6gLUyFMRZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022431; c=relaxed/simple;
	bh=+dHOqgbqxbhUKjFC8jI1isYQT2Cb7uH2nwkpTlgXvmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBBAUpySuBkEFsL0HSRzXfQ1rUFr3oGWZtEIw2oFDPPG1Ko02RY+bkvRXMX9DBNHwqyBYs1h9FPd8gfZ4RO+iGTjY/8Vriv4KU+EbW3ZdHH43K5lxsTSd3EOVeKe0wONEzMQlXK1LDjjGPbeZAQWWaD/aKMLetlXIcYE+FN/rTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eOvnh2Mq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c714cd9c8so46884175ad.0;
        Tue, 15 Oct 2024 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729022429; x=1729627229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dHOqgbqxbhUKjFC8jI1isYQT2Cb7uH2nwkpTlgXvmE=;
        b=eOvnh2MqI+Yc+XN08GGb9BeyXO04yyx3pKUZE4xGIjGV/6lgY3I3da9a68x47FLTFa
         puBnRctLrtENa8ZOgGC4bmYjcIx2698nQMNrCl2aBDSInl+caG0JUMaTCyRbv/E5u1cY
         HAJUK/+ViQBEF2HekG3mapgCn3GW0IDmd6gFm1mzfu8plr0gCwnJfnu2GHPVGbmCL6qM
         IhkyGoWxv4lOQCBE+Xt7tA9m1/ie4eY/gF0NX/pR1hTNhJ1wGu5jWeQ+isG7GS0BIFuS
         KhYaUXS9AswSKin4eXkKhGhpyVaJlTW3qPwLyJV2jEbWPAAqDbqW29bSa1nS3uo4ccu8
         3KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729022429; x=1729627229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dHOqgbqxbhUKjFC8jI1isYQT2Cb7uH2nwkpTlgXvmE=;
        b=bp3WuPw8qDr3LXhkm9brUzFgIFDeV9lzS8itcIc4STm8CjTRvp6dSgxgQ4ET6V/cpX
         594WcvBmdk3wlhrR6PQeVsKzwYTcjGJxW3+8NKS7j3arBAjLU67dCG4x1V7CF8fPMo10
         PrvJ+jYXdEjD8fjzBjluBvW4pP1USjNJ4DDotMC/Qf+inzgijIa20X5Wd8jnLFXg4TO+
         fVMheMgjEpYm5GwUwDrAcMwfGDa6Jy0x4QYFK6OzAEGnhEzo06ws7pkly2ikFRswRKG2
         z1A+DGIJpE3qTmuaNBbAXzDxaOQ3amIdzXyy0n2GjmicI2jZvio9oNuYfcfwh+78f/aK
         baAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxDiJcjpqlQy4b3AviSOSyHsr3m0ix4MNzwjspilGRdQ7M2MCXMNqGI786bxQl4HYQhDAgQVtAy+Xy@vger.kernel.org, AJvYcCWMJnyc/kQHcbU7Fu874VBArSpRDyzcPeLyp/MgPzL7G8V+ohW2dic+OtYKD1YyggtW/zR8v4BFZbatD+Fs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7yGJI8KeT4gN9Lr8A60P0MINrKRn6ZNZpk31E7pCQGofXk1pM
	RcyP0gDew9p6/kOosI2k2WKlqPSFHg0mLNWqRyJlWw26S/inB6gb0nLg6ybmXlMubysHPLBk6B1
	qzpUfl5ETEt06Aycm56oEypPDNzs=
X-Google-Smtp-Source: AGHT+IGRAmeBaacGPitE5Lu93QMjwbYqZHTlRNrjzryAWT2uMOuhpeBjdQ1lgbAhAtrQkdLy8DPNtWJJOKrbkKNNLyA=
X-Received: by 2002:a17:903:2342:b0:202:13ca:d73e with SMTP id
 d9443c01a7336-20cbb1a967emr211133625ad.28.1729022429235; Tue, 15 Oct 2024
 13:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-v1-1-896b24e6c3c8@linaro.org>
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-v1-1-896b24e6c3c8@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 15 Oct 2024 22:00:18 +0200
Message-ID: <CAFBinCDyfLC5uF2X0DHazPq1hwA7qZ2yjLO9awcDgHcUbYVECQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: Document
 the System Control registers found on early Meson SoC
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:09=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> The early Amlogic SoCs also has a System Control registers register set,
> document it in the amlogic,meson-gx-hhi-sysctrl now the clock controller
> has been converted to yaml dt-schema.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

