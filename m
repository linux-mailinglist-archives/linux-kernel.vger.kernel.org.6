Return-Path: <linux-kernel+bounces-207721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6930901AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDB71F21C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E88A125DB;
	Mon, 10 Jun 2024 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDzeewiR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400F10A22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999691; cv=none; b=D9MTFEdz6ezUZ0WTG4qSPxLtsJFxtBOkAnq3TsvlrBOJS1SHjFMmKD9yDqi77oLGLNF4Y8fIhTnvLrJJ2eZFjBhLEEU/e/Dm9anVlqviLeR1u+UeHfda/gjanA7Rug28pnD7ELEZuCK7cDIobyvQeOQxB0sKjU5tgQ2uw0llVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999691; c=relaxed/simple;
	bh=5CmpMQ5KRNxApdYrHcBMYUq10a/yj5KAKMjMhnTxKY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYi8qTQTIERY0nO79QbpifVhG2q2pqSVdPrlsatsYhOncDRJxIVX5bLAo/2DKMpNdl4Minre8DpiSr6rlby8aJyF0urMAnfNpgT4qeVSpmuaXx8NDWwrsiPmLoqMtMvV26kYeW7IcK1QB4OiH/FaYCmpIabebnnm/YU4UoFyRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDzeewiR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so23579055e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717999688; x=1718604488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/J87sE5WWCxANMtnNec2a7KoufmyUGsipNDanWepiQ=;
        b=CDzeewiRJzeiT3OPvXhe5IjyYKf51tll36d1S6yz02QWAYDiELCL2G0anncQFnJ6T1
         6goITBf1pn3cRazbTBIuq+xHxgqKIZDCgfVA/jFWhd1HYzssAqnTC/tfdEzacJRLN6/H
         Z6np+ihT2HyvTWFQtHBNOFkdnJRjrBri8DVlPQ5YKPlphbqBNAHfM7EAQZFpAQvMGe6H
         BUBCkiN2rrbSamXNQ2HzN6OaxJVP79bCW2qxqGwapeXP8m8OdOR3b89hz/btlJrw9oYS
         La58m5Z7yTHkwnMZ/ItcUF0EDXcDNU5CSDgMntY8ZihUBpPDmOnaCKjygmeyqnn+AI+t
         Q0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717999688; x=1718604488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/J87sE5WWCxANMtnNec2a7KoufmyUGsipNDanWepiQ=;
        b=X3eTE/M+mD02iUR6qM9+MuKywyuIS3vyOUQrkpVwuw8d63Ca+Asbc2cEBun4QZkw+b
         wNG7tlENPm09cyWPZSdTLk+FLGKEAXdyrnoviwPjjuyd2IEPmqI33r275X7vjiWwX8qh
         OUs4uITCb1oc5XX1modg5RwABuYznDeMoQHgBY/Fe5sGEqM5nNdE9I9XgjQW/qvBw4bg
         V1mRa/AmORQ7DoXEoNwA4HXul0QP4twz/HJpDcPG+Rh8Z/vDHXDlEvm4zoMa3UJFD3Ht
         mDmFiap3dZVro4+3gqsjQBGpVH52UcB+sfjOcpANcErA2r1mGZWtnNA5XVpLfzhS/D4S
         0uUw==
X-Forwarded-Encrypted: i=1; AJvYcCVEgy8m/nGw8XltLvPaHJbnwmi+7xvZfCXs7M3o9z9zEJSQbsMY4krdLCqOEeEmgs/FMINUz/DuB42pcTccvJBebInO2kyhvMKr3WZa
X-Gm-Message-State: AOJu0YxZmQ/OMYPdSpIyAfoKORBKonQUSy/pKW6FPKilPlVkJ3CLpk0Z
	0YAAfyP1uyrnQFRxqI6BHnwp5MIUNtkuo/UiWwgwP6Dltxy+rKMrwhQnPaqsZTk=
X-Google-Smtp-Source: AGHT+IGzRdIwGC7ZVECSHelhkNw1xi169Id85SkAxS+xVHhRG655lnQ9cAHpX+PeqgP1/dH1IQAdLw==
X-Received: by 2002:a05:600c:4f4a:b0:421:20df:c6d7 with SMTP id 5b1f17b1804b1-421649f0744mr86433385e9.4.1717999688003;
        Sun, 09 Jun 2024 23:08:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0bdce051sm7008759f8f.75.2024.06.09.23.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:08:07 -0700 (PDT)
Date: Mon, 10 Jun 2024 09:08:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/24] Staging: rtl8192e: Rename variable bforced_tx20Mhz
Message-ID: <5ccfa433-f1be-45f6-9138-348cb4093866@moroto.mountain>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
 <20240610054449.71316-10-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610054449.71316-10-tdavies@darkphysics.net>

On Sun, Jun 09, 2024 at 10:44:34PM -0700, Tree Davies wrote:
> Rename variable bforced_tx20Mhz to forced_tx_20mhz
> to fix checkpatch warning Avoid CamelCase.

The correct capitalization for megahertz is MHz.  So the original is
wrong but the new name is not correct either.

regards,
dan carpenter


