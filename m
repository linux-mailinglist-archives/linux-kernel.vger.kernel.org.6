Return-Path: <linux-kernel+bounces-543700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB3A4D8BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69C017324D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BB1FDA92;
	Tue,  4 Mar 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx/eSIfE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD41F4CAD;
	Tue,  4 Mar 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080949; cv=none; b=ASN8ZK8FeF+JnNosaddbM1OtIgl0zNljRRxaZWhj/saLHXxv4HnoPieytwU+XWdUqcO2J7b1amoMC5EvJOWlVEuWqRT7GsFEFAXfnly9vwnEHJsbb6IpSC6fF27fhV4GNJRDjDD60ecgbRtR89YtFvs5d70jQJA1MIsNB0j8rsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080949; c=relaxed/simple;
	bh=OOxTMSOg7lRj8PaiKENPOz3rSc2lIXFyPelO8yUfKIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMvCUtx726T+Y0hKfUaExPYdf6TF+6s/yEGk6I9WAU9duStlJuuSoORjMJZ1n/RVHzM8c0n72sS5RFbQvpm0T8/DozQcqIXi6pQZoNtGWYCHyNYDfyv3pxujND18q6VJ9stbPqMT+dPVcce4CWiJF9pUbsDrCUTMmnOJGND0Uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx/eSIfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D46C4CEE5;
	Tue,  4 Mar 2025 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741080948;
	bh=OOxTMSOg7lRj8PaiKENPOz3rSc2lIXFyPelO8yUfKIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kx/eSIfEYTqyJ0J8k+nF8/AEbXCGGF2GV0OgRGwjE6bFMz0IzMwoPLLUqXfkYkSxN
	 MMUrBP4GuClisHs1i/tiOJG16n9DwkyUEzdC4VIRZ0AXMQgZhEaPaQBQ7LsYuD0T0A
	 yXdleayg3eRqdb5eZo+GCvFM8e83W3XkAwgki5wz3jr4idNcjThBFcDejw8QUYCX0d
	 WNsRqNiKFNlRPhY5jPFu8ucdXjfcIlEuUXyvAiQR32zr4qZuizqsn1+4S7kXigthfS
	 7X0yeRcXJMbsDwwpO0yM87YZZ6O9pkq5lOPiJ1vfOt3mfz1zmZDYjzG5bzJllzEQIS
	 q5tQDkUx9ugyw==
Date: Tue, 4 Mar 2025 10:35:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 30/40] sizes.h: Cover all possible x86 cpu cache sizes
Message-ID: <Z8bJb_NKdIh8jQkt@gmail.com>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-31-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304085152.51092-31-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> Add size macros for 24/192/384 Kilobyes and 3/6/12/18/24 Megabytes.
> 
> With that, the x86 subsystem can avoid locally defining its own macros
> for CPU cache sizs.

Please take some time to read your own changelogs:

 s/Kilobyes
  /Kilobytes

 s/sizs
  /sizes

 s/cpu
  /CPU

Thanks,

	Ingo

