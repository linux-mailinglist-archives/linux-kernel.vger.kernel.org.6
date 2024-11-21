Return-Path: <linux-kernel+bounces-416451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E909D44EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AA9282DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46706AD2C;
	Thu, 21 Nov 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNN0F4v4"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416370801
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732148960; cv=none; b=MvtLVNs0fNfzMjCqBilHqLbU9/CU23KBLRx0sTDDZ5ncEVpY8G4by1FZrlciOf/v94e5wL6JNZAk14K7IRDh04vXkvOx9/m7xEu5k8g68Yu8IhmsYV9zG9glPA8ma4h5rzUqbAspXK82xap/oWwmH0K+yeg1eUULkpFnX+QALOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732148960; c=relaxed/simple;
	bh=FWiIcYFpfnIOckfKm46vnv7yodm9kc7vmZ3xSFEEu2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H5bUi4yiBZutswtmdkyjfKX+oynAvAYJ8u/OWshxxb2JTGRnSkrBeidCXwVmCV0zO+DQsAfVaPTnNjSRCAwKfDVLjubZXUEc0hmLM8sFDZDpzrP0cV1EwnG8UbIkjBwsZp92/XQiiAeEAarjQoJ5tzrv2LyR3L1DIs0rHfQFjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QNN0F4v4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20d15285c87so2909945ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732148958; x=1732753758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaq4pkjzDY4CwQXdUFb+TCwYFBRLtW6PERcuUhVZR0I=;
        b=QNN0F4v4e21npo3IpTvpttKjnzO+EF1ivP9E96RrGxf7iPR81A/uRR+FM0G7SUWqO4
         aTuLc05QPeW5XDTQK8sNyLhInwxQVbdbFgql5saLLgUP9EZLLqBZppeqEw7Zt1kcIp6X
         jxapjWAJ1fhtQcRC9gQFeK707erDWOBzJb501IN+0dQ62v9vcBpWudFdSWG0fBNpI/1u
         x9pl6AO+rZWsQhsLfboxak+pT8LYCKuJyvyMu76N+sc7zgT5HdmP/mdxreoKJ+8rXf1T
         x8vUxYD21dv+ANwiH6ZGMvNAkBO9fBhRZWKh7D2GZuhCZqmKV4iF3VI+FT8CpZmn8w2y
         NJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732148958; x=1732753758;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yaq4pkjzDY4CwQXdUFb+TCwYFBRLtW6PERcuUhVZR0I=;
        b=DoS4ftbyG/l1VJuyPuVIJGbHOKQJm8Mbo5pt3/46N3ltWRjEh+vytAR5QtF7FBWfst
         RIzE/DgbKLJ+2lh5qw6zw3YEP81blH0RyDdz5fhZWCaXzdqX+Fc8ikpkPwlCKxJo59/q
         Bm5YazX4blgKTWJt6XRbcWFyPjoPGEYczC0O2hpSMLPDivUiBT1TnOKtbGwIr7T4I2un
         7YWBTbTitKODrmypB2wxErwlc4PziMhd+FgZ3Mudw2pl73Z+2NNsGXrMAWtmfYLBvq9E
         +K1TvRNYTH//RkicUtrfU8VE/y3fgrcvhAZSDLi1lA7scLnHakwOTEeaKBJ/LZURuzKi
         Cwzw==
X-Forwarded-Encrypted: i=1; AJvYcCXo8CCjOdPs9yfww2ENxRE3vedbjq1uUfaZAORreYkhKxhrzylYGEdzsZmY2Mr6nd4ZgBje8WwM5luaYw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Z9lPN8WljdxKc5oZ7YYFbAEvVNQurzImCVvsfp4/6oNLB+bI
	xgibAOeWoqcX4h4cy9pXLx6FEc+nFeaBS8nLyiJSk6X36btU8wVUPOPwA/svqssojs4kQQnenMG
	kWA==
X-Google-Smtp-Source: AGHT+IEo3SsZK3GD4ZcR6dZRBQukGq0A2fKygifFSwayRaQbB5hqp/jWvkHnbijR91Fktwts9Qc8xXjY/nM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:facb:b0:20b:b7b2:b6ef with SMTP id
 d9443c01a7336-2126a342d20mr18935ad.4.1732148957811; Wed, 20 Nov 2024 16:29:17
 -0800 (PST)
Date: Wed, 20 Nov 2024 16:29:16 -0800
In-Reply-To: <20241115211523.GB599524.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240821223012.3757828-1-vipinsh@google.com> <CAHVum0eSxCTAme8=oV9a=cVaJ9Jzu3-W-3vgbubVZ2qAWVjfJA@mail.gmail.com>
 <CAHVum0fWJW7V5ijtPcXQAtPSdoQSKjzYwMJ-XCRH2_sKs=Kg7g@mail.gmail.com>
 <ZyuiH_CVQqJUoSB-@google.com> <20241108-eaacad12f1eef31481cf0c6c@orel>
 <ZzY2iAqNfeiiIGys@google.com> <20241115211523.GB599524.vipinsh@google.com>
Message-ID: <Zz5-3A36cckhYu9K@google.com>
Subject: Re: [RFC PATCH 0/1] KVM selftests runner for running more than just default
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024, Vipin Sharma wrote:
> On 2024-11-14 09:42:32, Sean Christopherson wrote:
> > On Fri, Nov 08, 2024, Andrew Jones wrote:
> > > On Wed, Nov 06, 2024 at 09:06:39AM -0800, Sean Christopherson wrote:
> > > > On Fri, Nov 01, 2024, Vipin Sharma wrote:
> > > > > Phase 3: Provide collection of interesting configurations
> > > > >=20
> > > > > Specific individual constructs can be combined in a meaningful wa=
y to
> > > > > provide interesting configurations to run on a platform. For exam=
ple,
> > > > > user doesn't need to specify each individual configuration instea=
d,
> > > > > some prebuilt configurations can be exposed like
> > > > > --stress_test_shadow_mmu, --test_basic_nested
> > > >=20
> > > > IMO, this shouldn't be baked into the runner, i.e. should not surfa=
ce as dedicated
> > > > command line options.  Users shouldn't need to modify the runner ju=
st to bring
> > > > their own configuration.  I also think configurations should be dis=
coverable,
> > > > e.g. not hardcoded like KUT's unittest.cfg.  A very real problem wi=
th KUT's
> > > > approach is that testing different combinations is frustratingly di=
fficult,
> > > > because running a testcase with different configuration requires mo=
difying a file
> > > > that is tracked by git.
>=20
> I was thinking of folks who send upstream patches, they might not have
> interesting configurations to run to test. If we don't provide an option
> then they might not be able to test different scenarios.

Yeah, I'm not saying upstream can't provide testcases, just that the existe=
nce of
testcases shouldn't be hardcoded into the runner.

> I do agree command line option might not be a great choice here, we
> should keep them granular.
>=20
> What if there is a shell script which has some runner commands with
> different combinations? There should be a default configuration provided
> to ease testing of patches for folks who might not be aware of the
> configurations which maintainers generally use.
>=20
> End goal is to provide good confidence to the patch submitter that they h=
ave
> done good testing.

As discussed off-list, I think having one testcase per file is the way to g=
o.

  - Very discoverable (literally files)
  - The user (or a shell script) can use regexes, globbing, etc., to select=
 which
    tests to run
  - Creating "suites" is similarly easy, e.g. by having a list of files/tes=
tscase,
    or maybe by directory layout

Keeping track of testcases (and their content), e.g. to avoid duplicates, m=
ight
be an issue, but I think we can mitigate that by establishing and following
guidelines for naming, e.g. so that the name of a testcase gives the user a
decent idea of what it does.

> > > Could also use an environment variable to specify a file which contai=
ns
> > > a config in a test-specific format if parsing environment variables i=
s
> > > insufficient or awkward for configuring a test.
> >=20
> > There's no reason to use a environment variable for this.  If we want t=
o support
> > "advanced" setup via a test configuration, then that can simply go in c=
onfiguration
> > file that's passed to the runner.
>=20
> Can you guys specify What does this test configuration file/directory
> will look like? Also, is it gonna be a one file for one test? This might
> become ugly soon.

As above, I like the idea of one file per testcase.  I'm not anticipating t=
housands
of tests.  Regardless of how we organize things, mentally keeping track of =
that
many tests would be extremely difficult.  E.g. testcases would likely bitro=
t and/or
we'd end up with a lot of overlap.  And if we do get anywhere near that num=
ber of
testcases, they'll need to be organzied in some way.

One idea would be create a directory per KVM selftest, and then put testcas=
es for
that test in said directory.  We could even do something clever like fail t=
he
build if a test doesn't have a corresponding directory (and a default testc=
ase?).

E.g. tools/testing/selftests/kvm/testcases, with sub-directories following =
the
tests themsleves and separated by architecture as appropriate.

That us decent organization.  If each test has a testcase directory, it's e=
asy to
get a list of testcases.  At that point, the name of the testcase can be us=
ed to
organize and describe, e.g. by tying the name to the (most interesting) par=
ameters.

Hmm, and for collections of multiple testscases, what if we added a separat=
e
"testsuites" directory, with different syntax?  E.g. one file per testuite,=
 which
is basically a list of testcases.  Maybe with some magic to allow testsuite=
s to
"include" arch specific info?

E.g. something like this

$ tree test*
testcases
=E2=94=94=E2=94=80=E2=94=80 max_guest_memory_test
    =E2=94=94=E2=94=80=E2=94=80 128gib.allvcpus.test
testsuites
=E2=94=94=E2=94=80=E2=94=80 mmu.suite

3 directories, 2 files
$ cat testsuites/mmu.suite=20
$ARCH/mmu.suite
max_guest_memory_test/128gib.allvcpus.test

> This brings the question on how to handle the test execution when we are =
using
> different command line parameters for individual tests which need some
> specific environmnet?
>=20
> Some parameters will need a very specific module or sysfs setting which
> might conflict with other tests. This is why I had "test_suite" in my
> json, which can provide some module, sysfs, or other host settings. But
> this also added cost of duplicating tests for each/few suites.

IMO, this should be handled by user, or their CI environment, not by the up=
stream
runner.  Reconfiguring module params or sysfs knobs is inherently environme=
nt
specific.  E.g. not all KVM module params are writable post-load, and so ch=
anging
a param might require stopping all VMs on the system, or even a full kernel=
 reboot
if KVM is built-in.  There may also be knobs that require root access, that=
 are
dependent on hardware and/or kernel config, etc.

I really don't want to build all that into the upstream test runner, certai=
nly not
in the first few phases.  I 100% think the runner should be constructed in =
such a
way that people/organizations/CI pipeines can build infrastructure on top, =
I just
don't think it's a big need or a good fit for upstream.

> I guess the shell script I talked about few paragraphs above, can have
> some specific runner invocations which will set specific requirements of
> the test and execute that specific test (RFC runner has the capabilty to =
execute
> specific test).
>=20
> Open to suggestions on a better approach.

