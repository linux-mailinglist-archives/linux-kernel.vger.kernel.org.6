Return-Path: <linux-kernel+bounces-403612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BC9C37EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF8B1F21D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A5154C04;
	Mon, 11 Nov 2024 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzAIWO/j"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267614F9F9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304510; cv=none; b=VYtxFty9R1B6NmeGtlnPcUzhf3Tv3AOayvKlTA7m5F2cf7G1ucz5qKaP5Ci3baBAvtUxqlMBVsl66P+v7lzaR4IzQVze/wpWqZFNPlPIKkSKnRLkRCilmRaHZu3rNuBAc2873sxV1n0kHujiA2xMkVplAsa/Kpl70qM7OjXf0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304510; c=relaxed/simple;
	bh=1wbt4id5qTsT4HTO1+224rcxhAAHXiof/62rdh090/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgv3bc02TZzgpVxLfBMek5vtV5rbzpNdVIHZ83jWfV+UgWszOt0pOWr2aNvg+DC7XQr/Wj/yltFrOMMFfTnRfAO3tY7R9qoHo0Ijwjooywwmuu11adEywAYQjX+xgo9ZOLD/b+KBd8tDWSMHxxQzDUB3obwVex5ezKDRG8afK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzAIWO/j; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72061bfec2dso3812788b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731304507; x=1731909307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAWcQ5veHhNVgjM+Swr4gUazUOqqofF4VZks+AvSvMY=;
        b=wzAIWO/j9YvQkdELYgkwtoNij8P8ybBB9a4zGew03rdX2Bb/M+ZaXSBjaCdppWNFNe
         a5FXlmOCA83+k8bFrdQwRAcNb/NB3GcjPRsQ34oK5+pZmb89yzjFKe9LX1RY3P9FiQZG
         m8a34tB+67P9NXCFaE1yn5FdBFGvJTOlb+YnBJB/njGML0Up8n56Bm2yN6y2SvwSQ4Uc
         0fKLEpYLIU8a5NFVGAiLrGCH0qgYbKAvdz5k9KuGEbUUOSnOiWGIcLBstVmn5meJbb1g
         aMDgml63bPAL/nnrvzyszgwjWIQR0ULk222aYZwUhZWgxDUkgxXqqTuEhM2g8HbXkfbO
         qq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304507; x=1731909307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAWcQ5veHhNVgjM+Swr4gUazUOqqofF4VZks+AvSvMY=;
        b=lGOn43H892BM9fTC0Ly48ZB/yhIn3jRvLRSGUzmZmM140boaQWOj0jLpVPY13COdt7
         qYh2jJMnzxIsgiaegPJmRKD+itGd6nrBedMVjPSrTOOrF29d9Pzly9EB+phPsNDeMN2a
         Shydiao1rFS5W1Ib10px6ekPn3eTK7M+4Puy1M6yAj7MS0uDpLBGwMQZKoMkcgnkzfQi
         /4G/lKLGP3Jx+vcFepu/kKYFqfLXEjaW9XlbgDH17sq2PNgTsYGYP+gAPNME0WGA1PNx
         x5fxHeW6Qh3bdD55CA41yk9PeAgRTX3IJAcfdcDc8s5QzlszGO2aCjAAtqNusxaMSrFU
         7iKw==
X-Forwarded-Encrypted: i=1; AJvYcCWjP5DGaccZw9/7wtSTx6GNdvttG3HpATgC+uQsR5pBOBC5PasoiZq9Gop1mMaRFFJlswaEMcj7tpvbR4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBvrtRtTE6N5TA6a4/FM+F1tPvw7eAJU/aTpO0mCeJsej/5+Q
	MzxwxKEwKdYLSkWB/FV3h/CaDTEPSCnDCV7H4LdEmeRB+TEnnH53rAvxn+sNHgg=
X-Google-Smtp-Source: AGHT+IHtqVtA35vMC4e1EnNTvwTwqSJFlJzhlZOFgx3RSPLljVG5nE5Fqy9JY0g2bqUZOQmsSp1QUQ==
X-Received: by 2002:a05:6a00:198a:b0:71e:415:c4c6 with SMTP id d2e1a72fcca58-724133d215amr13597006b3a.26.1731304507363;
        Sun, 10 Nov 2024 21:55:07 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3d5bsm8443325b3a.106.2024.11.10.21.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 21:55:06 -0800 (PST)
Date: Mon, 11 Nov 2024 11:25:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
Message-ID: <20241111055504.2f3szrd5ahudvtqm@vireshk-i7>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
 <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
 <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>

On 11-11-24, 13:30, Chen-Yu Tsai wrote:
> On Mon, Nov 11, 2024 at 12:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 31-10-24, 04:02, Cody Eksal wrote:
> > > From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > >
> > > Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
> > > let us use efuse_xlate to extract the differentiated part.
> > >
> > > Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > > [masterr3c0rd@epochal.quest: add A100 to opp_match_list]
> > > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > > ---
> > > Changes in V2:
> > >  - Add the A100 to the cpufreq-dt-platdev blacklist.
> >
> > Can this be applied to the cpufreq tree separately ?
> 
> Yes.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied. Thanks.

-- 
viresh

