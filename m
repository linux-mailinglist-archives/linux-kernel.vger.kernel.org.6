Return-Path: <linux-kernel+bounces-192310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E57F8D1B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5CE282E57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97FB16D4F0;
	Tue, 28 May 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQJNdWDD"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD073447
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899733; cv=none; b=hMdz8D+/OIcpOHSNOHWO2Od6G+NGnX/bN9gHVzdHtgZTJdJqxKGb53+5WGBLry6KBP9nx+cLK+JRyFgp5pAuSXXVCp3EvDeBjVnaFL68WlF+7u+XP+Pa801oMwKhpAJYPvaHxLJ0Mf4q7qmQ17Z2J4tGzfuoHnn41XTWNcAyhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899733; c=relaxed/simple;
	bh=3v1uBBjooEdyYDyoX1l+q9hwfK+UTKUfPSA7u5ofWpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaRrBumxfJwRw1UHZClQBIJE/93QQqg0aTXs/spOawx2aXNMIz2JJZijeHcxTQhgXdAWrntTOZsqVgQAYAXMXNejFsKy1USwAx1kz3Wqa6VuY9ZefzPYmq4TaiEBmupp1tGe2wn9N093gxvITnF+u3CSgrRNaf8zMUTACfXgASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQJNdWDD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e974862b00so7939311fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716899729; x=1717504529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4yeI+hiJZtf8nSaCr8pjgpkOFaZnhw+Y9CcAkyaECY=;
        b=YQJNdWDD0eAi1zv0uYXjwyCVFc+OQ7bqFbvcf/y38BY36qTZ8M8xpYuEG4OnTjBUh6
         zonGG2n5h0UIfEI9K/VYYqrCYZSvGBUHhzEdoWJbXXkcQ0AHxIJe/tOMlNnHrDPEXkX+
         1AkxRGqliQ6bCSnOX2gwhbb0vdiOpAMWc/rftUTmia59a/6zz1A2ysCXuMz/xIdcckkW
         xjthFq0INPd79U0fHWwY0yp1QvpR+AtXP2RyKE9w7HVftIprijvR2iKo26wfMEjLHnI6
         IetnWmXSe7vo9eLnEvhw0aAKpX8VeeOEbCgXeC9BUOhPek7sAdSZ60hl+jD7jh/7qWsw
         +w3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899729; x=1717504529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4yeI+hiJZtf8nSaCr8pjgpkOFaZnhw+Y9CcAkyaECY=;
        b=DI7tVy2q6Y6gp+1/vWT7CKllICeTTNlxtcfWfT0k8ZgmroEQYILkwG8rdsq7+7ho7W
         lq5rd1IqVeJxneRCbpQ23eAkFGxTZu6WIjCTc++3hMUAGQizJBK1k6Vr7GlvPnRbx/4m
         falxtsT+ujAyrG0Qxx/ATiu07+JMXPm9CZGUpI/2hTErbY502caaU8n5RWINXUQZ+bK4
         uk56qlJdIwP5rxjwBvYYnhhdRQvvUyKeYay8QY83w267cqPSiSjqCXe5zS47v8ZdKbE7
         wH0l0XasJHSW9WAPulzEVM+2UBSkUSPH3kjSYwxEqiFGGlsUQ8WVOAmoFP1MbxW+P1SY
         mBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzQF84MZ5MpMQH8LCnYYlv53r+UG+f1w/dSPhvnU3mgt3HwpsFOwLBTZyryTn3CHo/VFBEESwxEb3CA0y7N928E58lqHP7vm1IWvYz
X-Gm-Message-State: AOJu0YwwPmF2zcxlDrXK5ocHCNBOnR3Aimfz1/ThxXhtdmiwWb6tBnwm
	4GZrlbQMK3AlXmHvS8FdNl3gDiP6DuuEiKkfFokUNB9b9pwh22GgVjwVt0GaLOc=
X-Google-Smtp-Source: AGHT+IGZLrg+HKp0k86HZKCf/NS5ffJjw/FyxYg3/CBLQoLNaKl3qjUbz3O0CChbdOjdbfdldpprBw==
X-Received: by 2002:a2e:88c9:0:b0:2e9:5689:6fde with SMTP id 38308e7fff4ca-2e95b099be2mr74576741fa.14.1716899728811;
        Tue, 28 May 2024 05:35:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bf276f9sm22565901fa.138.2024.05.28.05.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:35:28 -0700 (PDT)
Date: Tue, 28 May 2024 15:35:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com
Subject: Re: [PATCH v2 5/8] misc: fastrpc: Redesign remote heap management
Message-ID: <wfyiq6ova27t46cjvfgp6unxxo4xnlvsqwfg2z46r3k6y6ab2j@cpi73aresacu>
References: <20240528112956.5979-1-quic_ekangupt@quicinc.com>
 <20240528112956.5979-6-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528112956.5979-6-quic_ekangupt@quicinc.com>

On Tue, May 28, 2024 at 04:59:51PM +0530, Ekansh Gupta wrote:
> Current remote heap design comes with problems where all types
> of buffers are getting added to interrupted list and also user
> unmap request is not handled properly. Add changes to maintain
> list in a way that it can be properly managed and used at different
> audio PD specific scenarios.

This description doesn't tell me what was wrong. "not handled properly"
doesn't describe the problem. "properly managed" also isn't a great
description.

> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 221 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 175 insertions(+), 46 deletions(-)


-- 
With best wishes
Dmitry

