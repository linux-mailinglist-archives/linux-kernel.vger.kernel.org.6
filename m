Return-Path: <linux-kernel+bounces-305742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A09633B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3341F2310C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A21AC8A9;
	Wed, 28 Aug 2024 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDDP+I2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37D45C1C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879766; cv=none; b=aib/i9pWSzbXz87fb85SBvGr0loo5erq/8/FJD8QJK+lU9tLvOBfPNNt2CnFSP6k8a7VuXvBNfqQ1hi2syc7/ki4onZTzMz9tEv0B2eEZ3dzcLKvop7BKlM1RsKYysRiUeST4rkbAiQersYybh14qLqagLnKeiD4KftYzOa/XJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879766; c=relaxed/simple;
	bh=/kLL/io302i000jxePx13Sh1bdd2MFMnZ4xEnNsxgAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGKRVN0WbWOXFANjmVPipzlZl3yt5GV8+UURdQQKhMFgamzGvgFIDB7l5TcL18ie0vrXyFAUoa5lmQOOU05rTss2vtsmaE+uEHiwYDMSgY4+v8flh+o6jHtQ8XeFsvUct2S8S/cmGxeLbgbpqAfTGwlch8cUmpZ7XkqvZE/xcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDDP+I2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CB5C4CEC0;
	Wed, 28 Aug 2024 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724879765;
	bh=/kLL/io302i000jxePx13Sh1bdd2MFMnZ4xEnNsxgAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDDP+I2IgZaXaCF5B6H/uuXcsz4rkATfKsWdDMntlVi5UenhKA0YnBVVJqCq3+K4I
	 eWUl7w1dNLGzVYHzfnF43c0R76i0bsNg8azQXqxtPP6gxgt29+pz7cRsezhLmNS4mr
	 FydsQtDtWM+/dHNkEKM733fS3gqo8L9PALLhBNAx02IiXmDiJRdlp8ptekkyTlS5Pf
	 yV7373kxM6LTdcS7ZYgc893Q8Z4+tGQlAjnA/vLt1vuf5BdIj4di5/h/VEMMNRcoAf
	 3if+DkKqqrAz9CNZ0LiZQjqLqqzlX4lKxHiQHjdYGZCTMvdHDcxSXyEEOdIREBIcyw
	 CaNhJBS0V217g==
Date: Wed, 28 Aug 2024 18:16:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v1 2/9] perf auxtrace: Remove unused 'pmu' pointer from
 struct auxtrace_record
Message-ID: <Zs-Tkl0D44fQmMHT@x1>
References: <20240806204130.720977-1-leo.yan@arm.com>
 <20240806204130.720977-3-leo.yan@arm.com>
 <53c51dfc-9727-4e11-8846-6f37bc64744a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53c51dfc-9727-4e11-8846-6f37bc64744a@intel.com>

On Fri, Aug 09, 2024 at 11:02:16AM +0300, Adrian Hunter wrote:
> On 6/08/24 23:41, Leo Yan wrote:
> > The 'pmu' pointer in the auxtrace_record structure is not used after
> > support multiple AUX events, remove it.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Applied the first reviewed two patches.

- Arnaldo

> > ---
> >  tools/perf/arch/arm/util/cs-etm.c     | 1 -
> >  tools/perf/arch/arm64/util/arm-spe.c  | 1 -
> >  tools/perf/arch/arm64/util/hisi-ptt.c | 1 -
> >  tools/perf/arch/x86/util/intel-bts.c  | 1 -
> >  tools/perf/arch/x86/util/intel-pt.c   | 1 -
> >  tools/perf/util/auxtrace.h            | 1 -
> >  6 files changed, 6 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index da6231367993..96aeb7cdbee1 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -888,7 +888,6 @@ struct auxtrace_record *cs_etm_record_init(int *err)
> >  	}
> >  
> >  	ptr->cs_etm_pmu			= cs_etm_pmu;
> > -	ptr->itr.pmu			= cs_etm_pmu;
> >  	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
> >  	ptr->itr.recording_options	= cs_etm_recording_options;
> >  	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> > index d59f6ca499f2..2be99fdf997d 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -514,7 +514,6 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
> >  	}
> >  
> >  	sper->arm_spe_pmu = arm_spe_pmu;
> > -	sper->itr.pmu = arm_spe_pmu;
> >  	sper->itr.snapshot_start = arm_spe_snapshot_start;
> >  	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
> >  	sper->itr.find_snapshot = arm_spe_find_snapshot;
> > diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
> > index ba97c8a562a0..eac9739c87e6 100644
> > --- a/tools/perf/arch/arm64/util/hisi-ptt.c
> > +++ b/tools/perf/arch/arm64/util/hisi-ptt.c
> > @@ -174,7 +174,6 @@ struct auxtrace_record *hisi_ptt_recording_init(int *err,
> >  	}
> >  
> >  	pttr->hisi_ptt_pmu = hisi_ptt_pmu;
> > -	pttr->itr.pmu = hisi_ptt_pmu;
> >  	pttr->itr.recording_options = hisi_ptt_recording_options;
> >  	pttr->itr.info_priv_size = hisi_ptt_info_priv_size;
> >  	pttr->itr.info_fill = hisi_ptt_info_fill;
> > diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> > index 34696f3d3d5d..85c8186300c8 100644
> > --- a/tools/perf/arch/x86/util/intel-bts.c
> > +++ b/tools/perf/arch/x86/util/intel-bts.c
> > @@ -434,7 +434,6 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
> >  	}
> >  
> >  	btsr->intel_bts_pmu = intel_bts_pmu;
> > -	btsr->itr.pmu = intel_bts_pmu;
> >  	btsr->itr.recording_options = intel_bts_recording_options;
> >  	btsr->itr.info_priv_size = intel_bts_info_priv_size;
> >  	btsr->itr.info_fill = intel_bts_info_fill;
> > diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> > index 4b710e875953..ea510a7486b1 100644
> > --- a/tools/perf/arch/x86/util/intel-pt.c
> > +++ b/tools/perf/arch/x86/util/intel-pt.c
> > @@ -1197,7 +1197,6 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
> >  	}
> >  
> >  	ptr->intel_pt_pmu = intel_pt_pmu;
> > -	ptr->itr.pmu = intel_pt_pmu;
> >  	ptr->itr.recording_options = intel_pt_recording_options;
> >  	ptr->itr.info_priv_size = intel_pt_info_priv_size;
> >  	ptr->itr.info_fill = intel_pt_info_fill;
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 8a6ec9565835..95304368103b 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -411,7 +411,6 @@ struct auxtrace_record {
> >  	int (*read_finish)(struct auxtrace_record *itr, int idx);
> >  	unsigned int alignment;
> >  	unsigned int default_aux_sample_size;
> > -	struct perf_pmu *pmu;
> >  	struct evlist *evlist;
> >  };
> >  

