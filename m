Return-Path: <linux-kernel+bounces-325571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B6975B85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82451F2359A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B201BB6A1;
	Wed, 11 Sep 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULp8K1/2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A21885A8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085698; cv=none; b=ZMOOb5bK6l9FmKQWGFRUgYecIN+Iu3z4qaWLY0CCNn0t8GUkeHOWllW4H5qqDLFUlzvEqmqR3EmyTKsuiNkqJk6sDx2szt7jx88NfLFHXu/ZREXCPoF+7lDSCex3K2vonIHyuNqfXTMlhwXuUPML+FGm4cIl4waRB0BvXt7ycu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085698; c=relaxed/simple;
	bh=OsSe0iXO1X2k004OCN4aio3yNszGQTd/Jn30DawwnG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doyNBcw9QjZ9EQyueXOW4I31U+hRK1CyPmlRRvsxe2epi+VhOuhwMpBgiNp96f5V1m63GfTcCIKj275wMr6u6UYwjmW2oZp5UJhMfUxw+0dnbfTCahrMoVvAY5+wWUzoCE/ANYjd+fzIbLO6YpCTlIUmUFg0xOCT3oUeGAsRsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULp8K1/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726085686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsSe0iXO1X2k004OCN4aio3yNszGQTd/Jn30DawwnG8=;
	b=ULp8K1/2czBy0NT0y1F8nQbB3pfWveQFFbxeQoGUkBgKroHHA0+SXyW5VSpdVVGwtD4NXK
	VuNR+qQRbU5IBLRIYGVWapYNgeS6s57mDMTnlErLZQ1Qpi3QW22uD0Wa4lwyv6TqDoFKEl
	/I+iHAKCG3lWPxOdVxIT7WkmPda00ms=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-m8CIm6pSP52UXv8aaMoEtQ-1; Wed, 11 Sep 2024 16:14:42 -0400
X-MC-Unique: m8CIm6pSP52UXv8aaMoEtQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d0b29198so96253785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085682; x=1726690482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsSe0iXO1X2k004OCN4aio3yNszGQTd/Jn30DawwnG8=;
        b=FGrEujogzbJkrGJGXgZOtllh+7zf1CamG9k74iLdtz5SZO6Dvd3/7PiSIgT5YKnTzd
         7rDEj8sx3BO15RCVNpC2Cc/AhwcIQIY7AgBhuBhZlekLTnem8UaP5jxP+vH5Um7BmE15
         r7X7P0NG2KMbPk9mp5dwjQavgjiDFCBZJrZm0AEwWcNnmYo5pzV4PsWiHn6LmnookJYz
         Ue5nbEk1bgZi5iFwQv53SsuawbvUNz8tHnkx5AfWCubW5ooe8QhOa4UOctQnk7vkMmmd
         oblEWlTh7nOGY5DrPRtlFgmFfXYMOVEOklziOs+SF94HipbUWgp0dOlpL9I6Lf7gJmUC
         tFFg==
X-Forwarded-Encrypted: i=1; AJvYcCVyimjntp8z/9cbRIDOKhnfl4rgP5/EpoMGMq9y5v2eG2Sr+9N+mS5OM4dEm2a7ukvklXtzbUobJ6rVhyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4y49HIE0HjzDdmyDVeEIAUnfrtTSOXHOuwpBQfNE0IK/ZsI41
	I1BLbcuL7keGETCxt3j/O8d4plLoh5GjiAhqCeLNj9NPIj0hxzhflCEZe/tjjFicAvfTR8VFgd+
	KD/sIcG52nPp2bcgPkuEox30WVIDOIrMogm3roKbodTpecuXEfGgyY9pQiLnBew+nHvy9m9GyfV
	cEAoVyeYvUZYU5kD22TctLQXXWT6+isJyfYzGeqd92Id6t
X-Received: by 2002:a05:620a:1996:b0:7a9:aa6c:f15d with SMTP id af79cd13be357-7a9e5f7aeccmr74774185a.58.1726085681698;
        Wed, 11 Sep 2024 13:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYM9uFHo7eKZPOtqQHJZ2lGVoqcP+0rkdbBe7z/EI3IXviO6dh6tVJn98//HiyWnJ7GZ2OTU9TzgULozRBquw=
X-Received: by 2002:a05:620a:1996:b0:7a9:aa6c:f15d with SMTP id
 af79cd13be357-7a9e5f7aeccmr74770785a.58.1726085681232; Wed, 11 Sep 2024
 13:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b6aec51-dc23-4e49-86c5-0496823dfa3c@redhat.com>
 <20240911142452.4110190-1-max.kellermann@ionos.com> <CA+2bHPb+_=1NQQ2RaTzNy155c6+ng+sjbE6-di2-4mqgOK7ysg@mail.gmail.com>
 <CAKPOu+-Q7c7=EgY3r=vbo5BUYYTuXJzfwwe+XRVAxmjRzMprUQ@mail.gmail.com>
 <CA+2bHPYYCj1rWyXqdPEVfbKhvueG9+BNXG-6-uQtzpPSD90jiQ@mail.gmail.com> <CAKPOu+9KauLTWWkF+JcY4RXft+pyhCGnC0giyd82K35oJ2FraA@mail.gmail.com>
In-Reply-To: <CAKPOu+9KauLTWWkF+JcY4RXft+pyhCGnC0giyd82K35oJ2FraA@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 11 Sep 2024 16:14:14 -0400
Message-ID: <CA+2bHPbMwsg8NkvW=FCSwCs9p2B0wBkrfW6AbPj+SOWNHAD45w@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/quota: ignore quota with CAP_SYS_RESOURCE
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 3:21=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Sep 11, 2024 at 8:04=E2=80=AFPM Patrick Donnelly <pdonnell@redhat=
.com> wrote:
> > CephFS has many components that are cooperatively maintained by the
> > MDS **and** the clients; i.e. the clients are trusted to follow the
> > protocols and restrictions in the file system. For example,
> > capabilities grant a client read/write permissions on an inode but a
> > client could easily just open any file and write to it at will. There
> > is no barrier preventing that misbehavior.
>
> To me, that sounds like you confirm my assumption on how Ceph works -
> both file permissions and quotas. As a superuser (CAP_DAC_OVERRIDE), I
> can write arbitrary files, and just as well CAP_SYS_RESOURCE should
> allow me to exceed quotas - that's how both capabilities are
> documented.
>
> > Having root on a client does not extend to arbitrary superuser
> > permissions on the distributed file system. Down that path lies chaos
> > and inconsistency.
>
> Fine for me - I'll keep my patch in our kernel fork (because we need
> the feature), together with the other Ceph patches that were rejected.

If you want to upstream this, the appropriate change would go in
ceph.git as a new cephx capability (not cephfs capability) for the
"mds" auth cap that would allow a client with root (or
CAP_SYS_RESOURCE) to bypass quotas. I would support merging such a
patch (and the corresponding userspace / kernel client changes).

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


