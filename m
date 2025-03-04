Return-Path: <linux-kernel+bounces-543750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9BA4D95C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B207A543E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8691FCFE6;
	Tue,  4 Mar 2025 09:54:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931E51FCFDB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082080; cv=none; b=lEUT97CAc50Xu5Fms1vSYwpYwSiGdgHtWyOwD3tA83XyLpSeVqkOGSwV7euhDfjiSH6Uf3ko4n9GvkARb7wFOkggiQuJjBlgnkIC7Zp7sgIZKRGro6qe6XlmKPi/2OUdBgb6clYcsnBthpkdB45qHxhlYQJuTKCvVWIxgg4oPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082080; c=relaxed/simple;
	bh=aAAx0WCfVD9Yht0Hjqf+5lQdm3MbQGouHvs42YNXPAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANtvmURu1ah1OxKaPXadOVwtY8SWzUHUpWpd4mjSplZz628FvgOJJ188y4nNhOKc6Haa1zEqYlyh5x3/nI+ovpGpA5COlI4QGi4w/GfZ3f128YkWkjO6MJRIZSORhvZkeNNLz/Dvbz/xl8U83f9N4d+S4O7gqMPcMJwbNWVW24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EBE9FEC;
	Tue,  4 Mar 2025 01:54:51 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 676D93F5A1;
	Tue,  4 Mar 2025 01:54:35 -0800 (PST)
Date: Tue, 4 Mar 2025 09:54:32 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Sebastian Ene <sebastianene@google.com>,
	Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
	joey.gouly@arm.com, oliver.upton@linux.dev, snehalreddy@google.com,
	suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/4] KVM: arm64: Move the ffa_to_linux definition to
 the ffa header
Message-ID: <Z8bN2MI5GYdVtGyE@bogus>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-3-sebastianene@google.com>
 <20250227202557.d3fd6ylzbaho4pvx@bogus>
 <Z8DxZY-09R6lwEW3@google.com>
 <86wmdapei8.wl-maz@kernel.org>
 <20250303234426.GB30749@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303234426.GB30749@willie-the-truck>

On Mon, Mar 03, 2025 at 11:44:28PM +0000, Will Deacon wrote:
> On Fri, Feb 28, 2025 at 10:09:19AM +0000, Marc Zyngier wrote:
> > On Thu, 27 Feb 2025 23:12:37 +0000,
> > Sebastian Ene <sebastianene@google.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 08:25:57PM +0000, Sudeep Holla wrote:
> > > > On Thu, Feb 27, 2025 at 06:17:47PM +0000, Sebastian Ene wrote:
> > > > > Keep the ffa_to_linux error map in the header and move it away
> > > > > from the arm ffa driver to make it accessible for other components.
> > > >
> > > > Do you plan to push/target these changes for v6.15 ? If not, I can take
> > > > this patch with other FF-A changes in my tree for v6.15. Otherwise, it
> > > > is must go along with other changes.
> > > >
> > >
> > > Yes, feel free to pick them with your changes and we can push them
> > > later.
> >
> > So this series is not a 6.15 candidate?
>
> I think this is 6.15 stuff once it's been reviewed. Sudeep's message is
> a little confusing as it refers to 6.15 twice (I guess he meant 6.14 the
> first time?).
>

No I meant v6.15 both times 😉. Since not much time before v6.15, I was
thinking if this is not v6.15 material, I can just take the driver change
for v6.15 itself via my tree. Now that, you have clarified, I will leave
it to you. I think it doesn't conflict with any of driver changes in -next.

In short, just to avoid any further confusion, please take it via arm64/kvm
tree.

--
Regards,
Sudeep

