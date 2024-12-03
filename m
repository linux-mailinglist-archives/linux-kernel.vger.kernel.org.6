Return-Path: <linux-kernel+bounces-428658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E29E11DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA2281B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27015E5B8;
	Tue,  3 Dec 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UylGswjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FA1FC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196975; cv=none; b=PJE1xSPid+Re5jeJGrBl6nDn36vCHw2VLeEjmI36gf7botwHVy++Yx4RlnArF6k4Qvf+hh07LP8VduNc0bYe11yvFMM0fAbQji8+TLFpZPBDRMXnWgix+IPl8sgHf2/GSFueyb0hFdHPLjJb8d/rsF7oHnu11+tcpZzJrux7JaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196975; c=relaxed/simple;
	bh=SuvRh8cTgeUfkOy/wnjMzHP5FKz/STUzNHwd6uyGmoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmn2rfx54+iZg6ESzJ020ArSVN2WjJW3zRV2v8xmzWp9rAnsI/+e839hP4WeEghKJVtFJppOykCKQJOT/T5C1LLvlzGmRT5LeOhMkZhmSIPRiEpGo6VYFqm74P5V4JeyNbk1WGVObLkGupRqLGQp7VZi8BqsZN0ItZ4cQZ5zwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UylGswjl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733196971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWgn1koTIhFjwdGJMPZtVVEcZuDRaXD/BsEJEEH7EyE=;
	b=UylGswjlWHtiXHRjI17ZgFJycTLfuwFlztUvWlSFc/aP03uvUcKyBvgSx2D4g8UmayHjPj
	4zt3O70KkUJd8yS0BM/8znhUSyUfH5kviZHfQ10TGK1OuOfbflqJnsTfafFMtoyYymMTZ2
	CYCS/6YT2XKWtkj/Kw2lTfq+j2k9m/4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-L7PnmFm1OSaxh2aoamRGMA-1; Mon,
 02 Dec 2024 22:36:08 -0500
X-MC-Unique: L7PnmFm1OSaxh2aoamRGMA-1
X-Mimecast-MFC-AGG-ID: L7PnmFm1OSaxh2aoamRGMA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 212991955E80;
	Tue,  3 Dec 2024 03:36:07 +0000 (UTC)
Received: from fedora (unknown [10.72.112.177])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88AEE30001A0;
	Tue,  3 Dec 2024 03:36:02 +0000 (UTC)
Date: Tue, 3 Dec 2024 11:35:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: resctrl mount fail on v6.13-rc1
Message-ID: <Z058nbqa2S68-28e@fedora>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z05xSqIeNeHh19MZ@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z05xSqIeNeHh19MZ@agluck-desk3>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Dec 02, 2024 at 06:47:38PM -0800, Luck, Tony wrote:
> On Mon, Dec 02, 2024 at 02:26:48PM -0800, Reinette Chatre wrote:
> > Hi Tony,
> > 
> > On 12/2/24 1:42 PM, Luck, Tony wrote:
> > > Anyone better a decoding lockdep dumps then me make sense of this?
> > > 
> > > All I did was build v6.13-rc1 with (among others)
> > > 
> > > CONFIG_PROVE_LOCKING=y
> > > CONFIG_PROVE_RAW_LOCK_NESTING=y
> > > CONFIG_PROVE_RCU=y
> > > 
> > > and then mount the resctrl filesystem:
> > > 
> > > $ sudo mount -t resctrl resctrl /sys/fs/resctrl

[linux]# make -C tools/testing/selftests TARGETS=resctrl run_tests
make: Entering directory '/root/git/linux/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..1
# timeout set to 120
# selftests: resctrl: resctrl_tests
# TAP version 13
# # Fail: Check kernel supports resctrl filesystem
# 1..0 # SKIP resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.
ok 1 selftests: resctrl: resctrl_tests # SKIP
make: Leaving directory '/root/git/linux/tools/testing/selftests'

[linux]# grep X86_CPU_RESCTRL .config
CONFIG_X86_CPU_RESCTRL=y

Can you share how to make /sys/fs/resctrl so that I can check if the
recent changes in block tree can avoid this warning? 

> > > 
> > > There are only trivial changes to the resctrl code between
> > > v6.12 (which works) and v6.13-rc1:
> > > 
> > > $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
> > > 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > > 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
> > > 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
> > > 
> > > So something in kernfs? Or the way resctrl uses kernfs?
> > 
> > I am not seeing this but that may be because I am not testing with
> > selinux enabled. My test kernel has:
> > # CONFIG_SECURITY_SELINUX is not set
> > 
> > I am also not running with any btrfs filesystems. 
> > 
> > Is this your usual setup in which you are seeing this the first time? Is it
> > perhaps possible for you to bisect?
> 
> Bisection says:
> 
> $ git bisect bad
> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Oct 25 08:37:20 2024 +0800
> 
>     block: model freeze & enter queue as lock for supporting lockdep
> 
> > 
> > The subject states "resctrl mount fail" - could you please confirm if
> > resctrl cannot be mounted in addition to the lockdep warning?

It seems one lockdep false positive, but it shouldn't cause 'resctrl
mount fail', I will take a look at the lock chains and see if some of
them can be cut.


Thanks,
Ming


