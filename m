Return-Path: <linux-kernel+bounces-357171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD2E996CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBAC282962
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6C199949;
	Wed,  9 Oct 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmDMX/dN"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4C17C220
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482178; cv=none; b=sxI0vfTPfXHYX9lx53UA+AtbWLf83f8Bkd6iZBKskyXV60TaNXOgXfY1zQh1W6oMj2ouC3YpHoN6hGfNbnVNcXpKd9HRRQ2g7Qklg9SZso7CltiocydQ0TDnOlLRcR4mV9nUMb3HGxoc72ft5cE2kvt22Imx3vj28UIgwTCp5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482178; c=relaxed/simple;
	bh=T+2dki4VF39vIbkxA14WmXn9fcUYB2iyYJbWsFhcEho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDS7I6KAIM0ufdIKEIDpGe6nT4qcrQWN23pSf+AUcv+RasdZUkuVOypKT0P1Tz/9iDmdNmFuyaRXopBqinPdwTYIQHHyEaEp4ay3JflLZBp99ArK0rOQjgAQdGKqcJeby05wn7SyXjoYHHSLis1o33Qh+PycgMyJyUXECo8yWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmDMX/dN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so8389512a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728482176; x=1729086976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eqzIa0/gJcE/R3jckuKgBAZRYij1gkFRfpN0McDvtrE=;
        b=kmDMX/dNqGgvG2B7pD/b+Bw/AVJeXvwaA6oMMW1sB+w2QpFQjO4iZnz6ee4fNTfRf0
         MZegLj+hCAFhvpy5LeeFk6Ib5ogTMbNclbbA6nAvsVokLxzcgBQdCERCXroboIHHesnB
         aLf18Wq2NAshFqSqcbg1OthY/BRQqPvCs7ACtvpUtAnbq7s5+ejWSGpCYZBBS6GICdeN
         1va3EgKePFwxetzaQVLRB+Q9oQREp10ZSOy3Q0azeLZ6v/vYKfs28i2ZPDBxhHagi3wd
         4wiWQTggsa4irdF6gSO/nIdAFXnIEmK4hrHZnqToW3HW8uO1ZL8vXOjdfq23woMvf7R5
         JgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482176; x=1729086976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqzIa0/gJcE/R3jckuKgBAZRYij1gkFRfpN0McDvtrE=;
        b=ASrNFqoV9aeTWw2agSh4i1o+td8a3uAH+m/t0Ay47PQx+5ov9rgS0uRrggDI56smah
         VcCuODL1GBgzxr7t8jxuc48PEBj6BNkH7egAuw+DWhvkGpZ3vBe/tx7Dd85muu8oWA3S
         5rxtB+X4k/vQhznrOR1dY6LLe3eUOfU+NC4jLj2oTi1SoKzckX3KW5LMGFZiHgIqy0ly
         4r7xJL9VBurewB6cNr8TPTbmPIBtat8qqBXmE2nROGYYmh3r1mQPqkX1zSp9OwcXkGDc
         WzQYDKVAsilH9hMcn4G5Mw0+OV3hdSP5x0/egjUIvDlmYCWNN4NoGdj4n+LrEQNGaEhB
         3ikg==
X-Forwarded-Encrypted: i=1; AJvYcCX2N2rdrSp5lb8LYw7jx2zigm/MVXW45gw4OSVRJ2MyhJxmMZNG+0lHC1Jfc2IqJXgA5rbyr3mNrRZVA5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aXCqm0FZerL5T1F5g5ZWkkwnUgsTx275uCn7Wq3CSKu4Vji1
	GRYkgLLoqMdBjM/mSE3yH9PrxIy4g+2dLUd2tSI5nH6SsolYsFPrUXhlOMhmMbUnZ/xv/AW/vLM
	/6rRXxVvFCzulvWPhMzBRFiAuCX1y03hAoX6uYg==
X-Google-Smtp-Source: AGHT+IEDY6oABmsxHfJH5XHnlxBxVUBDjjYbzSQ7G4OqYguEkOELI7IuE4wjfYZU10PNdu1UqtivL9VdxcrOfXoEUFc=
X-Received: by 2002:a05:6402:448b:b0:5c7:2122:472 with SMTP id
 4fb4d7f45d1cf-5c91d6f6df8mr1869844a12.36.1728482175636; Wed, 09 Oct 2024
 06:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org> <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
In-Reply-To: <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 15:55:38 +0200
Message-ID: <CAPDyKFodrKnmFNjqLWfv2AExqkfRo9DRrf7wqB4ht=XwjZDhtw@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Vedang Nagar <quic_vnagar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Nikunj Kela <nkela@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ilia Lin <ilia.lin@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 09:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-10-24, 14:22, Ulf Hansson wrote:
> >  /**
> >   * struct opp_config_data - data for set config operations
> >   * @opp_table: OPP table
> >   * @flags: OPP config flags
> > + * @index: The position in the array of required_devs
> >   *
> >   * This structure stores the OPP config information for each OPP table
> >   * configuration by the callers.
> > @@ -48,6 +49,7 @@ extern struct list_head opp_tables;
> >  struct opp_config_data {
> >       struct opp_table *opp_table;
> >       unsigned int flags;
> > +     unsigned int index;
>
> Maybe name this required_dev_index as well ?

Sure!

Did you manage to get some time to look at the other patches in the series yet?

Kind regards
Uffe

