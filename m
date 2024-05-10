Return-Path: <linux-kernel+bounces-175212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C248C1C69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20B21F21968
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1713B7A6;
	Fri, 10 May 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBhpw0Q7"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F713B7A4;
	Fri, 10 May 2024 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308224; cv=none; b=Ls92MTWzAwuOSc5mS316MeFwhgnbc3zsCTUOpXWz97A/3jBWYwYXuECaRW1b5rOEx4XxLchJDSDJtL6bPDpXDCsll7xlciVgw0/6jsjQtsUSjtTSo6FX/HDWqy0Q8eJ4qjaCylgyJs5NkxJBGr/17rnRSnkmngFhBjB3LPkN/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308224; c=relaxed/simple;
	bh=ZzdVd+yC6m/YJclBMlBaIakLpO01LhOZQZwe/MSFkz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl/CuV2LG3QPk2SEe6wszVsvWHbt/Uxg1wHyCguUSa6Ouo0CpX/ogtPTLpjW0v79mDI1z8NBesbthL7UOoKZyXzdhX9hexrNF7/7uuo360RExQ8oahyJl81Biok55pDytUl+Q5qJhKgApndKhAeAVNOJZw4JQmy7kWNRZXR+tTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBhpw0Q7; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36c8a1dbec5so7387445ab.1;
        Thu, 09 May 2024 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715308222; x=1715913022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21VKHMMaZA0kpkZw9wZiu6Ve2UlBKMEGNlaolOO9V6A=;
        b=cBhpw0Q7afDtIOlM/JlRNAsJnRcr6nxPZ/7BVZLGOroQc/Xk76kz1DFin0Vb58+dPj
         Fal57/ndOeXl5p2Gs7Y/c/j1YUWeKNzwIv/2wVsOjkjjy43uoY9Fph01ESWsfZwQC2aP
         Pe7QmMQUN64xUk0rV4H+p9ULVLt+EHZXb/pfDOYNuPQPMSJsHFE1iOmc0Mbf3Tuc3jCo
         xLheZkeQICaqCIGVxdIw/+FsFCB5uq3AmQbRONN1mJeoFciqhRrZ2FVEkSsPh0MEQYdo
         +N3sFPYEYI+m6GtK7hZYcFcNj5L4PhhUkAmnoWKxrTnyqBopNep6pozX1JKtpv1e0yjV
         m6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715308222; x=1715913022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21VKHMMaZA0kpkZw9wZiu6Ve2UlBKMEGNlaolOO9V6A=;
        b=Ytk7aTTsFOjm7b3/zH7ErvGCEaLPXM5kEWYq1H8tLLHkX/1hqbd90TFoGqtvnnhmDy
         7WZmkuXL/lGzwt217fsHVkQQLOvBCvr1ola4Lfx5B9BkTTTolk19fG8we8UhFZPlxaGt
         SUoECRd9JIXkUX9uwzIUWX9q5t8+MD3n7EhkrujkqMucwsUfC7EbKRlgUkvQROI8tfHq
         Oa6NEHKsCe4KeW2PPO5dg11FQ5IILD6Hfmsl24UlONtZY1BdMc2M3QuIe2vAyZP8U1D2
         1iGAIj5a3cK+wWqR/RG10qE8iH8zQF920aH+8GHicAgjLrvUfxzIkxOaenAIQ/tShxV4
         ELuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcuxKnxBrf9Cn/X7q6sIQmFXygos4iIKVubfMtDa9W92vuEqKUCAZ6HCoID9CgEazyHHnvIp6xYd5WOe6Adsz5tXFGGUgNhBKpPsN9k6Ff82sAyZa4OOYx9vsCysDN4XCYc5/lS3Pb2xAAweHq0pUbGV46EgWMpSp3dX93jiYTtmAAR+Al
X-Gm-Message-State: AOJu0YzBHYXpFP3/gvmf2BxfjttCG5S0xXTgX3qBk4WeW4o/7DHtuRlU
	Sj6+9q33VJ2FzDiak9uK0r6IkqVQLQNYt6zbN/GHfB82Duc1zk9zDKEVt+VSA0ZWjfEvIbSVBZp
	FFnyjEjCESPejuzJOyr1tdvyXym4=
X-Google-Smtp-Source: AGHT+IGrr4iwZg6NUnOgkVHX9/Croov3vFT4FOj9bA67E1Jv8+1P0qtMgoPO/Vex1YuXlIlPwX+ZWDLIR3wv6gRTbps=
X-Received: by 2002:a05:6e02:1d83:b0:36c:47df:5922 with SMTP id
 e9e14a558f8ab-36cc14e12bemr19098315ab.29.1715308222256; Thu, 09 May 2024
 19:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
 <1715223460-32662-2-git-send-email-shengjiu.wang@nxp.com> <20240509-phonics-wound-58d3435165f0@spud>
In-Reply-To: <20240509-phonics-wound-58d3435165f0@spud>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 10 May 2024 10:30:11 +0800
Message-ID: <CAA+D8AOn=fPmUHthSRZeAYSpA3mCCdQQAT2SmqjAALo8nRPHsQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: fsl,xcvr: Add compatible string
 for i.MX95
To: Conor Dooley <conor@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:11=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 09, 2024 at 10:57:37AM +0800, Shengjiu Wang wrote:
> > Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.
>
> That's apparent from the diff. Why is it not compatible with existing
> devices?

i.MX8MP:  There is PHY and support eARC, ARC, SPDIF
i.MX93: There is no PHY and support SPDIF only
i.MX95: There is PHY (PHY is different with i.MX8MP),  only support SPDIF.

Will add such info in the commit message.

Best regards
Shengjiu
>
> Cheers,
> Conor.
>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Do=
cumentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > index 0eb0c1ba8710..1c74a32def09 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > @@ -22,6 +22,7 @@ properties:
> >      enum:
> >        - fsl,imx8mp-xcvr
> >        - fsl,imx93-xcvr
> > +      - fsl,imx95-xcvr
> >
> >    reg:
> >      items:
> > --
> > 2.34.1
> >

