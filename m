Return-Path: <linux-kernel+bounces-521969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72726A3C466
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CAD47A69F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AE1FDA8E;
	Wed, 19 Feb 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSkIiARg"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BE1ACEBA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981103; cv=none; b=LKNDGItEcbxUIOMkuRj+IylhqphptalEs8MSBX73ZeRP2Sz0BER18/8wdzksIf23cliIkAiEi7YI+H2jr7Nc+b4zQo+DKb8mklVRWmY1M02fEnKyj+x0fhGU/sVWvhJUIP4GtoMjI05OApPs1M//Ks5B8iWeTU9A7ekx5URSiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981103; c=relaxed/simple;
	bh=OiOSh7apz2kEsevABDPqv1dC0auMRoIYy9Zyi7ArObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpwAyx5vmqT46p3h8ZjfPfNuw7CBvvXgQwYoBBwJEWBsWhrG+8MNCtEWClYze9Kibk729PqevVHhOir+Pk3PFzoO29n9ka5wtiEHEvk+sY62xtPLL15vx2x6yed8BfTeVkJ2onTvvgNOmLOF7IPMzW7OyvvM/8/6SuBMZqI/q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pSkIiARg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so12694678a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739981100; x=1740585900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljkXhqkhG6hd6NRSsz5fArUZWBwAzxurIP4uHPf/TMY=;
        b=pSkIiARg9ehMQbQZvMhCjBd8LbOHtgBn0IU8YKnrLL0SaKgx7kyFpTR52kH+FWcg7X
         r3EAIIa+BQ9VPwf2KeGBel/2hVlaJZ883AbEerjSIB0TT45ep2+9/2x1KSsFHSp9j+Ej
         CqVE0PeuePfa0UZ8kdJwA0UcyPZ7YJJm/6BiTyBR+AK9217mTb1i3KcuTi6bZ238v38Y
         Fh0YPHxzsfrGedmZsBxyOA7G40gew1oO1YVh2pFEJtOhHlSC0UuLpoD9LoVDsLYzq81b
         5DnRpwnwemUP55x5bwP1u92AAHXRNFVEYDU9+HNnPkIuuQWBkV5Z3VNoVLLRGyYVNIPr
         7roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981100; x=1740585900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljkXhqkhG6hd6NRSsz5fArUZWBwAzxurIP4uHPf/TMY=;
        b=eYybBiwEfxtGWf7hlgNdkTxq+iX7oKW+exSXXxuxKO6RvWHFSw1rL62W8/iCL6pkG0
         wRlJ2ocysjehCKzLtNod3KvBU8ntM47w1xffCf0qaJoxewxrouiLdkNG9qmO9e1xAKM5
         2W2sYuf2C8xvyGOD9Cqbw+soBwzbS/3ahMDgsZzMBdzcsZHW2rAYJ7HMONKbhFlmieDj
         FrdUnyuBYxmy955KUWMS52Ez/K4zxbBZ3c8lzO2xnjODhD8w7g4XKMsbYHCA1HVI/AGO
         xWHQCF20sIORAkVcA3boespWXA6y+ml4wiv5m3+RbejllezanyD0ydiXnXVhTaugGz/n
         E59A==
X-Forwarded-Encrypted: i=1; AJvYcCWpMKl/jUJFbQxa+APJdc7VlC0KwCg8J/tvR0+ddCsNXuP+916ONP4YNfRdgjfxganCw8WBzMbS42wdxXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydeg8USEBTCkY3UDKSE5FtzxMiiWORSDpt33M38E3IIkMSiNBj
	onCnnhKib5HGHGP30fCgT9hSJB4TcfJ6PUyZn02IcCO+EbFnNHIKJ1IYNxq+5Kk=
X-Gm-Gg: ASbGncv2+tMnzcTLbcjn/D+pr0W33oWN7edI6AJtYhv7P2/Ls3UkY0YGaH85deE4Uq1
	uMOgGDJEKgcovCJXN82NZOJqm/drgGDAo4G1JSOGJJkfNsIhvgX8ayRQj+ndqhGIYLZ8lcYd/XL
	+e2/keA3tnsv0vWX5a5A0ky7LIGkVnqnv1PjAjJIskvefGWVm+/gycytNqOG12c3mYNxo9LWcAI
	VjX3oS5b+6RkxS4dnk04TFnAQHZ5kHBbTlNKZPZzwy6K2rfPWH+bTB8cqVuaLHtX1S7ZOxkbH6M
	wJPN3QpqCxQlxFZhIR9W
X-Google-Smtp-Source: AGHT+IGIOphoxeNaBbPBBYiv7n3xtBHBqQ7mynIC16IzmDF75ejyL2+ZcOWGMA4f93tnbTIyUvSjSw==
X-Received: by 2002:a05:6402:234f:b0:5dc:72e1:63ee with SMTP id 4fb4d7f45d1cf-5e03605b765mr20641327a12.6.1739981099630;
        Wed, 19 Feb 2025 08:04:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece287d3fsm10511628a12.72.2025.02.19.08.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:04:59 -0800 (PST)
Date: Wed, 19 Feb 2025 19:04:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jim Qu <Jim.Qu@amd.com>, Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] vgaswitcheroo: Fix error checking in
 vga_switcheroo_register_audio_client()
Message-ID: <f608a3b5-320a-4194-bd03-cf08be04c317@stanley.mountain>
References: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
 <87zfiim09n.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfiim09n.fsf@intel.com>

On Wed, Feb 19, 2025 at 05:17:56PM +0200, Jani Nikula wrote:
> On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > The "id" variable is an enum and in this context it's treated as an
> > unsigned int so the error handling can never trigger.
> 
> When would that be true with GCC?

The C standard give compilers a lot of flexibility with regards to enums.

But in terms of GCC/Clang then enums default to unsigned int, if you
declare one as negative then they become signed int.  If they don't fit
in int, then they become u64 etc.

enum u32_values {
	zero,
};

enum s32_values {
	minus_one = -1,
	zero,
};

enum u64_values {
	big = 0xfffffffffUL;
};

regards,
dan carpenter


