Return-Path: <linux-kernel+bounces-244963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2092AC4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D251C21816
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805DB14F9F4;
	Mon,  8 Jul 2024 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kx8czMfD"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4552EAE5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479279; cv=none; b=FhFFeFzc1dUhHe6TXCtLEB6hd/eZVFFR/FYj30enCb0qzTrxjb3KDMJgUB6jktIo5UEtdBpxLY1g7RTANso1IBTuekw5twl7/VdTyvYwIog9XqsYEgTI/m45GEKfhlVgjjytOZrVP0QIIvVnhPIXhscI7D6SG86cIyF8Bz4VfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479279; c=relaxed/simple;
	bh=M1teXtEqzBNMemfd7v+9SUr6KAqOs1d1qIm6KT4egzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8J22uxRf/13ir8EqUVmMZfWe7uypXf4F7/uXJeWZPi+QLwhvRsyKt4ajn7jgqfIFCcnizOPcZ0K+zxDCEY2K551L/liMUCeCEwYlt8/k8IP4lNkwr3Kd8fgEuLdY46H50Jmw9x9XbX9rQsLLIXk8LnXMyXpKWYPyD8R6O5QiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kx8czMfD; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e036eabc97dso4467153276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 15:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720479277; x=1721084077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpMVBXpONIC3Eu1OWrK8ZtjErK/z9AKePwun/fM/jmc=;
        b=Kx8czMfDGVSqQIYq/ZfoRjhcmrUxSwONcn3+IBvhyfjZEDY2ycsvfGrSADkKh09q9z
         7xivVC7bZZIclJe6b46/v4eldCzuBp1jMyRHAYIjXpaRr9HJEB7ZNlNkaBgUkHz5lKX5
         84m0B/y/f9wFrtAFagwc1IBvUSvQFxm33pu2Eyp7Kt4tHeF5tA1zBdHASaj/GhamUhLl
         ghWhKRYUh7HGuveJ1ATJg1UG7t+iJlYkSSHxMKUzO71NzEF4cKZ/iaKu5yPHmvEcrIMh
         lwWvbPm5DPhsDFDf14F92IMzAgvV+SKMCoBZbneohc6hofvh4rCQj0LLpieniDWRIQGl
         tlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720479277; x=1721084077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpMVBXpONIC3Eu1OWrK8ZtjErK/z9AKePwun/fM/jmc=;
        b=TTq8Mx7yiBo2QSV0vth2qrN/Vz7bxiHnryW0RzwSyOsCF80Lnu4SUvKFQTut6ic2q8
         Fa189GS8OQtfLlb+86p0AjGGy7OybPzHNN6FEqTZqIR14kAKRP5WR8olP2NT5zyxZPJ7
         Ho+g2LNcZDemZOTmy9z0hw6wo8JcrB08GbiDTX6fmNfsSEMOV6JSBa8akBZPyijvfprp
         32lxbvB/9aueMgnK/c+KhYisEkUfJm9qq8PfuDal/y6MbD+jkujJPTT+VoW3nvckdQ9+
         QP1O+V+sSzhLT0GVxoX9i4q7IoJaDHhhNxVcV1MVdTbc5NsgQRnVQ6qtFVkq5+/ZZPqH
         aGnw==
X-Gm-Message-State: AOJu0Yzb/TBV19b9qc7HdNt+8fwDTQr3HbkpF4kXrQRy09X37DUiM3ey
	GTGbxtbN1BPRCecxywZdHwXwYUy35yOV7GQClZCNl9VIY5B3+dP63BNH28BQqJarvCL//6Wm6Pq
	v2oDZt/lDeGQmDE+YlulpfmXXjzLY14j54cFPkw==
X-Google-Smtp-Source: AGHT+IHd7gushZ3fFJI6Z5/9daSH7WjN5Kth+2qfzwWNdWdQpkpmbQyT7N11rbO1k5F3rGB/Xbfge+MrIJrcQbxIxgg=
X-Received: by 2002:a25:4cc1:0:b0:dfd:b3bb:ac11 with SMTP id
 3f1490d57ef6-e041b1c2cc4mr1140503276.59.1720479277314; Mon, 08 Jul 2024
 15:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709085238.1fbc301d@canb.auug.org.au>
In-Reply-To: <20240709085238.1fbc301d@canb.auug.org.au>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 9 Jul 2024 01:54:25 +0300
Message-ID: <CAA8EJppPsTniX-0XJ-aX26hzO2GKEF_Y_qAjN3tYhQctfzJOww@mail.gmail.com>
Subject: Re: linux-next: error when fetching the drm-msm-lumag tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Tue, 9 Jul 2024 at 01:52, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Fetching the drm-msm-lumag tree
> (https://gitlab.freedesktop.org/lumag/msm.git#msm-next-lumag) produces
> this error:
>
> fatal: couldn't find remote ref refs/heads/msm-next-lumag

Probably it got removed by gitlab when the MR was merged. I reinstated
the branch. Thanks for the info.

-- 
With best wishes
Dmitry

