Return-Path: <linux-kernel+bounces-408558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF7B9C8068
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22DDB2320D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2401E5723;
	Thu, 14 Nov 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHO279r3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DF1CCEE0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550243; cv=none; b=BE0u+zXk53k786F5pox1kX4RxUXWzGRXx364+t9sVg9cO3/TI9BPURI2aRriBlBuRc7o+3u+LzYjD93gzm7evZ9M7TvB965ILgoJ1YH8e5OWU0TKrWixZeBghaqIHFofDtjchP9zyEabIG1PSlkk727iON1VmXpGb6AMMlnFsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550243; c=relaxed/simple;
	bh=5WSLlDa3Rl/WVrZZ2ncCiF5t05GJDoftB8R+jUBoZUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt2G7kt9HikCFgkNQIFeq8k3gZj1XxskQmV2fam8hVWC/IAMlEqKrjn3OK8pZRjuqvR+l68oc0fu9pbR0DC5MFu3zJNkJQ7XA/tufVytaPBQg96sP1hAWdOXwi+UPbj4wFIngBDQPMUev7cditt0ah2mjxLQsDa/Pv7lrH/yxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHO279r3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca4877690so36235ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731550240; x=1732155040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjubLhSWvgFZ38lDlXB9NFSnJ8bKcuyeNySB7MWmbYM=;
        b=cHO279r3V9cUXA/UCifFpWxQFigufCnUZsVHsnTezMs329LH8UAFMPw5ktO9HwKOFv
         EUk6VKLG/7bTOJOwgrpCzEr1B2T+JyEImSbGMJdHg/ABcq+TQ15Kn8tbNyFsByl+cuAi
         jbpoMxxf6EfM5Ak0y1P13KgZks2HHsC4Xzuh6JN/IjBayTK35yOmPhF2Yo0tvRYpjtGT
         KpfVP9vFagz7PlcvUpL44bxIJBy6oW1PfQv8QIwqygAyiLQH8bcH/b4r60BbcxDrP7QF
         5hVYowQ0SgAKmlUGig7lgkVa99YvX0/EYPH2Bg1OR+wP6g5x4RdDp76Z5c5mTFXsgZSv
         mjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550240; x=1732155040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjubLhSWvgFZ38lDlXB9NFSnJ8bKcuyeNySB7MWmbYM=;
        b=CcTm+TFQLnNznytKc5MBq7ozcns6CDN/MCiaxVeaSVIhN8pkoSD7XnvyUoH0q4MXbx
         OtR0ShhWs2PlE9PGo5Q2Aik5QhVzbFYBgV9kWUHW4hcCKAh4MCmoCx4KxbWVIzX0SR3N
         I2U6tTQ3c8iXGCzAzi/QfaTEcNEASAs9G5Z6oCpNW4yyARwfMEc8JWypmKEha8nBo4AS
         5fUrgeWAYYHo3zNorrvp7HvlvVB7zdQSa3gmI1m2IRSBn6KnSmP5FffvfmqVztGa8/Zj
         n7O6vmid94Kjnk1YEv4PpPgbRmdv2dnfaiDDtHaO0olc0oHQa+dThgojEskR4/ulKVvr
         44Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV+ybjpsjM+/6H8st9ayl2Xj2Gf61CSX+JkAF8OoKMuJAuEkhlnzz3m07t4kVdjCRFQjVuMrT25IpZAl1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJyG3II6xXrU/bSur9pCxW3iTk6VljwMBeUoLqkWtGCrTaKYdq
	59buZoJT3ZunoCHV/jBZUbGwiWRoNaPXETy24Hv5Dk1LDEDQFQodaP0RbpnUZqx9+qUEkNdVz5h
	q7s8mBqLhRMouufknv7Svi5afAi4uCQHWmkor
X-Gm-Gg: ASbGncsX8PXlqWM2bHvU1JRAs/+Dhr7SKXVtjSL/70ePqASYJLguxV0PGjMXFi7PnTz
	m+JBn0JVhrcApqI/09KRuwBYd9YEcEsxl
X-Google-Smtp-Source: AGHT+IH/wQopxutObt3ej9UcvjO43R9cYZT/EbybgiwANkU99P/wvf9LuS9yjTmVbCcQ+HFK+nlZtZ1d48wPS0WyScw=
X-Received: by 2002:a17:902:c40b:b0:20b:99a2:2a31 with SMTP id
 d9443c01a7336-211c18a8198mr1565075ad.8.1731550239792; Wed, 13 Nov 2024
 18:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160721.1401614-1-deepak.surti@arm.com> <20241107160721.1401614-4-deepak.surti@arm.com>
In-Reply-To: <20241107160721.1401614-4-deepak.surti@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 18:10:28 -0800
Message-ID: <CAP-5=fVuUVQW-E1Dow-H2O6kjHnoV3Rk-H5r1mA=EBfE8SZbzg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] tools/perf: Modify event parser to support
 alt-period term
To: Deepak Surti <deepak.surti@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.barnett@arm.com, ben.gainey@arm.com, 
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 8:08=E2=80=AFAM Deepak Surti <deepak.surti@arm.com> =
wrote:
>
> From: Ben Gainey <ben.gainey@arm.com>
>
> parse-events is modified, adding the "alt-period" term which can be used
> to specify the alternative sampling period.
>
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>

Hi Deepak,

this and the next change conflict with:
https://lore.kernel.org/all/20241015000158.871828-1-irogers@google.com/
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/tools/perf/tests/shell/attr.sh?h=3Dperf-tools-next&id=3D8519e4f44c2af7=
2214dc029f0334be068466e71f
Could you migrate the work to perf-tools-next?

Thanks,
Ian

> ---
>  tools/include/uapi/linux/perf_event.h             |  3 +++
>  tools/perf/tests/attr.c                           |  1 +
>  tools/perf/tests/attr.py                          |  1 +
>  tools/perf/tests/attr/base-record                 |  3 ++-
>  tools/perf/tests/attr/base-record-spe             |  1 +
>  tools/perf/tests/attr/base-stat                   |  3 ++-
>  tools/perf/tests/attr/system-wide-dummy           |  3 ++-
>  tools/perf/tests/attr/test-record-alt-period-term | 12 ++++++++++++
>  tools/perf/tests/attr/test-record-dummy-C0        |  3 ++-
>  tools/perf/util/parse-events.c                    | 15 +++++++++++++++
>  tools/perf/util/parse-events.h                    |  3 ++-
>  tools/perf/util/parse-events.l                    |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c         |  1 +
>  tools/perf/util/pmu.c                             |  1 +
>  14 files changed, 46 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/tests/attr/test-record-alt-period-term
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index 4842c36fdf80..bedae424ba36 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -379,6 +379,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6    120     /* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7    128     /* add: sig_data */
>  #define PERF_ATTR_SIZE_VER8    136     /* add: config3 */
> +#define PERF_ATTR_SIZE_VER9    144     /* add: alternative_sample_period=
 */
>
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -522,6 +523,8 @@ struct perf_event_attr {
>         __u64   sig_data;
>
>         __u64   config3; /* extension of config2 */
> +
> +       __u64   alternative_sample_period;
>  };
>
>  /*
> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> index 97e1bdd6ec0e..956b58c7ba8f 100644
> --- a/tools/perf/tests/attr.c
> +++ b/tools/perf/tests/attr.c
> @@ -139,6 +139,7 @@ static int store_event(struct perf_event_attr *attr, =
pid_t pid, struct perf_cpu
>         WRITE_ASS(branch_sample_type, "llu");
>         WRITE_ASS(sample_regs_user,   "llu");
>         WRITE_ASS(sample_stack_user,  PRIu32);
> +       WRITE_ASS(alternative_sample_period,  "llu");
>
>         fclose(file);
>         return 0;
> diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
> index e890c261ad26..75c4527393f9 100644
> --- a/tools/perf/tests/attr.py
> +++ b/tools/perf/tests/attr.py
> @@ -91,6 +91,7 @@ class Event(dict):
>          'branch_sample_type',
>          'sample_regs_user',
>          'sample_stack_user',
> +        'alternative_sample_period',
>      ]
>
>      def add(self, data):
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/ba=
se-record
> index b44e4e6e4443..403de2e2c891 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -5,7 +5,7 @@ group_fd=3D-1
>  flags=3D0|8
>  cpu=3D*
>  type=3D0|1
> -size=3D136
> +size=3D144
>  config=3D0|1
>  sample_period=3D*
>  sample_type=3D263
> @@ -39,3 +39,4 @@ config2=3D0
>  branch_sample_type=3D0
>  sample_regs_user=3D0
>  sample_stack_user=3D0
> +alternative_sample_period=3D0
> \ No newline at end of file
> diff --git a/tools/perf/tests/attr/base-record-spe b/tools/perf/tests/att=
r/base-record-spe
> index 08fa96b59240..db528d7d8b73 100644
> --- a/tools/perf/tests/attr/base-record-spe
> +++ b/tools/perf/tests/attr/base-record-spe
> @@ -38,3 +38,4 @@ config2=3D*
>  branch_sample_type=3D*
>  sample_regs_user=3D*
>  sample_stack_user=3D*
> +alternative_sample_period=3D0
> \ No newline at end of file
> diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base=
-stat
> index fccd8ec4d1b0..27ef0fa1386f 100644
> --- a/tools/perf/tests/attr/base-stat
> +++ b/tools/perf/tests/attr/base-stat
> @@ -5,7 +5,7 @@ group_fd=3D-1
>  flags=3D0|8
>  cpu=3D*
>  type=3D0
> -size=3D136
> +size=3D144
>  config=3D0
>  sample_period=3D0
>  sample_type=3D65536
> @@ -39,3 +39,4 @@ config2=3D0
>  branch_sample_type=3D0
>  sample_regs_user=3D0
>  sample_stack_user=3D0
> +alternative_sample_period=3D0
> diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/a=
ttr/system-wide-dummy
> index a1e1d6a263bf..5c4d2a60931d 100644
> --- a/tools/perf/tests/attr/system-wide-dummy
> +++ b/tools/perf/tests/attr/system-wide-dummy
> @@ -7,7 +7,7 @@ cpu=3D*
>  pid=3D-1
>  flags=3D8
>  type=3D1
> -size=3D136
> +size=3D144
>  config=3D9
>  sample_period=3D1
>  # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> @@ -50,3 +50,4 @@ config2=3D0
>  branch_sample_type=3D0
>  sample_regs_user=3D0
>  sample_stack_user=3D0
> +alternative_sample_period=3D0
> diff --git a/tools/perf/tests/attr/test-record-alt-period-term b/tools/pe=
rf/tests/attr/test-record-alt-period-term
> new file mode 100644
> index 000000000000..e0de4c8eb1c8
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-alt-period-term
> @@ -0,0 +1,12 @@
> +[config]
> +command =3D record
> +args    =3D --no-bpf-event -e cycles/period=3D3,alt-period=3D2/ -- kill =
>/dev/null 2>&1
> +ret     =3D 1
> +kernel_since =3D 6.11
> +
> +[event-10:base-record]
> +sample_period=3D3
> +alternative_sample_period=3D2
> +
> +freq=3D0
> +sample_type=3D7
> diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/test=
s/attr/test-record-dummy-C0
> index 576ec48b3aaf..d4f0546e02b6 100644
> --- a/tools/perf/tests/attr/test-record-dummy-C0
> +++ b/tools/perf/tests/attr/test-record-dummy-C0
> @@ -10,7 +10,7 @@ cpu=3D0
>  pid=3D-1
>  flags=3D8
>  type=3D1
> -size=3D136
> +size=3D144
>  config=3D9
>  sample_period=3D4000
>  # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> @@ -53,3 +53,4 @@ config2=3D0
>  branch_sample_type=3D0
>  sample_regs_user=3D0
>  sample_stack_user=3D0
> +alternative_sample_period=3D0
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 9a8be1e46d67..48723cea3a51 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -826,6 +826,7 @@ static const char *config_term_name(enum parse_events=
__term_type term_type)
>                 [PARSE_EVENTS__TERM_TYPE_RAW]                   =3D "raw"=
,
>                 [PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          =3D "lega=
cy-cache",
>                 [PARSE_EVENTS__TERM_TYPE_HARDWARE]              =3D "hard=
ware",
> +               [PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD]     =3D "alt-=
period",
>         };
>         if ((unsigned int)term_type >=3D __PARSE_EVENTS__TERM_TYPE_NR)
>                 return "unknown term";
> @@ -854,6 +855,7 @@ config_term_avail(enum parse_events__term_type term_t=
ype, struct parse_events_er
>         case PARSE_EVENTS__TERM_TYPE_NAME:
>         case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
>         case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> +       case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
>         case PARSE_EVENTS__TERM_TYPE_PERCORE:
>                 return true;
>         case PARSE_EVENTS__TERM_TYPE_USER:
> @@ -998,6 +1000,16 @@ do {                                               =
                          \
>                         return -EINVAL;
>                 }
>                 break;
> +       case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
> +               CHECK_TYPE_VAL(NUM);
> +               if (term->val.num =3D=3D 0) {
> +                       parse_events_error__handle(err, term->err_val,
> +                                               strdup("expected a non-ze=
ro value"),
> +                                               NULL);
> +                       return -EINVAL;
> +               }
> +               attr->alternative_sample_period =3D term->val.num;
> +               break;
>         case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>         case PARSE_EVENTS__TERM_TYPE_USER:
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> @@ -1124,6 +1136,7 @@ static int config_term_tracepoint(struct perf_event=
_attr *attr,
>         case PARSE_EVENTS__TERM_TYPE_RAW:
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>         case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +       case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
>         default:
>                 if (err) {
>                         parse_events_error__handle(err, term->err_term,
> @@ -1255,6 +1268,7 @@ do {                                               =
               \
>                 case PARSE_EVENTS__TERM_TYPE_RAW:
>                 case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>                 case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +               case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
>                 default:
>                         break;
>                 }
> @@ -1308,6 +1322,7 @@ static int get_config_chgs(struct perf_pmu *pmu, st=
ruct parse_events_terms *head
>                 case PARSE_EVENTS__TERM_TYPE_RAW:
>                 case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>                 case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +               case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
>                 default:
>                         break;
>                 }
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index 10cc9c433116..f1482361321a 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -79,7 +79,8 @@ enum parse_events__term_type {
>         PARSE_EVENTS__TERM_TYPE_RAW,
>         PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
>         PARSE_EVENTS__TERM_TYPE_HARDWARE,
> -#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HAR=
DWARE + 1)
> +       PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD,
> +#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT=
_SAMPLE_PERIOD + 1)
>  };
>
>  struct parse_events_term {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 5a0bcd7f166a..1972a5a696ef 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -331,6 +331,7 @@ percore                     { return term(yyscanner, =
PARSE_EVENTS__TERM_TYPE_PERCORE); }
>  aux-output             { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
AUX_OUTPUT); }
>  aux-sample-size                { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_AUX_SAMPLE_SIZE); }
>  metric-id              { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
METRIC_ID); }
> +alt-period             { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
ALT_SAMPLE_PERIOD); }
>  cpu-cycles|cycles                              { return hw_term(yyscanne=
r, PERF_COUNT_HW_CPU_CYCLES); }
>  stalled-cycles-frontend|idle-cycles-frontend   { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
>  stalled-cycles-backend|idle-cycles-backend     { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index 59fbbba79697..c6af598070b5 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -335,6 +335,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_ev=
ent_attr *attr,
>         PRINT_ATTRf(sample_max_stack, p_unsigned);
>         PRINT_ATTRf(aux_sample_size, p_unsigned);
>         PRINT_ATTRf(sig_data, p_unsigned);
> +       PRINT_ATTRf(alternative_sample_period, p_unsigned);
>
>         return ret;
>  }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 61bdda01a05a..7615d05e389f 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1738,6 +1738,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu,=
 void *state, pmu_format_call
>                 "percore",
>                 "aux-output",
>                 "aux-sample-size=3Dnumber",
> +               "alt-period=3Dnumber",
>         };
>         struct perf_pmu_format *format;
>         int ret;
> --
> 2.43.0
>

