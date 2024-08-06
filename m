Return-Path: <linux-kernel+bounces-276323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A352D949222
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEEE280A85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74621D6DDB;
	Tue,  6 Aug 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLYHdoOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222211BD009;
	Tue,  6 Aug 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952267; cv=none; b=J61/J2Lew5+iQG0hkTNw2ZCdfe7uFqYgPiZKjA0O/8egFwVghcGOJ3Ne31s3cK+htf4CJQ4xS5qBwUoyMuQsFfd4gKH3LTkcdGiyWQaDzcjBDzPzTCNdm0vSCtIQMeNc6/wQcV2/qbTvXn0xnpPUDiOUJdvUDr9JUFnUUIXJvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952267; c=relaxed/simple;
	bh=sxqHtM+CyWkUmqLteE86O3EkmvSjV44rljgaOCj5Ows=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIYPTu0YeVd7hMe7UIiR9grKmGVivrNi1C0o9jvYFheTNSV+UtndRMTgEqtB+RrhOzdEhkCWWkjYdA5u3u4zSPlzt3l10jBoM/rYaxWxa0bV0ge4rBDsbzTRE8hh98qJWpGcw0DJppgbnq8V+dQKtaB+uwn+mJZzOeayh59oRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLYHdoOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2640FC32786;
	Tue,  6 Aug 2024 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952266;
	bh=sxqHtM+CyWkUmqLteE86O3EkmvSjV44rljgaOCj5Ows=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLYHdoOpk4wX1H1OL+EQG+3MfxDrT69ZaLgLvEmODNlNIeR19UkqbebYmbbU7gUA3
	 S6R2PS2ALSWVVIpR96O3h0qEgDFxoNuE1SmgIGIrwe/0R9A7fPg/lPadgTH38YUGKz
	 oZDPZAOxf8zGpc9Vm2CGTXIlxVSzYpNf9xClMr7cEa1AhjPjOVHzcjR0GSNCjmtqd4
	 pvir5lZA+In9c86wMBRmT5rmrwOtKpH+jDJcqRb8xnMKiavOVHrY0s513oMzWjH8CO
	 D43cUh9/eYoJ80LCt8SbPtHBddCn5okbivNy68l8V09RO2IqeIUeZ5IrU2TMjkeDa1
	 fSnvhD23yTKAA==
Date: Tue, 6 Aug 2024 10:51:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Eric Lin <eric.lin@sifive.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Ci-Jyun Wu <dminus@andestech.com>,
	Locus Wei-Han Chen <locus84@andestech.com>,
	Atish Patra <atishp@rivosinc.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com,
	greentime.hu@sifive.com
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware
 event
Message-ID: <ZrIqR07cYJnhcTq8@x1>
References: <20240805194424.597244-1-irogers@google.com>
 <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
 <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
 <ZrInOywRKzRmjtKF@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrInOywRKzRmjtKF@x1>

On Tue, Aug 06, 2024 at 10:38:07AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 05, 2024 at 09:05:26PM -0700, Ian Rogers wrote:
> > On Mon, Aug 5, 2024 at 8:54 PM Eric Lin <eric.lin@sifive.com> wrote:
> > >
> > > Hi Ian,
> > >
> > > I've sent a patch to fix it and the patch already merged. Thanks.

Also, already merged where? Upstream? In the riscv kernel tree? where?

- Arnaldo

> > > https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.com/
> > 
> > Hi Eric/Arnaldo,
> > 
> > Right, I already commented this should have gone through the
> > perf-tools-next tree:
> > https://lore.kernel.org/all/CAP-5=fV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=cHaUMH5MFkVHQg@mail.gmail.com/
> > Arnaldo, please take Eric's patch in preference to this one.
> 
> So I removed your version from perf-tools-next, eventually we'll get
> this merged upstream, I'm just checking this isn't going to get in our
> way of testing what we have in perf-tools-next...
> 
> 
> - Arnaldo

