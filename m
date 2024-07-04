Return-Path: <linux-kernel+bounces-240456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54936926DED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD71C210E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567DA1AAA5;
	Thu,  4 Jul 2024 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkYGQFrH"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088817BAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062604; cv=none; b=T6owuV9lCouzHjcLjm+p/aD9zrfVC2sGGI/KjIo10s3jd6al5+zvsM7o0HcexKWtwP5ioZLtOrV07RuhAYAeMg7yYvjIqTm0mnQwUl1RvkY+y3OedjJUXpRt+baCYEd/E414g8JfuKYmZbzxm0HBQvA0ZKt13A6oezHvVgIwYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062604; c=relaxed/simple;
	bh=hki5iIMFNHbEsD/tTBvMKBYYVumg2clu5AcP3fU06G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxxhWdFIc5wlfx15360VaKJiCzhGvYIUpEXZWS6vWdL91t1S90aIpTx8QSqow7K3L+cTj+ytFWMDtcAiGz/gIkgvEn2k13djDPV4S8wU79bS4u8G45B+FFkJoKiTBgP7V5JtlWfls+xZqRZ+hArT71vEEvxtThRxF3f2wrqaQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CkYGQFrH; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d55e2e0327so112454b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720062602; x=1720667402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25KnsUopkysIBr2uTdSPXmQMFBU4Udb2z4yjgTYdwpg=;
        b=CkYGQFrHCowQP9HH4dZm4c6g7kGCkPkFLSJbNhqqydDFhgxCfurQTUDJ4BMOQzH9mF
         HZkgzF+jOR8SqX2kUtQ3r3OaKols+y3gk+6FTEoL132g1D/eLT/4bRaCGF0hz9Uq2M/v
         GNijpJUu+H1reiPhw5Ds5r33SO90Y+i88M67GwJEtLO8G6xsBMjlIh+j6RnnGmR83ijB
         Nipb8jaFUjaDCu1u6e2feauQPCNVa471rMgeuYFkc/kuocPFnOeKXfomSksqmivpcnAC
         29bT3S9bPZeZP3uS0Q9ILBOyEpeGVQ0e8/XtR5doeHiGQ/dUBNk5efsfD4FiI/7RAzes
         r5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062602; x=1720667402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25KnsUopkysIBr2uTdSPXmQMFBU4Udb2z4yjgTYdwpg=;
        b=ZYJ7HRHa/vJVBsCA1YSY5iYF/DuwAU7+Jx+7itMjP8C3WCUzY5MFsr4uvlepQRPJJo
         2yvQrxVotfan1COS2u3v7ZmZXN9+4QMGLKCU0DLChcd7ocGfRCdWmRye3HHZ7ue2cWXy
         jrGJ+R7udtJwWsmnfd0bQN/U09gvFmXsD5foD5WVAdA/rtX8DrD0wdmkJvC+RGMT9pTx
         zTew8eeE9I1cNzghr3iBg36mOIjzUYlaPs4FzF0oC7VUtcDY9SNW6gixslDDsEF8VN3g
         TnOQ6B8vb1cdAAI1ue+cPdTlwvq6yAPilNXeXrawuCQGD/w771WOWesdKIq1nSv+2efA
         kQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8NFlXrE0C4gOlnGoodOkrlCxZBCA7y2AjSxjVcy3jyIo+kNR+LSgUKCNXcHSIzXcDwIctIkCe7OmuUh7/7nJ2VZP0m9EwX3xd51nk
X-Gm-Message-State: AOJu0YxLZwvY2wEBumkRVT513f0RHmCDGy7uPETrbHCUuu6APShwCnrB
	BOrl4wYsYx4v6pwTZaN6k1nVUy2apEuNiTXUM42OZyrgAtAnuMju4rz2pZsgAeY=
X-Google-Smtp-Source: AGHT+IEihQyj4XFSMtMz5vsZU/RQnANpLyNp++2hhEn7OAX/jkTUQw8/zL/gyOLuMPNkWsj4ueRh5w==
X-Received: by 2002:a54:4888:0:b0:3d5:5bd4:75f6 with SMTP id 5614622812f47-3d914eb1089mr411097b6e.55.1720062601232;
        Wed, 03 Jul 2024 20:10:01 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d41655fsm8773138a12.92.2024.07.03.20.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 20:10:00 -0700 (PDT)
Date: Thu, 4 Jul 2024 08:39:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240704030958.h2m4t7qgk3sp33tn@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
 <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
 <d6994f56-57dc-4a66-ad7d-1daa04788b22@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6994f56-57dc-4a66-ad7d-1daa04788b22@collabora.com>

On 03-07-24, 14:43, AngeloGioacchino Del Regno wrote:
> Yes it will, but `ret = dev_err_probe(dev, -ENOMEM, "...")` is still kind of a
> shortcut, as that will effectively assign -ENOMEM to ret, so that the error is
> still returned like before ;-)

Ahh, my bad. I missed that you are assigning `ret` again.

-- 
viresh

