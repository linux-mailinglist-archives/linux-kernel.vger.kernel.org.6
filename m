Return-Path: <linux-kernel+bounces-231774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D6919DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D851F22767
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B11758F;
	Thu, 27 Jun 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9J0cCwI"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F8134BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719458623; cv=none; b=UiiQNyx1IvhNlYtqY2wSguxTbWT0g3+fyooseAfh+330KqRof72xIHTqsIBY5BkyyYRSr+Rwa/OOQO/VV12CtZCUo31IpEo6ZDE1Iz43itwwLMvMiD7Meen6BdYk/dXfXafvgUSbrLjP5HJAyu7Zco0xZwDs2pkuAteGbXvKI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719458623; c=relaxed/simple;
	bh=QikfeXobTSKxCaP4omuNIsg0yVhfL5NJ5MTEPUv7Nes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlHylctQmVw7bvGNkYl2hPNdb/O7ljroNfYFOISWqykDXQVXKMzOxpbqjJY0FpvAOMlvNbBOFjEtIXEw83fVVqOL5vyDHwuglMX+LfY9UMIXSnoqiZYnoQ1zL7ulLrdAoe/TGQhgWIGy5b1ugqA+CISkyMD6nOqd9xt4AVm1IRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9J0cCwI; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4450111d54dso113611cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719458621; x=1720063421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QikfeXobTSKxCaP4omuNIsg0yVhfL5NJ5MTEPUv7Nes=;
        b=M9J0cCwIHKhkqWrxJauWVKPRS/AQoWoWhOomSJNR1n9RZ7d0QrIwpRlIvI0BFmcGd5
         a0Ub+VjgdADxx/e3DnCl7o/AfXFe8iO9sQ3doqS1c+NM+KS0Car4nxkhesHx1omDU4gv
         1CAiKFNyk1DAZ4tNiA6lKrlaVoNL6Au4Ql4Ap8na8wyOXeP7BFm6TmTkFKdCWblQP+z3
         PIjROzAripVkd49/cIl5E9+Nf87F85v4wP1BP2b5O3S5p+0EoDj5jknZk9UxCdegfWq6
         rVhb0qo3xp+D93wnNOYV/ZrUz0gCGvR8aMdpp/fNAkBawBAmhMcQl8+Why/d7YgUxHg2
         XVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719458621; x=1720063421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QikfeXobTSKxCaP4omuNIsg0yVhfL5NJ5MTEPUv7Nes=;
        b=OS1crPMZP2/Xw1NvGROdwVcedhbxLwau46QqGMr8D9UoHZxJX8+CvwLiG2FW9RuKEP
         N2yyiNNrxK8anbNFd1a/BdzAsR5dfSUqmM8Uw/7MBiBjPy+D7AWsyNzPknwZod8SuQXY
         T76rLRgMt7PTHwMWep8LMZ4vLTvtS/wGOkHrbVj5XoKuLNNmaRe1G6BJOz225uOUJrmY
         7EaaUDm6A/6DaeQwl/pVxLs1yFy8ch7XMuX7lH7J4KRCbQbU9ssDjvrTKefLJwUi7xX8
         AsG6p5vtLqbG+5/W70N/yo7o2bujbuFoJY+uYNm04fLQp64yVaxIVmWXOW1WC3UDLdzz
         cwvA==
X-Forwarded-Encrypted: i=1; AJvYcCUqGDmLzN5zd9AY5Vp1qnRtxw9LMCSFTaTEmsRoVKyNVgSQqhOMyD9SY7BlespMKVQDdSPNb1qJm3Rs/RB2mh5e8VHOCPsCUvwhdo6K
X-Gm-Message-State: AOJu0YzVsT5cVvhGml0Rqb1jr0fVXObxSx385O8OtyqyDxyiaAAGiX6H
	6ZASFsk/2fL/4gz3Byl/Jdfhkczz6E9a59hyGDAeEAOdgXXqBtMnMM3klkEy/H1IfLDlIKq/YV7
	DfOeq2p+76gkgNLkovS9za2GlcH7RTSr1vVku4jRlYOtiHxFlEvYXBOI=
X-Google-Smtp-Source: AGHT+IEbj6A4+DDvJB4pQc3ii8OWh9rGdVOXWkqVlxAM5Xo3knFcy/93NDyEJd7xKKjg7zWlbHiZglcGVC3Hq4HPUXw=
X-Received: by 2002:a05:622a:130b:b0:441:5724:481c with SMTP id
 d75a77b69052e-4463db532a9mr2439001cf.8.1719458620655; Wed, 26 Jun 2024
 20:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626052238.1577580-1-aniketmaurya@google.com>
 <20240626052238.1577580-2-aniketmaurya@google.com> <e28ba03d1df1c0c5aec987411c40e44fc351ce0d.camel@codeconstruct.com.au>
 <c15045b4-2e5f-4fcc-b25c-76a5e4973e93@linaro.org> <b4ba5fa7834fdfb1a1e26ff0e01b9bb235de63b5.camel@codeconstruct.com.au>
 <CAMmmMt25nkZTXXLCVGv1baf3azQR0kwbM8LP4EzCQKOPLUhbVQ@mail.gmail.com>
 <d256cd72ef2011c3bfd045b04fb6509d1ac827e9.camel@codeconstruct.com.au>
 <CAMmmMt3DZWA734iFGLxz7cj+hYiWgq5MDOrc_UJpYeaij+yywg@mail.gmail.com> <ce1786dd7c0e9b892ffdeed20eb0c1c9c0808984.camel@codeconstruct.com.au>
In-Reply-To: <ce1786dd7c0e9b892ffdeed20eb0c1c9c0808984.camel@codeconstruct.com.au>
From: "Aniket ." <aniketmaurya@google.com>
Date: Thu, 27 Jun 2024 08:53:15 +0530
Message-ID: <CAMmmMt1fi4KryMPVv=YRd2WPt0RZsjyaGm4PE6WGzzAOLyEDuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add property to select IBI ops
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeremy,

> Does that mean that *all* existing implementations of this design will
> have IBI support? Changing this in the pre-existing driver will be
> asserting that.

Yeah, I checked with Synopsys. All the implementations of dw core have
basic(without payload) IBI support in master mode.

> > Shall I remove the ibi_capable property from the dw_i3c_master
> > struct?
>
> Only if you can ensure it's not going to break the driver for existing
> hardware deployments.

Since all the implementations have basic support, I believe it should be fine.
Sending a patch to fix this.

Thanks,
Aniket.

