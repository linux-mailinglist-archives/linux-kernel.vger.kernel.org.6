Return-Path: <linux-kernel+bounces-419381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F89D6D23
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99B1281554
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C51632C7;
	Sun, 24 Nov 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbZnYwRq"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A52FE33;
	Sun, 24 Nov 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732438164; cv=none; b=Xc49fwVzU+SlhmO0Q7o631nLlHhKt+H9PRo9f1yIQwTnefTy9Q7UFK3P35pT4QFkY3gCEGtl16iwqDTtaZvy62RMLgcoJaumuef4HCHb4jScj1d24mqXsk4kSxGaxrEXQKzf8/2YPmIpALzwOe1gVNGH7b5ai6zgxtVqtqBTRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732438164; c=relaxed/simple;
	bh=fM0ary42qSRrsL7AkalugbaHMb38W3ZqnrDRc0deO9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdVTmBX5aJGl00dCuhLn0cqR14LNWOf9/ZUPYQC7ngJhILMuRdGbHA6XtHK+27RWZzQ4M3aTkLOqVE9ToTNXMU7CMtsWWAsyl7nfxrxwt7F6P5rE4JZU/V42STDRLLKAP3wPiNxAziJShr1zugBxdT/b6jd/dg807NdCGer2pdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbZnYwRq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so2500454a12.2;
        Sun, 24 Nov 2024 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732438162; x=1733042962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmXw5x+IHnQ+uyZyOzsZS9Ul8CDlJvIGgeW1yGyy9es=;
        b=GbZnYwRqLf9JT/hnXkAEe55hgyXn5bwQUoFd65Jff4eDLdxbn0kQEYIZ/hw/Tdlm/r
         ehXOcpANQISKl3lM+EExzwzW+YYeWRi97iWL33x+Lh0uEXF0wscL6CsrN1rNUJrGoa2j
         NO77m60LNQx2IpHE6N9D3Wlf9jznsYXP2r9MBBXqr8HWxHnlpIXQ9d/by2Q1HAQv7Dzm
         SLYcwppDXQXWbimXlZ0HfRZqUYtriQdCSIWFhMY4+3TsXSQB/P4bbuDlXpcs2KmdYLwo
         GVmRfQYA+VtnuTHJ/0nAvLxs+8aMBxy6ySSzaJ86OMcGjNeslqRfHTryBQsoisQXMyKy
         Qkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732438162; x=1733042962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmXw5x+IHnQ+uyZyOzsZS9Ul8CDlJvIGgeW1yGyy9es=;
        b=EnNfP7knln72X4LcsMQWor+wLDEpQ2B6SboVn3tOxn/ygnCnYc4GXcoPMRACUN168j
         DAieUvagGfUT+A53M13srcQPvxikmbbnrcG0/o7y43bp2UtdW64qgSpkeL4EhajvFE74
         v/yJ3tbCOeerWdLYoXUwkpk2WBzRfrMzslvq7Gz/h0X6S5jI1pyNVhSlUl73QKHp63Fl
         Iu8Mbvuek67c2LnoRPEYzzRCWJfwAG99585HCsfW/3EE16FUaSRx9NI0iVeT+U/6Zeie
         6DwUOkjs5iQ5Y/W1mY0pvRF418GqQ86Wb7wie7H3rwErocbnsGSXYGx/yh/yUolOWTjy
         lXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC81ihDO6p4bg+Tt1NqZerslCL600IP56A6mXvc3Qoq3Mq5iYhkFkfyF6DxwKsxVqxqBVi/5GgOWfPGyya@vger.kernel.org, AJvYcCXwVRkclzWKgQrS6hpM8lsamIXyWBFHxajH5DuzU7A65psx0DFBD4no77rjORxcp97z1VK2I+PAVVjT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+woz/mxXhFtpAfiB9Le++IrB89oLkRr0cuEbZll+0cYS3dXpM
	EClJFMNjeqvNORBy3fVRiWBMaPOXnUMgYYZZEa2rnO+IQv/1LRV5
X-Gm-Gg: ASbGncs7bK5Y0SRE7jBNQ64PZI7zbpkJC9qqZG5D5ntDhGRNmVyvXSdmnfMco6DEZNP
	k4lV2e8UFNy7AsUatWuNVX1fhmCa1/zmoXyufnUTfHn5znihyzyDZdlXcTYbPpSQUHyrBrBRYbc
	x92gygaf+zL/W+8sIFimk5Aq8aGftJTebng0H3zl4WRdd3qSRrGXkUBq7GFuWxfhyXH1LN6+o65
	8eIwWdO//1kwbi0imPATFZxgkwd6be1kuOAyxT5cRoZ8/Ij
X-Google-Smtp-Source: AGHT+IEH3mMi3o2bStvSwRxcifpjaLZ8OllmWfCdTQV1ejr3K9yGIW+YcJaNskNnLTGCjTfUb7Zamw==
X-Received: by 2002:a17:90b:1bc2:b0:2ea:819e:9126 with SMTP id 98e67ed59e1d1-2eb0e867634mr10258380a91.26.1732438162379;
        Sun, 24 Nov 2024 00:49:22 -0800 (PST)
Received: from Emma ([2401:4900:1c21:cadf:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d048e94sm4460641a91.40.2024.11.24.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:49:21 -0800 (PST)
Date: Sun, 24 Nov 2024 08:49:14 +0000
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
Message-ID: <qb5sdh55yj7est52netydaauazgluej6hvvtutmmiw2bhglnpw@lq2cyg3hjhlw>
References: <20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com>
 <bdze3425qwrtlvlairw2b4xiycpkmhirzhqn2jt6jngc3bu4ta@uo4nc2lnj4sf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdze3425qwrtlvlairw2b4xiycpkmhirzhqn2jt6jngc3bu4ta@uo4nc2lnj4sf>

On Tue, Oct 29, 2024 at 08:10:23AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Oct 28, 2024 at 04:44:12PM +0000, Karan Sanghavi wrote:
> > Convert the raspberrypi,bcm2835-power binding to Dt schema
> > 
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---
> > Changes in v4:
> > - Corrected misindentations and random differences.
> > - Link to v3: https://lore.kernel.org/r/20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> <form letter>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
> 
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> </form letter>
> 
> Best regards,
> Krzysztof
>

Dear Krzysztof,

I hope this email finds you well. 
I'm following up on the patch I recently submitted linked below.
https://lore.kernel.org/all/ZxEm-H-PjlQyXeOH@Emma/
I noticed it hasn't been applied yet, and I wanted to see if there was 
anything else needed from my end. 
Please let me know if any further information or modifications are required.  
I appreciate your time and feedback.  

Thank you! 

Sincerely,
Karan.

