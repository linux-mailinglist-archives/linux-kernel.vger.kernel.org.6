Return-Path: <linux-kernel+bounces-575577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C8A70457
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FCF16BD56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D7325A648;
	Tue, 25 Mar 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="c+fhiXdo"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7C25A350
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914427; cv=none; b=mzolR2klfaZ9pc7n7/UB8pY1OJSXC9RHlAsgdX40fjowlB01btdXqvbEuosQeRS353uABxvUqxT4RlsZ4GGfmz5hzPqtTqDREp2AL/LdrtR4jjC5Eqm9hqUJJK+JMcAqEiPXu2b+4noBcdhDqFEJVCyDcnsEpYWnzWgOTQLGuP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914427; c=relaxed/simple;
	bh=1sM5l4Le9uZaYWmJvDCU8/tUWoePiEbJJ8FpsxGPQHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAUrh8FfrtiBzP8HtyY0Xw77q73ZNBhTOrW14MCK+WLBojkeu6yxqlpMJHv+AdNLbeJD4yuKAgCyF6wtN2ySuggoxaKpCdjAXiQ3WThyCBHr5z/pu3OBJrYb+fOVvyH7FmfshjXszOBAeOTW7LG/d+cKJpcJHBlKFM25e+LkUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=c+fhiXdo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301302a328bso10840653a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742914425; x=1743519225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TdkDS/vMk5p1AZv8W+AgQj6RaWYMpbzjtCmMRhYEbI=;
        b=c+fhiXdoVvykfu7MlS9X+itas6WJclx71D0tUzBqIpP4q+OXrzEjZUNQR7kFIdfFjb
         lM7FJVOPbNU8Sp7llOUUbJ92w8e2h8+Qxs3A5NkLMyT470VhVL6Ggn2q3U2wLOtCzQs8
         cKtZlOqOz3D+7+Rw2ES22wkODhcNmtY33GILg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914425; x=1743519225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TdkDS/vMk5p1AZv8W+AgQj6RaWYMpbzjtCmMRhYEbI=;
        b=aAkxqKyRRUTMdiQpspzAMH6dhHw1ScQUoFpZPM/M1mCytxqrNWhM7urxnF1r+eq2QL
         09mv6j3t10d5UquiMqTLkxjr+FO94jBT8jM0QBvzbj9XbRVKqD7TlffDX1KhZD7f4q0h
         gl/xUGD7ruB+MQSzjBot+NX24KQmlGaamGXr86PTLAA6g4a02PJWj67boOcBHTnvgvCH
         O+OIhuPsBVr+Rwmgjc2d2FmHlSywoKp+PQ3zmYpxmh3Dc9B5XtAhxy9UzA7wxQvhmAxN
         RTFlI2CTObjOBpg4PKjZ39c/zyobfdnmRW6JDGe15cqCEm2zTt3tDBGJg8uHEIzeD6oc
         DwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFH7yHmw9RjQeqO0QuBpqt4QjxKzgL+h4gZ7FTkemVf8P3ugJfDMj7AuaHba5UvXqx6iCRRmsoD7zutCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOri/+50aKDRG9hOyrnDM9XstTSVhNAd5v3J7rgsMnJF4qoaj
	UfYSDUTGrn+bPgy+jcPKyf4FZKOtjAfwSxiSwJZR3pluuJZJai1zsNr1CZJC9P4=
X-Gm-Gg: ASbGncvc5bS94KqIPi1p2qz2528TXNHP03ThYhAGJIL44sb5lsPNyTjUMHHdPAN76mO
	wK52/rY+Y1HuCY3GuZdVbAebeyA6xr3E0dKd+1Oorr5k35wraMF7Ib/9uheyoVZsChfh+UcT4Db
	ZMSyemRryCC47gzXRwrCp2pkfoQfDM2guEhM2kERIR8XYrh6AYAKbql3TjAAWbFDQeUql2nM99q
	mkdAEXUNK3id6GJFGSR/HJmhFch9Q6/NgEIkGK9aVcxkU7ikRkQ60FeUAbuGfL3jVWGRq7BHaVm
	T4eei6C65MFsR7iPZVSKsAYVcv/0Ekt+K6ncW0Tp4A21KuPyGjRO8HY/GzM5
X-Google-Smtp-Source: AGHT+IGTbPk9dPvPoREsYcLOoknFmq0RVX2PWOyMpPbWJ8k+G1JOY7Wb19hLjnqLwlugSDnBNIwDXA==
X-Received: by 2002:a17:90b:51cf:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-3030fe86471mr27282348a91.13.1742914425185;
        Tue, 25 Mar 2025 07:53:45 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811baf30sm90844895ad.130.2025.03.25.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:53:44 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:53:40 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	PCI <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	shivamurthy.shastri@linutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: next-20250324: x86_64: BUG: kernel NULL pointer dereference
 __pci_enable_msi_range
Message-ID: <Z-LDdPeTsnBi8gAU@macbook.local>
References: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>
 <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain>

On Tue, Mar 25, 2025 at 04:56:33PM +0300, Dan Carpenter wrote:
> If I had to guess, I'd say that it was related to Fixes: d9f2164238d8
> ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag").  I
> suspect d->host_data can be NULL.  I could be wrong, but let's add Roger
> to the CC list just in case.

Indeed, sorry.  There's a patch from Thomas to switch to using
pci_msi_domain_supports() for fetching the flag, as there's no
guarantee all call contexts will have an associated msi_domain_info:

https://lore.kernel.org/xen-devel/87v7rxzct0.ffs@tglx/

Regards, Roger.

