Return-Path: <linux-kernel+bounces-348110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DDD98E2A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E97B21846
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B8212F13;
	Wed,  2 Oct 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="N8IEU5pu"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D22141B8
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894103; cv=none; b=comIEP7AwIfsZzYZjmY13V6I0Ha5CdjEOPQ3kJ10aCFFc7JFx1CI5AQOKPITjSSb3ARh1eL0PJ0yGHfWp9Kgzk7oWtOM8i0NZBYlHKEDmaZ8krCW32s0biB96feSj3mCha5uk6g1/JM+R6HbV9cbz0K2htJUJy7zehNRUO92udI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894103; c=relaxed/simple;
	bh=4mOa3i0op2Pd4Qv4ekVZza/cC60XQdp58G07WH/bwuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1c09MM/Q9WWg2m3DTZARxRszjtGcJ0fpmtgBzGYzgb36nGhu2IAQRwPPIHBZif/OAA6zbJvBBu3q8HY7U0L/PvavMzWrPT4n4A7ysvghCVSyXIwiUQWFQHJrYeBg7YMoH7xbYjUJu3x2hnGLgGEQ1YeEK3wDybMOvmEVIsWLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=N8IEU5pu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20bb610be6aso609555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727894100; x=1728498900; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2bn2F/yqD7qU/04cqSEQXSLsFN+5ARfldGIgsw/yx6w=;
        b=N8IEU5puvbxPLucPJc3ufjkilft89dUJxRPIfS5RrKgYvOi/K8W3bmLhVnpCZYA9FV
         80Bk5ckUgiRhjWByZpOgkOvRVzKkhGl8bInt2FabSUV1W+BBuxj8KA/MqfI3uYSzHGjp
         UZZUMnGNbivZ98sI3uLjHcos/cJMhQpcBBQNeJA8Jp4Uo3lSLfZGgkZPZIsfpOXlf0q7
         SwBccXXm+qcPzH5ufHgifzqS58D/uVEcR1/A7NnJ6fOmgCXWLw4HWt3Aohyc9XfkW2i8
         iaAZ4VK7CzFnK5DIjebtpTQza01ueIZ00/9ujurp9Bzv9QT8jr7Frugx6ZXAXgIlyljU
         9dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894100; x=1728498900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bn2F/yqD7qU/04cqSEQXSLsFN+5ARfldGIgsw/yx6w=;
        b=b8l6uKpA4aPYtSrode1g+eH7AfsGWeHub7cXjkUOGJRUqY7z22ohxMEgOObFsEQvEL
         a99YCffpw5+IpXHl+3XRVg9JxcaJETf8O1dlptvMohFaUSlb7RFdmCQAq+R/jQGedfM+
         g/XYNEc8CEfj50V6s5rF7uU+hTvmelvCvcCTEn+zXbfyE0f212WrDxVSuvixssUr3CkD
         23njxmRO9Q9G7NdQ2RX6ebwwB5Qv/yDXWkbBLX+VTof7LPjqKpFcS8b53Gsa0fFZwEzt
         j3rfKksOhTILYhB/QP+iKeNscuaxNe0u/YFW/tiawJZMIAGGcU3lUASD3lIJr/qqa4sy
         s/EA==
X-Forwarded-Encrypted: i=1; AJvYcCUhxWU52aIFQHuEvKlQBHtq88EX6v7FGbfCcYbNx6WGHuV4NiWX9AEmcKzVxhMIucUdvFvzyStsV+iFsqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2Yhpj3mRI48x5SH2/qFSXKhzzNYBV0ANgqL7QMtgtARYASu9
	TcbmVxIzNf2bfw+XZm3jWszsucyHD3nFArqyvZyq97foIsy4IP651vCMm6PMGr0=
X-Google-Smtp-Source: AGHT+IGyYDFCPfBUD6cqyyaq/aeFBAk0GqWubZItpSq29H18WWXrjLh/21OEwSnJg9ub9uTxFHI7LQ==
X-Received: by 2002:a17:902:dac4:b0:20b:13a8:9f67 with SMTP id d9443c01a7336-20bc59ec852mr70149115ad.1.1727894100059;
        Wed, 02 Oct 2024 11:35:00 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b5b167128sm69551315ad.283.2024.10.02.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:34:59 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:34:57 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] pinctrl: Add T-Head TH1520 SoC pin controllers
Message-ID: <Zv2SUVv2PUYqwOzh@x1>
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com>
 <CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com>

On Tue, Oct 01, 2024 at 02:13:20PM +0200, Linus Walleij wrote:
> On Mon, Sep 30, 2024 at 9:51 PM Drew Fustini <dfustini@tenstorrent.com> wrote:
> 
> > This adds a pin control driver created by Emil for the T-Head TH1520
> > RISC-V SoC used on the Lichee Pi 4A and BeagleV Ahead boards and updates
> > the device trees to make use of it.
> 
> Thanks Drew, v3 looks good. I've merged it to an immutable branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-thead-th1520
> 
> Then I merged that into my "devel" branch for v6.13.

Thanks for taking this. Will that also end up in linux-next eventually?

I'm working on a TH1520 Ethernet driver which depends on the pinctrl
driver. Andrew Lunn replied to me that all the dependencies need to be
in linux-next [1].

> You can merge the DTS/DTSI files through the SoC tree, FWIW:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, I'll take the dts through my thead tree [2].

> I think I'll make a stab at using guarded mutexes etc and see what
> you think about it!

Do you mean using scoped_guard() for thp->mutex in
th1520_pinctrl_dt_node_to_map()?

thanks,
drew

[1] https://lore.kernel.org/linux-riscv/99af411c-ff40-4396-a6e2-5aac179ba1be@lunn.ch/T/#t
[2] https://github.com/pdp7/linux/tree/thead-dt-for-next

