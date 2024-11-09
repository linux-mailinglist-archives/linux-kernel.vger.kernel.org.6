Return-Path: <linux-kernel+bounces-402790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230A19C2C2D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA65DB21D06
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264C215573B;
	Sat,  9 Nov 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ED6OC0bE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01213DDA7
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151737; cv=none; b=EjHKNy81bLws/r4567+t00DEJ3RQHxUQmqy8XPKXlG9a2ahvEjJ9bUWH0b/+eKelPTq7zkEnMpgzaaD8bPA11MAUc8flxQ7TpQMmDAMDuPLW+DxRQFNhJ0B+eAfVHK+s16JSOMIPljkKq1dkL/N1mrt1GFQijKQFCQZZ8nWB10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151737; c=relaxed/simple;
	bh=zBQUkF3mr5u6Z/v/AXOYl5E26nW21vRGwX/grdg05bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PclPwbxeI4voWYk59OPWBSoOC5PGD7RkuGtPgqamRXyHhR6hvoiyXHOppGH7hzUTd1R37EMcdR0dKLIRm4vx3VDiMUKZ+hwnG71jSDPnfqskXBJ1CZ/yX1oBArQS96+EWM0Jf6lzLtCyty0lpsWHKQ6Y9btx7wxUFaXMDDiP2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ED6OC0bE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731151734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRuuRov2tfd3XM0hFi42t8RoGExTUNXwhCOPImNSph8=;
	b=ED6OC0bEO761MuidP88quTi8bFHJ5FVfZ7CjMk3Y2wr302NUeaxHeN//ZR+xJhIz5aL1Qs
	w/IcKCQOUaQjdUZOO4uIfOukpNyIaZR5yjaxvBboiiKLjRhUt4UiLOGrpbWdhPhTwqnMkA
	WyAHZbJJS0EMRpCq3hf58bZL+EPRPJ4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-wmCrGq76PRaVpGJAOT11RQ-1; Sat,
 09 Nov 2024 06:28:52 -0500
X-MC-Unique: wmCrGq76PRaVpGJAOT11RQ-1
X-Mimecast-MFC-AGG-ID: wmCrGq76PRaVpGJAOT11RQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E11819560AD;
	Sat,  9 Nov 2024 11:28:51 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4F8F300019E;
	Sat,  9 Nov 2024 11:28:50 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Kernel strscpy() should be renamed to kstrscpy() Re: [PATCH]
 nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
Date: Sat, 09 Nov 2024 06:28:48 -0500
Message-ID: <91B9DC8F-6C6C-4F47-922A-D01DF1079959@redhat.com>
In-Reply-To: <CAHnbEGKRKrw-9_wnrASVHniZ1RggP+b-YzvwPYM7ScsMvmpCGA@mail.gmail.com>
References: <20241106024952.494718-1-danielyangkang@gmail.com>
 <CAKAoaQnOfAU2LgLRwNNHion=-iHB1fSfPnfSFUQMmUyyEzu6LQ@mail.gmail.com>
 <283409A8-6FD1-461C-8490-0E81B266EF9D@redhat.com>
 <CAHnbEGKRKrw-9_wnrASVHniZ1RggP+b-YzvwPYM7ScsMvmpCGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 9 Nov 2024, at 6:11, Sebastian Feld wrote:

> On Wed, Nov 6, 2024 at 9:40 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 6 Nov 2024, at 15:20, Roland Mainz wrote:
>>
>>> On Wed, Nov 6, 2024 at 3:49 AM Daniel Yang <danielyangkang@gmail.com> wrote:
>>>>
>>>> The function strcpy is deprecated due to lack of bounds checking. The
>>>> recommended replacement is strscpy.
>>>>
>>>> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
>>>> ---
>>>>  fs/nfs/sysfs.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
>>>> index bf378ecd5..f3d0b2ef9 100644
>>>> --- a/fs/nfs/sysfs.c
>>>> +++ b/fs/nfs/sysfs.c
>>>> @@ -280,7 +280,7 @@ void nfs_sysfs_link_rpc_client(struct nfs_server *server,
>>>>         char name[RPC_CLIENT_NAME_SIZE];
>>>>         int ret;
>>>>
>>>> -       strcpy(name, clnt->cl_program->name);
>>>> +       strscpy(name, clnt->cl_program->name);
>>>
>>> How should the "bounds checking" work in this case if you only pass
>>> two arguments ?
>>
>> The linux kernel strscpy() checks the sizeof the destination.
>
> Then the kernel strscpy() should be renamed accordingly, and not
> confuse people. Suggested name would be kstrscpy().
> Otherwise this would disqualify strscpy() ever from being adopted as a
> POSIX standard, as there are two - kernel and glibc - conflicting
> implementations

I should have said the linux kernel strscpy() can accept only two args if
the destination is a statically-defined array.  Most uses are the three arg
version.

Ben


