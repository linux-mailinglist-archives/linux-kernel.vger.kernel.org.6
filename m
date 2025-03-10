Return-Path: <linux-kernel+bounces-554839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87FA5A195
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A54C1893E20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82D22D4FD;
	Mon, 10 Mar 2025 18:03:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038F21C4A24;
	Mon, 10 Mar 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629806; cv=none; b=f9Sx6Ssy6u0PZ+FG3n16kyVWI+PlTTbn9uMbR914EFJFbfvV6PceAgRx3xR45khSOTS6KDo08dWq9seWbp1J/Eb1slToUH9vHl2x8xTzpbYzBVxsWQGiJoYQ2/v+n2bJCMQiN2m9S1TKQXOFxeZAyw/9vFgPgRCUpVvZzTeEosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629806; c=relaxed/simple;
	bh=XMtm18g068N5MqIchA75+quYe9le6SbvtbqzVU9ALsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3ZyPEt61z8ckm7PbtIO0KcEFOPgB+4M1Wg7FmvsyVWTnN86eQPdQLJuq7zKtufAEb8aVY7R/BiANXhTgUKo33zVS/03zK2fd+uJFAMfC5d04tw/6wSv+ibAeCDp18vuVmHXw7CFA88B/rj5aBHAqby09Rlh/cSo7ovwG1KVJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68C191516;
	Mon, 10 Mar 2025 11:03:34 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98BA53F673;
	Mon, 10 Mar 2025 11:03:22 -0700 (PDT)
Date: Mon, 10 Mar 2025 18:03:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] coresight: etm: Add an attribute for updating
 buffer
Message-ID: <20250310180318.GH9682@e132581.arm.com>
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-6-leo.yan@arm.com>
 <d8b1cf1f-1996-4d9c-9f1a-fad556f91577@arm.com>
 <20250310155015.GG9682@e132581.arm.com>
 <3f4354e7-e74b-4ce9-b0c7-4be103cbc94d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4354e7-e74b-4ce9-b0c7-4be103cbc94d@arm.com>

On Mon, Mar 10, 2025 at 04:37:44PM +0000, Suzuki Kuruppassery Poulose wrote:

[...]

> > How about we dynamically set the default flag in the Perf tool?
> > 
> > - If users set explictly the 'update_buf_on_pause' flag, then the
> >    setting will be respected.
> > - If users don't set the flag, perf tool detects it is TRBE sinks,
> >    then it can set 'update_buf_on_pause' flag as false.
> 
> Not really possible. There could be systems with mixed sinks. e.g.  TRBE
> for some CPU and ETR for others (say due to a non-functioning TRBE).
> 
> > - If users don't set the flag, perf tool detects it is ETF/ETB/ETR
> >    sinks, it sets the flag as true.
> 
> And in the cases above, perf event cannot run on all the CPUs, because
> some sinks don't support it.
> 
> Why do we need a flag, when the effect is not user (read, perf decoder)
>  visible and at the same time improves some scenarios (read non-TRBE cases)
> ?

Indeed in this case the flag is redundant.

> I would say, let the driver always update on pause, depending on the
> sink.

It is fine for me.  I will move towards this direction.

Thanks,
Leo

