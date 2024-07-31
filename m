Return-Path: <linux-kernel+bounces-269504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAB943398
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46EC1F270F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FEF1BC06F;
	Wed, 31 Jul 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQkEbo50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8091BBBD3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440707; cv=none; b=P71moIT/+cO9tWRnKdy8oXh0AInou+fiB7i75LZpsGJRgvUx9E3x2IZyRMOI3ojcH83bubr9JxKFymJKyVRnWQBf4WwGIMz5+jWORz1h4BrhCqZT+xkWzgxQ+ivMT6H/eHq5IGpS+eUKbowr510ZF+0QbG1J2acMUrnu96AfTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440707; c=relaxed/simple;
	bh=NmitiGPMipFuWRllnzeaQLIndK4WAJkGQNjENc0ekiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc8T5JV0S3G7BB8tZxaKHOawb/bwyz/Dnl57aw6l3V/VdYJkTuY+VZhSMiVqzZMBcm9Mnx+uL3LjdqdGQD9e/iQOrI+hshgYswk3ieSY2yGmlpKnlbw0RTMlZ6E3TNtrmpt2Da2IN4ZNaHguIg2y+X+anihRRkHuPTYm+wQVTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQkEbo50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B38C116B1;
	Wed, 31 Jul 2024 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722440707;
	bh=NmitiGPMipFuWRllnzeaQLIndK4WAJkGQNjENc0ekiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQkEbo50vfpnFg39DPCCCVu8nBkMqa9VM/8zapr2mIeOaEtNZkoa08Ba9H0N+A5cQ
	 rZ7uBZ6ZA2TliCvWTeA3FaQD4stUPboUOTW3WqOqTv46WN2r6tMe6UNkQxdsTSoxKV
	 AmT/b1/wkUZpVJte+r8GGQ07SupmI5+7ByFCnQsTTg/7cS/Y0f/jMq09SKjW9I37gA
	 7DqrUyIFu/qKHFgurumt7BpAy5HJx9jTGj/tQa95vXnjnCUciOzAZncoTZXU52xion
	 +7lxa6RNL2pMkDXydELNYhAxaO6IYe0FQEv1t37Z08hsr8NtH4aTxZp+B0k5loZcrJ
	 hCYrQJ9vtAqZw==
Date: Wed, 31 Jul 2024 12:45:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
Message-ID: <ZqpcAN_-UhXJkM94@x1>
References: <ZqpUSKPxMwaQKORr@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqpUSKPxMwaQKORr@x1>

On Wed, Jul 31, 2024 at 12:12:10PM -0300, Arnaldo Carvalho de Melo wrote:
> There is a clash of the libbpf and capstone libraries, that ends up
> with:

So this is needed for building without BUILD_NONDISTRO=1, sry.


diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
index 14994515beb341ce..1fee71c79b624cc8 100644
--- a/tools/perf/util/disasm_bpf.c
+++ b/tools/perf/util/disasm_bpf.c
@@ -3,6 +3,8 @@
 #include "util/annotate.h"
 #include "util/disasm_bpf.h"
 #include "util/symbol.h"
+#include <linux/zalloc.h>
+#include <string.h>
 
 #if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
 #define PACKAGE "perf"

