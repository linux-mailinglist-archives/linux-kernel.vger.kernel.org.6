Return-Path: <linux-kernel+bounces-325216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1414F97567E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E587B2171C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBEE1A3033;
	Wed, 11 Sep 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNtb255Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE5E19E81F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066913; cv=none; b=g/ISRfH9vrTG08IV7KqeC+9pSUeAjjq9o+XsTHQS0BehT5YHtVZkZX0B0M8/IwLUe54MJj6/ahpuV21zb4ijzbPPAaNqc741rt4bkMI+GPmU5kzi3y1/GQQHJNekbjk22t/s2zEA9M31ijVCjf+Xsuj7C+nHd7jmIlP9go7mDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066913; c=relaxed/simple;
	bh=+bp5jNkh0sEpte3fgI8NNHJYPlPV3FQgO3dhcAnwtFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8uuVyb1vea1CGQcEG9+T2dq79qlIxtrCaBMYmW9dSVunaEw/MTgWs1j4vgwwAjAXUudTXEteE57s+QedF1sGMvoBcj83d5pK2iMgwJpHZsKHOLWjZZVWNYPpc/veyuEFh9gczhoE2FLcMPtOAAtKLc4Rqe0m8R2rUqZBWl68gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNtb255Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726066911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLn0JUXSczicvUoPLN4Wwhocrdq3XTVqmB3xoJcwWj8=;
	b=hNtb255ZuxC55+3N9kP5aRD9icS2DL1w9kjh0i5zOLEHhJwuYocMZDTXoZUzvuOo2TYACL
	5efdkS5N72u0qtq876NaszT79UDoZ6O3VGB5llwFUuM0PQ8G1fIQyxrKZVe/cIZHgAyfVv
	E3TEIGfC4kBgH2oFpRdALW7RREbx998=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-YDMYzN-KPayfBv49rPZeCg-1; Wed, 11 Sep 2024 11:01:47 -0400
X-MC-Unique: YDMYzN-KPayfBv49rPZeCg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a99fdae7bbso1026964585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066906; x=1726671706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLn0JUXSczicvUoPLN4Wwhocrdq3XTVqmB3xoJcwWj8=;
        b=qjAMBtWE6Coy1DvCEyAg1wkaoaPNCqq0iMgWYRFgEDmtViDP264FmI6nJjbjyTqQtO
         q0yob5dYlq7o/r469UmtKGizjo8/JijLNVGcM/WNySBJ40aLN/MTcI2FIUnREEwMcfBq
         XNIxqONa3TRHPklEYZSz/F4XrNT1mkDtDZ9wio705buFNxm681fOSGW1MvxdxYAYvqrI
         gx/fFf7gGsqZfnzm+6+VDDd2JYvF8wahXMa8j00Fws4YtOj0WZIob+yRhd5sa5gMCVVt
         O1YgrAPgp6NRYoisz4kpZJCWXREhYtj99+P6pXwFo6mUvHuow8YuKTHwN2VsmeV5WhcJ
         sIzw==
X-Forwarded-Encrypted: i=1; AJvYcCWb9y3GjGSPoLN/KozB9SbMslC4HtVBqYf2xJJL+EFD7aZOL7gTHGMgvrghv1A/p+TK2lJ9FyF2BVfgDs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGB4vzZNDH9b+HNyWQp81coDwIeJ9OT3JdEHlSBW7d2qf265vL
	w0SKd1acYvP01B4fOGV3EllsXIRKFJyosuj3CFNFREVss99fCaoB+LRsrtj9fWQmnfFFkYLaFbT
	5Q08Y5/Eugw0HkyCw7Mx4kjYpkBg1C7PWtl6lUfVs196JHeQai2dGNMB/yZqTt4ZLQrmGkGuaAY
	RHnByOwggGH4jjW3VCW+qiWrlA70b1njPdwf7V
X-Received: by 2002:a05:620a:2684:b0:7a9:ae1e:1055 with SMTP id af79cd13be357-7a9ae1e152emr2103323685a.59.1726066905870;
        Wed, 11 Sep 2024 08:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFedvQbeyWCbGq4+lmTuZLTMZSDQlJ/N0BLS/JVsMA7jBX7rrmuZduSfmR81ZzO0kQDC5jyKKHGNRi+hVI7kfM=
X-Received: by 2002:a05:620a:2684:b0:7a9:ae1e:1055 with SMTP id
 af79cd13be357-7a9ae1e152emr2103319685a.59.1726066905506; Wed, 11 Sep 2024
 08:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b6aec51-dc23-4e49-86c5-0496823dfa3c@redhat.com> <20240911142452.4110190-1-max.kellermann@ionos.com>
In-Reply-To: <20240911142452.4110190-1-max.kellermann@ionos.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 11 Sep 2024 11:01:18 -0400
Message-ID: <CA+2bHPb+_=1NQQ2RaTzNy155c6+ng+sjbE6-di2-4mqgOK7ysg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/quota: ignore quota with CAP_SYS_RESOURCE
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:25=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> CAP_SYS_RESOURCE allows users to "override disk quota limits".  Most
> filesystems have a CAP_SYS_RESOURCE check in all quota check code
> paths, but Ceph currently does not.  This patch implements the
> feature.

Just because the client cooperatively maintains the quota limits with
the MDS does not mean it can override the quota in a distributed
system.

NAK

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


