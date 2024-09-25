Return-Path: <linux-kernel+bounces-339489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A679865CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594661C24590
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8884A2F;
	Wed, 25 Sep 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AOaFagQk"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E081AD2;
	Wed, 25 Sep 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286027; cv=none; b=FmGPd3hZ1aoyTIAPnYpmp68x8LgZLnnDurHGgaRBJguAxKios2QFqW9TlGiEs9K5cUeIp6EK/GLZb9ulHap9iCs5/kMVdAblpnw4e/J3xg1p/3n4iepknxe9cUc1teawouqBohXzyOHCkbyTnYVk2mRe/SE4Ab6gheY9Qt/Ul3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286027; c=relaxed/simple;
	bh=/p5QzDKhsYn2lpXH1p8VSp9v88ED0oxXMiz3ZcFyFYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP/6Uf2tWIMNGh4F/W94NkHw/A05J0mEuhxxtkqfCzqXF7ujZzZJFu3gyDKZezwW6kTwas0ehgrHPKjbLVdvEf2oNctnyACorsRbTu2UBMcFXVfDll8ewPjIcG1DqtElg+5sKvV812N3viD+RYXka0QTMjUpQtHEWUEhlw/FnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AOaFagQk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2053616fa36so744705ad.0;
        Wed, 25 Sep 2024 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727286025; x=1727890825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu6Ob4lIhoBnF+vdDQ/YY5vwteehRkNIa8XoxhggZNQ=;
        b=AOaFagQkkmOQmZcP3weDowk6piClW6xZ0DrO8sdCYkpesUu+u9abh1fwjofTBY/M3D
         qhQiAJyuu9+lZd67Olmz/biI+Vci6AZvCtU7jqloOTNwotDKWBh5XqMleuiEPIUoP/gM
         VUcD2ruBLklRLfnVX7R0iqkUMFx04pYl/x6KpTWVGckQi1rH/RiNBsg9ng4apa5tEr9R
         NAQXEORQyszaRDvFGPDqU0PM5J6BSUdHX4OEyn0JHzxnNRUDZvPimvboPb7Znv3zfx34
         q6dyY+ZO81fmcpfV/WPp3HriEhMpIFnhJW6bxkYNp2bfdUUXA3tGEfiz08o/ZKS4WgQ5
         /xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286025; x=1727890825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu6Ob4lIhoBnF+vdDQ/YY5vwteehRkNIa8XoxhggZNQ=;
        b=aPb4zSwnbtlsahuWpQ8y2RQ09oMD2cNOHuh+R8pW+BKSYlR0F7SgEz1DOj8+vEqi1A
         JKiKZbEvFk1w1wMDkLIcGHJFLn7H1vqnLJzyPt8/b+mMH5gsdT4Tnu8p1GhHJYUtFSEJ
         LoDnzqD5xvEmJyRFRUMkB1ArFHJbwJgV5TXWM7pTn2RzyuPPTeZUiJULokwRPQgMwVuP
         mbZ9d0knOxdWPHiWEUOgpNb439Qj+ZfWH36KScRUOcy26eOl01nrfBFExrY9DB7yZkI/
         BgY0KVGWcR7TF+OyqMfgy3l4oNVnzjbDDgX4NMWNMvpnXRrzDXb9s5kJk10FUn6X7Q1i
         TVZw==
X-Forwarded-Encrypted: i=1; AJvYcCV26V7hys+oJv3w9fMbRRqzs8859LaicXAI97oBVQB6o/X/5CWwJ5e9+GtZWko11a299ATYXd6Asv5jnV1L@vger.kernel.org, AJvYcCVF+XoxfvFZTJVXzbElUT5B1Qc87+BDCqd9v0mS0qHO0Iiv6psETYA6RCPvyf6FAd5gq5iZLsMufSnx@vger.kernel.org
X-Gm-Message-State: AOJu0YzAB8nnzvXlruZrRFrGQ/5mgP/TNaBLyiIdkKdLI0+MW1r6HtAr
	unzoKUw7lOBVk5FQ/LtKtqFLJOeVfz7XbzHNXN5rHzXnLY2egNF6IN8nIc3eldzywB08Fb8kkxU
	AQK+iRtr5YL4xJAdXrmgqFpOLUHY=
X-Google-Smtp-Source: AGHT+IEmtvARj4KtUmFt/OSibe+kwjSpppkVNlDqMZFxMwPHvTaAXOY0uVlb3cI5jpp03AjMDEIwGFC7XkDw4+/BHT8=
X-Received: by 2002:a17:903:1cf:b0:207:146f:b35a with SMTP id
 d9443c01a7336-20afc4c1877mr43755635ad.46.1727286025356; Wed, 25 Sep 2024
 10:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
 <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-1-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-1-0b20ed4f0571@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:40:14 +0200
Message-ID: <CAFBinCB+ZmjRbUyJ9+4SCkMyP_g45W7DvHV35AeiM1seo813og@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ARM: dts: amlogic: meson6: fix clk81 node name
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
> Use the proper node name, fixing:
> arch/arm/boot/dts/amlogic/meson6-atv1200.dtb: /: clk@0: 'anyOf' condition=
al failed, one must be fixed:
>         'reg' is a required property
>         'ranges' is a required property
>         from schema $id: http://devicetree.org/schemas/root-node.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

