Return-Path: <linux-kernel+bounces-416711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C9C9D4919
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59A01F228FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0F1C9EDC;
	Thu, 21 Nov 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SjfgntB/"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A2158D79
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178632; cv=none; b=T4Oc5vSeHcIoqod5EiTRtzkKZVjoKsKl2biC5k0/kT9eO/XBRm0mVhAvx3UUe+IBwf19T0OMlcHRlHHWTMpKNl1ZxuG3DXeCzddqnWTs6Yp+WWk7oVBDDQ+qsXD5yj3UZSLW7ZnvJzTzDXLAsFkZv7Ii7NhHqNltVqUYC/pCxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178632; c=relaxed/simple;
	bh=zbMOE85kyf/M+jgDKtWC/AtsNaFvB8caVQrYhqvhyGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XheblN6CiDuDAw6lutVDCTm6EyT2X4ctT1rUMgNZCkrA3K+U6Q0x+PubNjTa29bNd6ev2ck8p1B+mJeOwJCUPkwM/GMcSe/vUBdKN06wQ5vJ6yIaAvwDTMaQMf46BNZQznJL5wbrizaxFIwn/HDaYNJPBGuf9YuLzGxj+GOMbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SjfgntB/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9aa8895facso116776966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732178628; x=1732783428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbMOE85kyf/M+jgDKtWC/AtsNaFvB8caVQrYhqvhyGE=;
        b=SjfgntB/HcvOobtWOXpsUDLB2rPB+mAKqCTUI7miwRFQVi3mQ2YCyleC4uRsbl3oZq
         7E60Y7icAvDQw2eNfsOuTcn+5MbjrRqJLZa3LP5NbRbo1ax9MGWJwZ6BcQfpTNrQBOhc
         dfvahB8Ra2G2fi3zCv1HKOYMSMANbj2Fn6QYyZgYLXdRql4aPY0R2y2KgUhc5NOJgDew
         q2sDURpA8s0I1g+Kn9JxRYjoPdPP/b+nuXLbxxvmndMbkh5xlwaDtNOppteABL42BrJ1
         LtxxdB/1ZM83GQUM6JSFj0G09gI48GM3avWjEnSUQgFK5n0sBMXN0fKY0XFnu310ki78
         Zw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178628; x=1732783428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbMOE85kyf/M+jgDKtWC/AtsNaFvB8caVQrYhqvhyGE=;
        b=U6jNMV21Sc6AQvPgc+JCCHcNj3SEagRsXI2GXkwDQZVkqUDWenwLUxmvJmkNshBnXU
         OYIK5NfSCKC/F6ZXUotdMpwizEMCZqL25Ny88E6RkdkYYdU1GlEiU9frIAyKOhruICBV
         bd3wabD1gUJjyBngjFFz25c7lYQhDwc6fMmaksddDnOQWRzi6wdP55avRDZ/RE/QBwXm
         Aa0Ju6Ks6dMwZE17HNxVIPvzSrwaskCDQZNGxvXeJCKEpZEv3/+9wj858QWaG8Tu63ul
         rEmbxomxnh/IK5r5lFVm/JuCySSiWIn0vC78vjx80jPom4KPqnlcWLzlSIhBNUiNKMgu
         r10A==
X-Forwarded-Encrypted: i=1; AJvYcCUWtdC2vQEuJMrXkyApFI2ghbWSNlXBI9zMMPdbe9Cdh4HzZ1kH2o44LR2lrfLetvLKJfAd+bfN2B36xjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmhKl3WuyJyguL082DrEyUv5tc/aga3eWcfLon8ODOvnoCpu2
	OL7Ip6srwIWAYxIoM9P4cmiT31fVYtoFuT/KiVInbzKpFAcKlq5w8YSOyUVAInP10/SCk4u0Orx
	GROF6ujVrduGrGgh6fA7xGxCYw+cdaFwNDD44pA==
X-Gm-Gg: ASbGncvKS8hFQ1HwPI6Mskv2PD8jU/TKdcnRp+LBEkGqCaoQ0OnRn0QNqqdfXkUpo6p
	74AArnmqzt76e6K5K48fBFsr1VzCyedZYEXHe+gn81k+E4Ni4mnA21AiTtft5
X-Google-Smtp-Source: AGHT+IHd1tWz4ktoGkYiqgv0D+V9Xdzmco7j4J4H7r1eGdJjckgvHhcLnFzws4eZAlZff0HRlTXsvijEvYWA774J4Yo=
X-Received: by 2002:a17:907:f19a:b0:aa4:e89d:57b1 with SMTP id
 a640c23a62f3a-aa4e89d5aa8mr342483966b.28.1732178628260; Thu, 21 Nov 2024
 00:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
 <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
 <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com>
 <CAJuCfpEBs3R8C910eiaXcSMPPrtbMjFLNYzYdPGJG+gw4WHM8A@mail.gmail.com> <20241121045109.GA20615@lst.de>
In-Reply-To: <20241121045109.GA20615@lst.de>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 21 Nov 2024 09:43:37 +0100
Message-ID: <CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=+cbUBP2tZO-kEcyoMA@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Christoph Hellwig <hch@lst.de>
Cc: Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 5:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> Something seems to be going wrong here, though, but the trace below
> doesn't really tell me anything about the workload or file system
> used, and if this is even calling into readahead.

In case you were asking :-) these are web servers (shared webhosting),
running PHP most of the time. The host itself runs on an ext4, but I
don't think the ext4 system partition has anything to do with this.
PHP runs in containers that are erofs, the PHP sources plus
memory-mapped opcache files are in btrfs (read-only snapshot) and the
runtime data is on NFS or Ceph (there have been stalls on both server
types).
My limited experience with Linux MM suggests that this happens during
the page fault of a memory mapped file. PHP processes usually mmap
only files from erofs and btrfs.
The servers are always somewhat under memory pressure; our container
manager keeps as many containers alive as possible and only shuts them
down when the server reaches the memory limit. At any given time,
there are thousands of containers.

Max

