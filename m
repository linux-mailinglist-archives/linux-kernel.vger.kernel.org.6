Return-Path: <linux-kernel+bounces-436179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9609E822E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F154B1652E8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C44154425;
	Sat,  7 Dec 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HV87ou+p"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0E34CC4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733605952; cv=none; b=RhE5BK6AHZerahPmaVklbviMOleat0NrGOTEVL9AR+y7rsn4il3e6HWurDqLJwbohZatFckCBazaKEzJi0SVww4McDEyYQmdVGZvKiztwf+LNNGbE21FmjWor91sJNI3MBfOVm/TWFjG1V4Xj/yorn9AFyn7EanW+i1lLngKMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733605952; c=relaxed/simple;
	bh=vATbQ0NFVS0vjRVtkwEvWTym4PU7RrVnbFcpx1QcfyU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CVMmbt4GloJhcAbRNwuqHCGhEx6NnIqnlloebS1UVlPD+8304ERRxVNXi23o/qAVX/T1uTtsyvh7iA3OWAx9cI/W8U4imiRJm9cFM6PQ57PeziTBVqlMrvu2pbqlK9XmLert9yS+bszQZXj8C295pognL6d8iUZz6ES5GWeXGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HV87ou+p; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4B7LBNPM2935190
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 7 Dec 2024 13:11:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4B7LBNPM2935190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1733605885;
	bh=yrVV+ZiikcAW1cNetUD0nXbzS6VssMUyBuMSsCC1jYI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HV87ou+pXyEzXrRpZPxTi/z148+mGhfiHYDgqLwFVuJN5hoQlfk2Dd3XijmydinwZ
	 TzV27xaweCYU96Kf5qq6kGzMlyjW8myWo3p+lUVB78ZPZoxL51Q1N33uVEKpvU+wv+
	 ZYlGkj6slJO0QX+gGJpDVN/bqw4DIN72oXc0zq7YGVd0YckXbI4IGoMU9gXP+OmLfS
	 u66ZtCTuB9fJFrw5lLFLc4uUxSBU+gS1tWJLKx4OWa2xYZTD0CE0qxaP7i8dXou2Gs
	 MQIhB4CHoLGIV+dWFB2HO3turAmNmI9U8uZWRwua/J1COoCLCh3Tx5hHC+Dw3YmeJS
	 0fwMqMpQ53uow==
Date: Sat, 07 Dec 2024 13:11:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Eric Biggers <ebiggers@google.com>, Xin Li <xin3.li@intel.com>,
        Alexander Shishkin <alexander.shishkin@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/2=5D_x86/cpufeature=3A_Ad?=
 =?US-ASCII?Q?d_a_debug_print_for_unmet_dependencies?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241207004126.2054658-2-sohil.mehta@intel.com>
References: <20241207004126.2054658-1-sohil.mehta@intel.com> <20241207004126.2054658-2-sohil.mehta@intel.com>
Message-ID: <A62E8AE8-A7C8-4223-A914-CF5130F77E68@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 6, 2024 4:41:26 PM PST, Sohil Mehta <sohil=2Emehta@intel=2Ecom>=
 wrote:
>Instead of silently disabling features, add a print which might be
>useful to users if their favorite feature gets unexpectedly disabled=2E
>
>Features are typically represented through unsigned integers though some
>of them have user friendly names if they are exposed via cpuinfo=2E  Show
>the friendlier name if available otherwise display the X86_FEATURE_*
>numerals to make it easier to identify the feature=2E
>
>Use pr_debug() to avoid spamming the kernel log and generating false
>alarms=2E Note that the print will occur once per disabled feature on
>every CPU=2E Show this information only when someone is really looking fo=
r
>it=2E
>
>Suggested-by: Tony Luck <tony=2Eluck@intel=2Ecom>
>Signed-off-by: Sohil Mehta <sohil=2Emehta@intel=2Ecom>
>---
>Sent as a separate patch to make it easier to review and drop if it
>feels unnecessary=2E
>
>I can see both sides of the argument=2E The pr_debug() serves a
>compromise between the two=2E
>
>v3: New patch=2E
>
>---
> arch/x86/kernel/cpu/cpuid-deps=2Ec | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/cpu/cpuid-deps=2Ec b/arch/x86/kernel/cpu/cpu=
id-deps=2Ec
>index 8bea5c5e4fd2=2E=2Ec72f2dd77d72 100644
>--- a/arch/x86/kernel/cpu/cpuid-deps=2Ec
>+++ b/arch/x86/kernel/cpu/cpuid-deps=2Ec
>@@ -147,12 +147,32 @@ void setup_clear_cpu_cap(unsigned int feature)
> 	do_clear_cpu_cap(NULL, feature);
> }
>=20
>+/*
>+ * Return the feature "name" if available otherwise return
>+ * the X86_FEATURE_* numerals to make it easier to identify
>+ * the feature=2E
>+ */
>+static const char *x86_feature_name(unsigned int feature, char *buf)
>+{
>+	if (x86_cap_flags[feature])
>+		return x86_cap_flags[feature];
>+
>+	snprintf(buf, 12, "%d*32+%2d", feature / 32, feature % 32);
>+
>+	return buf;
>+}
>+
> void filter_feature_dependencies(struct cpuinfo_x86 *c)
> {
>+	char feature_buf[12], depends_buf[12];
> 	const struct cpuid_dep *d;
>=20
> 	for (d =3D cpuid_deps; d->feature; d++) {
>-		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
>+		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
>+			pr_debug("x86/cpu: Disabling feature %s since feature %s is missing\n=
",
>+				 x86_feature_name(d->feature, feature_buf),
>+				 x86_feature_name(d->depends, depends_buf));
> 			do_clear_cpu_cap(c, d->feature);
>+		}
> 	}
> }

Ok, I realize that the x86 maintainers **very legitimately** don't want mo=
re crap in /proc/cpuinfo, but perhaps we could include the strings for prin=
ting debug messages in cleartext? Add a bitmap for which entries should go =
into /proc/cpuinfo=2E

