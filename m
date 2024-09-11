Return-Path: <linux-kernel+bounces-325317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A79757BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F2F1C2173F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69531AB6D7;
	Wed, 11 Sep 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3CvXpka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307D187336;
	Wed, 11 Sep 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070297; cv=none; b=HaL4usgDcR7GO7rAy+arITw15jjOxK+p2vrz5D9vkH7nKhhPGNh8vokNqx69sZqUKEn2Q+u1BiuskWozfQf8fbMxy836eugROUsqPleKSK0GtKgu7HE51t2MhQeqNWi31wNTZVIqhMIam2+3mjNo6SkQoCKdoLdk7J8vQUVuZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070297; c=relaxed/simple;
	bh=0j1mqJC/lyjFngzKjxiKOd66K8oCQNazYv0sZapsMDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL60rwk1BPDgcpavZrArKZapWnKNuRoY2YJYltTnJYn+cf/MkogvKNretuPRAh0yctcSODkDwkNFYx3GQYeyGr7EHHE9h9DvbDK9hSpz7WO2TanTVZq9rGPJsN7dvTLHdJIrQS0rEfGgDHeqxMM69kUv08LWs8T2OGTpo4BHOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3CvXpka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E19C4CEC0;
	Wed, 11 Sep 2024 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726070296;
	bh=0j1mqJC/lyjFngzKjxiKOd66K8oCQNazYv0sZapsMDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3CvXpka/nlCo3Gpds1ctsuixTz3JE09aVKOyztrlIAUmLhgvzQ1Rxd5GbR7S+9CD
	 faWVHolWN6FEFeHopqRjSYVOq3US/rAL0pJF46vGLegrKy3jVTc3Q7OLDxFaVSl4uw
	 BFUPX9T7bTx0m8p39klf6VD1Feyu7MxT0iOcpInosQHt5dy24SiUqg9UbKjmOUoDYV
	 dt6qUsiXvoEghP44v55Sfv4gbgRA8CogtRfTFozAYvv+scl3PUxWXL31YfaasiDxzs
	 +V07DLxq+WSP1ZdBtHWojhN3LCoQpwTX9dpf6knQUthVISAX7jqWUkIVOgXI7w5dhS
	 QDRDFKWFoODrQ==
Date: Wed, 11 Sep 2024 12:58:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf env: Find correct branch counter info on hybrid
Message-ID: <ZuG-FYTFnE6U3PTn@x1>
References: <20240909184201.553519-1-kan.liang@linux.intel.com>
 <ZuGnCqBa4HZUzrmX@x1>
 <17676366-31b8-4c7c-b2e5-a91b054a5e7c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17676366-31b8-4c7c-b2e5-a91b054a5e7c@linux.intel.com>

On Wed, Sep 11, 2024 at 11:41:54AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-11 10:19 a.m., Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 09, 2024 at 11:42:00AM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> No event is printed in the "Branch Counter" column on hybrid machines.
> >>
> >> For example,
> >>  $perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S"
> >>  -j any,counter
> >>  $perf report --total-cycles
> > 
> > So I tried this on an Intel Hybrid system, I start the TUI, then try 'B'
> > and, after applying your patch:
> > 
> >   0.66%  67.8K  0.00%   75                    ┌─Branch counter abbr list────────────┐ibc_write+18]          libc.so.6
> >   0.63%  65.4K  0.00%  106                  [p│                                     │r_active+159]          [kernel.kallsyms]
> >   0.61%  63.2K  0.01%  175  [native_queued_spi│ The branch counter is not available.│in_lock_slowpath+528]  [kernel.kallsyms]
> >   0.57%  58.4K  0.00%   39         [syscall_ex│Press any key...                     │ser_mode+109]          [kernel.kallsyms]
> >   0.54%  55.6K  0.00%    1  [_IO_file_xsputn@@└─────────────────────────────────────┘BC_2.2.5+316]          libc.so.6
> > 
> > The perf.data was obtained from:
> > 
> > root@number:~# perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S" -j any,counter find /
> > 
> > And:
> > 
> > root@number:~# perf evlist --group 
> > {cpu_core/branch-instructions/pp,cpu_core/branches/}
> > dummy:u
> > root@number:~# 
> > 
> > Only mishap above we discussed already, the missing :S, and then:
> > 
> > root@number:~# perf evlist -v
> > cpu_core/branch-instructions/pp: type: 4 (cpu_core), size: 136, config: 0xc4 (branch-instructions), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER, read_format: ID|GROUP|LOST, disabled: 1, freq: 1, enable_on_exec: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, branch_sample_type: ANY
> 
> For a hybrid client, the "Branch Counter" feature is only supported
> starting from the just released Lunar Lake. Perf falls back to only
> "ANY" on your Raptor Lake.
> 
> The "The branch counter is not available" message is expected.
> 
> Here is the perf evlist result from my Lunar Lake machine,
> 
> #perf evlist -v
> cpu_core/branch-instructions/pp: type: 4 (cpu_core), size: 136, config:
> 0xc4 (branch-instructions), { sample_period, sample_freq }: 4000,
> sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER,
> read_format: ID|GROUP|LOST, disabled: 1, freq: 1, enable_on_exec: 1,
> precise_ip: 2, sample_id_all: 1, exclude_guest: 1, branch_sample_type:
> ANY|COUNTERS

So I'll just take the patch and add these explanations there, ok?

- Arnaldo
 
> 
> Thanks,
> Kan
> > cpu_core/branches/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000004, sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER, read_format: ID|GROUP|LOST, sample_id_all: 1, exclude_guest: 1, branch_sample_type: ANY
> > dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> > root@number:~#
> > 
> >         Version: Intel(R) Core(TM) i7-14700K
> >         Voltage: 1.0 V
> >         External Clock: 100 MHz
> >         Max Speed: 8500 MHz
> >         Current Speed: 3400 MHz
> >         Status: Populated, Enabled
> >         Upgrade: Socket LGA1700
> > 
> > What am I doing wrong not to get to see that "branch counter abbr list"
> > info to then check before/after your patch?
> > 
> > - Arnaldo
> >  
> >>  # Branch counter abbr list:
> >>  # cpu_core/branch-instructions/pp = A
> >>  # cpu_core/branches/ = B
> >>  # '-' No event occurs
> >>  # '+' Event occurrences may be lost due to branch counter saturated
> >>  #
> >>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles  Branch Counter
> >>  # ...............  ..............  ...........  ..........  ..............
> >>            44.54%          727.1K        0.00%           1   |+   |+   |
> >>            36.31%          592.7K        0.00%           2   |+   |+   |
> >>            17.83%          291.1K        0.00%           1   |+   |+   |
> >>
> >> The branch counter information (br_cntr_width and br_cntr_nr) in the
> >> perf_env is retrieved from the CPU_PMU_CAPS. However, the CPU_PMU_CAPS
> >> is not available on hybrid machines. Without the width information, the
> >> number of occurrences of an event cannot be calculated.
> >>
> >> For a hybrid machine, the caps information should be retrieved from the
> >> PMU_CAPS, and stored in the perf_env->pmu_caps.
> >>
> >> Add a perf_env__find_br_cntr_info() to return the correct branch counter
> >> information from the corresponding fields.
> >>
> >> Fixes: 6f9d8d1de2c6 ("perf script: Add branch counters")
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-script.c |  5 +++--
> >>  tools/perf/util/annotate.c  |  5 +++--
> >>  tools/perf/util/env.c       | 15 +++++++++++++++
> >>  tools/perf/util/env.h       |  3 +++
> >>  tools/perf/util/session.c   |  6 ++++--
> >>  5 files changed, 28 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> >> index dbe792b52c5c..a644787fa9e1 100644
> >> --- a/tools/perf/builtin-script.c
> >> +++ b/tools/perf/builtin-script.c
> >> @@ -1241,10 +1241,11 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
> >>  	}
> >>  
> >>  	if (PRINT_FIELD(BRCNTR)) {
> >> -		unsigned int width = evsel__env(evsel)->br_cntr_width;
> >> -		unsigned int i = 0, j, num, mask = (1L << width) - 1;
> >>  		struct evsel *pos = evsel__leader(evsel);
> >> +		unsigned int i = 0, j, num, mask, width;
> >>  
> >> +		perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
> >> +		mask = (1L << width) - 1;
> >>  		printed += fprintf(fp, "br_cntr: ");
> >>  		evlist__for_each_entry_from(evsel->evlist, pos) {
> >>  			if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
> >> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> >> index 4990c70b1794..c6ebde9d40a8 100644
> >> --- a/tools/perf/util/annotate.c
> >> +++ b/tools/perf/util/annotate.c
> >> @@ -333,14 +333,15 @@ static int symbol__account_br_cntr(struct annotated_branch *branch,
> >>  {
> >>  	unsigned int br_cntr_nr = evsel__leader(evsel)->br_cntr_nr;
> >>  	unsigned int base = evsel__leader(evsel)->br_cntr_idx;
> >> -	unsigned int width = evsel__env(evsel)->br_cntr_width;
> >>  	unsigned int off = offset * evsel->evlist->nr_br_cntr;
> >> -	unsigned int i, mask = (1L << width) - 1;
> >>  	u64 *branch_br_cntr = branch->br_cntr;
> >> +	unsigned int i, mask, width;
> >>  
> >>  	if (!br_cntr || !branch_br_cntr)
> >>  		return 0;
> >>  
> >> +	perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
> >> +	mask = (1L << width) - 1;
> >>  	for (i = 0; i < br_cntr_nr; i++) {
> >>  		u64 cntr = (br_cntr >> i * width) & mask;
> >>  
> >> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> >> index a459374d0a1a..1edbccfc3281 100644
> >> --- a/tools/perf/util/env.c
> >> +++ b/tools/perf/util/env.c
> >> @@ -624,3 +624,18 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
> >>  	free(cap_eq);
> >>  	return NULL;
> >>  }
> >> +
> >> +void perf_env__find_br_cntr_info(struct perf_env *env,
> >> +				 unsigned int *nr,
> >> +				 unsigned int *width)
> >> +{
> >> +	if (nr) {
> >> +		*nr = env->cpu_pmu_caps ? env->br_cntr_nr :
> >> +					  env->pmu_caps->br_cntr_nr;
> >> +	}
> >> +
> >> +	if (width) {
> >> +		*width = env->cpu_pmu_caps ? env->br_cntr_width :
> >> +					     env->pmu_caps->br_cntr_width;
> >> +	}
> >> +}
> >> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> >> index 2a2c37cc40b7..51b36c36019b 100644
> >> --- a/tools/perf/util/env.h
> >> +++ b/tools/perf/util/env.h
> >> @@ -192,4 +192,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
> >>  			     const char *cap);
> >>  
> >>  bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
> >> +void perf_env__find_br_cntr_info(struct perf_env *env,
> >> +				 unsigned int *nr,
> >> +				 unsigned int *width);
> >>  #endif /* __PERF_ENV_H */
> >> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >> index b492300ec959..dbaf07bf6c5f 100644
> >> --- a/tools/perf/util/session.c
> >> +++ b/tools/perf/util/session.c
> >> @@ -856,7 +856,6 @@ static void branch_stack__printf(struct perf_sample *sample,
> >>  	struct branch_entry *entries = perf_sample__branch_entries(sample);
> >>  	bool callstack = evsel__has_branch_callstack(evsel);
> >>  	u64 *branch_stack_cntr = sample->branch_stack_cntr;
> >> -	struct perf_env *env = evsel__env(evsel);
> >>  	uint64_t i;
> >>  
> >>  	if (!callstack) {
> >> @@ -900,8 +899,11 @@ static void branch_stack__printf(struct perf_sample *sample,
> >>  	}
> >>  
> >>  	if (branch_stack_cntr) {
> >> +		unsigned int br_cntr_width, br_cntr_nr;
> >> +
> >> +		perf_env__find_br_cntr_info(evsel__env(evsel), &br_cntr_nr, &br_cntr_width);
> >>  		printf("... branch stack counters: nr:%" PRIu64 " (counter width: %u max counter nr:%u)\n",
> >> -			sample->branch_stack->nr, env->br_cntr_width, env->br_cntr_nr);
> >> +			sample->branch_stack->nr, br_cntr_width, br_cntr_nr);
> >>  		for (i = 0; i < sample->branch_stack->nr; i++)
> >>  			printf("..... %2"PRIu64": %016" PRIx64 "\n", i, branch_stack_cntr[i]);
> >>  	}
> >> -- 
> >> 2.38.1
> > 

