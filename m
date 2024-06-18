Return-Path: <linux-kernel+bounces-219690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D0C90D68D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A570B1C24092
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA21CD39;
	Tue, 18 Jun 2024 15:06:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E234323741;
	Tue, 18 Jun 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723212; cv=none; b=USt8wi1uIqJQsAeEPHAaudcGZZNaYQnWLBui3PAxiKo7k5DCttz6W7c6WnoSYxxjvBSM0DxDfrHT02S5XioNGTHTFnGZTWvfWdigVaU3ZZMXkyTQoazs1AlrRNJ5JCHJIcWEEvskCX8BKuki/X1VxwF4WGEk085Z0Mw09zV8Czc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723212; c=relaxed/simple;
	bh=K4Nuu1MdvzbkwkoZbOGhAJw5NwM8D8dujcXnSYn8D20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwUV1wC6gah2CRUE/b9/b01Rzqlp876ajrRMinPfoIvIoZXd9l8GAbdwK9LFRiXf00cx7dk1a73yLFH5KPVl5sixrC5caWr1RFler8AHP3pN4vCm7f7mQYQizv6lri0W3w35CVEqX7FNiegTWfxwX0LPwHzQl+jT7sqdZ94SvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD784DA7;
	Tue, 18 Jun 2024 08:07:11 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21A33F6A8;
	Tue, 18 Jun 2024 08:06:44 -0700 (PDT)
Message-ID: <197e62e3-d34a-442a-97cf-6edf6c8c013f@arm.com>
Date: Tue, 18 Jun 2024 16:06:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf pmu: Restore full PMU name wildcard support
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240617134348.208241-1-james.clark@arm.com>
 <20240617134348.208241-2-james.clark@arm.com>
 <CAP-5=fUZkAs9h+fLiJOeL9p_K3auQcn30mXvXZWRYMchmT9ZPA@mail.gmail.com>
 <b2008905-686b-4494-a10d-c3357cce91da@arm.com>
 <CAP-5=fUkZnG0gaJ_76Azn643DXZSq9xhpX=+U6Mjhtnko8PyLw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fUkZnG0gaJ_76Azn643DXZSq9xhpX=+U6Mjhtnko8PyLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/06/2024 15:23, Ian Rogers wrote:
> On Tue, Jun 18, 2024, 3:59 AM James Clark <james.clark@arm.com> wrote:
> 
>>
>>
>> On 17/06/2024 22:25, Ian Rogers wrote:
>>> On Mon, Jun 17, 2024, 6:44 AM James Clark <james.clark@arm.com> wrote:
>>>
>>>> Commit b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic
>>>> pmu events") gives the following example for wildcarding a subset of
>>>> PMUs:
>>>>
>>>>   E.g., in a system with the following dynamic pmus:
>>>>
>>>>         mypmu_0
>>>>         mypmu_1
>>>>         mypmu_2
>>>>         mypmu_4
>>>>
>>>>   perf stat -e mypmu_[01]/<config>/
>>>>
>>>> Since commit f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()"), only
>>>> "*" has been supported, removing the ability to subset PMUs, even though
>>>> parse-events.l still supports ? and [] characters.
>>>>
>>>> Fix it by using fnmatch() when any glob character is detected and add a
>>>> test which covers that and other scenarios of
>>>> perf_pmu__match_ignoring_suffix().
>>>>
>>>> Fixes: f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()")
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>>
>>>
>>> We use regular expression matching elsewhere rather than fnmatch. We can
>>> also precompile the matchers using lex. I'm not sure we shouldn't be
>>> looking for an opportunity to remove fnmatch rather than expand upon it.
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> Presumably you mean we can do the removal of fnmatch after this fix goes
>> in,
>> rather than instead of? Because this is a user facing change in behaviour
>> but the removal of fnmatch would be an non-user facing code refactor?
>>
>> It's technically not an "expansion" because we always used fnmatch and the
>> linked commit hasn't made it to a release yet.
>>
> 
> The main place the expansion gets added is parse-events.c, previously
> parse-events.y. If we're adding the expansion ourselves then we can choose
> the form we add it. Some coming servers will have 100s of PMUs and so I'm
> worried about the scanning cost when a PMU isn't specified.
> 
> Thanks,
> Ian
> 

I think I might not be following. If a PMU isn't specified then
perf_pmu__match() is never called so no cost is incurred. I also don't
add any new calls to fnmatch().

I only updated the gate on whether the existing fnmatch() is called from
"*" to "*[?". So it only happens when one of those characters is in the
PMU name, but it already happens when '*' is in the name.

But yes I agree about the potential performance issues. With a large
number of PMUs if regex is faster we can update it to use that instead.
But we should make sure the regex supports the same wildcarding options
as before (unless we want to remove the range options, but that's a
separate thing I suppose).

>>>
>>> ---
>>>>  tools/perf/tests/pmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
>>>>  tools/perf/util/pmu.c  |  2 +-
>>>>  2 files changed, 79 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
>>>> index cc88b5920c3e..fd07331b2d6e 100644
>>>> --- a/tools/perf/tests/pmu.c
>>>> +++ b/tools/perf/tests/pmu.c
>>>> @@ -437,12 +437,90 @@ static int test__name_cmp(struct test_suite *test
>>>> __maybe_unused, int subtest __
>>>>         return TEST_OK;
>>>>  }
>>>>
>>>> +/**
>>>> + * Test perf_pmu__match() that's used to search for a PMU given a name
>>>> passed
>>>> + * on the command line. The name that's passed may also be a filename
>>>> type glob
>>>> + * match.
>>>> + */
>>>> +static int test__pmu_match(struct test_suite *test __maybe_unused, int
>>>> subtest __maybe_unused)
>>>> +{
>>>> +       struct perf_pmu test_pmu;
>>>> +
>>>> +       test_pmu.name = "pmuname";
>>>> +       TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu,
>>>> "pmuname"),      true);
>>>> +       TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu,
>>>> "longertoken"), false);
>>>> +       TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu,
>>>> "pmu"),        false);
>>>> +
>>>> +       test_pmu.name = "pmuname_10";
>>>> +       TEST_ASSERT_EQUAL("Diff suffix_", perf_pmu__match(&test_pmu,
>>>> "pmuname_2"),  false);
>>>> +       TEST_ASSERT_EQUAL("Sub suffix_",  perf_pmu__match(&test_pmu,
>>>> "pmuname_1"),  true);
>>>> +       TEST_ASSERT_EQUAL("Same suffix_", perf_pmu__match(&test_pmu,
>>>> "pmuname_10"), true);
>>>> +       TEST_ASSERT_EQUAL("No suffix_",   perf_pmu__match(&test_pmu,
>>>> "pmuname"),    true);
>>>> +       TEST_ASSERT_EQUAL("Underscore_",  perf_pmu__match(&test_pmu,
>>>> "pmuname_"),   true);
>>>> +       TEST_ASSERT_EQUAL("Substring_",   perf_pmu__match(&test_pmu,
>>>> "pmuna"),      false);
>>>> +
>>>> +       test_pmu.name = "pmuname_ab23";
>>>> +       TEST_ASSERT_EQUAL("Diff suffix hex_", perf_pmu__match(&test_pmu,
>>>> "pmuname_2"),    false);
>>>> +       TEST_ASSERT_EQUAL("Sub suffix hex_",  perf_pmu__match(&test_pmu,
>>>> "pmuname_ab"),   true);
>>>> +       TEST_ASSERT_EQUAL("Same suffix hex_", perf_pmu__match(&test_pmu,
>>>> "pmuname_ab23"), true);
>>>> +       TEST_ASSERT_EQUAL("No suffix hex_",   perf_pmu__match(&test_pmu,
>>>> "pmuname"),      true);
>>>> +       TEST_ASSERT_EQUAL("Underscore hex_",  perf_pmu__match(&test_pmu,
>>>> "pmuname_"),     true);
>>>> +       TEST_ASSERT_EQUAL("Substring hex_",   perf_pmu__match(&test_pmu,
>>>> "pmuna"),       false);
>>>> +
>>>> +       test_pmu.name = "pmuname10";
>>>> +       TEST_ASSERT_EQUAL("Diff suffix", perf_pmu__match(&test_pmu,
>>>> "pmuname2"),  false);
>>>> +       TEST_ASSERT_EQUAL("Sub suffix",  perf_pmu__match(&test_pmu,
>>>> "pmuname1"),  true);
>>>> +       TEST_ASSERT_EQUAL("Same suffix", perf_pmu__match(&test_pmu,
>>>> "pmuname10"), true);
>>>> +       TEST_ASSERT_EQUAL("No suffix",   perf_pmu__match(&test_pmu,
>>>> "pmuname"),   true);
>>>> +       TEST_ASSERT_EQUAL("Underscore",  perf_pmu__match(&test_pmu,
>>>> "pmuname_"),  false);
>>>> +       TEST_ASSERT_EQUAL("Substring",   perf_pmu__match(&test_pmu,
>>>> "pmuna"),     false);
>>>> +
>>>> +       test_pmu.name = "pmunameab23";
>>>> +       TEST_ASSERT_EQUAL("Diff suffix hex", perf_pmu__match(&test_pmu,
>>>> "pmuname2"),    false);
>>>> +       TEST_ASSERT_EQUAL("Sub suffix hex",  perf_pmu__match(&test_pmu,
>>>> "pmunameab"),   true);
>>>> +       TEST_ASSERT_EQUAL("Same suffix hex", perf_pmu__match(&test_pmu,
>>>> "pmunameab23"), true);
>>>> +       TEST_ASSERT_EQUAL("No suffix hex",   perf_pmu__match(&test_pmu,
>>>> "pmuname"),     true);
>>>> +       TEST_ASSERT_EQUAL("Underscore hex",  perf_pmu__match(&test_pmu,
>>>> "pmuname_"),    false);
>>>> +       TEST_ASSERT_EQUAL("Substring hex",   perf_pmu__match(&test_pmu,
>>>> "pmuna"),       false);
>>>> +
>>>> +       /*
>>>> +        * 2 hex chars or less are not considered suffixes so it
>> shouldn't
>>>> be
>>>> +        * possible to wildcard by skipping the suffix. Therefore there
>>>> are more
>>>> +        * false results here than above.
>>>> +        */
>>>> +       test_pmu.name = "pmuname_a3";
>>>> +       TEST_ASSERT_EQUAL("Diff suffix 2 hex_",
>> perf_pmu__match(&test_pmu,
>>>> "pmuname_2"),  false);
>>>> +       /*
>>>> +        * This one should be false, but because pmuname_a3 ends in 3
>>>> which is
>>>> +        * decimal, it's not possible to determine if it's a short hex
>>>> suffix or
>>>> +        * a normal decimal suffix following text. And we want to match
>> on
>>>> any
>>>> +        * length of decimal suffix. Run the test anyway and expect the
>>>> wrong
>>>> +        * result. And slightly fuzzy matching shouldn't do too much
>> harm.
>>>> +        */
>>>> +       TEST_ASSERT_EQUAL("Sub suffix 2 hex_",
>> perf_pmu__match(&test_pmu,
>>>> "pmuname_a"),  true);
>>>> +       TEST_ASSERT_EQUAL("Same suffix 2 hex_",
>> perf_pmu__match(&test_pmu,
>>>> "pmuname_a3"), true);
>>>> +       TEST_ASSERT_EQUAL("No suffix 2 hex_",
>>  perf_pmu__match(&test_pmu,
>>>> "pmuname"),    false);
>>>> +       TEST_ASSERT_EQUAL("Underscore 2 hex_",
>> perf_pmu__match(&test_pmu,
>>>> "pmuname_"),   false);
>>>> +       TEST_ASSERT_EQUAL("Substring 2 hex_",
>>  perf_pmu__match(&test_pmu,
>>>> "pmuna"),      false);
>>>> +
>>>> +       test_pmu.name = "pmuname_5";
>>>> +       TEST_ASSERT_EQUAL("Glob 1", perf_pmu__match(&test_pmu, "pmu*"),
>>>>         true);
>>>> +       TEST_ASSERT_EQUAL("Glob 2", perf_pmu__match(&test_pmu,
>>>> "nomatch*"),        false);
>>>> +       TEST_ASSERT_EQUAL("Seq 1",  perf_pmu__match(&test_pmu,
>>>> "pmuname_[12345]"), true);
>>>> +       TEST_ASSERT_EQUAL("Seq 2",  perf_pmu__match(&test_pmu,
>>>> "pmuname_[67890]"), false);
>>>> +       TEST_ASSERT_EQUAL("? 1",    perf_pmu__match(&test_pmu,
>>>> "pmuname_?"),       true);
>>>> +       TEST_ASSERT_EQUAL("? 2",    perf_pmu__match(&test_pmu,
>>>> "pmuname_1?"),      false);
>>>> +
>>>> +       return TEST_OK;
>>>> +}
>>>> +
>>>>  static struct test_case tests__pmu[] = {
>>>>         TEST_CASE("Parsing with PMU format directory", pmu_format),
>>>>         TEST_CASE("Parsing with PMU event", pmu_events),
>>>>         TEST_CASE("PMU event names", pmu_event_names),
>>>>         TEST_CASE("PMU name combining", name_len),
>>>>         TEST_CASE("PMU name comparison", name_cmp),
>>>> +       TEST_CASE("PMU cmdline match", pmu_match),
>>>>         {       .name = NULL, }
>>>>  };
>>>>
>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>> index c94a91645b21..97d74fe6d816 100644
>>>> --- a/tools/perf/util/pmu.c
>>>> +++ b/tools/perf/util/pmu.c
>>>> @@ -2150,7 +2150,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu
>>>> *pmu, __u64 config,
>>>>  bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
>>>>  {
>>>>         const char *name = pmu->name;
>>>> -       bool need_fnmatch = strchr(tok, '*') != NULL;
>>>> +       bool need_fnmatch = strisglob(tok);
>>>>
>>>>         if (!strncmp(tok, "uncore_", 7))
>>>>                 tok += 7;
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>
>>
> 

