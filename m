Return-Path: <linux-kernel+bounces-435617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129FE9E7A30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27652820C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70E1C549C;
	Fri,  6 Dec 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6jOQVG/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699B20458A;
	Fri,  6 Dec 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518127; cv=none; b=S78lpb8awiE7AWNM/Sl+VxnLUiUqLhKkbxINe0etmuPpuBuCnnThjb8EWquuEyngO850HyNKZbdUCnqdGVyhlBVBmY5+qyqtPAPsjcps6VCbFWGsVK7bIiuGs23J6UV55yrDWvvxj/4Q/LlfaRemQYTsFoVPIyGjou2rv7iInj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518127; c=relaxed/simple;
	bh=BQGszL1O9E0CccpW+L2lcg/6KXwBvmkBtbzNTLssjUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVJuxTcqy6roxMOCsg61fIW6GYpZTA4uYdS18Rug2bRoGwnErjLjgm0yKBCmzDYz+ThbapxNKOZUnccwWlgN5GM1SoZ++GY1Kjs+uZKE9KAyJITpK6zAEpFTmaBh4SNjYqgAUBMFswcRYs5RmTeKggoC85BcQRTfp8fug3FJJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6jOQVG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CCBC4CED1;
	Fri,  6 Dec 2024 20:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733518126;
	bh=BQGszL1O9E0CccpW+L2lcg/6KXwBvmkBtbzNTLssjUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6jOQVG/CeWcfcR0LgFChl5GmoRNXgVlV9hjf+4Ih5RXxVASK7yl9d24VMfdIaXtj
	 qZL4tDDhWcT+apaZzKN8UR2ECnAOGeTy/DYfj1KMgq3KSSyUSKvUFww3NZdBHgVwx2
	 OVqqOWUwOXYLLx2mheb/73lMSFUacl82rf79V1r/FxTl4H0qJfujJYmaPwPvB2Ail5
	 prBrJAkQvUezOxeL3/7rPrtdt6bnRkTmzpPYQWwwhu8J/w+UGNFHjMEOEooaouYo//
	 nMbXoXyZ9DKe25azEpDcFUijGk4zYKTEvk2Kdti78TYUPZe4yIdjzbwL0gYc3Te3Mu
	 XbK3gwsUNpcTg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>,
	Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Cc: Francesco Nigro <fnigro@redhat.com>,
	Ilan Green <igreen@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf jitdump: Accept jitdump mmaps emitted from inside containers
Date: Fri,  6 Dec 2024 17:48:25 -0300
Message-ID: <20241206204828.507527-3-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206204828.507527-1-acme@kernel.org>
References: <20241206204828.507527-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the java agent is running inside a container it will emit mmaps
with the format:

  ⬢ [acme@toolbox a]$ perf report -D | grep PERF_RECORD_MMAP | grep \.dump
  0 0x15c400 [0x90]: PERF_RECORD_MMAP2 3308868/3308868: [0x7fb8de6cb000(0x1000) @ 0 08:14 3222905945 0]: r-xp /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jit-1.dump
  ⬢ [acme@toolbox a]$

Since perf is running from outside the container it sees the pid 3308868
in PERF_RECORD_MMAP2, while the agent saw the pid of the profiled app
inside the container, 1.

The previous validation was:

  if (pid && pid2 != nsinfo__nstgid(nsi))

pid2 at this point is '1' (/jit-1.dump), so it considers this as a
malformed jitdump mmap and refuses to process it.

The test ends up as:

  if (3308868 && 1 != 3308868)

which is true and the jitdump is not processed.

Since 1 in the container namespace is really 3308868 in the namespace
that perf is running, consider this a valid mmap.

We need to make perf realize this and behave accordingly, for now
checking instead:

  if (pid && pid2 && pid != nsinfo__nstgid(nsi))

Translating to:

  if (3308868 && 1 && 3308868 != 3308868)

Will make the jitdump mmap to be considered valid and processed.

The jitdump is described in:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/jitdump-specification.txt

Now we end up with the expected flurry of MMAPs, one per jitted function
transformed into a little ELF file that should then be processable by
the other perf features, like code annotation:

  [acme@toolbox a]$ echo $JITDUMPDIR
  /tmp/.debug/jit
  [acme@toolbox a]$

First use 'perf inject':

  ⬢ [acme@toolbox a]$ time perf inject -i perf.data -o acme-perf-injected.data -j

Then look at the PERF_RECORD_MMAP events in the result file, that went
thru the JIT map file:

  ⬢ [acme@toolbox a]$ ls -la /tmp/*.map
  -rw-r--r--. 1 acme acme 2989559 Nov 27 16:11 /tmp/perf-3308868.map
  [acme@toolbox a]$

It is a symbol table:

  ⬢ [acme@toolbox a]$ head /tmp/*.map
  0x00007fb8bda5c1a0 0x00000000000000d0 java.lang.String java.lang.module.ModuleDescriptor.name()
  0x00007fb8bda5c4a0 0x0000000000000178 int java.lang.StringLatin1.hashCode(byte[])
  0x00007fb8bda5c9a0 0x00000000000000d0 java.lang.String org.springframework.boot.context.config.ConfigDataLocation.getValue()
  0x00007fb8bda5cca0 0x00000000000000d0 java.lang.module.ModuleDescriptor java.lang.module.ModuleReference.descriptor()
  0x00007fb8bda5cfa0 0x00000000000000d0 java.lang.Object java.util.KeyValueHolder.getKey()
  0x00007fb8bda5d2a0 0x00000000000000d0 java.lang.Object java.util.KeyValueHolder.getValue()
  0x00007fb8bda5d5a0 0x0000000000000218 boolean jdk.internal.misc.Unsafe.compareAndSetReference(java.lang.Object, long, java.lang.Object, java.lang.Object)
  0x00007fb8bda5d9a0 0x00000000000001f0 boolean jdk.internal.misc.Unsafe.compareAndSetLong(java.lang.Object, long, long, long)
  0x00007fb8bda5dda0 0x00000000000001f8 void java.lang.System.arraycopy(java.lang.Object, int, java.lang.Object, int, int)
  0x00007fb8bda5e1a0 0x00000000000001e8 int java.lang.Object.hashCode()
  ⬢ [acme@toolbox a]$

As specified in:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/jit-interface.txt

This was collected from inside the container, so came as
/tmp/perf-1.map.

To make perf, running outside the container to use it we need to copy it
to /tmp/perf-3308868.map.

This is another logic that has to be added to perf to work on this
scenario of running outside the container but processing things created
by the hava agent running inside the container.

With all this in place we get to:

  ⬢ [acme@toolbox a]$ perf report -D -i acme-perf-injected.data | \
  			grep PERF_RECORD_MMAP > /tmp/acme-perf-injected.data.mmaps ; \
  			wc -l /tmp/acme-perf-injected.data.mmaps
  44182 /tmp/acme-perf-injected.data.mmaps
  ⬢ [acme@toolbox a]$ tail /tmp/acme-perf-injected.data.mmaps
  1030266786574466 0x7bc9e0 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0ceb1c0(0x8d0) @ 0x80 00:2c 238715 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43989.so
  1030266795288774 0x7bca78 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0cecc00(0x7e8) @ 0x80 00:2c 238716 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43990.so
  1030266895967339 0x7bcb10 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0cee500(0x3328) @ 0x80 00:2c 238717 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43991.so
  1030266915748306 0x7bcba8 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0aae0a0(0x138) @ 0x80 00:2c 238718 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43992.so
  1030267185851220 0x7bcc40 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0cf61e0(0x3b50) @ 0x80 00:2c 238719 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43993.so
  1030267231364524 0x7bccd8 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0cfea80(0x14a0) @ 0x80 00:2c 238720 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43994.so
  1030267425498831 0x7bcd70 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c054b4a0(0x338) @ 0x80 00:2c 238721 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43995.so
  1030267506147888 0x7bce08 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0a995c0(0x1e8) @ 0x80 00:2c 238722 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43996.so
  1030268112586116 0x7bcea0 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0d02520(0x258) @ 0x80 00:2c 238723 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43997.so
  1030269435398150 0x7bcf38 [0x98]: PERF_RECORD_MMAP2 1/78: [0x7fb8c0d02dc0(0x278) @ 0x80 00:2c 238724 1]: --xs /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43998.so
  ⬢ [acme@toolbox a]$

And if we look at those tiny ELF files generated by the jitdump code
used by 'perf inject' we see:

  ⬢ [acme@toolbox a]$ file /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43989.so
  /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43989.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=790591db95a77d644657dfe5058658b200000000, with debug_info, not stripped
  ⬢ [acme@toolbox a]$ file /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43990.so
  /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43990.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=762f932acbee53a22638bf4c2b86780200000000, with debug_info, not stripped
  ⬢ [acme@toolbox a]$

  ⬢ [acme@toolbox a]$ ls -la /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43989.so /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43990.so
  -rw-r--r--. 1 acme acme 9432 Nov 29 10:56 /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43989.so
  -rw-r--r--. 1 acme acme 7504 Nov 29 10:56 /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43990.so
  ⬢ [acme@toolbox a]$

And:

  ⬢ [acme@toolbox a]$ objdump -dS /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43990.so | head -20

  /tmp/.debug/jit/java-jit-20241126.XXTxEIOn/jitted-1-43990.so:     file format elf64-x86-64

  Disassembly of section .text:

  0000000000000080 <Lredacted/REDACTED/REDACTED/logging/RedactedRedacted;Redacted(Lredacted/REDACTED/REDACTED/redactedRedacted/Redacted;)V>:
    80:	44 8b 56 08          	mov    0x8(%rsi),%r10d
    84:	49 c1 e2 03          	shl    $0x3,%r10
    88:	49 3b c2             	cmp    %r10,%rax
    8b:	0f 85 6f 15 83 fc    	jne    fffffffffc831600 <Lredacted/REDACTED/REDACTED/redacted/RedactedRedactedRedacted;Redacted(Lredacted/Redacted/Redacted/redactedRedacted/Redacted;)V+0xfffffffffc831580>
    91:	66 66 90             	data16 xchg %ax,%ax
    94:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9b:	00
    9c:	66 66 66 90          	data16 data16 xchg %ax,%ax
    a0:	89 84 24 00 c0 fe ff 	mov    %eax,-0x14000(%rsp)
    a7:	55                   	push   %rbp
    a8:	48 8b ec             	mov    %rsp,%rbp
    ab:	48 83 ec 40          	sub    $0x40,%rsp
    af:	48 89 34 24          	mov    %rsi,(%rsp)
  ⬢ [acme@toolbox a]$

The thing now being investigated is why we can't annotate anything here,
maybe that JITDUMPDIR is getting in the way:

  ⬢ [acme@toolbox a]$ perf annotate --stdio2 -i acme-perf-injected.data 'java.lang.String com.fasterxml.jackson.core.sym.CharsToNameCanonicalizer.findSymbol(char[], int, int, int)'
  Error:
  Couldn't annotate java.lang.String com.fasterxml.jackson.core.sym.CharsToNameCanonicalizer.findSymbol(char[], int, int, int):
  Internal error: Invalid -1 error code
  ⬢ [acme@toolbox a]$

In the tests I performed while merging this patch:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d518ac7be6223811ab947897273b1bbef846180

It works, but then there was no JITDUMPDIR involved:

  /home/acme/.debug/jit/java-jit-20241127.XXF1SRgN/jitted-3912413-4191.so

⬢ [acme@toolbox perf-tools-next]$ perf report --call-graph none --no-child -i perf-injected.data | grep jitted- | head
     1.36%  java             jitted-3912413-54.so    [.] Interpreter
     0.30%  C1 CompilerThre  jitted-3912413-1.so     [.] flush_icache_stub
     0.18%  java             jitted-3912413-4184.so  [.] org.apache.fop.fo.properties.PropertyMaker.get(int, org.apache.fop.fo.PropertyList, boolean, boolean)
     0.18%  java             jitted-3912413-4177.so  [.] org.apache.fop.layoutmgr.inline.TextLayoutManager.getNextKnuthElements(org.apache.fop.layoutmgr.LayoutContext, int)
     0.13%  java             jitted-3912413-3845.so  [.] java.text.DecimalFormat.subformatNumber(java.lang.StringBuffer, java.text.Format$FieldDelegate, boolean, boolean, int, int, int, int)
     0.11%  java             jitted-3912413-4191.so  [.] org.apache.fop.fo.FObj.addChildNode(org.apache.fop.fo.FONode)
     0.09%  java             jitted-3912413-2418.so  [.] org.apache.fop.fo.XMLWhiteSpaceHandler.handleWhiteSpace()
     0.08%  Reference Handl  jitted-3912413-54.so    [.] Interpreter
     0.08%  java             jitted-3912413-3326.so  [.] org.apache.xmlgraphics.fonts.Glyphs.stringToGlyph(java.lang.String)
     0.08%  java             jitted-3912413-3953.so  [.] org.apache.fop.layoutmgr.BreakingAlgorithm.considerLegalBreak(org.apache.fop.layoutmgr.KnuthElement, int)
⬢ [acme@toolbox perf-tools-next]$

And then:

  ⬢ [acme@toolbox perf-tools-next]$ perf annotate --stdio2 -i perf-injected.data 'org.apache.fop.layoutmgr.inline.TextLayoutManager.getNextKnuthElements(org.apache.fop.layoutmgr.LayoutContext, int)' | head -20
  Samples: 8  of event 'cpu_atom/cycles/Pu', 4000 Hz, Event count (approx.): 8112794, [percent: local period]
  org.apache.fop.layoutmgr.inline.TextLayoutManager.getNextKnuthElements(org.apache.fop.layoutmgr.LayoutContext, int)() /home/acme/.debug/jit/java-jit-20241127.XXF1SRgN/jitted-3912413-4177.so
  Percent        0x80 <org.apache.fop.layoutmgr.inline.TextLayoutManager.getNextKnuthElements(org.apache.fop.layoutmgr.LayoutContext, int)>:
                   nop
                   movl       0x8(%rsi),%r10d
                   cmpl       0x8(%rax),%r10d
                 → jne        0
                   movl       %eax,-0x14000(%rsp)
                   pushq      %rbp
                   subq       $0xb0,%rsp
                   nop
                   cmpl       $0x3,0x20(%r15)
                 ↓ jne        7037
             2e:   movl       %ecx,0x28(%rsp)
                   movq       %rdx,%rbp
                   movl       0x64(%rdx),%ebx
                   cmpb       $0x0,0x38(%r15)
                 ↓ jne        3a44
                   movq       %rsi,0x30(%rsp)
             48:   movq       0x30(%rsp),%r10
  ⬢ [acme@toolbox perf-tools-next]$

No source code nor line numbers, that I saw in another build of perf for
RHEL9, for the same workload described in the cset above (a publicly
available java benchmark), so something to investigate on perf upstream
running on fedora, maybe some quirk with the jdk used when building perf
for RHEL 9 and for Fedora 40.

A related patch that should have make this all work is:

  "perf inject jit: Add namespaces support"
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=67dec926931448d688efb5fe34f7b5a22470fc0a

But we still need to polish this some more, maybe there are differences
in the agent used in NodeJS with --perf-prof and the jvmti one we're
using.

Hopefully describing all the steps while we investigate this case will
help us improve perf support for profiling JITed environments running in
containers while profiling from inside and outside it.

Reported-by: Francesco Nigro <fnigro@redhat.com>
Reported-by: Ilan Green <igreen@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 346513e5e9b7a956..d53c6ac4095b663c 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -777,7 +777,7 @@ jit_detect(const char *mmap_name, pid_t pid, struct nsinfo *nsi)
 	 * pid does not match mmap pid
 	 * pid==0 in system-wide mode (synthesized)
 	 */
-	if (pid && pid2 != nsinfo__nstgid(nsi))
+	if (pid && pid2 && pid != nsinfo__nstgid(nsi))
 		return -1;
 	/*
 	 * validate suffix
-- 
2.47.0


