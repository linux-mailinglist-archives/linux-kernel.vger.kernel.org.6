Return-Path: <linux-kernel+bounces-529793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A950A42AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3753B80DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F2264FBE;
	Mon, 24 Feb 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clSfQpCp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ADB1A5B82
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421131; cv=none; b=DX0UsrSYW8wNN9g2mZn/9PUy1igWr+ZbllMRaT7Ke0AqdelaLUErhjaT8sh+ous05ITh5BrH2LDLHOUFzmcUxOhbQfL/kdsgxSX/st4CBgc5yL8c2DeqJmIakxK4H3Mss4cjJ3lDzpL8xADIhz5coYKSYnmFDz4fAbPvb1J9PhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421131; c=relaxed/simple;
	bh=byxv+mlOvSHfc90q+hw4mXLTnXfG69/YARVK3lak8rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW0r2ZnIri9FaZbr4AdfKvfQ6t5E4PcJW3VG3VKoEVUOGED5DqI/xuot4TejuBGGg3+nqx7s34fp5DucQD17TKx/DZlrUKbkx25ZtXjk1nEe+TJMmAGxtoCLFDxaMfH/XUD51eWMGklqKmrrvi0J2nvZIn5QG+Q3GhWH80ET0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clSfQpCp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2212222d4cdso15835ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740421129; x=1741025929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1r0DTBemJTbWIAcMf/B1UyOUvQ5l7Xx+cguq8yf/Eo=;
        b=clSfQpCp3q4jA2VprAPbqzzvdzI/n7C8gvfcR2GfCGRJXCYDXEjMGz9RY/28pDvplT
         seTe4SpKQJu9ti5WMJjgD+jEIB6uaeOhBDHVgmOsGsFh2ZfX1UiSaDUusTingRxfPbLl
         DdlhSDBcGKOIo4ubVGXJ4ANG0sWundrL4zBadSFDoXNgyZct4D5UsYtK+FNxnxCBPVbO
         BK1NbzPMuZSlO9nUeA6oTU6KzoOx77ZMOk5YDNT7ifZxdwojfIORJVt5VDAP5zd7fbMW
         tzMWM8drVUthpue0WkdOvEt9042rd7CE4ueDXkjbJ94DrixGeUcbcvVRYobAHmTd0+S5
         owjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421129; x=1741025929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1r0DTBemJTbWIAcMf/B1UyOUvQ5l7Xx+cguq8yf/Eo=;
        b=oCWwhGT6tuaXfjSOwKMUKzopKU1RY+Tb9gAxfXQ8angpqs4NQ8432hY9FC0wbkA5Vc
         TE6TrGENgij+XHW+GM5HS59+kgAZzPWmnMavoYk/qoXMmxof+gjGM6cj+P7d9YB2HHKm
         t4X7xhWFMp3F3capxxS+OeoqBL9d1r0lIv7RCi+hV9smjKE1WCs0F2z6TyHL8kZ6VfcZ
         KJgGRn0JCd1rPBjiotVnpdYr0B7mcQn0zeQDTBiFpB4n5Xr5BqZdaqcDsPFCflOe1EYS
         eA7Avg9772TJJOvDXrTso7qKJ4FoU+cVNs5JXMFzlD0XkjlxTBaBOKwVVTGIAUWAJ/wA
         ya4w==
X-Forwarded-Encrypted: i=1; AJvYcCWO1IwmT8ylelY6Sj1FeWOVyjiPID6wal532WzMspOcR6otnur6/uP049GaCtS2k77X2gmRI6gZdDDOjd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwTIZXZ7VTg8llI0E6l6rpz9QJ+FaE7qpZv7y/+01DyCdsiWA
	+TRgYQGuosdvaDVBihmVczzefgQPnHmzpH1IYj8xkCfTf3nkFmcooRdstoLdPasjVhz2pXm49EO
	WKnD0jDPMwnMWr6TSECRyOhbZk2yKlX77hXwVKqYTlNyT0TNbP5zl
X-Gm-Gg: ASbGnctV9La+p6+09Knrf4XMc6wKprhdu37gQebc6lKtAVnCjvH9lTcz5oMwKS0RXty
	SeaqV6YEv0284mAAgykiP9p7r0DNOEDuRvu6OZ31klRTEqtikDz7wFw6ijSkwcUOH9dO52BbBDl
	P9BzmGprnyOwro+NfVeEf6Kb5jyb3aHXejUoY=
X-Google-Smtp-Source: AGHT+IHEFEZ9FZxtzjYAWGpCcbgOAoyMIes/Md1kSlYdOsjB7A+9rtZtRYeazBrgOVOotB7ncX6mp3R8Un+4ZHl4itw=
X-Received: by 2002:a17:902:e80b:b0:21f:2828:dc82 with SMTP id
 d9443c01a7336-22307a2fea8mr318725ad.2.1740421128666; Mon, 24 Feb 2025
 10:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
 <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
 <Z6_CL0RpUUvw0lR7@x1> <Z7TvZGjVix2asYWI@x1> <Z7T1LVSLo8EEMmkM@x1>
 <Z7UDlZKnqXRqNqQa@google.com> <Z7XsltyqUWrdKma0@x1> <Z7XvEFEZtCRZKG7Y@x1>
 <Z7ZIqpwffQbibwL2@google.com> <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com>
In-Reply-To: <Z7gllQZeg6U2OvZE@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 10:18:37 -0800
X-Gm-Features: AWEUYZkfLaCHbD8kiSJIc6pf9-FZYteh7wKLZDID1Kp-CkEcsg3AY_S-Cw_MqT4
Message-ID: <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Feb 20, 2025 at 09:12:46AM -0800, Ian Rogers wrote:
> > On Wed, Feb 19, 2025 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 03:47:44PM +0100, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Wed, Feb 19, 2025 at 03:37:10PM +0100, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Tue, Feb 18, 2025 at 02:03:01PM -0800, Namhyung Kim wrote:
> > > > > > On Tue, Feb 18, 2025 at 10:01:33PM +0100, Arnaldo Carvalho de M=
elo wrote:
> > > > > > > On Tue, Feb 18, 2025 at 09:36:52PM +0100, Arnaldo Carvalho de=
 Melo wrote:
> > > > > > > > So the call to maps_fixup_end() will set maps->end_broken t=
o false,
> > > > > > > > since it fixed up the map ends, etc, but then we insert mor=
e maps with
> > > > > > > > broken ends:
> > > > > > >
> > > > > > > > #6  0x0000000000633d52 in check_invariants (maps=3D0xf967c0=
) at util/maps.c:95
> > > > > > > > 95                                            assert(map__e=
nd(prev) <=3D map__end(map));
> > > > > > > > (gdb) p prev->dso->name
> > > > > > > > $1 =3D 0xfc47ab "bpf_trampoline_6442522522"
> > > > > > >
> > > > > > > So the above map is created overlapping a previously existing=
 map:
> > > > > > >
> > > > > > > root@number:~# perf probe -l
> > > > > > >   probe_perf:maps_fixup_end (on maps__fixup_end:1@util/maps.c=
 in /home/acme/bin/perf with maps)
> > > > > > >   probe_perf:maps_insert (on maps__insert:1@util/maps.c in /h=
ome/acme/bin/perf with maps name start end)
> > > > > > > root@number:~#
> > > > > > >
> > > > > > > root@number:~# perf trace --lib -e probe_perf:maps* perf reco=
rd sleep
> > > > > > > <SNIP>
> > > > > > >    319.791 perf/1732173 probe_perf:maps_insert((634e5e) maps=
=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_egress" start=3D0xfff=
fffffc0160788 end=3D0xffffffffc01607c8)
> > > > > > >    319.810 perf/1732173 probe_perf:maps_insert((634e5e) maps=
=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=3D0xff=
ffffffc01647b8 end=3D0xffffffffc01647f8)
> > > > > > >    319.822 perf/1732173 probe_perf:maps_insert((634e5e) maps=
=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_egress" start=3D0xfff=
fffffc016482c end=3D0xffffffffc016486c)
> > > > > > >    319.834 perf/1732173 probe_perf:maps_insert((634e5e) maps=
=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=3D0xff=
ffffffc01648ac end=3D0xffffffffc01648ec)
> > > > > > >    319.845 perf/1732173 probe_perf:maps_insert((634e5e) maps=
=3D0x2d9715d0 name=3D"bpf_prog_be31ae23198a0378_sd_devices" start=3D0xfffff=
fffc0186388 end=3D0xffffffffc01864b2)
> > > > > > >    319.857 perf/1732173 probe_perf:maps_insert((634e5e) maps=
=3D0x2d9715d0 name=3D"bpf_trampoline_6442522522" start=3D0xffffffffc0147640=
 end=3D0xffffffffc0148640)
> > > > > > > [ perf record: Captured and wrote 0.035 MB perf.data (7 sampl=
es) ]
> > > > > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(p=
rev) <=3D map__end(map)' failed.
> > > > > > > root@number:~#
> > > > > > >
> > > > > > > So a PERF_RECORD_KSYMBOL processing will add a map for
> > > > > > > "bpf_trampoline_6442522522" that has its start after before t=
he
> > > > > > > "bpf_prog_40ddf486530245f5_sd_devices" start, ok, but ends af=
ter
> > > > > > > "bpf_prog_40ddf486530245f5_sd_devices", overlapping it.
> > > > > > >
> > > > > > > machine__process_ksymbol_register() does:
> > > > > > >
> > > > > > > 713                     map__set_start(map, event->ksymbol.ad=
dr);
> > > > > > > 714                     map__set_end(map, map__start(map) + e=
vent->ksymbol.len);
> > > > > > > 715                     err =3D maps__insert(machine__kernel_=
maps(machine), map);
> > > > > > >
> > > > > > > And:
> > > > > > >
> > > > > > > (gdb) p /x event->ksymbol.addr
> > > > > > > $2 =3D 0xffffffffc0147a2c
> > > > > > > (gdb) p event->ksymbol.len
> > > > > > > $3 =3D 306
> > > > > >
> > > > > > Hmm.. so I think the situation is like below.
> > > > > >
> > > > > >              (bpf_trampoline_6442522522)
> > > > > >       +---------------------------------------+
> > > > > >       |                                       |
> > > > > >       |       +------------------------+      |
> > > > > >       |       | (bpf_prog_40ddf486...) | <----+----  adding thi=
s
> > > > > >       |       |                        |      |
> > > > > >       |       |                        |      |
> > > > > >       |   c0147a2c                            |
> > > > > >       |                                       |
> > > > > >   c0147640                                 c0148640
> > > > > >
> > > > > > And it failed to add bpf_prog_40ddf486... in check_invariants()=
 because
> > > > > > the end address is smaller than the previous map.
> > > > >
> > > > > No, it didn't fail to add, it managed to do it which left the ker=
nel
> > > > > maps in a broken state, with overlappings while it had a cleared
> > > > > ends_broken, then, later, when the checks_invariant is finally ca=
lled at
> > > > > perf record exit time:
> > > >
> > > > Nope, __maps__insert() should notice that the ends are broken and s=
et
> > > > it:
> > > >
> > > >         if (nr_maps =3D=3D 1) {
> > > >                 /* If there's just 1 entry then maps are sorted. */
> > > >                 maps__set_maps_by_address_sorted(maps, true);
> > > >                 maps__set_maps_by_name_sorted(maps, maps_by_name !=
=3D NULL);
> > > >         } else {
> > > >                 /* Sorted if maps were already sorted and this map =
starts after the last one. */
> > > >                 maps__set_maps_by_address_sorted(maps,
> > > >                         maps__maps_by_address_sorted(maps) &&
> > > >                         map__end(maps_by_address[nr_maps - 2]) <=3D=
 map__start(new));
> > > >                 maps__set_maps_by_name_sorted(maps, false);
> > > >         }
> > > >         if (map__end(new) < map__start(new))
> > > >                 RC_CHK_ACCESS(maps)->ends_broken =3D true;
> > > >
> > > >
> > > > humm, RC_CHK_ACCESS(maps)->ends_broken should be set for the case w=
e
> > > > have and I think it isn't being... Then the bpf trampoline map that=
 is
> > > > the last entry to be added is before the last entry and thus
> > > > maps_by_address_sorted is set to false, ends_broken continues false=
 and
> > > > at the end maps_by_address_sorted is set to true and the last
> > > > check_invariants triggerrs the asserts...
> > >
> > > Right, probably it needs to set the ends_broken when the end address =
of
> > > the new map is smaller than the previous (but the start address is
> > > bigger) and fixup the end address when it sorts the maps by address.
> >
> > Ugh, I get git blamed for ends_broken and I was wondering what the heck=
 it is:
> > https://lore.kernel.org/all/20240210031746.4057262-2-irogers@google.com=
/
> > My memory is that when the rb-tree was built the maps put in it could
> > be broken and ends_broken was to capture we were in this state as the
> > sorting would get broken, invariants be off, etc.. The rb-tree
> > constructing code would then call maps__fixup_end. Having the caller
> > call maps__fixup_end seems error prone, as does the whole
> > "ends_broken" thing - remember I was in the code to fix memory leaks
> > so modifying the maps API wasn't front of mind. I added ends_broken,
> > the original rb-tree had no notion of it, because I was trying to get
> > the invariants right for the testing I could do and ends_broken was
> > the pragmatic thing to do for odd cases like kernel modules before
> > maps__fixup_end is called.
> >
> > The maps API has evolved and we have a pretty robust, but possibly not
> > fast, maps__fixup_overlap_and_insert:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/maps.h?h=3Dperf-tools-next#n69
> > I think ideally we'd make maps__insert uphold the invariants and not
> > have ends_broken. I'm worried that making ends_broken more load
> > bearing isn't the right thing to do, we may even be able to not have
> > the variable for the "ifndef NDEBUG" case, which making it load
> > bearing would completely defeat.
> >
> > So I think the fix here should be to understand the maps construction
> > code for the modules, try to work out why maps__fixup_end wasn't
> > called, perhaps migrate the code to maps__fixup_overlap_and_insert or
> > add a missed maps__fixup_end call.
>
> IIUC module size in /proc/modules are wrong due to the reason in the
> commit 876e80cf83d10585 ("perf tools: Fixup end address of modules") and
> it called maps__fixup_end() for that.
>
> But the problem is some BPF maps processed at real-time during the
> build-id processing at the end of perf record.  One map is inside of
> another and check_invariants() didn't expect such maps and crashed.

I thought the real-time processing had to use
maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
events only give us VMA data and two mmaps may have been merged.
Shouldn't doing this change be the simplest fix?

Thanks,
Ian

> Maybe we can fix maps__insert() to check such condition and fix it
> everytime.  But it means it needs to sort the maps which would add big
> overhead we had before.  So I just wanted to set the flag quickly and
> to fix the end address when it calls maps__find() or similar later.
>
> Thanks,
> Namhyung
>
> >
> > Given the blame I kind of feel responsible for this, but the real
> > issue is adding the invariant checks has caught a latent bug that the
> > rb-tree code would have just ignored and possibly been broken as a
> > consequence. I lack bandwidth and a reproduction so thank you for
> > digging into this.
> >
> > Thanks,
> > Ian

