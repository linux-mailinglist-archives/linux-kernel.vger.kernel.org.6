Return-Path: <linux-kernel+bounces-189615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D1B8CF2F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB69C28185C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D618F5B;
	Sun, 26 May 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BiosjQv3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FE6FD3;
	Sun, 26 May 2024 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714397; cv=none; b=j9qbnzjd/cYZioslyPuTltBVL7xd30HiMYaFptsD4SqgD0kZHcjcDID282uuQPuv+Ce09PbT3k3R/eOunaVWSNYvN0lMD05NETyVrzN69PerebtAqD3GWDDZocTAUPGx6DBHgdYLFpOvBdAMZVGE6uh/E8f/371cVKDYzzzQplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714397; c=relaxed/simple;
	bh=RzF9fiVi1OhH+C39PKj+ZVf1/6bD59OxZmO8t9FhR8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiJPtrQ+7mj0rgmdTCaMuT3x58w+WdZVlYafldgLZ3RyvGXhpkNKVXUn4y6depsL+BhFsUt5n61EvuZxMejIjgLxN/w/F8Av6DcJlqJycIlmQTl8tba1yjx9pSKnUt5rzrFEPUntXQXoTJdRfwdNYye/6UKaL60+lStQO+YLQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BiosjQv3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C66940E016A;
	Sun, 26 May 2024 09:06:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Dk9wYavNe0pk; Sun, 26 May 2024 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716714381; bh=zedgAlxO21oymFWocT8Z0a1YC46yYpVIHt+BQbWlsm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiosjQv3CgKP7BO3GoueBe5N4EemSuxztQUHJYn97cnD8nm/6yMG+RUtS65yPGfLQ
	 4NLJx1yuIFj+xNd+kAB/v7t0pIGsW2UAR127P0ei/YQUssKXFvHTfBnymO9RrWgzwt
	 2NKp5e9QIhjKh2guIAPKBPu6tl4E4ig14hzZaIEB6pO05JRgUKOVTKahDmGimmNKZP
	 FSxcykzWS8TZtEG9XxYgLhzX93OKB8EcKhSIcrl4HkhvB3f8xoQpsLHzOjby+KcWLN
	 EE3NBzutPK2sjdV62SuG0faw+L4ai6ttxJ2yAWmT+t4WFUFijwDmXt2EwIl/yUlEnl
	 sCCrKnWaZDx8P1HrswavzFY7uD1+0D6M9KBh9lODQ3SAkctr3kdrR2f8JYDjny51Zr
	 6VBu2/+5guWTsmvaMJgF9pbGkeos47H14qxCZ/517birhB/8sbCvuEtdW+lQeNjcil
	 fAYhq6agtfwbATm5fBWpkJCChTOiEVRHUukrTdcjYYyVQkIUL9Y/oDnmpO2RyX3HSH
	 c4pkFNSxOSSGkNrtzvE6BEz7rz+iFfC0p89hHOpTatcPLbfbaACfAchp3KboI11tVQ
	 EdyzEqpcei2VXqSdiz45rF3N4vPQ4zJYR0KUqq+RUbIuerWwfi63Ra6Jd8kKqWYcU3
	 y0aey59Vkzlo3Lt2vfM6HiYQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DE0F40E01A1;
	Sun, 26 May 2024 09:06:01 +0000 (UTC)
Date: Sun, 26 May 2024 11:05:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Balasubrmanian, Vignesh" <vigbalas@amd.com>
Cc: "Balasubrmanian, Vignesh" <Vignesh.Balasubrmanian@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"George, Jini Susan" <JiniSusan.George@amd.com>,
	"matz@suse.de" <matz@suse.de>,
	"binutils@sourceware.org" <binutils@sourceware.org>,
	"jhb@FreeBSD.org" <jhb@freebsd.org>,
	"felix.willgerodt@intel.com" <felix.willgerodt@intel.com>
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <20240526090554.GAZlL7cpva88mMUbCK@fat_crate.local>
References: <87wmo4o3r4.ffs@tglx>
 <4a090901-9705-40aa-ac3d-d67c52660f22@amd.com>
 <20240522153433.GCZk4QiX4Hf0OuI48E@fat_crate.local>
 <902b1bf0-15e6-42df-8f86-21387deef437@amd.com>
 <20240523144543.GDZk9WlwKpCKx8I3RE@fat_crate.local>
 <664e101b-3689-4876-825b-a5aa12b7978f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <664e101b-3689-4876-825b-a5aa12b7978f@amd.com>

On Sun, May 26, 2024 at 10:24:41AM +0530, Balasubrmanian, Vignesh wrote:
> If we can add a new enum only when we extend, then as Thomas suggested can
> we use other kernel variables as in the first version of the patch until we
> extend for other/new features?

I assume by "other kernel variables" you mean CPUID?

If so, can you change the layout of your buffer once you export it to
userspace?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

