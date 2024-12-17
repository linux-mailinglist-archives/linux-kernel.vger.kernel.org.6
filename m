Return-Path: <linux-kernel+bounces-449851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE49F56EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D9188EB01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A91F893A;
	Tue, 17 Dec 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4cQJhPXr"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48B1F1917
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464123; cv=none; b=kmGHqi1TdQrRnTpXwHPCMRk3fJL/Ff7ueRDg12A8sF6fKfvMcsrFJHaVfa+Woznd8AtkjbYlrysOB6/4RNInFoes2TpIaG+QxTYInyWAY9J0/f3f1+/biqnAkVdcqgE789Bv+BiLZyjE4L35qGsUOvcnaQgH1f1G/sK6kTxHxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464123; c=relaxed/simple;
	bh=MAG1Msz1RJNFqDQ+TyGKHCIsJ1GRGB91HTUjVnzbwtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5v0XD2pllxp7Hjki52zRIdExdbvhlTuM5aGPGpnVUFtu1HomQA46BLjtbtS60Pe+y86/nnCIG7qlQIZWvoXKisE7iQ9Fhq4vFr1jq5xiSwygiD4qv3OU7zp99HyCQeszKUohCiilPB/7wX8sbk87OUVPKsOTHey5KeltSypNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4cQJhPXr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725e71a11f7so25441b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734464120; x=1735068920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d87CX4sPJ2SFFT7xE3ytRCoiviKYTjk0B5BoSWiSUsE=;
        b=4cQJhPXrpJe58n/CjRoHVGjDetK2iO+37Whs8UaDogxGRSzlWm0K8xdMLkfZMeCuwH
         0aMpeelDbFKy2QFyov9XNiB6P9RwZu/Uk5IVnjfKAV65prVEEUNamf4qZsmW2qPGMzJg
         enEuqxucuQsNcL2AqdBLvMaHEBIl+luknt6VMeYoCL0g7+ahTo1ZvUr/7ZSVs5eH/kx2
         4k5YEd3FOcjGtK92C1jsQLR81Il6tBMEbZ/ekemXuFEsm/UT1q9jhnBsfvACceFiL0aQ
         05kbzaE4cTZTEed2H4E1Xf3Mh8zJYk3eor4+xHNu0oV8FOSgLEpvafhKGxaq1Bm3jXnL
         C6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464120; x=1735068920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d87CX4sPJ2SFFT7xE3ytRCoiviKYTjk0B5BoSWiSUsE=;
        b=J58c4KlITzeEo0SzqB2QcJNXAfmI2IDE+YDoSAdwKab3+2n85fNTzJFLIe986CpUa8
         9Nk8Bn/7hK/0RA5tINReCv9gj0/v3j33DOd2rw/Ni8b2B7XWFqrTcGTzRlnROeg+bupO
         KuMwmKcTAXjXb3gqsQof4Wg/a5YiAkzONKi7E7FH3Wzn6elObz8ORA7BHjnGrsfuFul0
         5Qi1ZYGYioyWf0LqCTrbaxGzicd0v+oZ2bpTUnoL7Y4vECBmVKQn4a6fISVUZrIl18To
         YRrKs5XyUYJsAdyWUqikmfc9AmaPVlQ1KZVjGFbx4eAFePdhIbA7jDpmYhFCebx/z9jh
         Vkcw==
X-Forwarded-Encrypted: i=1; AJvYcCWT/zoZ36y1uFDWWktr7gB6zY+NDEZJC4heeF13Z3S9NLYmTSKAFNB5GUFH/BVZQcUlIYn+4nb22mkwPsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7h2Ia7RYo7Q2BRYik93WHU00qz2YYKgjlGtwYBHJ+rhcwTZx
	w92u43MXfTDezM95IbnePuNClAAA60WwPyjQI17kSPpzWC4q3PldJdK+sFFkVQ==
X-Gm-Gg: ASbGnctV46TR0h67wP3wQeaENlcM2dxPFRSJdpVGqyHi7hi8BxYVp9I6dnkHIUAv0OA
	m00H+vgixBhih4qV+VBdkUga230xvr8ZKz7y9CCNNrGEIeoauSyZUvqHz6cXEEDKwOe2xnPmQfG
	CNm2m02xOahvnBailoQ0EqADMFug+OsMgLYQ3Hg31RtZocqydZ/FTlOU1dVy2s91IvJh3uChUTt
	Lq2gMgtvdOoyzRAF276Bn8Ch6ZNGvFPF3G0QrDp7a8pFBGjvYu4LCBWzmRVv0PirzGAzl9ZQhDk
	XcBtNBFLH6KnNdKM1kXVTyEc
X-Google-Smtp-Source: AGHT+IGYtQ+zUFnfNfiNRBX/1cbObzVwvveviWhy/ECfWtAB1ZGYKXCWjAdhChwSqe5/tliuvTSNgQ==
X-Received: by 2002:a05:6a21:9010:b0:1e0:d3e9:1f8 with SMTP id adf61e73a8af0-1e5b57f435amr24707637.10.1734464119628;
        Tue, 17 Dec 2024 11:35:19 -0800 (PST)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac53fesm7002639b3a.30.2024.12.17.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:35:19 -0800 (PST)
Date: Tue, 17 Dec 2024 11:35:16 -0800
From: William McVicker <willmcvicker@google.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] mfd: syscon: Fix race in device_node_get_regmap()
Message-ID: <Z2HSdK0wwaHXEWMJ@google.com>
References: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
 <20241217-syscon-fixes-v2-1-4f56d750541d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-syscon-fixes-v2-1-4f56d750541d@kernel.org>

On 12/17/2024, Rob Herring (Arm) wrote:
> It is possible for multiple, simultaneous callers calling
> device_node_get_regmap() with the same node to fail to find an entry in
> the syscon_list. There is a period of time while the first caller is
> calling of_syscon_register() that subsequent callers also fail to find
> an entry in the syscon_list and then call of_syscon_register() a second
> time.
> 
> Fix this by keeping the lock held until after of_syscon_register()
> completes and adds the node to syscon_list. Convert the spinlock to a
> mutex as many of the functions called in of_syscon_register() such as
> kzalloc() and of_clk_get() may sleep.
> 
> Fixes: bdb0066df96e ("mfd: syscon: Decouple syscon interface from platform devices")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

I verified this works on my Pixel 6. Thanks!

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

