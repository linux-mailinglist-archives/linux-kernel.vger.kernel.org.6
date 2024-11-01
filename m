Return-Path: <linux-kernel+bounces-393004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AC9B9AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD43281EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50BD1E6DD5;
	Fri,  1 Nov 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="op0ajXu/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72D1AAE06
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499270; cv=none; b=ug32xMzqAeVwFxcF8juLwDwDHEpD5qJLBNhQIsECmSvUxme+deDYf94AtbAc52smO2tMsSXMmjwifnkkPn39WIaQGHke2nmZn/d4O03AqMfHg5HxwNoIbE70pUEQ52A7CbAYiyLvHNmNukbNEodfclT4sPG4kHZuljAg3rfD5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499270; c=relaxed/simple;
	bh=wLtASQMHq4sgKLG7ICINv/hxvFRTofV3JDrpku5EzC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCEkT/9XdlCetJapJPj3hkMChSoaqWtprYJ0aZ1w+VD4Tk2X6myUdcBP4f6ZgWAql677g7rM8Xji/0Fhv7Ij3v+jBWydytug0KQ+DZ5r/lgivfl6F3cven60M6qQcWVsqnTQ/g2uJDzbNQi8+6MpJUPrt3YMhyyara+ZoaP1RLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=op0ajXu/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e681ba70so3744e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730499267; x=1731104067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++IjMUbwkrGj/mHG9oyoX/blJaf9PFISzgC1CVaEouo=;
        b=op0ajXu/qHv6hXElgj5BjVCU15fJEo24aLthgpT4uFaYt53LdsUhaBaqv2FC02GHrf
         iNs9dL2vTI6Hn8YFOPwJMJ1VUWwOGaa7wGywMGHNlIdjASX/mIElxckb/rNnB+OKQu+j
         bv43l6oDJD9KkP1bbcR7nVg5fOSW+pF7KQmNxR3oRzwEgUR3i0vKPlCXunwBbMc3oBXE
         KqfcUmb7pvyidmcVWZG+A3EYyfwskDWvDlxn+lF6zTZT1SZjzar1HRuzTCHj13Grx//Y
         /f1j+mYIacCX+RyQN4Q7sIOoiHHUpSYQwm9Kv/BIFAbITmPLxZnd7OcRX4AyR2I/9X4N
         qhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499267; x=1731104067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++IjMUbwkrGj/mHG9oyoX/blJaf9PFISzgC1CVaEouo=;
        b=pQUXqcGE+BzIkhIfm3WFGzPVN66DHu6v1XF9Dqem8HWMPQKmWegWF038aiBkAFZgL+
         E9UOd3EAIAV8R2CqWOCHSX5WYoh1afE+xuN+tfNbrKGJHeD9cliEZo5JxjuUilBKzrFI
         Q/8cqJWCLXnMOwANGqlym0juRGjgYEypBjOaQS1aY5iebYd9KBhb7WWQCNiIpAETO4Yj
         h5eGJ0iTYek6dDcHl9hGdzOZqDKbWIZ0nbBu3OR6+MJaYe+upwdK928pC5t8gTRHgYd1
         gaSOM4Gmi8XE4TAUGsgjPCsXMzdOaTahq7yGrPWLJyMv2a4iNoTWitBU0SyAf+oQpXst
         MI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe8xNcgGQzNV4EvvYfDWNvscpYnrzK+VYflPSQBa8y0qPzfD9T95DTBsoqhV7mBpKPQxYvkgxR9UKLHbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7KcIV3bwRhjXbAkYz9y3W0OELrd9z9jb3eYzfRP89p8nM8mt
	mC1I0CR0IW13DsP6s1p5GDJF6wj/ktnzOFmxNHKr1lF85oDUIaAP0nAx2UxwFcOZPkGxPesrzxY
	67tBYF2uSuAWbst+dCVttGF46MJztahjvKBUA
X-Gm-Gg: ASbGncs58ZJjtIN5IQdmsSKXLndQdc7OqfKjNji9h2sl++FOIBA+YA5VuxbjzKxKJo6
	T7G8EWC9mtE+XR6waswTNjr6Obxf9JaUTrhW0QvFeCFVUy+pNJFnTdK2y1Kkl
X-Google-Smtp-Source: AGHT+IH2BcX/vmuG7YSwKV0+HLH1Y2RSr4a5KE0L+pbR96qsVezQH73VuaXsrlKiCpYFZijNULMRFs0zTF+aMIiqk0U=
X-Received: by 2002:a05:6512:31c4:b0:53b:5ae5:a9c8 with SMTP id
 2adb3069b0e04-53d6b1b3334mr53844e87.7.1730499266896; Fri, 01 Nov 2024
 15:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821223012.3757828-1-vipinsh@google.com> <CAHVum0eSxCTAme8=oV9a=cVaJ9Jzu3-W-3vgbubVZ2qAWVjfJA@mail.gmail.com>
In-Reply-To: <CAHVum0eSxCTAme8=oV9a=cVaJ9Jzu3-W-3vgbubVZ2qAWVjfJA@mail.gmail.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Fri, 1 Nov 2024 15:13:49 -0700
Message-ID: <CAHVum0fWJW7V5ijtPcXQAtPSdoQSKjzYwMJ-XCRH2_sKs=Kg7g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] KVM selftests runner for running more than just default
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:55=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> Oops! Adding archs mailing list and maintainers which have arch folder
> in tool/testing/selftests/kvm
>
> On Wed, Aug 21, 2024 at 3:30=E2=80=AFPM Vipin Sharma <vipinsh@google.com>=
 wrote:
> >
> > This series is introducing a KVM selftests runner to make it easier to
> > run selftests with some interesting configurations and provide some
> > enhancement over existing kselftests runner.
> >
> > I would like to get an early feedback from the community and see if thi=
s
> > is something which can be useful for improving KVM selftests coverage
> > and worthwhile investing time in it. Some specific questions:
> >
> > 1. Should this be done?
> > 2. What features are must?
> > 3. Any other way to write test configuration compared to what is done h=
ere?
> >
> > Note, python code written for runner is not optimized but shows how thi=
s
> > runner can be useful.
> >
> > What are the goals?
> > - Run tests with more than just the default settings of KVM module
> >   parameters and test itself.
> > - Capture issues which only show when certain combination of module
> >   parameter and tests options are used.
> > - Provide minimum testing which can be standardised for KVM patches.
> > - Run tests parallely.
> > - Dump output in a hierarchical folder structure for easier tracking of
> >   failures/success output
> > - Feel free to add yours :)
> >
> > Why not use/extend kselftests?
> > - Other submodules goal might not align and its gonna be difficult to
> >   capture broader set of requirements.
> > - Instead of test configuration we will need separate shell scripts
> >   which will act as tests for each test arg and module parameter
> >   combination. This will easily pollute the KVM selftests directory.
> > - Easier to enhance features using Python packages than shell scripts.
> >
> > What this runner do?
> > - Reads a test configuration file (tests.json in patch 1).
> >   Configuration in json are written in hierarchy where multiple suites
> >   exist and each suite contains multiple tests.
> > - Provides a way to execute tests inside a suite parallelly.
> > - Provides a way to dump output to a folder in a hierarchical manner.
> > - Allows to run selected suites, or tests in a specific suite.
> > - Allows to do some setup and teardown for test suites and tests.
> > - Timeout can be provided to limit test execution duration.
> > - Allows to run test suites or tests on specific architecture only.
> >
> > Runner is written in python and goal is to only use standard library
> > constructs. This runner will work on Python 3.6 and up
> >
> > What does a test configuration file looks like?
> > Test configuration are written in json as it is easier to read and has
> > inbuilt package support in Python. Root level is a json array denoting
> > suites and each suite can multiple tests in it using json array.
> >
> > [
> >   {
> >     "suite": "dirty_log_perf_tests",
> >     "timeout_s": 300,
> >     "arch": "x86_64",
> >     "setup": "echo Setting up suite",
> >     "teardown": "echo tearing down suite",
> >     "tests": [
> >       {
> >         "name": "dirty_log_perf_test_max_vcpu_no_manual_protect",
> >         "command": "./dirty_log_perf_test -v $(grep -c ^processor /proc=
/cpuinfo) -g",
> >         "arch": "x86_64",
> >         "setup": "echo Setting up test",
> >         "teardown": "echo tearing down test",
> >         "timeout_s": 5
> >       }
> >     ]
> >   }
> > ]
> >
> > Usage:
> > Runner "runner.py" and test configuration "tests.json" lives in
> > tool/testing/selftests/kvm directory.
> >
> > To run serially:
> > ./runner.py tests.json
> >
> > To run specific test suites:
> > ./runner.py tests.json dirty_log_perf_tests x86_sanity_tests
> >
> > To run specific test in a suite:
> > ./runner.py tests.json x86_sanity_tests/vmx_msrs_test
> >
> > To run everything parallely (runs tests inside a suite parallely):
> > ./runner.py -j 10 tests.json
> >
> > To dump output to disk:
> > ./runner.py -j 10 tests.json -o sample_run
> >
> > Sample output (after removing timestamp, process ID, and logging
> > level columns):
> >
> >   ./runner.py tests.json  -j 10 -o sample_run
> >   PASSED: dirty_log_perf_tests/dirty_log_perf_test_max_vcpu_no_manual_p=
rotect
> >   PASSED: dirty_log_perf_tests/dirty_log_perf_test_max_vcpu_manual_prot=
ect
> >   PASSED: dirty_log_perf_tests/dirty_log_perf_test_max_vcpu_manual_prot=
ect_random_access
> >   PASSED: dirty_log_perf_tests/dirty_log_perf_test_max_10_vcpu_hugetlb
> >   PASSED: x86_sanity_tests/vmx_msrs_test
> >   SKIPPED: x86_sanity_tests/private_mem_conversions_test
> >   FAILED: x86_sanity_tests/apic_bus_clock_test
> >   PASSED: x86_sanity_tests/dirty_log_page_splitting_test
> >   ---------------------------------------------------------------------=
-----
> >   Test runner result:
> >   1) dirty_log_perf_tests:
> >      1) PASSED: dirty_log_perf_test_max_vcpu_no_manual_protect
> >      2) PASSED: dirty_log_perf_test_max_vcpu_manual_protect
> >      3) PASSED: dirty_log_perf_test_max_vcpu_manual_protect_random_acce=
ss
> >      4) PASSED: dirty_log_perf_test_max_10_vcpu_hugetlb
> >   2) x86_sanity_tests:
> >      1) PASSED: vmx_msrs_test
> >      2) SKIPPED: private_mem_conversions_test
> >      3) FAILED: apic_bus_clock_test
> >      4) PASSED: dirty_log_page_splitting_test
> >   ---------------------------------------------------------------------=
-----
> >
> > Directory structure created:
> >
> > sample_run/
> > |-- dirty_log_perf_tests
> > |   |-- dirty_log_perf_test_max_10_vcpu_hugetlb
> > |   |   |-- command.stderr
> > |   |   |-- command.stdout
> > |   |   |-- setup.stderr
> > |   |   |-- setup.stdout
> > |   |   |-- teardown.stderr
> > |   |   `-- teardown.stdout
> > |   |-- dirty_log_perf_test_max_vcpu_manual_protect
> > |   |   |-- command.stderr
> > |   |   `-- command.stdout
> > |   |-- dirty_log_perf_test_max_vcpu_manual_protect_random_access
> > |   |   |-- command.stderr
> > |   |   `-- command.stdout
> > |   `-- dirty_log_perf_test_max_vcpu_no_manual_protect
> > |       |-- command.stderr
> > |       `-- command.stdout
> > `-- x86_sanity_tests
> >     |-- apic_bus_clock_test
> >     |   |-- command.stderr
> >     |   `-- command.stdout
> >     |-- dirty_log_page_splitting_test
> >     |   |-- command.stderr
> >     |   |-- command.stdout
> >     |   |-- setup.stderr
> >     |   |-- setup.stdout
> >     |   |-- teardown.stderr
> >     |   `-- teardown.stdout
> >     |-- private_mem_conversions_test
> >     |   |-- command.stderr
> >     |   `-- command.stdout
> >     `-- vmx_msrs_test
> >         |-- command.stderr
> >         `-- command.stdout
> >
> >
> > Some other features for future:
> > - Provide "precheck" command option in json, which can filter/skip test=
s if
> >   certain conditions are not met.
> > - Iteration option in the runner. This will allow the same test suites =
to
> >   run again.
> >
> > Vipin Sharma (1):
> >   KVM: selftestsi: Create KVM selftests runnner to run interesting test=
s
> >
> >  tools/testing/selftests/kvm/runner.py  | 282 +++++++++++++++++++++++++
> >  tools/testing/selftests/kvm/tests.json |  60 ++++++
> >  2 files changed, 342 insertions(+)
> >  create mode 100755 tools/testing/selftests/kvm/runner.py
> >  create mode 100644 tools/testing/selftests/kvm/tests.json
> >
> >
> > base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
> > --
> > 2.46.0.184.g6999bdac58-goog
> >

Had an offline discussion with Sean, providing a summary on what we
discussed (Sean, correct me if something is not aligned from our
discussion):

We need to have a roadmap for the runner in terms of features we support.


Phase 1: Having a basic selftest runner is useful which can:

- Run tests parallely
- Provide a summary of what passed and failed, or only in case of failure.
- Dump output which can be easily accessed and parsed.
- Allow to run with different command line parameters.

Current patch does more than this and can be simplified.


Phase 2: Environment setup via runner

Current patch, allows to write "setup" commands at test suite and test
level in the json config file to setup the environment needed by a
test to run. This might not be ideal as some settings are exposed
differently on different platforms.

For example,
To enable TDP:
- Intel needs npt=3DY
- AMD needs ept=3DY
- ARM always on.

To enable APIC virtualization
- Intel needs enable_apicv=3DY
- AMD needs avic=3DY

To enable/disable nested, they both have the same file name "nested"
in their module params directory which should be changed.

These kinds of settings become more verbose and unnecessary on other
platforms. Instead, runners should have some programming constructs
(API, command line options, default) to enable these options in a
generic way. For example, enable/disable nested can be exposed as a
command line --enable_nested, then based on the platform, runner can
update corresponding module param or ignore.

This will easily extend to providing sane configuration on the
corresponding platforms without lots of hardcoding in JSON. These
individual constructs will provide a generic view/option to run a KVM
feature, and under the hood will do things differently based on the
platform it is running on like arm, x86-intel, x86-amd, s390, etc.


Phase 3: Provide collection of interesting configurations

Specific individual constructs can be combined in a meaningful way to
provide interesting configurations to run on a platform. For example,
user doesn't need to specify each individual configuration instead,
some prebuilt configurations can be exposed like
--stress_test_shadow_mmu, --test_basic_nested

Tests need to handle the environment in which they are running
gracefully, which many tests already do but not exhaustively. If some
setting is not provided or set up properly for their execution then
they should fail/skip accordingly.

Runner will not be responsible to precheck things on tests behalf.


Next steps:
1. Consensus on above phases and features.
2. Start development.

Thanks,
Vipin

