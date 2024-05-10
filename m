Return-Path: <linux-kernel+bounces-175258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E08C1D20
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D12B20F02
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD66149C7B;
	Fri, 10 May 2024 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ6nOOHF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC69171A7;
	Fri, 10 May 2024 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312449; cv=none; b=BXN/l4W8778jEgxUOcR4pR5S1MqiL/iP672kc6suWhODrjPUbAbfA9lBqSnhJuBoKkhSsvt1BkfPLxyEPmA3ogS4jjYp3CFIaz6L//mhBzg+lbQEyuqqW1a5akTmtsMpVwtny5hhXcAfBvq3XZfJpKgXhdtx5GolbWqHYrMTHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312449; c=relaxed/simple;
	bh=MENmYORgJEZhsp38GB5HbWpXLSb6Vhhy+phhdaDWRG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZimR9sC1mfkRfxtjooaWw+GpFItqXkO085nCFfW1qISMg7MZIiTMM7MCjQLdca0kxXFDkucb6weztILmOfauS0iGYyHUKOgYwbHuciEU82QvPrzdKA9FeUszu9Ndhr9eN57fPrzosrKe/oFfLCiflNPf/kWPbTtVUWsZCZ0YOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ6nOOHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F80C113CC;
	Fri, 10 May 2024 03:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312449;
	bh=MENmYORgJEZhsp38GB5HbWpXLSb6Vhhy+phhdaDWRG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WQ6nOOHFZsk7fMf1W2v0cbpyO7LS1b3PqBDAPw++VqqC2yHhjdC/xGu4rNWNHmuhY
	 TBvMI14wERccWt+7XARjhSwd6JysEkuM1QVtALxPq7JHmQm0TPbHI4fIBKDGTlBddv
	 5SGtNsHuygaGjDek3veOSe3jbNI1uxCjEX1AYLSepT2T5EEct7PirdK8mnp/X2Uceu
	 EAZNEuuC31+fuJBcAk6OW1/pEar/jhJoOwnadOONPECcsdOkRdxVtAZokZis30xbea
	 pElaN52W4nR0nkYp4EDixw8sIdIrVKfccJmbfu0GD+ZYhB0n2CL1fpLTQG+HyDMcr5
	 ZyVlOsM8OeZNw==
Date: Thu, 9 May 2024 20:40:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <pkshih@realtek.com>,
 <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v18 10/13] rtase: Implement ethtool function
Message-ID: <20240509204047.149e226e@kernel.org>
In-Reply-To: <20240508123945.201524-11-justinlai0215@realtek.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
	<20240508123945.201524-11-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 20:39:42 +0800 Justin Lai wrote:
> +	data[0] = le64_to_cpu(counters->tx_packets);
> +	data[1] = le64_to_cpu(counters->rx_packets);
> +	data[2] = le64_to_cpu(counters->tx_errors);
> +	data[3] = le32_to_cpu(counters->rx_errors);
> +	data[4] = le16_to_cpu(counters->rx_missed);
> +	data[5] = le16_to_cpu(counters->align_errors);
> +	data[6] = le32_to_cpu(counters->tx_one_collision);
> +	data[7] = le32_to_cpu(counters->tx_multi_collision);
> +	data[8] = le64_to_cpu(counters->rx_unicast);
> +	data[9] = le64_to_cpu(counters->rx_broadcast);
> +	data[10] = le32_to_cpu(counters->rx_multicast);
> +	data[11] = le16_to_cpu(counters->tx_aborted);
> +	data[12] = le16_to_cpu(counters->tx_underun);

Please limit stats you report in ethtool -S to just the stats for which
proper interfaces don't exist. Don't duplicate what's already reported
via rtase_get_stats64(), also take a look at what can be reported via
various *_stats members of struct ethtool_ops.

