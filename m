Return-Path: <linux-kernel+bounces-345690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FA98B9C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF9E1C2304B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFA19D887;
	Tue,  1 Oct 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZAaqWlj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5E1862BD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778722; cv=none; b=KEkZr61hFsNE6vZKuv2V58U1Dy272pkHtyVyqkxNDuMbbAS7I7yBp7v6yFmQWniO6JWk3q5pzfxwOPktkM37jgC/lkx0HCBHxPXqei8mtgRKqoX2UZr3d4EBE/k8NmaSNMDGzJ5uhKASQVoO7rDVCsOMhF0sJDo1JMQdpOoXgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778722; c=relaxed/simple;
	bh=BHxBdN0+0XFc2gscEzhmEBjFXgbgPMlgA7qFw8/FInY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxM52aIzcWBQz5J6SG6XNi7s2iheKzMHiTOpWdD0geLk6aYXO7Pt2/dqJt/ggy4EVLbVef9v6lUlXgr9N3KsIA402zpAO91tJqg8ITeNoYsE4QdA5crOKL6QAGoSTZHA2B8s1XVbTpoZGufdw0vZuXVubLh1HPOpayklgisdZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZAaqWlj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727778719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFX2w5y/1YTkg4M3sx1+O7IJ/a9wNfaFRAayvFDPj2U=;
	b=cZAaqWlj8Ny3WGpOWfMkis8r3K1BeGuIxCdY0nOUVXoJ3zSbQtizdrljhMTZc+8MjFnCFl
	Ue8SsifMRyf8DrSRQ9E1TJqU6B1kazniTeUbpfIw/GgZKu+iqpTlbbefl+AOQBqOgvfokK
	MU91dZba9zS84fbqpPlL3E0rlePhVu4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-06VVDiZIPOuNRGszvORPTA-1; Tue, 01 Oct 2024 06:31:58 -0400
X-MC-Unique: 06VVDiZIPOuNRGszvORPTA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fac0c2d49fso21903231fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727778712; x=1728383512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFX2w5y/1YTkg4M3sx1+O7IJ/a9wNfaFRAayvFDPj2U=;
        b=KvtgpdAPKgRQWV/374oSRxskibUfqlZRh5SpqLcSqOl7WY77u7LzRHQFis44cjHEz6
         QmVX0+nO3+WeR426BgupEY154wRtpjp7LkcDe9xKcBpB2veb+tHunAoL2+bJNGmAdZiO
         4sy7BifV5PG5DyC5tiKU34g7buDMiwLm68GGIgUyLlh0qIPffM9dUP8XhphlgnG4vWFq
         6jciXn3NyYpw0toq1sMwzZUXgiDiVJ2S3HQr+v8L8WeEulLQtNeT/0cjJd4StH61PLXu
         NdTtqZm40GRSaA85t/mTJbpSJqMM0Jn8JvADseXqDglqRbQgvo4hIokYB7+1ho3CpMoC
         7I4w==
X-Gm-Message-State: AOJu0Yzpj8klPfiWL1BTyYy5ASRQds/pXOqMhw238EYc8BGypTa9Pko4
	7mq+DVAutP1KcI661lk8quIhiQbi80O1bFDNEbisHrkY4C3OrIXWHe+i0pn5x8nj5NIjFcxGxIT
	+qAeVhwHZ566aFnX98gqq3EwVKY3Yp3ovpvpmYZkF4Ob1I82yQw3QG3Fv7bpSX1siqsYK/G/Kfk
	HEbePdsdSgClChT6/wD3xa9t0NWVAYgWO/DR/N1Vt+ED/zn6Y=
X-Received: by 2002:a2e:b889:0:b0:2fa:d6cf:28f6 with SMTP id 38308e7fff4ca-2fad6cf2c81mr22444701fa.3.1727778712380;
        Tue, 01 Oct 2024 03:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEigpLyS7jOvPPrdCyLrpJ7l3ogwdCk5nU+Sx78wFqjh8XJSsDghWBrZl9qdNcLnsLV29Ppj+o544CxVwWSQzE=
X-Received: by 2002:a2e:b889:0:b0:2fa:d6cf:28f6 with SMTP id
 38308e7fff4ca-2fad6cf2c81mr22444471fa.3.1727778711910; Tue, 01 Oct 2024
 03:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926152044.2205129-1-david@redhat.com>
In-Reply-To: <20240926152044.2205129-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 1 Oct 2024 12:31:33 +0200
Message-ID: <CAMXpfWtjE9tKhrvRmnCC_PeneV6LAB3XSqAUBzCMGAjvH6oxJA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] selftests/mm: hugetlb_fault_after_madv improvements
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series has been successfully tested. Now when executing the
hugetlb_fault_after_madv selftest the benefits of both patches could
be observed.
# ./hugetlb_fault_after_madv
TAP version 13
1..1
# [INFO] detected default hugetlb page size: 1024 KiB
ok 1 SIGBUS behavior
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Thu, Sep 26, 2024 at 5:20=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Mario brought to my attention that the hugetlb_fault_after_madv test
> is currently always skipped on s390x.
>
> Let's adjust the test to be independent of the default hugetlb page size
> and while at it, also improve the test output.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Mario Casquero <mcasquer@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
>
> David Hildenbrand (2):
>   selftests/mm: hugetlb_fault_after_madv: use default hguetlb page size
>   selftests/mm: hugetlb_fault_after_madv: improve test output
>
>  .../selftests/mm/hugetlb_fault_after_madv.c   | 48 ++++++++++++++++---
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> --
> 2.46.1
>


