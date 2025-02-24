Return-Path: <linux-kernel+bounces-529744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E146EA42A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DE018969D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D87264FA6;
	Mon, 24 Feb 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGXguZ/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9602264A60;
	Mon, 24 Feb 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419785; cv=none; b=gfhSFli1QtEK3ttD3fF6lmsCMSUpEEIU+bOuzqWn3jstiAZw8UCf91UKTpnLzOVT4h4Cv/AQxiTkzVvSLLRUeJH+tMHzuCYjxAPDsquKMW40l+CN2mnQQxHsQM26EHeIrUn5oLlNKJtW4em4+dvwNGs0t+lYMpNYMNOVKzUkqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419785; c=relaxed/simple;
	bh=Bt7VoPhcsSkXtYjPHqWG20sRUthCsltNi81xM60UOWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHogbMjDSzWuJkkEwi8+UVg2MNrIpBf9rxRBVeWRctwaexBkCvRr8MZaqb1XWhGmKpCheI0Pb7SKO6i9PoDou5EuvP49eSXF3dCRhD+Uno1DiFFCcvQw3hMEZQyY5+7kcUb4bg72plkKQp3QR1MAxaUhC5HPKRFo3sUl9iiSA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGXguZ/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DE2C4CED6;
	Mon, 24 Feb 2025 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740419785;
	bh=Bt7VoPhcsSkXtYjPHqWG20sRUthCsltNi81xM60UOWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGXguZ/qhyClnkyquiJduCOndGjtbuEHy51vgO2CgfUp+T7mVmkc/gKDJZNqC5YqC
	 kVwpTJYN6GbyDaTm+3LcD85SnkMHbJu6PHfmbxGA49igZ0gZ3ee0MDti+bO91h3Nuj
	 sSwbgSKaWxVxDz8JD/OjVoZBXjyKXAsusTV3Aemn57N1Uhgc1SuKoMBq/tuQVWmw0+
	 JjkF8BUo17JNM5rkz8L4FhL4EXQ9xc5wgRhmDWbU28fsCkO/V8bdrp2FRO3UdFmjX6
	 dr93AlMnkFKsR52pEGJaEVA8lSw342sfv/6nOulOwG7yv++fxZM7etsczsQGkiDMj7
	 FpyDIUi3HerxQ==
Date: Mon, 24 Feb 2025 17:56:18 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Hilber <quic_philber@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Parav Pandit <parav@nvidia.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] virtio_rtc: Add PTP clocks
Message-ID: <20250224175618.GG1615191@kernel.org>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
 <20250219193306.1045-3-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219193306.1045-3-quic_philber@quicinc.com>

On Wed, Feb 19, 2025 at 08:32:57PM +0100, Peter Hilber wrote:

...

> +/**
> + * viortc_ptp_gettimex64() - PTP clock gettimex64 op
> + *

Hi Peter,

Tooling recognises this as a kernel doc, and complains
that there is no documentation present for the function's
parameters: ptp, ts, and sts.

Flagged by W=1 builds.

> + * Context: Process context.
> + */
> +static int viortc_ptp_gettimex64(struct ptp_clock_info *ptp,
> +				 struct timespec64 *ts,
> +				 struct ptp_system_timestamp *sts)

...

