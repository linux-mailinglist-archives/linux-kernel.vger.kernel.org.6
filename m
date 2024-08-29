Return-Path: <linux-kernel+bounces-307729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B1965233
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB21F2514E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909301BA860;
	Thu, 29 Aug 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDz17oKi"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7A18A933
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967773; cv=none; b=qVPJ8MOc8pUG1nAJmiW6tQFArL9pAUYzNYMZFWQWsStwT1a12p6x77u03+OzUCTCMRNF2NoPJc8a4zvSsH1I7XCdciayya5Z7FedBX5xFM1iofP/qJCXZ1wmwufWXyH/WYnUqSLn/v8mJ+TaL+5vAZAO2zm+wEGvGem42dplSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967773; c=relaxed/simple;
	bh=vtWDT6Vu1puU+hWEFmxTGOhkNx3LusYEOO3n+xyl5q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW0Odmz0IbRkbMfxqXgQBkdvM6hbLfpt1ch2SsZ/wnKRtJ2qa1WAG2OkUuEmPPZZ87q+RojHwzAixRKnHvhkgFegu8BEvGG4Q2qOjy2aEjHczIUEEIkwxfN4lpowep5HUzinDrFa4tkEPAb0YgUZ7rKtDw5TjxYKfgfBilPjC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDz17oKi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45029af1408so30621cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724967770; x=1725572570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iagrj9YxCcEDRrPDPEXSMUMr7qKWs/FPJbPEPwzxc+c=;
        b=PDz17oKiwGV7VDPjoUfq2W9nlbBWBIM+WQdKQqjYMwNgbO+enk1xe0LaoVH0BORiLC
         S4GbtYCA2YH8gbZ91FE+guuEsKQxn1eFUqQrJ8+pFB53hwiNh71K8IrF7zOQINUmZaRE
         1yVUGAlx5T7SZ2O2uV6GC+CtVeXW/s3ksL/v1fgB7vBvcJ+6IdEzg+crrOs2MSp3k7et
         BQIvh+55KBw+McVHs2PfN7XjMAhZ7mzHnQfd0HujMqQ5dWNvRuAAJKyh/oq01q07n5kE
         4NJVISEX/yIi6gXH0yXHNbaZu7kz7mlvziwLq11u0fCpLfq/suAJioXaiMj2aSA+QyDm
         6EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967770; x=1725572570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iagrj9YxCcEDRrPDPEXSMUMr7qKWs/FPJbPEPwzxc+c=;
        b=GOqO7GTUkszAOVltHML2fs/bCVbgY9248EeEwORcsTBzFYTOCC1j5+GJfth2Pp96Y/
         1k1aT1wBY2d/UKrYQ2SEfeGNIy8B10/4TrUSbnp7uRid2gnOpg81odQkZEmghVvBlCMT
         FykpLddFmFR2s6TIox4RELn0I2M8+fXA0xLnhumh1aC8pWF50RZWGJyPUa9gLveEaNdG
         y0l7eJbco7NBMPKc4CXJJB9YdHJzfr3dEGEjyaX1uqkzw5ls7Wk6O6Gq7HBFHQyqUM4j
         BlHkYkdkXYQFRYG5B7Q9K7B2msB8A9BQKN+PAWTKfn0Q/jOLHWCb2DMkKuYSwo053G3F
         /nAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkMH1u/T++VMJkN+21VK1b+WNl3EC3fIaGWpuxT9UHAzYtTX0RQ4uGtA5CUAsk34pRlvLXv4RVHqSneOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ARL95J1iTOjrx1X8ybKkYzgQ9mujFEoNGgdXcyKPETTn7l+/
	gT0xPcA8hMvlbJZz3U/hcyyxHWgBHP5S/TnF8LyB3+oNOd2kTgEWWkSiFaUpgxulAQAf4YP+6aM
	o/mriy2y9mFiNARMwrpf5YFQHIOtT3ts5cVKW
X-Google-Smtp-Source: AGHT+IGT/2Tru3/ZbzfFvp8Sv6QDtWcBQCVigmN841I3eJzMG0iNTSF44MhOzYG5FGXt20XENS1U1h0jK2oruwnowtA=
X-Received: by 2002:a05:622a:a54c:b0:456:7ec0:39a9 with SMTP id
 d75a77b69052e-4568bd92327mr293581cf.5.1724967769731; Thu, 29 Aug 2024
 14:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com> <20240829150154.37929-6-irogers@google.com>
 <ZtDMf886_1vXWt49@x1> <CAP-5=fURe7yVy6OGWdKn1eSzsdfZPyvvc5fRMPeNAjukaWOe1w@mail.gmail.com>
 <ZtDg2BAI0V5zKpjn@x1>
In-Reply-To: <ZtDg2BAI0V5zKpjn@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Aug 2024 14:42:38 -0700
Message-ID: <CAP-5=fXa0r7sD9xbtBVbJQFgnq=3i-cnj6gUX9tze0JyhLhvZw@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] perf header: Allow attributes to be written after data
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nick Terrell <terrelln@fb.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:58=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 01:12:32PM -0700, Ian Rogers wrote:
> > On Thu, Aug 29, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 08:01:51AM -0700, Ian Rogers wrote:
> > > > With a file, to write data an offset needs to be known. Typically d=
ata
> > > > follows the event attributes in a file. However, if processing a pi=
pe
> > > > the number of event attributes may not be known. It is convenient i=
n
> > > > that case to write the attributes after the data. Expand
> > > > perf_session__do_write_header to allow this when the data offset an=
d
> > > > size are known.
> > > >
> > > > This approach may be useful for more than just taking a pipe file t=
o
> > > > write into a data file, `perf inject --itrace` will reserve and
> > > > additional 8kb for attributes, which would be unnecessary if the
> > > > attributes were written after the data.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/header.c | 106 +++++++++++++++++++++++++----------=
----
> > > >  1 file changed, 67 insertions(+), 39 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > index 65c9086610cb..4eb39463067e 100644
> > > > --- a/tools/perf/util/header.c
> > > > +++ b/tools/perf/util/header.c
> > > > @@ -3676,32 +3676,50 @@ int perf_header__write_pipe(int fd)
> > > >  static int perf_session__do_write_header(struct perf_session *sess=
ion,
> > > >                                        struct evlist *evlist,
> > > >                                        int fd, bool at_exit,
> > > > -                                      struct feat_copier *fc)
> > > > +                                      struct feat_copier *fc,
> > > > +                                      bool write_attrs_after_data)
> > > >  {
> > > >       struct perf_file_header f_header;
> > > > -     struct perf_file_attr   f_attr;
> > > >       struct perf_header *header =3D &session->header;
> > > >       struct evsel *evsel;
> > > >       struct feat_fd ff =3D {
> > > >               .fd =3D fd,
> > > >       };
> > > > -     u64 attr_offset;
> > > > +     u64 attr_offset =3D sizeof(f_header), attr_size =3D 0;
> > > >       int err;
> > > >
> > > > -     lseek(fd, sizeof(f_header), SEEK_SET);
> > > > +     if (write_attrs_after_data && at_exit) {
> > > > +             /*
> > > > +              * Write features at the end of the file first so tha=
t
> > > > +              * attributes may come after them.
> > > > +              */
> > > > +             if (!header->data_offset && header->data_size) {
> > > > +                     pr_err("File contains data but offset unknown=
\n");
> > > > +                     err =3D -1;
> > > > +                     goto err_out;
> > > > +             }
> > > > +             header->feat_offset =3D header->data_offset + header-=
>data_size;
> > > > +             err =3D perf_header__adds_write(header, evlist, fd, f=
c);
> > > > +             if (err < 0)
> > > > +                     goto err_out;
> > > > +             attr_offset =3D lseek(fd, 0, SEEK_CUR);
> > > > +     } else {
> > > > +             lseek(fd, attr_offset, SEEK_SET);
> > > > +     }
> > > >
> > > >       evlist__for_each_entry(session->evlist, evsel) {
> > > > -             evsel->id_offset =3D lseek(fd, 0, SEEK_CUR);
> > > > -             err =3D do_write(&ff, evsel->core.id, evsel->core.ids=
 * sizeof(u64));
> > > > -             if (err < 0) {
> > > > -                     pr_debug("failed to write perf header\n");
> > > > -                     free(ff.buf);
> > > > -                     return err;
> > > > +             evsel->id_offset =3D attr_offset;
> > > > +             /* Avoid writing at the end of the file until the ses=
sion is exiting. */
> > > > +             if (!write_attrs_after_data || at_exit) {
> > > > +                     err =3D do_write(&ff, evsel->core.id, evsel->=
core.ids * sizeof(u64));
> > > > +                     if (err < 0) {
> > > > +                             pr_debug("failed to write perf header=
\n");
> > > > +                             goto err_out;
> > > > +                     }
> > > >               }
> > > > +             attr_offset +=3D evsel->core.ids * sizeof(u64);
> > >
> > > So in the past we were using lseek(fd, 0, SEEK_CUR) to set the
> > > evsel->id_offset, now you're assuming that do_write will honour the s=
ize
> > > parameter, i.e. write evsel->core.ids * sizeof(u64), but:
> > >
> > > /* Return: 0 if succeeded, -ERR if failed. */
> > > int do_write(struct feat_fd *ff, const void *buf, size_t size)
> > > {
> > >         if (!ff->buf)
> > >                 return __do_write_fd(ff, buf, size);
> > >         return __do_write_buf(ff, buf, size);
> > > }
> > >
> > > And then:
> > >
> > > static int __do_write_fd(struct feat_fd *ff, const void *buf, size_t =
size)
> > > {
> > >         ssize_t ret =3D writen(ff->fd, buf, size);
> > >
> > >         if (ret !=3D (ssize_t)size)
> > >                 return ret < 0 ? (int)ret : -1;
> > >         return 0;
> > > }
> > >
> > > I see that writen calls ion that even has a BUG_ON() if it doesn't wr=
ite
> > > exactly the requested size bytes, I got distracted with __do_write_fd
> > > extra check that ret !=3D size returning ret if not negative...
> > >
> > > I.e. your code _should_ be equivalent due to the check in ion(), and
> > > taking that as an assumption you reduce the number of lseek syscalls,
> > > which is a good thing...
> > >
> > > I was just trying to see that the !write_attrs_after_data case was
> > > _exactly_ the same as before, which it doesn't look like it is :-\
> >
> > I'm not seeing the difference. Before:
>
> You noticed the difference: before we used lseek to get the current
> offset to use, afterwards we moved to doing plain math.
>
> So I had to check if we could assume that, and with the current code
> structure, yes, we can assume that, so seems safe, but it is different
> and if the assumption somehow breaks, as the code in __do_write_fd()
> guard against (unneeded at the moment as ion has even a BUG_ON for that
> not to happen), then the offset will not be where the data is.
>
> Using lseek() is more costly (syscalls) but it is the ultimate answer to
> get where in the file the current offset is.
>
> So that is the difference I noticed.
>
> Doing multiple things in the same patch causes these reviewing delays,
> doubts, its something we discussed multiple times in the past, and that
> continue to cause these discussions.

Right, but it is something of an unfortunate coincidence of how the
code is structured. The fact that writing the header updates
data_offset which is a thing that other things depend upon while
depending on its value itself, etc. - ie the function does more than
just a write, it also sometimes computes the layout, has inbuilt
assumptions on the values lseek will return, and so on. To get to this
final structure took a fair few iterations and I've separated this
change out from the bulk in the next change to keep the patch size
down. I could have done a patch switching from lseeks to math, then a
patch to add write_attrs_after_data. It probably would have yielded
about 4 lines of shared code, more lines that would have been deleted,
while creating quite a bit of work for me. Ideally when these
functions were created there would have been far more liberal use of
things like immutability, so side-effects are minimized. Yes I could
refactor everything, but time..

Thanks,
Ian

> - Arnaldo
>
> > ```
> > lseek(fd, sizeof(f_header), SEEK_SET);
> > evlist__for_each_entry(session->evlist, evsel) {
> >     evsel->id_offset =3D lseek(fd, 0, SEEK_CUR); // Initially at sizeof=
(f_header)
> > ...
> >     err =3D do_write(&ff, evsel->core.id, evsel->core.ids *
> > sizeof(u64));  // offset has advanced by "evsel->core.ids *
> > sizeof(u64)" bytes
> > ...
> > }
> > ```
> > After:
> > ```
> > u64 attr_offset =3D sizeof(f_header)
> > ...
> > else {
> >     lseek(fd, attr_offset, SEEK_SET);
> > }
> >
> > evlist__for_each_entry(session->evlist, evsel) {
> >     evsel->id_offset =3D attr_offset;
> > ...
> >     err =3D do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64)=
);
> > ...
> >     attr_offset +=3D evsel->core.ids * sizeof(u64);
> > }
> > ```
> >
> > The reason for using math rather than lseek (apart from reducing
> > syscalls) is that if we're writing the header at the beginning of
> > generating a file (usually done more to compute the
> > header->data_offset), we can't use lseek if writing at the end as we
> > don't know where the end of the data will be yet and don't write out
> > the bytes.
> >
> > Thanks,
> > Ian
> >
> > > - Arnaldo
> > >
> > > >       }
> > > >
> > > > -     attr_offset =3D lseek(ff.fd, 0, SEEK_CUR);
> > > > -
> > > >       evlist__for_each_entry(evlist, evsel) {
> > > >               if (evsel->core.attr.size < sizeof(evsel->core.attr))=
 {
> > > >                       /*
> > > > @@ -3711,40 +3729,46 @@ static int perf_session__do_write_header(st=
ruct perf_session *session,
> > > >                        */
> > > >                       evsel->core.attr.size =3D sizeof(evsel->core.=
attr);
> > > >               }
> > > > -             f_attr =3D (struct perf_file_attr){
> > > > -                     .attr =3D evsel->core.attr,
> > > > -                     .ids  =3D {
> > > > -                             .offset =3D evsel->id_offset,
> > > > -                             .size   =3D evsel->core.ids * sizeof(=
u64),
> > > > +             /* Avoid writing at the end of the file until the ses=
sion is exiting. */
> > > > +             if (!write_attrs_after_data || at_exit) {
> > > > +                     struct perf_file_attr f_attr =3D {
> > > > +                             .attr =3D evsel->core.attr,
> > > > +                             .ids  =3D {
> > > > +                                     .offset =3D evsel->id_offset,
> > > > +                                     .size   =3D evsel->core.ids *=
 sizeof(u64),
> > > > +                             }
> > > > +                     };
> > > > +                     err =3D do_write(&ff, &f_attr, sizeof(f_attr)=
);
> > > > +                     if (err < 0) {
> > > > +                             pr_debug("failed to write perf header=
 attribute\n");
> > > > +                             goto err_out;
> > > >                       }
> > > > -             };
> > > > -             err =3D do_write(&ff, &f_attr, sizeof(f_attr));
> > > > -             if (err < 0) {
> > > > -                     pr_debug("failed to write perf header attribu=
te\n");
> > > > -                     free(ff.buf);
> > > > -                     return err;
> > > >               }
> > > > +             attr_size +=3D sizeof(struct perf_file_attr);
> > > >       }
> > > >
> > > > -     if (!header->data_offset)
> > > > -             header->data_offset =3D lseek(fd, 0, SEEK_CUR);
> > > > +     if (!header->data_offset) {
> > > > +             if (write_attrs_after_data)
> > > > +                     header->data_offset =3D sizeof(f_header);
> > > > +             else
> > > > +                     header->data_offset =3D attr_offset + attr_si=
ze;
> > > > +     }
> > > >       header->feat_offset =3D header->data_offset + header->data_si=
ze;
> > > >
> > > > -     if (at_exit) {
> > > > +     if (!write_attrs_after_data && at_exit) {
> > > > +             /* Write features now feat_offset is known. */
> > > >               err =3D perf_header__adds_write(header, evlist, fd, f=
c);
> > > > -             if (err < 0) {
> > > > -                     free(ff.buf);
> > > > -                     return err;
> > > > -             }
> > > > +             if (err < 0)
> > > > +                     goto err_out;
> > > >       }
> > > >
> > > >       f_header =3D (struct perf_file_header){
> > > >               .magic     =3D PERF_MAGIC,
> > > >               .size      =3D sizeof(f_header),
> > > > -             .attr_size =3D sizeof(f_attr),
> > > > +             .attr_size =3D sizeof(struct perf_file_attr),
> > > >               .attrs =3D {
> > > >                       .offset =3D attr_offset,
> > > > -                     .size   =3D evlist->core.nr_entries * sizeof(=
f_attr),
> > > > +                     .size   =3D attr_size,
> > > >               },
> > > >               .data =3D {
> > > >                       .offset =3D header->data_offset,
> > > > @@ -3757,21 +3781,24 @@ static int perf_session__do_write_header(st=
ruct perf_session *session,
> > > >
> > > >       lseek(fd, 0, SEEK_SET);
> > > >       err =3D do_write(&ff, &f_header, sizeof(f_header));
> > > > -     free(ff.buf);
> > > >       if (err < 0) {
> > > >               pr_debug("failed to write perf header\n");
> > > > -             return err;
> > > > +             goto err_out;
> > > > +     } else {
> > > > +             lseek(fd, 0, SEEK_END);
> > > > +             err =3D 0;
> > > >       }
> > > > -     lseek(fd, header->data_offset + header->data_size, SEEK_SET);
> > > > -
> > > > -     return 0;
> > > > +err_out:
> > > > +     free(ff.buf);
> > > > +     return err;
> > > >  }
> > > >
> > > >  int perf_session__write_header(struct perf_session *session,
> > > >                              struct evlist *evlist,
> > > >                              int fd, bool at_exit)
> > > >  {
> > > > -     return perf_session__do_write_header(session, evlist, fd, at_=
exit, NULL);
> > > > +     return perf_session__do_write_header(session, evlist, fd, at_=
exit, /*fc=3D*/NULL,
> > > > +                                          /*write_attrs_after_data=
=3D*/false);
> > > >  }
> > > >
> > > >  size_t perf_session__data_offset(const struct evlist *evlist)
> > > > @@ -3793,7 +3820,8 @@ int perf_session__inject_header(struct perf_s=
ession *session,
> > > >                               int fd,
> > > >                               struct feat_copier *fc)
> > > >  {
> > > > -     return perf_session__do_write_header(session, evlist, fd, tru=
e, fc);
> > > > +     return perf_session__do_write_header(session, evlist, fd, tru=
e, fc,
> > > > +                                          /*write_attrs_after_data=
=3D*/false);
> > > >  }
> > > >
> > > >  static int perf_header__getbuffer64(struct perf_header *header,
> > > > --
> > > > 2.46.0.295.g3b9ea8a38a-goog

