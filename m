Return-Path: <linux-kernel+bounces-326534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F29769A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15001285EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C871AB6F9;
	Thu, 12 Sep 2024 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljdP0zeL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3671A4E7C;
	Thu, 12 Sep 2024 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145515; cv=none; b=Js0pJR9oXRlBlOtpMM9iuqk3631HXhFXcHnSWVMDMFJBJkyZJgvPA8+QXUQ6ydbmKpzhBKuh/kPLDs4boTA41u/gEzASTKpFYFt6Kk4ul+qeugQMgrd+y3ow/FnUbQ3+tJs8vFEBSGnY6b0CNb0JcavEMTZdzS33aP8NVJvY/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145515; c=relaxed/simple;
	bh=WqfmUqHw4n8EIkNZuk+D5nIi87AgVfDU5p0ao9ohaVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0O5OwHRtDGk1z/JrmkkYmkRb1C+R5rYHmESc9tJv+swxWVGTFvP3HRafk8jOz3hbZyh707REkMwTHt2KPiw74KvV8F/Kz+EHh9Pki8BDUimbqbHOgO+ivtAC9WMUb/R3rUo/7XfOWL+P/2XP5ZTNR5sWnrUHdIe0C3eko45d/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljdP0zeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F95C4CEC3;
	Thu, 12 Sep 2024 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726145514;
	bh=WqfmUqHw4n8EIkNZuk+D5nIi87AgVfDU5p0ao9ohaVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljdP0zeLagUdAAp1E2PZoIKqXm19oXgLyeU/+uBK3WMN9/lqVVWhB1VhICXcdoOE2
	 ShrdjCSrLn8V7FY5qmslanuUeWB9Nmq9oeL/A5+IlbS4TV5DYAJCX9+Xxrc/rlskdU
	 QokV7kPKPZNnPamh29jm316y4A8qtsSduZO4/HDF9Z1ckYtytgd1otrcH3e8F9X8ZP
	 WAu8vPw0nDLlkaDmmk1vzvyuWloh++6VxKHbMQ56wDedqnam00Q/Hzo5yKkOLmRB5h
	 pgd8O7S4nsHrozbmRw/bOobz/R5Yp5v5nrKy+16Q+H/0gNfMNoLOdG1U7XYhZ23kXt
	 U1A/RCOL3s3ZQ==
Date: Thu, 12 Sep 2024 09:51:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>,
	"Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 02/10] perf: Support discriminator in addr2line
Message-ID: <ZuLj5o6FwBJsk_1x@x1>
References: <20240905015300.2124798-1-ak@linux.intel.com>
 <20240905015300.2124798-3-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240905015300.2124798-3-ak@linux.intel.com>

On Wed, Sep 04, 2024 at 06:50:10PM -0700, Andi Kleen wrote:
> Dwarf has the concept of a discriminator to distinguish multiple
> compiler generated statements in a line. Add support
> for retrieving the discriminator in addr2line. Will be used
> in later patches to pass to python scripts.

So I left the whole message quoted because originally it went to the
wrong/non-existent mailing list (perf-tools-users@vger.kernel.org), so I
couldn't refer it to Steinar.

More comments below.
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c                   |  6 ++-
>  .../scripts/python/Perf-Trace-Util/Context.c  |  4 +-
>  tools/perf/util/dlfilter.c                    |  4 +-
>  tools/perf/util/srcline.c                     | 42 ++++++++++++-------
>  tools/perf/util/srcline.h                     |  2 +-
>  5 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 206b08426555..dc7e5406dae9 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1131,7 +1131,7 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
>  {
>  	char *srcfile;
>  	int ret = 0;
> -	unsigned line;
> +	unsigned line, disc;
>  	int len;
>  	char *srccode;
>  	struct dso *dso;
> @@ -1140,7 +1140,7 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
>  		return 0;
>  	srcfile = get_srcline_split(dso,
>  				    map__rip_2objdump(map, addr),
> -				    &line);
> +				    &line, &disc);
>  	if (!srcfile)
>  		return 0;
>  
> @@ -1157,6 +1157,8 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
>  	if (!srccode)
>  		goto out_free_line;
>  
> +	/* Print discriminator too? Maybe with a new option */
> +
>  	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
>  
>  	if (state) {
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> index 3954bd1587ce..3aa5e6385c1e 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> @@ -140,7 +140,7 @@ static PyObject *perf_set_itrace_options(PyObject *obj, PyObject *args)
>  static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode)
>  {
>  	struct scripting_context *c = get_scripting_context(args);
> -	unsigned int line = 0;
> +	unsigned int line = 0, disc = 0;
>  	char *srcfile = NULL;
>  	char *srccode = NULL;
>  	PyObject *result;
> @@ -157,7 +157,7 @@ static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode
>  	dso = map ? map__dso(map) : NULL;
>  
>  	if (dso)
> -		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
> +		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc);
>  
>  	if (get_srccode) {
>  		if (srcfile)
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index 7d180bdaedbc..1a3b5ba92313 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -250,7 +250,7 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
>  {
>  	struct dlfilter *d = (struct dlfilter *)ctx;
>  	struct addr_location *al;
> -	unsigned int line = 0;
> +	unsigned int line = 0, disc = 0;
>  	char *srcfile = NULL;
>  	struct map *map;
>  	struct dso *dso;
> @@ -268,7 +268,7 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
>  	dso = map ? map__dso(map) : NULL;
>  
>  	if (dso)
> -		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
> +		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc);
>  
>  	*line_no = line;
>  	return srcfile;
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 760742fd4a7d..07df410b52e4 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -146,6 +146,7 @@ struct a2l_data {
>  	const char 	*filename;
>  	const char 	*funcname;
>  	unsigned 	line;
> +	unsigned	discriminator;
>  
>  	bfd 		*abfd;
>  	asymbol 	**syms;
> @@ -232,9 +233,10 @@ static void find_address_in_section(bfd *abfd, asection *section, void *data)
>  	if (pc < vma || pc >= vma + size)
>  		return;
>  
> -	a2l->found = bfd_find_nearest_line(abfd, section, a2l->syms, pc - vma,
> -					   &a2l->filename, &a2l->funcname,
> -					   &a2l->line);
> +	a2l->found = bfd_find_nearest_line_discriminator(abfd,
> +							 section, a2l->syms, pc - vma,
> +							 &a2l->filename, &a2l->funcname,
> +							 &a2l->line, &a2l->discriminator);

I noticed that this is under:

#elif defined(HAVE_LIBBFD_SUPPORT)

That isn't built by default due to licensing issues, i.e. we only build
it if BUILD_NONDISTRO=1 is selected on the make command line, see:

tools/perf/Makefile.config +943

And we have the patch below now, can we try to use it instead so that at
some point we can remove the libbpf support?

Steinar?

Thanks,

- Arnaldo

⬢[acme@toolbox perf-tools-next]$ git show c3f8644c21df9b7db97eb70e08e2826368aaafa0
commit c3f8644c21df9b7db97eb70e08e2826368aaafa0
Author: Steinar H. Gunderson <sesse@google.com>
Date:   Sat Aug 3 17:20:06 2024 +0200

    perf report: Support LLVM for addr2line()
    
    In addition to the existing support for libbfd and calling out to
    an external addr2line command, add support for using libllvm directly.
    
    This is both faster than libbfd, and can be enabled in distro builds
    (the LLVM license has an explicit provision for GPLv2 compatibility).
    
    Thus, it is set as the primary choice if available.
    
    As an example, running 'perf report' on a medium-size profile with
    DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
    libbfd, 153 seconds with external llvm-addr2line, and I got tired and
    aborted the test after waiting for 55 minutes with external bfd
    addr2line (which is the default for perf as compiled by distributions
    today).
    
    Evidently, for this case, the bfd addr2line process needs 18 seconds (on
    a 5.2 GHz Zen 3) to load the .debug ELF in question, hits the 1-second
    timeout and gets killed during initialization, getting restarted anew
    every time. Having an in-process addr2line makes this much more robust.


  
>  	if (a2l->filename && !strlen(a2l->filename))
>  		a2l->filename = NULL;
> @@ -301,7 +303,7 @@ static int inline_list__append_dso_a2l(struct dso *dso,
>  static int addr2line(const char *dso_name, u64 addr,
>  		     char **file, unsigned int *line, struct dso *dso,
>  		     bool unwind_inlines, struct inline_node *node,
> -		     struct symbol *sym)
> +		     struct symbol *sym, unsigned *disc)
>  {
>  	int ret = 0;
>  	struct a2l_data *a2l = dso__a2l(dso);
> @@ -354,6 +356,8 @@ static int addr2line(const char *dso_name, u64 addr,
>  
>  	if (line)
>  		*line = a2l->line;
> +	if (disc)
> +		*disc = a2l->discriminator;
>  
>  	return ret;
>  }
> @@ -506,7 +510,8 @@ static int read_addr2line_record(struct io *io,
>  				 bool first,
>  				 char **function,
>  				 char **filename,
> -				 unsigned int *line_nr)
> +				 unsigned int *line_nr,
> +				 unsigned *disc)
>  {
>  	/*
>  	 * Returns:
> @@ -518,6 +523,9 @@ static int read_addr2line_record(struct io *io,
>  	size_t line_len = 0;
>  	unsigned int dummy_line_nr = 0;
>  	int ret = -1;
> +	char *p;
> +
> +	*disc = 0;
>  
>  	if (function != NULL)
>  		zfree(function);
> @@ -602,6 +610,10 @@ static int read_addr2line_record(struct io *io,
>  		goto error;
>  	}
>  
> +	p = strstr(line, "discriminator");
> +	if (p && disc)
> +		*disc = strtoul(p + sizeof("discriminator"), NULL, 0);
> +
>  	if (filename != NULL)
>  		*filename = strdup(line);
>  
> @@ -636,7 +648,8 @@ static int addr2line(const char *dso_name, u64 addr,
>  		     struct dso *dso,
>  		     bool unwind_inlines,
>  		     struct inline_node *node,
> -		     struct symbol *sym __maybe_unused)
> +		     struct symbol *sym __maybe_unused,
> +		     unsigned *disc)
>  {
>  	struct child_process *a2l = dso__a2l(dso);
>  	char *record_function = NULL;
> @@ -688,7 +701,8 @@ static int addr2line(const char *dso_name, u64 addr,
>  	io__init(&io, a2l->out, buf, sizeof(buf));
>  	io.timeout_ms = addr2line_timeout_ms;
>  	switch (read_addr2line_record(&io, a2l_style, dso_name, addr, /*first=*/true,
> -				      &record_function, &record_filename, &record_line_nr)) {
> +				      &record_function, &record_filename, &record_line_nr,
> +				      &disc)) {
>  	case -1:
>  		if (!symbol_conf.disable_add2line_warn)
>  			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
> @@ -704,7 +718,7 @@ static int addr2line(const char *dso_name, u64 addr,
>  		 */
>  		switch (read_addr2line_record(&io, a2l_style, dso_name,
>  					      /*addr=*/1, /*first=*/true,
> -					      NULL, NULL, NULL)) {
> +					      NULL, NULL, NULL, NULL)) {
>  		case -1:
>  			if (!symbol_conf.disable_add2line_warn)
>  				pr_warning("%s %s: could not read sentinel record\n",
> @@ -754,7 +768,7 @@ static int addr2line(const char *dso_name, u64 addr,
>  						      /*first=*/false,
>  						      &record_function,
>  						      &record_filename,
> -						      &record_line_nr)) == 1) {
> +						      &record_line_nr, NULL)) == 1) {
>  		if (unwind_inlines && node && inline_count++ < MAX_INLINE_NEST) {
>  			if (inline_list__append_record(dso, node, sym,
>  						       record_function,
> @@ -805,7 +819,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>  	INIT_LIST_HEAD(&node->val);
>  	node->addr = addr;
>  
> -	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
> +	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym, NULL);
>  	return node;
>  }
>  
> @@ -832,7 +846,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
>  		goto out_err;
>  
>  	if (!addr2line(dso_name, addr, &file, &line, dso,
> -		       unwind_inlines, NULL, sym))
> +		       unwind_inlines, NULL, sym, NULL))
>  		goto out_err;
>  
>  	srcline = srcline_from_fileline(file, line);
> @@ -865,8 +879,8 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
>  	return srcline;
>  }
>  
> -/* Returns filename and fills in line number in line */
> -char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
> +/* Returns filename and fills in line number in line and discriminator in disc */
> +char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc)
>  {
>  	char *file = NULL;
>  	const char *dso_name;
> @@ -878,7 +892,7 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
>  	if (dso_name == NULL)
>  		goto out_err;
>  
> -	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL))
> +	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL, disc))
>  		goto out_err;
>  
>  	dso__set_a2l_fails(dso, 0);
> diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
> index 75010d39ea28..d2cb90b1177e 100644
> --- a/tools/perf/util/srcline.h
> +++ b/tools/perf/util/srcline.h
> @@ -17,7 +17,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
>  		  bool show_sym, bool show_addr, bool unwind_inlines,
>  		  u64 ip);
>  void zfree_srcline(char **srcline);
> -char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line);
> +char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc);
>  
>  /* insert the srcline into the DSO, which will take ownership */
>  void srcline__tree_insert(struct rb_root_cached *tree, u64 addr, char *srcline);
> -- 
> 2.45.2

