Return-Path: <linux-kernel+bounces-271680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF69945194
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB09E1F236DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC951B9B28;
	Thu,  1 Aug 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io79+YZv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DD182D8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533916; cv=none; b=B3cayiBIizmbRwqKphbI0nEc5E6Y/8vLvDoyaSvulQ6FaLERIKgd6/NUc/vIY/c7xhFWbFxkDI++ukIKGa0tpeJ3NBjVyXbmvh9MFSyKLjbZvUyL7KrlKUgp/xjoeezVbaiO7Op+7e6ZMoJg4qKjWgbF8bZ4x/SUYHYVhhm3vH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533916; c=relaxed/simple;
	bh=RAvj/gF93jOqzP4GL/lSwxlRywzRFQiXo/RpNNJdT3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/3OjhEviQTI1g1TJqjkLxLzkGo3IXsgsGdm+5q2+nIUkXtVV/+ccjghnZXwnEgRH51neR025mtijZPmnMBuYDvS1irxeBVmDEPJGt6bhPSpPAZESFFnJ65PdJEuaU48NtoRT+uP5OIqNkQyQY8WIA7b0beke6P4LW97wWGpjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io79+YZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA171C32786;
	Thu,  1 Aug 2024 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722533916;
	bh=RAvj/gF93jOqzP4GL/lSwxlRywzRFQiXo/RpNNJdT3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=io79+YZv2SL7kMus3yFshjkRLpYratoUxh8wgJnTSQqRIrgv0ObxMkabbrrByaZac
	 fCStYZvWJRIwp3b/erIXpaYMjGyqawY4RSmx9Tpom4oNiP64eEDKULp7CNcxl2DVin
	 gZoR074rTdAU0ShM5o2VWPGS5AboortYNo0w30iaY/iZfpSP3fLbaFYx97XhFUawqA
	 vvA+DY1nMjDLL1KznuikDRpj/WzxTkbhmIBQiCVZ1LipHSW2BAZ4LmWuBK06GHOLes
	 XghC92uos44mIBsdC7a8k1Bv49c1WLKgLOPR7DcfaO64tnVbbE8zfSVq1VsGmDnda3
	 JEjDIAxmEgyAw==
Date: Thu, 1 Aug 2024 14:38:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
Message-ID: <ZqvIGLQNAtYqjo7u@x1>
References: <ZqpUSKPxMwaQKORr@x1>
 <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
 <ZqqHnlgG0YS4DRAt@x1>
 <CAP-5=fVH-YG65AmFz-N0uSXg2OcGJrmkw5tQtuEuFY=h_4K8_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVH-YG65AmFz-N0uSXg2OcGJrmkw5tQtuEuFY=h_4K8_g@mail.gmail.com>

On Thu, Aug 01, 2024 at 08:18:23AM -0700, Ian Rogers wrote:
> On Wed, Jul 31, 2024 at 11:51 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Jul 31, 2024 at 10:07:50AM -0700, Namhyung Kim wrote:
> > > On Wed, Jul 31, 2024 at 8:12 AM Arnaldo Carvalho de Melo
> [snip]
> > > I think this can be gated by LIBBFD and LIBBPF config, but not sure
> > > it can express the both requirements easily.
> >
> > It is possible, but as discussed with Ian in another message, the
> > cheapest way to do it was, I think, like I did, in the end it is just a
> > stub returning an error when those libraries are not linked with perf.
> >
> > When we manage to implement the disassembly of BPF using something other
> > than libbfd we can spend more time in this area, I think.
> 
> Not following this, can you show an example perf command. There is a
> BPF disassembler already in the kernel tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/kernel/bpf/disasm.c?h=perf-tools-next
> and in use in bpftool that we use in the perf build.

Well, looking at the files in this patch shows it, here, more precisely:


tools/perf/util/disasm_bpf.c

#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct annotate_args *args __maybe_unused)
{
        return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
}
#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)

- Arnaldo

