Return-Path: <linux-kernel+bounces-264570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB093E531
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A91C20EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173243AAB;
	Sun, 28 Jul 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGm3WMWR"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FF374CC;
	Sun, 28 Jul 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722171418; cv=none; b=T40SO4VHeSk2c2g/tVVk52wVfRyiyBxkN0RFvgSdRadqomDcWwo5ZQXupMbAt6wbbEotb2QTdNWbqY6KOSdoHVr356MIleiN/9Muq/THHaj06DjCEk2Qh/7u8olis3U1zAcRp7L4jcsQHfRbkbpxsctjiwR2Yp4LQP9Re61ISlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722171418; c=relaxed/simple;
	bh=L94x+L+vKExg7VhlBjw2ui0CT+T7cm/w9eVgnbGIE9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYnSep9ndbRRjTsOgS31fPb2z4f/l9Qq14If1qd6YGjnW+fNoQ7tX7V4M1U8bSzW0emlWhPwImfNx8Srx2hSTxk5bfq+2Qa6pirtO1yH8JeoWEbJ0bdT3UC15/wAhU723+r0zXX+RYEjLUkmgZI+lxHRKSoRfq7ErkVoH9pmnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGm3WMWR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d42da3baso177085685a.1;
        Sun, 28 Jul 2024 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722171416; x=1722776216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTH+8E+6pDbaWYcbWv4zZJ4e3sHzdZrbTaO6H4PvA5I=;
        b=fGm3WMWRSfqPpIEpapXQ9CsxRCC2ptigcqNRaj/YLc+xxGWEzTgXLkHuYb910YMzhO
         iwQRQaaJ69eu0dN35b7/U88TsNVX5WJQh2qRcC+GLW0vXAIknuTqDAkruvYcSRlXosxk
         a7HhebOzvytexnkJSPSgQKuPvS3z6e/GWKN+osWrHfcbYAbRmvJmUN8c0nrRTL5RXar+
         pw+l/xJi8u6sCgsZr5rdQ79jG7rXiO9ZmQOYHfgxkVTQ1ZTh4Y0I1hHdlhnQy0QpFaM2
         HJ4GrkfTrUz8v8NNL5dg0W4+unmo5/nqv04Xf44uEXVZp5JHPGP0mh5yFyf40OTnBtBX
         b0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722171416; x=1722776216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTH+8E+6pDbaWYcbWv4zZJ4e3sHzdZrbTaO6H4PvA5I=;
        b=ji4vsy7sR2rfjf8eGRH2abhayeV7/KxmpwDQaXkTN0sejLdIZ7f0wV8bqYMTupz25a
         lpIsVOxgAZWISArN73cEyJawYm4d9VQ2sPi2aHTx+kzzZv+UeMHaF2lS5MmjsGn1qzJi
         A3ByIXEbrVsA6YqJ7IdIojGtly8+tHC+8DP2zxOvuMYF0gz+y/M/irK1VRG0xU+oYVT+
         RHpTIZzGl4S/6wdGnFBHbznymXu6h6+cXv8yskUkR7L7AnH52fuGzl+ykgu3y9WRPbPQ
         2TSJJSWa837BRQ47UDn6i1BxT5pzAXdC8Zc++WOrEu1/1YwYzu/O+b0TERFnyoA9n6cc
         0Bqg==
X-Forwarded-Encrypted: i=1; AJvYcCVqswC2N+09OFGv2EF7sS14jG9rlhxweZGLRcuHuIDm4g20UakyBnIYkpf+CLX8+LfYrka+NkwR2+FEzERZRwyrLLPYbSVDsmJhBHeC/maPUDyIMG2EfUnNHGtAvUnhl8ozZgmXLIx8OQ==
X-Gm-Message-State: AOJu0YwhG79VRr5VNiIdUoeIDC0X33ofsgWV1Kctzf3zc2TxH9MVjTQB
	5RkJO7HFG+rhbVoJwy0hlbW3NsPnfpbj9fDOqsWxAg7546ZVL8Ac
X-Google-Smtp-Source: AGHT+IGhbIGqc1OmhHlXFQ666LqZ0bP89hCnXiP2i+2pSwxBoUqfb6pq6hrjBqghA+dtI3IfFPHCkg==
X-Received: by 2002:ad4:5c4d:0:b0:6b0:6d7c:da02 with SMTP id 6a1803df08f44-6bb5597d645mr74331016d6.11.1722171416138;
        Sun, 28 Jul 2024 05:56:56 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fab9974sm42470086d6.108.2024.07.28.05.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 05:56:55 -0700 (PDT)
Date: Sun, 28 Jul 2024 08:56:52 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Message-ID: <ko6kavj46gm5py3vtfnt6zdka5ar2zigmpg72kt4zr6f3tbhwr@nbbhn726oo36>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-2-lanzano.alex@gmail.com>
 <c7bf08aa-e7a0-4b60-b9fe-b43215ce3fb9@kernel.org>
 <7zpp4ebzj5xk3wbbpt7l5xnhqg3i52mdjhn3grmn562mres4k5@a3g2xxftk2td>
 <2d28134f-63d0-498c-8539-1cf2d0f1d68d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d28134f-63d0-498c-8539-1cf2d0f1d68d@kernel.org>

On Sun, Jul 28, 2024 at 10:40:23AM GMT, Krzysztof Kozlowski wrote:
> On 27/07/2024 18:30, Alex Lanzano wrote:
> > On Thu, Jul 25, 2024 at 08:17:01AM GMT, Krzysztof Kozlowski wrote:
> >> On 25/07/2024 02:47, Alex Lanzano wrote:
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - sharp,ls010b7dh04
> >>> +      - sharp,ls011b7dh03
> >>> +      - sharp,ls012b7dd01
> >>> +      - sharp,ls013b7dh03
> >>> +      - sharp,ls013b7dh05
> >>> +      - sharp,ls018b7dh02
> >>> +      - sharp,ls027b7dh01
> >>> +      - sharp,ls027b7dh01a
> >>> +      - sharp,ls032b7dd02
> >>> +      - sharp,ls044q7dh01
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  spi-cs-high: true
> >>
> >> You can drop it.
> >>
> > 
> > This is a required property in order for the display to function correctly.
> > But I have no issues removing it if there's a better place to document it.
> 
> The sharp LCD device or the board (e.g. via some inversion)?
> 

The sharp LCD device itself.

https://cdn.sparkfun.com/assets/d/e/8/9/7/LS013B7DH03_datasheet.pdf
Page 16 of the PDF below shows the timing chart for it if interested

