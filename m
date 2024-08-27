Return-Path: <linux-kernel+bounces-302827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB69603E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B95B1C220AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49232198E71;
	Tue, 27 Aug 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vtq05eLL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12849196D98
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745790; cv=none; b=XHK3cbium0oIXjJePmF1bZbWYsXhjbv0gBNMqf0ALlcCTKISA3zM9G9AWk/XWqgojJEoyy7P7oulPpWxlqc1HA82pKPwI3uku2x+V212xbn1qjIV54W2BKgIy021V7j/UW3pM1+HDD3ZVw+cV7lAOLhSeRg6nXdwwuD+JF7U4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745790; c=relaxed/simple;
	bh=4MFCsHCbSfsLzCMTMa6Dj5HQcFVkxz2Gp/cD9XJHo4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkQErXPRE4BRpIXOeQADT8iIuF8e/c7etERW+zW2rJJ3iwgp5XVO2L6gGa81KgZUASrk/As1N5FhKWX48XnXqo3sVO3sMe2Zr9dpjDBhj57DMmCfoE051SoXO0YHrl7y4sZgc/Uldh+UB4N9Rxh2lq7U+9SBRfCocJ3yTLNOT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vtq05eLL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724745787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffMGKoiHs0yZ815x5dyOzgYe6p4XSSyZPbsnLGfo48c=;
	b=Vtq05eLLXhLd9hWSD+ttDlp5pFZZH32Op/LXc7KMxuXbaVW7qAETYQfivAa84heOBxAgTO
	Z6hainP3vgWScFSWdccx7dS6RKa+eEa3r94wr78I9AL6FNoXQ3jL/GfXegEFvFm1nhLQVj
	yvgsTup7pnWFs4xK8aMVy7LSnDHz5dQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-txYPOakSO0mefbd4ZHGq7Q-1; Tue, 27 Aug 2024 04:03:06 -0400
X-MC-Unique: txYPOakSO0mefbd4ZHGq7Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d406dc42f4so5347690a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745785; x=1725350585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffMGKoiHs0yZ815x5dyOzgYe6p4XSSyZPbsnLGfo48c=;
        b=USBEcvC3JjJUIZz2E6Avrwj65Fcau2Ru5yLHI3aiOp3alObGonMn9KV2DHsDK4bJ6X
         zADNH8nIhcPbB1i6YMGQudRpQNO47kVy5So1YISj1cR0Nc+Tj1NfmXVVNuQtvx/3suqE
         xy1fim5+adnh082qtrOs/onQjXzfJcdX1wuWOTY7WGDoinw5MFGK9DDl6X7p48YexNpo
         42QyFWAYCzTsxMn+KDdpYJS3Mo8ujkJ2WsU+QEfZ8JWINfSuQ9on9CUQxwfF0nirGUjt
         RdoOQgjGVEyzOShyfi8iYaekrwtP5ONvMVihzDgR0DAx7HoY3pd0VSOssthYJrRtQhms
         4LNQ==
X-Gm-Message-State: AOJu0YwQIMyum66D7GA5kv2q+WAIT1LsUg4JmGDHBS0Mp355mzrERA7F
	HaQA1l0xWGlRL9mIu8WqaWDuKzZphBkCLE8mhEUZHWGxqXQLi5CGhcThuvUxULEIpFGTcHjneeV
	fnryIkHAysPx6iY6lxJaXczpjv/5U7M8BZVMYFqiMfRKUK3K59YMIGxbaN3Pysv3BsA+TQjJfDh
	LZjXnfJW29LPX/PDZYhCin1QgTlzMM/V/xZyqd
X-Received: by 2002:a17:90a:394c:b0:2c9:e24d:bbaa with SMTP id 98e67ed59e1d1-2d8259d4663mr2250659a91.27.1724745785051;
        Tue, 27 Aug 2024 01:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCZ0HUn8POci1+wrCfZMzm6mS4ZeB+DcoBO5sIlJ8wwnpW4tPy+dcsyOe2ekJNdcposI/b7etWYGnF60z08I4=
X-Received: by 2002:a17:90a:394c:b0:2c9:e24d:bbaa with SMTP id
 98e67ed59e1d1-2d8259d4663mr2250612a91.27.1724745783995; Tue, 27 Aug 2024
 01:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com> <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
 <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com> <d431a0a3-a12d-4da0-b8cb-dd349aee8d4d@oracle.com>
In-Reply-To: <d431a0a3-a12d-4da0-b8cb-dd349aee8d4d@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 16:02:51 +0800
Message-ID: <CAEemH2d9uzDv030eYRs_hsu_PcbVTXR75YPyN4Ux2v9AVxd5Lg@mail.gmail.com>
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it, 
	Jan Stancek <jstancek@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

John Garry <john.g.garry@oracle.com> wrote:

> On 27/08/2024 08:35, Li Wang wrote:
> > On Tue, Aug 27, 2024 at 3:20=E2=80=AFPM John Garry <john.g.garry@oracle=
.com> wrote:
> >>
> >> On 27/08/2024 04:22, Li Wang wrote:
> >>
> >> +linux-block, Jens
> >>
> >>> This change allows the loopback driver to handle larger block sizes
> >>
> >> larger than what? PAGE_SIZE?
> >
> > Yes,
>
> Please then explicitly mention that

Sure.

>
> > system should return EINVAL when the tested bsize is larger than PAGE_S=
IZE.
> > But due to the loop_reconfigure_limits() cast it to 'unsined short' tha=
t
>  > never gets an expected error when testing invalid logical block size.>
> > That's why LTP/ioctl_loop06 failed on a system with 64k (ppc64le) pages=
ize
> > (since kernel-v6.11-rc1 with patches):
> >
> >    9423c653fe6110 ("loop: Don't bother validating blocksize")
> >    fe3d508ba95bc6 ("block: Validate logical block size in blk_validate_=
limits()")
> >
> >
> >
>
> I feel that you should be adding a fixes tag, but it seems that those
> commits only expose the issue, and whatever introduced unsigned short
> usage was not right. Maybe you can just get this included for 6.11,
> where 9423c653fe6110 was introduced.

Ok, we can mention that two commits exposed the problem since v6.11-rc1.
I will send V2 including that. Thanks!

--=20
Regards,
Li Wang


