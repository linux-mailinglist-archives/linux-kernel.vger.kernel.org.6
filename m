Return-Path: <linux-kernel+bounces-422161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237739D954F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE241666E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AD31C3023;
	Tue, 26 Nov 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RGJGFAPd"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640318FDBA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616245; cv=none; b=KfoJde6HoEbWWbFQBve7FbSWsUP7EbiHCFqKsOXWTx989qKzvXcR7adT0K8nSfa7KX9/nuVYIfyvG60REK5sRrFRdyHyIDJS35n4XCJZv2KrLV1sdKBbmzeCA8Cl7s5y399nmNFBHucuaAAJtPqDrIa+5HWwBxz3Cq9Cw/9JSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616245; c=relaxed/simple;
	bh=0tb/1VpCPVFgloHLNFl73KUluXt5M3902QRNEkET+pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNIjQwQwNZha6CE0tvchqy8oNUXByExvZXX/cV3+V7Nt+izWUhpTBbjHCkoP+42l/s6M7krs7qvm0wiMh42W8Q8qZzPlj/p6RxwaaZeh8F8ZBFGPqZyBZ8suJHMoNHOnW7HWP4Y1QpxhVUk1iPcg1q0Js8ScoAGaQacPbtPb1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RGJGFAPd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa51d32fa69so546524866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732616242; x=1733221042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tb/1VpCPVFgloHLNFl73KUluXt5M3902QRNEkET+pg=;
        b=RGJGFAPdQNsQfMevtpemDeM6dOde7CWIWcijG7I4ciT+HQ3lfB+9mkPm787P8q9c/M
         qsw029uTGer3NtBnFf+L/k3nG2DX9umsQeqS78oKK/FenBmYTle1fQ/VTRQYDrGA8Phq
         FOAGTeaqNNDZT2z5Pzd+OdODHafQlkQ15r7ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732616242; x=1733221042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tb/1VpCPVFgloHLNFl73KUluXt5M3902QRNEkET+pg=;
        b=U+SKz6jCysYG0Xj2BGn0PmSjSsELcmnZ/3cTACF6NAv4GgfbGuI0YKsywIVQL00LjD
         bMBzmQ9E2Urc0fvgV8z7kV8Z+Pq2eKnAmFQ46l83FpQfRH9EQtDZrGTbbalqm92/KyZP
         qkCUmRtPdpzgI/i/EtCXk+frQ6xja667EWVsE8hgaIjCteNntna/g0SyDvx8uTk6qQjW
         di7voKFypmAExWT9kbx756c5y3k14BbY1k8/oVY2V5OKnaM9yd/K1zTm3XNXTtQWU5FS
         n8tEEkL4SiDQIOIdIlMezYnq+Szim75ZZJO+MdLvPyQhESbiNpAuFpPnkel/pBR6iLRm
         byiA==
X-Forwarded-Encrypted: i=1; AJvYcCVIGq5jjrbPSd8g1B+uoJItElEF9CX3BHdV6OlUNVm1zoBranPr62I7XZRMJHu9tAZTVAtZtdvMG6eC/GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOk1FPJ5rRe/FKFQ+cZ0l47Zvjl20dIBLGf+IxBMYVo9YCZ/t
	c/vOaAh/rLPbUVEYBZP7Na1ywergeEaoidA5Kdg76rkIsf2amOEqSfAZdvq1vK9DS2EYpx1gxal
	BHw==
X-Gm-Gg: ASbGncuvcR/ivGPPEqzgn5CU4MPye8PlT5DGwqxLGfaXX4zyP8ifcK6RNPgfnWtcSTn
	fe4tuQRKTQbh6IoavoqBVT3YYTtlfymY7I5CMLvtCJkPHLOLJV9kZrcS+Z/K5XQngZmgWvQy2+P
	eUAu9jZV0cQV502TJvQ+22IIBoCEjMle5UB+e63TnMXQoNHfIrn5o6TyRbSDoB6/Gg2fPX9Eol7
	GDWnj+jQqdAgM0DFSP53bsVV04nHLOMAcUX/z6EKBTHMNmlc7gZPUesi6rpXBp1dOF8gdOIKY1+
	8djrzwzYFXCR7c1K
X-Google-Smtp-Source: AGHT+IHYz/mVjFqHK3g+eis019q9rZ8EkzO1AAlIgWJ2F+KzjcCexxQX+8MRWhY0MEwQu6JYNCRXZg==
X-Received: by 2002:a17:906:18a1:b0:aa5:2d9a:152a with SMTP id a640c23a62f3a-aa52d9a154bmr770888066b.34.1732616241905;
        Tue, 26 Nov 2024 02:17:21 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57bd96sm581727866b.148.2024.11.26.02.17.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:17:20 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so5729a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:17:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWobf4Dk3ihLnPFoqoYInkfs6jylw/HK53gBDvzfRWHCyhdqnHlPvxZcURIXJZ/w4+thjxVqztd1HiVPsk=@vger.kernel.org
X-Received: by 2002:a50:9505:0:b0:5d0:b76:3ae1 with SMTP id
 4fb4d7f45d1cf-5d06f5111c2mr40797a12.5.1732616240006; Tue, 26 Nov 2024
 02:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-damu-v4-1-e746eec2cb52@chromium.org> <9004a82a-56a3-4d88-b0be-7e9d45932607@kernel.org>
In-Reply-To: <9004a82a-56a3-4d88-b0be-7e9d45932607@kernel.org>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 26 Nov 2024 18:16:43 +0800
X-Gmail-Original-Message-ID: <CAHc4DNKNrOUPJ+3DE+f+78-SAeQkuqEHqFXmwwaPTG+ni_1MMw@mail.gmail.com>
Message-ID: <CAHc4DNKNrOUPJ+3DE+f+78-SAeQkuqEHqFXmwwaPTG+ni_1MMw@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] arm64: dts: mt8183: set DMIC one-wire mode on Damu
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 6:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 26/11/2024 10:57, Hsin-Te Yuan wrote:
> > From: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > Sets DMIC one-wire mode on Damu.
> >
> > Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board"=
)
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>
> Where did this happen?
>
https://lore.kernel.org/all/01020191db901d32-5c318445-b8f4-4f4d-86db-316dc0=
db04ec-000000@eu-west-1.amazonses.com/

> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> And this?
>

https://lore.kernel.org/all/5a668114-2ae6-4217-9614-b690c0870849@gmail.com/
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> > Changes in v4:
> > - Add Reviewed-by tag back, which is dropped in v3
>
> This resend is very weird. Didn't you get a replies that this was applied=
?
>
>
> Best regards,
> Krzysztof

This patch had been applied but was dropped due to missing a
Signed-off-by from the author
(https://lore.kernel.org/all/20241009071543.5230cf79@canb.auug.org.au/).

Regards,
Hsin-Te

