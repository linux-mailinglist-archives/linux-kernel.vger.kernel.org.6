Return-Path: <linux-kernel+bounces-217828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B241A90B4D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2DF1C22C32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79AF1553A3;
	Mon, 17 Jun 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="MDODHCDt"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807269D3C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637125; cv=none; b=jt3OgGu77vu2bcxtbUsgh0sEpKkMQf/i9YWm9dsD8+8rs31yPu9TRHNT8Q+VrUo7fKfTfuCn+ubZ+xHb9vachN50kh8Sk0xMswDd8/kwyLTMFd1mmouOyNDu3o7+bz7qcpgtY7nxR61vaUKKFtNi3CGi6UPhIeYfAva79bjZdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637125; c=relaxed/simple;
	bh=dSpQHrvl4C9nuFdBFR8jTR9+qH/F/pXj/XpXZeaI1Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNmW/fiy45I1d1XxIsdf4YlKNjH9T4KJYgsI2yqxO2+JxPFjzHe5+is+AjNhvtAkecWwNH9/WFF1qr2vnWJO6CmPUsdK4yWMaLs+BnmTxJwBP8ToWtfyh+Xh8IvFDilMns3Mqh/bcUwPM8Pb5OjZJvJVfrz+stIHf0TmzXUUgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=MDODHCDt; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45HEs4IV017728;
	Mon, 17 Jun 2024 15:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc : content-type : date
 : from : in-reply-to : message-id : mime-version : references : subject :
 to; s=pps0720; bh=6Wt2QKNSGBX4X4tK7ech9zSO0dKYbN7hZGkSbLMy5F8=;
 b=MDODHCDtyzPF+fRIBEYf5p+3WDgle+JN1XwhNq3zEJEyAVf4HQJwpD7g2tuHg3Mn8na+
 rMq/b4NBCPYUzby+slhUxXAM5L9U9RopBbMwU4FDs+AUwNx/HQqT+1s+OjBl1cMROkLV
 q273emyZ25PUX24vaQQ//0J2DZm4aJymdVJS4+/EFBLes9gTYy76uOi56oIweHOR/ekg
 sgxASTKo2nwCB9XBNJQFlknMaRDOZwGXMrm6MmgO6RTKHCq7cxgjGnE/fhRe6kVg0Ty/
 unzOKYmD0FKGfnxuHKg1kE6GIP86eYDvhh70AU16vxtsQgg46G3vI00czeBPhC+sGYiD jA== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ytqaj849d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 15:10:41 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id B525C147AD;
	Mon, 17 Jun 2024 15:10:40 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 0A38A806B47;
	Mon, 17 Jun 2024 15:10:34 +0000 (UTC)
Date: Mon, 17 Jun 2024 10:10:32 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
        Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
X-Proofpoint-GUID: iXZ47Dexat143EyDeEs6H_lZNkPb6Hvy
X-Proofpoint-ORIG-GUID: iXZ47Dexat143EyDeEs6H_lZNkPb6Hvy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170117

On Sun, Jun 16, 2024 at 10:25:33PM +0200, Borislav Petkov wrote:
> On Thu, Jun 13, 2024 at 11:16:36AM -0500, Steve Wahl wrote:
> > The Atom was the prominent example of a platform that the code
> > introduced for SEV broke.  Unfortunately, the fix currently
> > implemented leaves things still broken for actual AMD SEV capable
> > processors when nogbpages is used,
> 
> Ok, how do I reproduce this?
> 
> Please give exact step-by-step directions.

The first, hardest step is locate a system that is AMD based, SEV
capable, with a BIOS that chooses to locate the CC_BLOB at addresses
that do not share a 2M page with other chunks of memory the kernel
currently adds to the kexec identity map.  I.e. This is a stroke of
luck, and for all I know could depend on configuration such as memory
size in addition to motherboard and BIOS version.  However, it does
not seem to change from boot to boot; as system that has the problem
seems to be consistent about it.

Second, boot linux including the "nogbpages" command line option.

Third, kexec -l <kernel image> --append=<command line options>
--initrd=<initrd>.

Fourth, kexec -e.

Systems that have this problem successfully kexec without the
"nogbpages" parameter, but fail and do a full reboot with the
"nogbpages" parameter.  

I wish I could be more exact, filling in <kernel image> and <command
line options> and <initrd> for you, but they must be tailored to the
needs of the particular system.

I do not have direct access to a system with this problem myself. I
have relied on others who reported the problem to reproduce it and
test my fix.

Thanks,

--> Steve Wahl


-- 
Steve Wahl, Hewlett Packard Enterprise

