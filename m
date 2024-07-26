Return-Path: <linux-kernel+bounces-262745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C293CC20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7E41C215C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C6ED8;
	Fri, 26 Jul 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aggawm64"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A9EC5;
	Fri, 26 Jul 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954179; cv=none; b=YSOvXlNHAbhTvopryeY+Iz3jldWAr4QTJQ45c4NhZjg7ils+wS/aIPuyPlxrmY+2ox4EKnx9IEs5FJ/qsYHEx8RS75CXiKhCH3GpqfnGEErlLJ0WO9tPrVuQZtEP6IH+anGrMC0h+nl7B+BJ2By10ZvYllp0ADgWto0Y85yCwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954179; c=relaxed/simple;
	bh=2zMmEK4lOrUvH2hzmY7OyrrgkhihTpSrCOi+f7buVfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7n4wOX92zeaJytf8dEZD1ZTYDZcvOMiiqHDOm3l2EWSuSMKTqrSgIv92uA1xQIhgLDOugreuaj4qjTN/nNN/UvCOP5LA/jmTWZdcApO6Lupc/blkHAoEBQuVg6scfxMVbl38IHBnAB7jhmg5oxnzFsOOLfCGG/CPm7GRgxN1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aggawm64; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dea79e1aso7418685a.1;
        Thu, 25 Jul 2024 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721954176; x=1722558976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L291mgIc5iI7OK8XleK9YhT1xWPCs2ak74jgRyXyYfQ=;
        b=aggawm64CHpfbWjvgc5sILiOj959zpCccbgCZSy6hDVn21N8euu07eja7VGRYGFto2
         uwkpVNmv4/0WK4/2jbcAEutvvcAnpT6p8GZh9kyLZso+PAlKvojPtzDXdFmNVcXJmGyn
         8AqYPgTn84YaQpS03A6imP9tOzfnVvg8QlQu/GKSxjw7XOQZDOd5kUeim4oygts+QL7h
         VZqQOq7RhduYBI51SYmrMBakh06Ix6tKOJ2A2MWlWQIoCfKantqSGF26qGA/fTDXBTVA
         JZLz0oGR4A+ZKfegkJr2Px9OgLys21IJqPU0wtoNy0OYJKiAsjfoQ1ubJv7ULt8pJiXY
         VRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721954176; x=1722558976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L291mgIc5iI7OK8XleK9YhT1xWPCs2ak74jgRyXyYfQ=;
        b=ZH6/RaGFoMUmTGbGT1uju7nNrsd7AvM8QP2BlXY+3yj+SKDH+F6wGAkFHQiRWOV/c6
         3GqWrM4lLW7Jyeu4JRwHduVx+wBm9xqImPMvy9AyvoPCXzavlouzf5M7ceYVo0VfgZfX
         qeLI/v54Pm2XgWbNRp3aphPOXhcZyfRmJwsup4YV3peIl3pVhXJCQHIp/3GXCRSOeQia
         Kl5vToaIP2K3TbxxZ7dTKm9aPr2ir/BLw9k3boXqA9uHjCEtbGFzz6pjtHZiU10XHde+
         ju45uMIgOEEFxXs06npysOoZdcRgqcojxd6KTkch8jl9rOvKaX3IWqm+ibDroKep1q2n
         x+tA==
X-Forwarded-Encrypted: i=1; AJvYcCV0jIgnXBd3cqGu97/ZfPC5oKwAGKMIB4a7wEWJ2xorzszY3vFCcI4ngtX0blaEU6G0VJ5mNWwy3TDiRgq9NB4WxwCIHFfltvzb44kska+hl+R/FPWm8vx1IPvAsVm3k6iFT6Yiel7/nw==
X-Gm-Message-State: AOJu0YwFrQB2+FcDS/eRcBOJLOJMbaPzKBoWLw2kIN4U4Qrq9H1MQdKf
	eUVGJIInsU3ICsJdkUNMwHgz+0CEM+a7tZ5SiFTa9Hf5+LgycmYT
X-Google-Smtp-Source: AGHT+IFL80A/AmlvrAcmTqfRsjx33wSR9irZJm5WasknKgEYW/EaDmsMs7vzmUn3r8rpCSLBNxu7Lg==
X-Received: by 2002:a05:620a:d93:b0:79d:6276:927a with SMTP id af79cd13be357-7a1d44b593emr607077085a.22.1721954176418;
        Thu, 25 Jul 2024 17:36:16 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7444d42sm129040985a.99.2024.07.25.17.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 17:36:15 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:36:13 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Message-ID: <li2dwzrd7oqjc4rmkrimicmbkzh46grpt2pwjbidsksm4xbtx7@ifc3ir4ineo5>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-2-lanzano.alex@gmail.com>
 <b358e743-d264-4c18-95a3-393b9d20a87c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b358e743-d264-4c18-95a3-393b9d20a87c@kernel.org>

On Thu, Jul 25, 2024 at 08:18:44AM GMT, Krzysztof Kozlowski wrote:
> On 25/07/2024 02:47, Alex Lanzano wrote:
> > Add device tree bindings for the monochrome Sharp Memory LCD
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > ---
> >  .../bindings/display/sharp,sharp-memory.yaml  | 97 +++++++++++++++++++
> >  include/dt-bindings/display/sharp-memory.h    |  9 ++
> >  2 files changed, 106 insertions(+)
> 
> BTW, look at your original binding:
> https://lore.kernel.org/dri-devel/2a7c51b6e619c02ec175a5c219b0a0fd7a24499d.1701267411.git.mehdi.djait@bootlin.com/
> 
> Why did you decide to introduce mistakes? Eg. dropping all $refs?
> 
> And finally look at the comment:
> https://lore.kernel.org/dri-devel/5dbdf7bd-cfa3-492b-a0a3-fdc323cf11f8@linaro.org/
> You just ignored it completely....
> 
> Best regards,
> Krzysztof
> 

Will fix in V2.

Best regards,
Alex

