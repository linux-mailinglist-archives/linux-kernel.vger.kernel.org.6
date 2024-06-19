Return-Path: <linux-kernel+bounces-220678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FEA90E550
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DA328532C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756378C7F;
	Wed, 19 Jun 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FRxw+0cD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A9763FD;
	Wed, 19 Jun 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784775; cv=none; b=Hj7DLqJsuVORrah98HrV96hk9m0FpcH1+b5qV+qrIUoqkmeWYmjBFc6zyz0L5wxBAXck2xJFYvGLRIAj5/YnE2cfDSpNqSY3zUxIhwwZdH2mdbDpb8Vk+LF7/Azd8EKqREFs9WDLNWCCg9xi6B5m3Rcp93RvMHdpgAkzjNVlQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784775; c=relaxed/simple;
	bh=d22ozv8UZzsbdeCLyzbmyCDhwksXbO4tqNyJiRNzVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiOtyQnu5SsJgKF1VT6WsqS39Yq9upZ7I8hDBYmZz14Q1JJGYtxW4OnZkuEEoF6q2CqNzzddwLg57iBxqXog3VvpQutCp5yziob1kkGYklpT1a9Ma3Kl9U04r9xag1hmz2pSt7fG7rgp/LfKJdVXn+wkeshcArwVqrT6IhtR3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FRxw+0cD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390ECC2BBFC;
	Wed, 19 Jun 2024 08:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718784774;
	bh=d22ozv8UZzsbdeCLyzbmyCDhwksXbO4tqNyJiRNzVpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRxw+0cDYZFJozbRUuujZdkbvcFzUBdF99vdYElj/iTAhc2AmqbsuXU4OhghUY0V2
	 cY+wdFFl+mpsiRarjMYjdBdXpoBDovhiv5K+JJahLex4yeoYkuPRRrMJlIai0FDMoc
	 0sCElbyU81+aJIT2xLdwj91jyQjXxJ3UF/qOa/kQ=
Date: Wed, 19 Jun 2024 10:12:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jie Gan <quic_jiegan@quicinc.com>, coresight@lists.linaro.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Konrad Dybcio <konradybcio@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Rob Herring <robh@kernel.org>,
	Suzuki Poulouse <suzuki.poulose@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Jinlong Mao <quic_jinlmao@quicinc.com>,
	Song Chai <quic_songchai@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	Tingwei Zhang <quic_tingweiz@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>, quic_liuxin@quicinc.com,
	quic_sijiwu@quicinc.com, quic_xinlon@quicinc.com,
	quic_xueqnie@quicinc.com, quic_yanzl@quicinc.com,
	quic_yijiyang@quicinc.com, quic_yuanjiey@quicinc.com
Subject: Re: [PATCH 2/3] coresight: Add coresight slave register driver to
 support data filter function in sysfs mode
Message-ID: <2024061947-street-italics-0cdf@gregkh>
References: <20240618072726.3767974-3-quic_jiegan@quicinc.com>
 <e916a445-f7bd-4213-ac66-cf39f6c5001b@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e916a445-f7bd-4213-ac66-cf39f6c5001b@web.de>

On Wed, Jun 19, 2024 at 09:55:25AM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/hwtracing/coresight/coresight-csr.c
> > @@ -0,0 +1,315 @@
> …
> > +static int __csr_set_etr_traceid(struct coresight_device *csdev,
> > +			uint32_t atid_offset, uint32_t traceid,
> > +			bool enable)
> > +{
> …
> > +	spin_lock_irqsave(&drvdata->spin_lock, flags);
> > +	CS_UNLOCK(drvdata->base);
> …
> > +	CS_LOCK(drvdata->base);
> > +	spin_unlock_irqrestore(&drvdata->spin_lock, flags);
> > +	return 0;
> > +}
> …
> 
> Would you become interested to apply a statement like “guard(spinlock_irqsave)(&drvdata->spin_lock);”?
> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/spinlock.h#L574


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

