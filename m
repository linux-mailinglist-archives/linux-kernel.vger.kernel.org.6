Return-Path: <linux-kernel+bounces-251541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C693060C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405891F21D29
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6964013B2AC;
	Sat, 13 Jul 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfZoCWRL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7855FDA5;
	Sat, 13 Jul 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720882604; cv=none; b=qL0q44la4bkaSDNkFpA1HXo+JizqD2uXQKnb8566voIDbOwwBp9eqSv7z3HewRC1UDCNV1LgjDPtXfgankBQygv3F1FfldsnAIibnmC8QrUZRODX2SkiCpFZxUgK9sHYS0L91U1hoG8wNesJE6vPIqUV0y+vOeB83NdoQTrOjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720882604; c=relaxed/simple;
	bh=98Uf/BgNp4xzwikAgzIM1P+vRLZX8/MnC8W/dRNxc10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OipLFHvomug72Dp747IoWy9910e+arNgx8AQJPcscyiq9fJlpIuQpWcRBjyjRoObWQu250GdWYzOCe4kgbB4ij2zoIdMQVYRluUaFIXywIgg4Vb7qC6/rKd73P3GghW6CA10LWyHTwKNzV52UuYXov8SuH3mqotooJ6px+5UxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfZoCWRL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so3149488a12.1;
        Sat, 13 Jul 2024 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720882601; x=1721487401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+QJ0SsewdKDJPXCT3dbpM5KdZdtJLQpdDMM4UU/jY8=;
        b=TfZoCWRLyVoKhXWoONoA9DPgSlVwSGNNHBFhrxS3M8FpkazQgLUSgwyx/A7Zg3qswo
         M2cWAmvNSKaaJHF1jqOL7KhhdQ6Deh3Xpl6wPXbbYFFNepffD4RdVenLyycklytaz/NN
         J5a+TLuj4JCDfHew36WW+rcSJIb1KwsmXkvVHl85Wg761WFJr0VPfPZa0ZHkS9uXkOUS
         B6qRrNbZZ8OZoU+5C7XFHcOYqoWIYGk6sTy+e6+4LXAzBavqWHoCKqTPyf0fUttxt5uG
         LrURdtVTJqelkX5fFPa4pZN/tUmDIfB8Xm2JWM9MdmkO1tyFc1/6TjrgoQBMDbhuHF9o
         bCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720882601; x=1721487401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+QJ0SsewdKDJPXCT3dbpM5KdZdtJLQpdDMM4UU/jY8=;
        b=QpfSX+oSWYsIJZVbSiyq+gsM4rLkhk+UgzAD2plzEf7wBLDiW3UiGGS66Dj3NhAIx3
         z0BoYBi/v6pYqfOtAzwXec+kSwqK5LXt8rht1pweoNMA7G1b1cl7saqmW9lmCrF9DdEG
         8ZLGsNzKKyWZpYsgFkXxGx8b8CAKJJixCChlD9/Frwk8m6GWGby74E1X3+0l9s2R6Jwi
         Sby3n7BmzVp2dtutWgmLqbvIq5W1yl8p4OL0aSD92ha/bpJJdQYdP6wtnQCspQy0OF/+
         hmGDOTC1melKjEqvJhxtaamz9zgixqUiruuLeSZwbSACK8SbM97BUrfnUEgA8XbFtz1z
         iyZw==
X-Forwarded-Encrypted: i=1; AJvYcCVWcF1moB3Etnp264v7Wlyhm7a8SG2ql2CKtsuAW9rCVDohQ442vpDdGUemSmMGAqPiRQktsu6BQzx1Bh5qAnQwmZCwp33A4o+WYQYH2Td/9BwivVT3oP0E7toRF2lzqy5wWbePjcYy0A==
X-Gm-Message-State: AOJu0Ywc1bvaMhfXjFOgVI23SL6yJ/SBmATzRJXZcIXWlf3pm1g42Bty
	2FQdnZEtr+wEmep+aIZEuKgFWBX/jFUvMdOYfT9eu0xK9sszg9o=
X-Google-Smtp-Source: AGHT+IEBrxJbGg84mCAvITBimIZyse3/RhpYf/0B/ael0HmzbuRV66syKLkU7uKd0X4UqYujCyLMsg==
X-Received: by 2002:a50:bb62:0:b0:599:4d6c:d71c with SMTP id 4fb4d7f45d1cf-5994d6cdbffmr2986279a12.40.1720882601102;
        Sat, 13 Jul 2024 07:56:41 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:4389:8fa7:e8f7:707b? ([2a02:810b:f40:4600:4389:8fa7:e8f7:707b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76fefsm860047a12.16.2024.07.13.07.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 07:56:40 -0700 (PDT)
Message-ID: <969642dd-fe5f-4dfd-baac-21e75e30a271@gmail.com>
Date: Sat, 13 Jul 2024 16:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add sdmmc_ext for RK3328
To: Diederik de Haas <didi.debian@cknow.org>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>
References: <20240710132830.14710-1-didi.debian@cknow.org>
 <20240710132830.14710-3-didi.debian@cknow.org>
 <72718d8d02c25993c138567c96340792@manjaro.org> <2735059.JVtD0IzA6d@bagend>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <2735059.JVtD0IzA6d@bagend>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 13.07.24 um 16:35 schrieb Diederik de Haas:
> Hi Dragan,
>
> Thanks for the reviews!
>
> On Saturday, 13 July 2024 15:45:12 CEST Dragan Simic wrote:
>> Looking good to me, cross-referencing the RK3328 TRM and the
>> downstream RK3328 SoC dtsi checks out.  Though, it will remain inert
>> in our codebase, because no supported boards use it, but that's fine,
>> we're still improving the correctness of the RK3328 SoC dtsi.
> Indeed. But it's hard to argue with technically correct ;-)
FWIW: (upstream supported) ROC-RK3328-PC has sdio wifi connected to this
controller.

Alex

> Cheers,
>    Diederik

