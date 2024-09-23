Return-Path: <linux-kernel+bounces-335803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F360797EAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BA8280C20
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9848619538A;
	Mon, 23 Sep 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMnyzQq1"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F1B824AC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091931; cv=none; b=G+MV15bj5/cxWzyUGpYycYpMyLT7xUUO8h30HPYCyvmkF3nvFI8JZVdbSkmnekvDr0/0kcPkJynmbUfQUc5FaFltse3jSN6rGHQ/s8EhGxpUR5yI6kDTY10IJLkTQnjgILmpsT9UoyW+vWMV++uC4SyMuHLNIYUoNMpVZY0wP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091931; c=relaxed/simple;
	bh=aUq/hEJy5beIUpqN45toKBNilWOEc/UNHjuq4CMJ/GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sazo92xOn2aO+ZlkKqOh5DIgnnontQzvWMR2bede2ciabrjb93UQVJicTlBI48DYMKzMhnbSKkEqfB6ZSWdLVpmPnDhBiIYJQS2K+SSHt7TTvivTvPZRxNXoK1PglXZVMNHj3hsQsjjUKTEzovxxD0S3BO/zbiJ7Vay67qoeR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fMnyzQq1; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-535be093a43so5035905e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727091928; x=1727696728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMwbFcxKHdbftumcznblxJfBpPC8ptWVXFa2dH4Buk8=;
        b=fMnyzQq1FvctjaTPFMBllLNAHST34nrti32OW+lndfosdVi+yw2ZugfuzicphetgEu
         f0Cd3nVFVrFYWL12wrfFcJHG6HRquWCGMLD0uTZo27NtWBzG/5mFGhmpn/ukP6y3v5LZ
         ujJRfO8FaueAmPbruWzWXuTnOU5K2UNsiAG/sRaUdq5tuiUc+qDPcvTcTlwJ/hWUe6cc
         NWJkFnlWsAaO+Ae7Sb98XjwFFOYRmS6BzmwAcjPlplBpwdFtnxN/BHX0pOc7KvxhRcAu
         VBGPKuiavqUX6PTzCD4M5+GMaRJohs8xq6yByR6foCvoVV3lc1K6aV8a9vmtzffh/2lS
         2P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727091928; x=1727696728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMwbFcxKHdbftumcznblxJfBpPC8ptWVXFa2dH4Buk8=;
        b=pgS5+YQgUSD4wdGQ58p5ZQt78CTPLG6fbQwA19PhCGZzftmfxuqczlRWsGKT2RmbFO
         6cqQQrA/oD/5flvww8Nsnds7vCywQjSWWOHxpJUwxPtjmHDKsEkjMLwf7u3QOJR+oA+7
         /KJ7oZuBnzhPKw+tpBEBXKuEYytC2MQmjomk3J3J10ucJdguo72MK6qNLzF/KQdIZULC
         p1RzjhfiIntrHymKPGo4fxMh+no9afMQiw3I3Dd7OFJ+dKwvuhLuW0v0G/RNF8Ig1LvU
         LSdsPtfftiNroFgWByjDDmgNymLNTHGIMQyFyJ1pJPKCJl3ackLLkq2ikg4IHd6tpSJe
         coTg==
X-Forwarded-Encrypted: i=1; AJvYcCXh/86Tik3b4ZkpmUYc9/0RX5bMTZYfPC5KSAf9zh8BkB67cFH7uFzkkkrt95YdGQYTAVDUbaXRBBppqbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSevzSCX74RrzBYlTIzCOr3vhq9nfQB26GBXGXb0ySzUEbXcY0
	4DegHaVOCNATjsP5bqJs4ltGXetvnhvPeq9gCaObW30ytwkLcRxi1LLI763n7To=
X-Google-Smtp-Source: AGHT+IFCh2GD/YYaddP7TMIDd36YLwXyayl1/jc49hpm9pk1zAYcHwo3MqpSbCp+ZxyRhnbKUPJIcw==
X-Received: by 2002:a05:6512:3b27:b0:52e:9b68:d2d4 with SMTP id 2adb3069b0e04-536ac33b18emr4731956e87.56.1727091927618;
        Mon, 23 Sep 2024 04:45:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536a6959582sm1674291e87.22.2024.09.23.04.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:45:27 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:45:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, konradybcio@kernel.org, 
	andersson@kernel.org, simona@ffwll.ch, abel.vesa@linaro.org, robdclark@gmail.com, 
	quic_abhinavk@quicinc.com, sean@poorly.run, marijn.suijten@somainline.org, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, quic_khsieh@quicinc.com, konrad.dybcio@linaro.org, 
	quic_parellan@quicinc.com, quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, quic_riteshk@quicinc.com, 
	quic_vproddut@quicinc.com
Subject: Re: [PATCH v3 3/5] phy: qcom: edp: Add support for eDP PHY on SA8775P
Message-ID: <mrx2flabzgzsfyenqowgslb5654wcai6q3oclkc2i3em3iqusr@ed3af2qdx7vb>
References: <20240923113150.24711-1-quic_mukhopad@quicinc.com>
 <20240923113150.24711-4-quic_mukhopad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923113150.24711-4-quic_mukhopad@quicinc.com>

On Mon, Sep 23, 2024 at 05:01:48PM GMT, Soutrik Mukhopadhyay wrote:
> Add support for eDP PHY v5 found on the Qualcomm SA8775P platform.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
> v2: Fixed review comments from Dmitry
> 	- Reused edp_swing_hbr_rbr and edp_swing_hbr2_hbr3 for v5.
> 
> v3: No change
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

