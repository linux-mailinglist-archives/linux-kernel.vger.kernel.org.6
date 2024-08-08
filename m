Return-Path: <linux-kernel+bounces-279044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E2294B838
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82CE1C2444E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFA71891A0;
	Thu,  8 Aug 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8jdPorz"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4D184114
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103386; cv=none; b=WFgtpXk84NNALGFjFrHHL5uMbE2W/axh22P1XZcscUQHdmPkOeD2ShigmlQJ6CobouX1Yme20acBHd+FYrtbVlXq0AwJDyyLe8dGcdU1EqrNhABzvcD+1HRl214scH+d3Ovun4WVDrYf11qZCzwfxRJHEZY+2ruYnI7RcSpQGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103386; c=relaxed/simple;
	bh=eRMCGQGyPMzEKe5DbxrFRJMmi8rj1jlg7tNTvlTUMvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgB7RfWsMShyEyrIaCrt83Jr2UrzfRtjt9WjFkPNu0WB4gJE4/mzdb1T1v8F0PvnxzNhIGc5BtWat69GAwTXBgpJtXUjS1OigpuiGsa9BZG6oBlmA89DPBgiJ7zSjMc8wGjxpRnFbUyTTuNdohme9yvN6AcCQM5UuLt7fITufxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8jdPorz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-661d7e68e89so5499327b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 00:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723103383; x=1723708183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eRMCGQGyPMzEKe5DbxrFRJMmi8rj1jlg7tNTvlTUMvU=;
        b=B8jdPorzRd0y5M5KeAXF+/5QB6w3Lat0e1lvMTyhSnkJYoNc6jFN7huQbpaNf39kpk
         Zc8jNR6RRVm3QP/JnmyQElHVxPA2/FG7LpbwLPSeLshqI/Hz8MI6+TGEoEEIQ/IelRS6
         muWj8/liweI2PrYwRkik3KEPEliyqGlCNTVNdUY3SRuxb75OydqrdfOAODXdMaaV+Zsk
         yf0u7OVmhgQUkk4Q7rvip/mJ7I2fa/yfPFAfiowMYnowbcOlUBFAT01uTUHHXA2anikm
         FkEiDt0YkkIyRkQID5p9cF70lmoutjaWQFzUDyKDP/QLJ/3yF3r0xu50PZL+M8GmL/Ey
         vLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723103383; x=1723708183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRMCGQGyPMzEKe5DbxrFRJMmi8rj1jlg7tNTvlTUMvU=;
        b=fNlVl0m1ascjnWz+7bS2ps/0j6y1gqmcBeHTVoYbkpN//YzPTIryI9KhgNqdKutWNQ
         BVQhuc8Mv2dBO/78pbykGDPZLj5oEJXkoScqQ9+ya97U0NfuaQ7AnIsYTGGkwk6uQ2Th
         SYenqVAVzDEo7Wiu7eN40XPWYG6FPpnWmDrxoA3rvDri8jLqQ8rSdFPWiQqIuMzVYYdw
         Ntv4VAPRD4IdyQdhHYZWyXvRbPm8z1iPMzlvEe3XFh6m5BPQeRVmBChEz1RijdSKdZxS
         2HccSeRVVJW47GUI08s15MM/TCdbk3XPwI4CzPnZFmkQyqYE9ZC0LqECagVWl38bUYgj
         glGw==
X-Forwarded-Encrypted: i=1; AJvYcCUa1/XwYakLhQ/1ra/+h0HuaxJGchTg1GU+E8GEi9Ix/FxThqtbYO9KpiEe+QYv/wH4t5C3aiPDJ8u/TBKcc3nXsRzOdPERnr7WGerC
X-Gm-Message-State: AOJu0Yy+8bdT4brqztJoECYe6uFryFBqf/fLR6eb2CgKbstshSla8uBr
	WqLJmpdLoqrljUpCN+71QwZmoxP8rYpMOL9ljEQ7KixK77mr+9fxkIvjU+2xZiNZLec/WybJcO6
	hPmQlFQPouzg1o3/1mLF0S6BmhVrGGYc9eQsN9g==
X-Google-Smtp-Source: AGHT+IFyIUiLZyMQe48633h5dRgjuSDZTU0zmncfIpnawrCmNKHGxrVkYgirf7pL6TeuoZ7Ea4yE3VCGND/RcnmcpDw=
X-Received: by 2002:a05:690c:650d:b0:651:4b29:403c with SMTP id
 00721157ae682-69c0d6c32b1mr5818397b3.2.1723103382998; Thu, 08 Aug 2024
 00:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org> <a3bd82fa-eb27-4a71-96d8-c768b9866bf1@penguintechs.org>
In-Reply-To: <a3bd82fa-eb27-4a71-96d8-c768b9866bf1@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 8 Aug 2024 09:49:32 +0200
Message-ID: <CACMJSet78P5ix7QM=uz2jH21MSNmJ0nVCaeaJFKA6S8T+0R-Eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 21:09, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 7/31/24 8:20 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > QCA6390 can albo be used on non-DT systems so we must not make the power
> > sequencing the only option. Check if the serdev device consumes an OF
> > node. If so: honor the new contract as per the DT bindings. If not: fall
> > back to the previous behavior by falling through to the existing
> > default label.
> >
> > Fixes: 9a15ce685706 ("Bluetooth: qca: use the power sequencer for QCA6390")
> > Reported-by: Wren Turkal <wt@penguintechs.org>
> > Closes: https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Was this commit supposed to have a Tested-by: footer for me?
>

Yes, I sent you an offlist message about it. You added:

+Tested-by: (...)

The leading `+` caused patchwork to omit the tag. Just do:

Tested-by: (...)

next time.

Thanks,
Bartosz

