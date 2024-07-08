Return-Path: <linux-kernel+bounces-244593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E625692A698
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D972893A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0EC146D45;
	Mon,  8 Jul 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtXlsyxo"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E677144307
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454345; cv=none; b=maJeUEayBWR1js/RkL+UQw9p0HQriNFV9vbvYSu1B+XknSWVyHARmiDzu73KzSBO0qDZKJiQSA4Q/M4aQOM7K1jduWgM5dZMY4bxeiTM1tEEcBygx5/Z2TQrSXJqGyc5GPKOQ6t8YLzaBoM5I21xj/uzjmwfFXQFB4E7LAAK+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454345; c=relaxed/simple;
	bh=T5r3mJm2PSBO0KpcpoVkQJClJnZRVOvT+7sfiReF18Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYX0Q/ksmmXbQn5rT9/VOmQ2mpBC+9wLIBbKY16BNe9llVdwgvCRoexgpDmteCX3leXWyAKehznbjFE15U0EoX+1X/2GJwJ6vwu1i3vUYRwA2BhcCE1GxaMhmMlMTYyJWDBxtd7qLKcNE9cjNywcs0lGkRICyWVaKxHAFewOrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CtXlsyxo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b31272a04so710650b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720454343; x=1721059143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Rr0PPFKZTDxFeXGu4e7pIimZBTpzWSD8DHkcidYJLk=;
        b=CtXlsyxoeAwISJ0ExiNeFQ2LtdR/ab6Jc8WiEFxa3tokSwoTjG6n3ke80URDq37QrP
         r6NIxi/zIFE0/ELa2ULmxoXTXL+IXK7QBHm7K3XdE3eoIQwLk8HftKBYH6jO+gRWI8dl
         FlrYdaHMdPFcp57IHWmqZ/AD+80WXs9tLagW2B1c3ncDaT0QS1hGU+dBH1pOexHP//xs
         E/hxtflE9XraZ5AOAu+x9WGY3R8y+k0TXMTdLoz72WBCQlRaVYxY3Md2GaEZYepplvwP
         18gYcBGolxYHV3SUkuzBoi8siDEk+xZTepg9823Hc9YraBFLlkhC1FCZsX01ZWLDXpIn
         6dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454343; x=1721059143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rr0PPFKZTDxFeXGu4e7pIimZBTpzWSD8DHkcidYJLk=;
        b=B2+wx9aq8wIZk8lB5/xoGkqEV/UkLUS3qNR2S57ig93r71BfIMYPfdtm4XU4Jns8ej
         tJXa94fJpI7OedWdZRRvDKIdMPLnIkWXLpFF+B8rjxUMCQaad2HkU8yuMD1P9sxej5pJ
         U272SigQSbHHGrF5RNPWltmz5LQBagwYsHH0kpCFBor5vST7nf6tOdhl8Jk17FeIWp+q
         avvR3NuqJ9f+R0bZ/v6kam7Nrj54ZhUDOqQ+3WD5fq7e+RxnOfe79EaVqtmqiyheaxQj
         YCu52f2qo3LgzUzLqJcrvXiIAwd6MkGM6ylHQdG9eeZxODcNYk5svhtuJ8+OkLWzesWf
         alsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEXfjhmmm8ae6KomC8zjvH+QeOQnMEzEZiRdGfo05loK49tnM3DXvSD10MY5mXCiPF6god1c/622cnOO4Nj4psdEe/sOKDoP+BqHsm
X-Gm-Message-State: AOJu0YyRE7Hk1U3zBkr0gEWsvu+tMADScnfqg68CWm9hSlWG0olHk6+9
	xj5RtshHE+bvD9UrZmZk2+kAVayXCSy+IXiGUu6HVfqKpfpWeT3dUKfK03lVNw==
X-Google-Smtp-Source: AGHT+IGL7y17EBQGZOQtqPKSNxUDptufJrdZlvrmTqMgjsNgJkzF5C8xozj5jrdwZhFb1OwzQWhInA==
X-Received: by 2002:a05:6a20:3949:b0:1c2:8c90:8e8a with SMTP id adf61e73a8af0-1c28c908f74mr3250148637.26.1720454343660;
        Mon, 08 Jul 2024 08:59:03 -0700 (PDT)
Received: from thinkpad ([120.56.193.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439e9fc0sm9814b3a.206.2024.07.08.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:59:03 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:28:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <20240708155856.GE5745@thinkpad>
References: <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante>
 <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante>
 <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
 <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
 <20240708154401.GD5745@thinkpad>
 <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
 <CAMRc=Mf2pE5JVHzcntO5b+5so_=ekuHGzrY=xJpKatURJFpGZA@mail.gmail.com>
 <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>

On Mon, Jul 08, 2024 at 10:53:18AM -0500, Mario Limonciello wrote:
> On 7/8/2024 10:49, Bartosz Golaszewski wrote:
> 
> > 
> > If you have CONFIG_OF enabled then of_platform_populate() will go the
> > normal path and actually try to populate sub-nodes of the host bridge
> > node. If there are no OF nodes (not a device-tree system) then it will
> > fail.
> > 
> > Bart
> 
> So how about keep both patches then?

Why would anyone running non OF system have CONFIG_OF enabled? If that's the
case, they have to see the error because there would be no DT nodes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

