Return-Path: <linux-kernel+bounces-295315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B995999A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA6D1F21F14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306220DB9C;
	Wed, 21 Aug 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OGAZx4aB"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563D20DB91
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234961; cv=none; b=r0r+jY9JZkQXXPRLeloDfrCUmGfGCe0eX2LOMCKPFulFKaPNinOSTSZDFBswhyKlpl2zbaMXb3jo+8kr/VvDsDeLCUlznfRiBReGP5hIcYaUnmuImUW5TGhnaQARg5I71tWbvwrtWFm/6+8pt/e+/OiMF9vie8+AqaAMFB5FnXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234961; c=relaxed/simple;
	bh=2CnvFDBpoOmIJPEwWYRm+tbMpmDawJVyobMgSJbQRAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ7wD7Qi/XTUCXQhXEkUXxbyEwtzrDB8omw0vh++1y/kLBCeo2gHOYfmgFWdUi53Ko7GhVybw6UnyHK+JMM/VW0zL5hemFwsUHWiRIWJTjWkfBjwRatjM5DkP86FCw7NX1vyIPZU80tnv3jTODnmWcV8Vh2yIsKTTBPtOL9lPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OGAZx4aB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f0bdbcd9so14436481fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724234958; x=1724839758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CnvFDBpoOmIJPEwWYRm+tbMpmDawJVyobMgSJbQRAQ=;
        b=OGAZx4aBg8aiY3oJo4fLG4No03Q1zZ6ZIs0HhqnO2cNXYzDLLGtnR3hknab86rferM
         zcBK2pcz7WuenhIasaQv9ZAZVPIlkIh5RQQIao/fUqmbDA2s1w3L5rYkX6Zfg2++l062
         z38GgdZsMPXyPswhiZkXE8p4UMvzeL9s98rznE7G1S4/SN8uvt2VbePFUgo9m5ZNiOEB
         c80WJOhhC4OmNlXz5Z6ZwCLz0ftZtKMa+a+cM2X6urB0gjSzpsm4MNeRfDgughMcKZAM
         AZzLAE3Z6dhymG5iY0h8LEpreHxs6msqdaKcGnEvYbWUg5EXUvZuA22Dr20UFuNMDbbV
         +Pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234958; x=1724839758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CnvFDBpoOmIJPEwWYRm+tbMpmDawJVyobMgSJbQRAQ=;
        b=RvnnhHKClIAnT5BdPS9B/SHahseNhb+trMrP2lgyEZnG1EThB7Sfp/dWr/m9FsFgSc
         HLfHYa5qAwnwLTl7cHGl3UCGvkJDesgaOmgSdPnVA8cHERg8qNJT11F8Ub7eLqRYI2FD
         AlQvcUwd7HBSH5aUpHxrmtMzPTmNc+fLpVISXB1/Kh/Nhyc2vEUiPzKE17jCz5k/GDug
         l+YNtKcs4SiVyuprjJpGYvfvJSWsBhZL9OOEfXHKhHlmobeS6DE/p8NlB+8C9VUl3NNY
         CQ7UXU4P1R5wII7pHq3+ODnNis0pmbTByWWyinV3WHnxQOFcEnbEYT10OMsT/pVuGBi2
         O4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXdHVqJ/Lrfj+2CIcg0EzEr6QAXM/pOogcq344+OMMgcZDJOUoNW8nDGLlPx6ORYelUfYgmmuiIMv1Eyoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqqYr909CfODRc0IV7a78J62xzRPdwg9xRdDBjomNfttbwdeX
	HdeEzJuPlGaDXhR0sxzP9Mr7HpcIRWTZW2xcZo6hfHNnBKj2H2H1EBcWkyMDVWEx36dMI4WshNu
	3VGRJjz6/6RKN93wDLLO/R8Sc4R/Q7NbUW8ph02XEtfFlubtaqBE=
X-Google-Smtp-Source: AGHT+IH/KROqd4SBZBae9gjn5KPL2Xtm+TzJJpxpcFP2raa1nwIor65T1emivTiTtt+tA6WUId6hptYcdpMUP4C3LDc=
X-Received: by 2002:a2e:7219:0:b0:2f3:d82b:1955 with SMTP id
 38308e7fff4ca-2f3f88922a1mr10409461fa.25.1724234957071; Wed, 21 Aug 2024
 03:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820153855.75412-1-brgl@bgdev.pl> <87cym3f447.fsf@trenco.lwn.net>
 <CAMRc=MeGew-iHFmeKuKqDfDPZtjCfdNXzOzj56=qxssGP90SzQ@mail.gmail.com> <874j7ff0kt.fsf@trenco.lwn.net>
In-Reply-To: <874j7ff0kt.fsf@trenco.lwn.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Aug 2024 12:09:06 +0200
Message-ID: <CAMRc=MffQCapPQ-O=GQUVEcEGx8ey6Mcum9-new-BEis+Yk-eQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add a driver API doc for the power
 sequencing subsystem
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:36=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > Am I getting that right, are all these :c:func: directives useless in
> > this file or only in this paragraph?
>
> Throughout - it is really just not needed for kernel docs.
>
> Thanks,
>
> jon

Just sent a v2. I can pick it up into my pwrseq tree with your Ack.

Bart

