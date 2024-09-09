Return-Path: <linux-kernel+bounces-321820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999A4971FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502A2286AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91817965E;
	Mon,  9 Sep 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2gFxhjb"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B2178CF6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901512; cv=none; b=cr/2l8TXuH54a9M0W+H4HYxm0f5VsbKaVkvGE4uvpRGg1r5YuLx07MHunhnx3ZDXCc2XM0o3+oqIDWH39XDIdrEBfd4v19ZtfRk6TbAlbsnSJQItW2GLMpuWitWbQI3Z7iYJ66obUu8S5TIAAHSCPRbi5jz6aebj05GAihpz/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901512; c=relaxed/simple;
	bh=XU6HEwpxZuYi7mv98AHnoRTqRUq04/yFlN+9ofdXsiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1nKAuPca6402DeIWNFZhNtXKFTXl8a1mNPl81Lv3UD2obaXCqrEG7vk9iIm8kUQC1nJruvMjznK3DGv5M1xdlTTFB2IPC5x7t7XzafZAfnFkstVoogolqRvjtkudMDI8Pq4N4atqItHE5Hd2rx/joFkM/IWwFNewkqtMOnufuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2gFxhjb; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso6665ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725901509; x=1726506309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQwjvv8xOTFkfDabjAr3Hcyae7FKP8FwGE4Kcv3E/4A=;
        b=l2gFxhjb+IA7J/qA3gAeFRWlUl44xxNKIX4G46qVafX4SVcCg4vScdVBtejY01CLA5
         UyrxlD4XF8XPVgU9+grMDrmUCIi6Di7U7NkCZqacwMaP39WLbrbeJ7rtns7b65eDDFUg
         xHObtQZ+nGHPMHRj8rC8xX9boRcGx6WZ9sf1IguRnu2L7hxKDe+ASY/jHfmc4H/Rvykj
         nwzrBAHpW8jwzmbKf6o6CfE1a7R4pr0zgBkEFuyCJCIuOG8GL+rzraw3NOZppZpW4bua
         a4sTvrF9hsp0UJcswrnp0fszqZV6jjHFYjl3vRd+BTh/FOAbddegS7nPkOhKqfplXaAh
         +o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725901509; x=1726506309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQwjvv8xOTFkfDabjAr3Hcyae7FKP8FwGE4Kcv3E/4A=;
        b=ri5LWaN9uQS9lmZfgiydrjwOpHnPYCT7Nk/jz8+BMQATQyRPQXagd1o9ie6/kkr8L7
         Huhor7SV40F0ZwezM0tlBvfKdMtoIow123tRIk6kvtb0AYxKo8X5oVEkk9mO/0exLtMX
         7EB/iVhccRuUsQDeahf2quMyk9cIVVrpPOfoY/ZZCA/ytCNkvWZV0QKq4Ai/fjMknL6V
         tGbzFgVZ+keGHcNQSx5IZNFEURUDyv2QkdvFR4VotUrvLaqIzxT9mAGkzkPXVDLS0EcH
         UpdTbaovHWVjuz0laBx4/CJhgiSiCZIIbp2dsUCSDt18z1Ecu7aywW7yNapZUEJCIUje
         BMkg==
X-Forwarded-Encrypted: i=1; AJvYcCWn7Vwu36O6C6B8u+eHCDzrxH6YT/LL3D5QLoZ0VUkFRsccSARTzRYkv10d8P2xlQ7EuWp5mOfwYSTkiJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkcvtp9gB285GhbjaHYbYV3ZjnqzUQ5iQPuFQzddTCFlkkty+
	xggy5493LwU4mM1JoGaPOd07xOL9X8mm5cbbzLn9/YXPB3nyw1XpU0Tpa1eEqrZ0RdAigPKe9OS
	YIbe11Kjllr62Wr2ky1xUF5gmUYKG/d+dZHk7
X-Google-Smtp-Source: AGHT+IFapdfezntcYhpUFZ+8ms2lfGkPp0ZHN06XN57ZEZ5gwvRm0yM+4y+kLOUDbUbR2e4G+wLP5Ng3boNJw5CJdXU=
X-Received: by 2002:a05:6e02:1d1d:b0:377:14ab:42ea with SMTP id
 e9e14a558f8ab-3a0576fd579mr6625045ab.16.1725901509053; Mon, 09 Sep 2024
 10:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906195020.481841-1-acme@kernel.org> <20240906195020.481841-3-acme@kernel.org>
In-Reply-To: <20240906195020.481841-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Sep 2024 10:04:57 -0700
Message-ID: <CAP-5=fW4=2GoP6foAN6qbrCiUzy0a_TzHbd8rvDsakTPfdzvfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf trace: Use a common encoding for augmented
 arguments, with size + error + payload
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Howard Chu <howardchu95@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> We were using a more compact format, without explicitely encoding the
> size and possible error in the payload for an argument.
>
> To do it generically, at least as Howard Chu did in his GSoC activities,
> it is more convenient to use the same model that was being used for
> string arguments, passing { size, error, payload }.
>
> So use that for the non string syscall args we have so far:
>
>   struct timespec
>   struct perf_event_attr
>   struct sockaddr (this one has even a variable size)
>
> With this in place we have the userspace pretty printers:
>
>   perf_event_attr___scnprintf()
>   syscall_arg__scnprintf_augmented_sockaddr()
>   syscall_arg__scnprintf_augmented_timespec()
>
> Ready to have the generic BPF collector in tools/perf/util/bpf_skel/augme=
nted_raw_syscalls.bpf.c
> sending its generic payload and thus we'll use them instead of a generic
> libbpf btf_dump interface that doesn't know about about the sockaddr
> mux, perf_event_attr non-trivial fields (sample_type, etc), leaving it
> as a (useful) fallback that prints just basic types until we put in
> place a more sophisticated pretty printer infrastructure that associates
> synthesized enums to struct fields using the header scrapers we have in
> tools/perf/trace/beauty/, some of them in this list:
>
>   $ ls tools/perf/trace/beauty/*.sh
>   tools/perf/trace/beauty/arch_errno_names.sh
>   tools/perf/trace/beauty/kcmp_type.sh
>   tools/perf/trace/beauty/perf_ioctl.sh
>   tools/perf/trace/beauty/statx_mask.sh
>   tools/perf/trace/beauty/clone.sh
>   tools/perf/trace/beauty/kvm_ioctl.sh
>   tools/perf/trace/beauty/pkey_alloc_access_rights.sh
>   tools/perf/trace/beauty/sync_file_range.sh
>   tools/perf/trace/beauty/drm_ioctl.sh
>   tools/perf/trace/beauty/madvise_behavior.sh
>   tools/perf/trace/beauty/prctl_option.sh
>   tools/perf/trace/beauty/usbdevfs_ioctl.sh
>   tools/perf/trace/beauty/fadvise.sh
>   tools/perf/trace/beauty/mmap_flags.sh
>   tools/perf/trace/beauty/rename_flags.sh
>   tools/perf/trace/beauty/vhost_virtio_ioctl.sh
>   tools/perf/trace/beauty/fs_at_flags.sh
>   tools/perf/trace/beauty/mmap_prot.sh
>   tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
>   tools/perf/trace/beauty/x86_arch_prctl.sh
>   tools/perf/trace/beauty/fsconfig.sh
>   tools/perf/trace/beauty/mount_flags.sh
>   tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
>   tools/perf/trace/beauty/fsmount.sh
>   tools/perf/trace/beauty/move_mount_flags.sh
>   tools/perf/trace/beauty/sockaddr.sh
>   tools/perf/trace/beauty/fspick.sh
>   tools/perf/trace/beauty/mremap_flags.sh
>   tools/perf/trace/beauty/socket.sh
>   $
>
> Testing it:
>
>   root@number:~# rm -f 987654 ; touch 123456 ; perf trace -e rename* mv 1=
23456 987654
>      0.000 ( 0.031 ms): mv/1193096 renameat2(olddfd: CWD, oldname: "12345=
6", newdfd: CWD, newname: "987654", flags: NOREPLACE) =3D 0
>   root@number:~# perf trace -e *nanosleep sleep 1.2345678901
>        0.000 (1234.654 ms): sleep/1192697 clock_nanosleep(rqtp: { .tv_sec=
: 1, .tv_nsec: 234567891 }, rmtp: 0x7ffe1ea80460) =3D 0
>   root@number:~# perf trace -e perf_event_open* perf stat -e cpu-clock sl=
eep 1
>        0.000 ( 0.011 ms): perf/1192701 perf_event_open(attr_uptr: { type:=
 1 (software), size: 136, config: 0 (PERF_COUNT_SW_CPU_CLOCK), sample_type:=
 IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: =
1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 1192702 (perf), =
cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 3
>
>    Performance counter stats for 'sleep 1':
>
>                 0.51 msec cpu-clock                        #    0.001 CPU=
s utilized
>
>          1.001242090 seconds time elapsed
>
>          0.000000000 seconds user
>          0.001010000 seconds sys
>
>   root@number:~# perf trace -e connect* ping -c 1 bsky.app
>        0.000 ( 0.130 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: LOCAL, path: /run/systemd/resolve/io.systemd.Resolve }, addrlen: 42) =3D=
 0
>       23.907 ( 0.006 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 3.20.108.158 }, addrlen: 16) =3D 0
>       23.915 PING bsky.app (3.20.108.158) 56(84) bytes of data.
>   ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .family: UNSPEC }=
, addrlen: 16)           =3D 0
>       23.917 ( 0.002 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 3.12.170.30 }, addrlen: 16) =3D 0
>       23.921 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: UNSPEC }, addrlen: 16)           =3D 0
>       23.923 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 18.217.70.179 }, addrlen: 16) =3D 0
>       23.925 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: UNSPEC }, addrlen: 16)           =3D 0
>       23.927 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 3.132.20.46 }, addrlen: 16) =3D 0
>       23.930 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: UNSPEC }, addrlen: 16)           =3D 0
>       23.931 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 3.142.89.165 }, addrlen: 16) =3D 0
>       23.934 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: UNSPEC }, addrlen: 16)           =3D 0
>       23.935 ( 0.002 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 18.119.147.159 }, addrlen: 16) =3D 0
>       23.938 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: UNSPEC }, addrlen: 16)           =3D 0
>       23.940 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 3.22.38.164 }, addrlen: 16) =3D 0
>       23.942 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: UNSPEC }, addrlen: 16)           =3D 0
>       23.944 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 0, addr: 3.13.14.133 }, addrlen: 16) =3D 0
>       23.956 ( 0.001 ms): ping/1192740 connect(fd: 5, uservaddr: { .famil=
y: INET, port: 1025, addr: 3.20.108.158 }, addrlen: 16) =3D 0
>   ^C
>   --- bsky.app ping statistics ---
>   1 packets transmitted, 0 received, 100% packet loss, time 0ms
>
>   root@number:~#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/trace/beauty/perf_event_open.c     |   2 +-
>  tools/perf/trace/beauty/sockaddr.c            |   2 +-
>  tools/perf/trace/beauty/timespec.c            |   2 +-
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 104 +++++++++++-------
>  4 files changed, 66 insertions(+), 44 deletions(-)
>
> diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace=
/beauty/perf_event_open.c
> index 01ee15fe9d0c7a98..632237128640dbb4 100644
> --- a/tools/perf/trace/beauty/perf_event_open.c
> +++ b/tools/perf/trace/beauty/perf_event_open.c
> @@ -76,7 +76,7 @@ static size_t perf_event_attr___scnprintf(struct perf_e=
vent_attr *attr, char *bf
>
>  static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct sy=
scall_arg *arg, char *bf, size_t size)
>  {
> -       return perf_event_attr___scnprintf((void *)arg->augmented.args, b=
f, size, arg->trace->show_zeros);
> +       return perf_event_attr___scnprintf((void *)arg->augmented.args->v=
alue, bf, size, arg->trace->show_zeros);
>  }
>
>  static size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t si=
ze, struct syscall_arg *arg)
> diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty=
/sockaddr.c
> index 2e0e867c0c1b879a..a17a27ac2a6ff1c4 100644
> --- a/tools/perf/trace/beauty/sockaddr.c
> +++ b/tools/perf/trace/beauty/sockaddr.c
> @@ -47,7 +47,7 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa, c=
har *bf, size_t size) =3D {
>
>  static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_a=
rg *arg, char *bf, size_t size)
>  {
> -       struct sockaddr *sa =3D (struct sockaddr *)arg->augmented.args;
> +       struct sockaddr *sa =3D (struct sockaddr *)&arg->augmented.args->=
value;
>         char family[32];
>         size_t printed;
>
> diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty=
/timespec.c
> index e1a61f092aad8b23..b14ab72a2738efd9 100644
> --- a/tools/perf/trace/beauty/timespec.c
> +++ b/tools/perf/trace/beauty/timespec.c
> @@ -7,7 +7,7 @@
>
>  static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_a=
rg *arg, char *bf, size_t size)
>  {
> -       struct timespec *ts =3D (struct timespec *)arg->augmented.args;
> +       struct timespec *ts =3D (struct timespec *)arg->augmented.args->v=
alue;
>
>         return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" =
PRIu64 " }", ts->tv_sec, ts->tv_nsec);
>  }
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 0f9bd2690d4e5295..9c7d2f8552945695 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -10,6 +10,9 @@
>  #include <bpf/bpf_helpers.h>
>  #include <linux/limits.h>
>
> +#define PERF_ALIGN(x, a)        __PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
> +#define __PERF_ALIGN_MASK(x, mask)      (((x)+(mask))&~(mask))
> +
>  /**
>   * is_power_of_2() - check if a value is a power of two
>   * @n: the value to check
> @@ -66,19 +69,6 @@ struct syscall_exit_args {
>         long               ret;
>  };
>
> -struct augmented_arg {
> -       unsigned int    size;
> -       int             err;
> -       char            value[PATH_MAX];
> -};
> -
> -struct pids_filtered {
> -       __uint(type, BPF_MAP_TYPE_HASH);
> -       __type(key, pid_t);
> -       __type(value, bool);
> -       __uint(max_entries, 64);
> -} pids_filtered SEC(".maps");
> -
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -105,17 +95,27 @@ struct sockaddr_storage {
>         };
>  };
>
> -struct augmented_args_payload {
> -       struct syscall_enter_args args;
> -       union {
> -               struct {
> -                       struct augmented_arg arg, arg2;
> -               };
> +struct augmented_arg {
> +       unsigned int    size;
> +       int             err;
> +       union {
> +               char   value[PATH_MAX];
>                 struct sockaddr_storage saddr;
> -               char   __data[sizeof(struct augmented_arg)];
>         };
>  };
>
> +struct pids_filtered {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, pid_t);
> +       __type(value, bool);
> +       __uint(max_entries, 64);
> +} pids_filtered SEC(".maps");
> +
> +struct augmented_args_payload {
> +       struct syscall_enter_args args;
> +       struct augmented_arg arg, arg2; // We have to reserve space for t=
wo arguments (rename, etc)
> +};
> +
>  // We need more tmp space than the BPF stack can give us
>  struct augmented_args_tmp {
>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> @@ -182,15 +182,17 @@ int sys_enter_connect(struct syscall_enter_args *ar=
gs)
>         struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
>         const void *sockaddr_arg =3D (const void *)args->args[1];
>         unsigned int socklen =3D args->args[2];
> -       unsigned int len =3D sizeof(augmented_args->args);
> +       unsigned int len =3D sizeof(u64) + sizeof(augmented_args->args); =
// the size + err in all 'augmented_arg' structs
>
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> -       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "siz=
eof(augmented_args->saddr) needs to be a power of two");
> -       socklen &=3D sizeof(augmented_args->saddr) - 1;
> +       _Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), =
"sizeof(augmented_args->arg.saddr) needs to be a power of two");
> +       socklen &=3D sizeof(augmented_args->arg.saddr) - 1;
>
> -       bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg=
);
> +       bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr=
_arg);
> +       augmented_args->arg.size =3D socklen;
> +       augmented_args->arg.err =3D 0;
>
>         return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -201,14 +203,14 @@ int sys_enter_sendto(struct syscall_enter_args *arg=
s)
>         struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
>         const void *sockaddr_arg =3D (const void *)args->args[4];
>         unsigned int socklen =3D args->args[5];
> -       unsigned int len =3D sizeof(augmented_args->args);
> +       unsigned int len =3D sizeof(u64) + sizeof(augmented_args->args); =
// the size + err in all 'augmented_arg' structs
>
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> -       socklen &=3D sizeof(augmented_args->saddr) - 1;
> +       socklen &=3D sizeof(augmented_args->arg.saddr) - 1;
>
> -       bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg=
);
> +       bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr=
_arg);
>
>         return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -249,13 +251,23 @@ int sys_enter_rename(struct syscall_enter_args *arg=
s)
>         struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
>         const void *oldpath_arg =3D (const void *)args->args[0],
>                    *newpath_arg =3D (const void *)args->args[1];
> -       unsigned int len =3D sizeof(augmented_args->args), oldpath_len;
> +       unsigned int len =3D sizeof(augmented_args->args), oldpath_len, n=
ewpath_len;
>
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> +       len +=3D 2 * sizeof(u64); // The overhead of size and err, just b=
efore the payload...
> +
>         oldpath_len =3D augmented_arg__read_str(&augmented_args->arg, old=
path_arg, sizeof(augmented_args->arg.value));
> -       len +=3D oldpath_len + augmented_arg__read_str((void *)(&augmente=
d_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value))=
;
> +       augmented_args->arg.size =3D PERF_ALIGN(oldpath_len + 1, sizeof(u=
64));
> +       len +=3D augmented_args->arg.size;
> +
> +       struct augmented_arg *arg2 =3D (void *)&augmented_args->arg.value=
 + augmented_args->arg.size;
> +
> +       newpath_len =3D augmented_arg__read_str(arg2, newpath_arg, sizeof=
(augmented_args->arg.value));
> +       arg2->size =3D newpath_len;
> +
> +       len +=3D newpath_len;
>
>         return augmented__output(args, augmented_args, len);
>  }
> @@ -266,13 +278,23 @@ int sys_enter_renameat2(struct syscall_enter_args *=
args)
>         struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
>         const void *oldpath_arg =3D (const void *)args->args[1],
>                    *newpath_arg =3D (const void *)args->args[3];
> -       unsigned int len =3D sizeof(augmented_args->args), oldpath_len;
> +       unsigned int len =3D sizeof(augmented_args->args), oldpath_len, n=
ewpath_len;
>
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> +       len +=3D 2 * sizeof(u64); // The overhead of size and err, just b=
efore the payload...
> +
>         oldpath_len =3D augmented_arg__read_str(&augmented_args->arg, old=
path_arg, sizeof(augmented_args->arg.value));
> -       len +=3D oldpath_len + augmented_arg__read_str((void *)(&augmente=
d_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value))=
;
> +       augmented_args->arg.size =3D PERF_ALIGN(oldpath_len + 1, sizeof(u=
64));
> +       len +=3D augmented_args->arg.size;
> +
> +       struct augmented_arg *arg2 =3D (void *)&augmented_args->arg.value=
 + augmented_args->arg.size;
> +
> +       newpath_len =3D augmented_arg__read_str(arg2, newpath_arg, sizeof=
(augmented_args->arg.value));
> +       arg2->size =3D newpath_len;
> +
> +       len +=3D newpath_len;
>
>         return augmented__output(args, augmented_args, len);
>  }
> @@ -293,26 +315,26 @@ int sys_enter_perf_event_open(struct syscall_enter_=
args *args)
>  {
>         struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
>         const struct perf_event_attr_size *attr =3D (const struct perf_ev=
ent_attr_size *)args->args[0], *attr_read;
> -       unsigned int len =3D sizeof(augmented_args->args);
> +       unsigned int len =3D sizeof(u64) + sizeof(augmented_args->args); =
// the size + err in all 'augmented_arg' structs
>
>          if (augmented_args =3D=3D NULL)
>                 goto failure;
>
> -       if (bpf_probe_read_user(&augmented_args->__data, sizeof(*attr), a=
ttr) < 0)
> +       if (bpf_probe_read_user(&augmented_args->arg.value, sizeof(*attr)=
, attr) < 0)
>                 goto failure;
>
> -       attr_read =3D (const struct perf_event_attr_size *)augmented_args=
->__data;
> +       attr_read =3D (const struct perf_event_attr_size *)augmented_args=
->arg.value;
>
>         __u32 size =3D attr_read->size;
>
>         if (!size)
>                 size =3D PERF_ATTR_SIZE_VER0;
>
> -       if (size > sizeof(augmented_args->__data))
> +       if (size > sizeof(augmented_args->arg.value))
>                  goto failure;
>
>         // Now that we read attr->size and tested it against the size lim=
its, read it completely
> -       if (bpf_probe_read_user(&augmented_args->__data, size, attr) < 0)
> +       if (bpf_probe_read_user(&augmented_args->arg.value, size, attr) <=
 0)
>                 goto failure;
>
>         return augmented__output(args, augmented_args, len + size);
> @@ -325,16 +347,16 @@ int sys_enter_clock_nanosleep(struct syscall_enter_=
args *args)
>  {
>         struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
>         const void *rqtp_arg =3D (const void *)args->args[2];
> -       unsigned int len =3D sizeof(augmented_args->args);
> +       unsigned int len =3D sizeof(u64) + sizeof(augmented_args->args); =
// the size + err in all 'augmented_arg' structs
>         __u32 size =3D sizeof(struct timespec64);
>
>          if (augmented_args =3D=3D NULL)
>                 goto failure;
>
> -       if (size > sizeof(augmented_args->__data))
> +       if (size > sizeof(augmented_args->arg.value))
>                  goto failure;
>
> -       bpf_probe_read_user(&augmented_args->__data, size, rqtp_arg);
> +       bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
>
>         return augmented__output(args, augmented_args, len + size);
>  failure:
> @@ -352,10 +374,10 @@ int sys_enter_nanosleep(struct syscall_enter_args *=
args)
>          if (augmented_args =3D=3D NULL)
>                 goto failure;
>
> -       if (size > sizeof(augmented_args->__data))
> +       if (size > sizeof(augmented_args->arg.value))
>                  goto failure;
>
> -       bpf_probe_read_user(&augmented_args->__data, size, req_arg);
> +       bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
>
>         return augmented__output(args, augmented_args, len + size);
>  failure:
> --
> 2.46.0
>

