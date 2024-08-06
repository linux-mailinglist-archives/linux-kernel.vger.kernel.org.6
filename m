Return-Path: <linux-kernel+bounces-276421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B63949367
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F681F25284
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8F1D47DB;
	Tue,  6 Aug 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsFPlxVZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2F1D1748
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955199; cv=none; b=bjEIcjMhCjae/c1mq+JAtbxAPjE9CRGoqvmJRK88vV4yAhAK/68rJRqB07YoIDPvLGVmzuVqUVyri0SKt8T1pcVlvXBbIvQ6gUpntSt2cQR95IKTmYc7JMcq4d980xxGVwu1RdxOuxePH7gMR93CSXi2xlymbLZsy08GffdyDHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955199; c=relaxed/simple;
	bh=v68hSRbYssgHPOdUrsegsfZqESfEURUFI1ovetWwfZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/Sz4w88NspmhJsJoxu2eI7Hu3V0MMxPMeksL4xMoxaHBkcP8GdGl7VBDpLnTZTmXX30hnaAZbfALI3nc06NxI2rx8AXYNJxcwzWnBSiWSrPoXmu6RPriQTRn0j/2BxKP7B9YEwD1zBc2DDBLO1JN27J7qDQTtZz8lWePPri7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsFPlxVZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722955197; x=1754491197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v68hSRbYssgHPOdUrsegsfZqESfEURUFI1ovetWwfZk=;
  b=UsFPlxVZkTmU+Dss4+rw8sEbBKsFO+gcX9mNADlRrtIBVwYfc6F3LpUt
   Ji6LAHlOMxJQXkdtNmnuADDzrSkXwkFfiPxAr9lpS6VEt4zkreR+ugstL
   tWGKMe9yQu9hYi7iMr6oCNUcW1br2HXR5NUzW55I+4OMRTD0k7yCcQN0a
   s2ZXvbr5iQaCo8RNzRMEbph46lgXvWDGfBORdYKnV60Vstc3TmWFOnh1j
   CRqYNCnAOKf9Rq7GKMsBCbijv6E50T1LMc3QuxvhPnqUYGVPdoUK1UX4Q
   EQeiSxQ9XtiWX2H1Le0qyP3kQllwstknTiH0TDKKd9uhk6P0UDV1xKSqa
   A==;
X-CSE-ConnectionGUID: AWYhwg5fQA+n1xMuivKMww==
X-CSE-MsgGUID: n7o8qP9rTfiNoljDxF79wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43501776"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="43501776"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:39:57 -0700
X-CSE-ConnectionGUID: HVHRI5pXTp2gRhiQYiWpDQ==
X-CSE-MsgGUID: JD3uxjkPTJO70/Zu8tmObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="87176887"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:39:57 -0700
Received: from [10.212.84.25] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8B00B20CFECD;
	Tue,  6 Aug 2024 07:39:55 -0700 (PDT)
Message-ID: <9b7c5c61-ef8c-43a8-bf1c-7ff32b4c8bee@linux.intel.com>
Date: Tue, 6 Aug 2024 10:39:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] perf report: Display the branch counter histogram
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
 ak@linux.intel.com, eranian@google.com
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-7-kan.liang@linux.intel.com>
 <CAM9d7cgQWLdec063U+c1su_O9jchv5HSTQ0S0tQJ_q96hjgjXw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cgQWLdec063U+c1su_O9jchv5HSTQ0S0tQJ_q96hjgjXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-08-02 8:18 p.m., Namhyung Kim wrote:
> On Wed, Jul 3, 2024 at 1:03 PM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Reusing the existing --total-cycles option to display the branch
>> counters. Add a new PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER to display
>> the logged branch counter events. They are shown right after all the
>> cycle-related annotations.
>> Extend the struct block_info to store and pass the branch counter
>> related information.
>>
>> The annotation_br_cntr_entry() is to print the histogram of each branch
>> counter event.
>> The annotation_br_cntr_abbr_list() prints the branch counter's
>> abbreviation list. Press 'B' to display the list in the TUI mode.
>>
>> $perf record -e "{branch-instructions:ppp,branch-misses}:S" -j any,counter
>> $perf report  --total-cycles --stdio
>>
>>  # To display the perf.data header info, please use --header/--header-only options.
>>  #
>>  #
>>  # Total Lost Samples: 0
>>  #
>>  # Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }'
>>  # Event count (approx.): 1610046
>>  #
>>  # Branch counter abbr list:
>>  # branch-instructions:ppp = A
>>  # branch-misses = B
>>  # '-' No event occurs
>>  # '+' Event occurrences may be lost due to branch counter saturated
>>  #
>>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          Branch Counter [Program Block Range]
>>  # ...............  ..............  ...........  ..........  ......................  ..................
>>  #
>>            57.55%            2.5M        0.00%           3             |A   |-   |                 ...
>>            25.27%            1.1M        0.00%           2             |AA  |-   |                 ...
>>            15.61%          667.2K        0.00%           1             |A   |-   |                 ...
>>             0.16%            6.9K        0.81%         575             |A   |-   |                 ...
>>             0.16%            6.8K        1.38%         977             |AA  |-   |                 ...
>>             0.16%            6.8K        0.04%          28             |AA  |B   |                 ...
>>             0.15%            6.6K        1.33%         946             |A   |-   |                 ...
>>             0.11%            4.5K        0.06%          46             |AAA+|-   |                 ...
>>             0.10%            4.4K        0.88%         624             |A   |-   |                 ...
>>             0.09%            3.7K        0.74%         524             |AAA+|B   |                 ...
> 
> I think this format assumes short width and might not work
> well when it has more events with bigger width.  Maybe
> A=<n>, B=<n> ?

The purpose of "AAA" is to print a histogram here which can give the end
user a straightforward image of the distribution. The A=<n> may not be
that obvious.

I don't think there is a plan to increase the saturation of the counter.
So 4 bits of width should last for a long time. Other ARCHs don't have
such a feature either. I think I can the change the code to force the 4
bits of width now. For more that 3 events, the perf tool can convert it
to a "+". We may update the perf tool for a more specific histogram
later, if the saturation is changed. What do you think?

Thanks,
Kan
> 
> Thanks,
> Namhyung
> 
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/Documentation/perf-report.txt |   1 +
>>  tools/perf/builtin-diff.c                |   4 +-
>>  tools/perf/builtin-report.c              |  20 ++++-
>>  tools/perf/ui/browsers/hists.c           |  17 +++-
>>  tools/perf/util/annotate.c               | 101 +++++++++++++++++++++++
>>  tools/perf/util/annotate.h               |   3 +
>>  tools/perf/util/block-info.c             |  66 +++++++++++++--
>>  tools/perf/util/block-info.h             |   8 +-
>>  8 files changed, 202 insertions(+), 18 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
>> index d2b1593ef700..f35189d5ff1e 100644
>> --- a/tools/perf/Documentation/perf-report.txt
>> +++ b/tools/perf/Documentation/perf-report.txt
>> @@ -614,6 +614,7 @@ include::itrace.txt[]
>>         'Avg Cycles%'     - block average sampled cycles / sum of total block average
>>                             sampled cycles
>>         'Avg Cycles'      - block average sampled cycles
>> +       'Branch Counter'  - block branch counter histogram
>>
>>  --skip-empty::
>>         Do not print 0 results in the --stat output.
>> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
>> index 2d9226b1de52..de24892dc7b8 100644
>> --- a/tools/perf/builtin-diff.c
>> +++ b/tools/perf/builtin-diff.c
>> @@ -705,7 +705,7 @@ static void hists__precompute(struct hists *hists)
>>                 if (compute == COMPUTE_CYCLES) {
>>                         bh = container_of(he, struct block_hist, he);
>>                         init_block_hist(bh);
>> -                       block_info__process_sym(he, bh, NULL, 0);
>> +                       block_info__process_sym(he, bh, NULL, 0, 0);
>>                 }
>>
>>                 data__for_each_file_new(i, d) {
>> @@ -728,7 +728,7 @@ static void hists__precompute(struct hists *hists)
>>                                 pair_bh = container_of(pair, struct block_hist,
>>                                                        he);
>>                                 init_block_hist(pair_bh);
>> -                               block_info__process_sym(pair, pair_bh, NULL, 0);
>> +                               block_info__process_sym(pair, pair_bh, NULL, 0, 0);
>>
>>                                 bh = container_of(he, struct block_hist, he);
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index da8d13bbb500..a0f864f2e996 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -575,6 +575,13 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
>>                 hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
>>
>>                 if (rep->total_cycles_mode) {
>> +                       char *buf;
>> +
>> +                       if (!annotation_br_cntr_abbr_list(&buf, pos, true)) {
>> +                               fprintf(stdout, "%s", buf);
>> +                               fprintf(stdout, "#\n");
>> +                               free(buf);
>> +                       }
>>                         report__browse_block_hists(&rep->block_reports[i - 1].hist,
>>                                                    rep->min_percent, pos, NULL);
>>                         continue;
>> @@ -1121,18 +1128,23 @@ static int __cmd_report(struct report *rep)
>>         report__output_resort(rep);
>>
>>         if (rep->total_cycles_mode) {
>> -               int block_hpps[6] = {
>> +               int nr_hpps = 4;
>> +               int block_hpps[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
>>                         PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>>                         PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>>                         PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>>                         PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>> -                       PERF_HPP_REPORT__BLOCK_RANGE,
>> -                       PERF_HPP_REPORT__BLOCK_DSO,
>>                 };
>>
>> +               if (session->evlist->nr_br_cntr > 0)
>> +                       block_hpps[nr_hpps++] = PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER;
>> +
>> +               block_hpps[nr_hpps++] = PERF_HPP_REPORT__BLOCK_RANGE;
>> +               block_hpps[nr_hpps++] = PERF_HPP_REPORT__BLOCK_DSO;
>> +
>>                 rep->block_reports = block_info__create_report(session->evlist,
>>                                                                rep->total_cycles,
>> -                                                              block_hpps, 6,
>> +                                                              block_hpps, nr_hpps,
>>                                                                &rep->nr_block_reports);
>>                 if (!rep->block_reports)
>>                         return -1;
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index b7219df51236..73d766eac75b 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -3684,8 +3684,10 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>>         struct hist_browser *browser;
>>         int key = -1;
>>         struct popup_action action;
>> +       char *br_cntr_text = NULL;
>>         static const char help[] =
>> -       " q             Quit \n";
>> +       " q             Quit \n"
>> +       " B             Branch counter abbr list (Optional)\n";
>>
>>         browser = hist_browser__new(hists);
>>         if (!browser)
>> @@ -3703,6 +3705,8 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>>
>>         memset(&action, 0, sizeof(action));
>>
>> +       annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
>> +
>>         while (1) {
>>                 key = hist_browser__run(browser, "? - help", true, 0);
>>
>> @@ -3723,6 +3727,16 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>>                         action.ms.sym = browser->selection->sym;
>>                         do_annotate(browser, &action);
>>                         continue;
>> +               case 'B':
>> +                       if (br_cntr_text) {
>> +                               ui__question_window("Branch counter abbr list",
>> +                                                   br_cntr_text, "Press any key...", 0);
>> +                       } else {
>> +                               ui__question_window("Branch counter abbr list",
>> +                                                   "\n The branch counter is not available.\n",
>> +                                                   "Press any key...", 0);
>> +                       }
>> +                       continue;
>>                 default:
>>                         break;
>>                 }
>> @@ -3730,5 +3744,6 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>>
>>  out:
>>         hist_browser__delete(browser);
>> +       free(br_cntr_text);
>>         return 0;
>>  }
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 6baa0671598e..f20f9e40ef0d 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -40,6 +40,7 @@
>>  #include "namespaces.h"
>>  #include "thread.h"
>>  #include "hashmap.h"
>> +#include "strbuf.h"
>>  #include <regex.h>
>>  #include <linux/bitops.h>
>>  #include <linux/kernel.h>
>> @@ -47,6 +48,7 @@
>>  #include <linux/zalloc.h>
>>  #include <subcmd/parse-options.h>
>>  #include <subcmd/run-command.h>
>> +#include <math.h>
>>
>>  /* FIXME: For the HE_COLORSET */
>>  #include "ui/browser.h"
>> @@ -1706,6 +1708,105 @@ static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
>>                   ipc, coverage);
>>  }
>>
>> +int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header)
>> +{
>> +       struct evsel *pos;
>> +       struct strbuf sb;
>> +
>> +       if (evsel->evlist->nr_br_cntr <= 0)
>> +               return -ENOTSUP;
>> +
>> +       strbuf_init(&sb, /*hint=*/ 0);
>> +
>> +       if (header && strbuf_addf(&sb, "# Branch counter abbr list:\n"))
>> +               goto err;
>> +
>> +       evlist__for_each_entry(evsel->evlist, pos) {
>> +               if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
>> +                       continue;
>> +               if (header && strbuf_addf(&sb, "#"))
>> +                       goto err;
>> +
>> +               if (strbuf_addf(&sb, " %s = %s\n", pos->name, pos->abbr_name))
>> +                       goto err;
>> +       }
>> +
>> +       if (header && strbuf_addf(&sb, "#"))
>> +               goto err;
>> +       if (strbuf_addf(&sb, " '-' No event occurs\n"))
>> +               goto err;
>> +
>> +       if (header && strbuf_addf(&sb, "#"))
>> +               goto err;
>> +       if (strbuf_addf(&sb, " '+' Event occurrences may be lost due to branch counter saturated\n"))
>> +               goto err;
>> +
>> +       *str = strbuf_detach(&sb, NULL);
>> +
>> +       return 0;
>> +err:
>> +       strbuf_release(&sb);
>> +       return -ENOMEM;
>> +}
>> +
>> +int annotation_br_cntr_entry(char **str, int br_cntr_nr,
>> +                            u64 *br_cntr, int num_aggr,
>> +                            struct evsel *evsel)
>> +{
>> +       struct evsel *pos = evsel ? evlist__first(evsel->evlist) : NULL;
>> +       int i, j, avg, used;
>> +       struct strbuf sb;
>> +
>> +       strbuf_init(&sb, /*hint=*/ 0);
>> +       for (i = 0; i < br_cntr_nr; i++) {
>> +               used = 0;
>> +               avg = ceil((double)(br_cntr[i] & ~ANNOTATION__BR_CNTR_SATURATED_FLAG) /
>> +                          (double)num_aggr);
>> +
>> +               if (strbuf_addch(&sb, '|'))
>> +                       goto err;
>> +
>> +               if (!br_cntr[i]) {
>> +                       if (strbuf_addch(&sb, '-'))
>> +                               goto err;
>> +                       used++;
>> +               } else {
>> +                       evlist__for_each_entry_from(evsel->evlist, pos) {
>> +                               if ((pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) &&
>> +                                   (pos->br_cntr_idx == i))
>> +                                       break;
>> +                       }
>> +                       for (j = 0; j < avg; j++, used++) {
>> +                               if (strbuf_addstr(&sb, pos->abbr_name))
>> +                                       goto err;
>> +                       }
>> +
>> +                       if (br_cntr[i] & ANNOTATION__BR_CNTR_SATURATED_FLAG) {
>> +                               if (strbuf_addch(&sb, '+'))
>> +                                       goto err;
>> +                               used++;
>> +                       }
>> +                       pos = list_next_entry(pos, core.node);
>> +               }
>> +
>> +               /* Assume the branch counter saturated at 3 */
>> +               for (j = used; j < 4; j++) {
>> +                       if (strbuf_addch(&sb, ' '))
>> +                               goto err;
>> +               }
>> +       }
>> +
>> +       if (strbuf_addch(&sb, br_cntr_nr ? '|' : ' '))
>> +               goto err;
>> +
>> +       *str = strbuf_detach(&sb, NULL);
>> +
>> +       return 0;
>> +err:
>> +       strbuf_release(&sb);
>> +       return -ENOMEM;
>> +}
>> +
>>  static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
>>                                      bool first_line, bool current_entry, bool change_color, int width,
>>                                      void *obj, unsigned int percent_type,
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index f39dd5d7b05e..2ff79a389dc0 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -548,4 +548,7 @@ struct annotated_basic_block {
>>  int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
>>                               struct list_head *head);
>>
>> +int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>> +                            int num_aggr, struct evsel *evsel);
>> +int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
>>  #endif /* __PERF_ANNOTATE_H */
>> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
>> index 04068d48683f..649392bee7ed 100644
>> --- a/tools/perf/util/block-info.c
>> +++ b/tools/perf/util/block-info.c
>> @@ -40,16 +40,32 @@ static struct block_header_column {
>>         [PERF_HPP_REPORT__BLOCK_DSO] = {
>>                 .name = "Shared Object",
>>                 .width = 20,
>> +       },
>> +       [PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER] = {
>> +               .name = "Branch Counter",
>> +               .width = 30,
>>         }
>>  };
>>
>> -struct block_info *block_info__new(void)
>> +static struct block_info *block_info__new(unsigned int br_cntr_nr)
>>  {
>> -       return zalloc(sizeof(struct block_info));
>> +       struct block_info *bi = zalloc(sizeof(struct block_info));
>> +
>> +       if (bi && br_cntr_nr) {
>> +               bi->br_cntr = calloc(br_cntr_nr, sizeof(u64));
>> +               if (!bi->br_cntr) {
>> +                       free(bi);
>> +                       return NULL;
>> +               }
>> +       }
>> +
>> +       return bi;
>>  }
>>
>>  void block_info__delete(struct block_info *bi)
>>  {
>> +       if (bi)
>> +               free(bi->br_cntr);
>>         free(bi);
>>  }
>>
>> @@ -86,7 +102,8 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>>
>>  static void init_block_info(struct block_info *bi, struct symbol *sym,
>>                             struct cyc_hist *ch, int offset,
>> -                           u64 total_cycles)
>> +                           u64 total_cycles, unsigned int br_cntr_nr,
>> +                           u64 *br_cntr, struct evsel *evsel)
>>  {
>>         bi->sym = sym;
>>         bi->start = ch->start;
>> @@ -99,10 +116,18 @@ static void init_block_info(struct block_info *bi, struct symbol *sym,
>>
>>         memcpy(bi->cycles_spark, ch->cycles_spark,
>>                NUM_SPARKS * sizeof(u64));
>> +
>> +       if (br_cntr && br_cntr_nr) {
>> +               bi->br_cntr_nr = br_cntr_nr;
>> +               memcpy(bi->br_cntr, &br_cntr[offset * br_cntr_nr],
>> +                      br_cntr_nr * sizeof(u64));
>> +       }
>> +       bi->evsel = evsel;
>>  }
>>
>>  int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
>> -                           u64 *block_cycles_aggr, u64 total_cycles)
>> +                           u64 *block_cycles_aggr, u64 total_cycles,
>> +                           unsigned int br_cntr_nr)
>>  {
>>         struct annotation *notes;
>>         struct cyc_hist *ch;
>> @@ -125,12 +150,14 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
>>                         struct block_info *bi;
>>                         struct hist_entry *he_block;
>>
>> -                       bi = block_info__new();
>> +                       bi = block_info__new(br_cntr_nr);
>>                         if (!bi)
>>                                 return -1;
>>
>>                         init_block_info(bi, he->ms.sym, &ch[i], i,
>> -                                       total_cycles);
>> +                                       total_cycles, br_cntr_nr,
>> +                                       notes->branch->br_cntr,
>> +                                       hists_to_evsel(he->hists));
>>                         cycles += bi->cycles_aggr / bi->num_aggr;
>>
>>                         he_block = hists__add_entry_block(&bh->block_hists,
>> @@ -327,6 +354,24 @@ static void init_block_header(struct block_fmt *block_fmt)
>>         fmt->width = block_column_width;
>>  }
>>
>> +static int block_branch_counter_entry(struct perf_hpp_fmt *fmt,
>> +                                     struct perf_hpp *hpp,
>> +                                     struct hist_entry *he)
>> +{
>> +       struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +       struct block_info *bi = he->block_info;
>> +       char *buf;
>> +       int ret;
>> +
>> +       if (annotation_br_cntr_entry(&buf, bi->br_cntr_nr, bi->br_cntr,
>> +                                    bi->num_aggr, bi->evsel))
>> +               return 0;
>> +
>> +       ret = scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
>> +       free(buf);
>> +       return ret;
>> +}
>> +
>>  static void hpp_register(struct block_fmt *block_fmt, int idx,
>>                          struct perf_hpp_list *hpp_list)
>>  {
>> @@ -357,6 +402,9 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
>>         case PERF_HPP_REPORT__BLOCK_DSO:
>>                 fmt->entry = block_dso_entry;
>>                 break;
>> +       case PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER:
>> +               fmt->entry = block_branch_counter_entry;
>> +               break;
>>         default:
>>                 return;
>>         }
>> @@ -390,7 +438,7 @@ static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts,
>>  static int process_block_report(struct hists *hists,
>>                                 struct block_report *block_report,
>>                                 u64 total_cycles, int *block_hpps,
>> -                               int nr_hpps)
>> +                               int nr_hpps, unsigned int br_cntr_nr)
>>  {
>>         struct rb_node *next = rb_first_cached(&hists->entries);
>>         struct block_hist *bh = &block_report->hist;
>> @@ -405,7 +453,7 @@ static int process_block_report(struct hists *hists,
>>         while (next) {
>>                 he = rb_entry(next, struct hist_entry, rb_node);
>>                 block_info__process_sym(he, bh, &block_report->cycles,
>> -                                       total_cycles);
>> +                                       total_cycles, br_cntr_nr);
>>                 next = rb_next(&he->rb_node);
>>         }
>>
>> @@ -435,7 +483,7 @@ struct block_report *block_info__create_report(struct evlist *evlist,
>>                 struct hists *hists = evsel__hists(pos);
>>
>>                 process_block_report(hists, &block_reports[i], total_cycles,
>> -                                    block_hpps, nr_hpps);
>> +                                    block_hpps, nr_hpps, evlist->nr_br_cntr);
>>                 i++;
>>         }
>>
>> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
>> index 0b9e1aad4c55..b9329dc3ab59 100644
>> --- a/tools/perf/util/block-info.h
>> +++ b/tools/perf/util/block-info.h
>> @@ -18,6 +18,9 @@ struct block_info {
>>         u64                     total_cycles;
>>         int                     num;
>>         int                     num_aggr;
>> +       int                     br_cntr_nr;
>> +       u64                     *br_cntr;
>> +       struct evsel            *evsel;
>>  };
>>
>>  struct block_fmt {
>> @@ -36,6 +39,7 @@ enum {
>>         PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>>         PERF_HPP_REPORT__BLOCK_RANGE,
>>         PERF_HPP_REPORT__BLOCK_DSO,
>> +       PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER,
>>         PERF_HPP_REPORT__BLOCK_MAX_INDEX
>>  };
>>
>> @@ -46,7 +50,6 @@ struct block_report {
>>         int                     nr_fmts;
>>  };
>>
>> -struct block_info *block_info__new(void);
>>  void block_info__delete(struct block_info *bi);
>>
>>  int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right);
>> @@ -55,7 +58,8 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>>                         struct hist_entry *left, struct hist_entry *right);
>>
>>  int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
>> -                           u64 *block_cycles_aggr, u64 total_cycles);
>> +                           u64 *block_cycles_aggr, u64 total_cycles,
>> +                           unsigned int br_cntr_nr);
>>
>>  struct block_report *block_info__create_report(struct evlist *evlist,
>>                                                u64 total_cycles,
>> --
>> 2.38.1
>>
> 

