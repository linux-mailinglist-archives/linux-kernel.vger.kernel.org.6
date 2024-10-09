Return-Path: <linux-kernel+bounces-357379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0477E99709D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CCC1C21FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7C1E32D9;
	Wed,  9 Oct 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnjXQKF2"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27E1E103F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488893; cv=none; b=Jzs7l6RkNQzUNnvJjFQ+11kmaJzJNxDrmREHyheVgCgLhLRBoiQgi/v1SJZsAasJNOhzr+7Y0Rf4xizCI2doFJ0tCfeTQyN6Q54Cj2lziKfAP5Tb+txCpoU/A8U2NfX6jMSBM9K9VU3mCfbCJZJUMKkQBxWUeQCFIB2AYf2+RS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488893; c=relaxed/simple;
	bh=IfPkcwdhCwLlPdy98Fy8391EEMq1s6QRUNRdai6YeTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDbxXS8W407o6WIDA3r74+hRBt/DGVxLgKVi1wOISo+LggS1Z9TCzJ/N7oB2hNjB/TR5MOuYXNDnre+oZw85x68iegS7L1cC65TzmNlALBO6bFJQQuU256AiqYM/SnK09o5zpY83OPVh2NbgPH+CaaJfwfSqrtZ1ZeqBKdTkzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dnjXQKF2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e28ba2d96aso1640251a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728488890; x=1729093690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VuR7zphzwtkTUqZr9LGGHJleCuOU7V1SDZN4yuic54k=;
        b=dnjXQKF2LZdXFJe2w7/dVAki3/c3nBKdfjIOuU/pQFAc1/OJMJO3CFaHRoil4of6Xl
         er90n8RGh2xDRZcwqPHbx7gXoIybYfWQqPIjXZewGuEXyUbGS5xCmpy0QqP884e8MQ0Q
         jnpFcrSj8ceey3lNv9+fLzP+g2EgA4qmQGRrwMfBXKAhGMhUNrRZxMxB6VDeTQnaSAIX
         /FZU9ZJsoLSwAzpu+dFEiXNj+BAEujALqEJf8W3ex3vxMpNGdhELgnR8JvBDN9cdLMqj
         Q5AS+iEafHj0LdmBuc9W5+KvF8VF2eDMyVwzXxkc7xRt/RMB2j//ckD828IQCJaMS98u
         s5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488890; x=1729093690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuR7zphzwtkTUqZr9LGGHJleCuOU7V1SDZN4yuic54k=;
        b=UpzSUwtCI1gzNGOwmaOL/f2x6C3BWEMLDn43GHdIqtCiPLpsh4fR0IlED++uXAnLwJ
         /jVUy2lZ2vigIJ4A+7w0edPrGZt0BZaKAkNTYHyOiKpgcf5mtnlL6PsStpaZ8NQr9tLC
         yjjyi+zklztuQUDXFGvsdHF9RkwLueDQMnfHs4KaChPSreftmuuOhIBqPe1u4fRIgfyr
         tWtyqQ86LcH8uxjsGO0sw5arrKE3b0JQa25LPiOkzu8ZP7QAGoafnbjQiXtfudHY6fc8
         n5fkJXpqAtU5U6aCtbYHfdnwAo9M7UA8Xx91WQdC5ZhRWn4AkmYtpprnaAdeZRHy++x9
         jlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgIuSrvaPWHYgcKKiVVE3b1PRiAfzkhAa0Scq8RT6ZLoUxH+cvYogLrpdNwmqZByGSg7uW1Ktd8Qba83I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesGpRGADuGDcNaElBXorUydGpbdNCsNf9mmh4FjRs16NBnVF5
	WLe09Ok7aieNLHZpYArjwBYkWlk8oUFY2ZXiP8CeZOPkq19qf6dtP7uXkIe9uN0=
X-Google-Smtp-Source: AGHT+IFhB+8emk2XE7uFmSQX3unmTXISUTBHb+C1muZoDZ600jxRkJ6cmVrUS6Qtx0eUc3jBfmiu2Q==
X-Received: by 2002:a17:90b:3a8f:b0:2e2:c406:ec84 with SMTP id 98e67ed59e1d1-2e2c406ed25mr861909a91.38.1728488890541;
        Wed, 09 Oct 2024 08:48:10 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a570bfa6sm1846802a91.27.2024.10.09.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:48:09 -0700 (PDT)
Date: Wed, 9 Oct 2024 21:18:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
Message-ID: <20241009154807.4i5qse7utnqbsoib@vireshk-i7>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org>
 <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
 <CAPDyKFodrKnmFNjqLWfv2AExqkfRo9DRrf7wqB4ht=XwjZDhtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFodrKnmFNjqLWfv2AExqkfRo9DRrf7wqB4ht=XwjZDhtw@mail.gmail.com>

On 09-10-24, 15:55, Ulf Hansson wrote:
> On Thu, 3 Oct 2024 at 09:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 02-10-24, 14:22, Ulf Hansson wrote:
> > >  /**
> > >   * struct opp_config_data - data for set config operations
> > >   * @opp_table: OPP table
> > >   * @flags: OPP config flags
> > > + * @index: The position in the array of required_devs
> > >   *
> > >   * This structure stores the OPP config information for each OPP table
> > >   * configuration by the callers.
> > > @@ -48,6 +49,7 @@ extern struct list_head opp_tables;
> > >  struct opp_config_data {
> > >       struct opp_table *opp_table;
> > >       unsigned int flags;
> > > +     unsigned int index;
> >
> > Maybe name this required_dev_index as well ?
> 
> Sure!
> 
> Did you manage to get some time to look at the other patches in the series yet?

Ahh, they looked okay and most of them were already Acked by me I guess :)

Sorry for the confusion.

-- 
viresh

