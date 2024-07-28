Return-Path: <linux-kernel+bounces-264592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8B93E5BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0B8281A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BEC51C3E;
	Sun, 28 Jul 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd+GHCdA"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA941C6D;
	Sun, 28 Jul 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722178357; cv=none; b=E5w9cen2ws4NXvQKQcSxuzcfqZ6The8O6ZIEKdzxz1HMpmy2f/PwnbqG8mYisBD/KXvYNgCXKrzz/xyw1UWcpBbQDcPPHD+rZuyqus4bE2OJuSPyWYf9wpfbhDPwmvzxgZ/OIbU50+ajq50b5isrl6IFfMBc7WfPLk0rAbpKoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722178357; c=relaxed/simple;
	bh=Rt9jwuV8+MnRh6A5l08O86ie2CpxOU4vyieDUvpyhnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAa2KDpbhuKekX1rZVHHv8FMPtEd+ujS3L12FMP20X3g1KnPijeRyaY4AXvF8gul3DpXMprJW0arEiBkX25oNW++5iFd4QmyawxNW3GcbyfKuJgJDmfQ7h5xxm36I3TXUvmXK276W/zW9Wwt1nJXll4JOO7hKwAU+lidHS06taw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd+GHCdA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fea2d40adso15982391cf.0;
        Sun, 28 Jul 2024 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722178355; x=1722783155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZp6ohF7fMnFuP0g+iZlmuP4ACp+YqqKbSTvRemgoPQ=;
        b=Wd+GHCdAYw+XI/gflLIBT67ly5HVzbknVqERpgj/z5dN83v7QMKwmW90afABVuaVl7
         0yPconkBts8x7hVOIp6BZS1mYGFHA5G82+Tb0NusVsM0GxuPXtfqFlnQzpPRcRzoaqJh
         qSUaKJ6Vqy4J1qD5KLO9KLSZwhyjtXtiDYUpu/X3O0gkoiIuG0UOShSZ4grZMNryVevy
         NQeuoPtuYiGyvbOVOT6U6FJi9ubDl4H55oOwAt8d96Zg41VFjHxe1/QOA3ffE4bOI1fa
         7tJCK67hdlw7W7ywzMsRnODFjvh2ODZApMcr+pAMEW6JpIYEekP/tPZK2w+SnkC2QX6U
         N3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722178355; x=1722783155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZp6ohF7fMnFuP0g+iZlmuP4ACp+YqqKbSTvRemgoPQ=;
        b=LUFgt1yZcU7PdpGM5OH2WQa13IfW8Au74fcC5R96M/r2x+JQcBsuC+wz5FrmM51UHn
         eXYibI5zPyaUfcp/E984/SCYwkD8mwypXs8Pe2dNFzw5YNlae0ayuZnyoStm+NAGB4o4
         hBjuNgl8DvH5tfwscqOcqTr/ZpM7KhEs0LbKPsZ5k4/SlVQ1oMXY3fZIMa/qm6JqVbza
         HV7Tv7tSVGLX5uJwwZaj0NzIoA9bHN/YxhmHrc2XnUPyKZ7i8Rkm/MG1/Zwto/ZZxWsf
         ok/FVCeykgzCDbWbg1e6n8uthtLCGkP95Ry78k5TPebTkl2E/WvKwDwVAovSaS5qUlQ8
         ldjg==
X-Forwarded-Encrypted: i=1; AJvYcCUkeLhv9o0JJaD56OraHEMvQtMluzSiDA1hnmFtFZOoGhxL5MEZhmokK194vnVFBhd1xFgN7Rv3D3WUxPDeBkpDdGTTJxZUUEJdBOm97AR9vrMiJzbcO1wUMSesZjzlb5kzzRlUE1GiWw==
X-Gm-Message-State: AOJu0YyBu5gvyYsS4lKU5OKzlSeUugRlBV6A5lNPnv91UpnilL6Dtrck
	96PO9knPonCBx871YZdGJh+FX9cz/3fs/fVgQkpjRnFwHQVV7lou
X-Google-Smtp-Source: AGHT+IGDB+ttYPFx4TQUrCgIQJWbbDjmtLOnZcLk00fPOQgxgWq12138PSalkJM2nTycdUiZK23bLQ==
X-Received: by 2002:a05:622a:1791:b0:44f:fde6:7fad with SMTP id d75a77b69052e-45004f2a79fmr85331251cf.43.1722178355232;
        Sun, 28 Jul 2024 07:52:35 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8200640sm35289981cf.71.2024.07.28.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 07:52:34 -0700 (PDT)
Date: Sun, 28 Jul 2024 10:52:31 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Message-ID: <3wgrdnpwmss3lpevxmf574pqt4rwttdwadsm6tqaobouw3akor@v6z76j5yzdmu>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-2-lanzano.alex@gmail.com>
 <c7bf08aa-e7a0-4b60-b9fe-b43215ce3fb9@kernel.org>
 <7zpp4ebzj5xk3wbbpt7l5xnhqg3i52mdjhn3grmn562mres4k5@a3g2xxftk2td>
 <2d28134f-63d0-498c-8539-1cf2d0f1d68d@kernel.org>
 <ko6kavj46gm5py3vtfnt6zdka5ar2zigmpg72kt4zr6f3tbhwr@nbbhn726oo36>
 <8edc9bd6-2130-44aa-aeaf-cfb5ca43ca0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edc9bd6-2130-44aa-aeaf-cfb5ca43ca0f@kernel.org>

On Sun, Jul 28, 2024 at 04:43:42PM GMT, Krzysztof Kozlowski wrote:
> On 28/07/2024 14:56, Alex Lanzano wrote:
> >>>>> +
> >>>>> +  spi-cs-high: true
> >>>>
> >>>> You can drop it.
> >>>>
> >>>
> >>> This is a required property in order for the display to function correctly.
> >>> But I have no issues removing it if there's a better place to document it.
> >>
> >> The sharp LCD device or the board (e.g. via some inversion)?
> >>
> > 
> > The sharp LCD device itself.
> > 
> > https://cdn.sparkfun.com/assets/d/e/8/9/7/LS013B7DH03_datasheet.pdf
> > Page 16 of the PDF below shows the timing chart for it if interested
> 
> OK, so you enforce chip select as always high and then someone comes
> with a board which has a inversion and expect the SoC to drive it low,
> as usually? In such system this would not work, would it?
> 
> IOW, I think this is the first case where you require specific CS high
> and this should make you think why...

Ahh I see what you mean! I'll remove it.

Best regard,
Alex

