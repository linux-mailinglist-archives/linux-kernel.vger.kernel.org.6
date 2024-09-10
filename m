Return-Path: <linux-kernel+bounces-323837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F366974410
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDBD2889EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B18C1A76CF;
	Tue, 10 Sep 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isKjMABr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174217C7C9;
	Tue, 10 Sep 2024 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000115; cv=none; b=Kk7/Q6jaO3UHu3m+1kK6Al9ZL2GfMP8IRbXP1h7WtH9vT//V+0+WVuwq+zNRXeJo3eKo8HzHb9+Qcss7ve2yBip9NacD3KrpGJiIFy0bnZb8WXYoxM5Kj+T1e9RdKCIMKj0zNykWQtfZe7f772kJWrKVYnL7RdameTMAqanX+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000115; c=relaxed/simple;
	bh=GW+yR2a4/1+k4KvzOC8XHFKXUGqTmzh2RmWZLDFchRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8yBj6Gfb0QT1qEzdpstmleIq1y5u5ddb83LWEhPkoS0Sngnw1BW2tthOkqEsiwBnwqIM9GjXAanN45d/G3b0YthdtbBKZQ+aSy2Mg6Q/ArW5QO277cNQjVejjOb2MWK38YpOby9+WbFqAN9OjHBdiyLL1oubLKUKn/NfQMwd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isKjMABr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE78C4CEC3;
	Tue, 10 Sep 2024 20:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726000114;
	bh=GW+yR2a4/1+k4KvzOC8XHFKXUGqTmzh2RmWZLDFchRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isKjMABrg3Sus6C4ewCUWaJJcT58qVildzBfJ11aO4Uqqtlj9J+Tp4cwXyHK9iz/I
	 2Hl4uS4Guzc8ew1ijxNGAfGUky0qrkWtUU1P6VdoQsaRsXIiwvhkmlG9EMc7ihdVB0
	 UbaUiDeJER1atX2ECStm5pdvCVJrXTez6shGgGXw5bffNGeDgrcNv7eI+MtzpIhUJF
	 jDYMO5RxvfBid4TbCCeUYg/63KkY1cEJuYMnLa+phBXXiBQDK1s1pmJ/Sw8xbqG8GY
	 KNeQYZdeB6E6faXqQJT8ZwB3l2bK6Qovhzj8uTEe/DlNMqvH0Z8sA5leGkCBNAA015
	 GivpT4pRFRZHw==
Date: Tue, 10 Sep 2024 17:28:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf trace: Support collecting 'union's with the BPF
 augmenter
Message-ID: <ZuCr7yOQb-1qeuox@x1>
References: <ZuBJQp1lf5uAjpo1@x1>
 <CAH0uvoh=Q6iv1YG96tVw3ynskOGhBEhKzCGBS9nwbu_zgZOB3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAH0uvoh=Q6iv1YG96tVw3ynskOGhBEhKzCGBS9nwbu_zgZOB3Q@mail.gmail.com>

On Tue, Sep 10, 2024 at 09:16:56AM -0700, Howard Chu wrote:
> Hello Arnaldo,
>=20
> LGTM.

Taking that as an Acked-by, as per the Documentation/  submitting
patches docs, next time consider providing an:

Acked-by: you

or a stronger:

Reviewed-by: you

since this is code you worked with for a long time.

Tested-by: you

also is interesting, indicating you actually built and tested it.

All these things on the record are important for the trust we put in the
code and in the persons involved.

I'll remove the now not needed () as you noted below.

Thanks,

- Arnaldo
=20
> On Tue, Sep 10, 2024 at 6:27=E2=80=AFAM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > And reuse the BTF based struct pretty printer, with that we can offer
> > initial support for the 'bpf' syscall's second argument, a 'union
> > bpf_attr' pointer.
> >
> > But this is not that satisfactory as the libbpf btf dumper will pretty
> > print _all_ the union, we need to have a way to say that the first arg
> > selects the type for the union member to be pretty printed, something
> > like what pahole does translating the PERF_RECORD_ selector into a name,
> > and using that name to find a matching struct.
> >
> > In the case of 'union bpf_attr' it would map PROG_LOAD to one of the
> > union members, but unfortunately there is no such mapping:
> >
> >   root@number:~# pahole bpf_attr
> >   union bpf_attr {
> >         struct {
> >                 __u32              map_type;           /*     0     4 */
> >                 __u32              key_size;           /*     4     4 */
> >                 __u32              value_size;         /*     8     4 */
> >                 __u32              max_entries;        /*    12     4 */
> >                 __u32              map_flags;          /*    16     4 */
> >                 __u32              inner_map_fd;       /*    20     4 */
> >                 __u32              numa_node;          /*    24     4 */
> >                 char               map_name[16];       /*    28    16 */
> >                 __u32              map_ifindex;        /*    44     4 */
> >                 __u32              btf_fd;             /*    48     4 */
> >                 __u32              btf_key_type_id;    /*    52     4 */
> >                 __u32              btf_value_type_id;  /*    56     4 */
> >                 __u32              btf_vmlinux_value_type_id; /*    60 =
    4 */
> >                 /* --- cacheline 1 boundary (64 bytes) --- */
> >                 __u64              map_extra;          /*    64     8 */
> >                 __s32              value_type_btf_obj_fd; /*    72     =
4 */
> >                 __s32              map_token_fd;       /*    76     4 */
> >         };                                             /*     0    80 */
> >         struct {
> >                 __u32              map_fd;             /*     0     4 */
> >
> >                 /* XXX 4 bytes hole, try to pack */
> >
> >                 __u64              key;                /*     8     8 */
> >                 union {
> >                         __u64      value;              /*    16     8 */
> >                         __u64      next_key;           /*    16     8 */
> >                 };                                     /*    16     8 */
> >                 __u64              flags;              /*    24     8 */
> >         };                                             /*     0    32 */
> >         struct {
> >                 __u64              in_batch;           /*     0     8 */
> >                 __u64              out_batch;          /*     8     8 */
> >                 __u64              keys;               /*    16     8 */
> >                 __u64              values;             /*    24     8 */
> >                 __u32              count;              /*    32     4 */
> >                 __u32              map_fd;             /*    36     4 */
> >                 __u64              elem_flags;         /*    40     8 */
> >                 __u64              flags;              /*    48     8 */
> >         } batch;                                       /*     0    56 */
> >         struct {
> >                 __u32              prog_type;          /*     0     4 */
> >                 __u32              insn_cnt;           /*     4     4 */
> >                 __u64              insns;              /*     8     8 */
> >                 __u64              license;            /*    16     8 */
> >                 __u32              log_level;          /*    24     4 */
> >                 __u32              log_size;           /*    28     4 */
> >                 __u64              log_buf;            /*    32     8 */
> >                 __u32              kern_version;       /*    40     4 */
> >                 __u32              prog_flags;         /*    44     4 */
> >                 char               prog_name[16];      /*    48    16 */
> >                 /* --- cacheline 1 boundary (64 bytes) --- */
> >                 __u32              prog_ifindex;       /*    64     4 */
> >                 __u32              expected_attach_type; /*    68     4=
 */
> >                 __u32              prog_btf_fd;        /*    72     4 */
> >                 __u32              func_info_rec_size; /*    76     4 */
> >                 __u64              func_info;          /*    80     8 */
> >                 __u32              func_info_cnt;      /*    88     4 */
> >                 __u32              line_info_rec_size; /*    92     4 */
> >                 __u64              line_info;          /*    96     8 */
> >                 __u32              line_info_cnt;      /*   104     4 */
> >                 __u32              attach_btf_id;      /*   108     4 */
> >                 union {
> >                         __u32      attach_prog_fd;     /*   112     4 */
> >                         __u32      attach_btf_obj_fd;  /*   112     4 */
> >                 };                                     /*   112     4 */
> >                 __u32              core_relo_cnt;      /*   116     4 */
> >                 __u64              fd_array;           /*   120     8 */
> >                 /* --- cacheline 2 boundary (128 bytes) --- */
> >                 __u64              core_relos;         /*   128     8 */
> >                 __u32              core_relo_rec_size; /*   136     4 */
> >                 __u32              log_true_size;      /*   140     4 */
> >                 __s32              prog_token_fd;      /*   144     4 */
> >         };                                             /*     0   152 */
> >         struct {
> >                 __u64              pathname;           /*     0     8 */
> >                 __u32              bpf_fd;             /*     8     4 */
> >                 __u32              file_flags;         /*    12     4 */
> >                 __s32              path_fd;            /*    16     4 */
> >         };                                             /*     0    24 */
> >         struct {
> >                 union {
> >                         __u32      target_fd;          /*     0     4 */
> >                         __u32      target_ifindex;     /*     0     4 */
> >                 };                                     /*     0     4 */
> >                 __u32              attach_bpf_fd;      /*     4     4 */
> >                 __u32              attach_type;        /*     8     4 */
> >                 __u32              attach_flags;       /*    12     4 */
> >                 __u32              replace_bpf_fd;     /*    16     4 */
> >                 union {
> >                         __u32      relative_fd;        /*    20     4 */
> >                         __u32      relative_id;        /*    20     4 */
> >                 };                                     /*    20     4 */
> >                 __u64              expected_revision;  /*    24     8 */
> >         };                                             /*     0    32 */
> >         struct {
> >                 __u32              prog_fd;            /*     0     4 */
> >                 __u32              retval;             /*     4     4 */
> >                 __u32              data_size_in;       /*     8     4 */
> >                 __u32              data_size_out;      /*    12     4 */
> >                 __u64              data_in;            /*    16     8 */
> >                 __u64              data_out;           /*    24     8 */
> >                 __u32              repeat;             /*    32     4 */
> >                 __u32              duration;           /*    36     4 */
> >                 __u32              ctx_size_in;        /*    40     4 */
> >                 __u32              ctx_size_out;       /*    44     4 */
> >                 __u64              ctx_in;             /*    48     8 */
> >                 __u64              ctx_out;            /*    56     8 */
> >                 /* --- cacheline 1 boundary (64 bytes) --- */
> >                 __u32              flags;              /*    64     4 */
> >                 __u32              cpu;                /*    68     4 */
> >                 __u32              batch_size;         /*    72     4 */
> >         } test;                                        /*     0    80 */
> >         struct {
> >                 union {
> >                         __u32      start_id;           /*     0     4 */
> >                         __u32      prog_id;            /*     0     4 */
> >                         __u32      map_id;             /*     0     4 */
> >                         __u32      btf_id;             /*     0     4 */
> >                         __u32      link_id;            /*     0     4 */
> >                 };                                     /*     0     4 */
> >                 __u32              next_id;            /*     4     4 */
> >                 __u32              open_flags;         /*     8     4 */
> >         };                                             /*     0    12 */
> >         struct {
> >                 __u32              bpf_fd;             /*     0     4 */
> >                 __u32              info_len;           /*     4     4 */
> >                 __u64              info;               /*     8     8 */
> >         } info;                                        /*     0    16 */
> >         struct {
> >                 union {
> >                         __u32      target_fd;          /*     0     4 */
> >                         __u32      target_ifindex;     /*     0     4 */
> >                 };                                     /*     0     4 */
> >                 __u32              attach_type;        /*     4     4 */
> >                 __u32              query_flags;        /*     8     4 */
> >                 __u32              attach_flags;       /*    12     4 */
> >                 __u64              prog_ids;           /*    16     8 */
> >                 union {
> >                         __u32      prog_cnt;           /*    24     4 */
> >                         __u32      count;              /*    24     4 */
> >                 };                                     /*    24     4 */
> >
> >                 /* XXX 4 bytes hole, try to pack */
> >
> >                 __u64              prog_attach_flags;  /*    32     8 */
> >                 __u64              link_ids;           /*    40     8 */
> >                 __u64              link_attach_flags;  /*    48     8 */
> >                 __u64              revision;           /*    56     8 */
> >         } query;                                       /*     0    64 */
> >         struct {
> >                 __u64              name;               /*     0     8 */
> >                 __u32              prog_fd;            /*     8     4 */
> >
> >                 /* XXX 4 bytes hole, try to pack */
> >
> >                 __u64              cookie;             /*    16     8 */
> >         } raw_tracepoint;                              /*     0    24 */
> >         struct {
> >                 __u64              btf;                /*     0     8 */
> >                 __u64              btf_log_buf;        /*     8     8 */
> >                 __u32              btf_size;           /*    16     4 */
> >                 __u32              btf_log_size;       /*    20     4 */
> >                 __u32              btf_log_level;      /*    24     4 */
> >                 __u32              btf_log_true_size;  /*    28     4 */
> >                 __u32              btf_flags;          /*    32     4 */
> >                 __s32              btf_token_fd;       /*    36     4 */
> >         };                                             /*     0    40 */
> >         struct {
> >                 __u32              pid;                /*     0     4 */
> >                 __u32              fd;                 /*     4     4 */
> >                 __u32              flags;              /*     8     4 */
> >                 __u32              buf_len;            /*    12     4 */
> >                 __u64              buf;                /*    16     8 */
> >                 __u32              prog_id;            /*    24     4 */
> >                 __u32              fd_type;            /*    28     4 */
> >                 __u64              probe_offset;       /*    32     8 */
> >                 __u64              probe_addr;         /*    40     8 */
> >         } task_fd_query;                               /*     0    48 */
> >         struct {
> >                 union {
> >                         __u32      prog_fd;            /*     0     4 */
> >                         __u32      map_fd;             /*     0     4 */
> >                 };                                     /*     0     4 */
> >                 union {
> >                         __u32      target_fd;          /*     4     4 */
> >                         __u32      target_ifindex;     /*     4     4 */
> >                 };                                     /*     4     4 */
> >                 __u32              attach_type;        /*     8     4 */
> >                 __u32              flags;              /*    12     4 */
> >                 union {
> >                         __u32      target_btf_id;      /*    16     4 */
> >                         struct {
> >                                 __u64 iter_info;       /*    16     8 */
> >                                 __u32 iter_info_len;   /*    24     4 */
> >                         };                             /*    16    16 */
> >                         struct {
> >                                 __u64 bpf_cookie;      /*    16     8 */
> >                         } perf_event;                  /*    16     8 */
> >                         struct {
> >                                 __u32 flags;           /*    16     4 */
> >                                 __u32 cnt;             /*    20     4 */
> >                                 __u64 syms;            /*    24     8 */
> >                                 __u64 addrs;           /*    32     8 */
> >                                 __u64 cookies;         /*    40     8 */
> >                         } kprobe_multi;                /*    16    32 */
> >                         struct {
> >                                 __u32 target_btf_id;   /*    16     4 */
> >
> >                                 /* XXX 4 bytes hole, try to pack */
> >
> >                                 __u64 cookie;          /*    24     8 */
> >                         } tracing;                     /*    16    16 */
> >                         struct {
> >                                 __u32 pf;              /*    16     4 */
> >                                 __u32 hooknum;         /*    20     4 */
> >                                 __s32 priority;        /*    24     4 */
> >                                 __u32 flags;           /*    28     4 */
> >                         } netfilter;                   /*    16    16 */
> >                         struct {
> >                                 union {
> >                                         __u32  relative_fd; /*    16   =
  4 */
> >                                         __u32  relative_id; /*    16   =
  4 */
> >                                 };                     /*    16     4 */
> >
> >                                 /* XXX 4 bytes hole, try to pack */
> >
> >                                 __u64 expected_revision; /*    24     8=
 */
> >                         } tcx;                         /*    16    16 */
> >                         struct {
> >                                 __u64 path;            /*    16     8 */
> >                                 __u64 offsets;         /*    24     8 */
> >                                 __u64 ref_ctr_offsets; /*    32     8 */
> >                                 __u64 cookies;         /*    40     8 */
> >                                 __u32 cnt;             /*    48     4 */
> >                                 __u32 flags;           /*    52     4 */
> >                                 __u32 pid;             /*    56     4 */
> >                         } uprobe_multi;                /*    16    48 */
> >                         struct {
> >                                 union {
> >                                         __u32  relative_fd; /*    16   =
  4 */
> >                                         __u32  relative_id; /*    16   =
  4 */
> >                                 };                     /*    16     4 */
> >
> >                                 /* XXX 4 bytes hole, try to pack */
> >
> >                                 __u64 expected_revision; /*    24     8=
 */
> >                         } netkit;                      /*    16    16 */
> >                 };                                     /*    16    48 */
> >         } link_create;                                 /*     0    64 */
> >         struct {
> >                 __u32              link_fd;            /*     0     4 */
> >                 union {
> >                         __u32      new_prog_fd;        /*     4     4 */
> >                         __u32      new_map_fd;         /*     4     4 */
> >                 };                                     /*     4     4 */
> >                 __u32              flags;              /*     8     4 */
> >                 union {
> >                         __u32      old_prog_fd;        /*    12     4 */
> >                         __u32      old_map_fd;         /*    12     4 */
> >                 };                                     /*    12     4 */
> >         } link_update;                                 /*     0    16 */
> >         struct {
> >                 __u32              link_fd;            /*     0     4 */
> >         } link_detach;                                 /*     0     4 */
> >         struct {
> >                 __u32              type;               /*     0     4 */
> >         } enable_stats;                                /*     0     4 */
> >         struct {
> >                 __u32              link_fd;            /*     0     4 */
> >                 __u32              flags;              /*     4     4 */
> >         } iter_create;                                 /*     0     8 */
> >         struct {
> >                 __u32              prog_fd;            /*     0     4 */
> >                 __u32              map_fd;             /*     4     4 */
> >                 __u32              flags;              /*     8     4 */
> >         } prog_bind_map;                               /*     0    12 */
> >         struct {
> >                 __u32              flags;              /*     0     4 */
> >                 __u32              bpffs_fd;           /*     4     4 */
> >         } token_create;                                /*     0     8 */
> >   };
> >
> >   root@number:~#
> >
> > So this is one case where BTF gets us only that far, not getting all
> > the way to automate the pretty printing of unions designed like 'union
> > bpf_attr', we will need a custom pretty printer for this union, as using
> > the libbpf union BTF dumper is way too verbose:
> >
> >   root@number:~# perf trace --max-events 1 -e bpf bpftool map
> >        0.000 ( 0.054 ms): bpftool/3409073 bpf(cmd: PROG_LOAD, uattr: (u=
nion bpf_attr){(struct){.map_type =3D (__u32)1,.key_size =3D (__u32)2,.valu=
e_size =3D (__u32)2755142048,.max_entries =3D (__u32)32764,.map_flags =3D (=
__u32)150263906,.inner_map_fd =3D (__u32)21920,},(struct){.map_fd =3D (__u3=
2)1,.key =3D (__u64)140723063628192,(union){.value =3D (__u64)9414583339222=
6,.next_key =3D (__u64)94145833392226,},},.batch =3D (struct){.in_batch =3D=
 (__u64)8589934593,.out_batch =3D (__u64)140723063628192,.keys =3D (__u64)9=
4145833392226,},(struct){.prog_type =3D (__u32)1,.insn_cnt =3D (__u32)2,.in=
sns =3D (__u64)140723063628192,.license =3D (__u64)94145833392226,},(struct=
){.pathname =3D (__u64)8589934593,.bpf_fd =3D (__u32)2755142048,.file_flags=
 =3D (__u32)32764,.path_fd =3D (__s32)150263906,},(struct){(union){.target_=
fd =3D (__u32)1,.target_ifindex =3D (__u32)1,},.attach_bpf_fd =3D (__u32)2,=
=2Eattach_type =3D (__u32)2755142048,.attach_flags =3D (__u32)32764,.replac=
e_bpf_fd =3D (__u32)150263906,(union){.relative_fd =3D (__u32)21920,.relati=
ve_id =3D (__u32)21920,},},.test =3D (struct){.prog_fd =3D (__u32)1,.retval=
 =3D (__u32)2,.data_size_in =3D (__u32)2755142048,.data_size_out =3D (__u32=
)32764,.data_in =3D (__u64)94145833392226,},(struct){(union){.start_id =3D =
(__u32)1,.prog_id =3D (__u32)1,.map_id =3D (__u32)1,.btf_id =3D (__u32)1,.l=
ink_id =3D (__u32)1,},.next_id =3D (__u32)2,.open_flags =3D (__u32)27551420=
48,},.info =3D (struct){.bpf_fd =3D (__u32)1,.info_len =3D (__u32)2,.info =
=3D (__u64)140723063628192,},.query =3D (struct){(union){.target_fd =3D (__=
u32)1,.target_ifindex =3D (__u32)1,},.attach_type =3D (__u32)2,.query_flags=
 =3D (__u32)2755142048,.attach_flags =3D (__u32)32764,.prog_ids =3D (__u64)=
94145833392226,},.raw_tracepoint =3D (struct){.name =3D (__u64)8589934593,.=
prog_fd =3D (__u32)2755142048,.cookie =3D (__u64)94145833392226,},(struct){=
=2Ebtf =3D (__u64)8589934593,.btf_log_buf =3D (__u64)140723063628192,.btf_s=
ize =3D (__u32)150263906,.btf_log_size =3D (__u32)21920,},.task_fd_query =
=3D (struct){.pid =3D (__u32)1,.fd =3D (__u32)2,.flags =3D (__u32)275514204=
8,.buf_len =3D (__u32)32764,.buf =3D (__u64)94145833392226,},.link_create =
=3D (struct){(union){.prog_fd =3D (__u32)1,.map_fd =3D (__u32)1,},(u) =3D 3
> >   root@number:~# 2: prog_array  name hid_jmp_table  flags 0x0
> >         key 4B  value 4B  max_entries 1024  memlock 8440B
> >         owner_prog_type tracing  owner jited
> >   13: hash_of_maps  name cgroup_hash  flags 0x0
> >         key 8B  value 4B  max_entries 2048  memlock 167584B
> >         pids systemd(1)
> >   960: array  name libbpf_global  flags 0x0
> >         key 4B  value 32B  max_entries 1  memlock 280B
> >   961: array  name pid_iter.rodata  flags 0x480
> >         key 4B  value 4B  max_entries 1  memlock 8192B
> >         btf_id 1846  frozen
> >         pids bpftool(3409073)
> >   962: array  name libbpf_det_bind  flags 0x0
> >         key 4B  value 32B  max_entries 1  memlock 280B
> >
> >   root@number:~#
> >
> > For simpler unions this may be better than not seeing any payload, so
> > keep it there.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-trace.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index c47fde936c33a2e6..d28a56cc171b2b2e 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1075,7 +1075,7 @@ static size_t trace__btf_scnprintf(struct trace *=
trace, struct syscall_arg *arg,
> >
> >         if (btf_is_enum(arg_fmt->type))
> >                 return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf=
, size, val);
> > -       else if (btf_is_struct(arg_fmt->type))
> > +       else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->=
type))
> >                 return btf_struct_scnprintf(arg_fmt->type, trace->btf, =
bf, size, arg);
> >
> >         return 0;
> > @@ -2365,8 +2365,7 @@ static size_t syscall__scnprintf_args(struct sysc=
all *sc, char *bf, size_t size,
> >                         default_scnprintf =3D sc->arg_fmt[arg.idx].scnp=
rintf;
> >
> >                         if (trace->force_btf ||
> > -                           (default_scnprintf =3D=3D NULL ||
> > -                            (default_scnprintf =3D=3D SCA_PTR && strst=
r(field->type, "struct")))) {
> > +                           (default_scnprintf =3D=3D NULL || (default_=
scnprintf =3D=3D SCA_PTR))) {
>=20
> Can we discard the parenthesis surrounding the 'default_scnprintf =3D=3D =
SCA_PTR'?
>=20
> (default_scnprintf =3D=3D NULL || default_scnprintf =3D=3D SCA_PTR)) {
>=20
> Thanks,
> Howard
> >                                 btf_printed =3D trace__btf_scnprintf(tr=
ace, &arg, bf + printed,
> >                                                                    size=
 - printed, val, field->type);
> >                                 if (btf_printed) {
> > @@ -3663,14 +3662,18 @@ static int trace__bpf_sys_enter_beauty_map(stru=
ct trace *trace, int key, unsigne
> >                 return -1;
> >
> >         for (i =3D 0, field =3D sc->args; field; ++i, field =3D field->=
next) {
> > -               struct_offset =3D strstr(field->type, "struct ");
> > -
> >                 // XXX We're only collecting pointer payloads _from_ us=
er space
> >                 if (!sc->arg_fmt[i].from_user)
> >                         continue;
> >
> > -               if (field->flags & TEP_FIELD_IS_POINTER && struct_offse=
t) { /* struct */
> > -                       struct_offset +=3D 7;
> > +               struct_offset =3D strstr(field->type, "struct ");
> > +               if (struct_offset =3D=3D NULL)
> > +                       struct_offset =3D strstr(field->type, "union ");
> > +               else
> > +                       struct_offset++; // "union" is shorter
> > +
> > +               if (field->flags & TEP_FIELD_IS_POINTER && struct_offse=
t) { /* struct or union (think BPF's attr arg) */
> > +                       struct_offset +=3D 6;
> >
> >                         /* for 'struct foo *', we only want 'foo' */
> >                         for (tmp =3D struct_offset, cnt =3D 0; *tmp !=
=3D ' ' && *tmp !=3D '\0'; ++tmp, ++cnt) {
> > --
> > 2.46.0
> >

