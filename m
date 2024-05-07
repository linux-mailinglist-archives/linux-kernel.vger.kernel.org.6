Return-Path: <linux-kernel+bounces-171885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A518BE9E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E08C1C21F78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D300742065;
	Tue,  7 May 2024 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/G+nh7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8916C443
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101006; cv=none; b=CGEzzxkBZBeJ71Jbh4XcHF4CF0spKXMjfzpp25+K1MUdkQATfRl9zlu7eAxVWVr+3iACqs9mOAyJUHsw0mBQlyjtFklsRCcEehlJQg006NJlnvKb1rEFWO4ZCDFAu5RyVC9dQz3Q0+di6S1pzsWSbFEjew9KTIV3cGRY8muold8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101006; c=relaxed/simple;
	bh=cpSnBOlxoobeW93e7dJEkEHD7EOpMpJthLmloLNdINo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AED3SmmgcN6YX2nGxn9girPsPh5It6tPcEyq5IxCXHQ0rjiP6wW1d4o9vnX3K7+3pLTgs6dLIYtfEW8Ve2ewfW6xQQoyn434+LJYCR0M6/yLsX+PuClMZQ5EZv1PgJh40ePVgL2gFKT1UIHiYCjwA8F7WFWLn/0lbZzLgA3PvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/G+nh7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF1CC4DDE1;
	Tue,  7 May 2024 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715101005;
	bh=cpSnBOlxoobeW93e7dJEkEHD7EOpMpJthLmloLNdINo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=E/G+nh7MycQtNscnJTuv0PuvL1b+CIRXIRXtEJYIdUxxCuB8qLiRlLSYx8GFul1sM
	 5Sl79y1bvolz5SfuGBoV+/jdcYBxmvQSXhU8zGcYgf+GTrXMM2Ws5UbO2NKLeGpaAj
	 6pS2RaTP17vUcOjLvaOCmJvGA4X6ricYA4nR+2TnIt8q59pv3nnk3bTL1Uj1dLyzby
	 wWTiCajH3dWEUlZIMvsz8horcyw08ZT6D96TLfblS7RPznZvyI2+P7EMlDH2lLavDj
	 HS70QamYgMSx5berMmBEkUJ1LaRq3/F/sG+kyS15mqKbekaZOo4TR0QO8ZGxyDs4MC
	 xY+PJAPEJAtuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 839E3CE14CC; Tue,  7 May 2024 09:56:45 -0700 (PDT)
Date: Tue, 7 May 2024 09:56:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] kcsan, compiler_types: Introduce __data_racy type
 qualifier
Message-ID: <f140eb01-fc94-478b-8931-3e1d281949ce@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240502141242.2765090-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502141242.2765090-1-elver@google.com>

On Thu, May 02, 2024 at 04:12:17PM +0200, Marco Elver wrote:
> Based on the discussion at [1], it would be helpful to mark certain
> variables as explicitly "data racy", which would result in KCSAN not
> reporting data races involving any accesses on such variables. To do
> that, introduce the __data_racy type qualifier:
> 
> 	struct foo {
> 		...
> 		int __data_racy bar;
> 		...
> 	};
> 
> In KCSAN-kernels, __data_racy turns into volatile, which KCSAN already
> treats specially by considering them "marked". In non-KCSAN kernels the
> type qualifier turns into no-op.
> 
> The generated code between KCSAN-instrumented kernels and non-KCSAN
> kernels is already huge (inserted calls into runtime for every memory
> access), so the extra generated code (if any) due to volatile for few
> such __data_racy variables are unlikely to have measurable impact on
> performance.
> 
> Link: https://lore.kernel.org/all/CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com/ [1]
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I have queued and pushed this, thank you!

I have started testing, and if all goes well I will rebase this on top
of v6.9-rc2 (same base as the rest of my commits for next merge window),
merge it in and push it out.  With a little luck, this will get it into
tomorrow's -next.  With more luck than anyone deserves, today's.

							Thanx, Paul

> ---
>  Documentation/dev-tools/kcsan.rst | 10 ++++++++++
>  include/linux/compiler_types.h    |  7 +++++++
>  kernel/kcsan/kcsan_test.c         | 17 +++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index 94b6802ab0ab..02143f060b22 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -91,6 +91,16 @@ the below options are available:
>    behaviour when encountering a data race is deemed safe.  Please see
>    `"Marking Shared-Memory Accesses" in the LKMM`_ for more information.
>  
> +* Similar to ``data_race(...)``, the type qualifier ``__data_racy`` can be used
> +  to document that all data races due to accesses to a variable are intended
> +  and should be ignored by KCSAN::
> +
> +    struct foo {
> +        ...
> +        int __data_racy stats_counter;
> +        ...
> +    };
> +
>  * Disabling data race detection for entire functions can be accomplished by
>    using the function attribute ``__no_kcsan``::
>  
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 2abaa3a825a9..a38162a8590d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -273,9 +273,16 @@ struct ftrace_likely_data {
>   * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
>   */
>  # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
> +/*
> + * Type qualifier to mark variables where all data-racy accesses should be
> + * ignored by KCSAN. Note, the implementation simply marks these variables as
> + * volatile, since KCSAN will treat such accesses as "marked".
> + */
> +# define __data_racy volatile
>  # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
>  #else
>  # define __no_kcsan
> +# define __data_racy
>  #endif
>  
>  #ifndef __no_sanitize_or_inline
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 015586217875..0c17b4c83e1c 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -304,6 +304,7 @@ static long test_array[3 * PAGE_SIZE / sizeof(long)];
>  static struct {
>  	long val[8];
>  } test_struct;
> +static long __data_racy test_data_racy;
>  static DEFINE_SEQLOCK(test_seqlock);
>  static DEFINE_SPINLOCK(test_spinlock);
>  static DEFINE_MUTEX(test_mutex);
> @@ -358,6 +359,8 @@ static noinline void test_kernel_write_uninstrumented(void) { test_var++; }
>  
>  static noinline void test_kernel_data_race(void) { data_race(test_var++); }
>  
> +static noinline void test_kernel_data_racy_qualifier(void) { test_data_racy++; }
> +
>  static noinline void test_kernel_assert_writer(void)
>  {
>  	ASSERT_EXCLUSIVE_WRITER(test_var);
> @@ -1009,6 +1012,19 @@ static void test_data_race(struct kunit *test)
>  	KUNIT_EXPECT_FALSE(test, match_never);
>  }
>  
> +/* Test the __data_racy type qualifier. */
> +__no_kcsan
> +static void test_data_racy_qualifier(struct kunit *test)
> +{
> +	bool match_never = false;
> +
> +	begin_test_checks(test_kernel_data_racy_qualifier, test_kernel_data_racy_qualifier);
> +	do {
> +		match_never = report_available();
> +	} while (!end_test_checks(match_never));
> +	KUNIT_EXPECT_FALSE(test, match_never);
> +}
> +
>  __no_kcsan
>  static void test_assert_exclusive_writer(struct kunit *test)
>  {
> @@ -1424,6 +1440,7 @@ static struct kunit_case kcsan_test_cases[] = {
>  	KCSAN_KUNIT_CASE(test_read_plain_atomic_rmw),
>  	KCSAN_KUNIT_CASE(test_zero_size_access),
>  	KCSAN_KUNIT_CASE(test_data_race),
> +	KCSAN_KUNIT_CASE(test_data_racy_qualifier),
>  	KCSAN_KUNIT_CASE(test_assert_exclusive_writer),
>  	KCSAN_KUNIT_CASE(test_assert_exclusive_access),
>  	KCSAN_KUNIT_CASE(test_assert_exclusive_access_writer),
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

