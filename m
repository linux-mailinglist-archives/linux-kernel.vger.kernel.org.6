Return-Path: <linux-kernel+bounces-423827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6309DAD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7248316529B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0182010F8;
	Wed, 27 Nov 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN0lsPsa"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FC2010EC;
	Wed, 27 Nov 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732748; cv=none; b=E38uuwq4sjEf9Pc0GNTvqZpGHAd02g7ihJULqMRRUbmTExaELvp/VZnSQ3wFEPkxsDSotnw1iVlquNHbXhRmk6cmpFOLVROK1nJeFpWXShIWQ8DXp8kQmHffZp1v3sYphPD0qFinMTCwXZKhFViEbGzNsvHQPJqDdA02Hak5LVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732748; c=relaxed/simple;
	bh=prk4w3AFibrQXsEB3OHmUy1xQXvgSEU3wphtGpL+kqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUw9SbMCQrE9BzgFbKNVMocXdTOC255bvfA0rSUWW4u1OEZ10g8e8WRdwGxWbv6d0qA7C9v3VnmM1D3uYxWUQvcRxZEisG2K+WMQst7bnqCcCezf09iMZ7iavTYMU3PEpt1O73hdQ4wWDNRsNSU8CvfJvVxZVKB2qs108fpok44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN0lsPsa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-211fd6a0a9cso32255ad.3;
        Wed, 27 Nov 2024 10:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732732746; x=1733337546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UaSCewOAz1MC+uF5VfjhdECGUiSX1B4mUUKrmti1jEk=;
        b=WN0lsPsanp/rGAgYyXfRre9iA0iSS3vt87IRmoSJYgk/42ofEPCqc+O7HlSwCI25dR
         J8UMtKou+aQhODPIfxWshubCTn9rU4n0lIheiwTJ900VkkFqLLut/XLd0/s7sLXL2vfj
         dq8p53lmuIPr4cTc4QofXwOqKB2hNBDfNeuowuWRfSSx8/blm4UsuaucRUsz8tp9bMAE
         GwaKGrvIA0Lr7sVcAFXQuteKZdi2yCNbwCo51NZbt1a8uNBK8qk6zCfJANAyuIpijCuz
         Uqb15WWjdbqeGuSO7I4mN9zhM5YG0TfuG2YTF1k2snHSMdYaZTGTvRvTJEIFC1k6YDS4
         vRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732732746; x=1733337546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaSCewOAz1MC+uF5VfjhdECGUiSX1B4mUUKrmti1jEk=;
        b=ayFCOiT/+VrI62hS6+vUt7M88cJ55JqZ2Bcs3bXdwXI5sbmVhQAnB0RglUql5WJ8fv
         BwF0tTdVPklVOOt52HhN+goETP8IY1WQH+/ih9F7/h4zuLl3Xp1KdCMrzJo22TRbbJTA
         G1fkFKjWDA7ht5A96LhOOAcYfv5+JhVthEsDPPmmNbAltl45fW1lKsOvgQmXnomzoEqr
         p0Dx5EvU1l2HnuJN63a6l0afW5UH9l9MAXaJFzoLB8KRDPdG38HnQR21FGe05gCHbVb4
         kDJvyn8NvwZnJVdjh5FQRS3mLVTReBeaTFkroD/N6KVXWoWXnXcjouPNxEQMejbSe4dz
         WWAw==
X-Forwarded-Encrypted: i=1; AJvYcCVshq6rAMbzTmMOK4SWjNBPBOZvdyo3XH+6WNAZFTn4f/ykAAuDz6toSfMVBA0hY1ryQhJX3ccPGNOcNnEf@vger.kernel.org, AJvYcCW4sQ32HmQUo540So4QjtX00/o5jNxqdARW930MpkBY+wG6Xd+xA5Xqx2+PSzQxSIUVKWNYlWG1zdzf@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvLZ8excWtIAoMbMlA4PdSZF1xbDvKP1aARo06cLuPJB4GqGD
	71TNhT7TMDHihF+XRaF4Cy9grTh5HqXbDqNrC6/LKGmCInMEOMV1YhQOutI0f7M=
X-Gm-Gg: ASbGncsMAixSAp04rCnwj5guZNmjvU014Eoq9qKwrJ94aiQ5uVWEEoZGfitMPfAQEBi
	PklI0xYagXKpi7b6HnXplgpbDhdWXvR5yaINLD5ls9x/ejxHExOpVvflWyvz4nGjelqlOOFGwNf
	JjGGpibM2F5mQEVk7OW1mSL/7oCZ0LMAAugkjN4iR+ZDxCTgehu7Zh3bx7uY/1MfJm6aMmZCMOA
	Jj/if9EnuMHXP5kgBSH/xIu7NXneB9Y2ZIUrunCa9nRKIzz
X-Google-Smtp-Source: AGHT+IGhx34DRsa8uxFgpl8ldbCeAEFgFfVZ5YwC6dpou4pfJOmsKdHkfpUchzoB3IylveFgpWYqRA==
X-Received: by 2002:a17:902:ce08:b0:20c:da66:3875 with SMTP id d9443c01a7336-2150175eb06mr64426315ad.24.1732732746107;
        Wed, 27 Nov 2024 10:39:06 -0800 (PST)
Received: from Emma ([2401:4900:1c94:da7e:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc21b5csm106070115ad.227.2024.11.27.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:39:05 -0800 (PST)
Date: Wed, 27 Nov 2024 18:38:59 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, 
	Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v4] dt-bindings: power: Convert raspberrypi,bcm2835-power
 to Dt schema
Message-ID: <5wzekgv7ccja7ucz2w3byprltalflx4am24scecxjokra4t44g@ll56dfqotyoq>
References: <20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com>
 <bdze3425qwrtlvlairw2b4xiycpkmhirzhqn2jt6jngc3bu4ta@uo4nc2lnj4sf>
 <qb5sdh55yj7est52netydaauazgluej6hvvtutmmiw2bhglnpw@lq2cyg3hjhlw>
 <b81cd6bd-4a7e-4032-aa56-843793a0e0c8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81cd6bd-4a7e-4032-aa56-843793a0e0c8@kernel.org>

On Sun, Nov 24, 2024 at 11:52:35AM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2024 09:49, Karan Sanghavi wrote:
> > On Tue, Oct 29, 2024 at 08:10:23AM +0100, Krzysztof Kozlowski wrote:
> >> On Mon, Oct 28, 2024 at 04:44:12PM +0000, Karan Sanghavi wrote:
> >>> Convert the raspberrypi,bcm2835-power binding to Dt schema
> >>>
> >>> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> >>> ---
> >>> Changes in v4:
> >>> - Corrected misindentations and random differences.
> >>> - Link to v3: https://lore.kernel.org/r/20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> <form letter>
> >> This is an automated instruction, just in case, because many review tags
> >> are being ignored. If you know the process, you can skip it (please do
> >> not feel offended by me posting it here - no bad intentions intended).
> >> If you do not know the process, here is a short explanation:
> >>
> >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> >> versions, under or above your Signed-off-by tag. Tag is "received", when
> >> provided in a message replied to you on the mailing list. Tools like b4
> >> can help here. However, there's no need to repost patches *only* to add
> >> the tags. The upstream maintainer will do that for tags received on the
> >> version they apply.
> >>
> >> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> >> </form letter>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Dear Krzysztof,
> > 
> > I hope this email finds you well. 
> > I'm following up on the patch I recently submitted linked below.
> > https://lore.kernel.org/all/ZxEm-H-PjlQyXeOH@Emma/
> I don't understand why do you reply to this patch about other patch.
> Anyway, you got reply there.
>
Really sorry to attach the wrong link 
Please find the corret link below
https://lore.kernel.org/all/20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com/

Is there anything more left form my side for this patch as you have given the
reviewed by tag to it but still it hasn't been applied yet 


> Best regards,
> Krzysztof

Regards,
Karan.

