Return-Path: <linux-kernel+bounces-273247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D057E94666E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 02:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E9B2181E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C0187F;
	Sat,  3 Aug 2024 00:18:22 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E24687
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722644301; cv=none; b=A+VvCxTTGSMr8tJc3nOdrLvgGtf++8qy7G0DrE4fGcYjdxm33CTky8rgOao2zISEu8Z5ANnQodPFi1eL8c7qZ/CUCOBAVrq1FzkHhoQSdfDUsRKT6RgjYTk8JcarugdirlAC0ugXSsm8p09CiVYK0TcAYHWBU3owFpTPjoFTVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722644301; c=relaxed/simple;
	bh=DgRzhSdto65/CIoKkGQrf/DbDzP2Yu9obFAuBl/ghIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmF8VcB1TLgTFuit9ggbMdhteyHUovku7zZD9604PaEAHf4SozTh9aFcTyq45OnAZ3SJSvyQMv4B7GuIbNMN8UlKffnXhxsxdpE4RcjvmGc/lze/Bb0uI6eftMedBtFchkMGds8v9QyJ0G2N3OcYV+DXrlTAX7gPTFEpQbqijt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so2998970a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 17:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722644298; x=1723249098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixqSzFubw9i2X+ARQcm5z+nOA2aqzT2yrQFzWOtCIqw=;
        b=dEvTLvwuE/jpzU93IASAbVQUDsVg1KD+GsRx67A3o2IElCNqltnmdUQimpU5nHMffP
         x57Gh3Ak3QYBZ5ujBn7K6QOWmsY4WNIQ2/A7iYbldv0+hgbDKde//I2WUa94qQsNzIEC
         lg5b9Y92LH1c5QDzpxS/A93f6i6CIkQ8iXHi10UR+weYbwpD7vDunE+rnGgYwNxOAF0j
         YhzAz8JM8cBPtjeKAy6Gci7Mtau6KrH4gWeXf1Wqf8PgVsfGUgQYU1akLgjYEQE8EqHB
         4qby7dqgxTU22ic55XxkKS7GajrQYoypgMWqxDlMB4HuxbxBu1Pcx+TbIItU2h/ZAbFN
         xIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHd7wYii+fzL/kAGTCBoDCfB9jKXuEbS7YJOrtL1P8kNI3/I1POK28+5+PC9blYPTF3uW8XFQqttk6btnqPVI6X/NoZyWq7Em75V4e
X-Gm-Message-State: AOJu0YxLfVK2KIWuYeRW6NQqjDWhVTJk0pxliD6ve+XTN/qRw8nzETuY
	Uco8dx6FGbfUO1AC5qn85YNYSMGAn53MK+bMZK3jw1VzWlotwApooHMytmn6nS8ymyUyrt/V2nw
	rmOrrmji8GeL60ZmBMbiLOfPCqCNPlQpY
X-Google-Smtp-Source: AGHT+IGglHH6M+si7La92pt141lDjljt1wDPypY3oOBcZy+72ypLs/0yBn2niya2KHneq3mbEINeCwS6maRQXx7chsU=
X-Received: by 2002:a17:90a:c68b:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2cffa0e3043mr7987829a91.10.1722644298006; Fri, 02 Aug 2024
 17:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703200356.852727-1-kan.liang@linux.intel.com> <20240703200356.852727-7-kan.liang@linux.intel.com>
In-Reply-To: <20240703200356.852727-7-kan.liang@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Aug 2024 17:18:07 -0700
Message-ID: <CAM9d7cgQWLdec063U+c1su_O9jchv5HSTQ0S0tQJ_q96hjgjXw@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf report: Display the branch counter histogram
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:03=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Reusing the existing --total-cycles option to display the branch
> counters. Add a new PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER to display
> the logged branch counter events. They are shown right after all the
> cycle-related annotations.
> Extend the struct block_info to store and pass the branch counter
> related information.
>
> The annotation_br_cntr_entry() is to print the histogram of each branch
> counter event.
> The annotation_br_cntr_abbr_list() prints the branch counter's
> abbreviation list. Press 'B' to display the list in the TUI mode.
>
> $perf record -e "{branch-instructions:ppp,branch-misses}:S" -j any,counte=
r
> $perf report  --total-cycles --stdio
>
>  # To display the perf.data header info, please use --header/--header-onl=
y options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 1M of events 'anon group { branch-instructions:ppp, branch-mi=
sses }'
>  # Event count (approx.): 1610046
>  #
>  # Branch counter abbr list:
>  # branch-instructions:ppp =3D A
>  # branch-misses =3D B
>  # '-' No event occurs
>  # '+' Event occurrences may be lost due to branch counter saturated
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          Bran=
ch Counter [Program Block Range]
>  # ...............  ..............  ...........  ..........  ............=
..........  ..................
>  #
>            57.55%            2.5M        0.00%           3             |A=
   |-   |                 ...
>            25.27%            1.1M        0.00%           2             |A=
A  |-   |                 ...
>            15.61%          667.2K        0.00%           1             |A=
   |-   |                 ...
>             0.16%            6.9K        0.81%         575             |A=
   |-   |                 ...
>             0.16%            6.8K        1.38%         977             |A=
A  |-   |                 ...
>             0.16%            6.8K        0.04%          28             |A=
A  |B   |                 ...
>             0.15%            6.6K        1.33%         946             |A=
   |-   |                 ...
>             0.11%            4.5K        0.06%          46             |A=
AA+|-   |                 ...
>             0.10%            4.4K        0.88%         624             |A=
   |-   |                 ...
>             0.09%            3.7K        0.74%         524             |A=
AA+|B   |                 ...

I think this format assumes short width and might not work
well when it has more events with bigger width.  Maybe
A=3D<n>, B=3D<n> ?

Thanks,
Namhyung

>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-report.txt |   1 +
>  tools/perf/builtin-diff.c                |   4 +-
>  tools/perf/builtin-report.c              |  20 ++++-
>  tools/perf/ui/browsers/hists.c           |  17 +++-
>  tools/perf/util/annotate.c               | 101 +++++++++++++++++++++++
>  tools/perf/util/annotate.h               |   3 +
>  tools/perf/util/block-info.c             |  66 +++++++++++++--
>  tools/perf/util/block-info.h             |   8 +-
>  8 files changed, 202 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docume=
ntation/perf-report.txt
> index d2b1593ef700..f35189d5ff1e 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -614,6 +614,7 @@ include::itrace.txt[]
>         'Avg Cycles%'     - block average sampled cycles / sum of total b=
lock average
>                             sampled cycles
>         'Avg Cycles'      - block average sampled cycles
> +       'Branch Counter'  - block branch counter histogram
>
>  --skip-empty::
>         Do not print 0 results in the --stat output.
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 2d9226b1de52..de24892dc7b8 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -705,7 +705,7 @@ static void hists__precompute(struct hists *hists)
>                 if (compute =3D=3D COMPUTE_CYCLES) {
>                         bh =3D container_of(he, struct block_hist, he);
>                         init_block_hist(bh);
> -                       block_info__process_sym(he, bh, NULL, 0);
> +                       block_info__process_sym(he, bh, NULL, 0, 0);
>                 }
>
>                 data__for_each_file_new(i, d) {
> @@ -728,7 +728,7 @@ static void hists__precompute(struct hists *hists)
>                                 pair_bh =3D container_of(pair, struct blo=
ck_hist,
>                                                        he);
>                                 init_block_hist(pair_bh);
> -                               block_info__process_sym(pair, pair_bh, NU=
LL, 0);
> +                               block_info__process_sym(pair, pair_bh, NU=
LL, 0, 0);
>
>                                 bh =3D container_of(he, struct block_hist=
, he);
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index da8d13bbb500..a0f864f2e996 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -575,6 +575,13 @@ static int evlist__tty_browse_hists(struct evlist *e=
vlist, struct report *rep, c
>                 hists__fprintf_nr_sample_events(hists, rep, evname, stdou=
t);
>
>                 if (rep->total_cycles_mode) {
> +                       char *buf;
> +
> +                       if (!annotation_br_cntr_abbr_list(&buf, pos, true=
)) {
> +                               fprintf(stdout, "%s", buf);
> +                               fprintf(stdout, "#\n");
> +                               free(buf);
> +                       }
>                         report__browse_block_hists(&rep->block_reports[i =
- 1].hist,
>                                                    rep->min_percent, pos,=
 NULL);
>                         continue;
> @@ -1121,18 +1128,23 @@ static int __cmd_report(struct report *rep)
>         report__output_resort(rep);
>
>         if (rep->total_cycles_mode) {
> -               int block_hpps[6] =3D {
> +               int nr_hpps =3D 4;
> +               int block_hpps[PERF_HPP_REPORT__BLOCK_MAX_INDEX] =3D {
>                         PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>                         PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>                         PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>                         PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
> -                       PERF_HPP_REPORT__BLOCK_RANGE,
> -                       PERF_HPP_REPORT__BLOCK_DSO,
>                 };
>
> +               if (session->evlist->nr_br_cntr > 0)
> +                       block_hpps[nr_hpps++] =3D PERF_HPP_REPORT__BLOCK_=
BRANCH_COUNTER;
> +
> +               block_hpps[nr_hpps++] =3D PERF_HPP_REPORT__BLOCK_RANGE;
> +               block_hpps[nr_hpps++] =3D PERF_HPP_REPORT__BLOCK_DSO;
> +
>                 rep->block_reports =3D block_info__create_report(session-=
>evlist,
>                                                                rep->total=
_cycles,
> -                                                              block_hpps=
, 6,
> +                                                              block_hpps=
, nr_hpps,
>                                                                &rep->nr_b=
lock_reports);
>                 if (!rep->block_reports)
>                         return -1;
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index b7219df51236..73d766eac75b 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3684,8 +3684,10 @@ int block_hists_tui_browse(struct block_hist *bh, =
struct evsel *evsel,
>         struct hist_browser *browser;
>         int key =3D -1;
>         struct popup_action action;
> +       char *br_cntr_text =3D NULL;
>         static const char help[] =3D
> -       " q             Quit \n";
> +       " q             Quit \n"
> +       " B             Branch counter abbr list (Optional)\n";
>
>         browser =3D hist_browser__new(hists);
>         if (!browser)
> @@ -3703,6 +3705,8 @@ int block_hists_tui_browse(struct block_hist *bh, s=
truct evsel *evsel,
>
>         memset(&action, 0, sizeof(action));
>
> +       annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
> +
>         while (1) {
>                 key =3D hist_browser__run(browser, "? - help", true, 0);
>
> @@ -3723,6 +3727,16 @@ int block_hists_tui_browse(struct block_hist *bh, =
struct evsel *evsel,
>                         action.ms.sym =3D browser->selection->sym;
>                         do_annotate(browser, &action);
>                         continue;
> +               case 'B':
> +                       if (br_cntr_text) {
> +                               ui__question_window("Branch counter abbr =
list",
> +                                                   br_cntr_text, "Press =
any key...", 0);
> +                       } else {
> +                               ui__question_window("Branch counter abbr =
list",
> +                                                   "\n The branch counte=
r is not available.\n",
> +                                                   "Press any key...", 0=
);
> +                       }
> +                       continue;
>                 default:
>                         break;
>                 }
> @@ -3730,5 +3744,6 @@ int block_hists_tui_browse(struct block_hist *bh, s=
truct evsel *evsel,
>
>  out:
>         hist_browser__delete(browser);
> +       free(br_cntr_text);
>         return 0;
>  }
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 6baa0671598e..f20f9e40ef0d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -40,6 +40,7 @@
>  #include "namespaces.h"
>  #include "thread.h"
>  #include "hashmap.h"
> +#include "strbuf.h"
>  #include <regex.h>
>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
> @@ -47,6 +48,7 @@
>  #include <linux/zalloc.h>
>  #include <subcmd/parse-options.h>
>  #include <subcmd/run-command.h>
> +#include <math.h>
>
>  /* FIXME: For the HE_COLORSET */
>  #include "ui/browser.h"
> @@ -1706,6 +1708,105 @@ static void ipc_coverage_string(char *bf, int siz=
e, struct annotation *notes)
>                   ipc, coverage);
>  }
>
> +int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool h=
eader)
> +{
> +       struct evsel *pos;
> +       struct strbuf sb;
> +
> +       if (evsel->evlist->nr_br_cntr <=3D 0)
> +               return -ENOTSUP;
> +
> +       strbuf_init(&sb, /*hint=3D*/ 0);
> +
> +       if (header && strbuf_addf(&sb, "# Branch counter abbr list:\n"))
> +               goto err;
> +
> +       evlist__for_each_entry(evsel->evlist, pos) {
> +               if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRA=
NCH_COUNTERS))
> +                       continue;
> +               if (header && strbuf_addf(&sb, "#"))
> +                       goto err;
> +
> +               if (strbuf_addf(&sb, " %s =3D %s\n", pos->name, pos->abbr=
_name))
> +                       goto err;
> +       }
> +
> +       if (header && strbuf_addf(&sb, "#"))
> +               goto err;
> +       if (strbuf_addf(&sb, " '-' No event occurs\n"))
> +               goto err;
> +
> +       if (header && strbuf_addf(&sb, "#"))
> +               goto err;
> +       if (strbuf_addf(&sb, " '+' Event occurrences may be lost due to b=
ranch counter saturated\n"))
> +               goto err;
> +
> +       *str =3D strbuf_detach(&sb, NULL);
> +
> +       return 0;
> +err:
> +       strbuf_release(&sb);
> +       return -ENOMEM;
> +}
> +
> +int annotation_br_cntr_entry(char **str, int br_cntr_nr,
> +                            u64 *br_cntr, int num_aggr,
> +                            struct evsel *evsel)
> +{
> +       struct evsel *pos =3D evsel ? evlist__first(evsel->evlist) : NULL=
;
> +       int i, j, avg, used;
> +       struct strbuf sb;
> +
> +       strbuf_init(&sb, /*hint=3D*/ 0);
> +       for (i =3D 0; i < br_cntr_nr; i++) {
> +               used =3D 0;
> +               avg =3D ceil((double)(br_cntr[i] & ~ANNOTATION__BR_CNTR_S=
ATURATED_FLAG) /
> +                          (double)num_aggr);
> +
> +               if (strbuf_addch(&sb, '|'))
> +                       goto err;
> +
> +               if (!br_cntr[i]) {
> +                       if (strbuf_addch(&sb, '-'))
> +                               goto err;
> +                       used++;
> +               } else {
> +                       evlist__for_each_entry_from(evsel->evlist, pos) {
> +                               if ((pos->core.attr.branch_sample_type & =
PERF_SAMPLE_BRANCH_COUNTERS) &&
> +                                   (pos->br_cntr_idx =3D=3D i))
> +                                       break;
> +                       }
> +                       for (j =3D 0; j < avg; j++, used++) {
> +                               if (strbuf_addstr(&sb, pos->abbr_name))
> +                                       goto err;
> +                       }
> +
> +                       if (br_cntr[i] & ANNOTATION__BR_CNTR_SATURATED_FL=
AG) {
> +                               if (strbuf_addch(&sb, '+'))
> +                                       goto err;
> +                               used++;
> +                       }
> +                       pos =3D list_next_entry(pos, core.node);
> +               }
> +
> +               /* Assume the branch counter saturated at 3 */
> +               for (j =3D used; j < 4; j++) {
> +                       if (strbuf_addch(&sb, ' '))
> +                               goto err;
> +               }
> +       }
> +
> +       if (strbuf_addch(&sb, br_cntr_nr ? '|' : ' '))
> +               goto err;
> +
> +       *str =3D strbuf_detach(&sb, NULL);
> +
> +       return 0;
> +err:
> +       strbuf_release(&sb);
> +       return -ENOMEM;
> +}
> +
>  static void __annotation_line__write(struct annotation_line *al, struct =
annotation *notes,
>                                      bool first_line, bool current_entry,=
 bool change_color, int width,
>                                      void *obj, unsigned int percent_type=
,
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index f39dd5d7b05e..2ff79a389dc0 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -548,4 +548,7 @@ struct annotated_basic_block {
>  int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
>                               struct list_head *head);
>
> +int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
> +                            int num_aggr, struct evsel *evsel);
> +int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool h=
eader);
>  #endif /* __PERF_ANNOTATE_H */
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index 04068d48683f..649392bee7ed 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -40,16 +40,32 @@ static struct block_header_column {
>         [PERF_HPP_REPORT__BLOCK_DSO] =3D {
>                 .name =3D "Shared Object",
>                 .width =3D 20,
> +       },
> +       [PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER] =3D {
> +               .name =3D "Branch Counter",
> +               .width =3D 30,
>         }
>  };
>
> -struct block_info *block_info__new(void)
> +static struct block_info *block_info__new(unsigned int br_cntr_nr)
>  {
> -       return zalloc(sizeof(struct block_info));
> +       struct block_info *bi =3D zalloc(sizeof(struct block_info));
> +
> +       if (bi && br_cntr_nr) {
> +               bi->br_cntr =3D calloc(br_cntr_nr, sizeof(u64));
> +               if (!bi->br_cntr) {
> +                       free(bi);
> +                       return NULL;
> +               }
> +       }
> +
> +       return bi;
>  }
>
>  void block_info__delete(struct block_info *bi)
>  {
> +       if (bi)
> +               free(bi->br_cntr);
>         free(bi);
>  }
>
> @@ -86,7 +102,8 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __may=
be_unused,
>
>  static void init_block_info(struct block_info *bi, struct symbol *sym,
>                             struct cyc_hist *ch, int offset,
> -                           u64 total_cycles)
> +                           u64 total_cycles, unsigned int br_cntr_nr,
> +                           u64 *br_cntr, struct evsel *evsel)
>  {
>         bi->sym =3D sym;
>         bi->start =3D ch->start;
> @@ -99,10 +116,18 @@ static void init_block_info(struct block_info *bi, s=
truct symbol *sym,
>
>         memcpy(bi->cycles_spark, ch->cycles_spark,
>                NUM_SPARKS * sizeof(u64));
> +
> +       if (br_cntr && br_cntr_nr) {
> +               bi->br_cntr_nr =3D br_cntr_nr;
> +               memcpy(bi->br_cntr, &br_cntr[offset * br_cntr_nr],
> +                      br_cntr_nr * sizeof(u64));
> +       }
> +       bi->evsel =3D evsel;
>  }
>
>  int block_info__process_sym(struct hist_entry *he, struct block_hist *bh=
,
> -                           u64 *block_cycles_aggr, u64 total_cycles)
> +                           u64 *block_cycles_aggr, u64 total_cycles,
> +                           unsigned int br_cntr_nr)
>  {
>         struct annotation *notes;
>         struct cyc_hist *ch;
> @@ -125,12 +150,14 @@ int block_info__process_sym(struct hist_entry *he, =
struct block_hist *bh,
>                         struct block_info *bi;
>                         struct hist_entry *he_block;
>
> -                       bi =3D block_info__new();
> +                       bi =3D block_info__new(br_cntr_nr);
>                         if (!bi)
>                                 return -1;
>
>                         init_block_info(bi, he->ms.sym, &ch[i], i,
> -                                       total_cycles);
> +                                       total_cycles, br_cntr_nr,
> +                                       notes->branch->br_cntr,
> +                                       hists_to_evsel(he->hists));
>                         cycles +=3D bi->cycles_aggr / bi->num_aggr;
>
>                         he_block =3D hists__add_entry_block(&bh->block_hi=
sts,
> @@ -327,6 +354,24 @@ static void init_block_header(struct block_fmt *bloc=
k_fmt)
>         fmt->width =3D block_column_width;
>  }
>
> +static int block_branch_counter_entry(struct perf_hpp_fmt *fmt,
> +                                     struct perf_hpp *hpp,
> +                                     struct hist_entry *he)
> +{
> +       struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> +       struct block_info *bi =3D he->block_info;
> +       char *buf;
> +       int ret;
> +
> +       if (annotation_br_cntr_entry(&buf, bi->br_cntr_nr, bi->br_cntr,
> +                                    bi->num_aggr, bi->evsel))
> +               return 0;
> +
> +       ret =3D scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, b=
uf);
> +       free(buf);
> +       return ret;
> +}
> +
>  static void hpp_register(struct block_fmt *block_fmt, int idx,
>                          struct perf_hpp_list *hpp_list)
>  {
> @@ -357,6 +402,9 @@ static void hpp_register(struct block_fmt *block_fmt,=
 int idx,
>         case PERF_HPP_REPORT__BLOCK_DSO:
>                 fmt->entry =3D block_dso_entry;
>                 break;
> +       case PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER:
> +               fmt->entry =3D block_branch_counter_entry;
> +               break;
>         default:
>                 return;
>         }
> @@ -390,7 +438,7 @@ static void init_block_hist(struct block_hist *bh, st=
ruct block_fmt *block_fmts,
>  static int process_block_report(struct hists *hists,
>                                 struct block_report *block_report,
>                                 u64 total_cycles, int *block_hpps,
> -                               int nr_hpps)
> +                               int nr_hpps, unsigned int br_cntr_nr)
>  {
>         struct rb_node *next =3D rb_first_cached(&hists->entries);
>         struct block_hist *bh =3D &block_report->hist;
> @@ -405,7 +453,7 @@ static int process_block_report(struct hists *hists,
>         while (next) {
>                 he =3D rb_entry(next, struct hist_entry, rb_node);
>                 block_info__process_sym(he, bh, &block_report->cycles,
> -                                       total_cycles);
> +                                       total_cycles, br_cntr_nr);
>                 next =3D rb_next(&he->rb_node);
>         }
>
> @@ -435,7 +483,7 @@ struct block_report *block_info__create_report(struct=
 evlist *evlist,
>                 struct hists *hists =3D evsel__hists(pos);
>
>                 process_block_report(hists, &block_reports[i], total_cycl=
es,
> -                                    block_hpps, nr_hpps);
> +                                    block_hpps, nr_hpps, evlist->nr_br_c=
ntr);
>                 i++;
>         }
>
> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
> index 0b9e1aad4c55..b9329dc3ab59 100644
> --- a/tools/perf/util/block-info.h
> +++ b/tools/perf/util/block-info.h
> @@ -18,6 +18,9 @@ struct block_info {
>         u64                     total_cycles;
>         int                     num;
>         int                     num_aggr;
> +       int                     br_cntr_nr;
> +       u64                     *br_cntr;
> +       struct evsel            *evsel;
>  };
>
>  struct block_fmt {
> @@ -36,6 +39,7 @@ enum {
>         PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>         PERF_HPP_REPORT__BLOCK_RANGE,
>         PERF_HPP_REPORT__BLOCK_DSO,
> +       PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER,
>         PERF_HPP_REPORT__BLOCK_MAX_INDEX
>  };
>
> @@ -46,7 +50,6 @@ struct block_report {
>         int                     nr_fmts;
>  };
>
> -struct block_info *block_info__new(void);
>  void block_info__delete(struct block_info *bi);
>
>  int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *ri=
ght);
> @@ -55,7 +58,8 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __mayb=
e_unused,
>                         struct hist_entry *left, struct hist_entry *right=
);
>
>  int block_info__process_sym(struct hist_entry *he, struct block_hist *bh=
,
> -                           u64 *block_cycles_aggr, u64 total_cycles);
> +                           u64 *block_cycles_aggr, u64 total_cycles,
> +                           unsigned int br_cntr_nr);
>
>  struct block_report *block_info__create_report(struct evlist *evlist,
>                                                u64 total_cycles,
> --
> 2.38.1
>

