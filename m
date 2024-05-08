Return-Path: <linux-kernel+bounces-172718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878118BF5C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97AC1C22EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27EE179AF;
	Wed,  8 May 2024 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfKigFzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED2171B0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147748; cv=none; b=WnqIHMzzLOBlpbw50YYPQ9p0s5WsT7cgzICZyYzgN8IRn+4EoiAzYBKT/PZOl75ME/QdMj3VTVRceiw3d6KpSHid8c+xBF7DeHAm8u6T/u9Z95sVOujQeJSRBDB0OuAOaprJgttJydivP0qKKwkZXY0BTsR9T3cJRsv1Sme3F8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147748; c=relaxed/simple;
	bh=9YJ4ItsN3hjrsW/K8yCf69qg1uB1he350g1oi/io63c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIaJDssweDN3/91HDJR6kIwR6nVtUeRq+A8pKMr8vCwYtUTePlpw5crhDhcdPNKwQek209w+U+R22G34z1HNEMxC4hoG6aObLtu1Wi8LJXnVx/Y41hExvXNQyEWEm3Joo084vBRAqY8FcfEgdbiem7ioqXlDCuffPhHIWDqoXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfKigFzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091BDC113CC;
	Wed,  8 May 2024 05:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715147747;
	bh=9YJ4ItsN3hjrsW/K8yCf69qg1uB1he350g1oi/io63c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfKigFzLDTwhTj6bFuleDfnO1Iccp1SD3JqxhbkSaPbpt39peuDA7EegDtvGdzr3O
	 g7Whbdcf/0kfJ8Gva5irrESFJ4SKHNz90FHAU4b99dGicwvm5sBnwy/cxupI6yW3xh
	 gGVrLw+MNCtaRDebURgwAFGrqB6+TqugybucPTMuqjguJE7zV9aLteGjTd9PdKqXDN
	 ikcwQ/d89Z6GnDcO/iM0o+O1+VA0fbAUYq/ZAsQFcJkBTKWtTm8rFg6HW2YSp7XFj8
	 /UsUARfcWb9hTdAljsoP81PP4ehYCKjupWH0Hq2x49MAfEoo5mJ9ahJsuHhbh4c4H7
	 H3lIWntyCFWgw==
Date: Tue, 7 May 2024 22:55:45 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bugs: Remove duplicate Spectre cmdline option
 descriptions
Message-ID: <20240508055545.eix25ok3wvv6gcpg@treble>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <cdfe36cf9c8b6cd98eb0f32b798d5af1af95cb2c.1715059256.git.jpoimboe@kernel.org>
 <d0079f0c-3be8-484b-9c67-f08d6a1fb31e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0079f0c-3be8-484b-9c67-f08d6a1fb31e@linux.intel.com>

On Tue, May 07, 2024 at 08:04:37AM -0700, Daniel Sneddon wrote:
> I love the idea here, but
> 
> >  	nospectre_v2
> > +	spectre_v2={option}
> > +	spectre_v2_user={option}
> > +	spectre_bhi={option}
> >  
> 
> this comes out as just a single line when I run make htmldocs.

Thanks, the below turns it into a bulleted list:

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index f9797ab6b38f..132e0bc6007e 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -598,11 +598,11 @@ current CPU.
 Spectre default mitigations can be disabled or changed at the kernel
 command line with the following options:
 
-	nospectre_v1
-	nospectre_v2
-	spectre_v2={option}
-	spectre_v2_user={option}
-	spectre_bhi={option}
+	- nospectre_v1
+	- nospectre_v2
+	- spectre_v2={option}
+	- spectre_v2_user={option}
+	- spectre_bhi={option}
 
 For more details on the available options, refer to Documentation/admin-guide/kernel-parameters.txt
 

