Return-Path: <linux-kernel+bounces-228431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3D915FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8031B21C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551181459F1;
	Tue, 25 Jun 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPKVLKOd"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA8145A09
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299918; cv=none; b=KEGkl+KNcb+U+fnqxoLMKBiEcTror5cgyR5kPhchNcjLsixL9pT2JDX1tTZVPRtwWHP5LgpaZcV9kgPuNMOHeT0XaLN7mgJEQ2R/Hs0Mp+AOG13saSKIQaqf5HJsyi7rx6+xPlrQhCZqA4Fl6qMdIAlJKTHIWALlWsLIQcHkM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299918; c=relaxed/simple;
	bh=Q9aaqWkdpjzN6oNKqxXIk1Upl4PEiadLzSNkI7yVFv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8LUd/4uQscHIb5IyB+u6NQjcQJRP4ctMTQ7o6wP9kS+ISqpwegteZFZhCOMa7BxxEr2LvCVNOXP5C0u2NfDC6rpcMDhRnHTikMVtZtGOFKb0KWP1fGiwgbqLoNmQ1WDwHGpvktuBMKpYs6gO1v5i576X9xVWbV+Q7inY/f6vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPKVLKOd; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f9a4f9923aso2881094a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719299916; x=1719904716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHh/S8cNaHU04bGjGURJd/BeCLnI4R/2BlT6C5Hhde4=;
        b=aPKVLKOd6KN1LKnfUe7+kmSgBOvDGk7L6DLJaL2aTbKHu94m6xdTSsKkg/fBqDmqua
         uMS0QDm1zghPpfP0ryFZvQmlGB5zSmvw2J6OlEizCFsSLf2M1WZsq9VUJTb7bk0hH3XF
         cUFRLV8oW0dEArmW4h5C235JDIsV3RdgnUeyxSpPyfqh+f9rzhzv5yAo/E2uz9KU1fp+
         nc6UtCbNiQ8ys1onRSFi5N3UOGJXuCEMdztBdwTEdux4IgKpnuesoHPBbdrxO/i9awR1
         BFc9k0+TSDguRYXPvs5iHbAmBVu3w7ENqcj+7vhTaU4SpZwTym8cm0IvvftIbJl3r6i4
         M5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299916; x=1719904716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHh/S8cNaHU04bGjGURJd/BeCLnI4R/2BlT6C5Hhde4=;
        b=hwkVkfh/gqtHWnQqCWCe+PkcKKodz3SbufBZZBu4D8iyYWqbIxvbbpIpNzx251Epxm
         PrrcQTkUjiMaBvNumb8N8ZIUp2xEuYGmLTYY9nzvDKFcDg6DDoQzUqXWdMPSWBNayXXP
         WlA4Mxs89N7XukNiNDLo7fnWJtGtK+soLVBNB+BJot0RJJRYY8tME/hfBcRnnyLxLIHX
         5YGcZ/Xl7F2toZBsk61N7RMG0FfSQTE3IKRZCjd4hb19tHDpagDNm5ZwQWiV036olb+7
         0PhrCj162MiFBI3bmKchBJ49IkFUA0QZXOyBjs18mlvACrxjx5dqJTkO1oSnJ+xCJdKa
         zpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwt93+hO9w/sT2uV8Da6efP6ii49PCJ2rnKbRDeeoRaKPo1eXXU/FE9Oq0eHAg4EmxklcT9VMsCr/Ut49DvthwJAy+MghA3eFIsYNa
X-Gm-Message-State: AOJu0YyzzFxPFo5M+dMoF55MCmUcHCfQ2P5DQpikHHaseInT4i3poz5p
	GC8PXIncovIIKdRtIzF1lPaa1gkVklrkP66Vf6dFtMfWqR4o45czLvqzjj0CP5E=
X-Google-Smtp-Source: AGHT+IFJP2Y5fe1lv0CnAImMG19RMAXOmGCb/Qw0VT9HgcFIG6KLeaCD3KKMlw7qfAX/uV1m95oM9Q==
X-Received: by 2002:a05:6870:638c:b0:259:89a5:440d with SMTP id 586e51a60fabf-25cfce010dcmr7970832fac.15.1719299916103;
        Tue, 25 Jun 2024 00:18:36 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069b36b540sm520256b3a.66.2024.06.25.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:18:35 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:48:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bryan Brattlof <bb@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 0/5] Update OPP table and add entries for AM62Ax &
 AM62Px SoCs
Message-ID: <20240625071833.lbtkcu6ubcxsyts2@vireshk-i7>
References: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>

On 21-06-24, 11:39, Bryan Brattlof wrote:
> Hello Everyone
> 
> This series starts off the process of updating the OPP decoding tables 
> to align with the new speed grade schemes for TI's AM62Ax and AM62Px SoC 
> families.
> 
> Following this update is the updated binding and the OPPv2 entries we 
> will be using for the SoC including the 1.4GHz frequency for our 
> reference boards when the VDD_CORE allows.

> Bryan Brattlof (5):
>       cpufreq: ti: update OPP table for AM62Ax SoCs
>       cpufreq: ti: update OPP table for AM62Px SoCs

Applied above patches. Thanks.

-- 
viresh

