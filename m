Return-Path: <linux-kernel+bounces-339488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327BA9865CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C6E1C24717
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2A82488;
	Wed, 25 Sep 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cs3qirto"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BF81AD2;
	Wed, 25 Sep 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286012; cv=none; b=Fq84HB+ITaStX0yoLDR4Zhzs6GeWFYVNcM6aebxbW5sVg2vG71eWUc22Ihq5k6uk3jrRhfTjLndCVS8tJof3sh4RTq4BdlFsKIj+9HyDVLA/JtjLUpwkrxNPNmzUJ2+45mN82MBsCSlobFLQpH7NwdzU2pUUI4pRV98fDb+7KJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286012; c=relaxed/simple;
	bh=92l9cC9ivnaS95vWYFFp4mOBKQtvcXeO85XyDB4Pt+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDWKuqT7iy3074SvXNfDTWllHYMAzXRIn2oeMGx9v5ta3eEW/g1qx/X15vquWWUD7bmizrtI07fM71CSxL7SvtyjUkRoMIbe3BqdOMMAWDbycRHpd2SSFCJdswE3whj3DkGvQ/YAvHnABjwVAmhyYBEaXsJokqutR+aiXicCYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cs3qirto; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068acc8a4fso436565ad.1;
        Wed, 25 Sep 2024 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727286010; x=1727890810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VwzsglwJddwnqfAajmvRAfcu2M8rj1kwdCIPhsr4Bw=;
        b=cs3qirtoFByTOSwYMiaahetX3eCGad7hWAgWNg6wWlJvU7IN5O9sJzScOvRW0PivK+
         lM/3oM8jycQEdYXklbqcq1unGTbfKY5xoXDyono8jvXf6NExJRZzZfM5aAS+4LISkqRF
         Pc996/NHO35iFLy8YjJ8cfjd9FR0G2cyINXIbfGpdhFTu4xFV/ogJIdOsAVBF6m6Al1/
         UTilxkpIOsJnd0IigfNMY2tSUngq0CGYbhRS8EzK58Btdcd4B+buVfRI4E+wyTeE738L
         PpjTFl79UMnkLXCtxDJffSrLIirju2f27EgRYithEXNoVh2OUlmVKoYmFkvE5lv3V+Go
         5umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286010; x=1727890810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VwzsglwJddwnqfAajmvRAfcu2M8rj1kwdCIPhsr4Bw=;
        b=MYt15YQRlQcJLb8Mc8kP1TnCpjvAaQn9vg3IlRYsaQtPy26b/iH25p0aD1PWsPkGrG
         swEVV7NxaaE5mS+r9stbm92iCF0xhwr3BH3MMJKVd+AfwmBM4no0NWXbsRFWwtSQHbkM
         BgGdAIPR81H56d96DhEK7RluuNhW5y/LbuAPvCBFUMMo9XdJnALh2y9O43Qk4OOUJYK+
         SOKZJ6fyeUf0XxiDYThsxZm9qCWXy46w/lREK5YHNWn/vW2q/uCEabI/MxJfRz02vApQ
         IRF8mD854JJbxS9L5qqiaHp7B/+tmSRCFmhizc/drPTpB7dx6rUXsPAJna/7haZOWPoW
         QIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFWJ2bhl+Wessw201xHawiQrovdLYQnwjswLjdnxkUP0KhAlsy1b9Ovb+aF9Yji4gNUHwW6RjlpunE@vger.kernel.org, AJvYcCVXuDsttKEm52oZGc/c+TZB84ywTI+bFHjJ9ArAHIwFAQ5ThbuFy2IK3d8zbcIXordqiq0BrmrYDYn43j0N@vger.kernel.org
X-Gm-Message-State: AOJu0Ywck+twHi2XrHSnzr7oM5kw39PZhnPlDUmfKtfGNuBV3KvMa8UX
	K5JPJgAUQT1DS8if1fbsNze1R0uvFLSkrGoeu2Hl7xZnWWxgtCHXj33xZm4M4Br6KWtsqVpsdlx
	u7J0Code3yhmmm3U3HB8fWRx3YdE=
X-Google-Smtp-Source: AGHT+IHKglkLsmjgQaRMz8Yit0jGozmt/v+TqUhEdeU1yFm+1vrxYNAYbBr4RJVLnKVyf9xVT4d+iBDg713LPJjyPp0=
X-Received: by 2002:a17:903:244d:b0:202:4640:cc68 with SMTP id
 d9443c01a7336-20afc637fe9mr43820845ad.59.1727286010155; Wed, 25 Sep 2024
 10:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
 <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-8-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-8-0b20ed4f0571@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:39:59 +0200
Message-ID: <CAFBinCDEDaj=fT3x0FszuqiBsXLA-4wRJvR0OJiXrGzLwJ9u1Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] ARM: dts: amlogic: add missing phy-mode in
 ethmac node
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
> The phy-node property is required, add it and fix:
> ethernet@c9410000: 'phy-mode' is a required property
>         from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yam=
l#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

