Return-Path: <linux-kernel+bounces-440601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB089EC18F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118B6169843
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8273156C40;
	Wed, 11 Dec 2024 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSLzM9A9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F901442F2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880815; cv=none; b=squIN3n+YosNrqgoq2aNAxjzi7a1ZYnfW16qMNiwuJsoPJx2BeH+vWHgonP6WOLwHKR8VtsQWnJwvuvvhhJv8MlCLiwDRLLwW2HEyCcrkjhesMQi45iGuj6MkH2FjFQ0KRi7w/nVKPlIAXcUEsdr1cnWPIg84rRU9Irge4mpslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880815; c=relaxed/simple;
	bh=ixOEVTaK4lSlhh7uDq9OBoTc7qCCZ81HJhC5B1Efifc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwqHk+v9Cds3zLWvefP6wZfWz0mGVM44VoJzCYryp+m/RZIj/ZAc8ioWhQRN+kwnQNFJ5k7V+w5qMOmg67uIY8rD30Vm990qPzb5BUxeNsz4f2sC0D20P/rlf4lKUF54wLBHXyA+bEEDgRzNiMiqXB3fVRFAJ4vjM7kJCrSZymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSLzM9A9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733880811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aV+9fvOxxvmUTahU0xu8ly965n+mUXb5DBtkjTwFAU=;
	b=TSLzM9A90GUnkT8fFkpKABF8rco7rZle75Z9M9ZrUmqUlJznJMb760dvlcPN3O7LRtGvmL
	zPIHbDMC9IqGF3fWwVRX7acTyI+4d8x7PKLMAlW3MljNL1sgjIp0zz0Ciwv1VKRZo7z6CZ
	4lDjg7hKaimFYAPlCzsHF1wo7u1V89M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-lb8kWb_iO1ioW3wfqaxV2A-1; Tue,
 10 Dec 2024 20:33:27 -0500
X-MC-Unique: lb8kWb_iO1ioW3wfqaxV2A-1
X-Mimecast-MFC-AGG-ID: lb8kWb_iO1ioW3wfqaxV2A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC1851955F2D;
	Wed, 11 Dec 2024 01:33:25 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1DCF1956094;
	Wed, 11 Dec 2024 01:33:23 +0000 (UTC)
Date: Wed, 11 Dec 2024 09:33:18 +0800
From: Baoquan He <bhe@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
	Alexander Graf <graf@amazon.com>,
	Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z1jr3ghRNdwo2y5I@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <96266276b15bc3c1100b46c27b0fc19dfbea25ec.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96266276b15bc3c1100b46c27b0fc19dfbea25ec.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 12/03/24 at 05:53pm, David Woodhouse wrote:
> On Tue, 2024-10-29 at 13:52 +0800, Coiby Xu wrote:
> > LUKS is the standard for Linux disk encryption, widely adopted by users,
> > and in some cases, such as Confidential VMs, it is a requirement. With 
> > kdump enabled, when the first kernel crashes, the system can boot into
> > the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
> > to a specified target. However, there are two challenges when dumping
> > vmcore to a LUKS-encrypted device:
> > 
> >  - Kdump kernel may not be able to decrypt the LUKS partition. For some
> >    machines, a system administrator may not have a chance to enter the
> >    password to decrypt the device in kdump initramfs after the 1st kernel
> >    crashes; For cloud confidential VMs, depending on the policy the
> >    kdump kernel may not be able to unseal the keys with TPM and the
> >    console virtual keyboard is untrusted.
> > 
> >  - LUKS2 by default use the memory-hard Argon2 key derivation function
> >    which is quite memory-consuming compared to the limited memory reserved
> >    for kdump. Take Fedora example, by default, only 256M is reserved for
> >    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
> >    to be reserved for kdump. Note if the memory reserved for kdump can't
> >    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
> >    1st kernel.
> > 
> > Besides users (at least for Fedora) usually expect kdump to work out of
> > the box i.e. no manual password input or custom crashkernel value is
> > needed. And it doesn't make sense to derivate the keys again in kdump
> > kernel which seems to be redundant work.
> > 
> > This patch set addresses the above issues by making the LUKS volume keys
> > persistent for kdump kernel with the help of cryptsetup's new APIs
> > (--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
> > the kdump copies of LUKS volume keys,
> > 
> >  1. After the 1st kernel loads the initramfs during boot, systemd
> >     use an user-input passphrase to de-crypt the LUKS volume keys
> >     or TPM-sealed key and then save the volume keys to specified keyring
> >     (using the --link-vk-to-keyring API) and the key will expire within
> >     specified time.
> > 
> >  2. A user space tool (kdump initramfs loader like kdump-utils) create
> >     key items inside /sys/kernel/config/crash_dm_crypt_keys to inform
> >     the 1st kernel which keys are needed.
> > 
> >  3. When the kdump initramfs is loaded by the kexec_file_load
> >     syscall, the 1st kernel will iterate created key items, save the
> >     keys to kdump reserved memory.
> > 
> >  4. When the 1st kernel crashes and the kdump initramfs is booted, the
> >     kdump initramfs asks the kdump kernel to create a user key using the
> >     key stored in kdump reserved memory by writing yes to
> >     /sys/kernel/crash_dm_crypt_keys/restore. Then the LUKS encrypted
> >     device is unlocked with libcryptsetup's --volume-key-keyring API.
> > 
> >  5. The system gets rebooted to the 1st kernel after dumping vmcore to
> >     the LUKS encrypted device is finished
> > 
> > After libcryptsetup saving the LUKS volume keys to specified keyring,
> > whoever takes this should be responsible for the safety of these copies
> > of keys. The keys will be saved in the memory area exclusively reserved
> > for kdump where even the 1st kernel has no direct access. And further
> > more, two additional protections are added,
> >  - save the copy randomly in kdump reserved memory as suggested by Jan
> >  - clear the _PAGE_PRESENT flag of the page that stores the copy as
> >    suggested by Pingfan
> > 
> > This patch set only supports x86. There will be patches to support other
> > architectures once this patch set gets merged.
> 
> 
> I'm not very keen on inventing lots of different mechanisms for passing
> data over kexec. Shouldn't this just be using the KHO infrastructure?

Hmm, this focuses on kdump side to fix a kdump drawback, not on kexec
reboot which KHO is related to. We have discussed this LUKS fix for a
long time, Coiby cooperated with LUKS package maintainers to have swept
all obstacles in userspace, now this patchset is doing its kernel part
change.

Yes, it retrieves the keyrings and store it into the existed crashkernel 
memory reserved for kdump kernel, then restore it in 2nd kernel. I think
KHO is gonna take the similar way, a preliminarily reserved memory,
while unified interfaces to store/restore data. Given KHO is still on
draft high level design, there's nothing for people to use for the time
being. I think later, when KHO is in mainline kernel, LUKS can change to
use KHO's interfaces to simplify codes.

Thanks
Baoquan


