Return-Path: <linux-kernel+bounces-444668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDE19F0AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906D1169DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F41C3C05;
	Fri, 13 Dec 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ/5j9q+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896944C6C;
	Fri, 13 Dec 2024 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088627; cv=none; b=pNX7G3qDkCPBlZZ906XCQx5WohguApg3hMd1j3rqWfK0rGjgkVAFdu5s/F+OtLaVFETMlhUxwZtsqzBF2I8ipPFEURmQeOZBLBThO9EhmNHoq+CPCt45/U/0bBDlwqaNd+rtTtWqTjBhARpyCrg1jJgGfNUFAkFbMxyQC6aZ28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088627; c=relaxed/simple;
	bh=JEx/qZ4zixKgNWa79zI1uqk1bWFi+4d3tFuS0XiPPy0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoN/+9X73tVzb/sNHnHd2rRyJiMWgoyFKHgdNaSCdc+7ooDvWu2wI/DYxm1SleYaXlArgJYmRa3Cj0hD0e5WM99KpMZRmkaGmcqfyPFmisiCYPIumiriXwjqmcEiFzWzWiKsI1tloXno61Je48xmREefihhYfXeUh4R9aCR5qYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ/5j9q+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso17063465e9.2;
        Fri, 13 Dec 2024 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734088624; x=1734693424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/cEY5Wv2VLzOhiYjn7VDO3P/7ASYT1bpc5HwHfTn/pA=;
        b=CQ/5j9q+cm0pH1Yo0qUoWW0jv79yIJm3dvOFp9ofH3FDraFr84z2C8W2WFrNjdT5SL
         3Ao7Wl8owqKEJNAxqES8aFQCt9nJPivTrSk8Wc0F3cd9PovFj+DlgRxY4NifSrGJjgtJ
         rfXKyL1gCgAaYk4kXggBEov12qcNzQWEldjZPiVDYgF0tDWD3GIvJwIeVmRYhL9YWkx2
         4kR1B4SPms1jcSXSUfX9T01rwec5Nn6zQ2KuHN7g20lovqFwBaUFXyQLEeupbXqvGwUl
         /2bBED10Q+WCrxmzts0nKydTJXlIztFYO40ZJtbZeMTdQPj10Eji34PvTEZHEbYcGQeT
         7p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088624; x=1734693424;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cEY5Wv2VLzOhiYjn7VDO3P/7ASYT1bpc5HwHfTn/pA=;
        b=H4xnBKA6HS1zQkJVARLjy9h/cGpNTW3ZnSL+bPCtlCQMKlkxDFSdVBREDRkQANQYl/
         yN/QNLfQcAFnQksW8mh1aV8dQRVOyRUYRq5zJIopaXqtprRjQWGq/xSqXe1F/0zrvSLU
         eZmtFyu2IhKijszh+Da8ScJTLXzPl66ULzYSYaIEkWDUYTapMj07AZnh5CbPcpPhkTg1
         N/R+dYMd4crCjkxcpPr+ngGIfnTKawqVP/z5dnc1j41mSwXz1YBI4tWCy/BuUaAtzybF
         XQKSx+ttuc0aZNOdwgZUy1pLeEzWQEuRjaKZ/EIHRjNHudiSbHS/21v5jg0O7Q7JpaVE
         4zRg==
X-Forwarded-Encrypted: i=1; AJvYcCVn0/NhLT3EngqVMvlu0bWahLru/6bk03CZUAzUAtfLLmU5W4xH9hYvgMZzgspOtTE3h6A8Ys29qqR0@vger.kernel.org, AJvYcCWEvPrSlUh3u399nLroC6zJtPBiaBXiz+Fqnupf8I0cnd+o8EmgteGltVCoSRD5V3VFmmyY0VTXikYO@vger.kernel.org, AJvYcCXdRAvGZwIpW5p+KcqucXRh9W2XUXLP5ijDPVjzpxuAtNprTJJG5mDjlLlxwwXBBwOn65h7m45Ek7d/cN0L@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8dgy/eMERf44j88kgCiJl2dLQhaLUmQOWFvE7Wnpb425skZb
	tebUEy0vZoiUeH4QW/1auT4FfI+ZY/CqpIEp1O/qaySRL/1BuLMT5bbpiQ==
X-Gm-Gg: ASbGncvR+LQjuV53pWCL0hIdH0ylGC7f6au8KN7j/L5hBXy6VZIHZ+s8zVZXVW3qIOo
	BaSw10zCAnRF2d4PtmshiwrwHBs9AGQzHhgYMnta4x8Gi4D+csnqpKGAMHAccV44FO8JTdBH8Kr
	h9LiEo6VxhRKoGm8biweSDi9xAR/zt4Ni7hAdD5ZxaCDvPBG3xHiSlHeVLdpADvmxorC/RGvcqt
	Ae7G7/ij+m1EFER4liEvXWTCgj18abjiVEgBOOYomabVgIY8uit290pe0XBuqOIx5UbsoLG0DnJ
	BeiNTOjkCd1J
X-Google-Smtp-Source: AGHT+IHhsHWy3PdvZo5ZPuzpgQ9ziiyM9Xp0QpEzv7d1NqYqUJosuh8WE5XAOjHAW3GEMEPhfUUMWA==
X-Received: by 2002:a05:600c:1c07:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-4362aa27ee6mr18031455e9.13.1734088623538;
        Fri, 13 Dec 2024 03:17:03 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514bf9sm6929690f8f.80.2024.12.13.03.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:17:03 -0800 (PST)
Message-ID: <675c17af.df0a0220.1ed8f5.5215@mx.google.com>
X-Google-Original-Message-ID: <Z1wXq2W4agQ-Qinn@Ansuel-XPS.>
Date: Fri, 13 Dec 2024 12:16:59 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH 1/2] dt-bindings: clock: add ID for eMMC for EN7581
References: <20241211112253.27905-1-ansuelsmth@gmail.com>
 <bzdhbuxr6zyln2ecxnamfzlblcigdfe7r4vvwcggf35kgyozk6@it2sm6fpypa5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bzdhbuxr6zyln2ecxnamfzlblcigdfe7r4vvwcggf35kgyozk6@it2sm6fpypa5>

On Fri, Dec 13, 2024 at 12:01:40PM +0100, Krzysztof Kozlowski wrote:
> On Wed, Dec 11, 2024 at 12:22:37PM +0100, Christian Marangi wrote:
> > Add ID for eMMC for EN7581. This is to control clock selection of eMMC
> > between 200MHz and 150MHz.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  include/dt-bindings/clock/en7523-clk.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/dt-bindings/clock/en7523-clk.h b/include/dt-bindings/clock/en7523-clk.h
> > index 717d23a5e5ae..78d16068228a 100644
> > --- a/include/dt-bindings/clock/en7523-clk.h
> > +++ b/include/dt-bindings/clock/en7523-clk.h
> > @@ -11,7 +11,8 @@
> >  #define EN7523_CLK_NPU		5
> >  #define EN7523_CLK_CRYPTO	6
> >  #define EN7523_CLK_PCIE		7
> > +#define EN7581_CLK_EMMC		8
> >  
> > -#define EN7523_NUM_CLOCKS	8
> > +#define EN7523_NUM_CLOCKS	9
> 
> This cannot change.
> 
> If this changes, then it is not a binding and first drop it in separate
> patch.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

maybe I can introduce EN7581_NUM_CLOCKS with the correct number? Just to
give more info about this... It's not clear to me why NUM_CLOCKS is
needed considering is only needed in clk-en7523.c to probe the driver
and allock memory...

Anyway is a different define OK for you?

-- 
	Ansuel

