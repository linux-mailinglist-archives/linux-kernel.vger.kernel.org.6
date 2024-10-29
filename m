Return-Path: <linux-kernel+bounces-386374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C219B4299
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CD283969
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C031201278;
	Tue, 29 Oct 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsCVp205"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2E28E7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184804; cv=none; b=fvbXb61e46WtixAUKbNlW+Ovh5GFJXt3jVjAbjx7HmxX2zEa00Y2yCwdijhex7BKffgZK11x3Y8eClZSDnCxcZEkR2J6o47IR+IHmgviS+zoNCTfvNluqR4RictgtPCzE08Gj1KE0mgmmQkuSKeX7AguhDmFs/FtxwC2SvHO8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184804; c=relaxed/simple;
	bh=VI5gBCWScORZmQ5M5JKICCGe/z8Tu5nvu1z/DGuqTYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMYW8ZH1QJvUAzW7uDobIo0e6DXisIHnulxwq+E4EV9qOwK+IGbO6lu4AfIAo0KUj9gNMysmMU9cpDJ/m9t878UXJbpS09e3etejdkdGW1D+FddK9Ks/PSH0gfGeaBLlVY4/RAQfvuBpN/aYMiBa6HXgfWJ0TDQHmC1420FrIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsCVp205; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso4103857a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730184802; x=1730789602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxdqxmWJXdXU8AUeRm4skNzTB6cELoVffMjUmz4VZV4=;
        b=TsCVp205Z2Rx58O5LNpZUuxsBJqxEYmRVNvrPr05GsIT1URTAfMgYQMYAEKnbzqUGR
         yajxuID98PopypqyNE4CEFYQD8hTAUi2jV4fay16BNghfISNCYSMVfblB8bDOnrcAKI+
         nGQ59tbKZbptMj2c6gimilCedT+Cj+tkMpFKZPwwx9+OFdj5IhX1iqyULBaaP09tm0+n
         MwlMYNWfuGxHxouJHNjdluosOiPy9L8SbbFjV1FnC/bLROYaSZwew/NL3kr6S/7Z8+Qw
         9xji6NMUiCEcBHTRJaDix1z6b6Oui5lgzyuSZlz0mWLToRDAkCOazRLMb6yl0XIdwN0S
         R4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730184802; x=1730789602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxdqxmWJXdXU8AUeRm4skNzTB6cELoVffMjUmz4VZV4=;
        b=XMpPRVSBuIkEo4ugeyQOUKgsgjipbvmk3DJM++IIlUJWg4Hx/iwErWuTiy3PzvT3+v
         eC+uCV6/xt5Egd0Od5Z+fe75pe5K79SRFG47BNhL7JMlMttaPSw5XfOgdZHSVFkRVc62
         cpVdIcvDtfEx8qahuRmCdgCvvvBqaR3LK+vBTdggk6e3ZCXWaPntuUETPKqvHC85IDrR
         VI30HD+tJr6447cCy8qv5n7kc7bQzolf8d5ZbJwugFsNTIly7YAa+9heBlBVhorM296V
         dnozpG9fIDnFjjYSxzco80spX8f4HevLv1wRqmGJC6ID9gKsgkcv7fnr9rfcCOc0PlMk
         Hyhg==
X-Forwarded-Encrypted: i=1; AJvYcCUnhBDa03B43i8c/zdCVHXOQP+DytcjY46sTGfVTjlQd2+dYHRhOKLNlAI2E+VkRGtbjb/ac3KmIbisvdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1ugh/IJQeHL0WhSqMQw0ejDEZhzLacyyeARXHZPz1+ybnu4i
	bEWD2lqMbfemWOatt724+WiRIVJjn0KACBt3EpsyD03mEEyOQWl564gsM9I7elU=
X-Google-Smtp-Source: AGHT+IFmnh6BfWm9u00lcdmwhUncv3sqpOQIn0HAENF9MSk8JtP1yLm3zPeUH5AL8E7LPGeuXgJA4A==
X-Received: by 2002:a05:6a21:3a4a:b0:1d9:1d2d:b656 with SMTP id adf61e73a8af0-1d9a83d9f36mr13743238637.15.1730184801978;
        Mon, 28 Oct 2024 23:53:21 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921daasm6909172b3a.37.2024.10.28.23.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:53:21 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:23:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, rafael@kernel.org,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, linux-tegra <linux-tegra@vger.kernel.org>,
	Bibek Basu <bbasu@nvidia.com>
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
Message-ID: <20241029065319.zto3wlvceec3fjym@vireshk-i7>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
 <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
 <Zwe1p0La_AFknglf@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwe1p0La_AFknglf@arm.com>

On 10-10-24, 13:08, Beata Michalska wrote:
> That is a fair point but I am not entirely convinced using '0' instead makes
> things any more clearer as this is in no way a valid CPU frequency.
> As long as we document the expected behaviour keeping the interface well
> defined,  both options should be fine I guess.
> 
> @Viresh: what is your opinion on that one ?

Failing to get frequency for the CPU shouldn't be represented by 0,
even if it is confusing for the user.

-- 
viresh

