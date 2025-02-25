Return-Path: <linux-kernel+bounces-530425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198EA4334B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E298D189BB40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B214387B;
	Tue, 25 Feb 2025 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSRKPJlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CFBE65;
	Tue, 25 Feb 2025 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451870; cv=none; b=Q/UjAnb4nEJ3rYIAu+ekrLl7QWQySV5ZDoBRrtlvZNX2OJLupyx+a07q4BwX2bE5NlW6woEnKih1oN794KLWu+reKl/9G0e6BPumUFrvSXF9JDvb+SxwPqi4TV1hOWcL5YBknrrH5aj680fjV8B5u3Jet0Cma6ZMHGbCX6X11EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451870; c=relaxed/simple;
	bh=FJbakWD9MrvkqKR6OsFbXn/1wjKE7jxTcouQ0muKlRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmwvW8OEclpgWGmupOeKUoFK76Hj0XW6hijSq5p03OajeRcsICbLKu+97wahNu7PIPRGcW+h3YNag45mRLK1j/ThjFHMsEVy6tPkYHp3nuc1MxrR5hyfWtCV+9/xX276Zm7cdKLuEpB+tFKxtR9njO6f8AHlmZm3i6lwKjV3/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSRKPJlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A42C4CED6;
	Tue, 25 Feb 2025 02:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740451870;
	bh=FJbakWD9MrvkqKR6OsFbXn/1wjKE7jxTcouQ0muKlRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSRKPJlYbB7xhj9u8SiIoVAB3h3RAm+zhQj2j/BNev+UoivL/LRAVorE1n/LqiN1q
	 I4XYi2qbxGNfU+ZkR2bXXJKqNjLoKiC2MeR/tPm2lad7bLF2S9Jc9+xIYdpEG+Y4Ur
	 +sVsjkVltLdPoxLZQPgO2GGzfUziuwrGcDZSe+zJUrDEpmxZ9JInWYoPaq89eftyPZ
	 SigiFpSJIYrWy05Tsjb21FfTmljTW3ggavdkvMhYJAx+non9rufdRJJX5NXJg01lPd
	 5Gf5f/f0o+mPvsyAsagvgXut5ufcnZbxzXmylv98ropLj+q2BAMUtAbGX/mtsTSKpq
	 mEGU34N7NwKXQ==
Date: Mon, 24 Feb 2025 18:51:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z70wHEl6Sp0H0c-3@google.com>
References: <Z6_CL0RpUUvw0lR7@x1>
 <Z7TvZGjVix2asYWI@x1>
 <Z7T1LVSLo8EEMmkM@x1>
 <Z7UDlZKnqXRqNqQa@google.com>
 <Z7XsltyqUWrdKma0@x1>
 <Z7XvEFEZtCRZKG7Y@x1>
 <Z7ZIqpwffQbibwL2@google.com>
 <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com>
 <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>

On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> On Thu, Feb 20, 2025 at 11:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Feb 20, 2025 at 09:12:46AM -0800, Ian Rogers wrote:
> > > On Wed, Feb 19, 2025 at 1:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 03:47:44PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > On Wed, Feb 19, 2025 at 03:37:10PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > On Tue, Feb 18, 2025 at 02:03:01PM -0800, Namhyung Kim wrote:
> > > > > > > On Tue, Feb 18, 2025 at 10:01:33PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > > > On Tue, Feb 18, 2025 at 09:36:52PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > > > > So the call to maps_fixup_end() will set maps->end_broken to false,
> > > > > > > > > since it fixed up the map ends, etc, but then we insert more maps with
> > > > > > > > > broken ends:
> > > > > > > >
> > > > > > > > > #6  0x0000000000633d52 in check_invariants (maps=0xf967c0) at util/maps.c:95
> > > > > > > > > 95                                            assert(map__end(prev) <= map__end(map));
> > > > > > > > > (gdb) p prev->dso->name
> > > > > > > > > $1 = 0xfc47ab "bpf_trampoline_6442522522"
> > > > > > > >
> > > > > > > > So the above map is created overlapping a previously existing map:
> > > > > > > >
> > > > > > > > root@number:~# perf probe -l
> > > > > > > >   probe_perf:maps_fixup_end (on maps__fixup_end:1@util/maps.c in /home/acme/bin/perf with maps)
> > > > > > > >   probe_perf:maps_insert (on maps__insert:1@util/maps.c in /home/acme/bin/perf with maps name start end)
> > > > > > > > root@number:~#
> > > > > > > >
> > > > > > > > root@number:~# perf trace --lib -e probe_perf:maps* perf record sleep
> > > > > > > > <SNIP>
> > > > > > > >    319.791 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_egress" start=0xffffffffc0160788 end=0xffffffffc01607c8)
> > > > > > > >    319.810 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=0xffffffffc01647b8 end=0xffffffffc01647f8)
> > > > > > > >    319.822 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_egress" start=0xffffffffc016482c end=0xffffffffc016486c)
> > > > > > > >    319.834 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=0xffffffffc01648ac end=0xffffffffc01648ec)
> > > > > > > >    319.845 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_be31ae23198a0378_sd_devices" start=0xffffffffc0186388 end=0xffffffffc01864b2)
> > > > > > > >    319.857 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_trampoline_6442522522" start=0xffffffffc0147640 end=0xffffffffc0148640)
> > > > > > > > [ perf record: Captured and wrote 0.035 MB perf.data (7 samples) ]
> > > > > > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > > > > > root@number:~#
> > > > > > > >
> > > > > > > > So a PERF_RECORD_KSYMBOL processing will add a map for
> > > > > > > > "bpf_trampoline_6442522522" that has its start after before the
> > > > > > > > "bpf_prog_40ddf486530245f5_sd_devices" start, ok, but ends after
> > > > > > > > "bpf_prog_40ddf486530245f5_sd_devices", overlapping it.
> > > > > > > >
> > > > > > > > machine__process_ksymbol_register() does:
> > > > > > > >
> > > > > > > > 713                     map__set_start(map, event->ksymbol.addr);
> > > > > > > > 714                     map__set_end(map, map__start(map) + event->ksymbol.len);
> > > > > > > > 715                     err = maps__insert(machine__kernel_maps(machine), map);
> > > > > > > >
> > > > > > > > And:
> > > > > > > >
> > > > > > > > (gdb) p /x event->ksymbol.addr
> > > > > > > > $2 = 0xffffffffc0147a2c
> > > > > > > > (gdb) p event->ksymbol.len
> > > > > > > > $3 = 306
> > > > > > >
> > > > > > > Hmm.. so I think the situation is like below.
> > > > > > >
> > > > > > >              (bpf_trampoline_6442522522)
> > > > > > >       +---------------------------------------+
> > > > > > >       |                                       |
> > > > > > >       |       +------------------------+      |
> > > > > > >       |       | (bpf_prog_40ddf486...) | <----+----  adding this
> > > > > > >       |       |                        |      |
> > > > > > >       |       |                        |      |
> > > > > > >       |   c0147a2c                            |
> > > > > > >       |                                       |
> > > > > > >   c0147640                                 c0148640
> > > > > > >
> > > > > > > And it failed to add bpf_prog_40ddf486... in check_invariants() because
> > > > > > > the end address is smaller than the previous map.
> > > > > >
> > > > > > No, it didn't fail to add, it managed to do it which left the kernel
> > > > > > maps in a broken state, with overlappings while it had a cleared
> > > > > > ends_broken, then, later, when the checks_invariant is finally called at
> > > > > > perf record exit time:
> > > > >
> > > > > Nope, __maps__insert() should notice that the ends are broken and set
> > > > > it:
> > > > >
> > > > >         if (nr_maps == 1) {
> > > > >                 /* If there's just 1 entry then maps are sorted. */
> > > > >                 maps__set_maps_by_address_sorted(maps, true);
> > > > >                 maps__set_maps_by_name_sorted(maps, maps_by_name != NULL);
> > > > >         } else {
> > > > >                 /* Sorted if maps were already sorted and this map starts after the last one. */
> > > > >                 maps__set_maps_by_address_sorted(maps,
> > > > >                         maps__maps_by_address_sorted(maps) &&
> > > > >                         map__end(maps_by_address[nr_maps - 2]) <= map__start(new));
> > > > >                 maps__set_maps_by_name_sorted(maps, false);
> > > > >         }
> > > > >         if (map__end(new) < map__start(new))
> > > > >                 RC_CHK_ACCESS(maps)->ends_broken = true;
> > > > >
> > > > >
> > > > > humm, RC_CHK_ACCESS(maps)->ends_broken should be set for the case we
> > > > > have and I think it isn't being... Then the bpf trampoline map that is
> > > > > the last entry to be added is before the last entry and thus
> > > > > maps_by_address_sorted is set to false, ends_broken continues false and
> > > > > at the end maps_by_address_sorted is set to true and the last
> > > > > check_invariants triggerrs the asserts...
> > > >
> > > > Right, probably it needs to set the ends_broken when the end address of
> > > > the new map is smaller than the previous (but the start address is
> > > > bigger) and fixup the end address when it sorts the maps by address.
> > >
> > > Ugh, I get git blamed for ends_broken and I was wondering what the heck it is:
> > > https://lore.kernel.org/all/20240210031746.4057262-2-irogers@google.com/
> > > My memory is that when the rb-tree was built the maps put in it could
> > > be broken and ends_broken was to capture we were in this state as the
> > > sorting would get broken, invariants be off, etc.. The rb-tree
> > > constructing code would then call maps__fixup_end. Having the caller
> > > call maps__fixup_end seems error prone, as does the whole
> > > "ends_broken" thing - remember I was in the code to fix memory leaks
> > > so modifying the maps API wasn't front of mind. I added ends_broken,
> > > the original rb-tree had no notion of it, because I was trying to get
> > > the invariants right for the testing I could do and ends_broken was
> > > the pragmatic thing to do for odd cases like kernel modules before
> > > maps__fixup_end is called.
> > >
> > > The maps API has evolved and we have a pretty robust, but possibly not
> > > fast, maps__fixup_overlap_and_insert:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/maps.h?h=perf-tools-next#n69
> > > I think ideally we'd make maps__insert uphold the invariants and not
> > > have ends_broken. I'm worried that making ends_broken more load
> > > bearing isn't the right thing to do, we may even be able to not have
> > > the variable for the "ifndef NDEBUG" case, which making it load
> > > bearing would completely defeat.
> > >
> > > So I think the fix here should be to understand the maps construction
> > > code for the modules, try to work out why maps__fixup_end wasn't
> > > called, perhaps migrate the code to maps__fixup_overlap_and_insert or
> > > add a missed maps__fixup_end call.
> >
> > IIUC module size in /proc/modules are wrong due to the reason in the
> > commit 876e80cf83d10585 ("perf tools: Fixup end address of modules") and
> > it called maps__fixup_end() for that.
> >
> > But the problem is some BPF maps processed at real-time during the
> > build-id processing at the end of perf record.  One map is inside of
> > another and check_invariants() didn't expect such maps and crashed.
> 
> I thought the real-time processing had to use
> maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> events only give us VMA data and two mmaps may have been merged.
> Shouldn't doing this change be the simplest fix?

Make sense.  How about this?

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 316f0879e5e08d66..d80b34717090db44 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -717,7 +717,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 		map__set_start(map, event->ksymbol.addr);
 		map__set_end(map, map__start(map) + event->ksymbol.len);
-		err = maps__insert(machine__kernel_maps(machine), map);
+		err = maps__fixup_overlap_and_insert(machine__kernel_maps(machine), map);
 		if (err) {
 			err = -ENOMEM;
 			goto out;
@@ -1459,8 +1459,6 @@ static int machine__create_modules(struct machine *machine)
 	if (modules__parse(modules, machine, machine__create_module))
 		return -1;
 
-	maps__fixup_end(machine__kernel_maps(machine));
-
 	if (!machine__set_modules_path(machine))
 		return 0;
 
@@ -1554,6 +1552,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		}
 	}
 
+	maps__fixup_end(machine__kernel_maps(machine));
+
 out_put:
 	dso__put(kernel);
 	return ret;

