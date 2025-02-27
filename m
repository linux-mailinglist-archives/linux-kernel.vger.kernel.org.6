Return-Path: <linux-kernel+bounces-535513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D2A473C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1797516A42C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3D91E1DEC;
	Thu, 27 Feb 2025 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsAsQXQF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84E1EB5E5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628253; cv=none; b=MZ3RC28NkKvw84pNSjmhnIksEpTFmKWJv/MJU6i7rBP3ro8n5ZWTABt3BpeqEUny0kpxjYTVNCVFSXkFzBjmuImLkdZ33eOtRULDuZXFLoAw8t+EidKbX43C7RL/leV3YhxD2w6swZOzcToNIK6NmoY/RAFfyGcWQ4jeGY4sxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628253; c=relaxed/simple;
	bh=tzXkCv3Dxtcb/gM98yhByyiqamfOlOYCxInZgpUs6Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I12Jag7kl39S3TbnEBL5GM+y1ww8tpOZ41QwfwWbthMX2Gr5vb5vS5UZBhWeNUgYQjf9aU6gOr1u+VF3xTBYRz3+3hUe5AgUkV86Dj6Nm0MRYFODmMYNh1jtzMyVapg8gbLXUH93jHpKS14JRx34BUoyRlPxkaX/2595qIdbiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsAsQXQF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740628252; x=1772164252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tzXkCv3Dxtcb/gM98yhByyiqamfOlOYCxInZgpUs6Jg=;
  b=KsAsQXQF4CwEqYc2IsZNgr2MPB1tcmk0nzBdJwpYpePnOeMa8y/23Vtu
   IulRwBaKzeyRVucIb/6Akx9ae73RSA+v3oag4TD/RYeL6nb+Vwz1hoaPe
   5TpsQTuvWsKCVAqKuTMNEIoFJvT1ZiOtj92Ny+fPafqNbGutC2VVNsVUB
   mqVEA8EPH5zUCNZ7RHAgR6rtaYE7Lrtd0nVO90KOsURcCYkcAa4Kus0B9
   wYaTYtAEHvpnvbpRzWnRDj85Xz3DlZ8pfUAlP2g4tw+h6pOr4mjjFIjXm
   k/fDZEpNL+2uFH4S71FlEO3Ib5O7NpnzpeQH/eOX5FIVblmB0AEAiYXsq
   g==;
X-CSE-ConnectionGUID: nEZnvG9GQ/yHbNJEW4ChSw==
X-CSE-MsgGUID: ew8hwnaBRKKkCN4sdPTEgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41633836"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41633836"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:50:51 -0800
X-CSE-ConnectionGUID: 7A8JQ9ACTDW8Hh+zXrkSig==
X-CSE-MsgGUID: u06h+CAUTY+ZgmKusSaL0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117542095"
Received: from unknown (HELO desk) ([10.125.145.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:50:50 -0800
Date: Wed, 26 Feb 2025 19:50:38 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250227034813.booxbhxnff66dnqx@desk>
References: <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227012329.vbwdmihjlqu6h5da@jpoimboe>

On Wed, Feb 26, 2025 at 05:23:29PM -0800, Josh Poimboeuf wrote:
> On Wed, Feb 26, 2025 at 04:35:28PM -0800, Pawan Gupta wrote:
> > On Wed, Feb 26, 2025 at 03:44:40PM -0800, Josh Poimboeuf wrote:
> > > On Wed, Feb 26, 2025 at 02:13:24PM -0800, Pawan Gupta wrote:
> > > > On Wed, Feb 26, 2025 at 09:03:58PM +0000, Kaplan, David wrote:
> > > > > > Extending =auto to take attack vectors is going to be tricky, because it already
> > > > > > takes ",nosmt" which would conflict with ",no_cross_thread".
> > > > > >
> > > > > > How about we keep =off, and =auto as is, and add:
> > > > > >
> > > > > >   mitigations=selective,no_user_kernel,no_cross_thread,...
> > > > > >
> > > > > > Requiring the user to explicitly select attack vectors to disable (rather than to
> > > > > > enable). This would be more verbose, but it would be clear that the user is explicitly
> > > > > > selecting attack vectors to disable. Also, if a new attack vector gets added in future,
> > > > > > it would be mitigated by default, without requiring the world to change their cmdline.
> > > > > 
> > > > > I kind of like that.
> > > 
> > > While it might be true that we don't necessarily need both opt-in and
> > > opt-out options...
> > > 
> > > I'm missing the point of the "selective" thing vs just
> > > "auto,no_whatever"?
> > 
> > That was my first thought, but then I realized that in "auto,nosmt" nosmt
> > is the opposite of disabling the mitigation. It would be cleaner to have
> > "=selective,no_whatever" which is self-explanatory.
> 
> The "auto,nosmt,no_whatever" is indeed a bit confusing because of the
> opposite meanings of the word "no", but least it sort of makes some
> kind of sense if you consider the existing "auto,nosmt" option to be the
> starting point.
> 
> And we could document it from that perspective: start with "auto" or
> "auto,smt" and then optionally append the ",no_*" options for the vectors
> you want to disable.
>
> IMO "selective" doesn't seem very self-explanatory, it says nothing to
> indicate "opting out of defaults", in fact it sounds to me more like
> opting in.  At least with "auto,no_whatever" it's more clear that it
> starts with the defaults and subtracts from there.

Thats fair. I certainly don't want to be adding new option if we are
willing to live with some minor quirks with auto,nosmt.

Like, should the order in which nosmt appears after =auto matter? IOW,
"=auto,no_foo,nosmt" would be equivalent to "=auto,nosmt,no_foo"? I believe
they should be treated the same.

Arches that don't support attack vectors, but support smt, should treat
"=auto,no_foo,nosmt" as "=auto,nosmt".

So as to treat nosmt as any other attack vector, CPU_MITIGATIONS_AUTO_NOSMT
should go away. I am thinking we can modify cpu_mitigations_auto_nosmt() to
check for smt attack vector:

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b605334f8ee6..6ddbee6a0b6b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3193,22 +3193,27 @@ void __init boot_cpu_hotplug_init(void)
 enum cpu_mitigations {
 	CPU_MITIGATIONS_OFF,
 	CPU_MITIGATIONS_AUTO,
-	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
+#define MITIGATE_SMT            BIT(0)
+#define MITIGATE_USER_KERNEL    BIT(1)
+#define MITIGATE_USER_USER      BIT(2)
+#define MITIGATE_GUEST_HOST     BIT(3)
+
 static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
+static unsigned int cpu_attack_vectors __ro_after_init = ~0;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
-	if (!strcmp(arg, "off"))
+	if (!strcmp(arg, "off")) {
 		cpu_mitigations = CPU_MITIGATIONS_OFF;
-	else if (!strcmp(arg, "auto"))
+	} else if (strstr(arg, "auto")) {
 		cpu_mitigations = CPU_MITIGATIONS_AUTO;
-	else if (!strcmp(arg, "auto,nosmt"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
-	else
+		cpu_attack_vectors = parse_cpu_attack_vectors(arg);
+	} else {
 		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
 			arg);
+	}
 
 	return 0;
 }
@@ -3223,7 +3228,7 @@ EXPORT_SYMBOL_GPL(cpu_mitigations_off);
 /* mitigations=auto,nosmt */
 bool cpu_mitigations_auto_nosmt(void)
 {
-	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
+	return (cpu_mitigations == CPU_MITIGATIONS_AUTO) && (cpu_attack_vectors & MITIGATE_SMT);
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
 #else

