Return-Path: <linux-kernel+bounces-510231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF8A31A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8ACB188A3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D7271824;
	Tue, 11 Feb 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLp7Sbyl"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD73BB54
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318286; cv=none; b=F3HnRO/MgGkrwSUD79/a89/2IDF56QeBFFEXVihDf0b7J8UjM3otf90wtAFSNExUt2DY5JziuHJ6ixVJOslBzqJ8wR4KS/Tr9Evi8MUWQQNDr6MhvKAPzCXDbUDIW17OEY90bfElHOQ0r+Cpl7aPUL9VDxNVmUEK707ySiCaS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318286; c=relaxed/simple;
	bh=RE+aHUIVuDPsDQj42j/fwrw4kpBxa9lJz16JhCXTAlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9/qAtuWje/GqfX3s2nqHX05cakOiy7jDDmFi9xz/jx6FGoqfDR9AqYqctSU1jbmvIJyk5DKj9GmBa5Tdr5p0W73HvA/5Y0wtsAnnSWsI0FNwDQm+oUe+Ji/yAg3jAXEpvyXvY6Lpwk81DrgHeSpebXWE7AccHqhMA9ttllbEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLp7Sbyl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54505c79649so3261005e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 15:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739318283; x=1739923083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LX/ULobNxBgRiiE6AfMWm4qglJRxW2bL2STp6gK7uVE=;
        b=yLp7SbylZpV6KkaSft03RvdgKMMDJvCbp1+9KxKl5etNCsfLKcWaKWp6vqobcyoAx4
         0s5SuVB24scHYfL5DRsd8opiUm642VHMw0wFiR20aial2/9DZWNwTSMVYAmQLCNki7jL
         Jpxocb4OXYrDxTr12FjdGB61F5AGXC4BCtCpVw4Ry0VjUOlMondYP+Dt1un41k3mW63W
         BdWiMgN6qxGRO2QvJOxAPbNEbtw23ny7uR4Gy1APWR3DeqJ7IXiENPu/sqn8YnK7tcbr
         IqosVIT6PZ8miakhIlc7rCJ6Onerf/9e2h1Ogt9I3m8D1xIQXzW7KTYN+yMabSuDgZpE
         bbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318283; x=1739923083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX/ULobNxBgRiiE6AfMWm4qglJRxW2bL2STp6gK7uVE=;
        b=c84YxU5XwoF2cqmPjEUVTaiuD4z7m0JJud59dXaGruDyQIuOnTIcL0WMEb51uyE1T+
         T1pH33lCiKGJwaxEthTXqWNggkit5NIKsk7tYe9sT1IBwGuemxDFtrOX+e+Y2VWrklic
         vTGS19L3zH8mIkCgOBntcSxBPfCeiVmcyNT1Ym5AIQ0ccVzNqY1vVwv8CJFAZ4Gx3ycT
         xAYa3nn503EwUbdMY+bUhrbVXNZq2hupsH5TjQ3Y3+WIfgL25OKKXWczHKGWyCg2PZib
         ay1rIYj5NsQ6nKY7X8q0B4IoDRuJdKTQatiA2X3OzfNU3FAmxwIae+Jm+FoglnrmbtnM
         wEKg==
X-Forwarded-Encrypted: i=1; AJvYcCUU6mYgziJ5G1iPAqUSdeKbDxyCU58KkcNNlyit3UMZ+LXkLnni3YlOlatyR46nMbi6a9hrgem5ZjD5AYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3vyNuQmKr8BDeXFH/3+BxV5MRj6LeBzapGmHbbVdaGEA13QF
	6sBtIHYk0v8+mnvkpyqqEZKwYgoX5pelbN8WoGJU1uUh/dLkJBw/QEhE4OU2tWA=
X-Gm-Gg: ASbGncsK8oy5nSY8OfXfuaBDIv8MNDupsPQVKMLDZ3hc61+8PwXe1dFqUJAMD3aXoEr
	ec3H2D+0iEGxHJN+HKRR1uIdrt4kUl1LNT+oMHsu++ydvyJOF/S6IMu15E+Vzqw5YC5Br+/ahMQ
	w6sQgjgttoIxRmEYI45Vb5H7TNPc5Zp7vip0ABZ5B/QMhs4TAY1kT87VirxlHNkCvJMiHFNraEa
	ptf1Um+n/59uvfXLUwHbYlb27NEhYLfvYVuioTdTkI3p/7eJC6WaT31pyaNHSwem9cQ97HqgWOl
	0Z+OHDhBGcUvU5qiyQir9mEkXBVQ11+SqPribodRi2cRXJAJ+76jFoouaZpbZ+3XVo5dMss=
X-Google-Smtp-Source: AGHT+IEZuHKlP0HFN8WiWm/I8ajOzqgUnqFUKxuS5iwuMpASJK2/hwz0WfYOWgwjCMYH+7xZ6hFXEQ==
X-Received: by 2002:a05:6512:124c:b0:545:353:4d46 with SMTP id 2adb3069b0e04-545181148dfmr238228e87.25.1739318282977;
        Tue, 11 Feb 2025 15:58:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54512236ba5sm393771e87.110.2025.02.11.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:58:01 -0800 (PST)
Date: Wed, 12 Feb 2025 01:57:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com, quic_jprakash@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
Message-ID: <sybrfmrpegq7fcqykgsfhm56wjyx5vp6zafqw2d73tiral64aw@hg4di55fzdle>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
 <ojukpywkhu72cimujmijzidf26654g5vkjaj477imcf4suz2o6@cmow62jcqsfz>
 <7a5db383-914c-4c1e-846e-5d68cc6a7765@quicinc.com>
 <fcd718be-fe8a-466f-bd2b-7b75d5f8dd6c@kernel.org>
 <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>

On Tue, Feb 11, 2025 at 12:50:12PM +0100, Krzysztof Kozlowski wrote:
> On 11/02/2025 12:46, Krzysztof Kozlowski wrote:
> > On 11/02/2025 12:15, Satya Priya Kakitapalli wrote:
> >>
> >> On 12/13/2024 2:08 PM, Krzysztof Kozlowski wrote:
> >>> On Thu, Dec 12, 2024 at 09:41:20PM +0530, Satya Priya Kakitapalli wrote:
> >>>> +
> >>>> +required:
> >>>> +  - compatible
> >>>> +  - reg
> >>>> +  - interrupts
> >>>> +  - io-channels
> >>>> +  - io-channel-names
> >>> Binding looks ok, but this wasn't tested due to unneeded dependency.
> >>> Please decouple from dependency, so automation can properly test it.
> >>
> >>
> >> The dependency is needed because this mbg peripheral is present on only 
> >> targets which have GEN3 ADC5, for which the bindings support is added in 
> >> the series [1]
> >>
> >>
> >> [1] 
> >> https://lore.kernel.org/linux-arm-msm/c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com/
> > 
> > Sure. Then this cannot be merged due to resulting test failure.
> > 
> > Please don't post new versions before this can be actually tested and
> > applied.
> 
> Heh, you responded *after two months*, to an old email so even previous
> discussion is gone from my inbox.

Are you responding to your own email?

-- 
With best wishes
Dmitry

