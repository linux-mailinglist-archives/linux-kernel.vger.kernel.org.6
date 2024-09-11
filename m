Return-Path: <linux-kernel+bounces-325456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FAE9759E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D708B22787
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11191B142E;
	Wed, 11 Sep 2024 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaG389XW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F72AEF1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077860; cv=none; b=ogt8I/zC/Kx0Xuhqnl6DaOPKzgejAxVAqjHW5ecIk8n/p62aX6vH+bmrneyHZtoXMkdd/I0ursoDbwReNWgLSc/gXkuti/Cr6BOQODn8CjANNzBZH4nUyRtQVF90xXmhfoSFStJ7tRiIqJ4tAFhCXq4oWkl+AYZkQmZLZgKsnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077860; c=relaxed/simple;
	bh=2xOHoF8thTJ3GUjh87u0t/cWagcW7jtsz01Vn56SM+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9y4qegJFgGmyUbK/Cdc6pG6swOb+sjOKQJvfMWxUlGkY6bKjEVTmnHUKGdfvzrsVaXLic5zop8L29LEPyJN0wgox+QuIH12oAoazdp+lr7dlCTfaj8y30qF149MfjbBbNyjJVkkO0Y7YUPvxClC9Nq8+MAssTEfdo6sWH0rh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaG389XW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726077857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xOHoF8thTJ3GUjh87u0t/cWagcW7jtsz01Vn56SM+Y=;
	b=FaG389XWVtgTrCw8eKbspxUebtcAQsm+2I90joEuYuptYG9uqFsS03cQrPEVJw3/5ZQ8dR
	YpY/x9To1RtD1frUVVUB2wn1JeflnED+xZ/4UZ4NI38H1Z+K7cJzTa7zcx7gMDZPFkfhRY
	6gJzPbwYKbA5lCv6lxCUY5vcFRGxQ3s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-N6teuNWINPOqXIV1nf4Low-1; Wed, 11 Sep 2024 14:04:16 -0400
X-MC-Unique: N6teuNWINPOqXIV1nf4Low-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a9a6634b08so15535785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726077856; x=1726682656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xOHoF8thTJ3GUjh87u0t/cWagcW7jtsz01Vn56SM+Y=;
        b=ZkP7NSjn7CWR88L+KcewIm5vIxzbiL1BOlMQVNNy1wkQVTrmfKUjuFhHEh1KfNWJrn
         8VRH4VzgRPom2famszep654XqDsReS+7GqbXbNBznzqKZ6a9R97JoowljHKRlOaLyPYU
         sLlqPhHSKrmziPhSa6o3271VXIXHwYu5KmI0HcW6ghFSIS118948kaMWhOcQcuETbbKA
         1FkUiIldSydB7EkRucxqf57x2KCMyUd6+lEqmR5L6whh4jDixtRmnGnobs9rEq9+6mw4
         cNcgmpKO4eYvJJ8a8U+pnSGpg/YkeeAmN/FiJMT8wNRDtrLxcvtNkn32bOQQgQVdgW4F
         xxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDGGrdDbdwTbi+d7r2eTZ5yKEY3zbVDxAmJk0Hn6cY/Jd0mIY1l2rvy/vSxERSTRgdX24Udczt7+Mw89A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xzlGKDHi8vXRuIfwulySRe0M0lw57A4L48ljdiw94BR7VG0Z
	mVTYH/3uSDH6URAXHgRRqWHQIrFwwhCkI3DfeC2c8ptdQ+oCWeoTUjM8/1iSeILNxkTX96RR7CD
	2lM01JSYxiXFfSblywkr+wuD+qFalZ0OoKcgCbRqkoigfUJ1hnwUK+8eB3vMUVilU4liqDEP0gZ
	dbkNCgBT0sUt/zkt58DFyp9BcDOB2u88Eil3S7
X-Received: by 2002:a05:620a:2a08:b0:7a9:b928:5362 with SMTP id af79cd13be357-7a9e60bb946mr33362285a.17.1726077856161;
        Wed, 11 Sep 2024 11:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOpsqs+dX0NjYLBNxcVRIIXvqV1z8VwH0tp118Z9B9RFh9BkGtU4S/d/XePBzURIlqO1bNg42AHvijqbUzRcc=
X-Received: by 2002:a05:620a:2a08:b0:7a9:b928:5362 with SMTP id
 af79cd13be357-7a9e60bb946mr33356485a.17.1726077855646; Wed, 11 Sep 2024
 11:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b6aec51-dc23-4e49-86c5-0496823dfa3c@redhat.com>
 <20240911142452.4110190-1-max.kellermann@ionos.com> <CA+2bHPb+_=1NQQ2RaTzNy155c6+ng+sjbE6-di2-4mqgOK7ysg@mail.gmail.com>
 <CAKPOu+-Q7c7=EgY3r=vbo5BUYYTuXJzfwwe+XRVAxmjRzMprUQ@mail.gmail.com>
In-Reply-To: <CAKPOu+-Q7c7=EgY3r=vbo5BUYYTuXJzfwwe+XRVAxmjRzMprUQ@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 11 Sep 2024 14:03:49 -0400
Message-ID: <CA+2bHPYYCj1rWyXqdPEVfbKhvueG9+BNXG-6-uQtzpPSD90jiQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/quota: ignore quota with CAP_SYS_RESOURCE
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 11:23=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Sep 11, 2024 at 5:03=E2=80=AFPM Patrick Donnelly <pdonnell@redhat=
.com> wrote:
> > Just because the client cooperatively maintains the quota limits with
> > the MDS does not mean it can override the quota in a distributed
> > system.
>
> I thought Ceph's quotas were implemented only on the client, just like
> file permissions. Is that not correct? Is there an additional
> server-side quota check? In my tests, I never saw one; it looked like
> I could write arbitrary amounts of data with my patch.

CephFS has many components that are cooperatively maintained by the
MDS **and** the clients; i.e. the clients are trusted to follow the
protocols and restrictions in the file system. For example,
capabilities grant a client read/write permissions on an inode but a
client could easily just open any file and write to it at will. There
is no barrier preventing that misbehavior.

Having root on a client does not extend to arbitrary superuser
permissions on the distributed file system. Down that path lies chaos
and inconsistency.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


