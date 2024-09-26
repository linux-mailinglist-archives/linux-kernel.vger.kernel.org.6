Return-Path: <linux-kernel+bounces-340923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE6987913
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDA1280D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303716191E;
	Thu, 26 Sep 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gelwxVx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977201534E6;
	Thu, 26 Sep 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375019; cv=none; b=H2kzqHlBM1e4qrU7UWOxq+H20lpc0tRSinkx3s0SjHhNXS8gU/gjesUiF6zMM2HXa+A3LOClSOZm8sWdxDM9ArVLGspsRTkRJWShIQauKz0KEncs5h6pV/7D0TDFHIo6sKTCkbyE5YlJTGQhNipUzxDdtg8KHGDDXpL95PzGl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375019; c=relaxed/simple;
	bh=lfmlMQv+tmymyNCleTTVgtuAeuqEnh92pBzOzW4+jnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdHOHpQmBCQzohgiC2xQhM+P3lIqnWlO8xROq1QuVS43D8taFU7M5YjtNXYS78PZ8yw6gQNKqZr8iA89HBvNfPfLECWO+9IMVGrswSDi+x93f/fqcH0eLOY5EcYW3qvxY1avO0zN06GVt2eoB1btxxIKcjmfwmslYG0EyH2SAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gelwxVx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCEFC4CEC5;
	Thu, 26 Sep 2024 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727375019;
	bh=lfmlMQv+tmymyNCleTTVgtuAeuqEnh92pBzOzW4+jnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gelwxVx8UU4JM6VmgLW7wvd3bjIjoBQr/40xH1YRFcGpznr0/i9nuZyy3aINFXWTO
	 A0ahAM3LhMaN02FeyMg9uyqwnvLtXoEAT2sMfsprSQ8ecezX+AD5CnpBhunQo3ctSP
	 0/YkbtHkSHFqDzIw6TvYR8eduQDkhHaU9oFxcbuJjtzF9lDBsgyDA5oMD+MGeLGw/I
	 bvRPRi2dqR0eyKt/y4dWHmjQ2VDTvYMBqHT2hx9FPfAJRsyOScAGqoIGVP51Rkt2k9
	 LNAQlNoUZRnZh0uXWOf3nIbKV8FZAGKBRa91K5tMUe1AaUZdZt5/Uj12+UPBY6hAQ3
	 7n93q28Pk+3YA==
Date: Thu, 26 Sep 2024 11:23:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Atish Patra <atishp@rivosinc.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 03/11] perf build: Rename test-dwarf to test-libdw
Message-ID: <ZvWmqLVOiTeNUqSu@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-4-irogers@google.com>
 <ZvSqkGVhD1ETzkDH@google.com>
 <CAP-5=fVvG1h+OA5cO8f=fHX0J-0vDLM190cM178oFYE+i-v5Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVvG1h+OA5cO8f=fHX0J-0vDLM190cM178oFYE+i-v5Tg@mail.gmail.com>

On Thu, Sep 26, 2024 at 08:37:51AM -0700, Ian Rogers wrote:
> On Wed, Sep 25, 2024 at 5:28 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Sep 24, 2024 at 09:04:10AM -0700, Ian Rogers wrote:
> > > Be more intention revealing that the dwarf test is actually testing
> > > for libdw support.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/build/Makefile.feature                     |  6 +++---
> > >  tools/build/feature/Makefile                     | 16 ++++++++--------
> > >  tools/build/feature/test-all.c                   |  6 +++---
> > >  .../build/feature/{test-dwarf.c => test-libdw.c} |  0
> > >  tools/perf/Makefile.config                       |  6 +++---
> > >  5 files changed, 17 insertions(+), 17 deletions(-)
> > >  rename tools/build/feature/{test-dwarf.c => test-libdw.c} (100%)
> > >
> > > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > > index ffd117135094..6025810cc346 100644
> > > --- a/tools/build/Makefile.feature
> > > +++ b/tools/build/Makefile.feature
> > > @@ -30,7 +30,7 @@ endef
> > >  #
> > >  FEATURE_TESTS_BASIC :=                  \
> > >          backtrace                       \
> > > -        dwarf                           \
> > > +        libdw                           \
> > >          dwarf_getlocations              \
> > >          dwarf_getcfi                    \
> > >          eventfd                         \
> > > @@ -120,7 +120,7 @@ ifeq ($(FEATURE_TESTS),all)
> > >  endif
> > >
> > >  FEATURE_DISPLAY ?=              \
> > > -         dwarf                  \
> > > +         libdw                  \
> > >           dwarf_getlocations     \
> > >           glibc                  \
> > >           libbfd                 \
> > > @@ -233,7 +233,7 @@ endef
> > >
> > >  #
> > >  # generates feature value assignment for name, like:
> > > -#   $(call feature_assign,dwarf) == feature-dwarf=1
> > > +#   $(call feature_assign,libdw) == feature-libdw=1
> > >  #
> > >  feature_assign = feature-$(1)=$(feature-$(1))
> > >
> > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > index 5938cf799dc6..bece326ac93b 100644
> > > --- a/tools/build/feature/Makefile
> > > +++ b/tools/build/feature/Makefile
> > > @@ -5,7 +5,7 @@ FILES=                                          \
> > >           test-all.bin                           \
> > >           test-backtrace.bin                     \
> > >           test-bionic.bin                        \
> > > -         test-dwarf.bin                         \
> > > +         test-libdw.bin                         \
> > >           test-dwarf_getlocations.bin            \
> > >           test-dwarf_getcfi.bin                  \
> > >           test-eventfd.bin                       \
> > > @@ -168,9 +168,9 @@ $(OUTPUT)test-libopencsd.bin:
> > >       $(BUILD) # -lopencsd_c_api -lopencsd provided by
> > >                # $(FEATURE_CHECK_LDFLAGS-libopencsd)
> > >
> > > -DWARFLIBS := -ldw
> > > +DWLIBS := -ldw

See here and the below changes.


> > >  ifeq ($(findstring -static,${LDFLAGS}),-static)
> > > -  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
> > > +  DWLIBS += -lelf -lz -llzma -lbz2 -lzstd
> > >
> > >    LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
> > >    LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
> > > @@ -179,18 +179,18 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
> > >    # Elfutils merged libebl.a into libdw.a starting from version 0.177,
> > >    # Link libebl.a only if libdw is older than this version.
> > >    ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
> > > -    DWARFLIBS += -lebl
> > > +    DWLIBS += -lebl
> > >    endif
> > >  endif
> > >
> > > -$(OUTPUT)test-dwarf.bin:
> > > -     $(BUILD) $(DWARFLIBS)
> > > +$(OUTPUT)test-libdw.bin:
> > > +     $(BUILD) $(DWLIBS)
> > >
> > >  $(OUTPUT)test-dwarf_getlocations.bin:
> > > -     $(BUILD) $(DWARFLIBS)
> > > +     $(BUILD) $(DWLIBS)
> > >
> > >  $(OUTPUT)test-dwarf_getcfi.bin:
> > > -     $(BUILD) $(DWARFLIBS)
> > > +     $(BUILD) $(DWLIBS)
> > >
> > >  $(OUTPUT)test-libelf-getphdrnum.bin:
> > >       $(BUILD) -lelf
> > > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> > > index 6f4bf386a3b5..d60e072b6eca 100644
> > > --- a/tools/build/feature/test-all.c
> > > +++ b/tools/build/feature/test-all.c
> > > @@ -38,8 +38,8 @@
> > >  # include "test-glibc.c"
> > >  #undef main
> > >
> > > -#define main main_test_dwarf
> > > -# include "test-dwarf.c"
> > > +#define main main_test_libdw
> > > +# include "test-libdw.c"
> > >  #undef main
> > >
> > >  #define main main_test_dwarf_getlocations
> > > @@ -187,7 +187,7 @@ int main(int argc, char *argv[])
> > >       main_test_get_current_dir_name();
> > >       main_test_gettid();
> > >       main_test_glibc();
> > > -     main_test_dwarf();
> > > +     main_test_libdw();
> > >       main_test_dwarf_getlocations();
> > >       main_test_eventfd();
> > >       main_test_libelf_getphdrnum();
> > > diff --git a/tools/build/feature/test-dwarf.c b/tools/build/feature/test-libdw.c
> > > similarity index 100%
> > > rename from tools/build/feature/test-dwarf.c
> > > rename to tools/build/feature/test-libdw.c
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 182e14e39cd5..c8e157cc0c5e 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -159,8 +159,8 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
> > >      DWARFLIBS += -lebl
> > >    endif
> > >  endif
> > > -FEATURE_CHECK_CFLAGS-dwarf := $(LIBDW_CFLAGS)
> > > -FEATURE_CHECK_LDFLAGS-dwarf := $(LIBDW_LDFLAGS) $(DWARFLIBS)
> > > +FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
> > > +FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
> >
> > s/DWARFLIBS/DWLIBS/ ?
> 
> The patch is changing the name of a feature test. It is possible to
> change this Makefile.config variable in the same patch but I think
> they are distinct things and the variable rename is follow up work.
 
Oh.. you changed it in tools/build/feature/Makefile above but didn't in
tools/perf/Makefile.config.  That confused me.. ;-)

Thanks,
Namhyung

> >
> > >  FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
> > >  FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
> >
> > Ditto.
> >
> > Thanks,
> > Namhyung
> >
> >
> > >  FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
> > > @@ -470,7 +470,7 @@ else
> > >          $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
> > >        endif
> > >      endif
> > > -    ifneq ($(feature-dwarf), 1)
> > > +    ifneq ($(feature-libdw), 1)
> > >        ifndef NO_LIBDW
> > >          $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
> > >          NO_LIBDW := 1
> > > --
> > > 2.46.0.792.g87dc391469-goog
> > >

