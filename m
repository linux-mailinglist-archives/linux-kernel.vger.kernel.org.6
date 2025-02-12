Return-Path: <linux-kernel+bounces-510300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7067FA31AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD713A5FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5118C0C;
	Wed, 12 Feb 2025 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7GeeOff"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932EA50
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321784; cv=none; b=oVZ9aO//SSUUzFrmOQ+PsqjnNNz+z9GivUW0IijmjQsLMo2fBPOU00mOGV6AUrShUvt10elpYtCq7QjJ02RgwKGhCSPt7RzG1w8hv5mMfu/zU4uD6oBuiiEvGULRoiA/9mqbyqU99q2rU6++Lm3TVIZubw7z7LF2BZkhAT9Ibjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321784; c=relaxed/simple;
	bh=e+BLwSgSHjy9yBuT4YO1wwabPYPHQNi+gOE3i7/aaBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkIw9UTKuAv3YiMsSXwMnOniY1yF6MRIL8MmcaVlfA84k5wOOY/Rn1YznWPHYAM5t1JbkhgUgQSaGqgZc8UNLkC0PTjy0Q90bblGeVgoIgXvvodvWYqvRhc8WS0+5cLyO4SWTEYNtUZQTSTMn2LiOE9CGbbXO7YltMD58NqlL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7GeeOff; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f72fac367so63625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739321783; x=1739926583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivh9AzheXIKHdwI+6JcoW6n5m0LCFzWHrb18akb3wpw=;
        b=e7GeeOffPq4t/PQlu78TZoDjxoMl7eKQenwphDwRGK/YvbSq5kzDJyyJZlcEZwTlSF
         Ap0taWoiPsKpEt+CX0unmR6+6Pg3G7GAJGiVDLrZf2dvAo7/JxeLrxBydCQqQCm04Plo
         3xvIHcnfiphwrSK6mDAH6qZNKfW345fZp+tGr3sUpIeXJgcp/JvarLOpdQTb+7hGRByj
         uGoTe5qaOoNZDAg/ZDy0EtHoGFE9adCoN0rU8khD7e/8AhbtoQgYO0na0CprvXKkhNTO
         p68a6uDQ8TbIr6iJTmzPQuThqVWXiOl7iJeI04hcDSKmZLXpmX5X1qhCst/GH4BJmv5e
         tzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321783; x=1739926583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivh9AzheXIKHdwI+6JcoW6n5m0LCFzWHrb18akb3wpw=;
        b=OZoUsqRayzMKbD+U8PoY///whYx2sgiAtfS5Q+SAHYI+ofQw2HXpp/tLkB2w/U3qnw
         jhavSRpPD5ozFT5cyD0vx6tBdO/hcEIEcCgDm4HVSX4wqGcL7l8ebEpRAipejFk3g0Cn
         pjWDVnHjqNpotDvVdp7vYqk1GrOLC1/rryVwrXc8yE7AS6hapljdstQhwhfcdjKgFSWv
         P+gXwMEWbitRuONg4jdX7bS9CLGm4HCGE3UvAoLH4TU76qIxTQjauuo2F5bITia5N2hP
         2b0tFE/G8V9aFnd3DktcBoBEyOtHhgvZI5rDT+jjerLhLJAG2JJAVWvpokGi/T8ThcCR
         7KLA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEEV4RlcuwZBgIA+fTNSyFwqFu2kiyWPuMJtmgmUg8iO2l250kwYHUPCpEqQen8ukqPjHEHXtKwp2h+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPdlnSiPwZEYxF4ruXsytt0/tHSgXF9sFZpvPqLmrTDlb/rZ0
	UisXTGKiMuk7pv1zv10jmHTgt8LnAYJ8IbFO6NlnnLzIl8BgxBUTc3u5ht1mJw==
X-Gm-Gg: ASbGncsgSk7PrF6pSB6he7MjwqiXGkm09GFTxG1+3/uB9rxjTuIViovwftmn/w7Mf8b
	owx/BQMmeM0fhVFxJVPV53n8s3+jSbJJNlQ3O2wVs93gx148u4s3irkvdWEl9sAy9y/3yHJsWej
	n2At46ZQj67b9MLemicu/ElTV9RrvNeCQqqbrlbrUDb3EVPmkFr0IoiV6pea7ujrbxi6DwYiqEM
	OjqEPPnsGFHlctmwoYVdwIIIzjtrmHLov6ZwV9VczsnB1EaI+FaaOgvLyk+Vr3rlwSdw4l9czdR
	aZZS4Ijv6p+OPGr6Yj8P8eLFObPRH0tmvyClhzHYXta9kYFwcy3Rq9Ge8s6lTA==
X-Google-Smtp-Source: AGHT+IE1AfJuJzaHf2oysXFlqioTFb+uK5152VMOgYK5OLbaKeSNVULBQuOJ5dxwdZzPVqNLcrYZHQ==
X-Received: by 2002:a17:903:19e6:b0:216:2839:145 with SMTP id d9443c01a7336-220befcac4bmr648985ad.1.1739321782337;
        Tue, 11 Feb 2025 16:56:22 -0800 (PST)
Received: from google.com (154.164.227.35.bc.googleusercontent.com. [35.227.164.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98d0765sm187583a91.20.2025.02.11.16.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:56:21 -0800 (PST)
Date: Wed, 12 Feb 2025 00:56:17 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: error: gendwarfksyms: process_module: dwarf_get_units failed: no
 debugging information?
Message-ID: <20250212005617.GA1701202@google.com>
References: <202502120752.U3fOKScQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502120752.U3fOKScQ-lkp@intel.com>

On Wed, Feb 12, 2025 at 07:55:45AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
> commit: 9c3681f9b9fd12cdbc4a542df599f1837512f3d5 kbuild: Add gendwarfksyms as an alternative to genksyms
> date:   5 weeks ago
> config: s390-randconfig-002-20250212 (https://download.01.org/0day-ci/archive/20250212/202502120752.U3fOKScQ-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120752.U3fOKScQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502120752.U3fOKScQ-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> error: gendwarfksyms: process_module: dwarf_get_units failed: no debugging information?
> --
>    In file included from <stdin>:3:
>    In file included from arch/s390/include/asm/asm-prototypes.h:4:
> >> include/linux/kvm_host.h:1908:24: warning: field 'desc' with variable sized type 'struct kvm_stats_desc' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>     1908 |         struct kvm_stats_desc desc;
>          |                               ^
>    1 warning generated.
> >> error: gendwarfksyms: process_module: dwarf_get_units failed: no debugging information?

The issue appears to be that the files in arch/s390/purgatory are
always built without debugging information, even though they include
code that uses EXPORT_SYMBOL.

I suspect the correct solution here is to ignore the object files in
this directory when calculating modversions. The quick patch below
fixes the build issue for me. Masahiro, does this look reasonable to
you?

Sami


diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bdcf2a3b6c41..bdcecc19441d 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -28,6 +28,8 @@ KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 PURGATORY_LDFLAGS := -nostdlib -z nodefaultlib
 LDFLAGS_purgatory := -r $(PURGATORY_LDFLAGS) -T
 LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
+# Purgatory doesn't export symbols, so disable symbol versioning.
+$(obj)/purgatory: skip_gendwarfksyms = 1
 $(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 993708d11874..cfb4b57ff617 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -309,11 +309,11 @@ getasmexports =								\
      $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
 
 ifdef CONFIG_GENDWARFKSYMS
-cmd_gensymtypes_S =							\
+cmd_gensymtypes_S = $(if $(skip_gendwarfksyms),,			\
 	$(getasmexports) |						\
 	$(CC) $(c_flags) -c -o $(@:.o=.gendwarfksyms.o) -xc -;		\
 	$(call getexportsymbols,\1) |					\
-	$(gendwarfksyms) $(@:.o=.gendwarfksyms.o)
+	$(gendwarfksyms) $(@:.o=.gendwarfksyms.o))
 else
 cmd_gensymtypes_S =							\
 	$(getasmexports) |						\

