Return-Path: <linux-kernel+bounces-330003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C7979856
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1AE1C2138E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C21C9ECF;
	Sun, 15 Sep 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g7N5qRUR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873B175AD;
	Sun, 15 Sep 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726427165; cv=none; b=Yby6byosjC5WdzeXnmoumxh8AdGGc+TWpJn7dlzebVoTqHaWdDcj+R9ZYfyll9G6q3/QQeJ/OA6Fviw1ooxnWNf8whUiwqSJwsuMUeu2m6wHj2fCtUlGhOIWYvpew0dy1GuMfQDOZEYs4BU0MYWnDtZX8Uzh5tJy9XMTNpsb6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726427165; c=relaxed/simple;
	bh=gL7+LPPXbmim7gWuH+PohwSFVDdKZqCM4KyIUHlEYyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWb/3WoUgNl3Ufq203DJGZ1I/9DoDaaV8bKwrRQoZ3S9jKl1kJSYgekgwTGjT7j3brBDTf5yeSCVET9b9YSMqHXmBhwHHl8dzYK7Ne/JBCkuLSpdjBAyXUksNp7ri4bjw3S5InuZZXxGIfIVNkByjqHxFEnpGb6iY2xbysHLfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=g7N5qRUR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053616fa36so44667345ad.0;
        Sun, 15 Sep 2024 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726427162; x=1727031962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOH05K8gI+IAZvbuBzqlVV1cO+viSa94cBnfzwtz9m4=;
        b=g7N5qRURq3wBfhtAQU5z6FHyCYHWY1ilajTOEO69ZwzPlzW4U6FaprxH8gh67ycmK/
         N4tLz692TpNn3ZHsTpMcDUFLZ29CYGLb7FQXQLQRxipcQbQdWpcgbBUSvfU+q+FdcGdU
         HJo/OIMtZyKymgEyimdS4Ccc/Km0J4V/kodR4AKhQqVwsqrOEijRNmt1Vcon9VSTg/K6
         ezXpvIvDlOSiYrlIgL8yDdxujkquznVbZoV6+x1cnIVySGrhXeAKX2rqN8B5ameFkLrN
         fXqWhxOyhtyCTDD9Vaxjed0gWu+5fX14HFFZQRSPkmIonwnuQEwd/dZOZMjbhatqswjZ
         m3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726427162; x=1727031962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOH05K8gI+IAZvbuBzqlVV1cO+viSa94cBnfzwtz9m4=;
        b=QZx8tsmmMrRCCBaJjRfanbNfIGzok1cVXaWjw+6YQtuRleEK8TVnRprJzymDgMOYQN
         xnoadU8EhbOOcXFVEADuBITVCD3V4YlaSinQVTE5I4HzNsDjlI2T0LZCgwKkFexOakwI
         IB0Y50ttqissFrzXqZJGIantu4SKPFVat0s1grWvGCdX5G/Vnf/9uPpQHCAIF9WYGS4q
         PqbLx/eCwN9rNqKHjPu9v6Cn1JB8QA+7YsSPjUca3vPh6lwuu8txxxLF/RmwE3RslcRG
         t2tHht2dOCXGD08ojoD1q0bM3ngDqp0Ad6HQz0nqNpBqmm7NN2BA7igrFzpUnoCAgccQ
         vUEg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0ftWFNbqcb5AHnmYCerRd/oJ9R/LP0csOkW7DckidnYaeMfK6fLSO+qgCRya/ODjcrj1BNE4FsWKfcio@vger.kernel.org, AJvYcCUz9+m/KiIiBFajtgMHBmSWHdynqpBdsBM+0zbTUVPamKeX+nWbcjCnZpYcNl+MergUXQ+eLh0xVQ7J@vger.kernel.org
X-Gm-Message-State: AOJu0YxBWXdcGtEZ/SOOyk+8OnOqnfr0kx9Zz+Ll+tI86TeVeNsGUrAg
	PQF+6aoQhjlyCddwF3LklWDDUfO2+evgNhONhON/GALZh8/LyphvyD2Xgy4ew910tOOgUj3SByQ
	dnhuNOhm4v83D4bvdmyuBSzzuFjc=
X-Google-Smtp-Source: AGHT+IFkqcbht/Z9kET9D030mGFZFTW4/RPeXFa22UBotYkviT8dg4bE+MVcepiuEYhDIm2gnxuL8wAP6O7rI/yMaVk=
X-Received: by 2002:a17:902:d509:b0:202:28b1:9f34 with SMTP id
 d9443c01a7336-2076e41cbcamr200524825ad.56.1726427162571; Sun, 15 Sep 2024
 12:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-6-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-6-feaabb45916b@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:05:51 +0200
Message-ID: <CAFBinCB8dhzNExOaO=VrDzTYLHHKUaxHZ49HzAYVnNZhAT_YFw@mail.gmail.com>
Subject: Re: [PATCH 6/7] ARM: dts: amlogic: fix /memory node name
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Wed, Sep 11, 2024 at 12:19=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
[...]
> -       memory {
> +       memory@0 {
>                 device_type =3D "memory";
>                 reg =3D <0x40000000 0x80000000>;
On the 32-bit SoCs we specify memory at an 0x40000000 offset.
Shouldn't we use memory@40000000 in that case?

