Return-Path: <linux-kernel+bounces-426479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CD9DF38D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86B4162F03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 22:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0AF1A4F01;
	Sat, 30 Nov 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a97DjdWK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553B19307D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733006154; cv=none; b=O145ojI8+i0fA9xVNStXX1ZNsKSYLu7L98RtQ6/LFYR1vi1Rp2HX9PWCtxt2/PLx+Xg9mGwcE2FN+BSi1IqDv0hbM+DbCo3j0bYRpEatDWvniQb0Wg+Ni46pW22R65KmJDLiqKSDWnoVOn0+rIsLdHnlGuIeMuU09DtVOGeCY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733006154; c=relaxed/simple;
	bh=e3Y+LPT4T+5s5Z1B9azCpm11KJqEouAd2GSPxWJzbrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kN0eORL7nLFe8xQMKJycoraQnjwpxhY6+b96DALL7qO97YgyASqEdDZSF3N7Omdca+i7r18hGT11Pou8ZE6asnQ2oFL5PpSORIbSWnL8s4ysWUAllGGl7G3k/IGICBBde6zLrsYX0QQ+lphMU0Ym3RQNdNqS7YugjuGLRdRtXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a97DjdWK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de5ec22adso3623005e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733006151; x=1733610951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjEEdOsbPzZpO48x0whbp4HjANLGu9eqTa4aQfjzkTo=;
        b=a97DjdWKvexPbFWtfAtSizs3GGqmFcT1xqlpJ5uKFWZinCbpqyNWIxGzsRUHhf2BvW
         bvwZHTktqh698k8bjHI/j71Bgi5F7iDIWqS8V0LBnW8Gw5t+ykkvs2fJOGHQgNJU6x8P
         bRiTxIQfASlk72hKSo0kWxh7mkUdPY5gakyfGMxXf1OlfQjyhy/i7Pqf4/XzlhkKw62H
         8y1q+bMbsd94mDIjIy00j0lI3z3DLnlkvjUUj2gMJZ953bJofd2+91jJfAvnRkTVDbSU
         1ceUD3gIdTTI9GsfMjzK/mQOR2UU61CNqhLu2ZHjdpIsAsC4ge1MywG9bTKCqzl20BaN
         ohZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733006151; x=1733610951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjEEdOsbPzZpO48x0whbp4HjANLGu9eqTa4aQfjzkTo=;
        b=AJYe3BHg3Qwz4UppvjmZ2gFUfFbuEiu3/gv71A4PRz8ARb7PYv5nRnoqZmb4c2IHoK
         vJWlf1XnzKpHW6YyQWLRoh7zIRJyUPjeSrTRr1+Wl0kdGdFOhtJM8FTQeHkCKO8OBF3u
         xWwx6iPzSMgJ8ZvNsKMJGyyfj/rgJL26/TnJ7AKad9A/4XOePIMvmGxy0geneBLl91Rz
         N5yli3dNkpSwB5K+a6Zy/kiX485OC6453FJOElAf8Eb93pk5alfpfYbv7kbrNtgehICA
         2vdg5sPgLcTLaF/G9JbErCOCoOgpF6vG5pwOEgLbTfJCvuD6bTqMkwt5/BuedWvlUiTF
         HhKw==
X-Forwarded-Encrypted: i=1; AJvYcCWftjEkIIjlk7WtfuFGCpFwXpmmO0UDdJuKGjbGnZ8lMXwg9GVGZJmsR8cJsO3KWhV9bj6hpptpTGrAVZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTF11j3HjUN3ctqCoA79fKEp+8SdwnDaDND8WsW10ouMAKo+w
	wq/V3QEfVByOZ2cBOwcZZJT9Q5eaJVIh9bi0eh8+CHMk2aRvbTso/0RMIE6TvreTe5CvR5w/Nu1
	8
X-Gm-Gg: ASbGnctHtqoQLI4NVCxZFfW7l4PyPlsiDW1LQZxRXiBMmc0w751o4KLSAzxBrYJ7fIX
	lQ3ORMh9GkSdJWwcC0n21TozJTL/ZaYsW//od28fsgPWjall+hj8eLwoO2r5oCKrETt0EGMFR4G
	aK2RPvHxNtcv1dZkznOOD2KUjmpCgfHlN+sgghC27OZIM0lAp9Vl6yU0eehg/1YR/SHtyHF9PkW
	++/J+kYwsENCMvv9GULz+1mFxnFxEcv3gr0rmUDqjvB6vvd6UfabDTPWLMVJbzHJ7aAKaJLahi+
	dcezMenmHxCmOUcsdOBuXSGmZV2Xbg==
X-Google-Smtp-Source: AGHT+IFRjM9hiHSdh6QMnUl0xAn2h7VlGTe986jUjWKha/xgpcy6CHVBb/2l1zKz49suidogBV/Sfg==
X-Received: by 2002:a05:6512:3983:b0:53d:ed77:37c1 with SMTP id 2adb3069b0e04-53df00ff831mr10041944e87.43.1733006151122;
        Sat, 30 Nov 2024 14:35:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a068esm877155e87.273.2024.11.30.14.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 14:35:49 -0800 (PST)
Date: Sun, 1 Dec 2024 00:35:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naman Jain <quic_namajain@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] nvmem: qfprom: add Qualcomm SAR2130P support
Message-ID: <yeqgrz3tlhqhkd5au5ras7iyp3q5l6mjfjnpngyuffn6k2hu2y@toy6eqfpdoub>
References: <20241027-sar2130p-nvmem-v2-0-743c1271bf2d@linaro.org>
 <5lucyuowwaz7k5x2grlifuc7xxxppant3ysofy52xsrxdsx4zf@2tj43gglshcf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5lucyuowwaz7k5x2grlifuc7xxxppant3ysofy52xsrxdsx4zf@2tj43gglshcf>

On Fri, Nov 15, 2024 at 09:59:58AM +0200, Dmitry Baryshkov wrote:
> On Sun, Oct 27, 2024 at 01:42:32AM +0300, Dmitry Baryshkov wrote:
> > Pick up a fix from msm-5.x kernels and add compatible for the Qualcomm
> > SAR2130P platform.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Changes in v2:
> > - Picked up required patch from QCLinux.
> > - Link to v1: https://lore.kernel.org/r/20241017-sar2130p-nvmem-v1-1-6cc32789afc6@linaro.org
> 
> These two patches have been sent two weeks ago, but got no response from
> the maintainers. Is there any reason for that? Srinivas, is the
> subsystem being maintained or should we change it to 'S: Odd Fixes'?

Another two weeks and still no response. Yes, we are in the merge
window, so I don't expect the patches to be applied. However it would
have been nice to get a feedback from the maintainer.

-- 
With best wishes
Dmitry

