Return-Path: <linux-kernel+bounces-360595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012A999D08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801951C22CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37A209694;
	Fri, 11 Oct 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxAQih2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842A209F39;
	Fri, 11 Oct 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629307; cv=none; b=jTJ5Re2A12gpWHhdVcAzH7zVTwLW/lx3E76WMh3UnVgbYXlofF7oGNjRVUurQpcdb5V5NEKFcF5eGa/kVNZX0iLg6E0SI/8P03Ia+GEhs6Vlp6jNBxLRSCw4cELQq3y6rO+cBihNB2kJaO5LdmtAJOFxEhCU8/xBWVFwC08YwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629307; c=relaxed/simple;
	bh=fF61UDY3wxbQV0rq4vrLYmp/5sHuCdzuBG/RmPHMGBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVR7de6lbQMzSALScqAZcYOxb+z5ahd2Td31XrmA9jbduUP4veDY7lOx/kgRgJ+pY7pzNmCL32s6ImCbeacToz7pWHYSNI0wasoyJt5OS2vccEznGSuk/M2nf2yi2v1dLZyq/HLzWiGvjNlt0MdfI+CSaAQ6+8N4RMArIP5AprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxAQih2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EFFC4CEC3;
	Fri, 11 Oct 2024 06:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728629305;
	bh=fF61UDY3wxbQV0rq4vrLYmp/5sHuCdzuBG/RmPHMGBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxAQih2T3914mXzgwnQL6cPt0FrQ7j5m7TI3hbzz7ENjHHqoNpezTDS10Yt9NogAm
	 bWby2qzIf6r9N+dfGlYHjRxqmxGEMu569PXzhksxJew2lBn5W0nLhRcHfgslloBAg3
	 BHGIRNZ//SA70F+KoaaEQ+wbLXRjJcgf3srenWXex7soqHmadhBarvEMoV2ePnTVgV
	 PQTbqic5duYMracHW3IGQmUpQ0rAfUbt9vKAYI2CAdWZKWnVkUbb1yz/Cmj6jhlckA
	 XJ6e5bn+T+lDpO9b4KEq0qDbLZIAcf/Wr+i17m6p9uxM0D+7qyqZKfVIxxVg4WRCui
	 CqeFfwQxOi38w==
From: Namhyung Kim <namhyung@kernel.org>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	atrajeev@linux.vnet.ibm.com,
	howardchu95@gmail.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	leo.yan@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	peterz@infradead.org,
	tmricht@linux.ibm.com,
	vmolnaro@redhat.com,
	weilin.wang@intel.com,
	zegao2021@gmail.com,
	zhaimingbing@cmss.chinamobile.com
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
Date: Thu, 10 Oct 2024 23:48:24 -0700
Message-ID: <20241011064824.1432562-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <172857541969.1131797.2693392463657578240.b4-ty@kernel.org>
References: <172857541969.1131797.2693392463657578240.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-10-10 15:50 -0700, Namhyung Kim wrote:
> On Tue, 01 Oct 2024 10:19:47 -0700, Ian Rogers wrote:
> > The path detection for "Setup struct perf_event_attr" test is brittle
> > and leads to the test frequently not running. Running shell tests is
> > reasonably robust, so make the test a shell test. Move the test files
> > to reflect this.
> > 
> > Ian Rogers (3):
> >   perf test: Add a shell wrapper for "Setup struct perf_event_attr"
> >   perf test: Remove C test wrapper for attr.py
> >   perf test: Move attr files into shell directory where they are used
> > 
> > [...]
> 
> Applied to perf-tools-next, thanks!

Dropped from perf-tools-next due to build failures on PPC.

https://lore.kernel.org/r/20241011102330.02bece12@canb.auug.org.au

Thanks,
Namhyung


