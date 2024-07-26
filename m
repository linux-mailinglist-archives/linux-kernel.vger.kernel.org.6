Return-Path: <linux-kernel+bounces-262734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A793CBD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455721C21350
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FAA7F8;
	Fri, 26 Jul 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm7tSlGs"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79E36D;
	Fri, 26 Jul 2024 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952427; cv=none; b=Q0F1KfuZQBHwAICUgEEGvmoWoJg/AMBHk/rxvGIaQvEs5Vm0R80kmXlDIZTEnG4NVVp/eRCCkWvD4GRCdzyh4M6gm0F1bIJ6Z/WuYwaSZnUswcOqPryzhSy3E4mIvIuKsCjHUEQSzJUVdTCUwbmbn19GZdFPmHoS7yUEgmL/g00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952427; c=relaxed/simple;
	bh=8MdBcCjwOySNAbYQaTV2PkTHCb+RNP4SwIA5eHRLoM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvamVq78kB2vSpCVPcaG9LvxwsF76gMmCiIZ2U2RarMXlWsw+LsCEaEA9M53xM1o0UKpqa6PmHeRm3lAAaOEcIY2IwMQiiBO8Xhhw5xJzZbBbnDZY45TSZJMWaIL4IT+7WmX6ZxqMilkIm7Ua4n6Hm5CRnOGCfwrWIYe49Fxgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm7tSlGs; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b97097f7fdso824186d6.0;
        Thu, 25 Jul 2024 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721952425; x=1722557225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mhrx66p4k+0HqBnVFIS3fmt62myrp/Me7feWqvjhdI=;
        b=Nm7tSlGsI6na/kv4xv6g93m/PYV6IXfK99WC3VRGNeyAr+zTN0YhsDrBUIlvIJZ4ZI
         cTqH6PY/jx3KcvMadWxiXPJdXsYvmjujrKsHWnJUenekEQSx78YwjTpNQCeGVscOW/Cn
         ZgW8zTFoAK6hX7wS7My/lICyTz3vn0ehnEbxBcx75OL6qQMhNWFyQxPqRWLIhQry7yOY
         iTQ6mIG5+Y7BoWNNG2H+WnNWxkqQojMEQ099jgrHj+wR/FwqFLm1DqGAlUQCmfmr3lub
         sNpv90xON2zXgUrtSQ1OnS10hiJWrJRVTxQppDZNvcLpfd8W46jDUnFn0YL5RGxL3R5G
         yeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721952425; x=1722557225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mhrx66p4k+0HqBnVFIS3fmt62myrp/Me7feWqvjhdI=;
        b=ZE0EBSjBOeECHJswiN+wWU9OQTlEfSaViKL72eKBUqV6s+Cx4h6Xrzcq3fjgFanh2O
         XIfghyEwzJOQNs6J/7gDzseIfY68RA3NQ8kBP1LE/+a1C8IXDT+ajwINDfZUXRvtQGGt
         qsXZhXKqyhxUOvoxmH8h2QQ10zVNvGGCwOfs9GumHvy+N4mJGY3b+jbLEiywecUDdF20
         bPkb93sQPRFBsZhcQ+sI4UETNGXyoFG7LU3opzTo3wfMLikoKaUbZNTUnBTGxk9VXyOW
         tHX5hJ2uGQMbXRu/hYEi1m1bQV8BnEnKbxayTnqZaAykshXssocAIgdA9uNSX1vDi06I
         xtaA==
X-Forwarded-Encrypted: i=1; AJvYcCVbacX4CQbkID07CkQYkIBDBFjezORyjMIvei/GXuD+C6ZXN0hd2KYLOzPWVej9Uj0a7MV74u/LwIrb4Nsz46faWB1L6+efqhS8Xlrd1IZH9Q4iqVG18KtowaTp0Gy/1szArqw2jHbMKw==
X-Gm-Message-State: AOJu0Yzw7/4B7gqKhOEkQz/dBMOP4wZxTPqBeqomLmNQ+lDH6s5qv41Q
	piryA27WSz13QW8Vvt63/mzx0AJ8AIGyEBsfD/S4I8gypQ71GxOloEs7xv6W
X-Google-Smtp-Source: AGHT+IGGfUcDRIS2ADeLCH+O/5hJ5jOciW87T8ynnw+FeWzNqY38U4MpJcRIw508BOtTHDbLgyKoBA==
X-Received: by 2002:a05:6214:da3:b0:6b7:a6eb:c343 with SMTP id 6a1803df08f44-6bb4087082dmr46978076d6.51.1721952425017;
        Thu, 25 Jul 2024 17:07:05 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fab9639sm11506416d6.103.2024.07.25.17.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 17:07:04 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:07:01 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: mehdi.djait@bootlin.com, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: Re: [PATCH 0/2] Add driver for Sharp Memory LCD
Message-ID: <vlhicmhpvqkvdbyq2dsgqmofst5a5rjztr3uhp3bwyjhv3kqog@lu5lqtey262n>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725074532.65616a26@windsurf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725074532.65616a26@windsurf>

On Thu, Jul 25, 2024 at 07:45:32AM GMT, Thomas Petazzoni wrote:
> Hello Alex,
> 
> On Wed, 24 Jul 2024 20:47:01 -0400
> Alex Lanzano <lanzano.alex@gmail.com> wrote:
> 
> > This patch series add support for the monochrome Sharp Memory LCD
> > panels. This series is based off of the work done by Mehdi Djait.
> 
> Thanks for resuming the effort on this patch series! Since this patch
> series is clearly heavily based on Mehdi's work, wouldn't it make sense
> to preserve Mehdi's authorship for the patches?

Hi! Thanks for the review. 

What would be the best way to go about doing this? I'm guessing appending to
MODULE_AUTHOR and adding a Signed-of-by or Co-Developed-by?

