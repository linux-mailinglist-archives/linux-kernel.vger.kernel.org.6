Return-Path: <linux-kernel+bounces-255365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D5933FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED5F2852AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E82181BB5;
	Wed, 17 Jul 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDDbHEM/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA632EAE5;
	Wed, 17 Jul 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230459; cv=none; b=Zft5A6TZBaH8S1bOSzH2M0qmTvGDG+RGWiyHTgd5sCbT5njucvosm6Ub1mzsffLF4CaNsAd8PJnVZA81yKhVY0DUJBYT012qhuSkSDFIAJK8QXz2huStc4O7Awsb2s06jNud2XAbn13sVTsYgT9Ey9+scN8Ru+K8jQK2QJ7YT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230459; c=relaxed/simple;
	bh=t4iPvhXVa3AMcXzBfJFgYS6s3OmUCR4MVqbnPIR6/kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtEcjG97eoZIuxyOyGCTaWSaivXW7osru6yQMRuCrt8QgU6k6sj4WicszwMqgQ0JIFndOIPEqiStQWKl9TjuLx85g1fptS0nNKhaKHAx8Ev+oWdyJl0BUizf6xXV3DBYfyHE/dok850AwseMNrQ+tTN+PvovDsk6YqsgPN+W5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDDbHEM/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee86c09963so8375901fa.1;
        Wed, 17 Jul 2024 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721230456; x=1721835256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4iPvhXVa3AMcXzBfJFgYS6s3OmUCR4MVqbnPIR6/kI=;
        b=MDDbHEM/ZsUoVQ5ICq/Amu+yb1ceG5N3XNWoYF5ww15qgDuIGdLNyTAqWSjSwV4Iu9
         2ugHHXOQkkaHm8TS2v7Oehmkxp+w8nRLrjrBtq3LWbQ9H2QQPHLtNMIpVx8WBNyx4G0r
         VWGPWmZF+m53jPN2OviFVgVflUVm+PP+cj/D6QvPzpwmyS4nmOSO+U3m8e7IbBlE3N8G
         gpT7YuSw60pHng4kZJVKvZFl2TXUP4g9nlM0/hxl4pfQSMtGattfLxNVQNRp0NRM8VVH
         lBipGX93V6YIJy5wH9VBbK5Zlhc/D0Ocj9tYqw5e7dGg2VlslSLA6V2Bv9evQPRPa/36
         LLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230456; x=1721835256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4iPvhXVa3AMcXzBfJFgYS6s3OmUCR4MVqbnPIR6/kI=;
        b=rRZJMV72SIy0UYmIAaQCd5zelf1HEoRCrdFDCOzVoqCQXEVK5UlV4fm7xlrlzjAo4u
         jriectrjygFgILYggn4aMY7yNL19+js3nmdLGrWoq08fTAsSCSt8tcnQ8ImlQjD4wSJe
         ssrnpI1UPjWhflooAOZA/FFNWz+OqgcmHCDozwXqSacoomCNplJgVXx3tGJlXeDXVbQb
         Jocok1sNkhMiTHbvsQWEqlIagCtatFrRVd7bIj8oUfsXV1SB7hy5Y7lNBsCqrpne+A2+
         JqUF2bjRRfiNfoutnOBCNiCW/V5MC3qZHcBbdeoS5iTEQqcqzY/2qatoLaB/QXzZqXdU
         lqvg==
X-Forwarded-Encrypted: i=1; AJvYcCVn/kQuFvCT+W+E8g+/rggaPfxg5V82EOVA8LCGqavrZR4oCIqe8C159Wf+MBfiO83xBpJW5JfSP229JjuGJsssALkvt9PZLgVFwRPZIGwJUOq1aWo8sNG1BCeKpeHlSqtvC3IEjdR7oQ==
X-Gm-Message-State: AOJu0Yw/NugH26c0xqrIZtR7IuDpY2k4nniTOczzyukGntVXmcnBKKGh
	WlEFv+BU+u+erXD0+XO/YMzLUlLx+Cz9ivEDy41gWzCkO/6MnVrQQ4gAitjy1pt3l0BtfUpEgLt
	6wpvV8H13HuGHwI4FmoQLlhC3WIw=
X-Google-Smtp-Source: AGHT+IFmkkq4f7VL86QzMTkqfkn1QPaCGg45UGmOuWB0BRvqpLJXZaINMT+NvWxqF4p/9Ea4jzkHPBRHbM/d6SY4tmE=
X-Received: by 2002:a2e:9b0b:0:b0:2ec:4ed6:f4a with SMTP id
 38308e7fff4ca-2eefd1521d2mr8120191fa.5.1721230455575; Wed, 17 Jul 2024
 08:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-anvil-ashy-544e80a1317c@spud> <20240717-parrot-malt-83cc04bf6b36@spud>
 <3870188.FjKLVJYuhi@diego> <CAP9ODKrpKDY91AFDYj7s++kU+=CSLw=F9mXyLZ621Mqq-8S6bw@mail.gmail.com>
In-Reply-To: <CAP9ODKrpKDY91AFDYj7s++kU+=CSLw=F9mXyLZ621Mqq-8S6bw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Jul 2024 12:34:03 -0300
Message-ID: <CAOMZO5C7JknQaftquRWDetLs4W0CHMvs5PiJWBLyo0G1oo4rCA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ARM: dts: rockchip: remove unlikly-to-exist DAC
 from elgin-r1
To: Otavio Salvador <otavio.salvador@ossystems.com.br>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
	Otavio Salvador <otavio@ossystems.com.br>, Conor Dooley <conor.dooley@microchip.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	imx@lists.linux.dev, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:38=E2=80=AFAM Otavio Salvador
<otavio.salvador@ossystems.com.br> wrote:

> @Fabio Estevam can you check this patch?

Correct, the rv1108-elgin-r1.dts board does not contain the DAC.

There is an LCD controlled via spidev though.

Conor,

If spidev is needed, what is the recommended way to describe it in the
devicetree?

Thanks

