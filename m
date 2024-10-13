Return-Path: <linux-kernel+bounces-362796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6899B95B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A3DB212CC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9536C13FD86;
	Sun, 13 Oct 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSI9vy53"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7113AD2F
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728822087; cv=none; b=JaolvccTuGMmRJpX/4Spd9Bbg9t2EnwYILBl7fxQSDhAvIMtphMjGAZSrEFCfRKh7Maop3dXtlpUJ/sarmt3ml7bSbfIffeJSQFT66J+KZdC8Qz1ncBqYzEl/VmYFBM8GaVwWUnfExG+AVOoZQFaQP9fXBjyPSkcAQ8I3IcKEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728822087; c=relaxed/simple;
	bh=q+75GZfgqCTSngT1o86/FOgcbVTQ54B8Ve4TR4ZuSP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MydWNTa70dVGDzf7xcz2gEu4IPoz5fn9zioqe4uQDAUIZ1hEnrTg6LynMXHh+UkChBEbDrYHzOo81clv8XQ3uh9DRw7WJvOQwVuCpIwY1vRfepy0182qKoCEviHnCxQuNnfF45cKsX6Z4WsXL9TLGoahWpYRgBd4D1B2lZ+DHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSI9vy53; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so2823773a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728822082; x=1729426882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+75GZfgqCTSngT1o86/FOgcbVTQ54B8Ve4TR4ZuSP0=;
        b=qSI9vy5399ExjqULSNZtJpMbMKMnI0lg6CPcbqxiCAyDNbXMBlkqmD1gJYsaLLSPMl
         cKXiN6GwYamcCxLtRwO9k42OTZ75TDqyQQDMAMQep26kjNCaDNO4BF6lKr54tEof9I3Z
         V5IleroIfcPPUB/DYFOEiLQDQ57jz8qfeHB+1mpyerjLJdujxfa24CE/yZ46fYzgKtdm
         s14xtq9O8zM3pNQBCChROPyjAS77HQpJBM3sJ9KkC9J78JYK84Zpp+nibgvVbX3MNNRU
         FLv7+1Mr9hprYB9+XzxATdInuldGkpDwSMToeSGWNPrOp4W+uwVR6wtl9L1T+T1BvPrV
         +3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728822082; x=1729426882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+75GZfgqCTSngT1o86/FOgcbVTQ54B8Ve4TR4ZuSP0=;
        b=jvfckfep4Rt0scFtAtyyvwGmxyxUNKGAQYiV9PXnfa92PYJvnbykfwW8MMx5NSlP+B
         GYs9qQhkeQ7SVkHpDVnIqclOyqR/2wdqKNkmAlH8AbtGDhOgsJeqF19k+cyLb8CiZyyP
         Teo7UZjjB8XJo4z+sfOoT3zoSeqhbebt2UVsdwUO4HLvFV8K2wXSRh4srw5o2qatvCCp
         YKaY3dYkRymI/lhyRDMKiI+IOjZpkLxKJ0aCT3QsWcb6cUB4UdO8+u7v/Q/DQVvgdbYS
         vgNxHDQuW6XhraWeBDEp/xHJO5u49Zo4MiFceRXT0s6/+Kx7P7hFf0Gp7JYJUTuIwVB4
         ghPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUaYNEnZN36BDrCwhkdiuZhl7ELTQ/p3VGi88s1z4s6jwg4dLFXlJ2VQygFJ8tuFOP1rvtkq8eUf8cvDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDFH0YTRHYxrubi5JMhl5x8Fqy2Uw3Ehj7bZcq86busCP/o+P
	B13eBe/+PU73jAVdhkloYegodYGzdvxn4A1ga+5AYNavWS+yyHCMtFFkJ8Pv4aM=
X-Google-Smtp-Source: AGHT+IHwnAL9xXNdFniy9d7/1k/UksIia33BwEpaaf5KGVD17AwvwJ1zNUNytvvKW5zXwkRvyM6o3A==
X-Received: by 2002:a17:907:3da3:b0:a99:742c:5b5 with SMTP id a640c23a62f3a-a99e3b20d4amr575334866b.13.1728822082533;
        Sun, 13 Oct 2024 05:21:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0e80050bsm7152066b.185.2024.10.13.05.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 05:21:22 -0700 (PDT)
Date: Sun, 13 Oct 2024 15:21:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v4 0/6] staging: vchiq: Lower indentation at various
Message-ID: <fcc69d9a-ebcf-4d74-affb-b08f07b7b081@stanley.mountain>
References: <20241013112128.397249-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013112128.397249-1-umang.jain@ideasonboard.com>

LGTM.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


