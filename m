Return-Path: <linux-kernel+bounces-403786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECE9C3ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56E2280DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FC170A2C;
	Mon, 11 Nov 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhLPy+Oa"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887C146A6B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317164; cv=none; b=HmEdHZX0s8VE0Kor8aB+DOtyRoply0AjJ2P9z0Qx0UYxoXWTq5QSFqsG9J+qvrUdjme+jkFBwRDQ6QJNMgDaglI+1jMLWrmjmFUr8jzNeXv6U7PxfW1nLuzdUYQYe0XztscklE8XtdGKuRjuUp9WldcVcfrZLsP0D2QMv/7Yym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317164; c=relaxed/simple;
	bh=7b0FRW3I7wDyYICQeheBD5oP4FfuE3EXWn2TWYS5OuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUFkOoDk/u0lWLg5NG208W50SQ9LBdq3f0aPR2FhKPZZ1vw1I8ssc6UcOQh0xYTUxuf52SM3XP9TwyLtqa8NMQzRo4KoF1HuLGGuwnoKBT8tLPtGLhjENKPpw3yjQtoLY2F0pmXWNi8X/x59WH/ode3NEIKPRz/4mRwwbRCIuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhLPy+Oa; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-288824e9cc4so699194fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731317161; x=1731921961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16u+npe4MbHHsmpZ08MOYgrA6j2B46LPWEmoqUuH2IU=;
        b=fhLPy+Oa6xw/6Pcs5jCk4LXDN2iQon6o4T9ksHFed5fO0WQUMweUga5ZQ1rOrxQIlg
         264T7ealswyq/v0k9OqIIfCzY9CGe1azn5kLQQuv9Udt79uUHpUGwaAFngJyMRYqix6s
         tW1WeAsdQlU5FOS5ASOB+/kEFwcyz7OMB/tnAaS4JSOaipmOzF1BvlVCe4gRoZleqEZs
         LH6sf5ptv0D57WqNl6b7XfeZdSH2Taln9GH/aNHYzAjhBMtFSOsEncm94W1oWKyjJocK
         P+iEoPd7+WxExH78J7n+BXcsZtgJUMj6YYEH+HYvxjLa41r9WxkCPv0zozfzjVB/YEUI
         cihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731317161; x=1731921961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16u+npe4MbHHsmpZ08MOYgrA6j2B46LPWEmoqUuH2IU=;
        b=BkVjOTUwjU2fVqB6FaeaIBebvuHKdvXjUbCRxRha1wNz7KUUn1hqs8Z8kFec8fYq+b
         BehvS63Wak0HXe95Gk+Ik7Pr9ddTuLdQ+T25L2JHBQ/GMi4YRPCd+Q9fbBYqJQ6K+kh7
         OXeX63o0+rFoVLlAvAY6xiKhXJpzmLvV7zvfFBPSsxEpmAY9MfOfxaSTJBl/fm5pebuf
         g4IEQcWWzKg6gG4zVqka2ucw/vpKZYpJZYj5cfqkHIjCUvVdcnw63xDPeR8jUxmLpH4M
         rMNd16nvclLDkz0HrKbH2RL0ZbjlaBXaHCyrF4KZ5MKc2NxTqKiWAwW70G8AIeNHa7qx
         Aucg==
X-Forwarded-Encrypted: i=1; AJvYcCWLPrGzmOd2jkLsYmqoAhOzaN1Wi+NQfACCBfrHqKurOUHjl8gYJrB4BBLKu+raIfU0J3Naalw5Nwj5yro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkMW8v9NlLvyhhNUlN+34wElj1VIjghUT6ZtbxK15irmfGoVu
	IR9qHirKJrfzI4YZYEWo1aNeVwcNO99ZCAOOgdPZzWGA5OMtjYdBDV+UPslQLnP8rwJ1DflOBTt
	Kb24dBmv8Kamx9AxW/9Gz4GUTf2yg7u5LinPo8A==
X-Google-Smtp-Source: AGHT+IEbddWaWnCjkmvVli+HftqZUgfuRo1RHD4WnRBKP26ug1MHqgXnTsC6sGlZxqlzp2/8eme4zlIKL3HJtTUpKNM=
X-Received: by 2002:a05:6830:d87:b0:718:ffc:9445 with SMTP id
 46e09a7af769-71a1c1f11b8mr2581183a34.2.1731317160303; Mon, 11 Nov 2024
 01:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Date: Mon, 11 Nov 2024 17:25:49 +0800
Message-ID: <CADYyEwQjDUALxi482d=KTY4Jt1zpbByPQXjF9YR4hu-3Qd-u0w@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 0/4] arm64: dts: mediatek: Add MT8186 Chinchou
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	wenst@chromium.org, hsinyi@chromium.org, sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

These patches have not been reviewed for more than two weeks. Please
review them.

thanks

Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
=E4=BA=8E2024=E5=B9=B410=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=80 15:27=E5=86=
=99=E9=81=93=EF=BC=9A
>
> This is v3 of the MT8186 Chromebook device tree series to support
> MT8186 chinchou platform. It is based on the "corsola" design.
> It includes chinchou and chinchou360, including LTE, stylus,
> touchscreen combinations.
>
> Changes in v3:
> - Add a patch to change codec in pmic (in mt8186-corsola.dtsi) to audio-c=
odec
> - Link to v2: https://lore.kernel.org/all/20241018091135.17075-1-xiazheng=
qiao@huaqin.corp-partner.google.com/
>
> Changes in v2:
> - Modify location of "const: google,chinchou-sku17" in mediatek.yaml
> - rename "pin-report" to "pin-report-pins"
> - add "vcc33-supply" and "vcc33-supply"
> - rename "cbj-sleeve-gpio" to "cbj-sleeve-gpios"
> - modify subnode of sound
> - Link to v1: https://lore.kernel.org/all/172900161180.733089.89635437453=
85219831.robh@kernel.org/
>
> Zhengqiao Xia (4):
>   dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
>   arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
>   arm64: dts: mediatek: Add exton node for DP bridge
>   arm64: dts: mediatek: Modify audio codec name for pmic
>
>  .../devicetree/bindings/arm/mediatek.yaml     |  28 ++
>  arch/arm64/boot/dts/mediatek/Makefile         |   3 +
>  .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
>  .../mediatek/mt8186-corsola-chinchou-sku1.dts |  35 ++
>  .../mt8186-corsola-chinchou-sku16.dts         |  29 ++
>  .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 321 ++++++++++++++++++
>  .../boot/dts/mediatek/mt8186-corsola.dtsi     |   8 +-
>  7 files changed, 441 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-=
sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-=
sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-=
sku16.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.=
dtsi
>
> --
> 2.17.1
>

