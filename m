Return-Path: <linux-kernel+bounces-269690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 296209435D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EABB21ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953344962E;
	Wed, 31 Jul 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKJQGjGe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E84778E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451873; cv=none; b=V65W2kH0Zci3bIKG0NWXOREWrd8a4dgLdLHdBVS7EhyLygvFbdXQMivvXhrnLYfZFpnamfs+nHN0luvxwGLjo/sRb9x+omeaYsXmLwuFXNQbS1yDgCeST3c8woyQs07AVRyEh0Ksr+4Tk9gD7mCL8CP0qhYRz1FirPz8QQUjxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451873; c=relaxed/simple;
	bh=b3hljwi1hleI4R5yYJ0QfHYB1fl44dT9f3B67aXaXN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joD/m68ki8+hFbAjGfhqj9IcEmZdmR9asurrtXS9UAC/uFkyCwEbwCLrnfedusui6byPZHbM22N1skdlJJwWoydlHA2uCBuidkQS1kmdykv/uVvVOdUAzab/rbvguCirUNp77DekG4BT9Wnkh6ou638Gmq8VNxZQfBQl/3SNTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKJQGjGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31C9C116B1;
	Wed, 31 Jul 2024 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722451873;
	bh=b3hljwi1hleI4R5yYJ0QfHYB1fl44dT9f3B67aXaXN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKJQGjGe/FGBv2aFFYSKJVw+4X29v7l6KkAVCgOWmvnVlL1vPhMz+2Uxs/5fyEaKO
	 GVoavXsL08o7J3iYJ9XbcR5Gx/F5RmHo3O9gFPoj6hIsz0N9MRor6MkzB87hHJ41EG
	 sG3JYEAeGxeU4SveDfUq85dLkKW6+araaDsc+pL8sUxKDIMujDCZTKufLV+c8DLfm5
	 MVwqYaLJFICHr/gPXb2a1l/bryRTMMvtMKITyFKwJKOtqKVqn/wFszOzTjA4gS0yGs
	 LrGvHUu0rUOkhRitrPZWSg+U/atDlnEz8/Kb5LzumimGGxwESkGR4Rz+Z2AUY+i6FJ
	 NmK4/nghKPvRg==
Date: Wed, 31 Jul 2024 15:51:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <song@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
Message-ID: <ZqqHnlgG0YS4DRAt@x1>
References: <ZqpUSKPxMwaQKORr@x1>
 <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>

On Wed, Jul 31, 2024 at 10:07:50AM -0700, Namhyung Kim wrote:
> On Wed, Jul 31, 2024 at 8:12 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > There is a clash of the libbpf and capstone libraries, that ends up
> > with:
> >
> >   In file included from /usr/include/capstone/capstone.h:325,
> >                    from util/disasm.c:1513:
> >   /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
> >      94 | typedef enum bpf_insn {
> >
> > So far we're just trying to avoid this by not having both headers
> > included in the same .c or .h file, do it one more time by moving the
> > BPF diassembly routines from util/disasm.c to util/disasm_bpf.c.
> >
> > This is only being hit when building with BUILD_NONDISTRO=1, i.e.
> > building with binutils-devel, that isn't the in the default build due to
> > a licencing clash. We need to reimplement what is now isolated in
> > util/disasm_bpf.c using some other library to have BPF annotation
> > feature that now only is available with BUILD_NONDISTRO=1.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/Build        |   1 +
> >  tools/perf/util/disasm.c     | 187 +--------------------------------
> >  tools/perf/util/disasm_bpf.c | 193 +++++++++++++++++++++++++++++++++++
> >  tools/perf/util/disasm_bpf.h |  12 +++
> >  4 files changed, 207 insertions(+), 186 deletions(-)
> >  create mode 100644 tools/perf/util/disasm_bpf.c
> >  create mode 100644 tools/perf/util/disasm_bpf.h
> >
> > +++ b/tools/perf/util/Build
> > @@ -13,6 +13,7 @@ perf-util-y += copyfile.o
> >  perf-util-y += ctype.o
> >  perf-util-y += db-export.o
> >  perf-util-y += disasm.o
> > +perf-util-y += disasm_bpf.o
> 
> I think this can be gated by LIBBFD and LIBBPF config, but not sure
> it can express the both requirements easily.

It is possible, but as discussed with Ian in another message, the
cheapest way to do it was, I think, like I did, in the end it is just a
stub returning an error when those libraries are not linked with perf.

When we manage to implement the disassembly of BPF using something other
than libbfd we can spend more time in this area, I think.

- Arnaldo

