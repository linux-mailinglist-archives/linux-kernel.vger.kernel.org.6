Return-Path: <linux-kernel+bounces-264221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396F93E055
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3502E1C20CAC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D26186E47;
	Sat, 27 Jul 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKeo8DjC"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA71B86E0;
	Sat, 27 Jul 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722101170; cv=none; b=BfQ2TL3IvZOWmsluJcnVbqnTO+heO9VpCPG/o1qEfnHKL8cfxY5oIRZL2POwlciA7+hR9VcnuKiXdbkc7KpLCE1gD3kdtwsLF+ieUD3pzM/zpbQeCwQOBQxPtT8ESHPdsOi9zW2IoU1QXQk0LY24/bgOj9C8GZm9xFOTNUzxA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722101170; c=relaxed/simple;
	bh=9oAufN8joVb0E8rKmzeoqRUEaltCXxDgkoiJeB/YjV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0eawToo/3UfrSVjLHQPLDuLmLPRiktNRazOaaOE2ZCqpo4ed4HgEHkpSzMntfMz4ICWZOeYxCOikWVKXYCIycJ0jneucUI/vDt7GSflW1cMLyEoexmY59Cj75nKLj/abLVDb3MXkTR1fwg7il/HgFbjxhTE6d4DK5bc0UGJuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKeo8DjC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fe58fcf29so8612881cf.2;
        Sat, 27 Jul 2024 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722101168; x=1722705968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mXEidSCbTxCEMvjRmFfWopU+ZWCaSmREcQ6uNlzUY8=;
        b=KKeo8DjC2mbS0FqyhSwAQu5ZaM/EfxDaNRlP3/xbNChOSiw/HOsW1ONPDGqLjCVNrx
         yi96ymPmlCQMXTY7r6/Mc1p82ok1LLWvvztaG6/B6UnVnRg71+Bo4PgsE+L8+MdN/hwZ
         OnjSZC+Xv8aIFIzIG5Bq3R4McxQcaNc4rFyx+M1+0b0BsLl8Ppqc7U7YwNWPg6+LRHGa
         AziVJbBxsr2v0U66ATZ6EVGTO/WbDie5u9rVsvDOSu87Zz+whxfC4DV3oBhTqbvjjdrg
         hMRBbOyLHj4sN9shCR6X08zetgrhePXGgfNMUa6ASQsFnQzGMIlAmWW1kt/2toAtU3sc
         fKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722101168; x=1722705968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mXEidSCbTxCEMvjRmFfWopU+ZWCaSmREcQ6uNlzUY8=;
        b=dmRQ6kWHv5nIbXLKsj7jZhwJzW7XKwWmgxTkNv6QPgS+Lq1OauDfyQGrdg8fe/ldT3
         s6xyVu8gisC6j0gRNsWFVIhE/3J0q2o5v+j4zvzU7BDfLM8UqVVYUVCtOl6C32dMQrAJ
         WNSdgnMV2ZHgcFZqcW1U4o1kC+FTv4alqJmV3rX6YB1t1/1XiysVssgBDs94B/FoFTEG
         8kgX6fSwMISPQ3fOEXEDRkuRUrvwnbeXwQpvCVoqii9hIEf2m8OCDYFItpxO+JCBnUzd
         VtDvYonKJNwj6rH/jrroah8PhFluijIfRzOkeS+DELQkmYH1O3pcNPH+RJMvA5r1F/nJ
         Y96w==
X-Forwarded-Encrypted: i=1; AJvYcCXt1opj/XqM3/0tOA2ioCDInChKPumWKr6LnWXwB+w2eHln7yF9BMPa1+hXmsDDB7oYWqzJcbP5/1HrkFrM217omfjSzcUu15WdtoG300terTcV8wM9qmaS9naSN04cZv7fpNTE5WWUTQ==
X-Gm-Message-State: AOJu0YwctultnPwmzsrQSCNvWfxtcCQhHchNellK8nQl69Yfjuv0Ev2b
	oIIImz2E2dPZ2vnNbe/9MGxMSiiUl1EF4uUvmwFxe7S5KsZS7uYv
X-Google-Smtp-Source: AGHT+IHZmTWCYaCpj+GEFbm8JxA2Vfn8GpH4Olgk26FftL3v9YKmgGnC9zttm9v5+DghGzE9vJ1fwA==
X-Received: by 2002:a05:622a:447:b0:447:d867:2aa7 with SMTP id d75a77b69052e-45004f3dba3mr38418051cf.46.1722101168180;
        Sat, 27 Jul 2024 10:26:08 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8123516sm25656831cf.1.2024.07.27.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 10:26:07 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:26:05 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, christophe.jaillet@wanadoo.fr, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add driver for Sharp Memory LCD
Message-ID: <crnz3y3y3m4yjrovjamtlftmztmqejqx6s2jg33guhkt2slnvl@45cfsfia3pyi>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-1-lanzano.alex@gmail.com>
 <a814e348-9837-4cfa-a500-72f47b47c9b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a814e348-9837-4cfa-a500-72f47b47c9b7@kernel.org>

On Sat, Jul 27, 2024 at 11:00:08AM GMT, Krzysztof Kozlowski wrote:
> On 26/07/2024 21:44, Alex Lanzano wrote:
> > This patch series add support for the monochrome Sharp Memory LCD
> > panels. This series is based off of the work done by Mehdi Djait.
> > 
> > References:
> > https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
> > https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.
> 
> Best regards,
> Krzysztof
> 

Will do! Sorry about that

Best regards,
Alex

