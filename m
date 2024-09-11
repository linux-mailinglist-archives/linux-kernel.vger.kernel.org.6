Return-Path: <linux-kernel+bounces-324356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20DA974B94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6531F286DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB013B580;
	Wed, 11 Sep 2024 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLzpOCLL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B1139CEC;
	Wed, 11 Sep 2024 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040316; cv=none; b=V/UUskYqVr3/HH+HnLsTjgNLQ14zRcrl+EsANBq375IdZr9YkvGE8yuSo9+7rkyywY08Zvc8tdZ5+Nf9hcRhpfRTRA5gFZgXVK3Nq0GltEq8Mgw+fDIxjbcxb9k3Bu5JQxpb6ABZZL6AEJeT/Tfy1LZ4aueTHI0HKK9dyUYNIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040316; c=relaxed/simple;
	bh=em1KWOQSx8jXyJHRB33gLcmsR/TiQIu3l568zDo51Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=T7Yi1aT011aTgbAbENm1UGlyvyR8FORSt9ZWr78qakkEPN+2nTyWRqvLHv8rvAstCyNOMwXISqoFTVQ9OhpfDyUJqA9CjDBkvtIz97he7cf696q2jzPV5aJ1h/DuNjR55gboGYjFdNg8pD5/sPrC4bqsRA3WlRupNU4Ls8k46KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLzpOCLL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365aa568ceso6438040e87.0;
        Wed, 11 Sep 2024 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726040313; x=1726645113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=em1KWOQSx8jXyJHRB33gLcmsR/TiQIu3l568zDo51Pc=;
        b=WLzpOCLLPw6vJsdzLyKh5tR+uwDLTXi6VlVrNltjeRexovsQ8M7B/aVnl+Q0a3YCbJ
         4MPmVV8zY0sitK8kSDUxNt02ORLllc3ZX3PJzr893VC+OLyDl1/nMfasdGWPrtmAhgJ9
         oBN+b8PmDj7tF3VNgd3MnLz40slRcmLmPJJEXhOa6t6tMs6a9hEtBRruq10xrSp8fun9
         s7rUKEYlDP9Jl3u4Ynn0n8FNhC/+xUZ1humnnsDFLAeQ2WeFaAnikjZRhZBJ8mi7P13g
         p28q42bUsg4aRPcfZJbpq4zywkd93OV2mWTYbu6M2j6DXA7c1vTFLN7j12vXVtzombRK
         /hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040313; x=1726645113;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em1KWOQSx8jXyJHRB33gLcmsR/TiQIu3l568zDo51Pc=;
        b=sxCIQ/yZl5P4OEHYchURPECfT3WBmz0Ho+h5zkAmaOJgn7tZTd7JdPV9/j/r9nIjG8
         NdQ6uQ0pr/nCnbgGNpFf/aXcctZ3osXAW75GbdFw1BXYPFJMOOKrrgphj7hLkYcOXL/j
         aR/YrznnbCZusE6pAfnsxtzIPGj+pB7Tm0bk5k3PtMtsR6Jpbua/nmdf40EaCH2S/R76
         G8R4mnQOdWwA/jKlb/jNLO1m+JeRE1/2iZpL1yeqGZO68V2N/NCNTP4wttmLOskySS/m
         5dZWqNvZ1kXbnSmenvT9lWRgT2q7aVxdLaXGADjTneaLCaAAyCUseOAAgLyLwffiiiyx
         c7qA==
X-Forwarded-Encrypted: i=1; AJvYcCVaioJ1Q0Rju5h/fdh9Btqrrmp8gzoeRaZdi+4ZeiQHWv7wlYxCbea8wYRdsxnepC5Xo8bw2F5WrmC3@vger.kernel.org, AJvYcCVlswROGfOqqk052TRw8wVfUv8pQTERQj6Tez0fbLSczyf2QEKNwBU2+20OymrXTOofmSna6TJw7A3qPXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVxo+pDNqYoxuRGFHVK9J8QjX5i35qnKGynqZnu3gIQsFQVy3
	ynMQoYdZINZAm+srGyZJB8geAGZS+so9lu4semH90y6Ob1SJZHr3
X-Google-Smtp-Source: AGHT+IE3tfOXEg+YO49sLFOpz9RW5LaIMuIyPRkrJrmu2UmBrsAbeBkhOPQ3+/VY/sdV+QeOl1kX5g==
X-Received: by 2002:a05:6512:10d5:b0:535:681d:34b0 with SMTP id 2adb3069b0e04-5365880bc04mr15406894e87.47.1726040312781;
        Wed, 11 Sep 2024 00:38:32 -0700 (PDT)
Received: from foxbook (bff5.neoplus.adsl.tpnet.pl. [83.28.43.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cee72bsm587866566b.173.2024.09.11.00.38.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Sep 2024 00:38:32 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:38:28 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: ki.chiang65@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [PATCH 0/3] xhci: Some improvement for Etron xHCI host
Message-ID: <20240911093828.58129593@foxbook>
In-Reply-To: <20240911051716.6572-4-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I have some Etron controller (forgot which one) but I'm not using it
because it crashes ("dies") all the time under my workloads.

I suppose I could try your patches if I find a moment for it.

I'm aware of one more bug which affects my Etron: if an error occurs
on an isochronous TD, two events are generated: first the error, then
"success", even if the error is on the final TRB (the common case).
Then the "success" causes "TRB DMA not part of current TD" warning.
I suspect that all Etron chips are the same. This should be easily
reproducible by unpligging an audio/video device while streaming.

Considering how utterly broken this hardware is, I think it could be
more efficient to have a single "Etron host" quirk. These bugs are
so stupid that it seems unlikely that any of Etron quirks would ever
be reused on other hardware. Of course it should still use "general"
quirks when applicable, such as "broken streams", which it does IIRC.

Regards,
Michal

