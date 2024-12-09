Return-Path: <linux-kernel+bounces-437947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65A9E9AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C3A164321
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9E126C05;
	Mon,  9 Dec 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXQOK1q+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DD25777;
	Mon,  9 Dec 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759267; cv=none; b=S4CWokffjOkgc4TDohrk6SAlCa9JmhDyte0zJ//rIiYQ4Z/oZPzp/Yq5mWUhMeOFY5M3lMoLq8xwVC+YEEO5oUr8JQajBdg40O/yqtUeU1+b+K+gIpZLSTP57Gk3iDv83lCryU/GpD1LgPzCShIF0B4rUQ5yuAVlq/Bg5YFeEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759267; c=relaxed/simple;
	bh=FEBLVkJCejaLE7938I3Gu6xCK/EAcxorKDJdglc/4jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7Jo0PADtgo5WW8Zjs+TZHiJ5cQI4FTIF5HJ1d7YWGl+5DsL/Ud+Tz8Kwr/EmcUPfHu0jtZG33hAPVTIZwDULOb2uVLzY0tXQLi/ggy3UUGw4JkWD/0AwOBxcpHIvlpZ8/q9KHPznIpAc9B/K+r8n7RQlYgIudjkvnQ9zwuYCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXQOK1q+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733759266; x=1765295266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEBLVkJCejaLE7938I3Gu6xCK/EAcxorKDJdglc/4jw=;
  b=dXQOK1q+M6Bar/CzxF3JoljjJnbfrIOK2hb7fL+zaAADBsNITUZe9E9L
   ya6F0ADk4jV0pG5uwlddZMPEQCRrNj178Ji6PalkpF72H+ctYbMSJNMqp
   ZP6oKJe4DYpTYEChSmiDyIhsecF76EMIwTwT7bNljKgspNQs58n47MoZZ
   PYvnf/g2tszkNn1TYPIS8WzR2gSWSP4kPXJwL7ip6vzeFoOLxTkewNLXi
   zJMIRhlLd/SiXsGexE6WyZJ8oruqt0s5E1oTi1BfuXOuMbE2FCjJ57XXi
   F7fDJh6Tlgz4xOCv/U7DSpxAqCGTlYd6zEBaMT2MhDJdISALh7OAZSj1n
   Q==;
X-CSE-ConnectionGUID: zepPbiN6T2iDYmr3XyO+Ng==
X-CSE-MsgGUID: OaBEtryNQhyx7wiz70APjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33797495"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33797495"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 07:47:45 -0800
X-CSE-ConnectionGUID: Rp35BmE8T+edm7vXl2WzMA==
X-CSE-MsgGUID: wffdhlVTSb+c1Y7ImF7rog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="132483851"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 09 Dec 2024 07:47:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B980D44B; Mon, 09 Dec 2024 17:47:41 +0200 (EET)
Date: Mon, 9 Dec 2024 17:47:41 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] thunderbolt: Don't display retimers unless nvm was
 initialized
Message-ID: <20241209154741.GM4955@black.fi.intel.com>
References: <20241206183318.1701180-1-superm1@kernel.org>
 <20241209062415.GG4955@black.fi.intel.com>
 <c40bed54-63e9-4535-b17b-fba980f19382@kernel.org>
 <20241209154013.GK4955@black.fi.intel.com>
 <4314e730-0852-47e9-8431-f9ec648f4bff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4314e730-0852-47e9-8431-f9ec648f4bff@kernel.org>

On Mon, Dec 09, 2024 at 09:44:43AM -0600, Mario Limonciello wrote:
> On 12/9/2024 09:40, Mika Westerberg wrote:
> > On Mon, Dec 09, 2024 at 08:15:16AM -0600, Mario Limonciello wrote:
> > > On 12/9/2024 00:24, Mika Westerberg wrote:
> > > > Hi Mario,
> > > > 
> > > > On Fri, Dec 06, 2024 at 12:33:18PM -0600, Mario Limonciello wrote:
> > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > 
> > > > > The read will never succeed if nvm wasn't initialized.
> > > > 
> > > > Okay but we would need to understand why it was not initialized in the
> > > > first place?
> > > 
> > > Oh sorry I should have included that/
> > > 
> > > https://gist.github.com/superm1/c3763840fefa54298258a6fbec399007
> > > 
> > > As you can see it's an unknown retimer NVM format.  So this ends up down the
> > > path of "NVM upgrade disabled".  So that's why I'm thinking the visibility
> > > is the right move to adjust here (IE this patch).
> > 
> > This is actually on-board retimer of the AMD platform:
> 
> Oh, good point.
> 
> > 
> > Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: retimer NVM format of vendor 0x7fea unknown
> > Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: NVM upgrade disabled
> > Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: new retimer found, vendor=0x7fea device=0x1032
> > 
> > I would think you guys want to make it upgradeable as well, no?
> 
> For AMD platforms retimers are nominally upgraded by the platform's BIOS
> upgrade, there haven't been asks from anyone to upgrade in AFAIK OS (Windows
> or Linux).

Right, until Chrome wants it and also a way to do that with no active
connection ;-)

> > > > I see this is ThinkPad Thunderbolt 4 Dock so probably Intel hardware? You
> > > > say you can reproduce this too so can you send me full dmesg with
> > > > thunderbolt dynamic debugging enabled? I would like to understand this bit
> > > > more deeper before we add any workarounds.
> > > > 
> > > > > Reported-by: Richard Hughes <hughsient@gmail.com>
> > > > > Closes: https://github.com/fwupd/fwupd/issues/8200
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > ---
> > > > >    drivers/thunderbolt/retimer.c | 17 ++++++++++++++---
> > > > >    1 file changed, 14 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
> > > > > index 89d2919d0193e..7be435aee7217 100644
> > > > > --- a/drivers/thunderbolt/retimer.c
> > > > > +++ b/drivers/thunderbolt/retimer.c
> > > > > @@ -321,9 +321,7 @@ static ssize_t nvm_version_show(struct device *dev,
> > > > >    	if (!mutex_trylock(&rt->tb->lock))
> > > > >    		return restart_syscall();
> > > > > -	if (!rt->nvm)
> > > > > -		ret = -EAGAIN;
> > 
> > This is actually here because it might take some time for the NVM to be
> > available after the upgrade so changing this may cause issues on its own.
> > 
> > Instead we should check first the
> > 
> > 	rt->no_nvm_upgrade
> > 
> > and return -EOPNOTSUPP which I believe fwupd handles?
> > 
> 
> Well I don't think it's right to export the sysfs file in the first place if
> we "know" it's not going to work.  That's disingenuous to software.
> 
> How about looking for rt->no_nvm_upgrade in the new retimer_is_visible?
> 
> I think it should get the same intent and not break this retry logic.

Yeah, that sounds good to me.

> 
> > > > > -	else if (rt->no_nvm_upgrade)
> > > > > +	if (rt->no_nvm_upgrade)
> > > > >    		ret = -EOPNOTSUPP;
> > > > >    	else
> > > > >    		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
> > > > > @@ -342,6 +340,18 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
> > > > >    }
> > > > >    static DEVICE_ATTR_RO(vendor);
> > > > > +static umode_t retimer_is_visible(struct kobject *kobj,
> > > > > +				      struct attribute *attr, int n)
> > > > > +{
> > > > > +	struct device *dev = kobj_to_dev(kobj);
> > > > > +	struct tb_retimer *rt = tb_to_retimer(dev);
> > > > > +
> > > > > +	if (!rt->nvm)
> > > > > +		return 0;
> > > > > +	return attr->mode;
> > > > > +
> > > > > +}
> > > 
> > > I just noticed I had a spurious newline here.  If we end up taking this
> > > patch would you mind just fixing it up?  If there is other feedback I'll fix
> > > it on a v2.
> > > 
> > > > > +
> > > > >    static struct attribute *retimer_attrs[] = {
> > > > >    	&dev_attr_device.attr,
> > > > >    	&dev_attr_nvm_authenticate.attr,
> > > > > @@ -351,6 +361,7 @@ static struct attribute *retimer_attrs[] = {
> > > > >    };
> > > > >    static const struct attribute_group retimer_group = {
> > > > > +	.is_visible = retimer_is_visible,
> > > > >    	.attrs = retimer_attrs,
> > > > >    };
> > > > > -- 
> > > > > 2.43.0

