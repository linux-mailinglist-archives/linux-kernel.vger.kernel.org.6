Return-Path: <linux-kernel+bounces-559970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D9A5FBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8C93B8F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5EB269D08;
	Thu, 13 Mar 2025 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6uy7lz8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE892698AE;
	Thu, 13 Mar 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883376; cv=none; b=rMOg3ZiemVtM0AYWWM4jrtOm95wveZigatbFwhvR2CoM04TGqx6SGNMHof8DCpDH/9Trwn0BWP8uwSUVEzxbzMC6rebSbTL/J5J8sid7K4uCnJcEPx0O5XlBaEX/nzg0ik7gH14A1AK1E80CDOzVd6GmFbudlDgeu7d/Pvu3uWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883376; c=relaxed/simple;
	bh=Kxx2hpMLgKSpInnRwV1p2bw+3N6G+xre+hC45z8bjRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V0+ZXrKBy+cB/ul0bCQNWtpVrYvgCIpV79YCCw+f0r+Iz3WWICq4TzbySVKmpmVHGdHDcDRoBp8QGR4wupO0fo3LVE4Xo7eZDXWkUg4aUbNs3mlc/VsYVjXFpsT8J2Qjr18eITQqF09feevetSQCa0m97eC4Dh9HPoR202psOls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6uy7lz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D172C4CEE9;
	Thu, 13 Mar 2025 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741883375;
	bh=Kxx2hpMLgKSpInnRwV1p2bw+3N6G+xre+hC45z8bjRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d6uy7lz8oyu99KZnF9KR3KOaiRIRtdswRzH3qSEuqivfO1GYMZDn2jnElBigD+SUm
	 w+/K2AS34/sf8RygMPovaQRjypEoVDhczOqAayTUbAo5lvEFZLIJ1dvlWJkQDJ3eeh
	 Rp9Lb6nti0T03+DHLSmZZxgI8gUlkIGQX6T/GcsXcHNHe3SZwYkuVW4FhnAM+lICow
	 G88b+m639bq4SWLIlBs/aTyfQUPk/RBNEXHrWziV6RvEVSwsXluSPkjPj9QyZ1yIzd
	 XzSN9WCiJAQAPkALdBTLu8sjgQvDYs6i1EMj4HbDLH7fBeT0KAd1Th8PJwNM1w/Sem
	 mPvMysPOB8o8g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20250310224925.799005-1-namhyung@kernel.org>
References: <20250310224925.799005-1-namhyung@kernel.org>
Subject: Re: [PATCHSET v2 0/7] perf annotate: Add --code-with-type option
Message-Id: <174188337513.3466761.1103420697284240909.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 09:29:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 10 Mar 2025 15:49:18 -0700, Namhyung Kim wrote:
> There are roughly two modes in the perf annotate.  One is normal code
> annotation and the other is data type annotation.  I'm proposing a new
> way to combine the code and data annotation together.
> 
> With this option, "# data-type: <name> [offset (field)]" part will be
> added when it found a data type for the given instruction.  This is
> for every instruction in the function regardless whether it has a
> sample or not.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



