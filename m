Return-Path: <linux-kernel+bounces-390551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27FC9B7B47
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF3D283F74
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC419D897;
	Thu, 31 Oct 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYZ2tSSx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0013A869
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379757; cv=none; b=ITPNJawrVT1OphM7Qp3oI0ahSPVGEuCkA8Tyq5gbsaHwVZCvzTndvVDn9x3KjZeiVh2U/mYMjO+jLG4DPiXObflvEhi9diGeM3Wn64bL9jxi2R9fgDUGM7VxAdFqMYm7VZrzjbr3szCr7+cOKS+nM/mMUsJAvN98RxEA0dNvsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379757; c=relaxed/simple;
	bh=M0D70IamMVOUtlYaX3c1QqMzfw1QA/z6aOA3jm/EdbY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fQaxnCrWEumLBKxzB02FviCmYslFqtV13UG4ruymOFvAwCdUunz6dbAF03K0gdn9gYQ/D+d2Phak1pxFY0cGV9PMxgz0aQv9aUep5OPLn4WUsS36tBMf+UB7Dg6T4kVKDmULyLv7LcPWKI7UPumMsAG6D2iijeAlVmvrSlxlfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYZ2tSSx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730379754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKUe4Pa/R9hlbyMzR4jy1hOyGYkrTgtlKEhJgNXsdu4=;
	b=TYZ2tSSx6fmYXTYqatGpllrG1jV8R8S5jIcO+QDE0z6fr/8ceWIwdsKjxe0CuM+REREPQ9
	Ne8x4bS0NUzIYOidcTtGfU9XaDIjoN03fPglbRTDb37ZMqckLqWkbzEQ3EACEwU5tEC6BH
	xKc/Xvsx+vrDWf49NuUYcMUI5rbA8bg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Ikp4entDNiagHn3Fq2JFdw-1; Thu,
 31 Oct 2024 09:02:30 -0400
X-MC-Unique: Ikp4entDNiagHn3Fq2JFdw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D1C1195608D;
	Thu, 31 Oct 2024 13:02:28 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.64.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A76231956086;
	Thu, 31 Oct 2024 13:02:25 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Mohammed Anees <pvmohammedanees2003@gmail.com>,  willy@infradead.org,
  bcrl@kvack.org,  brauner@kernel.org,  linux-aio@kvack.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for
 Active Request Management in AIO
References: <ZxW3pyyfXWc6Uaqn@casper.infradead.org>
	<20241022070329.144782-1-pvmohammedanees2003@gmail.com>
	<20241031120423.5rq6uykywklkptkv@quack3>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 31 Oct 2024 09:02:23 -0400
In-Reply-To: <20241031120423.5rq6uykywklkptkv@quack3> (Jan Kara's message of
	"Thu, 31 Oct 2024 13:04:23 +0100")
Message-ID: <x491pzwtogw.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jan Kara <jack@suse.cz> writes:

> Hi!
>
> On Tue 22-10-24 12:33:27, Mohammed Anees wrote:
>> > Benchmarks, please.  Look at what operations are done on this list.
>> > It's not at all obvious to me that what you've done here will improve
>> > performance of any operation.
>>=20
>> This patch aims to improve this operation in io_cancel() syscall,
>> currently this iterates through all the requests in the Linked list,
>> checking for a match, which could take a significant time if the=20
>> requests are high and once it finds one it deletes it. Using a hash
>> table will significant reduce the search time, which is what the comment
>> suggests as well.
>>=20
>> /* TODO: use a hash or array, this sucks. */
>> 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
>> 		if (kiocb->ki_res.obj =3D=3D obj) {
>> 			ret =3D kiocb->ki_cancel(&kiocb->rw);
>> 			list_del_init(&kiocb->ki_list);
>> 			break;
>> 		}
>> 	}
>>=20
>> I have tested this patch and believe it doesn=E2=80=99t affect the=20
>> other functions. As for the io_cancel() syscall, please let=20
>> me know exactly how you=E2=80=99d like me to test it so I can benchmark=
=20
>> it accordingly.
>
> Well, I'd say that calling io_cancel() isn't really frequent operation. Or
> are you aware of any workload that would be regularly doing that? Hence
> optimizing performance for such operation isn't going to bring much benef=
it
> to real users. On the other hand the additional complexity of handling
> hashtable for requests in flight (although it isn't big on its own) is
> going to impact everybody using AIO. Hence I agree with Matthew that
> changes like you propose are not a clear win when looking at the bigger
> picture and need good justification.

... and cancelation is only supported by usb gadgetfs.  I'd say submit a
patch that gets rid of that todo so nobody else wastes time on it.

Cheers,
Jeff


