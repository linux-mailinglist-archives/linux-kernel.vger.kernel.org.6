Return-Path: <linux-kernel+bounces-385309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0949B356E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40100283031
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793DD1DE886;
	Mon, 28 Oct 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRUtRG+1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBF1DD9A6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130922; cv=none; b=o+oQX0hobCwMbv4UEahTCF/k6DFix8vLCUITLzZVmWdc3zpBXtVH2PircQuO9RSLCnwpgV5Nkhz5Mn4omD/DIFY3C/COeQGGiyVDdY3f4ath79swfVZgRKaaE61/2vfgCShfHEa2BFsU8Yj1pwl/qw5KzjmNvo/8Mao+XnvvDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130922; c=relaxed/simple;
	bh=G7gK7h5l4wdYxW15n43e1nF6+MLyAKmon7XGH8HlZUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQCSrrWC9APhDgNauSVnSlPZyQMoAbulLOh7c5X71EqjGFF/15n8loqZQklfDyhGeK6HeGQuFHTK3OfBT6cuPnPkkYOh8Z8QDz+nQxufdQpaCeoJIoDJ67eRXmHL1TaoLMLs3/KhuddYd1o1PUO1RrPNpKYg5cVDpflFW8WrkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRUtRG+1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so51814087b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730130920; x=1730735720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C2b1d52yixaqrwrj7hYu48SeL8+Gd/GtggTGgTR4hU=;
        b=XRUtRG+1pMvbKng2jEphQwktkkF+4v29FUF5cFYEncD6tNo4tiD4zA+2vKIEG8qJv7
         b+02gD5wR/p4dsd0SN11dLG6B2O0MMofS6B9qn6K8KegVIIhfpEPaPBFb5fPVfXhhVf8
         FFMF4gM+VCBAqo0FRvdkCVJ0/yd+pWAwPo3nhKuLP8hxsgx42e7QOhSjRq6bY9lTyfKJ
         9O8Y4EkIDQ7PpAziA/UAeD5P4EePzx9RBH8FKbOThDDBEg5H9MsXbyqdGpB9wKJzV6Wp
         OoRLe7+eQ7d9SB1vzVWQjqLEg+8kXZm4OJZqh7qYz50rOVN4j6EWsQRbvp3bXKKjKxu8
         Kffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130920; x=1730735720;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0C2b1d52yixaqrwrj7hYu48SeL8+Gd/GtggTGgTR4hU=;
        b=OCES58K9S/rijRAMdGbhFgg90KTcD10Mj1GsWPzqEnoyW2mCGpt/ioY0YZzINi/CR9
         AAxpgO03KZijKixm7oZV01lc9VP57tsLcx8L1Ljx0bnJeJXSgeSCnHax1DyprP6yZoOL
         W5eF/3TQ5qNVfnG+PV5bE9YIEYYZGP+ad6neGLiCfmUN6RyWKgUkEeIObmHe9YsrjeEs
         KN3mzHa1UzlAiF8/nCV8pms2A8JoUNvGFrZTJFSe0b93qu5SOeGT6PIl/nq9Tcfo+IDM
         gByJV+DzKbvixdnE6C2v1ZzgVKQfI5rtWIam0HguwrooGmRpXstPt7iQ3XBOzPJ9y9iM
         o39g==
X-Forwarded-Encrypted: i=1; AJvYcCXj+BaJdiZUkzKwwPh0Cn5NKiGui0o0CUJ00djPZ+Lxdm1nianJOxlYW9xjht+d9ztRfMVZS0uONGeTSbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzed0/bBMsrD7CrPNkfWd0NPHpERrcigmGxPDwFKNiaHMBMJhxB
	Y3+GRYpshcZPtrIPgJkRel5cmLYuJYJC/FCzKsCoyqXMnvbyl+EmaJWNx6nxFprySolynMxWT4K
	pog==
X-Google-Smtp-Source: AGHT+IFW2uWD2JoYRqx//feYgv7dWWPiDC8Ri6H9Jm3Pt4mRWMx4jp0WPopWTpFDgAHwyA7bUNQFLD/xReI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:7301:b0:6dd:bb6e:ec89 with SMTP id
 00721157ae682-6ea22d45915mr1767b3.2.1730130919797; Mon, 28 Oct 2024 08:55:19
 -0700 (PDT)
Date: Mon, 28 Oct 2024 08:55:18 -0700
In-Reply-To: <c9d8269bff69f6359731d758e3b1135dedd7cc61.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c9d8269bff69f6359731d758e3b1135dedd7cc61.camel@redhat.com>
Message-ID: <Zx-z5sRKCXAXysqv@google.com>
Subject: Re: vmx_pmu_caps_test fails on Skylake based CPUS due to read only LBRs
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024, Maxim Levitsky wrote:
> Hi,
>=20
> Our CI found another issue, this time with vmx_pmu_caps_test.
>=20
> On 'Intel(R) Xeon(R) Gold 6328HL CPU' I see that all LBR msrs (from/to an=
d
> TOS), are always read only - even when LBR is disabled - once I disable t=
he
> feature in DEBUG_CTL, all LBR msrs reset to 0, and you can't change their
> value manually.  Freeze LBRS on PMI seems not to affect this behavior.
>=20
> I don't know if this is how the hardware is supposed to work (Intel's man=
ual
> doesn't mention anything about this), or if it is something platform
> specific, because this system also was found to have LBRs enabled
> (IA32_DEBUGCTL.LBR =3D=3D 1) after a fresh boot, as if BIOS left them ena=
bled - I
> don't have an idea on why.
>=20
> The problem is that vmx_pmu_caps_test writes 0 to LBR_TOS via KVM_SET_MSR=
S,
> and KVM actually passes this write to actual hardware msr (this is somewh=
at
> wierd),

When the "virtual" LBR event is active in host perf, the LBR MSRs are passe=
d
through to the guest, and so KVM needs to propagate the guest values into h=
ardware.

> and since the MSR is not writable and silently drops writes instead,
> once the test tries to read it, it gets some random value instead.

This just showed up in our testing too (delayed backport on our end).  I ha=
ven't
(yet) tried debugging our setup, but is there any chance Intel PT is interf=
ering?

  33.3.1.2 Model Specific Capability Restrictions
  Some processor generations impose restrictions that prevent use of
  LBRs/BTS/BTM/LERs when software has enabled tracing with Intel Processor =
Trace.
  On these processors, when TraceEn is set, updates of LBR, BTS, BTM, LERs =
are
  suspended but the states of the corresponding IA32_DEBUGCTL control field=
s
  remained unchanged as if it were still enabled. When TraceEn is cleared, =
the
  LBR array is reset, and LBR/BTS/BTM/LERs updates will resume.
  Further, reads of these registers will return 0, and writes will be dropp=
ed.

  The list of MSRs whose updates/accesses are restricted follows.
 =20
    =E2=80=A2 MSR_LASTBRANCH_x_TO_IP, MSR_LASTBRANCH_x_FROM_IP, MSR_LBR_INF=
O_x, MSR_LASTBRANCH_TOS
    =E2=80=A2 MSR_LER_FROM_LIP, MSR_LER_TO_LIP
    =E2=80=A2 MSR_LBR_SELECT
 =20
  For processors with CPUID DisplayFamily_DisplayModel signatures of 06_3DH=
,
  06_47H, 06_4EH, 06_4FH, 06_56H, and 06_5EH, the use of Intel PT and LBRs =
are
  mutually exclusive.

If Intel PT is NOT responsible, i.e. the behavior really is due to DEBUG_CT=
L.LBR=3D0,
then I don't see how KVM can sanely virtualize LBRs.

