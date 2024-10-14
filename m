Return-Path: <linux-kernel+bounces-364363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D199D3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A173B29CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0B1C3300;
	Mon, 14 Oct 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JDLV34J3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71401AA7AB;
	Mon, 14 Oct 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920480; cv=none; b=EPpIRUK2QC46rcYSK0YRhzerTO2wxyaL8fhQkjf0JCXi4pke9LLU4BoaNlS+pdLghGBZT4F8vpwhTESUTU5xfa7BqvodBEBXcrjINpj5SD8L98iefUNi+sEnoHq03KK0/cfGzCVlwDnNJXgxEbCVQTCVqtYHQbIZbvHNVtCJros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920480; c=relaxed/simple;
	bh=Vhgb8HMcP+PGqhPkFegSOhv2Wf5gbgeyjQgtSM6OTEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmI40gFTKbLdINwksZoS4/+JDrdsdXdnf5ZoS4TxDv+hNxvQXror2XkUDd/LZUV4CcJCX+28dE6e61p3EEmkJDiPWYymvzr5bKJJeLAJO/+Ag2C03BQKrAWpWx1LY2nMTz8+wAM2Cp4zPXEfBqJ+xc/R/9QSfI4+houkwxQKIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JDLV34J3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6A6C940E0184;
	Mon, 14 Oct 2024 15:41:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ROeAZSAksAB9; Mon, 14 Oct 2024 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728920461; bh=ulyFKHLbKKWql3gjmvQlmgr4sV9sT8AjEfj6klpUj7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDLV34J34UL0GOpZpy+5BIq+LUf+XsSDN/Gh4QVWEotlXBjKg8S2vYbApWUv0EShp
	 6AP7wScRwVZfSAAd7Uy+RpUv7WJEwDKLgpBFKZkQjKaN847OnZNUNrdNcDy6yptIcn
	 3Fm8FXPmOGJOmevw81DijFG++8//pTNHDAdOGrBIo3zdAqdJgPQ84GK+4B745FSCru
	 850Y2qeHJ2MELZ5F6CAJ0M+lyM4OxNRf0LNOGDG6ec2Zj1EOJUfvMcqEleYZZK/mfK
	 WZcpBMTEtglqvfD9wwH6PvLDaN6HIe+EDmhTNa8tr/6+a435BcwPFiKzKQd1GcFfyv
	 7qWRsoS1Z483mAkjdSNywf91ZI0HEm0Y5jK9PG9z4OP1rmBsUTmKa7sYafJzJ5vAeC
	 YSerfZNzmaH2vIBvUxQdTK6GUgvi0NYb+ndKO7YPYb0RxeceOW5NSYekDIoggTof98
	 oSk81MWKE99UnzSe4AZSa9UeEuBNNy6Gv9mnjRrDxPJZy99y3yX6AXos0rOKZjFIsD
	 JIlyUF6eHGitBcswlA2y8bkce7pRQQgyso95AVGEe9c1hGz/fq9SV5wcZoAu5s31/x
	 8tP34fgTQoVonYG5xlmj74bSzvJBrQjwIpKCDwsyvuDWzQIeAryjDs4MgGdYg3B+mJ
	 h4UDk1DO+qDeeaGDEevlrNXE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D64F240E0198;
	Mon, 14 Oct 2024 15:40:46 +0000 (UTC)
Date: Mon, 14 Oct 2024 17:40:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dhaval Giani <dhaval.giani@amd.com>
Subject: Re: [PATCH v7 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev
 kernel command line
Message-ID: <20241014154040.GBZw07eBVDJoLJZV0w@fat_crate.local>
References: <20241014130948.1476946-1-papaluri@amd.com>
 <20241014130948.1476946-3-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014130948.1476946-3-papaluri@amd.com>

On Mon, Oct 14, 2024 at 08:09:48AM -0500, Pavan Kumar Paluri wrote:
> @@ -25,6 +26,12 @@ static int __init init_sev_config(char *str)
>  			continue;
>  		}
>  
> +		if (!strcmp(s, "nosnp")) {
> +			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
> +			cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
> +			continue;
> +		}

Well, if it is a HV-only option, then it better be such:

@@ -25,6 +26,17 @@ static int __init init_sev_config(char *str)
 			continue;
 		}
 
+		if (!strcmp(s, "nosnp")) {
+			if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+				setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+				cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
+				continue;
+			} else {
+				goto warn;
+			}
+		}
+
+warn:
 		pr_info("SEV command-line option '%s' was not recognized\n", s);
 	}
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

