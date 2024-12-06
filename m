Return-Path: <linux-kernel+bounces-435759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA59E7BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900461885391
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8A212F88;
	Fri,  6 Dec 2024 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JJGj4uFb"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F21C3F36
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525307; cv=none; b=kS50IHr6nB0/lPbEUKWzop5+4r4kaZXShj5UE4soJgCyGVwQSeE19H1jpssWienYA4rqf7/UfCrxTIqpCKgGAcd/0nbEQ4rrnMPRT5c0vD9lcJujkMUAoIcDxY8G9NmMatWc4SpVj4kNmrNVnNmrLZwXxb5PP++7g2uFInTMXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525307; c=relaxed/simple;
	bh=1BWvsmk3F4Oxl/qJ24Ok5zN6PmBHW1QeWrGkfyajj0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+s9Us5dqTHiQP5aOEIowUp1pLLDoD7MprgwPGPmKyUhEePgCdAkxcPV9cd+UNhWTFDkiuZEtE/YKxY9LThCHQ9IjlepzKHfc7PMuEF8vohmFAuBzALyeYGg36qxU6NfS/QykaLhjsqOhoJMnxA4GD2Wx+AB1QfiX61+roSeUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JJGj4uFb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so3969064a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733525303; x=1734130103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BWvsmk3F4Oxl/qJ24Ok5zN6PmBHW1QeWrGkfyajj0E=;
        b=JJGj4uFbUHGgGycQgZA9MfSjeBl8wbk/EO5JIlLi1oZ1x/saeCc0lvAsZRCEWv6ObU
         XXwbWzK4hP+9Kwbk7n53vhq6/dXaeHNj0s3XqEgAZNRR8pWQGjevK3RQ87gW6OmAzLe6
         8uO01UlusmWBD1S5KJnldikqEi1A2pYDHdaFqrV6JotfBrCIxPJjidoN5aFyzE4TmOdw
         ZLELY8WEE2zcUFeyHzU+BHoEkJnCcRjwxiBiEmVZpuF3eM39LdniJQRf2C3VS9mSK3vF
         cee8gkUAnX1BunfDHWGVlzgK5f6WxclQSYMXt83eLPln4IpR/kwPESSBbTUWLzVrmoSR
         1a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525303; x=1734130103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BWvsmk3F4Oxl/qJ24Ok5zN6PmBHW1QeWrGkfyajj0E=;
        b=Q99pOBhqgUE7eaH4ixqANnObXodOwWnVCCNJJN8/WLQuQubxy9+ZSotYZBMMby0e5W
         xSAxCj6glPVvQ3Mf76BdOALnuv5Ffrjyn0s/KhBMNelT6l4IC1QCrXFiLEDtHh5WYqmy
         iq+uZj1Gr+04/zYFlWJZbLGE5NnMIMZyQ14HWX4YB+W8clMHBu/kpEpc25JajLUA9tQ7
         AzCsfHq2Qklwl1UkdcLzJkGA38yZDxBQ54in/o7/rpJiP/k3+rzNDQu5QhGQdLpoGEcn
         pmdqB4N9zlyhyzHhRk7ur9iAFZFkUYmKv2yKZ20MpIVMssDUuafJjBrL/t3cVtJu0Q05
         h8ng==
X-Forwarded-Encrypted: i=1; AJvYcCUtrk3zz9R1CTbZmsC/eWQww/ThSHZqNWbDctLokEPFCcsb401sUSzXTaIvZi2Tt9hJYYQrQmBRDfLMegM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQonZMvIl/mNZbP8Ppzhw0chvBTxsdQ5u1zkAh1NIHWZi1Lki
	4b0vO4enn8l+nugwU4iNDxC3GKUNTlh5CCQYqt2T6pIgK/8UsApm2o1a8QydTAXJh/bNHfzeE5e
	aZlgLVHqQFo4fui85onAEcrfSh8H/5wIgTE5H2r8G9uIRDbsbw7g=
X-Gm-Gg: ASbGnctkqn4/9mSWNAucPhfqPCXq7Ml8xXEgWuaZT3Cb/U8cje/pAl1M/jKJrA3WJUv
	NJ37LrkRRtVydMszMoavWky8IlZF1W22xXWro09LzVvtB7YoRxj+Ltiivf/7z
X-Google-Smtp-Source: AGHT+IFk7vAYpJ4ej4R2TYQ+KRfQ97bzd69cRG0vYtoOVc551gTh5/P+Xso9NEyVG9xovJ8bKaK2d9k4saRpRapGZhI=
X-Received: by 2002:a17:907:7701:b0:aa6:302b:21e4 with SMTP id
 a640c23a62f3a-aa63a025c44mr453223266b.16.1733525302996; Fri, 06 Dec 2024
 14:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206165014.165614-1-max.kellermann@ionos.com>
 <d3a588b67c3b1c52a759c59c19685ab8fcd59258.camel@ibm.com> <CAKPOu+-6SfZWQTazTP_0ipnd=S0ONx8vxe070wYgakB-g_igDg@mail.gmail.com>
 <cd3c88aae12ad392f815c15bab0d54c8f9092e46.camel@ibm.com>
In-Reply-To: <cd3c88aae12ad392f815c15bab0d54c8f9092e46.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 23:48:12 +0100
Message-ID: <CAKPOu+-AwRayUqOR9fEmZ88bpJkrknMbsZadknjDsBW=jcFL0g@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/io: make ceph_start_io_*() killable
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Alex Markuze <amarkuze@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:11=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
> Should be the check of
> this function's output mandatory? I am not fully sure.

But I am fully sure.
If you don't check the return value, you don't know whether the inode
was locked. If you don't know that, you can't decide whether you need
to unlock it. That being optional now (cancel locking if SIGKILL was
received) is the sole point of my patch. You MUST check the return
value. There is no other way. Don't trust my word - just read the
code.

