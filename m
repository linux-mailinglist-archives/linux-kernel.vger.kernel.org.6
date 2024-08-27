Return-Path: <linux-kernel+bounces-302944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2629D96055B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590BD1C2238C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7AA19D88C;
	Tue, 27 Aug 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJwcNmlG"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E71990CF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750272; cv=none; b=uvrkQWN9ciSxtIjmhF+KBZwtV4DOC1ZBhUd4NWEJPmeOk2sCVmQ4MKNMRSHftCE8HbAkGT8BX80YZty7pIbA0zGCjP54yuIrMSX+PsfWT7dZOZ0b8RfapN8zh4TTkgMdKPdHopLmPE9dfqylkuL6e7FsyGjMfuOk/er2ZaM3heI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750272; c=relaxed/simple;
	bh=rmnmsb9mQG1EcrAiwREtpEzcJgjxBrXKFUL0rHsmsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMz63GcRI2WZA9zhMD2ckAs83adw7Sny/R29ZN56nl/dxSqfgfEos/dDym/5YyaRBRZQ3V2/cHw+q3Q2HF982QpO184UMCaFwk7EfQ4Xi7J2fD+G254U50lj6xoFotTBOgDGOyDVSUdenkY8EiQYgZYS8jRGyR0AaqC6HfRq3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJwcNmlG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso5864521a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724750269; x=1725355069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1sasEf6dQ1biMySeoLzxw40J5UVWylbFqr5WcoeyDA=;
        b=tJwcNmlGoFQAyLVyPVePwnXXZ+MWnxOtRnoa9ZQl3x1p9wBABkglHxNOfvcEs/Jm7/
         f4YzzlKZY/t+nedy1E9Jc7WSiF5yEHgWe42I8pYamqkYTUMnYrKgqZJnUr3m6H1QrSDW
         Gt8fX8fuRCiDfpCPG+Zc1QfxKEXSoopjbuAGATIxYLbeccEfriiUwAiUg/CWQqqvSw4c
         qu0ZqIA1vUaLnhyD+8PIkZpPvTffLOHirmRvhjlFOXAMB6Pr696eR+CngneuQMHiqdNf
         uPhMoScONWYzJ3vM2h/cKLuZ9Etv0UKx14jJDKA6uGG0C6Y7UBg5mtkCCM9Ap2WXSYZF
         PcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724750269; x=1725355069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1sasEf6dQ1biMySeoLzxw40J5UVWylbFqr5WcoeyDA=;
        b=ZTzLkQAPxiM7lOdlv8VawbK/O2id/Qop3rsKeYQUGjiokvQT0K0bdMSL57zA6LRx8d
         cJr6f6pyGB+ROVh22tF6YgKslJBdOQHfkOiv0M4Z3Msnqd0tRPgmiJMmPUyhxZfHBIIQ
         RWrGkXn5nnvbxepPsve32zM719s3kkgsfIRmtLkIMwDMUCKbOhPsMBOW8lLZsxD7oHas
         WPHp5n6H6LxeF9Q44ekTDeBgiRqIdrtw3dGxt2D33vxu2tdsYsK4AGC5Ml2mhNPrcWKV
         zUkdOHFA8aWPNQrXOLb4T76zIFv4idBBLR27sFCN6Gd1kUEAfW0nqWq19C1Ly/+nl7Sy
         FrQA==
X-Forwarded-Encrypted: i=1; AJvYcCXHR04CgiFascPSfopnKWdz595Z9DJ4rDAqhGFGHdxaXR6Bkt1cAoQCkL69mLBI7EEUlT+rfOu0qa79RSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPzZOwybiT6L2r7Q+MRk2xsd2k1Jk72AZYbU8IGEP8lD1j02V
	a543rTFW5HubQVwtFKAwUPbpEVmUTEop00e1xi0pjLlkJhgcfxsdYmkfBx+c/oQ=
X-Google-Smtp-Source: AGHT+IFDcpOw1cf172ngEbl72Djz9SK7kIbETgguQZnpf+BgWO7feOp0diqESn2LrSOa7+a2O2Po3Q==
X-Received: by 2002:a05:6402:d08:b0:5be:fa68:a239 with SMTP id 4fb4d7f45d1cf-5c08916910amr8427516a12.13.1724750268593;
        Tue, 27 Aug 2024 02:17:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb2156dfsm780695a12.53.2024.08.27.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:17:48 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:17:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <d9131fb7-a6fe-43a4-92c6-5577700e34bf@stanley.mountain>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
 <Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
 <20240827073359.5d47c077@fedora-3.home>
 <a1642517-366a-4943-a55d-e86155f51310@stanley.mountain>
 <20240827104825.5cbe0602@fedora-3.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827104825.5cbe0602@fedora-3.home>

On Tue, Aug 27, 2024 at 10:48:25AM +0200, Maxime Chevallier wrote:
> Hi again Dan,
> 
> On Tue, 27 Aug 2024 11:27:48 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> 
> > Could you add some comments to ethnl_req_get_phydev() what the NULL return
> > means vs the error pointers?  I figured it out because the callers have comments
> > but it should be next to ethnl_req_get_phydev() as well.
> 
> Actually I replied a bit too fast, this is already documented :
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/ethtool/netlink.h#n284
> 
> Is this doc clear enough or should I still add some more explicit
> comments ?
> 

Ah, I didn't see that.  Thanks.

That comment is fine but we normally would have put it next to the function
implementation instead of the header file.  There are lots of comments in the
header file, sure, but those are for inline functions so it's the same rule of
thumb that the comments are next to the implementation.

regards,
dan carpenter


