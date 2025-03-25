Return-Path: <linux-kernel+bounces-575480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A12BCA702F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5ED97A77B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABEF258CF5;
	Tue, 25 Mar 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ajWv4Ohw"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E642580EB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910989; cv=none; b=EK4Ff0ZTpYK65BgGLkNSWnfKa+VaFtKAZ1ATGLcpDtrBDkDFx8DUd2TOnzi5IjrZ9BgXG79Bn1Lq5fcEP4kEE16rSwPQxJumhK7sW3SCd/0hVUg4Ld7/eaVh3wTi4ed/ocPhQ1GrFfZ2VZliBDJ1LlK7Jwb+vSOLu2oL7Z9prZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910989; c=relaxed/simple;
	bh=A1Q+B2gufMsfREQp5SIVWcC7720Z/T99tr9MbQkNLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHje8+pGzZgFaktWeOqld3fw2sT3BMDMqB2CbYBwEzZzG8IvWqYOZY9y1C3qDCLTCXZqQupbyGDzzuwjCXaKtvFaybLXTd+AcDWPzwGGhknM79cI1D4vBL7ACdauL/bC6UKlKkKu4wv2T9XMyBhiUf24ePW+MoVnJJTGukMgs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ajWv4Ohw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913d129c1aso4057060f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742910985; x=1743515785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UenxoH6KmmrH5CC3OQgIopnnTp23ZO/0n/qWbM1/1zo=;
        b=ajWv4OhwFXIiyIBoxfRqNRV/2qs/SZUnb5D19ez7n8slAjmmQf3L57Wh8xjjywnKPe
         hJxu8GOT3IejCy5pYIqeFokINlrWCk0xex+XUUzEIl+uoLgTmy1NuKGDa554zFCsSvfH
         QPUjhFBtN//YwbfEdRxl1gyB+o7UHTBhe0M3lo8SEmqJpueBk21iQevFgueZueTOTP4k
         cbQDf4WK1eq9VShlE3WHwyDxecsbcI08j5dV/WmOVaCV/nuy0NeA1Sgj0mSzhkG4fH0T
         LZ/qO+FGFT5td1mm2dHhwxlGBiSKDIhroiaEyuVxOlwGY8JqsOSFc4gyr7ZtcNDnznGA
         cbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910985; x=1743515785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UenxoH6KmmrH5CC3OQgIopnnTp23ZO/0n/qWbM1/1zo=;
        b=EUoSgnIyPpfZlZc5Ra8F/zVRQrEDs3l0L8CsSowckCyweGyMOFcZw+GObE4s0sCOrz
         cQLvOcrwb/p76uv59S50/0uhgEXYu7L/0N5rNJow6Y1sgzBk1RhVb1knfh04seQC99/Q
         JU4MoyNOY7oohg8m+y0cmy72OmBNefxAeO9ITw1AZSsXDUNiwjI4RWWsznF0CDkmCtff
         siCUJkEp5/7bx1KgwSUMINEy3tZcjIgR4yQCvphnKZ87JHzabqMnS7VCrX3Tl7jHHclq
         VNvBi1icr/Kn6dAjagZlHJlcWPVB4zQ9vs526HN4HZ4F8Vr7+qtshDaHKgx83YUQ9Zeg
         0OVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ioxciERKQWfRSSthpNQRv/mHyc9c0UOEDG3kcAzSEaVNy6za3E8wMoQBSrASUeB26UyQc3kJdFMqxwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomXyh9CHUFdT6/qV1APUbUFIQAkKpZuWIMPcrF371Z5riC2mZ
	Z6GM4siTqVUOw5CbyRlaF68a1W77FT7MUeLu7lyAJ14U0DvzjQ8uyvu+GY1k5UL+0rj2SrREEab
	M
X-Gm-Gg: ASbGnctFenabmcgvzUTxGRlLmGp/AWiVj2jlUabvftPDiF0bCP22P2127JCCkXDnzP0
	8X6NzRr/pLLReMa8okltnrx32LjP0GWnAu7rgL0VT89Neizjs6dawFXllFy5JoNrOPajSSRPJ3b
	7MQym9rYeZ3BhNfXrkePvpbrAfQ0c08Sb5h/sNEHMhqCsoR/ifnV0xs/mfPqqxm1joZEouY2yNj
	Av+ODxLN9o7Y86jR7jG4Ojnu9SXSZR8eN5nJgj0FN28LHdmr5TxKkSnWoJ4dMTnWl5WR7doPmYK
	72YB5GA85mKRtcZGDdxDkDwu0wVDtAJlDVftr1PN+X9I
X-Google-Smtp-Source: AGHT+IGuP7hdX4oUt/uYmCs7eqmCWfVYFgG4WOsXpx3j+wCi9SZrdUfRY084MJJ+0RZbPCxY7u8W5w==
X-Received: by 2002:a05:6000:188e:b0:390:dec3:2780 with SMTP id ffacd0b85a97d-3997f93c60fmr13164520f8f.24.1742910985169;
        Tue, 25 Mar 2025 06:56:25 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efcb1sm14030721f8f.94.2025.03.25.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:56:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 14:56:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v3 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z-K2B8WMVf36sLcX@pathway.suse.cz>
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>

On Mon 2025-03-24 19:50:17, Filipe Xavier wrote:
> This patchset add ftrace helpers functions and
> add a new test makes sure that ftrace can trace
> a function that was introduced by a livepatch.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

For both patches:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

