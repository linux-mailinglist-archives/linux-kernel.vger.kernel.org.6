Return-Path: <linux-kernel+bounces-363135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947399BE49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EA41F22C22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34C8248C;
	Mon, 14 Oct 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT1WX7fb"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA080231CA6;
	Mon, 14 Oct 2024 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877285; cv=none; b=EHy/+rAJq87MeFy2kMLxQPFt/fbrKEgRuuX7KXg0mNxRX9IW03WcAfuKAOkbcAI3xfpNChGpG+KHZvk3efeldyyvAVZFzk11BvbJ/qdXbpe/OjEHJXX1lplRGpuqlwggvl9BtzW56+7R4CLSCXzW9dJ5jxo0eslDKZsIengTYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877285; c=relaxed/simple;
	bh=mELz8a8zfTbhzWj4Dc9TOqu9NWONfm+X3dBjyrOSck4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF1+0gYVXeJHxf6mIXSOMu7JQ36t2SgPEL92Lidbk9FzPUskuC1H5M0Cc5UFTJpr4oqYPHTQB3xn5YGyaSfCl+VhBAk0mSV7ukpGpHgWx/MGer25GM70KzR1LxXb0fdKvzVgKbH8x2FpM1UyzH7RTb+I8Ya4/oHcQXIiRsNSA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT1WX7fb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d495d217bso3337948f8f.0;
        Sun, 13 Oct 2024 20:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728877282; x=1729482082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mELz8a8zfTbhzWj4Dc9TOqu9NWONfm+X3dBjyrOSck4=;
        b=KT1WX7fbciOEQ+oV0LDnitGX9YaAdVOz4tQCoNjzseocLHTzy5mpKIGbiOrh13LDfp
         Xw761OAcF5O9wtTfbGcNMxVc+vwZTMdNnGYnnMfcqFQHKnadoYIU2i1UylD/zwhv5Qm3
         J7WU5Fe2+YuCbbpNH/hB4HNiGtDiwuxPx+fkStnxA40Jj65A/90qs4lKx261Xq16bbSH
         yMYuXDY1VT4IR1axCgV+umVfUUvv0HifomM4C4c35GbTJPyy7mjRLkwrR3K8GboXSa2S
         v5iew4GiUeldz4sz7aEggFWp54kKyeaLX0AU21L4r/k2ZaYqMWT9BnNvYRZ0AF+mQP88
         oaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728877282; x=1729482082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mELz8a8zfTbhzWj4Dc9TOqu9NWONfm+X3dBjyrOSck4=;
        b=mc+QS1aQeumCBas8yucIbGc7tuVfgEyhd2vCIOr4c0Ji6otd3Q2aFwFwA84GHzawYh
         u+nHSwwCYmp6QDiQtXZW8xMltCeNlzGTK2gZ19PaqzSu9S66RpY4rIMkO1F6x3j2k4Yi
         47IiLh4E8zeo70jCtfD1l56ooNlrk0laB1ycsJDKRBY0Btzvl4BDYug2k0U4hd2MzoUs
         woOVbXra3S87DO8bLjGhO/OP+5keCO2MTlb86nth03wcv81NJjN7y7lCaAIHXoPQtkIn
         x+DN+pQuPkzFKeL1CDoIQSiULIFcWuxMI/CVTLzYEi4cwc/e2KOEYk/Mx2H9UfrGtjqB
         smfw==
X-Forwarded-Encrypted: i=1; AJvYcCWP9PBX71NwGASvrpZjUIAxJcrnZ1Vq7baidEe/vBIiJaYtw0Lkl/Ljp0V7ZX4TZwSssTHKq5eJrojFTdEJ@vger.kernel.org, AJvYcCXhaPhV8RC+RF+7DF54+e91t7+BgWc9N+UkOS0M6vp4hbPPJ3hz1PJDG0c9397PhoyHkHQ8wrCVpBWK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39dobcGm+xC6J6k0W5y2HXmZ6K0sLJaLN3i4uaklO/Ijftxde
	vttCMw4Yc+WkEValRfFf0amI5XG7The277OKFTJlx5OX7g+fvW5I2JVdQY+reBQqv2YfJf6F5k/
	8xiKiFUQM9jn+iqA6Wr7bnUyEyDM=
X-Google-Smtp-Source: AGHT+IEuZXkrca6rIsUVQwVU97haNonzhsHAqe8u5lA+PAFqgXiPP+0kQTUchcBTz53mVNKJeYrFkQei/keoHkeSEYo=
X-Received: by 2002:adf:b359:0:b0:37d:4c40:699 with SMTP id
 ffacd0b85a97d-37d5ff25593mr6606983f8f.5.1728877281830; Sun, 13 Oct 2024
 20:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013213305.310844-1-cenk.uluisik@googlemail.com> <20241013213305.310844-2-cenk.uluisik@googlemail.com>
In-Reply-To: <20241013213305.310844-2-cenk.uluisik@googlemail.com>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Sun, 13 Oct 2024 22:41:10 -0500
Message-ID: <CALWfF7+nek6S--Cfq51QE-vSTnnENkbzgGiQkH7RQyjXeUpC-Q@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] dt-bindings: arm: rockchip: Add Orange Pi 5b
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>, Andy Yan <andyshrk@163.com>, 
	Jagan Teki <jagan@edgeble.ai>, Michael Riesch <michael.riesch@wolfvision.net>, 
	Jing Luo <jing@jing.rocks>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 4:33=E2=80=AFPM Cenk Uluisik
<cenk.uluisik@googlemail.com> wrote:
>
> This commit adds the Xunlong Orange Pi 5b entry to the device tree
> bindings inside the Documentation folder. I know you said I
> should extend the Orange Pi 5 one with an enum, but I made a whole new
> entry, because looking at all the other entries, they also create new
> entries in a case "like this". I hope this is okay, or maybe I misunderst=
and something.
> Thank you in advance.
>

An example of using an enum is the NanoPi R6 boards
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/arm/rockchip.yaml?h=3Dv6.11#n241

>

