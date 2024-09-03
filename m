Return-Path: <linux-kernel+bounces-313186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9793496A1A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D711F23F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D35B18453F;
	Tue,  3 Sep 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6+m8oBg"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F252A1DC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376105; cv=none; b=i7mR/HjVa+eKxDax7jwFOjX2M+omicF0+h7EIoLRSYN6jf2sRwFnrvkZ8Uj7GjB3JPqa+3Fpq37/tEIsIYw2a1Okf7Mb2JwfLmh94g7tVr6lWI3XnlvGc/ymhLvWv3g+XqGoga+NTrbJjNNAE1f/BzL+tp5bp92qOLLr1llvTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376105; c=relaxed/simple;
	bh=+/YB2+Y2RTNoAqkefvNT5hKFDnmavnPCrMBY69xdSg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCetPTEwR6vqj1LPT9hfaxtuywFttEoEKsFBcoulbowynCM958cal+KXWLOI5ysDgiljj2+lSIe5dfQJA94zgI0Lh4NH4FvthLj3OO/iIh5oShZeqoNAMjvfHto7T6J2mPHKsXOEVXRsYZLwAeO6LpdEp6wxD1w0DE/rTs2GthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m6+m8oBg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86e5e9ff05so629189866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725376101; x=1725980901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/YB2+Y2RTNoAqkefvNT5hKFDnmavnPCrMBY69xdSg4=;
        b=m6+m8oBgRGUHVzTFDQveNo2ORC78lzYaMH4jGG4NNGvxqL+D6ABsab3sf6kfVjTprK
         q/6/we1TwOt0Q6KL4SUOcHjxoUicA/c/OUJhj9AUOCAzySREKHbhG9WNe1vRJzqhFDDG
         hi8nt7WcKNvQG04x5/NB1Gnn7PfGHYKZTCUxzE5U85S7gR3bl9a/TBAmSWAzV9NoYhxM
         JMoQ5TBE6wQWgtWMsABkKyL6VE+azLoZ4T9ubbyYYMPWQ+Nw0L16OO0jRSLwrn8b562w
         b20wuSMDySqdmT4n3wKisz0wXFXU2qRrE0TDBiE3DfPEMpA9LyHPN3Zdc7mZ7JLgCJd6
         AqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376101; x=1725980901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/YB2+Y2RTNoAqkefvNT5hKFDnmavnPCrMBY69xdSg4=;
        b=hM32ZnD21JajV+QZJG7fSWrC3tHW+YaGQtO7CvfvAWqMKKCCvuCXcVDdzu9ytT2h9e
         LqWXxr2W7Am23ANuZF3JJOQ15rcyfbCrnHKlUs1//rDPFi2hwKO9eun3JF5ueRh5yBUc
         1VkgSIJoOxsnx9ltak0W/GN9gsbbT8xN1kTK3mbbG3JYdyXneAFMVQcA7Gnz9ystFCeQ
         EtrusWQhUGViQDn7WQgiYM5Pb4KEpqk76HBjjVhh3ooCp4ifBND7zGTUpZVZdp3PgL4U
         hfEX+rpi7aVIgylzpo1SOS2aOS7lalf4ctVcAR58Z6xcibQBEzcPK0LS/qUjujXVt7oy
         wVmg==
X-Forwarded-Encrypted: i=1; AJvYcCWU6NmgKVPISYBvpOKV+UMfnxRqV3R7lxnJjqc3KQXDL4QYIUPVe6SydQDYBGOzOf23h0scH6pLtXBNMgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAjX21nNOVpSCCxRN+/bwUv8W9F8oD43KA5mwNv7jpuvi1T7+
	W453LiYAlr9CbwEbazhEYcpcU5SXeXV3r3Keym8w/Xmzo3J0DuRHHlUPUk1dRKk=
X-Google-Smtp-Source: AGHT+IFdcjzbRsjvKuQu7pSzCjABoL04Be+IgB9GA7AMbTetDo/vMeHHYWeH2GCc9JDbYQ9yzK8+2w==
X-Received: by 2002:a17:907:d90:b0:a86:b504:42ea with SMTP id a640c23a62f3a-a8a32fa1085mr83163866b.45.1725376101351;
        Tue, 03 Sep 2024 08:08:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff0465sm694539766b.29.2024.09.03.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:08:21 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:08:19 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] backlight: 88pm860x_bl: Simplify with scoped for
 each OF child loop
Message-ID: <20240903150819.GF12939@aspen.lan>
References: <20240822062546.3490076-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822062546.3490076-1-ruanjinjie@huawei.com>

On Thu, Aug 22, 2024 at 02:25:46PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

