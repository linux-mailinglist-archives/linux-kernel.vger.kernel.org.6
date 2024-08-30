Return-Path: <linux-kernel+bounces-308881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EF966308
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4261C227A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFCB1AD5CB;
	Fri, 30 Aug 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g26UpISI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B2165F05
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025029; cv=none; b=tMoMj6OQE0sATz9XetN974UBUu3z3EmbILfzg6I9eIFQJ7drnSdbupysGIn1LGVOTnw5eirqdfYTLy2DClILBBwL2rN2gN5d8c8R1mARtIHcdyXpMwBR1XoEqL9vsF73V1R28vJrC2diCYfkKgCFCqjv+oY8RXJmuXF+QgcAtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025029; c=relaxed/simple;
	bh=VrkFLo9b82/ZdEIQjnHaqEIbLRMJ0Cnw3oTqMOIg9Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J84ZFu0zWYNeuJX2KaNi4JRPtFedsTCLbsMCo4KQC7F52FxV2TFvhkAOLHGYd3O0R/TL72EHhocj1g+DHu/7v0QBVgbJ5w/cygeepJMgFkA9wktKzUVa1ADRsVXh74SXIX1tsHEFGTAXqVCklnrGJKc0+4LYJdEI4svlex5dlbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g26UpISI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412AFC4CEC2;
	Fri, 30 Aug 2024 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725025028;
	bh=VrkFLo9b82/ZdEIQjnHaqEIbLRMJ0Cnw3oTqMOIg9Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g26UpISIOpy9xyli0TfJxi8kPf2XL/OCA3zx3fEAEqqylz2zP7j7YxBI6D++d4xNA
	 Gy/Y1JN9DO4zs0Y4oao2fz/7o+qYhOtmcjRSBPS+ifvE2fUBQUG+fVSPBWix5J/89c
	 wHmJu3mmVmpROvE7w4TUkWKKQvoy9QpjFW67j5wMbyQJ0OZXIbPGLBkORUwDetmmxK
	 Li6sbDB40f+n+Fic98axWiVCLXPLrrNyRn68Gco9T/F/zjLNboLzuk3jlBaatDS44T
	 7SL5k+rUIrp+OhkVkkOKC2kzlIx6p14Q21VUf8oKRYePdt1eeaDSRvhv2PFS7qwFqB
	 Ifw0R1cCXRF9g==
Date: Fri, 30 Aug 2024 10:37:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	Ian Rogers <irogers@google.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Radostin Stoyanov <rstoyano@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf tests pmu: Initialize all fields of test_pmu
 variable
Message-ID: <ZtHLAcgDT7S51vUg@x1>
References: <ZroIIXkmErNGZjQO@x1>
 <e26941f9-f86c-4f2e-b812-20c49fb2c0d3@redhat.com>
 <CAP-5=fXFH8aqxzCVAgRRdZufUdiC2UMBApEeSnak3yhZ_CXNyA@mail.gmail.com>
 <ZtDjdt1QwbxJVKZ0@x1>
 <CAM9d7ch3wYvqKE9HANvhinnBqgtnA6suzLYrd4bkFZ-wjqdOQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ch3wYvqKE9HANvhinnBqgtnA6suzLYrd4bkFZ-wjqdOQw@mail.gmail.com>

On Thu, Aug 29, 2024 at 08:49:05PM -0700, Namhyung Kim wrote:
> On Thu, Aug 29, 2024 at 2:09 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Being only in perf-tools-next:

> >   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=37e2a19c98bf99747ca997be876dfc13f9165e0a

> > So yeah, probably Namhyung can cherry-pick that patch (Veronika's) into
> > perf-tools for v6.11.

> > There were a few more fixes that I noticed and picked for
> > perf-tools-next that then people reported that should also be
> > cherry-picked for v6.11, Namhyung?

> Ok, I can pick this up.  I think my perf lock contention fix also can
> go to perf-tools.
> What others do you want me to pick up?

Here Ben points to one:

https://lore.kernel.org/all/d94d995e476a5c014e1ce4d75d36f8667acd3316.camel@decadent.org.uk/T/#u

Which I think its this one:

commit 2518e13275ab9ea6b2540f828cf78b0280991f85
Author: Xu Yang <xu.yang_2@nxp.com>
Date:   Mon Aug 19 10:34:03 2024 +0800

    perf python: Fix the build on 32-bit arm by including missing "util/sample.h"

There is also this one:

commit 6236ebe07131a7746d870f1d8eb3637a8df13e70
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Aug 19 16:46:29 2024 -0300

    perf daemon: Fix the build on more 32-bit architectures
    
    The previous attempt fixed the build on debian:experimental-x-mipsel,
    but when building on a larger set of containers I noticed it broke the
    build on some other 32-bit architectures such as:
    
      42     7.87 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
        builtin-daemon.c: In function 'cmd_session_list':
        builtin-daemon.c:692:16: error: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long int' [-Werror=format=]

- Arnaldo

