Return-Path: <linux-kernel+bounces-244556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86D92A5F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74FC1F21CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B60143729;
	Mon,  8 Jul 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAYWKMHq"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF008142E8D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453450; cv=none; b=H/OPmhV0J3k6YsfUo9h+vdKP1nzk/tH99SJQ2mOF4dQGSN9E+51NZBD/9Qw0DmzcswcHaW2ko07UzeaSjkUjlMaHNIZxmL+cicX3yRk/4Xb1KUaZs2hGXUdNnFhDYvUAgbwIqWkjtkikPyBv4iUfael+N8nBMD4rEkXzwXd5Mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453450; c=relaxed/simple;
	bh=55EYL/WN0iSbHJNqTA4mdC9p/nIRZAJYljL9DHWdBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5KIG0ZsI6jZfuOgfRic8fCvhyGskyzdNirTLB+pKrB6zvQRUIa8IdvCAXarXuOsMuaA82g+kInpDT8Mp9gpJbDrc84LqiUu1P/7/qpVFFBwRKgVHZcbn5XMPTYL1CQneH9D5koNxon9qHVyBQQ/nP8M23qk8YtZCwmS4zbLRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAYWKMHq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-73aba5230b6so2618253a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720453448; x=1721058248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVqwRjC0kzl+AxJ7p37N65b8RTNZZv7rKYg4axeFKMA=;
        b=CAYWKMHqjvTZ+bMrpsHCfuT1/ki5LoTaB34648yNg+EM+ffqnADk4GqoX9G3sNQdla
         VoDa6bPfUs+BuEEoQF6EoPQzlV5zYnRNAu9/H+7M4B+WAkq1869ju6DtYd+zmpDHpZgW
         OqY96fg+CAzfCHxD62OVAVrvdf8vC27O8MbPvkKdl5Kf5aISpiczDwaOY7x7tjq8G65F
         SqpvgE3kECmMExJYrFqiv79boXt7Zmd5oeSDxPTpPgnq/lD49kQ50f44b2kUh2T5ff6q
         G2PpAkvSC1fJvsnV/7CTqBLU6ETWEShl6v2AOoEz4CwuyUY/PqsOnBYKT/zyfqJJy35d
         aCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453448; x=1721058248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVqwRjC0kzl+AxJ7p37N65b8RTNZZv7rKYg4axeFKMA=;
        b=QWAHOwPKl2ieovAFjQl8yLEdDZMVPNnAHI7DYTrUQNH3AZkkJmZTUPy51CAAs7bUQo
         gytHp/zKz4XG0zjVSy8XIdjuo9Zd4VJFUHWveFb+GIW0i6b4IbtmdMMcfHV0xKzzPOkN
         0/JKCrR54/TMZbiY8pwHuPwCDEOuQY66bytT8lxpp3ttA1CRX0IidoNMyul4FV8pfcwh
         Y/AJSckBy1yoSqeGbO4Xn/0+7puecAfWJ3mNAr3Z3mgd19oVwM3DweOrq4bsXd2PfZoo
         MLcF+5XHhr2hBsPYlaI33mZSEcGPAkp7kBzfcLTgYDFbI9SynDELWaSWRaVLw9M+qlN5
         4VnA==
X-Forwarded-Encrypted: i=1; AJvYcCWPBaLUnqVopFEusi2ksr0tPKkv5WQQnMo+rZh5LTn+D8br9djn5dlHlMWrvv0Gkzr3LD57Y3y5UxiQWiTvDOvdP9w4FufxxMMpnNxl
X-Gm-Message-State: AOJu0YxOnaUSRKr/zLoS6S8KCxKuJvtxxlMcxc5GiOhuhfPsfvmP8oDv
	mZbItZ6hUhKav0pQFf1hUL24mqiHO5AIA4wV4IlfUbv/yzOulSoXrxP5B5Bp0g==
X-Google-Smtp-Source: AGHT+IHR7ldtrNinIO67D+kzq2z37guYy8fIY3dVyTh4B4NQWA6z3He8hLllyjJdqpBZrxgl3N+XxQ==
X-Received: by 2002:a05:6a21:398c:b0:1c2:8c0c:e60e with SMTP id adf61e73a8af0-1c28c0ce7damr3288048637.15.1720453448154;
        Mon, 08 Jul 2024 08:44:08 -0700 (PDT)
Received: from thinkpad ([120.56.193.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43899502sm6927b3a.2.2024.07.08.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:44:07 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:14:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <20240708154401.GD5745@thinkpad>
References: <20240707183829.41519-1-spasswolf@web.de>
 <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante>
 <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante>
 <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
 <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>

On Mon, Jul 08, 2024 at 05:34:29PM +0200, Bartosz Golaszewski wrote:
> On Mon, 8 Jul 2024 at 17:29, Mario Limonciello <superm1@kernel.org> wrote:
> >
> > On 7/8/2024 3:33, Krzysztof Wilczyński wrote:
> > > [...]
> > >>> If there aren't any objections, I will take this via the PCI tree, and add
> > >>> the missing tags.  So, no need to send a new version of this patch.
> > >>>
> > >>> Thank you for the work here!  Appreciated.
> > >>>
> > >>>          Krzysztof
> > >>
> > >> I don't think you can take it via the PCI tree as it depends on the
> > >> changes that went via the new pwrseq tree (with Bjorn's blessing).
> > >
> > > Aye.
> > >
> > >> Please leave your Ack here and I will take it with the other PCI
> > >> pwrctl changes.
> > >
> > > Sounds good!  With that...
> > >
> > > Acked-by: Krzysztof Wilczyński <kw@linux.com>
> > >
> > >> After the upcoming merge window we should go back to normal.
> > >
> > > Thank you!
> > >
> > >       Krzysztof
> >
> > FWIW this other patch makes it quieter too.
> >
> > https://lore.kernel.org/linux-pci/20240702180839.71491-1-superm1@kernel.org/
> 
> I had applied it previously but backed it out in favor of the new one.
> 

That sounds sensible. The patch referenced above still causes
of_platform_populate() to be called on non-OF platforms, which is not optimal.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

