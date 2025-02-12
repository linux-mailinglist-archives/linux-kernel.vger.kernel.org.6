Return-Path: <linux-kernel+bounces-511044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E9A32519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83B37A3D57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0720AF93;
	Wed, 12 Feb 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZJlTcMB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991F20ADC0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359897; cv=none; b=ckZPd3OCcq2Smtjei6CHxPWrPJf+BNW0I++ieFwLH/O2804qevBp+fZ6OvuPIAHLurRre3zzBLtrTJV64Tul62cs9b6cW97sC8MtQgbP5/caQN0dhoO550ZrhIlRRHAz3qp0bXXDrUjSECGG7aZvQjg1a5JtxDcNEpfqEoAwUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359897; c=relaxed/simple;
	bh=e2KfzgLwmzk5l1JnDBTAAKAkzVrUhAernehT+CJYXpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boXcjzdlRIqkXQ91RKqO4pieU57PlLR+aRcKg2Hkvc3q03SievRwdkeq8P/IBWBRf/RQPCj0Tj7a7MHvK6ojrG2Y4POevyPwgRfAMlhWJzYkan9htP9y7E/8igMVPzDfQR/JrtFn4tK7CRjc8Qr6HObOJCWvOxuuEQuzM8Gp9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GZJlTcMB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so79600266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359894; x=1739964694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IY7v4Zi/Fu9rYdLW7DVELcSJJEpH68M/8w+jya2QF0=;
        b=GZJlTcMBTZ2+iX/gOdOAqkbTw8csfkc6j8jmzDiZtvGzsuBnzDSxUwtvu3tA38FAcR
         UO7QYFSRWaFmtKnPRigXx+kcZNK+r+vY/IyD7rs5h+ndktvCkZYrRVXg8INcpUDtpw8H
         czVOkv9j/yOw5IqbzaqfeyJYe98DQKtLOKyMYRcvj/pPZQTp+IJdB7bdp+wpILbDvQr6
         9RZoSRRf6V1I2vUszbJNpg5ICCJti+PuifJsx0Bnz/UDh7qaRf/5ydZFAA3j3GorarlT
         +8gzT9IaBhevyyLdUe8WcB04hx7W0PYmqsx5yOjjNOZqnoiNENBic2W7rUA4dCbmPZv6
         N6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359894; x=1739964694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IY7v4Zi/Fu9rYdLW7DVELcSJJEpH68M/8w+jya2QF0=;
        b=cA+0Cj37yStddGlLt8h/nk1V/jAMcAV5F6t+w+MvELr07NDjYmmmcOch62Th1Z7FXS
         diQUuwC+qJw7VDXzJr7XNmB9dz0vJdLDzc3dW06+EAnWegUjB0FGPg+F7rqOL/YHBl3p
         t/kq4SXVpJjmzxA8kGP6qUZeaMkrQYsvjFTkgs5r05N/fArGghbPGmZLkK5/cFXhWpir
         EeATU/zn5wrmDxZyag9urlB1laXETNSGHZ/3RgEgHGg+P64TKExU1aidHhBwA69nbKy2
         J6MFK3cCl0CIV87+ene3AkytnYAkqfkmt/cMtUF4uCKTBRdoBTnyWrV0ja96h7wus2Kb
         qxZg==
X-Forwarded-Encrypted: i=1; AJvYcCUrSUqxb1QtYrUS67lqtbQFUN9PBBuOqR0zdqKR2D5Y2jQLq4KNoVGzJbDcMCgixHqX0u5oOu0m79p+Oac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwpJrBjuq+mFUk3hmJB2KD1konmeoGPqYEZutPmU7CiiXQEeZ
	HicJLx8+AEnvqIP2QKB9FI0si4FUmO7RjOXGSuyWnZEHMnc4vam4hBEGpzq+PQE=
X-Gm-Gg: ASbGnctyBpQ4phLiBRWb9jzD4p6IJrhfH91Cij8/h5B5hb5B4goGIlrNwiZSaSfVyi1
	/HElhfnrqBG0Xz037kg6HELnmCnoknYjAI4LpxJnLnPWU2QARW27prCIRcfbIldqgiLU69x+w2Z
	oLTmCqglgljlXUbNDWmtU2u02WHoEfQXszjztfPzZ/zxtpN7m9n0wefbNbMt1zETLNaz/KtAMzs
	tSTtyRyqjGs4tKmECgXzRspFmozBirW40fCQekN6pGJHvX4oV2ZtzZ0wUOCyoT5JZiBc6VY5BO9
	6lIC+p/G8bgpbCnZ5Kun
X-Google-Smtp-Source: AGHT+IE8r3Uu976/b0hVMNfiMuo5JA7dISIXfDl7r2E96RTKYYYlUfjyoNpZXPWOU+uynrV2OZsf0Q==
X-Received: by 2002:a17:906:6a0b:b0:ab6:b9a6:a9e6 with SMTP id a640c23a62f3a-ab7f34a11a2mr214687166b.46.1739359894370;
        Wed, 12 Feb 2025 03:31:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7c3aef933sm570929466b.120.2025.02.12.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:31:33 -0800 (PST)
Date: Wed, 12 Feb 2025 14:31:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, kvmarm@lists.linux.dev,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	virtualization@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: kvm: nVHE hyp panic at: __kvm_nvhe_kvm_hyp_handle_sysre
Message-ID: <6b7780ee-6dbe-4e2a-8d7f-4057e83c767e@stanley.mountain>
References: <CA+G9fYt6Cuu6=OO9w80yhJbZB77Q0qf7nzYdvjbgDbgAw6t1jw@mail.gmail.com>
 <8634gku30g.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8634gku30g.wl-maz@kernel.org>

On Tue, Feb 11, 2025 at 11:36:31AM +0000, Marc Zyngier wrote:
> On Tue, 11 Feb 2025 11:24:06 +0000,
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > 
> > Regression on rk3399-rock-pi-4b while running kvm-unit-tests with
> > nvhe, protected and vhe mode with virtualization enabled.
> 
> I do not buy this. RK3399 only has ARMv8.0 cores, which by definition
> do not have VHE.
> 

The links to the dmesg are at the bottom of the email.  It does seem to
be a RK3399 with ARMv8.0 cores though as you say...

https://lkft.validation.linaro.org/scheduler/job/8117232#L1395

We'll test the patch.

regards,
dan carpenter


