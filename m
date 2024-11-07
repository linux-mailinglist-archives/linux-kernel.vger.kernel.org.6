Return-Path: <linux-kernel+bounces-399492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373F9BFFC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B532836A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A421D63F1;
	Thu,  7 Nov 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DATmbwfF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97B1CC16C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967190; cv=none; b=AJaItewuEjwFzBvjvaqtmBqLlsDEdB0lRMOUu/o4L27ufo7fvU+kLOPkGCa0iFU0sgUs3LP4HKkmm+3C63f1PYMfCvbQP+CeKtaOav98fzatkEn2et+zqy9zNzIw9+MTAuGlsJrYztt+BYy8WmpDlBtz5xWyY/XLdeGFqGBUBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967190; c=relaxed/simple;
	bh=jmcE0/Im3Exsi4Vo2GDudQkmOHMoQVfMs6ELkDnlnJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgeuwJDPzLIhz5eCCJlmQOPj9IFMGnkSNUPXuzCHvAP+qIUNDbW11EnxlljGuBRIBSM/Kd674rkbSGICwYsVWEqC3LyJPATaSRt0KwBGpevFdDfkh0nb+9jkouuzt+kpHcAuw4yYDIowIfkUYVUO+rzYfDzOJlmV+mTLZ/4tQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DATmbwfF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730967187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmcE0/Im3Exsi4Vo2GDudQkmOHMoQVfMs6ELkDnlnJM=;
	b=DATmbwfF2e6LlySMELpZtGZkll0b8OQ9qyWf+C+TGgCBLRX2UnVH/rSfPpYqudYlR1RWJA
	nfrN/thmhuMU9Xuv10n8zJs2g+okYUb3I5aoDUCWKFkH+G5FzGtKjp0HmVg9q0kRKB3Tvh
	LaJX0FWXmTJIL+OCnJepF4gjVfCfKIM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-FnBrE9GTPb2jdAKcwHtnhA-1; Thu, 07 Nov 2024 03:13:04 -0500
X-MC-Unique: FnBrE9GTPb2jdAKcwHtnhA-1
X-Mimecast-MFC-AGG-ID: FnBrE9GTPb2jdAKcwHtnhA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso6295795e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 00:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730967183; x=1731571983;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmcE0/Im3Exsi4Vo2GDudQkmOHMoQVfMs6ELkDnlnJM=;
        b=pHtfWrodE5lM/n8e5464rs5RJ+JGMLIC2anVys1JUQIddVgp8qWNHNQl83Yw/vld7v
         NXzwQek20z/igzqctHRVTdrwRPERpfd9BJjg/ltbfVG5xV+ikWFHJ+NJMpRhfiZ8DMbD
         cvZD6hgR5TuUo97P50tyv19XETkL00xZzUctsZeIBtFzAU+FjGgSELFv3R1AnQBXAOkG
         kRzSyExA6pDifc/TWBv7Ni2u1duZvgzgUOo6p2wEWz5XJbkI7csnxhgwLhzFV7Hq+Opl
         a3zqyu2VSnI1xRyzMhvMhlXrlzsdwOulfVzxgzXAJNSGWS8npgJGsrHtp9nfHnvThTfy
         THqw==
X-Gm-Message-State: AOJu0YwoX2ErfpqSRYUiKy7ULGTwSJdjmYpfySKLsQgJGFy0RV2qOfuE
	/Ocfw644rZbCa3yeHMgMT4PZ+cexfrNnR0VWotO1Xye6CLyOCVQpYrPJH/k8kDoio4DjICyUFAZ
	lFiZSxElAytgkHfnP0SjXRuIGDPoRsYOKEFhDbYq4v05a9uaqodRPVfs1nrB9sw==
X-Received: by 2002:a05:600c:4683:b0:431:5ba1:a520 with SMTP id 5b1f17b1804b1-432942dd802mr176881205e9.3.1730967182982;
        Thu, 07 Nov 2024 00:13:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnTyA6N8yEcFnDtKauiq42cuS9o+PXrZ70fr1HF81Ts+ix5HQLYe878DBn81fWa9Uq4qScrg==
X-Received: by 2002:a05:600c:4683:b0:431:5ba1:a520 with SMTP id 5b1f17b1804b1-432942dd802mr176881025e9.3.1730967182667;
        Thu, 07 Nov 2024 00:13:02 -0800 (PST)
Received: from [10.32.64.113] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0566544sm14009185e9.24.2024.11.07.00.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 00:13:02 -0800 (PST)
Message-ID: <71860affadbd3efe72edbced28b3135924a28594.camel@redhat.com>
Subject: Re: linux-next: manual merge of the block tree with the pci tree
From: Philipp Stanner <pstanner@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jens Axboe <axboe@kernel.dk>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Date: Thu, 07 Nov 2024 09:13:00 +0100
In-Reply-To: <20241107162459.71e0288a@canb.auug.org.au>
References: <20241107162459.71e0288a@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-07 at 16:24 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the block tree got a conflict in:
>=20
> =C2=A0 drivers/block/mtip32xx/mtip32xx.c
>=20
> between commit:
>=20
> =C2=A0 5080394a8fcb ("block: mtip32xx: Replace deprecated PCI functions")
>=20
> from the pci tree and commit:
>=20
> =C2=A0 91ff97a72259 ("mtip32xx: Replace deprecated PCI functions")
>=20
> from the block tree.

Ooops, that should not have happened =E2=80=93 I must have lost overview ov=
er
my branches when submitting the latter.

I will improve quality ensurence.

>=20
> I fixed it up (I arbitraryly used the former version) and can carry
> the
> fix as necessary. This is now fixed as far as linux-next is
> concerned,

Thanks. I think dropping the latter is the right thing to do.

Regards,
Philipp

> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.=C2=A0 You may also
> want
> to consider cooperating with the maintainer of the conflicting tree
> to
> minimise any particularly complex conflicts.
>=20


