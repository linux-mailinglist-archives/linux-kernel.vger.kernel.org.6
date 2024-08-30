Return-Path: <linux-kernel+bounces-308629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC7965FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2778D1C23877
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2909192D7A;
	Fri, 30 Aug 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGVXmE+1"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61401190074
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015385; cv=none; b=krDXQiF96uQj1L9pf7kvB/gK0GYU7TrzTcjhjWSkxqrXGTq67V+tLReq7WRqGh2WnF5GJ0u7mJVuBlim8kCm/O0TIdvI0Hrgtj7kB2eaxcLAoM9u7lwV2vcw9gW8Cqw3x91tXALjNdGicABC7gKXjsmP4zN6SOa1ryZpizlkW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015385; c=relaxed/simple;
	bh=0yNkwl+K5/f2VBOn0wh/xwNfO68u56iaPDTBCQB+eAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9lzefoCU66y48A8NWW5hDkA4lcOC1KbwxRmive66+5bizPO5EwIa33vgkF2JmERJhBtmall4dAmJVsuOnchNU9/BGHk9nsLlXbuO6EKCZbdHAjqX3YilZ5wR4ILkMBqtHHqe8aPPvlPa3Ya04udvxIqGuB85VxOOQjBRiLl2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGVXmE+1; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5343e75c642so2153854e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725015381; x=1725620181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gKyKcoJ3TdGstuho5BLbj3dZPw1dj82Fy+eFXEsXQM=;
        b=xGVXmE+1pE+9jg7cyDn3RqoS9NbP3TyjTQXw5VuoMLjKHAFPF3AgtIo9LQTeeWtpTx
         vJZiAPDn35JxD5oRpOyAQu7S5Gzt6sQWboITPGUkbFTPqf5vCxFRjzP2bSXtxWwaJK4c
         +GWpGiDWNBhrO+Vjq/bUSax0d5zYUjpaWBGmqNN//5jV9KPqNbBIK8IpJCapYZ+/qguI
         HkLsONC6n0r4/S1F/Z4qZvR5CZoy9W5wEOkjF8gY+zem3rvxs67WzAt8bI95Qn1PXh8p
         pKXaggt42Aj3Dtda6E2yh4iXc3U1hJoyJxfJ0XnG69fYECp6PbpU7edDaMp/vzQYFuOo
         QS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015381; x=1725620181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gKyKcoJ3TdGstuho5BLbj3dZPw1dj82Fy+eFXEsXQM=;
        b=BnLsN2lUvBVeWLBWHmHTm0Q+A6cUD/0IIImmgs5sMeVOwjSBQzo7kkaEEC7m6hmy/t
         maIQ+43flTlxsL3HOYI8MLfvAX/mYaeFUSCTI4ANz9DoB9Kv2yLVNKQEFSkZppMLunFb
         j7dO53nZQ/ygkyWmn9KHhMcTiBOepCtvdGVah/7Rmp5FO9vO/WUrQ6+E8vypRggdKFzZ
         soxnlNipPmMKRyI6oM22Y7EQea6tzGaJ1EMYYXvoX6dlp8MpCE3TD213PwmcZKo7mxIk
         8oa7YrkvHSGYeRT71k1xP8b0u6HghztCfFemRwEEgLKRVeANArhZHrkt0QnNwqyASfUB
         HJCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBgBBnn79rP9jbCc2BjpTtKDp5PkH4EVTyDHeyk5bsYzfJNrAyGw0u9n2R9Gx9IetcZI1hBN6fuNm83lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOzTKGYvL/0fpRq0she1oehHmZ2yc6XoJOU/oAIaeGtzwBvBv
	+lMVIMs9/UMhZaSyC8gEGPxzMUZ5UaLyEhIG43ARyDWqxKA6uwCSQKH8qb3iemY=
X-Google-Smtp-Source: AGHT+IFhQ6PoGmrOUr14jdbBRUr38XMXRb64j/1OyzzvHshRezk/QL3UWUvUtUOcTCJicKZk+oUx6A==
X-Received: by 2002:a05:6512:2309:b0:52e:98f6:c21f with SMTP id 2adb3069b0e04-53546b0b111mr1274057e87.16.1725015380724;
        Fri, 30 Aug 2024 03:56:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827a11sm545340e87.162.2024.08.30.03.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:56:20 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:56:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: srinivas.kandagatla@linaro.org, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, amit.pundir@linaro.org
Subject: Re: [PATCH v2] ASoC: codecs: lpass-va-macro: set the default codec
 version for sm8250
Message-ID: <7tzmorkxuaiztz4vabjvfclv6s5vu2dtlfd6vzlnz66jhg6y2p@msgesiuficec>
References: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
 <0fcd3421-8086-44bc-b24f-7fb2262a675c@nexus-software.ie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fcd3421-8086-44bc-b24f-7fb2262a675c@nexus-software.ie>

On Fri, Aug 30, 2024 at 09:37:39AM GMT, Bryan O'Donoghue wrote:
> On 16/08/2024 10:12, srinivas.kandagatla@linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > sm8250 and sc7280 have lpass codec version 1.0, as these are very old
> > platforms, they do not have a reliable way to get the codec version
> > from core_id registers.
> > 
> > On codec versions below 2.0, even though the core_id registers are
> > available to read, the values of these registers are not unique to be
> > able to determine the version of the codec dynamically.
> > 
> > Add the version info into of_data, so that driver does not need to use
> > core_id registers to get version number for such situations.
> > 
> > Fixes: 378918d59181 ("ASoC: codecs: lpass-macro: add helpers to get codec version")
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Seems to be fixing the reset I've been seeing on rb5

Let's hope this patch can find its way into v6.11

> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

-- 
With best wishes
Dmitry

