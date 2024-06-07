Return-Path: <linux-kernel+bounces-205257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EEF8FFA0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1893B285936
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78A14F90;
	Fri,  7 Jun 2024 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8EN6HI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FE12E47
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717728087; cv=none; b=sccI9OnMH+auQqiD/fM1MGQZLoTiYIVafeFjOoXwA/+CW2DD8fzn+akjkUhGnyejTit4hVOs5ND9hIM9wAx74Cl9tgDFk0qsw+FWyZLcLhRByzp948sXas7iHp3CM5eDh5evrb7DgbClRcp6fEozW5TWsPFVo76tihV13bfBT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717728087; c=relaxed/simple;
	bh=us34JFVYbA5mG82uLJk2U+J0l+KMvoo6AlvtT/zfTlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ89ya9+R6xdbMbzqmY3a1Q/+zJqYfGn+BVd0qNVZrT47Lt8MGs6b0TF94scQ61V1RNQHwilV0vW2DTiaoSQZeWYghikPklGYHfRCmlzXLvFH5TcI1otg4xP+NaKkVC53FIDj48k+NXQjkxuk22E0AqjUeDPHYhJjoKyCjSxCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8EN6HI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CBCC2BD10;
	Fri,  7 Jun 2024 02:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717728086;
	bh=us34JFVYbA5mG82uLJk2U+J0l+KMvoo6AlvtT/zfTlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8EN6HI4OjDEsL0zKsAdzsKpDF6u4LAwIEODtZXF4E3a1aVf4TMz7MatOoeXlp1XR
	 tSCDMHzs5O/v+kzryZ59yaUWHsPpuZMzgUtTnd7BdUbAPj3EXRkZCTlzIPvaKu390x
	 pieHlGvZbibapwUgTIv4COwp7uzn9N+5uEfa6+1wFZPCfGyf95D4fPtrrXrT4sB2yo
	 2YpjOQkSd6sIpVe0WQT6zH8Nmfg1BoJAinJWqn/Bfa9jMJ0pDvXSV4zjtKq02DQXUK
	 3gmZr9SuTFIqx/17Y3gcMZDmbXQCzrhmbBnQehnLgEal73Fn3tkYoMoWG0etRWqCrX
	 W6gLP8Gj8249Q==
Date: Thu, 6 Jun 2024 19:41:25 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool query: section start/end symbols?
Message-ID: <20240607024125.jsumfrbgoz5vz3si@treble>
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
 <20240606194525.cdnnidxurejsjtx4@treble>
 <CAHk-=wjdrJ1H7sbsaL8_bLvRmt26_io=5_b3k_g33kd+bwFHzA@mail.gmail.com>
 <20240606221856.g3iboxfkkgzp6sd3@treble>
 <CAHk-=wjEcPQQ108RFw8Tk6oxfqcystVS94tRyVZCSczSBFMTDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEcPQQ108RFw8Tk6oxfqcystVS94tRyVZCSczSBFMTDA@mail.gmail.com>

On Thu, Jun 06, 2024 at 03:54:34PM -0700, Linus Torvalds wrote:
> On Thu, 6 Jun 2024 at 15:19, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > So while I'm not yet necessarily conceding that objtool is really needed
> > here, I could work up a quick objtool patch.  It would just be x86-only,
> > is that ok for the time being?
> 
> Absolutely.

This adds a new objtool "--bounds" action which creates a

  __sec_<secname>_{start,end}

symbol for every section.

The only testing I've done has been staring cross-eyed at the readelf
output on a defconfig kernel.

If you have CONFIG_X86_KERNEL_IBT -- which causes objtool to run on
vmlinux.o -- you can enable bounds symbol creation by adding
OBJTOOL_ARGS="--bounds" to your make cmdline:

  make -j$(nproc) -s OBJTOOL_ARGS="--bounds"

Otherwise it would need to be manually added with

  objtool --bounds --link vmlinux.o

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 5e21cfb7661d..e1a86981fd96 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -68,6 +68,7 @@ static int parse_hacks(const struct option *opt, const char *str, int unset)
 static const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_BOOLEAN('b', "bounds", &opts.bounds, "generate section start/end bounds symbols"),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -131,7 +132,8 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
 static bool opts_valid(void)
 {
-	if (opts.hack_jump_label	||
+	if (opts.bounds			||
+	    opts.hack_jump_label	||
 	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
@@ -199,6 +201,11 @@ static bool link_opts_valid(struct objtool_file *file)
 		return false;
 	}
 
+	if (opts.bounds) {
+		ERROR("--bounds requires --link");
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0a33d9195b7a..59e6638db83f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4213,6 +4213,124 @@ static int add_prefix_symbols(struct objtool_file *file)
 	return 0;
 }
 
+static bool is_discarded_sec(struct section *sec)
+{
+	static const char * const discards[] = {
+		".note.gnu.property",
+		".export_symbol",
+		".modinfo",
+		"__patchable_function_entries",
+		".exitcall.exit", // not discarded for modules
+	};
+
+	if (!(sec->sh.sh_flags & SHF_ALLOC) || strstarts(sec->name, ".discard"))
+		return true;
+
+	for (int i = 0; i < ARRAY_SIZE(discards); i++)
+		if (!strcmp(sec->name, discards[i]))
+			return true;
+
+	return false;
+}
+
+#define BOUNDS_SEC_NAME ".rodata.sec_bounds"
+
+static int create_bounds_section(struct objtool_file *file)
+{
+	struct section *bounds_sec, *sec;
+	unsigned int idx;
+
+	sec = find_section_by_name(file->elf, BOUNDS_SEC_NAME);
+	if (sec) {
+		INIT_LIST_HEAD(&file->static_call_list);
+		WARN("file already has .sec_bounds section, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	for_each_sec(file, sec)
+		if (sec->idx && !is_reloc_sec(sec) && !is_discarded_sec(sec))
+			idx++;
+
+	bounds_sec = elf_create_section_pair(file->elf, BOUNDS_SEC_NAME,
+					     sizeof(long) * 2, idx, idx * 2);
+	if (!sec)
+		return -1;
+
+	idx = 0;
+	for_each_sec(file, sec) {
+		if (sec->idx && !is_reloc_sec(sec) && !is_discarded_sec(sec)) {
+
+			char sanitized_name[116];
+			char start_name[128];
+			char end_name[128];
+
+			if (!strcmp(sec->name, BOUNDS_SEC_NAME))
+				continue;
+
+			if (!sec->sym && !elf_create_section_symbol(file->elf, sec))
+				return -1;
+
+			strncpy(sanitized_name, sec->name, sizeof(sanitized_name) - 1);
+			for (char *s = sanitized_name; *s; s++)
+				if (*s == '.')
+					*s = '_';
+
+			snprintf(start_name, 256, "__sec%s_start", sanitized_name);
+			snprintf(end_name,   256, "__sec%s_end",   sanitized_name);
+
+			if (find_symbol_by_name(file->elf, start_name) ||
+			    find_symbol_by_name(file->elf, end_name))
+				continue;
+
+			/* 'start' symbol */
+			if (!elf_create_symbol(file->elf,
+					       start_name,
+					       bounds_sec,
+					       STB_GLOBAL,
+					       STT_OBJECT,
+					       idx * 2 * sizeof(long),
+					       sizeof(long)))
+			    return -1;
+
+			if (!elf_create_symbol(file->elf,
+					       end_name,
+					       bounds_sec,
+					       STB_GLOBAL,
+					       STT_OBJECT,
+					       (idx * 2 * sizeof(long)) + sizeof(long),
+					       sizeof(long)))
+			    return -1;
+
+			/* 'start' reloc */
+			if (!elf_init_reloc(file->elf,
+					    bounds_sec->rsec,
+					    idx * 2,
+					    idx * 2 * sizeof(long),
+					    sec->sym,
+					    0,
+					    R_ABS64))
+				return -1;
+
+			/* 'end' reloc */
+			if (!elf_init_reloc(file->elf,
+					    bounds_sec->rsec,
+					    (idx * 2) + 1,
+					    (idx * 2 * sizeof(long)) + sizeof(long),
+					    sec->sym,
+					    sec->sh.sh_size,
+					    R_ABS64))
+				return -1;
+
+
+			idx++;
+		}
+	}
+
+
+	return 0;
+}
+
 static int validate_symbol(struct objtool_file *file, struct section *sec,
 			   struct symbol *sym, struct insn_state *state)
 {
@@ -4826,6 +4944,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.bounds) {
+		ret = create_bounds_section(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (opts.ibt) {
 		ret = create_ibt_endbr_seal_sections(file);
 		if (ret < 0)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d27983dc908..b596e992ca80 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -788,8 +788,7 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 	return sym;
 }
 
-static struct symbol *
-elf_create_section_symbol(struct elf *elf, struct section *sec)
+struct symbol *elf_create_section_symbol(struct elf *elf, struct section *sec)
 {
 	struct symbol *sym = calloc(1, sizeof(*sym));
 
@@ -811,6 +810,8 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
 	if (sym)
 		elf_add_symbol(elf, sym);
 
+	sec->sym = sym;
+
 	return sym;
 }
 
@@ -845,10 +846,37 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
 	return sym;
 }
 
-static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
-				    unsigned int reloc_idx,
-				    unsigned long offset, struct symbol *sym,
-				    s64 addend, unsigned int type)
+struct symbol *elf_create_symbol(struct elf *elf, char *name,
+				 struct section *sec, unsigned int bind,
+				 unsigned int type, unsigned long offset,
+				 size_t size)
+{
+	struct symbol *sym = calloc(1, sizeof(*sym));
+
+	if (!sym) {
+		perror("calloc");
+		return NULL;
+	}
+
+	sym->name = strdup(name);
+	sym->sec = sec;
+
+	sym->sym.st_name = elf_add_string(elf, NULL, sym->name);
+	sym->sym.st_info = GELF_ST_INFO(bind, type);
+	sym->sym.st_value = offset;
+	sym->sym.st_size = size;
+
+	sym = __elf_create_symbol(elf, sym);
+	if (sym)
+		elf_add_symbol(elf, sym);
+
+	return sym;
+}
+
+struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
+			     unsigned int reloc_idx,
+			     unsigned long offset, struct symbol *sym,
+			     s64 addend, unsigned int type)
 {
 	struct reloc *reloc, empty = { 0 };
 
@@ -906,8 +934,6 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 		sym = elf_create_section_symbol(elf, insn_sec);
 		if (!sym)
 			return NULL;
-
-		insn_sec->sym = sym;
 	}
 
 	return elf_init_reloc(elf, sec->rsec, reloc_idx, offset, sym, addend,
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index fcca6662c8b4..c0a73e247722 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -30,6 +30,7 @@ struct opts {
 	/* options: */
 	bool backtrace;
 	bool backup;
+	bool bounds;
 	bool dryrun;
 	bool link;
 	bool mnop;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 2b8a69de4db8..a2f9c1b4ca88 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -113,8 +113,20 @@ struct section *elf_create_section_pair(struct elf *elf, const char *name,
 					size_t entsize, unsigned int nr,
 					unsigned int reloc_nr);
 
+struct symbol *elf_create_symbol(struct elf *elf, char *name,
+				 struct section *sec, unsigned int bind,
+				 unsigned int type, unsigned long offset,
+				 size_t size);
+
+struct symbol *elf_create_section_symbol(struct elf *elf, struct section *sec);
+
 struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
 
+struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
+			     unsigned int reloc_idx,
+			     unsigned long offset, struct symbol *sym,
+			     s64 addend, unsigned int type);
+
 struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 				      unsigned long offset,
 				      unsigned int reloc_idx,

