Return-Path: <linux-kernel+bounces-555165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E48A5A64B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF6B3AB2E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575D1E1C22;
	Mon, 10 Mar 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b0ChczpO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551B1DFFD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642491; cv=none; b=s2GDvxuwEcS4X2ZFcwxpb/e2aW2n2IwtGNOKWmLbkmsKE8EyAHGeluQasPTkBSatYr97i5WNAJrsKTt2+8ClDWWEGAnOePyvwDGrpWzoohPQyMi0XXK5nVvpNCEuk9C1qSFRy8Hm+JtWG5u1mDiOOIyIYJCy8J+1RuLD8NdW1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642491; c=relaxed/simple;
	bh=MlsvTgu2xdfwqY1n3brEBiV+89FAhscRgROi5u15lR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV3kK7s18wnjMPqDdjWVhRexrFNaRgGS6/DOtAhWZg5L9fVhvsbRppgWR0fPXHwzQned/+hA4iPspLQtyvi7uXB5dH0XZ/1FnOsUvFeseYU4+is0Ytmt7PnyiLmwXTeIRZFhbSsn2Dp8dVTCCSIrGdi8MHQDzGs1Ax00ZAg63c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b0ChczpO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8870040E0217;
	Mon, 10 Mar 2025 21:34:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6cDD1ejoWONO; Mon, 10 Mar 2025 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741642484; bh=Wuk/+RGFxhwalfrPZQEyinJaRDZUPzYHrzRIisv4kNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0ChczpO7EjZELxwXsCrhwV2VRIZsGYwYqX4i9jSWVB0keFWamQhcDueHBPJDVJkX
	 pND4LtsitniNEG8abeDDKT8oZr9sju1BoAMQPAvCApMKXZmsAbJIUGRLgqxdvSTLBW
	 9DixpxwFm7vh0pT3f752/CabQwbJZyPEZthQwqSxlOAr3pHngHiQ3+cA+phGBebgq1
	 6GI+QFO05qzE11c+qTlIRmeu+xP8GdEWhQVwYk+Ru9PgcOJneUFu3EbkZQTdvykBj3
	 q28sE2aYIJf8aY9qXxxXG9LJjlFmlDnKQ/iNkSBU/tkkPhcVOYVZq+fch2qNVYCSiT
	 XDQfPLog0R3vHkffXI8Y+LNnZaZ2tTfF+dkiHFl++/s2wxfyUBpMshmxozgnLhN1Rt
	 BzrKK1YP7Qz8T2Ydn5KL0dgAE9XPzIdH7EcJpGwp7pFHE8af4nzQDRKaj5SKr7I4Oq
	 GjwYqmsMhHlvpmCGjlESDI4/ZPt28Wloag2f4BVTsltBxr4kTqrGG63OsMyEkGwEcO
	 tnIJCQ52NYrIYvtQbI4GrCI1G/rsl78PNq33jl9is6ex6KY4iL4+Vm7TpdNfnn/CFg
	 Ig/gx0NpX0E/WmO4QCTVv7uedUL93IWs4sVlWzD0bXcEtODBTPxXe+oxR6RZSkmMiF
	 lsUWuBeU9gXpDYp//ESDfVqk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7D0A40E015D;
	Mon, 10 Mar 2025 21:34:36 +0000 (UTC)
Date: Mon, 10 Mar 2025 22:34:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <20250310213429.GAZ89a5bv2MK_N35mU@fat_crate.local>
References: <20250310200817.33581-1-ubizjak@gmail.com>
 <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
 <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
 <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local>
 <CAFULd4YwQ3dcRwugyr9-GUWbVh2cREu6qNQctKG2S5JpoEfQcg@mail.gmail.com>
 <20250310210753.GZZ89UqRTKo2OE4UOl@fat_crate.local>
 <CAFULd4Y=LMs0wWLwEg_WLoDeffo0T6cXhyBuWJVuSk4o_cNQOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4Y=LMs0wWLwEg_WLoDeffo0T6cXhyBuWJVuSk4o_cNQOA@mail.gmail.com>

On Mon, Mar 10, 2025 at 10:18:50PM +0100, Uros Bizjak wrote:
> a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> instruction from being scheduled by the compiler before the frame
> pointer gets set
> up by the containing function. This unconstrained scheduling might
> cause objtool to print a "call without frame pointer save/setup"
> warning.
> 
> would be ok?

Yes, and pls say something along the lines of: this is not a currently
triggered issue but it can potentially happen, so that it is perfectly clear
what this patch is addressing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

