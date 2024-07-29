Return-Path: <linux-kernel+bounces-265671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD07893F43C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BB22838E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD5145B25;
	Mon, 29 Jul 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DSfscIuU"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9157407A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253061; cv=none; b=TG05eJju1DtTY8pEfimvjVEYiL20smuwgbQ579wIDZ6YgNISlsiAMEjdtCthdm90FnpvdXS4ZBgLqWyFanzaZokfTYigoaajcDIBF0S664rDCdT9BH8/hsf8O8PPxMoQxPoM+HKzdzzVtIsU522vG1GBBiVEnFp90BjdMmZZMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253061; c=relaxed/simple;
	bh=UMkg+emiOqLVL4nu4GJN12oeT/RpjoaPHzJuxhx2oak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow+6F7mnjwkNsxZ/KgFCpysP3FHMQKj9lilsozQFh5s2w/7YIvzGtvRJlIH0zwOMNonPcR5U9Vxvn53QzF7AxAOoB+/60wPVZLmB0HsNzFjvydskMzInNfcrbFyo6YJ/gqcd3Zz7bnJbc0TFKf4KrinV67SId9ozQ6GIT7oOrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DSfscIuU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368313809a4so1041976f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722253057; x=1722857857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMkg+emiOqLVL4nu4GJN12oeT/RpjoaPHzJuxhx2oak=;
        b=DSfscIuURCi3jRmaMtGT1zMF2A6zOs3/5RyGTRIQDsoHQ0avTt/HnLfj6yRlV7OrhQ
         mFjZ2sVsrLTTUiRA/lqRyVNy1xdfJjOF5U7kYJ2ya3TPI8XuWRiokqRfj6orJaZLWiQs
         CKgOT+BxeqqeLLuQXRnuhetC+4em4plX/D+3JjrGbDPaxuItXPyRzecQ0hjWxLiTmAHo
         2Szypa4C4uW55cHXIk/BOrwk6adDWrMQTYEjDICRDWsSt3lco5P9yyaU8yw5iHMFBLZw
         ghIzD7C99YO+4agtLD7luM86/QhbFhnsxRWwcD5E1/+H4AEn+k8omCPC4mRMo7JSWUp0
         WFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253057; x=1722857857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMkg+emiOqLVL4nu4GJN12oeT/RpjoaPHzJuxhx2oak=;
        b=RHW+5UQS4Vd8ePbf6MJyl8tEBNuVOcYFEGlzn78ZRLGSpfannAb5cNCuck4Cq0Wboj
         0DqGPXDdmHdcjOJXNc/kmjcZtXrjgAlqdHq2yG9uJK3XG1AervxXhvaZGA6Grg7G+7b5
         hkl4RSgMQvFnNu/i5OeavZRy9OWzfI1k0PinIxQjUJwMkY3TtVKB97BC0yNdpEtgA1QS
         8AmFOAOhFJszy78rVxK38lLItM9AU53ySN8/lfrRqaXXqWPINQndr3bpJt3Llfgz9mW8
         dTIkT5wiVXSzdRCL9AR4MdB0EvwSNlcO/EELDuhyLvHB6gRdJRNh20q8sXfJnwCbMgTx
         VJjw==
X-Forwarded-Encrypted: i=1; AJvYcCViMHNcDYt6iyf+PvAN8VR4x4EdfIy70Dg+fK8f9c+BkVMBEFhteTF4609EUTNU/auXtXrHfwOMc45yxmKHjTN06BUxJdaCuNJFvRT5
X-Gm-Message-State: AOJu0YzWw7MQkp/o9/KDTCU4fv/AcJ8ccSKxmgQyvfs4kWzRaC5f58AM
	lYIcGqPcynuMWTZk51bhhqupB2H4LIGeKadmJYQ0SpSHvHsa0nL4kjkG+VtN1wU=
X-Google-Smtp-Source: AGHT+IGA3UsThwAcVwD716jWhKy1lQNtTr9Jegqy5NdqB0mgtrvu+30lgXe0KA7W0Qd/qyqgK0dtOQ==
X-Received: by 2002:adf:e84e:0:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-36b5d7cffdemr4718333f8f.15.1722253057229;
        Mon, 29 Jul 2024 04:37:37 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fc3ce3sm80759405ad.277.2024.07.29.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:37:36 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:37:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, surenb@google.com, 
	peterz@infradead.org, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: Inherit parent cgroup psi enable state
Message-ID: <dxwvcccihuuxddycohyi5dj66o42rjekmkgxc7pzs344kvwuhd@3x6e5prw3xld>
References: <20240729034100.1876510-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crgn7wpegjt47bzp"
Content-Disposition: inline
In-Reply-To: <20240729034100.1876510-1-zhouchuyi@bytedance.com>


--crgn7wpegjt47bzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chuyi.

On Mon, Jul 29, 2024 at 11:41:00AM GMT, Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
> This patch tries to solve this issue. When a child cgroup is created, it
> would inherit the psi enabled state of the parent in group_init().
> Once the enable state is found to be false in the css_populate_dir(), the
> {cpu, io, memory}.pressure files will be hidden using cgroup_file_show().

I'd consider such an inheritance cgroupv1-ism. Notably,
mmemory.swappiness also had inheritance and it caused some headaches
because of its susceptibility to races (cgroup creation vs parent
configuration).

What about adding an option (mount option?) to determine the default of
per-cgroup pressure accounting?
(Based on reading about your use case in other mail.) With that you
could only enable it for the "online" groups of interest.

(I admit I only assume it'd be possible thanks to existence of
psi_cgroup_restart(), I didn't look at how easy it'd be.)

Thanks,
Michal

--crgn7wpegjt47bzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqd+5AAKCRAt3Wney77B
ScXXAP970hkRXZ1uqV68TT0aS/OXr1USW4LVTdVn5LEms87OgAD8C5/Hpf8Nvv81
SQLJ4Ea0onFoknz8L2CXCTgcIdcE2AE=
=H86Q
-----END PGP SIGNATURE-----

--crgn7wpegjt47bzp--

