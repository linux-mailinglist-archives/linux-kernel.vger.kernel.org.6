Return-Path: <linux-kernel+bounces-272654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F77945F78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1941F2346B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF24210196;
	Fri,  2 Aug 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP3fQJ5l"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B0210180;
	Fri,  2 Aug 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609196; cv=none; b=GLPXIyvnMvMG3jgeJ1PihFFG1b7HjpS7PXiZWGvvMaAjaB0nXEWaj7BJfZeC0IwOsfvFMCtSTXIO2pWj8PQIPBUe27Jz87ETtfYroND1P0sIJG6BXyrSyfYEMaFiGQtORjoVXMgKMMKDjO5HcpYlAyRLKF0fkE9rPiN+6xCu0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609196; c=relaxed/simple;
	bh=Jbq3Kk+4K1zGUJD2BxakquhhgxFJyuurECG6gSj6e78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7ngjJVDpJpT7SfPcc5CUjCqIX22xH45EEr+xL9l/nougs96Fm8aCwBzkrJVw8Rp3AaUtALHPwi0alr15w75kTy9CJ4DfktahTojivSUc2Y1IJHZMEPJegfZU1IutLf/YGlEtVNSmqDHk4gIgf+4K2Tm2QjSTg9cCKa2/Ox1TZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP3fQJ5l; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so932139b3a.2;
        Fri, 02 Aug 2024 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722609194; x=1723213994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAm2XYZeWuKP9P2ZHjYHA13ZsL8qNHmm4A+9E90Jfrs=;
        b=HP3fQJ5lCvi54TWqnYYtgy87DpqVfmOzJMSHx2dCv18BfBxWob45TK85fNfW2+HrKJ
         4LaSteqchyDI5FBlhVtvLr6F0LWllKm+Uy+LNs+X96Bb5tg1YwTHpYPQIEIzKr8FLrNe
         Uhjxy+a6DvfTVCk2JSU+H+nabGQrvXvNtngC16w7e9uxrQNmFM77UxxN80B2MEsqs/8N
         o5fpc/mNH7cmaHO44Scnlj/mVXwweYr4M4MX/9OBLkHCy1iJXKxAB0kFCik+2PZ/iQyQ
         tbmy9ZHMaVTPLQ7tfABUe8acJQ5SHoRnxDn9vJYN+I7HUf/+HxtXirBACwdkv5CqsLhZ
         GSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722609194; x=1723213994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAm2XYZeWuKP9P2ZHjYHA13ZsL8qNHmm4A+9E90Jfrs=;
        b=U2VTyon5tllHTuoCM2w96Kfzpq3lmmLMVXuXAQwaikXqP7lJNOQ/Hil0keMy99k0zL
         Hwk0SUDg55rbh0f8Z3lcVyTYeXBEU7E08Z1gelVLCTDb+6k9i0u/y17fIBbFH8Vlzl8a
         3z3FGns4mbIjmRgC01skUKDgl0N5rUwGXPLWNTBy9uCMiqnPKKdQvItgVGbcAXpwTPSh
         KdZOL69xB7ztdYfzAGJxiNYhqniMOzMHyaADs/fFUlm5jk1dG4xqYEeEnddfV9pEKa6W
         8HmGLn62G+3BvZh2IQAF7/GxzR/MZlOjOXu7GWP92oOhUzzQ2Qxaz+xwoiY1223tP2Ed
         p/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWInFCBt2yQmnQ5cSV0NmoCahLWa1Ba8Xt5Bcr63n9+c0RmcLNYsTJ227sK7ImeGRIJObnUw2eIpzyPw2M1kJvari2NKqWW4HjLDbQvvTwTD/xogje94gvBCTcEqSbFs41QIlsFpqyV/g==
X-Gm-Message-State: AOJu0Yy02l8RZvS1o0nfSu/9IU4gIOEJ8tpRA5oB7E1BKg/gHuuzWQw4
	3UJv2ELt9o3m50kZ5qTNiGhGKImcnCWJKhODPXYm6vnGR7+t8obRjb8VpLkMaloh1Lv73/CqXJR
	cOguq4JGp/THZ68vgGMAKj1PJYxo=
X-Google-Smtp-Source: AGHT+IGcc4C9Ka0Sg4b61PSMIOJ2BWzWUV0ocUvXuqe7MukMJIzauYH7pJmkF4L4LfsRiVThDQAWIFhXZPNyGPVlTec=
X-Received: by 2002:a05:6a20:2448:b0:1c0:eb1e:868e with SMTP id
 adf61e73a8af0-1c69955a53amr5180052637.19.1722609193653; Fri, 02 Aug 2024
 07:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801161005.120111-1-alessandro.zanni87@gmail.com> <20d128b3-ad81-4338-bd59-a039ddcbbadf@kernel.org>
In-Reply-To: <20d128b3-ad81-4338-bd59-a039ddcbbadf@kernel.org>
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
Date: Fri, 2 Aug 2024 16:32:37 +0200
Message-ID: <CABq9Dx4LDdHaknB6XgMvtT41tWtDx7YGnFCi6geSS-0J1UxrzQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: edac: Add Altera SOCFPGA SDRAM EDAC binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	skhan@linuxfoundation.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the review.

This patch aims to be a conversion from txt file
"bindings/arm/altera/socfpga-sdram-edac.txt" to this
"bindings/edac/altr,sdram-edac.yaml" file.
That's why I also deleted the txt file in the patch.

Maybe I should have put a different title to make it clearer.

This is the original example in the txt file:
sdramedac {
    compatible = "altr,sdram-edac";
    altr,sdr-syscon = <&sdr>;
    interrupts = <0 39 4>;

and this is my conversion:
> +  - |
> +    memory-controller {
> +      compatible = "altr,sdram-edac";
> +      altr,sdr-syscon = <&sdr>;
> +      interrupts = <0 39 4>;

Sorry for that but, to me, it's not clear what I should convert in
this example to complete the yaml file.

Best regards,
Alessandro


Il giorno ven 2 ago 2024 alle ore 08:54 Krzysztof Kozlowski
<krzk@kernel.org> ha scritto:
>
> On 01/08/2024 18:10, Alessandro Zanni wrote:
> > Convert the device tree bindings for the Altera PCIe MSI controller
> >
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >
>
> Subject: you did not add binding in this patch. Binding was already
> there. You converted one to DT schema.
>
>
> > Notes:
> >     v3: moved yaml file from arm/altera to the edac folder, removed items keys, added general node names
> >
>
> ...
>
> > +
> > +examples:
> > +  - |
> > +    memory-controller {
> > +      compatible = "altr,sdram-edac";
> > +      altr,sdr-syscon = <&sdr>;
> > +      interrupts = <0 39 4>;
>
> No improvements here.
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>
>
>
> Best regards,
> Krzysztof
>

