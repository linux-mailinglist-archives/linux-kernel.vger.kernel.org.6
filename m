Return-Path: <linux-kernel+bounces-204851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6258FF439
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E74A284B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A6119925A;
	Thu,  6 Jun 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FP+oP4FE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0F1991D3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697061; cv=none; b=BTSMSF7lYJz6XvizdSeoeVJx5/69sjdRUN5bbffnlJmhcno1+oXQo2otRnUGNRnidCiKGohtOSRUb72QbleUG7OQ3Di7pk+d73tcZUdomE21gWcOatUIypZ1b14OCWOTv9S/VcFqHU4kZbfp7FijNXkc8Qc2NfvJMU3eHeaOJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697061; c=relaxed/simple;
	bh=da+imw45i6WbUyYnjdn/vso5vMNu8F/aTdzRiRx0Jm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTyZfxKEmncPVKqJgAvpoFmdjsfctWFY0+Y1i83i249Jr/iNhsRNnMQLAefjiCivpxpl+4iYm7RfYscZ44+ngHoOOr2KvHmqhxZFZ5eFWFEx0gBoOkIUnz0650ixiGlqJrwRLvgpWaAV/0iDcgM5HcIIKDanZoIz7/12w3FjSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FP+oP4FE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717697058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CO0g1e2iEYIKJ/eo72YLUJTNuT2OqKeA+f4WWAhCUA=;
	b=FP+oP4FEDgh2HaiiWpZlKv9XuMtjsKEejf3C+FrrL9e1V2x8Qn2j7Tmzy8Vo9NR7nKcwKQ
	39bbsofuPdJ5uoBmTB4QfUI5ha84g5ATk/1nrrXFlvEdZ59y2xJJJgdSlgfayg5N91NsVF
	Jck9rfOvqCIn0B0e0e/cMh5igltyoV0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-8ypqWJbzPAWP3SCrROSlnA-1; Thu, 06 Jun 2024 14:04:17 -0400
X-MC-Unique: 8ypqWJbzPAWP3SCrROSlnA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d1ff776f69so937915b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697056; x=1718301856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CO0g1e2iEYIKJ/eo72YLUJTNuT2OqKeA+f4WWAhCUA=;
        b=PweA8Ctrx2CefIwnIjnp15XeJRng8IfqMFJi9tMNUtccMNnhs+bF+QTh00I4Uz5cgM
         9aAWwDiYdrE5ZSR7qpVEF7lWX57yoodu7h/UPLObE1zNWpdzrD6parQl20Y52xvi5r4r
         PtlVOKRoJw4LBdvmpNof1e6iXDU8XtroI6Gbl4LFi+v2oZ9RpHjHcC+IsPlCYLMDHslo
         Si4C4piKxayfa+5YMbaCSRebcokjta06X6dgZ7F1GI85hdaRCn+2kwVDkU9x5i7uei3d
         hkKySsUXZMNavZ7kWZAp6uFlAyO1SmsGYZTrk+rRNs9u5rbMewRmR+cj0TeDob4g9FHR
         Xewg==
X-Forwarded-Encrypted: i=1; AJvYcCUV25QHMB3BtlMAjMiVS5LC9TiyVn4e2KeztVk/KxV3D+B2d1gdlNrPC95bXEm6TggBjv0f1gp3aGOxPCiqf5ZV6n+QFxE/yKP0F03C
X-Gm-Message-State: AOJu0Yz3Xwshj/rtpO/w8SuJHrtpsECB2+YQwC+qhUIKLv9hZEcvtmkx
	C+9sbG/rxbzBE1nSNLV/YIe44Du41LKYHUtYqC16BLMVPfYIoYQV9adVVV/KRUbgQZAlekeHHGJ
	4Xaq9sqWI35kLmapH5/rUrtruIsCOjHoqJYtotIyyMwSoy7k08UPPU1fKPt0TSOCotZKkU3QV5F
	qmyjzIoEDaKx/VOY/PP1+bC0uwa1fmMBwK7UZ0qQQW35fe
X-Received: by 2002:a05:6808:f01:b0:3c9:c350:bd40 with SMTP id 5614622812f47-3d210c5c58dmr321906b6e.0.1717697055854;
        Thu, 06 Jun 2024 11:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMNpxDILxVYdYF+MIzB3EnzNYH3beUywsvqC9vv7lHss0Xq69PNun6Ju9dhGLMdY0RV9kmGV1cAXkq3BMPIBY=
X-Received: by 2002:a05:6808:f01:b0:3c9:c350:bd40 with SMTP id
 5614622812f47-3d210c5c58dmr321852b6e.0.1717697055422; Thu, 06 Jun 2024
 11:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.LSU.2.21.2405311304250.8344@pobox.suse.cz> <20240606135348.4708-1-rysulliv@redhat.com>
In-Reply-To: <20240606135348.4708-1-rysulliv@redhat.com>
From: Joel Savitz <jsavitz@redhat.com>
Date: Thu, 6 Jun 2024 14:03:59 -0400
Message-ID: <CAL1p7m7oHwX_OqyUiXqKh=x24d9b9x9gqNA6YEec6s58adAE0A@mail.gmail.com>
Subject: Re: [PATCH] selftests/livepatch: define max test-syscall processes
To: Ryan Sullivan <rysulliv@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mpdesouza@suse.com, jpoimboe@kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:54=E2=80=AFAM Ryan Sullivan <rysulliv@redhat.com> =
wrote:
>
> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.
>
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>
> ---
>  tools/testing/selftests/livepatch/test-syscall.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/te=
sting/selftests/livepatch/test-syscall.sh
> index b76a881d4013..289eb7d4c4b3 100755
> --- a/tools/testing/selftests/livepatch/test-syscall.sh
> +++ b/tools/testing/selftests/livepatch/test-syscall.sh
> @@ -15,7 +15,10 @@ setup_config
>
>  start_test "patch getpid syscall while being heavily hammered"
>
> -for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do
> +NPROC=3D$(getconf _NPROCESSORS_ONLN)
> +MAXPROC=3D128
> +
> +for i in $(seq 1 $(($NPROC < $MAXPROC ? $NPROC : $MAXPROC))); do
>         ./test_klp-call_getpid &
>         pids[$i]=3D"$!"
>  done
> --
> 2.44.0
>
>
Acked-by: Joel Savitz <jsavitz@redhat.com>


